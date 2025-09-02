Return-Path: <linux-kernel+bounces-797455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9490B410A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AEB1B6410A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA5627F19B;
	Tue,  2 Sep 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYzGgkf2"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E426C385
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855131; cv=none; b=cxOahNnyHLQtUnvMPVvGEPr2Z+SKe07f035SEiY5lCY7UYSM/gZuSbGDVSHZ+9ndty3q6fnxa+vgdo3LHcLGa5FospaSn8Oi7tcW2zqW7OEUjXTCuAQAA8/QbSx4WAtBMt7CFicsqW8SrM8ViN15IbYFpnhdC19XndAq/mKT+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855131; c=relaxed/simple;
	bh=RC2SuukZpECOwJKN24XJO9QYhLSxuw1j+vclL1sH4M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=USfcw0UGflz7Pt3N113E6eMR4LfjCQEGZoxFoQDJSA/czsZ8lZ+SdCJfce9Jmeoi3ZTuzvR/ne0ia9uhJgGdfVKk2Z2cBmZ0/UcRYMUWFTGER8lmLve+TGiI5OZPY82BKHzzJUPI52xm0JVkDQhzBAnSaLDj1tX7gj+IdexxAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYzGgkf2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f72452a8eso3980248e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756855127; x=1757459927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIjMpHwYzE4g/6WKCNgfagxf+5dKQ2N0eUW6mQ6xm8U=;
        b=lYzGgkf2xw0jcAfk9112fOpLnOGwNNh68CsPurmpcxgJVr/7JSbokMOlZm2esC0jzs
         Oz5CwnZloataw/WpM/neXjNw2vu3Fjuwd5DLh8CQiBdT7RFrqyRcTZT8yqWFNdKooxHz
         bEF66PxBK3LkpxNFNMAzQayYMWZ0XvQfhv2q9cdnbvo1u17TjjWHJwVeY8IjJPIZJ+vB
         jVwEpLEdlDByfat6pc1rFLXv6hgZH2EMwNACkZzcnPMKXnl4cECQE9/IVESb7txGKyCu
         Evn4nsCzGQky+igVJ5H421sZBv8QbclQmvYeAQNEYYMG3Z/dUgjEMIrUm/faKGKedIF5
         iWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756855127; x=1757459927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIjMpHwYzE4g/6WKCNgfagxf+5dKQ2N0eUW6mQ6xm8U=;
        b=hSwmZfH6ivWDZxO628KOby68pJM8PvlvXJFzvpKUh8qt1YBjquuclxBTGbJPqS6ew1
         AVtXgCyCKa9UflV7tJEnozqApe/vfCW3cchTIKH0eC3nYHwCAKi9ztYWAHR5ctO9XZiB
         v5L+Ifso4RfIYgVmiSoXuSc9bAjQ1z/+tyXlNENIBjHPtKDLxqLg4HRQUC7WgYHrkbdC
         RNzdD+ex26VJpjqfRtFbeZTiuNzrTKOtdkOhkRKJXTmsTtjDRankunvbX8qViQXm9tv/
         jIOSKfVULEEFDqDtULV/fLaz0vQQq//2dMRhdqwPada+PQE+xw2xRZkRsF+sAjA3fD4I
         ceBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlN3KY4MeGZmd1xPnYaWMsn4f9PMjO1noMsDQU9TdXzgQV258kp7a14Mzy03O5BlUUvQ5SoGa3V3uqU+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTHwLtBBY1lji5QcJUfNU/2JQLsy4Tz7aqrzWH3ojehlhZ0JI
	xDzoK7Mr4mxN8rH0VBqyKV8YcKHMLGHQ/F28PF76jI/tBz9oHJ8RjtqL
X-Gm-Gg: ASbGncuRxk2A7+Jvcvz6VR5/u5K7pj2O9dxf+ma9IRS2CxXPfjFtuQUkdBuuPE9gOuw
	+Wkdf9YCAlPZDb5l/v1za/o4WEUdNN28CZ80JdJqT4+dTNRdRaiFdgARMLge5q840k1AF8+Ocys
	EMKb/655maId9b8PAa8f7VPIGHhN0OzlifGkikmh0JgkxsKSoevMHFldJ7+m5vSqzbcgykZR+JC
	8UHItcK5H9uVnXnzwlQBX/rGg1+87BB6oIgxRPOLaqVh7WkBrwB3g92eXf7MO7nCrCiFDBx0fQ+
	GadR1FyEQsVkJtcxcu8CcmI+X+B50Kfms+G/bG74uA7lAq5EGsmTRoNctXtd+r9dRqDNqnn88WJ
	n5hA7Ryc2MlF3KnkBUuIWSKXG/GfLbSY8
X-Google-Smtp-Source: AGHT+IHBkhypX8PliyvBm2EDGnps/SdjWMK/oXTi9pJ/ZhI9sUg+t+MQviVvBQtxBckq0XKyo0yLkA==
X-Received: by 2002:a05:651c:238:b0:333:bf9e:d6e1 with SMTP id 38308e7fff4ca-336cb0b0958mr34920641fa.32.1756855127305;
        Tue, 02 Sep 2025 16:18:47 -0700 (PDT)
Received: from vovchkir.localdomain ([95.161.221.106])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5608ab5e281sm105674e87.18.2025.09.02.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:18:46 -0700 (PDT)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: vovchkir@gmail.com
Subject: [PATCH] drm/bridge: lontium-lt9611uxc: use irq as optional parameter
Date: Wed,  3 Sep 2025 02:18:20 +0300
Message-Id: <20250902231821.2943-3-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902231821.2943-1-vovchkir@gmail.com>
References: <20250902231821.2943-1-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some systems the interrupt pin may not be used.
In this case we exclude DRM_BRIDGE_OP_HPD from supported operations,
after which a polling thread is started to detect the connection.
(the default polling period for DRM is 10 seconds)

Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 25 ++++++++++++++--------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 1aeb5b29704b..b17483f1550c 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -854,12 +854,17 @@ static int lt9611uxc_probe(struct i2c_client *client)
 	init_waitqueue_head(&lt9611uxc->wq);
 	INIT_WORK(&lt9611uxc->work, lt9611uxc_hpd_work);
 
-	ret = request_threaded_irq(client->irq, NULL,
-				   lt9611uxc_irq_thread_handler,
-				   IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
-	if (ret) {
-		dev_err(dev, "failed to request irq\n");
-		goto err_disable_regulators;
+	if (client->irq) {
+		ret = request_threaded_irq(client->irq, NULL,
+					   lt9611uxc_irq_thread_handler,
+					   IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
+		if (ret) {
+			dev_err(dev, "failed to request irq\n");
+			goto err_disable_regulators;
+		}
+		dev_dbg(dev, "Uses IRQ\n");
+	} else {
+		dev_warn(dev, "Irq isn't present. Check Irq or use the polling!!\n");
 	}
 
 	i2c_set_clientdata(client, lt9611uxc);
@@ -867,7 +872,7 @@ static int lt9611uxc_probe(struct i2c_client *client)
 	lt9611uxc->bridge.funcs = &lt9611uxc_bridge_funcs;
 	lt9611uxc->bridge.of_node = client->dev.of_node;
 	lt9611uxc->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
-	if (lt9611uxc->hpd_supported)
+	if (lt9611uxc->hpd_supported && client->irq)
 		lt9611uxc->bridge.ops |= DRM_BRIDGE_OP_HPD;
 	lt9611uxc->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 
@@ -896,7 +901,8 @@ static int lt9611uxc_probe(struct i2c_client *client)
 	return 0;
 
 err_remove_bridge:
-	free_irq(client->irq, lt9611uxc);
+	if (client->irq)
+		free_irq(client->irq, lt9611uxc);
 	cancel_work_sync(&lt9611uxc->work);
 	drm_bridge_remove(&lt9611uxc->bridge);
 
@@ -914,7 +920,8 @@ static void lt9611uxc_remove(struct i2c_client *client)
 {
 	struct lt9611uxc *lt9611uxc = i2c_get_clientdata(client);
 
-	free_irq(client->irq, lt9611uxc);
+	if (client->irq)
+		free_irq(client->irq, lt9611uxc);
 	cancel_work_sync(&lt9611uxc->work);
 	lt9611uxc_audio_exit(lt9611uxc);
 	drm_bridge_remove(&lt9611uxc->bridge);
-- 
2.34.1


