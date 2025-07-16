Return-Path: <linux-kernel+bounces-732716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCDB06B27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED0D4E3C44
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405471C700D;
	Wed, 16 Jul 2025 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jk9GEnH+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3B2F50
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629477; cv=none; b=Nzu4/cjZRZZ3fmodp4aX8zxsIVCNfD5oUOtq5mAcLiOF0XIKPsOuY37wQrOAUhapA3zbYP33xqZ7AfQBo5k7+XClHoK4TEMojEOTjYmkYV4BqrY+FlZufNlSAQsEOA1QCbNowhUnFPcmevZ/Aqj3aeQpkhnkQW1p+aAA7H/hvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629477; c=relaxed/simple;
	bh=73V/RlOBiweuktnv1eka8wk64sIXg6PJqACWxRcmXCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lgi3Ur7oM/BIuBMAMmdXhABXlNrr7W7VkOQdcK3sM9x+NK2e4BYuSMbcR30imZXEQaJSMlhbGplQomOslO3Db7FhrCk09qafxTheeYdYF7CeEol9GA/3Op+7MOaOu43M6ECtZe+VBMVPmhzZXsFvJagn5edmegxmzBlj1B2OPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jk9GEnH+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23507382e64so61226545ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752629475; x=1753234275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/bynpCs2Tw7cfiBo3vM7e1zV+l08DPmNuREEbJrQdE=;
        b=jk9GEnH+nLE2mqyD3dkNoSoTAhoUT1OtzwFmkK5bO8Pm9LZJ8y0wQ+GhfgxgL3Jqiq
         8KzPckc8dWG9CY0T0K7hO4FuT+UIVdAqU5qlq1HfxREZGGkUknuuopppiATmPsgzy6P1
         ISbQHcsnll98ZJ3e81VniK8XPe0fqa3TtmPAoF0QTuCaeT0f7YoikrBimGtkaodyqHK/
         js6JYLMOatXYITOgBG/0QwaLXTuFAXocVrfOlo1tRToeSzhhaZgnLVOenCLw1MOLZG5Z
         XS/qg86uebU3YBEP5oDsS0O+Pe9OqMMRIquRRnrhRkNQiA6W4c0/tRX+2BxCaJxk8Lka
         TkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752629475; x=1753234275;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/bynpCs2Tw7cfiBo3vM7e1zV+l08DPmNuREEbJrQdE=;
        b=n8aJEnbhR7+lT7yqfrbtIO0dGfmmCC3YrndW7sVPn/3AIceJEP14jL2/flISKwJDzu
         enGJY5zcl3NrAGt0XBuz7KFHwORQSPgr54Z39ydt4XyTjbKV0i00kbg3zpnlP+dsf0+W
         tcEVizHL/gTiD4N5cQcY5qt0sfO/Gwpje3GupYbbzTyLWWWIPKuB6vbN4x52mdBZlbwJ
         hqWKPtfgbzrm4OHj8vlt3ILedGTg3SapE1YcJIBVJf3T11NVlIOww949iJnk77eOBRrF
         wf5dbc/5Fdydbe8MiSn6MBAVr0Ho7pmZL5GSbOrNHfKmqLF2+bsohOi7crixCLSbnYRk
         Z7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm0EryLxCrei8FIPKHI4kntuSn4Zv7Qi/Tr6zaDpnbUolZCSPGYMnLw7k9MQUyfAG80fPCcI1of2ihPdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nlUK3bTsl+B2kMdXCAKf1mLGDF1MGwX82NJNcga55r5qCl0f
	mZ9+GqHA8vclncpdktXoaKij7Q2WCBiUzTeLfhgLWaQdLAHyz/ZyD0Nre+3d4SzzdUIqPAZ7ybD
	Kf8q2bV8G9rUyrgnNpTGqqEsV7g==
X-Google-Smtp-Source: AGHT+IHAz2N0p2NM1zIRzM7XyR7ZyyTnOFv8dVXQ9TyaWXhO7LBHk0tVSGg+5/wDKo04VRUwt6H8Hx9UYAA8jcoIfw==
X-Received: from pjbtc15.prod.google.com ([2002:a17:90b:540f:b0:31c:2fe4:33b4])
 (user=salomondush job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e885:b0:235:7c6:ebc2 with SMTP id d9443c01a7336-23e2566b063mr10618185ad.4.1752629475352;
 Tue, 15 Jul 2025 18:31:15 -0700 (PDT)
Date: Wed, 16 Jul 2025 01:31:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716013103.1571029-1-salomondush@google.com>
Subject: [PATCH] scsi: mpi3mr: Emit uevent on controller diagnostic fault
From: Salomon Dushimirimana <salomondush@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Salomon Dushimirimana <salomondush@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduces a uevent mechanism to notify userspace when the controller
undergoes a reset due to a diagnostic fault. A new function,
mpi3mr_fault_event_emit(), is added and called from the reset path. This
function filters for a diagnostic fault type
(MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT) and generates a uevent
containing details about the event:

- DRIVER: mpi3mr in this case
- HBA_NUM: scsi host id
- EVENT_TYPE: indicates fatal error
- RESET_TYPE: type of reset that has occurred
- RESET_REASON: specific reason for the reset

This will allow userspace tools to subscribe to these events and take
appropriate action.

Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 42 +++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 1d7901a8f0e40..9c90569754305 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1623,6 +1623,47 @@ static inline void mpi3mr_set_diagsave(struct mpi3mr_ioc *mrioc)
 	writel(ioc_config, &mrioc->sysif_regs->ioc_configuration);
 }
 
+/**
+ * mpi3mr_fault_uevent_emit - Emit a uevent for a controller diagnostic fault
+ * @mrioc: Pointer to the mpi3mr_ioc structure for the controller instance
+ * @reset_type: The type of reset that has occurred
+ * @reset_reason: The specific reason code for the reset
+ *
+ * This function is invoked when the controller undergoes a reset. It specifically
+ * filters for MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT) and ignores other
+ * reset types, such as soft resets.
+ */
+static void mpi3mr_fault_uevent_emit(struct mpi3mr_ioc *mrioc, u16 reset_type,
+	u16 reset_reason)
+{
+	struct kobj_uevent_env *env;
+
+	if (reset_type != MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT)
+		return;
+
+	ioc_info(mrioc, "emitting fault exception uevent");
+
+	env = kzalloc(sizeof(struct kobj_uevent_env), GFP_KERNEL);
+	if (!env)
+		return;
+
+	if (add_uevent_var(env, "DRIVER=%s", mrioc->driver_name))
+		goto exit;
+	if (add_uevent_var(env, "HBA_NUM=%u", mrioc->id))
+		goto exit;
+	if (add_uevent_var(env, "EVENT_TYPE=FATAL_ERROR"))
+		goto exit;
+	if (add_uevent_var(env, "RESET_TYPE=%s", mpi3mr_reset_type_name(reset_type)))
+		goto exit;
+	if (add_uevent_var(env, "RESET_REASON=%s", mpi3mr_reset_rc_name(reset_reason)))
+		goto exit;
+
+	kobject_uevent_env(&mrioc->shost->shost_gendev.kobj, KOBJ_CHANGE, env->envp);
+
+exit:
+	kfree(env);
+}
+
 /**
  * mpi3mr_issue_reset - Issue reset to the controller
  * @mrioc: Adapter reference
@@ -1741,6 +1782,7 @@ static int mpi3mr_issue_reset(struct mpi3mr_ioc *mrioc, u16 reset_type,
 	    ioc_config);
 	if (retval)
 		mrioc->unrecoverable = 1;
+	mpi3mr_fault_uevent_emit(mrioc, reset_type, reset_reason);
 	return retval;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


