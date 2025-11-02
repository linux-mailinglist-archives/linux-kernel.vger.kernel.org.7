Return-Path: <linux-kernel+bounces-881705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A577C28CA6
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2D084E1D57
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AEC239E88;
	Sun,  2 Nov 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="TgGl2Y+X"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24913635E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076628; cv=none; b=rweDd5bjNJY5/OXUvU8bmxwQQHPM8JpsJBOWnrpjbpvsnu+zJ1fd7KZrVe4OgkAaNi8gPWyweb1QIktTXPUG69x5+wVcerQcL0vuAY3ZZET8bVrqmGUtnObbQUk2iQXwniVDxa+MSxqUX7aNDo3jl8yKQKd1k2yNDsfOCuXEAxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076628; c=relaxed/simple;
	bh=uKq8BRZL1bcOVPXxA803oJ6yh3VoZLWokRQjiujEvJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Srox7bELOaAus23FdtDQ+WeadkOf1ODDrTm7CdGe2egDBloTFu9Zg2FNyVOzTt7BCAHOg60aDANdvJE4ERFlqvC58DaU8EOZSgEvdKrRg5iHGmMUUNGGz6F6LtX5xjlHNll88jsJCtt9iMRzAL7K53rhLL5IGNcSCsDCQ+dN9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=TgGl2Y+X; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 34F30104C1E6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:13:30 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 34F30104C1E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1762076610; bh=uKq8BRZL1bcOVPXxA803oJ6yh3VoZLWokRQjiujEvJQ=;
	h=Date:From:To:Cc:Subject:From;
	b=TgGl2Y+X2LmW76tTSvUewdL3D744S+S/G31yGxT7ZUZMZvGwEuIY0MMlR8C6EFB86
	 jpcXqLA8qvlo4HNy8MgQvdz3AiaF1Ru/ycjT9zbRxGBWF5S+EVcwQhSjYAWvXPeiXt
	 FyyMw4yg1IkkGfqOzTfQAxHww7KAnMGyZmqIxSKg=
Received: (qmail 2979 invoked by uid 510); 2 Nov 2025 15:13:30 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.55476 secs; 02 Nov 2025 15:13:30 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 2 Nov 2025 15:13:26 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 11A3A360079;
	Sun,  2 Nov 2025 15:13:26 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id E00C21E814DC;
	Sun,  2 Nov 2025 15:13:25 +0530 (IST)
Date: Sun, 2 Nov 2025 15:13:20 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: linux@roeck-us.net, jcdra1@gmail.com, kiriyatsenko@gmail.com,
	afd@ti.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] hwmon: (aht10) Add support for dht20
Message-ID: <2025112-94320-906858@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add support for dht20 temperature and humidity sensor from Aosong.
Modify aht10 driver to handle different init command for dht20 sensor by
adding init_cmd entry in the driver data. dht20 sensor is compatible with
aht10 hwmon driver with this change.

Tested on TI am62x SK board with dht20 sensor connected at i2c-2 port.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 Documentation/hwmon/aht10.rst | 10 +++++++++-
 drivers/hwmon/Kconfig         |  6 +++---
 drivers/hwmon/aht10.c         | 19 ++++++++++++++++---
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/aht10.rst b/Documentation/hwmon/aht10.rst
index 213644b4ecba..7903b6434326 100644
--- a/Documentation/hwmon/aht10.rst
+++ b/Documentation/hwmon/aht10.rst
@@ -20,6 +20,14 @@ Supported chips:
 
       English: http://www.aosong.com/userfiles/files/media/Data%20Sheet%20AHT20.pdf
 
+  * Aosong DHT20
+
+    Prefix: 'dht20'
+
+    Addresses scanned: None
+
+    Datasheet: https://www.digikey.co.nz/en/htmldatasheets/production/9184855/0/0/1/101020932
+
 Author: Johannes Cornelis Draaijer <jcdra1@gmail.com>
 
 
@@ -33,7 +41,7 @@ The address of this i2c device may only be 0x38
 Special Features
 ----------------
 
-AHT20 has additional CRC8 support which is sent as the last byte of the sensor
+AHT20, DHT20 has additional CRC8 support which is sent as the last byte of the sensor
 values.
 
 Usage Notes
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2760feb9f83b..2a71b6e834b0 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -245,12 +245,12 @@ config SENSORS_ADT7475
 	  will be called adt7475.
 
 config SENSORS_AHT10
-	tristate "Aosong AHT10, AHT20"
+	tristate "Aosong AHT10, AHT20, DHT20"
 	depends on I2C
 	select CRC8
 	help
-	  If you say yes here, you get support for the Aosong AHT10 and AHT20
-	  temperature and humidity sensors
+	  If you say yes here, you get support for the Aosong AHT10, AHT20 and
+	  DHT20 temperature and humidity sensors
 
 	  This driver can also be built as a module. If so, the module
 	  will be called aht10.
diff --git a/drivers/hwmon/aht10.c b/drivers/hwmon/aht10.c
index d1c55e2eb479..a153282eef6a 100644
--- a/drivers/hwmon/aht10.c
+++ b/drivers/hwmon/aht10.c
@@ -37,6 +37,8 @@
 #define AHT10_CMD_MEAS	0b10101100
 #define AHT10_CMD_RST	0b10111010
 
+#define DHT20_CMD_INIT	0x71
+
 /*
  * Flags in the answer byte/command
  */
@@ -48,11 +50,12 @@
 
 #define AHT10_MAX_POLL_INTERVAL_LEN	30
 
-enum aht10_variant { aht10, aht20 };
+enum aht10_variant { aht10, aht20, dht20};
 
 static const struct i2c_device_id aht10_id[] = {
 	{ "aht10", aht10 },
 	{ "aht20", aht20 },
+	{ "dht20", dht20 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, aht10_id);
@@ -77,6 +80,7 @@ MODULE_DEVICE_TABLE(i2c, aht10_id);
  *              AHT10/AHT20
  *   @crc8: crc8 support flag
  *   @meas_size: measurements data size
+ *   @init_cmd: Initialization command
  */
 
 struct aht10_data {
@@ -92,6 +96,7 @@ struct aht10_data {
 	int humidity;
 	bool crc8;
 	unsigned int meas_size;
+	u8 init_cmd;
 };
 
 /*
@@ -101,13 +106,13 @@ struct aht10_data {
  */
 static int aht10_init(struct aht10_data *data)
 {
-	const u8 cmd_init[] = {AHT10_CMD_INIT, AHT10_CAL_ENABLED | AHT10_MODE_CYC,
+	const u8 cmd_init[] = {data->init_cmd, AHT10_CAL_ENABLED | AHT10_MODE_CYC,
 			       0x00};
 	int res;
 	u8 status;
 	struct i2c_client *client = data->client;
 
-	res = i2c_master_send(client, cmd_init, 3);
+	res = i2c_master_send(client, cmd_init, sizeof(cmd_init));
 	if (res < 0)
 		return res;
 
@@ -352,9 +357,17 @@ static int aht10_probe(struct i2c_client *client)
 		data->meas_size = AHT20_MEAS_SIZE;
 		data->crc8 = true;
 		crc8_populate_msb(crc8_table, AHT20_CRC8_POLY);
+		data->init_cmd = AHT10_CMD_INIT;
+		break;
+	case dht20:
+		data->meas_size = AHT20_MEAS_SIZE;
+		data->crc8 = true;
+		crc8_populate_msb(crc8_table, AHT20_CRC8_POLY);
+		data->init_cmd = DHT20_CMD_INIT;
 		break;
 	default:
 		data->meas_size = AHT10_MEAS_SIZE;
+		data->init_cmd = AHT10_CMD_INIT;
 		break;
 	}
 
-- 
2.34.1


