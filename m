Return-Path: <linux-kernel+bounces-758934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C2B1D5D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E93A16698C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320E230D08;
	Thu,  7 Aug 2025 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7nUKLYP"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3842AA5;
	Thu,  7 Aug 2025 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562759; cv=none; b=O7rqBCNe41BN88XlunB/Ta8oi/79mqd676RphHaDuXpXQpOHlNXQ/eDrHmpRBpgBmD2l4XJFJNjP9x9K8xL12KmgWwj476cS4JZWzc/zQUBrxFvlKoxHt8bl4WngPaxtYK0cYzqG1Y5us46gpJspUvW22XYfRoXiRkxZHzKJJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562759; c=relaxed/simple;
	bh=8T4ciwZYIdTlobh2yTQlV72mffUjAvybA1slfR+u/AA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J0LgMjc5eszerQuOKA/+G/egp3tuzlBAkQWOYxy6e43YI5SUnviitYRHJpWCgV8Zx+GFuBY4Sga5WJJReBm1oNGjLbZqZPkKYU1qM8hh8JOrXSvPb+JGohtGLjnDTgfyEnBD9BjMWngpTzHHWrAKknmaCaYfNEydoSZLnwp2Exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7nUKLYP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71bce78e14fso8622057b3.1;
        Thu, 07 Aug 2025 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754562757; x=1755167557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0B8JKmuj7NoKhGZ2Qof2Rmk4iilq75YN49pVYUQ/rPY=;
        b=A7nUKLYP9wLYtUZ2dYHLflefPO2ZxtDwK998xdqNM1ckqPbqDs4vaFOqDzQTWe/2eC
         /TDcduIhcFVqOvle9eCObuCIefpkwnPe5rhbu0L7oC/qjfBqU1jOwUie/nM+k0wJbWhf
         xAfnsH5F7/tyzWVma3Y4vQ55fBvi/mJWPIDK5WTQQCFQZRFgZjdr/G2rd3cMKuRI9ARb
         vw5LP5HSpL29CDk5QclEtID5ilU/+OaJUs+wEH9eIzQOqvmj77YsjTimrW1kW7ciYkGe
         ANptq5KiA1WAd1d1cLR3gzYF/YDdbuGoV16KNLY90wa5j+C7tUHlfYxB2kBeMpS8Kkbk
         1maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754562757; x=1755167557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B8JKmuj7NoKhGZ2Qof2Rmk4iilq75YN49pVYUQ/rPY=;
        b=XPc3Gmqmy98SjOi6Ba9qULbYNtNQDrisAIS8FmVbxUbXzw3SrL+kFTapWZR+3lxufN
         NjnKySfZ/Aiz4vsyTVDvCd2J4QZf8aiNwya5bvlNc/cW70pr4Et5sqLsS9YBvcvcgSxe
         sT0SxECarYnPhjpz65uBIAiJL0sINA9X4Nlcf6jhmn9sQtLtUMQBLATCmmFJen0tCHlH
         h4sZsar/cdhADxxRZZ+ojA9qvxjSA7Jv+viA0pq93Ua+lO10pGiC9jfPMBN7wkeAPi0r
         bOhRDD2mC5KkjsqDnWcvC27wFbQJwBq/HuV/qFCACoj99J5ihaQR3G9aRUr8w4rkTXmE
         kdFg==
X-Forwarded-Encrypted: i=1; AJvYcCXiiiIU7dU+TbCslUbN0xEFEtoWOzbIkBmK0Dc4XRj3ZsW8nub7c3ZvafnbWc+5XoUZ5mpyoTWrh3/8G7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tn2NhbXdG2g64OSpo43VTjtojATToDHwG21AJlfx1iqnzIqR
	YR9nYo3D9dgEi6PhJ+oRtEQ2r+lUvsUpHuI2r8sWfgty6+CMlAlQf5t31OGa0rXK
X-Gm-Gg: ASbGnctJwFiUV5KdpNob0ehuV1jqQcZyJZsLm//STmslVUpYdRNxLA456JKcwwwggHU
	z3h8SYbYsi8M3qc1KEpIYTFVwjC681vJM5b2+cUIDqOU7VVhjaB5sW7zJNl56Jh3bCdKVj+A8Xz
	cdVu6R7Upr4iwvEj1IiYznsm9eztFNDhX3XeT7SetwNyQvPl+rl0HneCKvCqL9VfFlEfuNDPZ9K
	4dphBnIBgNO1r/xE91z6Y+h+wPiQYCpzLqNsTb6DLcfIvj8Eqq2y5mgMNefsgZ8gZTD6O3fcejt
	Iv4WUaAAvT9H/+6FpPi/3rkJ2BFd8Z6nbuLwnvsMZn2Nb+C9xRNnKOub+hfoMPAjz287XaRcpZO
	OtL4uDxwcRtar386h+b5riYlyX//ENsDDMoahZuIzInvL
X-Google-Smtp-Source: AGHT+IFPufnvFSsR8r6T7GxkS4gEbZwWXr6CP+c/UMnPc/HrB9L8UVLsIPq1jzvkyhEUv+s/coVuwg==
X-Received: by 2002:a05:690c:9b08:b0:71a:2cb:db1c with SMTP id 00721157ae682-71bcc86886cmr69241197b3.25.1754562757019;
        Thu, 07 Aug 2025 03:32:37 -0700 (PDT)
Received: from z-Lenovo-Product.home.local ([137.118.180.123])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5c8fd9sm44766317b3.61.2025.08.07.03.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 03:32:36 -0700 (PDT)
From: David Ober <dober6023@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	dober@lenovo.com,
	mpearson@lenovo.com,
	David Ober <dober6023@gmail.com>
Subject: [PATCH] hwmon:Update EC Chip driver for Lenovo ThinkStation motherboards
Date: Thu,  7 Aug 2025 06:32:28 -0400
Message-Id: <20250807103228.10465-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes differences for the P8 system that was initially set to
the same thermal values as the P7, also adds in the PSU sensor for
all of the supported systems

Signed-off-by: David Ober <dober@lenovo.com>
Signed-off-by: David Ober <dober6023@gmail.com>
---
 drivers/hwmon/lenovo-ec-sensors.c | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
index 143fb79713f7..8681bbf6665b 100644
--- a/drivers/hwmon/lenovo-ec-sensors.c
+++ b/drivers/hwmon/lenovo-ec-sensors.c
@@ -66,7 +66,7 @@ enum systems {
 	LENOVO_P8,
 };
 
-static int px_temp_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
+static int px_temp_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 31, 32};
 
 static const char * const lenovo_px_ec_temp_label[] = {
 	"CPU1",
@@ -84,9 +84,29 @@ static const char * const lenovo_px_ec_temp_label[] = {
 	"PCI_Z3",
 	"PCI_Z4",
 	"AMB",
+	"PSU1",
+	"PSU2",
 };
 
-static int gen_temp_map[] = {0, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
+static int p8_temp_map[] = {0, 1, 2, 8, 9, 13, 14, 15, 16, 17, 19, 20, 33};
+
+static const char * const lenovo_p8_ec_temp_label[] = {
+	"CPU1",
+	"CPU_DIMM_BANK1",
+	"CPU_DIMM_BANK2",
+	"M2_Z2R",
+	"M2_Z3R",
+	"DIMM_RIGHT",
+	"DIMM_LEFT",
+	"PCI_Z1",
+	"PCI_Z2",
+	"PCI_Z3",
+	"AMB",
+	"REAR_VR",
+	"PSU",
+};
+
+static int gen_temp_map[] = {0, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 31};
 
 static const char * const lenovo_gen_ec_temp_label[] = {
 	"CPU1",
@@ -101,6 +121,7 @@ static const char * const lenovo_gen_ec_temp_label[] = {
 	"PCI_Z3",
 	"PCI_Z4",
 	"AMB",
+	"PSU",
 };
 
 static int px_fan_map[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
@@ -293,6 +314,8 @@ static const struct hwmon_channel_info *lenovo_ec_hwmon_info_px[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
@@ -327,6 +350,7 @@ static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p8[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
@@ -359,6 +383,7 @@ static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p7[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
@@ -388,6 +413,7 @@ static const struct hwmon_channel_info *lenovo_ec_hwmon_info_p5[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
@@ -545,9 +571,9 @@ static int lenovo_ec_probe(struct platform_device *pdev)
 		break;
 	case 3:
 		ec_data->fan_labels = p8_ec_fan_label;
-		ec_data->temp_labels = lenovo_gen_ec_temp_label;
+		ec_data->temp_labels = lenovo_p8_ec_temp_label;
 		ec_data->fan_map = p8_fan_map;
-		ec_data->temp_map = gen_temp_map;
+		ec_data->temp_map = p8_temp_map;
 		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p8;
 		break;
 	default:
-- 
2.34.1


