Return-Path: <linux-kernel+bounces-896583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE491C50B79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C10184E2CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23162D73BB;
	Wed, 12 Nov 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oK18Bzq9"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739602D73A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929186; cv=none; b=Rl5+uUvPategbk4l5jflB8bEj0JsMyFvv5dz+eXs3m9jeAO3hBjt/mZaVwPHKT5NdA9ijyoRE4FQYu8GR7iElm5DksEhBXuS3BErs+7f957Ufcnsq/9aSvp9OjaUAAJYNdgiguYH2lQV5UTeLJZj+/qA72+MON1jVy11J38SfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929186; c=relaxed/simple;
	bh=Cw/W9CyuYpuZLvXAU9J3ai0lpSgJef+6FDu5Ex6zTrg=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=ePLzFnmeyUJ2HHzynQUgP97cuClXyoRn5wtO6hTconhPYf/XQHrTWhrdcUptP3YZpiXFEbZwr063kdBaCEsueppIWgz51z9PKLl4vNI9CEqL2MKPPICL3+7KIj3CAmv585Lz/aRPJBaDKuek5xm5vqatwsHlqqnn313uwyWLD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--powenkao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oK18Bzq9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--powenkao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297d50cd8c4so12143035ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762929185; x=1763533985; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cNIqEapCp4oN2w7WnRx0ObGqxT09Vga2okdYEcb4q94=;
        b=oK18Bzq9RRjXUlKATZooOcws999OSeiGuoDndB+9R1ocGd36BL5voCOOq83In35In6
         thuAIF6Jwne4MmhHeTmVZYPaEjqqjgHzMn4vagXGnkeJLwpklrQ55Di9BFCLrDAXLXvP
         6b2rjHT6LN/pieuVSi1oBiqk+bkYXT4tQuLddtqhgH6bsPy29c6MNxLLyhP5E0VSgVsO
         kjsPrC7gK9RUDOVIYlhN+mEUXY1PxH/pdNSHlA2iJQbrbf5u37URfbqDucLvLmyQ2ERi
         6DlOXb/4XMHFaHPdRUmq2CRs4vAFJP4ty5LCwaXEPeK8SECVtZaaDsKRUv2pL2/1GHJ5
         Fy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762929185; x=1763533985;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNIqEapCp4oN2w7WnRx0ObGqxT09Vga2okdYEcb4q94=;
        b=oL62hX6qqrnvaoXEJ/A3BcU8SMSzUUcPdV44B99vOvB2hCZfchJ63yXL5elUZkDo9/
         vleWkGSN74eawVIqm1nlBcJ9AUnZZ6Di/H3uClAgPytLfV3/WOir/dbrH29pK0Oy/T1C
         QWXg52EjumqunepaLcPoERNNk1hrhi6WvkuDNP3cA3Mqjx4LF393ukR3eFCBgBVZKdnC
         NoiLidBfejph8Yv0fEk6xyNhZadEg0M3YKRBjcVrGauLD7At3sT0Y+qUWqJY14tQ49wR
         gYwoNdWWXtQZZ82dzSNX9Y7irWaAszRq7jKBblB1J+HAK1IN17Kc+xK5WR0Nya5kcUAE
         uoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/xJTEPmw3Qpw2yCRBA34F8KKnsI6jo4ZPMUbi+vehTvMSYpmNLYeba21I33zCKCy3K1j8sobO9YOI6WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYq0wYqhSwgxlGA/fJvTFeaY5oj5bFpYnyJs/VUWCZxAR6OWdM
	WNhUtpv8wLhvTFhAVCYpT4vegsVX//j3sEcKNFNZDByM+zogtWE9FMjfTtc+WPznk0yDiV9x93y
	JtSSV8riHeQPaiA==
X-Google-Smtp-Source: AGHT+IE+1PQbQCK5w3kPAD89sgfjYeOI3cDhEHBRfHdP1rOJCTJurTa9E4fGRbFCWFXAzzb3hcUMl+2A8+O2wQ==
X-Received: from plxe3.prod.google.com ([2002:a17:902:ef43:b0:298:33c9:abd5])
 (user=powenkao job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a30:b0:290:b53b:7456 with SMTP id d9443c01a7336-2984ed34347mr24804745ad.5.1762929184258;
 Tue, 11 Nov 2025 22:33:04 -0800 (PST)
Date: Wed, 12 Nov 2025 06:32:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112063214.1195761-1-powenkao@google.com>
Subject: [PATCH 1/1] scsi: ufs: core: Fix EH failure after wlun resume error
From: Po-Wen Kao <powenkao@google.com>
Cc: Brian Kao <powenkao@google.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Peter Wang <peter.wang@mediatek.com>, 
	Bean Huo <beanhuo@micron.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" <linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Brian Kao <powenkao@google.com>

When a W-LUN resume fails, its parent devices in the SCSI hierarchy,
including the scsi_target, may be runtime suspended. Subsequently, the
error handler in ufshcd_recover_pm_error() fails to set the W-LUN
device back to active because the parent target is not active.
This results in the following errors:

  google-ufshcd 3c2d0000.ufs: ufshcd_err_handler started; HBA state eh_fatal; ...
  ufs_device_wlun 0:0:0:49488: START_STOP failed for power mode: 1, result 40000
  ufs_device_wlun 0:0:0:49488: ufshcd_wl_runtime_resume failed: -5
  ...
  ufs_device_wlun 0:0:0:49488: runtime PM trying to activate child device 0:0:0:49488 but parent (target0:0:0) is not active

This patch addresses this by:

1.  Ensuring the W-LUN's parent scsi_target is runtime resumed before
attempting to set the W-LUN to active within ufshcd_recover_pm_error().
2.  Explicitly checking for power.runtime_error on the HBA and W-LUN
devices before calling pm_runtime_set_active() to clear the error state.
3.  Adding pm_runtime_get_sync(hba->dev) in
ufshcd_err_handling_prepare() to ensure the HBA itself
is active during error recovery, even if a child device resume failed.

These changes ensure the device power states are managed correctly
during error recovery.

Signed-off-by: Brian Kao <powenkao@google.com>
Tested-by: Brian Kao <powenkao@google.com>
---
 drivers/ufs/core/ufshcd.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index fc4d1b6576dc..9176d7ce25b4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6504,6 +6504,11 @@ static void ufshcd_clk_scaling_suspend(struct ufs_hba *hba, bool suspend)
 
 static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 {
+	/*
+	 * A WLUN resume failure could potentially lead to the HBA being
+	 * runtime suspended, so take an extra reference on hba->dev.
+	 */
+	pm_runtime_get_sync(hba->dev);
 	ufshcd_rpm_get_sync(hba);
 	if (pm_runtime_status_suspended(&hba->ufs_device_wlun->sdev_gendev) ||
 	    hba->is_sys_suspended) {
@@ -6543,6 +6548,7 @@ static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
 	if (ufshcd_is_clkscaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, false);
 	ufshcd_rpm_put(hba);
+	pm_runtime_put(hba->dev);
 }
 
 static inline bool ufshcd_err_handling_should_stop(struct ufs_hba *hba)
@@ -6557,28 +6563,42 @@ static inline bool ufshcd_err_handling_should_stop(struct ufs_hba *hba)
 #ifdef CONFIG_PM
 static void ufshcd_recover_pm_error(struct ufs_hba *hba)
 {
+	struct scsi_target *starget = hba->ufs_device_wlun->sdev_target;
 	struct Scsi_Host *shost = hba->host;
 	struct scsi_device *sdev;
 	struct request_queue *q;
-	int ret;
+	bool resume_sdev_queues = false;
 
 	hba->is_sys_suspended = false;
+
 	/*
-	 * Set RPM status of wlun device to RPM_ACTIVE,
-	 * this also clears its runtime error.
+	 * Ensure the parent's error status is cleared before proceeding
+	 * to the child, as the parent must be active to activate the child.
 	 */
-	ret = pm_runtime_set_active(&hba->ufs_device_wlun->sdev_gendev);
+	if (hba->dev->power.runtime_error) {
+		/* hba->dev has no functional parent thus simplily set RPM_ACTIVE */
+		pm_runtime_set_active(hba->dev);
+		resume_sdev_queues = true;
+	}
+
+	if (hba->ufs_device_wlun->sdev_gendev.power.runtime_error) {
+		/*
+		 * starget, parent of wlun, might be suspended if wlun resume failed.
+		 * Make sure parent is resumed before set child (wlun) active.
+		 */
+		pm_runtime_get_sync(&starget->dev);
+		pm_runtime_set_active(&hba->ufs_device_wlun->sdev_gendev);
+		pm_runtime_put_sync(&starget->dev);
+		resume_sdev_queues = true;
+	}
 
-	/* hba device might have a runtime error otherwise */
-	if (ret)
-		ret = pm_runtime_set_active(hba->dev);
 	/*
 	 * If wlun device had runtime error, we also need to resume those
 	 * consumer scsi devices in case any of them has failed to be
 	 * resumed due to supplier runtime resume failure. This is to unblock
 	 * blk_queue_enter in case there are bios waiting inside it.
 	 */
-	if (!ret) {
+	if (resume_sdev_queues) {
 		shost_for_each_device(sdev, shost) {
 			q = sdev->request_queue;
 			if (q->dev && (q->rpm_status == RPM_SUSPENDED ||

base-commit: c53a741a7fd4b8e9d07acf1861b5e4a188c6585a
-- 
2.51.2.1041.gc1ab5b90ca-goog


