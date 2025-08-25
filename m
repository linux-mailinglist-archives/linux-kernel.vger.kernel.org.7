Return-Path: <linux-kernel+bounces-784360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38605B33A76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12667481264
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63AF2D060B;
	Mon, 25 Aug 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWlYhSR6"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090C2C326A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113324; cv=none; b=Q+0b9MUilKquZ0GzxvcWAmotd86DopyCuOZlq4PuzLzxnN9Y7M1tm5e8Qd4KRtSeK70qLj+zjHVa2SfgZE346gzRvFAmV8uM93JW7eokcH7ry2SxvWfb3FIcwRPjNwk7Fi0ZM/F92kqY+1Qd50BLxq7+0VUH5Y4K9fCMLnKj9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113324; c=relaxed/simple;
	bh=frWilHKtOC7ibOioFIhO93e3vGAB4SI1rbdEQyYyVJ4=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rpDVz5jFrzWBxbuRIUJAAtkJrRqcgPTt8kgecptWpTSLCC6JFwyZF33SML1592eZjwViW1iL2yYXMZWmFE6Upa6cD02/gH7mL1JYGzmozk0Og5A0+WrTkcxrWsqmvIjwoOf7ZA59sbFwP/O0qfWzvz1Z8y49jsUr86WkCUr5cDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWlYhSR6; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b474d0f1d5eso2753773a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113322; x=1756718122; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EfPpvJ6+WhTEmPpSG5PEfw+gk8iXNJsS1zHeL+VA0I=;
        b=WWlYhSR6qngtgAgckhq286Rxjv2HuMTS6AnZsgMz1GaVazROg/KqFhk6Dqd+NoA3Du
         Jg/0LBSVO5F5K4dkOVC6r6V0maQ6AyWelNaWaxyJT/3IphW5cSjb32292uD7h9wVmwJr
         awG7urhTK+xnxjmFntLc/BL+Rc4ezY3YG67zV3ey5NRbklR1NaqtOnIDJSb8usljwZ+6
         ZEQN0Xed2zirnZYZYy9qlKBSoty4OAitCkY2uOIWxexbe+4BHLjtXfufQxpvwx047qip
         Db+TNDJE6PEMlaA1HofSCiHTwn91GNM+E9+LHHgWuWYw8TKFYGXcw+mjv6BAb9AbNo8W
         nmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113322; x=1756718122;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EfPpvJ6+WhTEmPpSG5PEfw+gk8iXNJsS1zHeL+VA0I=;
        b=w2zBKF7UxU7e8m0u0UZWF8uUFNeIBMt3Rkp+Bp+Z4ZugTTSs1B0gcxH1AwnBurCpCe
         9J/XUNpzL54FliWsGsVUDWSu7yFH5XZfjsiZZhbuTS8RKJNagfZubD0pVFyj3jiqXdpg
         ZWLYrBGvjxADRhvsoXQkjcaJ8PMLjxR73yQAzXAA+2iXC9CVSUky49E+n6eDGJB3QviU
         9qnchza6Q2W/EM835UfAg+ztPqbMyCrZ6bNYooJ5ZMzSF4DIK16mo0bK5YoPNrwjnm70
         1pFvBbehX0IvoujKuGllYbt8ikv2QDRUjCcZe8mHBlK7Q/uMbgJU5+QRyW2gZLGiMBJ3
         F5mA==
X-Forwarded-Encrypted: i=1; AJvYcCVLQRgz/rKGDOvCp7T/kSGYiB740q+Q/AWkCrOELooeQfb2ARjcskROULxJb9gA/Ssc0BRj0GOP1VQKsOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtiRJRmmrZTYX0+l73MSrV7JX+WEvuJdJt2TYomhginyUuJj1
	xYuO85YQbpH763/45LztnvYICZ6KVESmO+1dKjzDPTX5Sb6Kc0+ntsfH9KBtciHmSBCF
X-Gm-Gg: ASbGnctb/meTjoiXJ14P5oVJdAtkH2h1fJxmDiFd1FGeBCF+wm+g5C+ye8ymzee80BF
	C/pnQuO+dtobKSQIZMzgniq81ts90ieSk4WWXn1/JNb1nRz8m2Q9LOJD+CW0h+H8ESmSyYoq4U+
	9B+f04uiKuLteqWeZc5d1Bs9I00unWJ1FtWMaVQLjK8Bd7BgG7qoTu9RxMucHVgooqftJpn2nAO
	+u0zfPRDlUsK8FBuuGTVJPZksocZbYOuZAPb6ehzTWa/gXVyQQ7JCigyVAqkA1Z2xLWVMelyQ3K
	Zxz3eyD6ae8KPBjDHEuMbERqDLad+FY/hcu0ItOvfCRznLJRgwnUxT5zAfjWSvxZrf38aBZqleV
	DsKA4qTMCrFEBTrYSjuv8MjmAViqRI+K6buEpf3QYa+mDpGDzIE5QTrJLGSc=
X-Google-Smtp-Source: AGHT+IGM+hvjIncidO6+06hwgjNzVfwutWvQvN1StGNPqmAytpX8YR1SEbFsIYGuWTIGKBQS+eJdCA==
X-Received: by 2002:a17:902:d486:b0:246:b46b:1b09 with SMTP id d9443c01a7336-246b46b2296mr52545635ad.30.1756113321877;
        Mon, 25 Aug 2025 02:15:21 -0700 (PDT)
Received: from didi-ThinkCentre-M930t-N000 ([46.232.49.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a04dsm63318855ad.21.2025.08.25.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:15:20 -0700 (PDT)
From: fuyuanli <fuyuanli0722@gmail.com>
X-Google-Original-From: fuyuanli <fuyuanli@didiglobal.com>
Date: Mon, 25 Aug 2025 17:15:08 +0800
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
	fuyuanli0722@gmail.com
Subject: [PATCH v2] ntb: Add mutex to make link_event_callback executed
 linearly.
Message-ID: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
	fuyuanli0722@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since the CPU selected by schedule_work is uncertain, multiple link_event
callbacks may be executed at same time. For example, after peer's link is
up, it is down quickly before local link_work completed. If link_cleanup
is added to the workqueue of another CPU, then link_work and link_cleanup
may be executed at the same time. So add a mutex to prevent them from being
executed concurrently.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
---
v2:
1) use guard() instead of lock & unlock functions.

v1:
Link: https://lore.kernel.org/all/aKiBi4ZDlbgzed%2Fz@didi-ThinkCentre-M930t-N000/
---
 drivers/ntb/ntb_transport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4f775c3e218f..eb875e3db2e3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -59,6 +59,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/mutex.h>
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
 
@@ -241,6 +242,9 @@ struct ntb_transport_ctx {
 	struct work_struct link_cleanup;
 
 	struct dentry *debugfs_node_dir;
+
+	/* Make sure workq of link event be executed serially */
+	struct mutex link_event_lock;
 };
 
 enum {
@@ -1024,6 +1028,7 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt =
 		container_of(work, struct ntb_transport_ctx, link_cleanup);
 
+	guard(mutex)(&nt->link_event_lock);
 	ntb_transport_link_cleanup(nt);
 }
 
@@ -1047,6 +1052,8 @@ static void ntb_transport_link_work(struct work_struct *work)
 	u32 val;
 	int rc = 0, i, spad;
 
+	guard(mutex)(&nt->link_event_lock);
+
 	/* send the local info, in the opposite order of the way we read it */
 
 	if (nt->use_msi) {
-- 
2.34.1


