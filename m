Return-Path: <linux-kernel+bounces-896715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB19C510A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE0C54F1B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2722C08C2;
	Wed, 12 Nov 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLwUr/eU"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36191E492A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934554; cv=none; b=oNkWa9cApglgynzwRWl+KB/8wQS+EGno3gGOvunYeP25x+fydnKrqrN+1Jng+6aNTskg/ibsL7Yqj0tP1HVgAo/K3p0tTxppadM1+c9DkpWoDZkVs+bjsg4ywKZgtJZBqd4DIVTVddcB61drM0AInpKynMyvM/NqxWjbeNZjJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934554; c=relaxed/simple;
	bh=vddPXFfo1J7kmKsDkCwFm7XrCGCGDU29NCTugLPyq54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiRx8ASUh/zNp7e8jaEDSK+5g9exg+SlYs8TUBye7iVX1hPbW/I3Fea+tPmNlSLWUQGVKTlJxvvFjqmH5s7fucwmNiL8bMDm8KktHt0/oAEO/1mf1gn+z05NwPdApXpbs5udUpS64x0v5wCQXDW2J4kUJz5T7H7xau999OSWpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLwUr/eU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so852947a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762934551; x=1763539351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1vSzWoIsU/LU/7nkUUUbQ83OoHkgHR/WVO8I+WEFiQ=;
        b=PLwUr/eUTcBP0NWsQCmPEfy7jJAug6sWqE4pGTL7ube+fhNVrL8l2WG4tjGOQ1p8bh
         Vg9alfY9l6tGWtbDGq8BAv3T5I7ZJ/TxjEWWcQG+zvVplfFuNbAJkaJ2+bXW3LoAe/Wu
         WclZA1h2R6XN9IuKT8vXFyT4sTPukg0u7sNI2snYG6/gv5vn1Gzj/fOFvjCZePY5W/7i
         UOo/0mVzLdKUkuJ7vjCgB8CRJwvnePyyhyS7X0i/H64NR0fNobgXZpSxfAScmXVb3teb
         nR3/iSBDdBsYdZ9sJSIk4lA/1mgKbQb9O+7khK9yeF5b9AIO2WdyJUbV4GQnXw93Av+1
         vA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762934551; x=1763539351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1vSzWoIsU/LU/7nkUUUbQ83OoHkgHR/WVO8I+WEFiQ=;
        b=V5yI/6f7xhkEsAGfp+WqiPK81LyWLeCqvTz41aT3tjrFKqnWAcrsLNch9BQwxBChZW
         9H7M0D70+YFyZFgOT5AXl2jfRB5SwH/sPmV6USbiBLm3xfKHwUG216pH77SGhso/in3i
         YNlOYgmwMHPUIUf/3LxWUhvODtr9LPuh6qSMyS302QBhm3x85zYGFvWp4V1ouDOoe6SN
         UvGPks8KFR859Ve2TMogoDIRyJ3gvQ7OwHGxRjyvjKNpaxesjtjcKCbC7R89m2621hq/
         pH+x8q+bbinEVTnVDoZVBbyiX70bb+3LyS+FUI/DBJf0Z4A3WUGPrcbbbnvVaCdBstz1
         enQw==
X-Forwarded-Encrypted: i=1; AJvYcCUBjphOaF/8j26dy9v24nw0MFcEUSo0ALUqbGDTBqcGAY4W1c/1GZgDPeak3auZSncmreTMzZgwM+IORAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmcJm/R87dRK5Ocvm9qAUdvnUdy/C4R/fTq42Ri/AzmEPgr+u
	xxUYOpbFaY2CiKJlBQ8OvY0rtw6bUok5SGIXCR7wkZRhXmajacPJZimo
X-Gm-Gg: ASbGncvpMU18/uDMHVQqHMnrXvJETdL2hj7VRgbPQlg9tfq/9r3pyhZpAEAUFBpmXgp
	zZlVVNh6/0H+Vb6mEnorxpAkhLX7paF5e0uAPoQZ+ylaKuLZqZigSUDpb3No6U3HXDgT7AIgJEB
	3MAX8ROnY/ISPY32yMU4CToUA4tO/zefYQJ4w7CgVb7rPOCQcEbyrGduqJ9H/uWQfZluI8V2x2O
	EvQvFwWOL2vvOuhET4mMwPMGntMAFylx5HTjEneEyc/0gs3CPcRhIfi2xPdOQ+B0G4YCNy6Zudw
	A0dWTkgvP+eeqV0Q+BJgM4tLwDYgczsuO+TY5Vl2PnQUxX0ufSSAU+jiTTFgr4jM3VMC1NcYjDl
	KhCbtdLNZo8RhC5OwgI4vmPw/v5d07+fBc40FWbfdphtZMUEiRdnLOP5JyuFTr1N2kG3nWFo=
X-Google-Smtp-Source: AGHT+IH4ZMrWaoefx3L7WnsU9NJXJjf/H4U0hsMcEo73wphLyQhueMcVj/mEqHE3McBEcd+WIQvBUg==
X-Received: by 2002:a17:907:7285:b0:b46:31be:e8fe with SMTP id a640c23a62f3a-b7331973fb1mr219408666b.11.1762934550973;
        Wed, 12 Nov 2025 00:02:30 -0800 (PST)
Received: from pc.. ([41.209.14.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc83asm1515992366b.51.2025.11.12.00.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:02:30 -0800 (PST)
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
Subject: [PATCH] drm/vc4: Replace lock/unlock pattern to use guard
Date: Wed, 12 Nov 2025 11:02:20 +0300
Message-ID: <20251112080220.223318-1-karanja99erick@gmail.com>
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
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 45 ++++++++++++++---------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index bb09df5000bd..8271a6610d6e 100644
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
+		/* Couldn't find an open slot.  Wait for render to complete
 	 * and try again.
 	 */
-	exec = vc4_last_render_job(vc4);
-	if (exec)
-		seqno = exec->seqno;
-	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
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


