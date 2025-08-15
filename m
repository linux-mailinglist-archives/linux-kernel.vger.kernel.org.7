Return-Path: <linux-kernel+bounces-771225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C80B28459
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15564AA56ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF6632145D;
	Fri, 15 Aug 2025 16:47:34 +0000 (UTC)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403C257838
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276454; cv=none; b=Gb/bsWspqW40UJumiZZBiYUB/u6msLvNMWEJbb15ebveX91z3khbX8QvGkxNE3xyQ+o++37pVQ4KSHarQNXcDwchMpprQuPKi77R+HD5gYrffive51Y1sinxBMMceSEXy/UjB2AODJnpFOY+WRCosPmoPPq0BGDS/GpAmbvrraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276454; c=relaxed/simple;
	bh=yQA+mFiFAYBW3Bcde4BtGhek+5Dht/Bvq62Oc8hxX9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIjHteO9IkO4OX+evUKJ+y4LqFYRP3davUGLyxshpXqCpbTdmHtYCEcw+GHFAoKKtWsxGEt7MISdKVgJ/P6HvM7ygVAV3rYb4LW75p/3EpwNMdL10Nx6//2W2r9iBK5g7VK6ZzQTHR4isRsEEQA6oF8mQ9O3RjyovzzXUPykOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
Date: Fri, 15 Aug 2025 16:46:06 +0000
Message-ID: <20250815164627.22002-5-bcollins@watter.com>
In-Reply-To: <20250815164627.22002-1-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

dt-bindings documentation for this driver claims to support
thermocouple-type, but the driver does not actually make use of
the property.

Implement usage of the property to configure the chip for the
selected thermocouple-type.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 drivers/iio/temperature/mcp9600.c | 69 +++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index c18ae17b6d82f..361572a241f06 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -22,11 +22,15 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
+#include <dt-bindings/iio/temperature/thermocouple.h>
+
 /* MCP9600 registers */
 #define MCP9600_HOT_JUNCTION		0x00
 #define MCP9600_COLD_JUNCTION		0x02
 #define MCP9600_STATUS			0x04
 #define MCP9600_STATUS_ALERT(x)		BIT(x)
+#define MCP9600_SENSOR_CFG		0x05
+#define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
 #define MCP9600_ALERT_CFG1		0x08
 #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
 #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
@@ -66,6 +70,30 @@ static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] = {
 	[MCP9600_ALERT4] = "alert4",
 };
 
+/* Map between dt-bindings enum and the chip's type value */
+static const unsigned int mcp9600_type_map[] = {
+	[THERMOCOUPLE_TYPE_K] = 0,
+	[THERMOCOUPLE_TYPE_J] = 1,
+	[THERMOCOUPLE_TYPE_T] = 2,
+	[THERMOCOUPLE_TYPE_N] = 3,
+	[THERMOCOUPLE_TYPE_S] = 4,
+	[THERMOCOUPLE_TYPE_E] = 5,
+	[THERMOCOUPLE_TYPE_B] = 6,
+	[THERMOCOUPLE_TYPE_R] = 7,
+};
+
+/* Map thermocouple type to a char for for iio info in sysfs */
+static const int mcp9600_tc_types[] = {
+	[THERMOCOUPLE_TYPE_K] = 'K',
+	[THERMOCOUPLE_TYPE_J] = 'J',
+	[THERMOCOUPLE_TYPE_T] = 'T',
+	[THERMOCOUPLE_TYPE_N] = 'N',
+	[THERMOCOUPLE_TYPE_S] = 'S',
+	[THERMOCOUPLE_TYPE_E] = 'E',
+	[THERMOCOUPLE_TYPE_B] = 'B',
+	[THERMOCOUPLE_TYPE_R] = 'R',
+};
+
 static const struct iio_event_spec mcp9600_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -89,6 +117,7 @@ static const struct iio_event_spec mcp9600_events[] = {
 			.type = IIO_TEMP,				       \
 			.address = MCP9600_HOT_JUNCTION,		       \
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
+					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
 					      BIT(IIO_CHAN_INFO_SCALE),	       \
 			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
 			.num_event_specs = hj_num_ev,			       \
@@ -131,6 +160,7 @@ struct mcp_chip_info {
 
 struct mcp9600_data {
 	struct i2c_client *client;
+	u32 thermocouple_type;
 };
 
 static int mcp9600_read(struct mcp9600_data *data,
@@ -165,11 +195,32 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 		*val = 62;
 		*val2 = 500000;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		*val = mcp9600_tc_types[data->thermocouple_type];
+		return IIO_VAL_CHAR;
 	default:
 		return -EINVAL;
 	}
 }
 
+static int mcp9600_config(struct mcp9600_data *data)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+	u8 cfg;
+
+	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
+			  mcp9600_type_map[data->thermocouple_type]);
+
+	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to set sensor configuration\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
 {
 	if (channel2 == IIO_MOD_TEMP_AMBIENT) {
@@ -453,6 +504,24 @@ static int mcp9600_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->client = client;
 
+	/* Accept type from dt with default of Type-K. */
+	data->thermocouple_type = THERMOCOUPLE_TYPE_K;
+	ret = device_property_read_u32(&client->dev, "thermocouple-type",
+				       &data->thermocouple_type);
+	if (ret < 0 && ret != -EINVAL)
+		return dev_err_probe(&client->dev, ret,
+				     "Error reading thermocouple-type property\n");
+
+	if (data->thermocouple_type >= ARRAY_SIZE(mcp9600_type_map))
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Invalid thermocouple-type property %u.\n",
+				     data->thermocouple_type);
+
+	/* Set initial config. */
+	ret = mcp9600_config(data);
+	if (ret < 0)
+		return ret;
+
 	ch_sel = mcp9600_probe_alerts(indio_dev);
 	if (ch_sel < 0)
 		return ch_sel;
-- 
2.50.1


