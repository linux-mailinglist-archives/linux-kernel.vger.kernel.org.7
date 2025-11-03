Return-Path: <linux-kernel+bounces-883288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A9C2CF86
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A71188D67F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CAE314A87;
	Mon,  3 Nov 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LKDkN57Y"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B44313E1E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185485; cv=none; b=FhWWwgvnGkNtupYpYFgyRPmoEIVJyTgL1n/V0zLXLIvu9uUSBoofP9xkg7rxhqxaF+/ATWbdK+Ca3jWyQdqFdZgMUgsI52iOqvCRw5nH0xdByxLdMaOacyzD02rZ2tQr7yaALiXa/UUVEOqVgDRIr/WLQ3DoYJZSH0NufaJ6bDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185485; c=relaxed/simple;
	bh=voKY2it8hqoGPUQsm3TwfCUdA3ifh1QfXobzOigoTfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdVqkC1OZpWC6F+YAtter/drgxovd6o0SykYPPF2j2kCwJVqwNScUYbZGEcVkorQ1M7TEAAvyaeyiTdsYwEBRH8R/nz9yU5Flo8qmOs/QFqRk09YCkfpNCMWZpEBYgVxY0WajHIm8I6coFGc0MkiIajMbik4YiU7Pvf7X78wgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LKDkN57Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso40078465e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762185480; x=1762790280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG7NrqQN35AJ0Wq7ouL8uMkG/dwt+C79zv693rtI1Go=;
        b=LKDkN57Y0X6RdW9RNEitylyvwsxoMeV1lO5JYrSJFRZU8X3fmpkPuo00p90rTzSGEJ
         M1MxOn+aSmrirzbTSySVlC+y11sIVlCnQrq4p7dyLaL8Z3rMiUGq5KS0qY26wCAoBGIa
         uZC15thH5suvr1LWDg6rR5fo7yzf0Gos75NphcdfKG36MZvEwg5k3IP8vm1kVAkq+TuR
         oNT/f3Iu2T7oaIoJPqOyI6twT59OUk2miAG1uz8Dr0dQVY/RR2ESisNbpwM2sn+0R+0l
         slokiy0/RmbqIrpgWf6A8T1oTkMvIeA32BDPOPG94JXHh+mJmz+9r/pb8QACEI5eMnDu
         zFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185480; x=1762790280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG7NrqQN35AJ0Wq7ouL8uMkG/dwt+C79zv693rtI1Go=;
        b=X8659B7fdmPRSYqVdVafW3EFKMIYRcDPXGBtyHG+AvKAUDTbmLrQ/a0MMRMwV+OLBg
         GxEsLkQCUgohFc5S4xKMNER79DtSFScKaWrLtQSYhA/TwiyXEmHMmtPga0octGCQyF6J
         tvx6QHMGwjky00ALFsb7igLvX5DQaiLZmNMFg1SkmrB8o1CzBvmqqi+I1di3wBdQzeMQ
         AiUx3CCqdsUksmYf5nFEthCRXTxBNSyOh9VcDd530EKcSJWd1Sm2zSPPNGgplnYDb/cW
         6lIvEvxtM8rcFZE1vKCCtDzqfDY3yN8/RDgt2bXn6KXzXnIrv1FuVBq6j+7TwO3qd5OU
         dQrg==
X-Gm-Message-State: AOJu0YwZ6ZLhSAayAfp4ga4EAm9vsxtX3nfGa6qt+ZGmXWiQzW/TB0Ld
	WDDkIRiGTxgYUsJGmDxZz8LKOSZ4WGheb/fkOS6GW/0WAo77BlUehw1v3UQ7IyZscb0D03nWpw4
	lsKQU
X-Gm-Gg: ASbGnctufqaIcdieG/NxG9BiV3mAJZNucPON04Sbu/kTizp2CyAkgA4HMUWSjcD1eWQ
	LrEXFneM0MKaHhIWf+OfqwCP5LspEKt9WGG0C0mTB01urYe1czymrepcTqpTlQReyc6KiTONdPj
	/CvoBWKBRogQJUoeaX4cc5P0x1YCCdgHJ08nZW1TOeeAF1yhn3/YUf+FQ2xK2cqlOuS7ZfOrlXA
	2piaCRrAZF/wwqo7rkdaWaxMnVtmKcx+qaaKwPGdxbgVnDf3e0BAX5XU0pPikYFoCWXOlKqfSj5
	tbZTc7W2leOpI8sAcATfpRda4VRJ54gIW2NjcP3+kdGjcJtc45Z/C6z0vEwRdjTW2gymuHHM8G0
	9xOL1VOptqMWCRsiF6DaImQr2zA9Jqr/3UcN1uiov9jvnXxu/V1UvtPZDosCWTsmZ+wbhcbaMwN
	mpKfPwJlfBYGjaQnDpbCAYYRGDYhGTo98Gn1k=
X-Google-Smtp-Source: AGHT+IEYB4RcO6/T/F6GdUJRGz5Gj8k/fCh8UC0fYenTSuHKZJgZ81fKWDHYEdBWnPyUSDcJxcdkUw==
X-Received: by 2002:a05:600c:4f0b:b0:46e:4783:1a7a with SMTP id 5b1f17b1804b1-47730793c43mr123205675e9.3.1762185480364;
        Mon, 03 Nov 2025 07:58:00 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm48245e9.5.2025.11.03.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:58:00 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian Konig <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philip Yang <yangp@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
Date: Mon,  3 Nov 2025 16:57:37 +0100
Message-ID: <20251103155740.250398-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103155740.250398-1-marco.crivellari@suse.com>
References: <20251103155740.250398-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

The above change introduced in the Workqueue API has been introduced by:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 9569dc16dd3d..7957e6c4c416 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -175,7 +175,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
 		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-			if (!queue_work(system_unbound_wq,
+			if (!queue_work(system_dfl_wq,
 					&tmp_adev->reset_cntl->reset_work))
 				r = -EALREADY;
 		} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3d032c4e2dce..041ee35684ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6040,7 +6040,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work(system_unbound_wq,
+				if (!queue_work(system_dfl_wq,
 						&tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 28c4ad62f50e..9c4631608526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -116,7 +116,7 @@ static int amdgpu_reset_xgmi_reset_on_init_perform_reset(
 	/* Mode1 reset needs to be triggered on all devices together */
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
-		if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
+		if (!queue_work(system_dfl_wq, &tmp_adev->xgmi_reset_work))
 			r = -EALREADY;
 		if (r) {
 			dev_err(tmp_adev->dev,
-- 
2.51.1


