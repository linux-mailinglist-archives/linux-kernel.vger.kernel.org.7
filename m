Return-Path: <linux-kernel+bounces-884120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E464BC2F667
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05EC94EA91A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE22D46A2;
	Tue,  4 Nov 2025 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbQZ0ih6"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F22C11D9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762235319; cv=none; b=ksKSr8mHFXvL3CPNx74gnuG/sfu+7dVP01lgoq1gJQyr6MxDa70r6aIOt7DgDn18yqsWSjWLWFQSzW2/bNZK+VtXZ825YCPo+9pZVLfZGOPQr58ZXRZsJQsI8AXxOQVisW61Vuo+RLy8gG3Yfaqf7GsJgmMoDthZThnvb55oTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762235319; c=relaxed/simple;
	bh=SoQk+AByx0B9wRad9q+1vgZW/a+k5+ol7C2iIungM2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUnkBbr0mOZ8wrHGkEZXeZ9S6MfnSMoydjIaUom8mgmzQfyhksjz0q/hhfYAlXWfavWnMPdOW+k5iJihCdIQ5ouKDrEweOlpOicHYZfx9RWTyYrddDJCELRRFvY0wDh4VrA/BeNhoe3/IXqux+3WTj/Wiq9Qy19+p1/dOwrt3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbQZ0ih6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso2604762a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762235317; x=1762840117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwmlHepJDXaxQ4eDoxYf0LfaCV1WGfYtTqn36dvPOd8=;
        b=XbQZ0ih6hPQwK9etNAfBpEFT7PtpeuXzqAbLcI/KzveUwBK5ftNmpX8w2oAEVeYPql
         HfHTRaWmAB8fN+mgtll/YZui7Sgosv3l0Hf37x6RjOhVJm4CfFB0tAEdVKqiihKrUaxh
         36dbsWmJefTh/fXizivLKuX9vTKhhOGrKiimy27cGD33pypPaR2CkbDd1x63l8VyhAq/
         SmE6r6SmhL6KRDgbiW1URL5hVm3Pz6xaDVlSVraUqPBe3nA1SlkYvb35ZErD+THAZHyW
         PYr3f49KKJPp1PNLeF7FgFj++Ipln0KglLc5jjA1P5jw4ThFbWpnp9CBdOO+pzp4G28G
         U3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762235317; x=1762840117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwmlHepJDXaxQ4eDoxYf0LfaCV1WGfYtTqn36dvPOd8=;
        b=m3Jc8KpHIY3/2R1DKmvQx50FvebExhWb6ykUT0NUV5VKa/qmoABT0L/vUnoY9W4/lE
         8JJoG/7LJ67AF7O1k8beOOTdFMZel45yqQgicvw5zhXQywBj6xj3rmQAsVQJGAxztP+K
         b4YniVcQ+brAQ7GDKw7HUMLMrhxixlFtGIl114ZRm9kTUTG+CwDEfxBzqbJ0QIT9flnB
         m1noINF7tu0BzvLNJjob/RoUkdq6aHLmQjUuJlaemXzNs0jmZUmJpdfYPAVSKB2QBPRA
         EITRzTKgItfAXaNQymvTwB6EtufEhsr5JA5bnEzhrvQAZW0yRFGXjGzMobeJ3x5xk99S
         HR0g==
X-Forwarded-Encrypted: i=1; AJvYcCUMGYmtmkvnetnPl+I+C1JU12Byi1lswSlS/ZZNUUFdAt05z59E4uipl9BKY+uDNVIkaAViBm6qGyj7JFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9dGRINW/KTPJJcRNK7uDSS7RNIT6h1z7D1uz5+7hzYaac7yp
	YAmVcWugmsNsHbYB8N46WDZBoYagKI6HjbOuqwbBf5knqBHht0dMNWSc
X-Gm-Gg: ASbGncsW/x1P6zfkjijvGZ3dtz1ojhHKjJ0alpyzN1HEjGwg0xS48Aq2apki+gyzBmo
	isrNkPwvLxY2stjzgOkKnTVzzsSBu9Xek4KlYLw4eKxT3mppHgE6P7uKSiAt4j5Iqex4XBgNpeg
	mK9vGo/8plqPhy439Em0bzTWmJrEalZ7ujE30mW0N9M5rhdZ1k6UDtm1fuVMoMcqWh/XlqGgoFx
	rJglnlnBUf7f2Yf6+QvdWu5fZwUkP8CgRoBsaD3bPxhCofhmQfTO1MfvXokO45svCHFDDGpkkLh
	Nho4p45zkCLSn1hZooobawptLpBpeDPa8oWQ7ugB5ICTdvPWYUGTPIiWLK8GHe2KQT0ESWAQklm
	3/jkxH53Zfu5V8FVPRyPTGOluyr3+kdrU0Uy6ubwBCqEEPt+lzOjKJrPEOjwObD0jgZhXJB13wp
	HK
X-Google-Smtp-Source: AGHT+IEO/1QaqQevZmDtRbW5FSbU38Ge7FvQkdRw0BAEdkYOrDNaBqA5V2pQW8KxDTNIzn/JWdb5cw==
X-Received: by 2002:a17:902:ce8b:b0:295:5da6:5ff7 with SMTP id d9443c01a7336-295f946fc18mr26276325ad.15.1762235317385;
        Mon, 03 Nov 2025 21:48:37 -0800 (PST)
Received: from gmail.com ([49.37.169.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a80esm11858525ad.73.2025.11.03.21.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 21:48:36 -0800 (PST)
From: hariconscious@gmail.com
To: shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] ASoC: tas2781: Replace deprecated strcpy() with strscpy()
Date: Tue,  4 Nov 2025 11:12:58 +0530
Message-ID: <20251104054257.9953-2-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

strcpy() is deprecated,use strscpy() instead.
No functional changes intended.
Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---
This patch replaces strcpy() call with the strscpy() API.
strscpy() is preferred over strcpy()/strncpy() as per the
kernel documentation.
If padding is fine, will use strscpy_pad() API.
Please let me know, will modify patch accordingly.

Thank you.

 sound/soc/codecs/tas2781-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index ba880b5de7e8..0f314523703f 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -1999,7 +1999,8 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 		dev_err(tas_priv->dev, "%s Can't get reset GPIO\n",
 			__func__);
 
-	strcpy(tas_priv->dev_name, tasdevice_id[tas_priv->chip_id].name);
+	strscpy(tas_priv->dev_name, tasdevice_id[tas_priv->chip_id].name,
+		sizeof(tas_priv->dev_name));
 }
 
 static int tasdevice_i2c_probe(struct i2c_client *i2c)

base-commit: d127176862a93c4b3216bda533d2bee170af5e71
-- 
2.43.0


