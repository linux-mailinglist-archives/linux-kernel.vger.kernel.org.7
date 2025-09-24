Return-Path: <linux-kernel+bounces-831260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE0B9C380
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2816A1BC309D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216BD274670;
	Wed, 24 Sep 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi1ntqAV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCFD263899
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747581; cv=none; b=Aie7yjUYp1IGYAoK2rP0JeEWmUHSMWbaziiB6A3C940cIMpNQXKxLhI07YoATqy5UqSgiSxpN2dbktzYq66txtzwEufX1q2eeU07tdFz28cTixAnZzUzN1t+LxthnmF9kODuGwEB/HQ9Cfm/MQuRmqpQGsP+pHnGC0rTFjTQTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747581; c=relaxed/simple;
	bh=WWUhycMgvhzyeaLAv3HRCxsWk3YeZlwvEpXzRathUBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JcHibW8ieqjGgglrDczX1GrdWNJmZ9L9vK/7pwZ8gsU5L8axmgqbwPjm29+nea6NFFO0YmaRbjUJfTGFYNDhYbep4V4BqJVaUDKASSvPYEeBYFNtEd/FfoYaNoaWsMp7JqX8fpFWxm+X6IGaJJG93X/zfJb7vVmsMypg3kTuH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi1ntqAV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457f581aeso3134535ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758747579; x=1759352379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRuDgtKnLQenDF5rrcxOy2nEN1e01GeSQLdOvaR9vtc=;
        b=Mi1ntqAVuTfkVvNFGerOBgft6kEpumvmgdr53jBOh7CtJQVqwCu9jF4b8oz1nHWbP1
         wvlu7l3Y+kKnT+L+nNMpxRXnzghtyRdWpTtJdniZ1j/yHqKKHN4L+Pg14TUU1W/KY4rm
         SeSGrN0Zoqtp0xwkSf0AulOhJU1rqEp4564jmxXbaqodbuWpjyKFZqLEmTBW67igJJkq
         3lw+jJy4+ZMwX3BEFdHImXFpwRD5zhS1FdKK/V4CgxSKciFPOBy3ASOKlAj3jcAEvMgE
         UxBZiqX6TzaZLcriE3g4YZTtwnpSveut+pASlhWkZfO1zVMby1aOw/xQYwzkmvRTCzX9
         ezQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758747579; x=1759352379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRuDgtKnLQenDF5rrcxOy2nEN1e01GeSQLdOvaR9vtc=;
        b=rMx/ytFTyZO5rVqnN2zoNbX3z51pS2ZeTo9KLc/xn5aAp7uPsUsrBaIlxlmXu4WDTi
         A+qC2HWMR1JGHb0hYQt+kxNZbhn3hcsB3M5kE9GEiAEYflXtAYjRGU/9VvXkt3uChw1Y
         XtKPidMuH3DSVTRJqfbkI21SDB+I0JtSqOIBMcAzZkbwqK4xP4uQ292XFKh8YeuZKKli
         9nUmuxzXFkWKNWCLLGFdMUAmC6nVdYRB595ulHW7SpAKHHbRULn8MrA9fV+ITz8HcGI6
         oUedv4Py0VEL3AvjFb97AR0HPwwkgQxyek2Pb90uZ6OArjaC/IKDPjjFvKtqlVIeRfH9
         3n0A==
X-Forwarded-Encrypted: i=1; AJvYcCWVdBjh0rL+16ApO3ohspkxo9VfuXjBgC2QmqQpoXJkT36liRukwhQNmwlwDzFl7CS2DpIDd0bw8vJ7qhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7IlRUCwyS/lRcCsbXO5hfDH31/ghKD+/vyZKER8zySnrWtx2
	05uhvvrD4o5BuiSfHnrGLYSv6smXvl/a0Url1YKTyrmPQecIKayl/xenXwIbnGYptE0=
X-Gm-Gg: ASbGncvKbt8wJa/dsExG4hBLD2sLIjISUf05CF9RCiMMkWgXVoRjxd6P93a7lqHU1GS
	29610BoPUaDPN0Ei6HsTNRunOgqSbY7FzrFUO9MlhuADP/yS3Z5LkGWHnaI64fjIG1yLoT5RZ0S
	vC/+G1eV9s1fohOWWVy1z/lQaNMYQsJohixVdnUF/vMb0Vlpw2pE7nJfch9a8IT9Gpm7fmpZnDK
	ZfB06oGDvM5umokvGglDjrAYCDW/OBwdEQoJrTGkw/x2XeKrYPmiC0RVLq0gNdtIlS5gJA5iiNA
	iyWREyqJ3HGDLffajBYVKiBoHlhdN587Et1vJbwHWRAN7h821m8DfvDDhnhN3ldrTLMaEAs/oUj
	2YiGFxDkKxyReVJhsrw0RP8hw3luXPg3bJy2LI4MZEz7gbyJ0veXYLb7EXGVdS0agybNRLhcdir
	6x0CMczUC4oICZjuNKxuLH3hA=
X-Google-Smtp-Source: AGHT+IFTfcwzlqAQ3hKxw5FC7Jv4ja7YwXZXX4kygX+5Zsmi5Hhkd3KRdxGLAj7nmPNA59hYiV1jxw==
X-Received: by 2002:a17:903:3c26:b0:264:ede2:683d with SMTP id d9443c01a7336-27ed4adb732mr10341995ad.56.1758747579257;
        Wed, 24 Sep 2025 13:59:39 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([27.252.49.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd8fa0asm3375248a91.3.2025.09.24.13.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:59:38 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sanjay Govind <sanjay.govind9@gmail.com>
Subject: [PATCH] Input: xpad - Add support for CRKD LP Guitars
Date: Thu, 25 Sep 2025 08:58:38 +1200
Message-ID: <20250924205912.29793-1-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds support for CRKD LP Guitar Controllers

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d72e89c25e50..33b0ad041247 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -133,6 +133,8 @@ static const struct xpad_device {
 } xpad_device[] = {
 	/* Please keep this list sorted by vendor and product ID. */
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
+	{ 0x0351, 0x1000, "CRKD LP Blueberry Burst Pro Edition (Xbox)", 0, XTYPE_XBOX360 },
+	{ 0x0351, 0x2000, "CRKD LP Black Tribal Edition (Xbox) ", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03f0, 0x038D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wired */
@@ -518,6 +520,7 @@ static const struct usb_device_id xpad_table[] = {
 	 */
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
+	XPAD_XBOX360_VENDOR(0x0351),		/* CRKD Controllers */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One controllers */
-- 
2.51.0


