Return-Path: <linux-kernel+bounces-897882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA9DC53E24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD3024F45E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA15346A1B;
	Wed, 12 Nov 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr1c12lk"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3C33B6E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971008; cv=none; b=fPfM/uEShh320m2rv3l040McLh3lIx2kzLD1bxVQnjFAI/laTUsfk24FQf/Lv/tUuTxO4XjPw186xBGmY2hx3D7xuSvC91ymB21anwhmTM90208Jz9poWXZ0+w7KiFGlc2BdJymR53S5iol5RmwQNSpfIIxD5L6nc4THq8isL88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971008; c=relaxed/simple;
	bh=6/ankDnvpOn83+FzQq2TH/FDKkX/T7hWx8Z+bYm5gXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=batxZUtNUguYKiXuvqAJXc5p+6LC6FsJklAUL6f1v4RaL2k/f/MZI0DOp0YVXZ9WkI5YvosOH81mdJwUPnl49wXtwcAqQlTXzrnlhoR5DrFoNQk6sJnhUDuRqayigpx7PB6qQw0X1FcgL0c0HuvmpJnn4Ab0Znc3BB1bbSM6oFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr1c12lk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b31507ed8so963216f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762971004; x=1763575804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+wmjDICqkhyxIMt0aSqRBiqskV13ZNchnqRu1NgOCBA=;
        b=gr1c12lk13rYGJXGvTD6S7lHc1wgdEWD+gmKNJVCXd7PEljTdoU3CZfL50AEky6XD0
         XHOzEDz0qBKfp4KPsd1gN0+esj0uDkFEa8eEdRXVG3zkR0h8kFj+ikNZclg2jGUEjXwY
         GlUQysXGIADBbv4r9cOLfBvVNxiimYfCyDf/OOwfOlxZiRxerUi2606faTahhzBU+Kw2
         QNsos+ZkF54QRxXsVXCgBfwv7E1BMRPb3J2AGD3EuDiHZPwA82AmE1BKrpVP+DaxIhDW
         OUN1y9JIrOpful67lQBL427oSzThP94jgFD83kNB/FstT9uvjL+cmdu98xSQK9Pj3ZWr
         O3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971004; x=1763575804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wmjDICqkhyxIMt0aSqRBiqskV13ZNchnqRu1NgOCBA=;
        b=wzQcO3H9vp583RqAjvLJacCawfweTNSqkEdinxbKXwQ0OyyMu0R8qPNyGNKIu9bVr+
         2AutjyUb1P7/BRKtcHZsA5K8v/AREzdwCEhn9XZ17JZHOLc6Y2ED0rSTfc6NMffQTekI
         uLO9oUKgbtK5BPz3W6SbMrcBdmRiqjZMT0uugbj+8l6a7pnJ64OdP32evzh7FDF8qyI7
         Vl4Fckfpv98m4WGmAcZj2/lY2/xcD8Sq2+Cfi70vEmyTI8A4h5AeunTGdkgFpRmzeO25
         nK9nshi+ZZtAIDgsRxj8uLlgwF21QPDUJ8eXGmCU46e4XRSvf8B+TTn9NROwd0mrtiVR
         bqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm+UUkmmdPme0+ppcTKBgyagvM9ylVUbuPYQYuf5uuPDPMQSx3wYhfy3IngRnsNQaimXCD7/ZHJdNPYzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9sIYeMhW6nCqWqsU+YsI02J0WduH8G3U9Iow3GG8Me0oG6xa
	6XEW/amRAypQUdZmnGWZTSgcKOVnH3sczvk+atX3xIR7UM602K9h2GCk
X-Gm-Gg: ASbGncv8chuDHtBc1W6QDUWSIV+85jhrLj5L85AJsRPPXF0usq2Qs8Nq0dZ9L5t9RJr
	esxyuduK+NVpsobu92lSrqG5jpYI8ffXTv42rRR7c6fkN6mUf73340v151iVbC1/0ZiW6kMNdLF
	CvbWG33pqrPTncYbGr/NlltYLOJ6/TYfhu8tLI1DF5yXBN7sDylLTxL1uZhvvHPTfh8/flQpkYM
	I3C9j2ZBW5tWgDNbSkKYxvinv3nreOsN4Lmf9dd+EcdwJgU7F8kPtiVNbNHiLzIO3CpKywfRUCA
	Ijg/9MzkKBpKcApbeE9MzOeI4fillDnDhLNyCvgsj7O9mzdgtdF31bciypg8P3kkFc/MR80J5MZ
	UogTGGRf1Q1tqiHeeBXaWJyq41AMUzEsscEbIttnCbCsCZPM6SvdULiiSk93cXZplqpMeHyAZsH
	tKqD4crVZ/
X-Google-Smtp-Source: AGHT+IHmLYMewd+jrcBOIghWYuI807eXIKJk+kmG2/2leMrzxIPaH8dVJ+dwD4fAdrXHIOtYKYxcMA==
X-Received: by 2002:a05:6000:430e:b0:427:813:6a52 with SMTP id ffacd0b85a97d-42b4bdaeeeemr3474839f8f.41.1762971003404;
        Wed, 12 Nov 2025 10:10:03 -0800 (PST)
Received: from pc.. ([105.163.156.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm36139163f8f.40.2025.11.12.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:10:02 -0800 (PST)
From: Erick Karanja <karanja99erick@gmail.com>
To: mripard@kernel.org,
	dave.stevenson@raspberrypi.com
Cc: mcanal@igalia.com,
	kernel-list@raspberrypi.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH v2] drm/vc4: Replace lock/unlock pattern to use guard
Date: Wed, 12 Nov 2025 21:09:55 +0300
Message-ID: <20251112180955.145567-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual lock/unlock patterns with guard.
This simplifies the code.

Generated-by: Coccinelle SmPL
Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

changes in v2:
	- Indent comments correctly
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 49 ++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index bb09df5000bd..39815b2f6e2d 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -130,17 +130,15 @@ vc4_v3d_pm_get(struct vc4_dev *vc4)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return -ENODEV;
 
-	mutex_lock(&vc4->power_lock);
+	guard(mutex)(&vc4->power_lock);
 	if (vc4->power_refcount++ == 0) {
 		int ret = pm_runtime_get_sync(&vc4->v3d->pdev->dev);
 
 		if (ret < 0) {
 			vc4->power_refcount--;
-			mutex_unlock(&vc4->power_lock);
 			return ret;
 		}
 	}
-	mutex_unlock(&vc4->power_lock);
 
 	return 0;
 }
@@ -151,12 +149,11 @@ vc4_v3d_pm_put(struct vc4_dev *vc4)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
 
-	mutex_lock(&vc4->power_lock);
+	guard(mutex)(&vc4->power_lock);
 	if (--vc4->power_refcount == 0) {
 		pm_runtime_mark_last_busy(&vc4->v3d->pdev->dev);
 		pm_runtime_put_autosuspend(&vc4->v3d->pdev->dev);
 	}
-	mutex_unlock(&vc4->power_lock);
 }
 
 static void vc4_v3d_init_hw(struct drm_device *dev)
@@ -173,7 +170,6 @@ static void vc4_v3d_init_hw(struct drm_device *dev)
 int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
 {
 	struct drm_device *dev = &vc4->base;
-	unsigned long irqflags;
 	int slot;
 	uint64_t seqno = 0;
 	struct vc4_exec_info *exec;
@@ -182,23 +178,22 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
 		return -ENODEV;
 
 try_again:
-	spin_lock_irqsave(&vc4->job_lock, irqflags);
-	slot = ffs(~vc4->bin_alloc_used);
-	if (slot != 0) {
-		/* Switch from ffs() bit index to a 0-based index. */
-		slot--;
-		vc4->bin_alloc_used |= BIT(slot);
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		return slot;
-	}
+	scoped_guard (spinlock_irqsave, &vc4->job_lock) {
+		slot = ffs(~vc4->bin_alloc_used);
+		if (slot != 0) {
+			/* Switch from ffs() bit index to a 0-based index. */
+			slot--;
+			vc4->bin_alloc_used |= BIT(slot);
+			return slot;
+		}
 
-	/* Couldn't find an open slot.  Wait for render to complete
-	 * and try again.
-	 */
-	exec = vc4_last_render_job(vc4);
-	if (exec)
-		seqno = exec->seqno;
-	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+		/* Couldn't find an open slot.  Wait for render to complete
+		 * and try again.
+		 */
+		exec = vc4_last_render_job(vc4);
+		if (exec)
+			seqno = exec->seqno;
+	}
 
 	if (seqno) {
 		int ret = vc4_wait_for_seqno(dev, seqno, ~0ull, true);
@@ -328,10 +323,10 @@ int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return -ENODEV;
 
-	mutex_lock(&vc4->bin_bo_lock);
+	guard(mutex)(&vc4->bin_bo_lock);
 
 	if (used && *used)
-		goto complete;
+		return ret;
 
 	if (vc4->bin_bo)
 		kref_get(&vc4->bin_bo_kref);
@@ -341,9 +336,6 @@ int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used)
 	if (ret == 0 && used)
 		*used = true;
 
-complete:
-	mutex_unlock(&vc4->bin_bo_lock);
-
 	return ret;
 }
 
@@ -363,9 +355,8 @@ void vc4_v3d_bin_bo_put(struct vc4_dev *vc4)
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return;
 
-	mutex_lock(&vc4->bin_bo_lock);
+	guard(mutex)(&vc4->bin_bo_lock);
 	kref_put(&vc4->bin_bo_kref, bin_bo_release);
-	mutex_unlock(&vc4->bin_bo_lock);
 }
 
 #ifdef CONFIG_PM
-- 
2.43.0


