Return-Path: <linux-kernel+bounces-891538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAEC42E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4BF188F666
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E7204C36;
	Sat,  8 Nov 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nathanrossi.com header.i=@nathanrossi.com header.b="S+WZFxIp"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47F29CEB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611194; cv=none; b=dkqXyubOGJmYFnvgNsXgFZoOA6MPSGlEdUu/Gy+ikeP//vB53mIBeOs7ZR07j1EjvAFG/goDPeuQs1XR6qf1jy9/z7tJjNreNMpujfVRty74DOoy6HYpeyXwaAaklVwd9OgBQg8pNFcvx/Phg0bGQ8L7QSSASUSuwqkE0wqdQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611194; c=relaxed/simple;
	bh=wZNNbZV1e8ssMYWThHII56kh9E/cv0pc38q5OAO3aOw=;
	h=Date:Message-Id:From:To:Cc:Subject:Content-Type:MIME-Version; b=MG4qlFY/bV114JtGL9chKbgYK9VsMS1aiepp1xMtuSrKJRYPeAV6RhcJMDK/az1eqUq2iSrpIHj7rs9MRaqGwcuGmhk9GSw0WecbiUsxP8TageLK0KNak+lvFmIKMEIBS1m44w20OS1ZE54GDDEEHdnaKt1c+y4e+xVcMj8eQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nathanrossi.com; spf=pass smtp.mailfrom=nathanrossi.com; dkim=pass (2048-bit key) header.d=nathanrossi.com header.i=@nathanrossi.com header.b=S+WZFxIp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nathanrossi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nathanrossi.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-794e300e20dso1100626b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 06:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google; t=1762611192; x=1763215992; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiXbpzd3bIjWXSPGISfM4gyeG5qjOlx+rSwjrBCzc6o=;
        b=S+WZFxIpxHZdk4Fzuycim0xx5YyTUVmgrANev2BFEsqUM8IbiNhzaPbsdAsO2n299s
         kAfC9NnhwGY4rP27AUS/xpH3RYeFVcdvj0t/zz6h4mfjK44H9T3NtWnXurtjzabnCLPz
         kMX514tP7MBWAHCHfvjOCesUcTS+Z6MEUL1iQRD1c4Eu1q6xHzaYjUMBJWqsFEAQ/Vsf
         1u6o3RITYsYd9fy2/YzlhEFwntVTZZPuadW5pS//D2qbvQv1P8mjlz1GDgQJi0FpWzuy
         AajhAgLSVgP9Am/eiATL8Cclpc5CpoVdj05P+82CIIYmgf+5+XMF2zlOzDktgucfyLUB
         AiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762611192; x=1763215992;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiXbpzd3bIjWXSPGISfM4gyeG5qjOlx+rSwjrBCzc6o=;
        b=ml2eKryarJsMZ6v0YW3ucITl5TZotE9rPqkyIsNjzT5L/0mK3Xm44zNuZbGFtGxyy2
         Os7te4PVZ1/vRSZTIxeDQESMcyLDnScDg2N7616dpZNQO9PlOrWKOFmtR3/xeUkONbYl
         PH/mr8EMLJjPraGfBuJsFIaoaafMi80wsZldjDSWvTHsbMr+p0enqmi1KZFtceX8lYXr
         gYA+Y9bDEs9WEUoDEcCDg+Wt/vDI1HLgNPiQwCjLYLHmqEmws4zQTUbytWeKW63bnAoA
         /E+L1eCckssly8Ai4eyZgs1YI+nFW4pd1dJFHVTde8fwLH/+JSbX3kCdIF02ucFZI+mE
         d6hg==
X-Forwarded-Encrypted: i=1; AJvYcCXri2HGRT3OIKgNFT8MhPrOG1Nb884VoDmJbVLHDCLS0aNrhV6xocsElQdWx7ERE218Z6DkqHiXip4arbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRiYlzHnnNnGedqZVAuUbUiOZ3XuqeDMcqhSYyFWSRydnvqL5t
	OYn3cHI0WfzstE7Coal2AjXLt9+3JvViPyQKqbjcAMU3fcdvqIxLcoLU23z5gJVABw==
X-Gm-Gg: ASbGncszrEqRp9+SK1mRKRGXhoVa+W0hGUMnYsFZVOzgW7gaj3e079Z2Gh0cZ/gTjvQ
	uYD6vO12ogHONsZLgPKdtfQiOcDeu5hpjxlBcRLGOh4Q6l3f/rJWPN/66BCAuxvX3jIhDgUgOds
	sHIUrJ7jTeNlWboJwgA/qAQBPWkC3PSu24lU3teNwqx6KI/ETtDF/KCNuwtdK7/JDgl5VZx7V2X
	79NA1s4txhtnVoM8DZVpajdsKGTW9PU9RbxjUYWeLIPiLSCHtvtwNIcPuNxkNxGTHPFFxsYXRku
	HZYwWG95lr6an5Mp8hAwkxVADFXu0DeuRyh1m6T5gRnq0gC9eBjPeki14ypVpWvA9cXzsxg8KPy
	29dqlciv6F0CY2jc32TLROqMGUNj9QMFa5JESbtQzlbaTYNgxto2IQEut6xtOGyfNQuM6mlOi2q
	w1p4iT4lmHQI1waLJQM9KKk9s9sZMr1b6SmFFtEQBi5bpLO3WqtQ==
X-Google-Smtp-Source: AGHT+IFYoVKN7RXzMH2xZdzQ2rIpGtAnIJTVwkAnY47V2DgRk614nU5oM9Y7Z1tcV+omkfnlHtPGcg==
X-Received: by 2002:a17:902:f707:b0:295:6850:a38d with SMTP id d9443c01a7336-297c95b383emr61436335ad.19.1762611191644;
        Sat, 08 Nov 2025 06:13:11 -0800 (PST)
Received: from [127.0.1.1] (117-20-68-151.751444.bne.nbn.aussiebb.net. [117.20.68.151])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29651cc1907sm90616035ad.99.2025.11.08.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 06:13:11 -0800 (PST)
Date: Sat, 08 Nov 2025 14:13:00 +0000
Message-Id: <20251108141300.3402380-1-nathan@nathanrossi.com>
From: Nathan Rossi <nathan@nathanrossi.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Nathan Rossi <nathan@nathanrossi.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Filipe =?utf-8?q?La=C3=ADns?= <lains@riseup.net>
Subject:
 [PATCH] HID: logitech-dj: Add support for G Pro X Superlight 2 receiver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The Logitech G Pro X Superlight 2 has a lightspeed receiver with a
product id of 0xc54d, this receiver behaves like the receiver used in
the original Logitech G Pro X Superlight (id 0xc547) including the 13
byte mouse reports.

This change adds a definition for this receiver id, and a mapping for
the recvr_type_gaming_hidpp_ls_1_3 type. With this change in place the
receiver now reports the battery status of the connected mouse over
wireless as well as exposing the HID interface needed for userspace to
perform additional configuration with libratbag/Piper.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
 drivers/hid/hid-ids.h         | 1 +
 drivers/hid/hid-logitech-dj.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index aa3ceef3016e..e06f5088202b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -917,6 +917,7 @@
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_1	0xc53f
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_2	0xc543
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3	0xc547
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4	0xc54d
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_POWERPLAY	0xc53a
 #define USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER	0xc548
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index d66f4807311a..d39a4c1073ad 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -2091,6 +2091,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3),
 	 .driver_data = recvr_type_gaming_hidpp_ls_1_3},
+	{ /* Logitech lightspeed receiver (0xc54d) */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
+	 .driver_data = recvr_type_gaming_hidpp_ls_1_3},
 
 	{ /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
---
2.51.0

