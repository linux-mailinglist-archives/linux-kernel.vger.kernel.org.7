Return-Path: <linux-kernel+bounces-764135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA73DB21E78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885751A236AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A568228D830;
	Tue, 12 Aug 2025 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GPamlzTc"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79521FF46
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980639; cv=none; b=gmykmZ9fYIdQetnECImjIWktLaID9nx7zCSLbvx9JOk1WiTSHNM0dVzYq9FpUBvpIZ2EyPxpvRv2rFzrxPmA2QSF5GEFS3HtHyHb1sSiD6jH3PAIJ0PnEE+8itwAqEp8eZTkO1cQM2wKGWc143YtYTKMo9nTeKsfT/vuF8rbHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980639; c=relaxed/simple;
	bh=mYiBVXAo93QnGQS5BptwWusIUvuqnLn8pdDv8oIL01c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hudCyUdmKgydYoQUK9k+OVREWmSM+6VNQr762MB58p0XpbeM5PwY30aJv4i/hCkTCNs/QxM3OZLvynjkz3aquv+fTL+qYLXDm+U0nfHm3thcoJkUmL47JlTG/Z1yNT3I/ppKQgefnaeRZxloH2SDBOuRagphA6tWBWFlyfftHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GPamlzTc; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3e539f3fbaaso22568245ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754980637; x=1755585437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vnf9J8D/lbhMrAAVySeXBqauE+p5C7GABrpw1C+CN+M=;
        b=dqwKQqlGLYZWcyIh/Ai8IxJJ1pzLGUtNE6mMVH1qZEpoB300+umb/uAFihI3ukk3mT
         FQ7GqOfOa7NhPaARIM+9S8Uhvttce/q31KImOJtbzveiUwad0F393qqGHI29WJ8KoFX8
         f8kTXBnOpNggoXpj3LPirPAirDOl3ApLkKcEcKRVyCsrEuvkTcXMGsEx2iSUVO5JQusE
         0IgyAbV6nQrRn48STqH5fMwSG7Nrj4vHRH9mnoeR43Ts4VVdFvVZHtqJ0AKKgIFG6TZg
         IW4s7chvbUlOhC/u4sFgwdcSvC5t/Slv0WSPQ/f+whJs9CeOUogQ4xBkXDtaZ4h4mLa2
         I+nw==
X-Forwarded-Encrypted: i=1; AJvYcCWvUz0r5VBU1aHKK/LFJFlnH9nTvBJqfShRFgMfL7ACSNVAf4tHo8NQF1X8/pYbjPO4F3zkgVXObJu8M1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy07+luV0j/IRNQFnoLX28nNS0viAVMBOrRVmnnfjcglCtko8sS
	keAZjwfxFsURLmxfnzg+3sh5q6HUcASZXe1loMrJ2bqcGV9vmXhFe8MPVO9oy7/xSNaiGQgHAAK
	mgfZAga4SUazaAm8J3Cm+/tDiaSQR5pZm03dhLSLYLKEntIMWS+UhaBgV7Yrb2Q5J9GiDOD0LLG
	Nt1hkKRepOyw2Vnevxnbx+m5ZGuInqbjocYnNlEiRfNa4MjlfiUrOJzMkp9/siuv8cmVuAb9OQq
	vGm4486KH6kXTCupVPnshKp0g==
X-Gm-Gg: ASbGncse9yElNMe0GjoPIoRTdHx173PuN0q8F9IhhC12hulG0tKsBXMp81Cam1ypU07
	1TBt8C5i7S+ppxBEA3T+ZJWceU/cQyT+QXvkP7VFZo6huc1baLS1RAlG8DykmehB24T8B8fDcqw
	f1pSB6Eeot4nywnHd/HKLxBp6UoMtcXl0weJ/gG3zD1vucDArB+6pIDQtfqjh0ns2izc5zoKhmZ
	1TV2mPkIHE+xj1VHi5n+A524aGzKPnLKy8nivV6+Lw8HfTLpZzE9UG6SmIiu5dSmCYq/JwXHqgr
	UIq2xp1pa8JyYdVqcFPZyT2jkdB8dta4YtrmKTjJ66YeTWOKJ0j3ZCuYZ7kDGdSR17tQKZuGfJy
	eGkWCCU2yY9moBc3glpRF4yK24YB9pq4KCD9PR/G92cEUg/PhBv/X71TsxZnFDxFCRhcPy+jv46
	sx
X-Google-Smtp-Source: AGHT+IE6JSeQ46rz6AQtQZXJWwYEW0O8MT9BCFtim3AtQwGxo70eRvCsUV1a6kcuHbaizw8QpikPgaF5Xpr6
X-Received: by 2002:a92:cd89:0:b0:3e2:99c3:47c8 with SMTP id e9e14a558f8ab-3e53315da3amr229345055ab.17.1754980636707;
        Mon, 11 Aug 2025 23:37:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e559a64d0asm1572825ab.3.2025.08.11.23.37.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:37:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0791a8e8dso144877341cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754980635; x=1755585435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vnf9J8D/lbhMrAAVySeXBqauE+p5C7GABrpw1C+CN+M=;
        b=GPamlzTcichAUm85LGJQbNiAuJ9qGOl/6KPcke5zGApE4TlmcaYtLNF6bz0cvsPB00
         JiOGxreDqCa/98DhRREJ2kBe71XvpITpgBZ/P/cYcmbGSkqYLIOgeH9L4VuQoSMaW8BS
         sAk8akiRNWE94yl/Fd9YBj1nSVRHaBArrjOSk=
X-Forwarded-Encrypted: i=1; AJvYcCVP5x01ZbKR4/dKP4Y/lMu4d4f5/l5DV4eUjkRrAUZMrQHNu9vWo2nayhI90uZ05EvjdTW8uhKlLXK8mqY=@vger.kernel.org
X-Received: by 2002:a05:622a:3c7:b0:4b0:641a:ddde with SMTP id d75a77b69052e-4b0aed86506mr214214011cf.59.1754980635085;
        Mon, 11 Aug 2025 23:37:15 -0700 (PDT)
X-Received: by 2002:a05:622a:3c7:b0:4b0:641a:ddde with SMTP id d75a77b69052e-4b0aed86506mr214213721cf.59.1754980634597;
        Mon, 11 Aug 2025 23:37:14 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b095e6c7d4sm85319621cf.54.2025.08.11.23.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:37:14 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	mario.limonciello@amd.com,
	sunil.khatri@amd.com,
	srinivasan.shanmugam@amd.com,
	siqueira@igalia.com,
	cesun102@amd.com,
	linux@treblig.org,
	zhangzekun11@huawei.com,
	andrey.grodzovsky@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Guchun Chen <guchun.chen@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] drm/amdgpu: handle the case of pci_channel_io_frozen only in amdgpu_pci_resume
Date: Mon, 11 Aug 2025 23:23:49 -0700
Message-Id: <20250812062349.149549-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit 248b061689a40f4fed05252ee2c89f87cf26d7d8 ]

In current code, when a PCI error state pci_channel_io_normal is detectd,
it will report PCI_ERS_RESULT_CAN_RECOVER status to PCI driver, and PCI
driver will continue the execution of PCI resume callback report_resume by
pci_walk_bridge, and the callback will go into amdgpu_pci_resume
finally, where write lock is releasd unconditionally without acquiring
such lock first. In this case, a deadlock will happen when other threads
start to acquire the read lock.

To fix this, add a member in amdgpu_device strucutre to cache
pci_channel_state, and only continue the execution in amdgpu_pci_resume
when it's pci_channel_io_frozen.

Fixes: c9a6b82f45e2 ("drm/amdgpu: Implement DPC recovery")
Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ff5555353eb4..683bbefc39c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -997,6 +997,7 @@ struct amdgpu_device {
 
 	bool                            in_pci_err_recovery;
 	struct pci_saved_state          *pci_state;
+	pci_channel_state_t		pci_channel_state;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 40d2f0ed1c75..8efd3ee2621f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4944,6 +4944,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	adev->pci_channel_state = state;
+
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
@@ -5079,6 +5081,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
 	DRM_INFO("PCI error: resume callback!!\n");
 
+	/* Only continue execution for the case of pci_channel_io_frozen */
+	if (adev->pci_channel_state != pci_channel_io_frozen)
+		return;
+
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-- 
2.40.4


