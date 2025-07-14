Return-Path: <linux-kernel+bounces-730460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30EB044D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD9D18862F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C625C713;
	Mon, 14 Jul 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBmvDpZ2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49989246BBE;
	Mon, 14 Jul 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508537; cv=none; b=geQp0uUDv37r/66kpzN29zVBs5+GQ4TxKTdeWxbslcT3eiT4Vg03utsm+yW8Vk4VL5C33L2DJST1qzuoSEbuIytL1kkpzELdZkBXeWm6jr8jNJU2KXNwm4O+3fECumv8MEtBcTiSC5ndT+9OL/a0WjgoQB/jP15GsQMkr+aF9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508537; c=relaxed/simple;
	bh=AtQGz9rkIFv6VA4C92j6yTOrX79tGL+3e2ekYE2zjgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tzg9+2GbHtRsI7b3MTwZ8ITBvdTxeD1dncbEsZU36gzJ0F+jTbezMHCDGLzbaa9xNN0jUiFopzm19iWQbA8WFu6dO2jfxyRMIOi/uuyRxnJ3azHjrhyaJCgGkPGMrcExxpzAOZ1VfmEFCoFdt2YebO7hMJzfiPSGQRe7YGST1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBmvDpZ2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d7b50815so29881245e9.2;
        Mon, 14 Jul 2025 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752508534; x=1753113334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2MRF6gj4+coDDTEj1rInWSJ6DwpZHRHQDrk1bbbl8M=;
        b=MBmvDpZ2FbObVGsM0cUET7ZEBir69Ha27PD3YzwBQGYZrf3B/OpqT6FqGW6dnpmHOL
         qdo9IeQau+umY4ofysB0eWWQiEFlTUFTTWSbB5no+YkAydekxoBYMNJVlOSjQojsHqof
         yAXc9JoXuql3sGOcTJS1G6l6KYYgRYy71c1MvRZgrIVohxXM7tF4PO1PXQ1vTAyGk0V1
         zzhtA3uPLzXkum9ZPRM8PRAwpjtMa+z93SYf5zKLioXuYYGJkqczIwO3iczBkmaXtNxi
         cjup0F1ECch1391xxP9J+7/ddIHlgjWp/k0iD0byF0iGkUzlrv6VeRtKWRDlPNA1cGtO
         fj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508534; x=1753113334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2MRF6gj4+coDDTEj1rInWSJ6DwpZHRHQDrk1bbbl8M=;
        b=tauhcgdKDfpBgEQmb1JGQGB+p+MGr8K9eITXRuA0yYvu0XFzMOhnsvUCO2lXwScV/3
         U5F+3+Efh7AYlBDP8ZHjI9rhZGtzI4HjZ7LBhxmBDCD5dweErSf2Xw8K7vtBtuJa8VE3
         sA1pIHZ1K4DsWlVMx3su9zfB+svInc5fODRDUwE5E6DzPUv0fURpxLjyKQ5KX9EsepqT
         Bqyz92mhDxxBPFZsK2Zv3hoCaVQIrmekVOjT2ebapXSgnp6lsBzZriYXl8SPfFShwfFl
         d1qw79QDoxT2ODU1gV6z4kRA1HgLOMbOOuv4xruUtHYxNGwjh9LqdvYGMzEV6OXg328A
         tgog==
X-Forwarded-Encrypted: i=1; AJvYcCVAVoNXU9WScZ7QTYh1h000w7v4N14XkEPZMI1heqGjiuzxeKy3urVLSsv9rNyjyXhq5ROomcMM6Fxv3X3f@vger.kernel.org, AJvYcCWSjz2MF60EOyU6L59MY6SwIqTZMvmPvH8ZWNbcLznt/OrWMVw4AigE//zcLZrdiHUoGoNo20k1cyQk/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpClZIDkRcHQ+1fY52xeOO9S5a/TSxDy0QU5dXPLpeLP5Q/l9
	DCKnreh9ZTQ/OdQI+hERf+xpLWEBgqBgwUo536XVXbHStQyr/7NVVsQa
X-Gm-Gg: ASbGncvKG3xeEVY03SJEZBpthDc9+KptiibhZQZWV1yQvnMWrBUv35O109kCgXNCLbM
	DPp+Pe4wE4WJKrSqnFGVq488iDp+Y+Emt9k6CbNrMgI9C6M0hP8KbVNwbyw3eE4KNuDyDs08kFC
	I8+L+vWVizAWvB3eg27qBfihL3WpAlTwqCLIVolOz36HtcHWxAC2tdAA/cXnlp6+Z6Zd3UdrXOd
	lYG1cVh/xIu4Mebnw5x4lWx+isVbuBPlieNE6KnkGHvO1jtSZItO2TXnslGFVG1cN1RrziCYeBG
	hAoOgnG7gVGHopIhmE+FV4p5AptmDOBJiuxCyWR3EGihCeHKLSGxKHcS22vfZqzxitaZ9tARw0L
	hslhGd9n45toJQqm/9jMg
X-Google-Smtp-Source: AGHT+IG55VkA7xaAD6VKWuP33bGEIBQ52KZ1Nx3084ejz+awO25J/pxMtjRv+GFd9FdkRR/D6Dp8Xg==
X-Received: by 2002:a5d:59c1:0:b0:3a4:f00b:69b6 with SMTP id ffacd0b85a97d-3b5f18fa926mr12105471f8f.54.1752508534395;
        Mon, 14 Jul 2025 08:55:34 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e1e3bdsm12600011f8f.81.2025.07.14.08.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:55:34 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] hwmon: w83627ehf: make the read-only arrays 'bit' static const
Date: Mon, 14 Jul 2025 16:55:05 +0100
Message-ID: <20250714155505.1234012-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only arrays 'bit' on the stack at run time,
instead make them static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwmon/w83627ehf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 7d7d70afde65..a23edd35c19f 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1448,7 +1448,8 @@ w83627ehf_do_read_temp(struct w83627ehf_data *data, u32 attr,
 		return 0;
 	case hwmon_temp_alarm:
 		if (channel < 3) {
-			int bit[] = { 4, 5, 13 };
+			static const int bit[] = { 4, 5, 13 };
+
 			*val = (data->alarms >> bit[channel]) & 1;
 			return 0;
 		}
@@ -1479,7 +1480,8 @@ w83627ehf_do_read_in(struct w83627ehf_data *data, u32 attr,
 		return 0;
 	case hwmon_in_alarm:
 		if (channel < 10) {
-			int bit[] = { 0, 1, 2, 3, 8, 21, 20, 16, 17, 19 };
+			static const int bit[] = { 0, 1, 2, 3, 8, 21, 20, 16, 17, 19 };
+
 			*val = (data->alarms >> bit[channel]) & 1;
 			return 0;
 		}
@@ -1507,7 +1509,8 @@ w83627ehf_do_read_fan(struct w83627ehf_data *data, u32 attr,
 		return 0;
 	case hwmon_fan_alarm:
 		if (channel < 5) {
-			int bit[] = { 6, 7, 11, 10, 23 };
+			static const int bit[] = { 6, 7, 11, 10, 23 };
+
 			*val = (data->alarms >> bit[channel]) & 1;
 			return 0;
 		}
-- 
2.50.0


