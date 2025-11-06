Return-Path: <linux-kernel+bounces-888090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DEC39D22
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94893BAFB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51546263F22;
	Thu,  6 Nov 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuTVu+ys"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3E35965
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421504; cv=none; b=nGZppkaqj7IbZzjJDWxxxVZyrIgE+CNzlGM8I/ORWzXGUGNYSW5UJ6qoi9Jmk6cXjNPm63HeEGEQxCyCWyCWKQPO9QCzR37E3p+73N3ZJelRugmaNVV13RGcBEzzT/FA/3I6veKxKBonBcu6EiqdXTnVpgHbmr7oy/RqUgYEt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421504; c=relaxed/simple;
	bh=j1+M3emMe9tqmPSbKCgIoXD49IQZIb4FHliGCLpUH2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgx6KBoL481TQNkSwvqUz9j6ErLQXorX9P9z3PoLprja6okmPmmVTVBgd+/qaTefrySQIB8qDXABO1GFk6Ehxx/V6OLCuE24mLDg8pZPhGmri3YJXiyY0bCMXDKl4ktywx0ZJxjcNjcsVoz1zYlWvQG/ZMzIlszL2az1OpNwU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuTVu+ys; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7810289cd4bso722160b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762421502; x=1763026302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU7AjJowjDZcDckJUJRmtF/yOybguMZZsthXphjlG7M=;
        b=kuTVu+ys5mAnXO+Ug532x5/DeRWWT6p2dJpyzUtJ8YaZ5wXvEP4FjYXNPY407SXUyI
         eQ8dDBsu+hYfa94jTH7wR5RWF+TDOJo5SELm2USBEWjB4wKErek0SthNNGw3TlPRsgHl
         KQ1E8J1nHzXlHT12dy1Tn5WfkA3SISC2dIBrEEKzz+IhtQ0o9bc5alJult8LdvE7PkBX
         qudBLphdGfMBCzaHSojZcfnkZN+TLCQffr0HWPNnfa7F2JD6szKX3DCUfU193KxTlGVm
         uAIByUTgDAvlne8XxKITXbzbXIIxKscDQ7MiC5lRe2w4lGBWpYNuRFLo/jXmkFa+VY9p
         h4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762421502; x=1763026302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU7AjJowjDZcDckJUJRmtF/yOybguMZZsthXphjlG7M=;
        b=utddIODGlEVuU6Iehc7EKvCM9H97IoVAzadMQGXfcskjLGLyid/AM8Nx+ogz+bSwdC
         zrJcBnA4URR2z2BSRvvf2vEKuinq+hn2rZzxjV3xa4EQQfSrVvamojgNGz/rSB/T1ydm
         4cFG6Xj9H44/26zoyApdq/eKKnYvknFvbDGURuGZ4AAWPnKAYyzTCxPzyXK3m5QE8AoR
         PoBnpVejo79SGZcGMkxl1mZw0UDqyTzvZ9HPRG8jbX9n5Fa39ZKmX8gDCCtDvuuBDPGA
         1C3CmRGsA4M+Fsgz6LHtAgcru+hRslCnaKPPg1La9Tf31Jrs39KQrlXiJlDh+gvoNzY4
         Kc5g==
X-Forwarded-Encrypted: i=1; AJvYcCXyio1te+WcwTsS5GSCKixihj4DrMhtCCrzic8Sr65g6kuHVLHT57v88z9kZeVGWXmDAdLZSG5wvCD+i1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSta5jLA7mmwIf2qiYtHjRXBd1Kfg/5/AC5A0lg9fqac2dUqY
	Zff/5vRKT8kCTy4g41e0t5wg7WZqWXJX2ey6EKsWxUryVVhPSN5+n1SM
X-Gm-Gg: ASbGncuwvphdBt5Kz+J22iMih2PIvu/Re5PF2f4YZHvXW44zkVIZPALE7p9DU2Iwsl4
	/fFbzYF7Dvi2KfrHKRpAS+cebUOaGPhGKbMSn/LG8f0O4YN2Ct01KrC+cjTN2j0NaqnFZswQJH/
	WWCWQcFfpXYAn5u5Y0a5WPiD9FO4qsJkQlLYLsl8x98gSNhxJlwJW5RowxqSqJCwzgthLvy5xmD
	5JbQoVOk5Nqw+i5ibNaDMlWlOzCA3K8e2D19fsfrakQY9zT0lxeQRbNrlmjf3iHsBR7aD8EJCsr
	cHnU0JfZLYVo7WOTRL2+fBkUu9/ZkBy+oUOjceG4qZuIg/18wcy1GhuRP45MTIMkHdwWfylbW7X
	twBBeMugqt5/kJkMzwwP3f3eLEEmUaXrBnp7frJVLZ806EhmE2wBSyGkz7+O9B1wXVasz4aN/56
	H1eQx5MlltJaNrlIxiE4LLGbe53GF7tTedjlFSDh0r4M7/QbGNK+HYWaqLvksT
X-Google-Smtp-Source: AGHT+IGBlclwFd/WiSybw2BLg2Lg7w42XKfs3KgCEfbKDZNZqWng5nmOi+qqs1EkrFKbQ+0aeHT+Qw==
X-Received: by 2002:a05:6a00:1d91:b0:7ae:8821:96c3 with SMTP id d2e1a72fcca58-7ae882198bfmr7251931b3a.32.1762421502528;
        Thu, 06 Nov 2025 01:31:42 -0800 (PST)
Received: from JF.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b043644b34sm496220b3a.28.2025.11.06.01.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:31:42 -0800 (PST)
From: Jeff Lin <jefflin994697@gmail.com>
To: jefflin994697@gmail.com
Cc: Mariel.Tinaco@analog.com,
	andriy.shevchenko@linux.intel.com,
	cedricjustine.encarnacion@analog.com,
	chiang.brian@inventec.com,
	grantpeltier93@gmail.com,
	gregkh@linuxfoundation.org,
	jbrunet@baylibre.com,
	jdelvare@suse.com,
	johnerasmusmari.geronimo@analog.com,
	kimseer.paller@analog.com,
	krzysztof.kozlowski@linaro.org,
	leo.yang.sy0@gmail.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	ninad@linux.ibm.com,
	nuno.sa@analog.com,
	peterz@infradead.org,
	thorsten.blum@linux.dev,
	tzungbi@kernel.org,
	william@wkennington.com
Subject: [PATCH v2] drivers/hwmon/pmbus: Add support for raa229141 in isl68137
Date: Thu,  6 Nov 2025 17:31:31 +0800
Message-Id: <20251106093131.2009841-1-jefflin994697@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926014552.1625950-1-jefflin994697@gmail.com>
References: <20250926014552.1625950-1-jefflin994697@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The RAA229141A is a digital dual output multiphase (X+Y ≤ 12) PWM
controller designed to be compliant with Intel VR13, VR13.HC, VR14 and
VR14.Cloud specifications, targeting VCORE and auxiliary rails.

The RAA229141A supports the Intel SVID interface along with PMBus V1.3
specifications, making it ideal for controlling the microprocessor core and
system rails in Intel VR13, VR13.HC, VR14 and VR14.Cloud platforms.

Signed-off-by: Jeff Lin <jefflin994697@gmail.com>
---
v1 -> v2:
- Modify subject and description for the requirements
- Remove CONFIG_SENSORS_RAA229141 in Kconfig
- Remove the part for multifunction pin in v1 patchset
- Rename function raa_dmpvr2_2rail_isys to raa_dmpvr2_2rail_pmbus
- Link to v1: https://lore.kernel.org/all/20250926014552.1625950-1-jefflin994697@gmail.com/
---
 Documentation/hwmon/isl68137.rst | 10 ++++++++++
 drivers/hwmon/pmbus/isl68137.c   | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/hwmon/isl68137.rst b/Documentation/hwmon/isl68137.rst
index 5bc029c98383..e77f582c2850 100644
--- a/Documentation/hwmon/isl68137.rst
+++ b/Documentation/hwmon/isl68137.rst
@@ -414,6 +414,16 @@ Supported chips:
 
       Publicly available (after August 2020 launch) at the Renesas website
 
+  * Renesas RAA229141
+
+    Prefix: 'raa229141'
+
+    Addresses scanned: -
+
+    Datasheet:
+
+      Provided by Renesas upon request and NDA
+
 Authors:
       - Maxim Sloyko <maxims@google.com>
       - Robert Lippert <rlippert@google.com>
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 6bba9b50c51b..97b61836f53a 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -65,6 +65,7 @@ enum chips {
 	raa228246,
 	raa229001,
 	raa229004,
+	raa229141,
 	raa229621,
 };
 
@@ -73,6 +74,7 @@ enum variants {
 	raa_dmpvr2_1rail,
 	raa_dmpvr2_2rail,
 	raa_dmpvr2_2rail_nontc,
+	raa_dmpvr2_2rail_pmbus,
 	raa_dmpvr2_3rail,
 	raa_dmpvr2_hv,
 };
@@ -399,6 +401,17 @@ static int isl68137_probe(struct i2c_client *client)
 		info->read_word_data = raa_dmpvr2_read_word_data;
 		info->write_word_data = raa_dmpvr2_write_word_data;
 		break;
+	case raa_dmpvr2_2rail_pmbus:
+		info->format[PSC_VOLTAGE_IN] = linear,
+		info->format[PSC_VOLTAGE_OUT] = linear,
+		info->format[PSC_CURRENT_IN] = linear;
+		info->format[PSC_CURRENT_OUT] = linear;
+		info->format[PSC_POWER] = linear;
+		info->format[PSC_TEMPERATURE] = linear;
+		info->pages = 2;
+		info->read_word_data = raa_dmpvr2_read_word_data;
+		info->write_word_data = raa_dmpvr2_write_word_data;
+		break;
 	case raa_dmpvr2_3rail:
 		info->read_word_data = raa_dmpvr2_read_word_data;
 		info->write_word_data = raa_dmpvr2_write_word_data;
@@ -469,6 +482,7 @@ static const struct i2c_device_id raa_dmpvr_id[] = {
 	{"raa228246", raa_dmpvr2_2rail_nontc},
 	{"raa229001", raa_dmpvr2_2rail},
 	{"raa229004", raa_dmpvr2_2rail},
+	{"raa229141", raa_dmpvr2_2rail_pmbus},
 	{"raa229621", raa_dmpvr2_2rail},
 	{}
 };
-- 
2.34.1


