package com.example.testing // your package name

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import java.io.File
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeScreenWidgetProvider : HomeWidgetProvider() {
     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                val title = widgetData.getString("title", null)

                var subTitle = widgetData.getString("timeline", null)

               

                setTextViewText(R.id.title, title)
                setTextViewText(R.id.timeline, subTitle)
                val imagePath = widgetData.getString("lineChart", null)
               val imageFile = File(imagePath)
               val imageExists = imageFile.exists()
               if (imageExists) {
                  val myBitmap: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
                  setImageViewBitmap(R.id.event_image, myBitmap)
               } else {
                  println("image not found!, looked @: $imagePath")
               }

                // Pending intent to update counter on button click
                // val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
                //         Uri.parse("myAppWidget://updatecounter"))
                // setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}