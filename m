Return-Path: <linux-kernel+bounces-775647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742F4B2C2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38581688533
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E8338F51;
	Tue, 19 Aug 2025 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bMIymVUD"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80A3376A9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605609; cv=none; b=htGAFtKOjYSrj2rUjSeaf2hL0Zlxxw8eaHDxrm71EE1/LbqEzzCWrT+2vS17K2/iSqhu1U/R6YUA5fxlah83cFw4mQC8i+8SEtKi7Pw/bdAUUItcP4k4oBpvTowKv7pg2MGJUMZlaUOv9pXyW4vymL5MRoJqR8sG1bYaloNEOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605609; c=relaxed/simple;
	bh=dywSOFLfMogkBmbcyfNdBbCCi1K9eDNR4VWZt+BgoJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4I7qcI9X8E8ixBDZXVk0BZhQ0q8wnz1H1ZUZOUm4dZ3UyiwITIYgh9JmSOB5l2rUq0ALa5uHznAgqE6Ya0rct3OWf4dSigo/VfXQV0rNbGLSSlS3Po947Ecp8uvMENKakmGFc+/PtF8er/OC541tEuyPGWiVcqUhLOKATEHs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bMIymVUD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so2879617f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755605606; x=1756210406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uRtcEd8pcpMinDJcB3a1LhyOu4987652vqrf5zaqCM=;
        b=bMIymVUDVbiJgz/6YaA5ilZjG6Src21hq2Wu0wTcbIYMuk0ptGVzt2pzFhNtQOoJCT
         LyN4NSLHqx3wI4Y8B3949p0D+cFhKpEGld9obGLTr+CzLFecTohGDFDBK4OIVvHbNE7W
         qpvBwdx6dD86YB/+Wea7j1kVAQXKtvKzIWAqwwC5wQuZrgnGWKxbn5/6ZnUvahZio8TG
         DkidWQT5B0kmWea3mo5FrOACdWYA6PXzFTQb84AgT1Y37sFkopIxI9gWEp85tN6uZzWz
         vVVrnd0z6Z/oEzMN56lLfxV+cjgQ1uOIYgKFZHQrfLN+aNHMLFWbhlfeUha6UPkGyv3P
         NHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605606; x=1756210406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uRtcEd8pcpMinDJcB3a1LhyOu4987652vqrf5zaqCM=;
        b=f+LBS6mcFhZq5TiWg3d9v6JgA2GvPHyXtn28w576H8ImkzqXqWVzOVU2HweQzvmuW0
         8LWgN5hSSdt50Nstwo5EXX7C1EjHqYiHSePAMYSY70H8OAtawTUtcc9H4tMRrCEr35J1
         hYX/L83X7xqM2C1AnCYEb6A2S4sCxzt1s0chytHyRLcSqESEyJ+2J5/1b3mIRJebboi7
         9i6H1kHfXDpX560glDx1keK7Ls8H/uhHr4SbvdoSr/HYTU9i6rY5sB6VxPxGmNaie3ea
         eAbxuTtfRAxn/aJG8x+wngXIIGc4ia+UOQV3GBRr8Ctc4PaxaGxR9qo2SwJUo5H6MlNc
         Jd3w==
X-Forwarded-Encrypted: i=1; AJvYcCX0fl+lVSrk0ca0lbcUVCG+6dVCAa0xr2/WzQVN/0H8cFWu1niglr0Wk522SC1MZsS24DXJZGjbc/ZJ/Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+K3mP3WdD8mMxsdQjg0czyyN9bDxXZcX+iyMf4s6tRi2t2vrt
	w47CC5e9OZGqtZQttMtJglcTo81fGetE95x9XYhREa5ew7XHhsWSWAh6HUZ+uy4iXNE=
X-Gm-Gg: ASbGncvznMShirllY8bKyCslXBIIBYkSNcbMEevqv0jijSDk2rZzU3OCkY/SydW5T77
	clt2UE/nTj7xSIDZb7oTq4WBYCV2+yM30qWzZLO0q/BKvAkfrDgWHTvu3eDOclr4gnRikzfQ5m/
	El3+oHrL/j6y3V4EOwdWWuqDH9BIW60SoqOrbrv1AVoTofbUXfcdNNIVXO90UMrOo1qnty81OLN
	w3xmXJhmBrxmZofOdiIw1/0oRf+AFLup8j+iRPkdEn5uAL0e8W+OpkFGfFscWiicHqdtLaZhkno
	LwhcCdU3HMSifrRKewp6iAKAlFLS1nN8UGwPPFHr8MyV0vGwRXIbdRnXreMsR6CGf0YRvYCVG77
	qLfSE4wyrXaJZ5aPVMaWT0uY2+oYGBJ/czXTNvS0=
X-Google-Smtp-Source: AGHT+IEyO17CVHXzd9F1BliU3Ul+TEXJM+jcje2z9wQ3gAvxvj+Mmq6shz2a+l3z2LEnQlSleO7Zcw==
X-Received: by 2002:a05:6000:402b:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3c0e9ff5689mr1656146f8f.25.1755605605945;
        Tue, 19 Aug 2025 05:13:25 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f6dfsm107897525ad.78.2025.08.19.05.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:13:25 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] params: Replace __modinit with __init_or_module
Date: Tue, 19 Aug 2025 14:12:09 +0200
Message-ID: <20250819121248.460105-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the custom __modinit macro from kernel/params.c and instead use the
common __init_or_module macro from include/linux/module.h. Both provide the
same functionality.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/params.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index b92d64161b75..19bb04f10372 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -595,12 +595,6 @@ static ssize_t param_attr_store(const struct module_attribute *mattr,
 }
 #endif
 
-#ifdef CONFIG_MODULES
-#define __modinit
-#else
-#define __modinit __init
-#endif
-
 #ifdef CONFIG_SYSFS
 void kernel_param_lock(struct module *mod)
 {
@@ -625,9 +619,9 @@ EXPORT_SYMBOL(kernel_param_unlock);
  * create file in sysfs.  Returns an error on out of memory.  Always cleans up
  * if there's an error.
  */
-static __modinit int add_sysfs_param(struct module_kobject *mk,
-				     const struct kernel_param *kp,
-				     const char *name)
+static __init_or_module int add_sysfs_param(struct module_kobject *mk,
+					    const struct kernel_param *kp,
+					    const char *name)
 {
 	struct module_param_attrs *new_mp;
 	struct attribute **new_attrs;
@@ -760,7 +754,8 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
+struct module_kobject * __init_or_module
+lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;

base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
-- 
2.50.1


