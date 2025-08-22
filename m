Return-Path: <linux-kernel+bounces-782199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955AB31C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692806606B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D854F30E0F2;
	Fri, 22 Aug 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGR/wbk7"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208F309DAF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873684; cv=none; b=pL3pVuc5BPVA4Pe9E2EhlhwtowvF+IEFkQ7XdSz1prLTCof+ijMkNhXqEPYQP6lULtpTVPO/lov0r8TDjoQscgCJI00j8Ko+d3ROU+p1EM7IrIUbvkcIFbTFhfa0DiX8d4JvO7gx/ocopLAYeUiILTDc+4D1/8W9iwcz3Y4jf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873684; c=relaxed/simple;
	bh=cOKiNR1OqsXvaoXMGRfm/iAMpfIw5WeEz8zS1By03+4=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=odxUcTL9uHwSuY2Tl2ZBBicD7vivKIb13sXhqkxLyjjLpZgHZ/724kOpClAh36/M4aoSuTxk4oGWL7KeP9pMX4tHw2cSwOmN7lQJFQvRLLp1csRk/8CDMst6viS2PVBwkpcWYDJ3wzR1a8Gah5TAqrES15J4FNA3zAiJoHUejmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGR/wbk7; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-324fb2bb099so1534612a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755873682; x=1756478482; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2a0v5c2RPOmVHPi5zsER9bdyoW9/sdLoaF8GR0neeg=;
        b=NGR/wbk7VX6jFTSrUpoW0YR0B7r27L4U7jHCLuLhocVGgNErv55W1il/LsVfZiMKoz
         gyMlIMy8jAHI3XfxKKagH5Q1p4XZL0Ubc+0aY8Ii7HKjT87i2jeAnTxzWQJTHYLcbFaQ
         yocqPCWv9ZcU+AlAdi0i6j4G4nQkgLMkJ8LTL5RC7VTpO0VPEmQmeSppGoFw8ZUsAzfO
         zLuajF/Z3dUIsNejEEXISk3QWtc+B5EXsLF4a8JfhHnQz+CxubjZnOlg/HxcxpEtARVt
         /FmqY++K/lt7OBe7NLZ3zeK4HM6zO7r1H/unfXH63J2qhaTwvbsWfSV0MM+y7wYPFPF8
         x2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755873682; x=1756478482;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2a0v5c2RPOmVHPi5zsER9bdyoW9/sdLoaF8GR0neeg=;
        b=ZB7VdW16SFSy/CIdOH05BdtNAztSFFX9creB7X5xYONuGyfPksYMIQX/Pjs2W5RiJa
         k9jlnbvuV4/oFCw72gNgkXy1cs8nSPhRD0GjcZzDUuAhNzLGHLpLUv9mjYwAjTQ09Ic2
         ZzAGQtiTYeE9ge/2BK9ZK4rQ8ih/J2/axVIksg4F80sHvInigZJ1cX7ar3UtpfoKrffb
         ATG1lvyE3Fzb8Ce+TmfftXAzlrputKZtCR+V+O73LSxApmFo3U4v2Y6TtoL7L9SaI21N
         pNN/lKy2JHXKdnWpjDFBKe85tQ0fkBdFWPLul31pEwAkZ4WkDkchM85EzprJcqDFl41j
         srbA==
X-Forwarded-Encrypted: i=1; AJvYcCVE4bq/rBQKq1EuEw4xin4pfMR2HcUIaBFEMyHQqPNAoKu7ru/vPtyIxth0gfDyYYBhnpfbq4xc65wuH84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/lbScUgbNb/8OBjJrAJ0CbhwuGRO+Cswmwpe/jvmCerXAmM8
	QZ5pCdb7c8bKNGDcKLmWO8lN6Ui4mHMbSpzkwWVH0hADBuAfP51WQMxua2WLD/U=
X-Gm-Gg: ASbGncsbGZgwG0+/mTOdFc+IkIQ+4I5GnGxFHEgv5PxDunoFl2TFXxljnbBmVBHDXt2
	+JHXVWnp3yQzTJCJhT8PA568/Go4iYaJshOr1N24iOZoj0y/JXPIc5fppvJC+V01gtXUMs2S3dI
	N1ZmZRyODnaLMg8+gEWPE/Gp+rwaJWB+pQ/1yII2e03GdLE/DIk0avHU/eAlk5n7SWX9cD4Hf20
	8yM598IzOQRQRi74/JEQLjdNuA+Oc4M1ds86Tbg4IjDa0WHy3WsXX04Zz4EL/P/R8B+snu5dYCg
	qnQDvch3tWzPEhuOYyHlAN22rIkvy5xXzgwAG9dGN5op2ydca3hh9I/+VSAzpTbyZ02VLITsJIS
	+FXe3SkpDFcG54EyrMbNPdfhx5pjv0MlPC8qCuISqBXyLQPM2q+Td8HA+TQ==
X-Google-Smtp-Source: AGHT+IFeJtTGj9VnBxoCmZ9HVU5zPX7E4u9a+qqxknNSnaMRNipL0qy+Y0d766tnO8d0BcnPkem+Gw==
X-Received: by 2002:a17:90b:4d89:b0:325:3937:ef93 with SMTP id 98e67ed59e1d1-3253937f1bfmr1656210a91.20.1755873681603;
        Fri, 22 Aug 2025 07:41:21 -0700 (PDT)
Received: from didi-ThinkCentre-M930t-N000 ([210.12.148.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ead28sm112089b3a.77.2025.08.22.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:41:20 -0700 (PDT)
From: fuyuanli <fuyuanli0722@gmail.com>
X-Google-Original-From: fuyuanli <fuyuanli@didiglobal.com>
Date: Fri, 22 Aug 2025 22:41:15 +0800
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] ntb: Add mutex to make link_event_callback executed linearly.
Message-ID: <aKiBi4ZDlbgzed/z@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since the CPU selected by schedule_work is uncertain, multiple link_event
callbacks may be executed at same time. For example, after peer's link
is up, it is down quickly before local link_work completed. If link_cleanup
is added to the workqueue of another CPU, then link_work and link_cleanup
may be executed at the same time. So add a mutex to prevent them from being
executed concurrently.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
---
 drivers/ntb/ntb_transport.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4f775c3e218f..902968e24c7a 100644
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
@@ -1024,7 +1028,9 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt =
 		container_of(work, struct ntb_transport_ctx, link_cleanup);
 
+	mutex_lock(&nt->link_event_lock);
 	ntb_transport_link_cleanup(nt);
+	mutex_unlock(&nt->link_event_lock);
 }
 
 static void ntb_transport_event_callback(void *data)
@@ -1047,6 +1053,8 @@ static void ntb_transport_link_work(struct work_struct *work)
 	u32 val;
 	int rc = 0, i, spad;
 
+	mutex_lock(&nt->link_event_lock);
+
 	/* send the local info, in the opposite order of the way we read it */
 
 	if (nt->use_msi) {
@@ -1125,6 +1133,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 			schedule_delayed_work(&qp->link_work, 0);
 	}
 
+	mutex_unlock(&nt->link_event_lock);
 	return;
 
 out1:
@@ -1132,10 +1141,13 @@ static void ntb_transport_link_work(struct work_struct *work)
 		ntb_free_mw(nt, i);
 
 	/* if there's an actual failure, we should just bail */
-	if (rc < 0)
+	if (rc < 0) {
+		mutex_unlock(&nt->link_event_lock);
 		return;
+	}
 
 out:
+	mutex_unlock(&nt->link_event_lock);
 	if (ntb_link_is_up(ndev, NULL, NULL) == 1)
 		schedule_delayed_work(&nt->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
-- 
2.34.1


