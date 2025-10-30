Return-Path: <linux-kernel+bounces-878618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E4C211B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CF11A624F8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842C365D32;
	Thu, 30 Oct 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bgft3vQq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8A3655FB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840626; cv=none; b=ECqi5I6//g+tpk1SWTH+ygDZe0h9QGSyRI/ZAU29oLqhaDmk2qmIRb2RVOJX0vi3jdiZZigEHKyuxdQR8EwNV0DOom6ATIaFTp51a/h9v6RczqbOhgkQop9a9g+BzBnUxKSa3YQclkbDiFMZ6SKd/quxr6BEHT/kkQUgpvQsrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840626; c=relaxed/simple;
	bh=2CRHRjYIG8N3UT6Uqg+4yPTH2iUR9Mqyj2TfzEyLThw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ng4etJOXtAM8XM6heFoaZErMJwErrnbizmSx/JRnhrggU5gKUcsnYcQgee0aeHXUCRZ6Tn4l10/MOX3HP4w69P4ZKSI0ixV0S0/XvxZK53+0ZXDg4zw7T0sVZy/i16ffFgkzJLYw3ELID/h+aMrLcHoTG8Jn4FgJ/xNap/M6gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bgft3vQq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-421851bcb25so742771f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761840622; x=1762445422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTPZsf+rmUI4vnLNPtXQcosAXrq3VoTes6fLwzo6HcE=;
        b=Bgft3vQqT/VssFbJHKY5bmj/kj6LG1fLkLBS3L/rITBl/Kjkq1EUP9Y++1T2m7jmCj
         X/jzVUfB7qjYyZr1JznYHsm79Fo/qRxmfoYHZeGDjAwxmvPWdSHzJhijRd1ZfWLWpkGW
         nX9NcHlD7ZerzV7kVnugEGKFmRrLoYjit8TPHnWZdlR3frzYZ83NHZC6F3puotyyzu1o
         jxpcrAq8k+CuUrhMq0Hc5OGL7n2d/EDu/7YSAs6J4wu/Cyg2ll10zWcupa+Q3KFJeb8d
         kOLJ1ihPBY9nqNLrAi+7O+wlXPLz2lmLeULYpFBfDY/Mc1mU62Q2OGFSbsImVUW25vYj
         oq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840622; x=1762445422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTPZsf+rmUI4vnLNPtXQcosAXrq3VoTes6fLwzo6HcE=;
        b=cChQG87q5vXGj637LOE6zjKexBXqdDLIp6G0xwg6M1qhAKXTZ6doDhBd5dHFLDJLXi
         N6V7wO5qbY1Ax31PKpMChZngW4flmhBW5Zi2XRQ7a3BOJUO5M4mfS80Pfv5EUGPCEwr4
         ClSMkwU4aLffUWGcHdZcXOcCurUdl0WBsfG+/bIQR7yZtGROJ+CLz05VVZ4gvMU7FsWp
         67XoG0RQwV6Q2SdA8kiDgxO23lP67C3HE+qlzAp4WLl8vILAJ5CwD8Oiyvg64Wo5PG7L
         LKbmCXXbp/e06vAWASJKJpQoUFPoTbmJ9m2bHyj5lTDG+J7VL7yR3kpA7RGzeAxLorR3
         dRTA==
X-Gm-Message-State: AOJu0YxAQhIETdPJ0MuRG1SN0nmxtpYxqAdoufKGFRIpXmHFclQLLsfu
	ONuJTtj+W65DEDVKtM0qj3uyzXiCT1M+XebBWlvUzkD1QCAjpydByQw3sMyzC+jH5nFW278HgjF
	ec3c8
X-Gm-Gg: ASbGncsEeXVCkPFE9Uhe3nYQQ1VgLxN3Qz8bendStxNzb159qjuWE7IViinChyV0CLY
	GSnyg3NXsGZ9gSeWNoYkOMFKhU5BkkTaF7whPuRxx9lD9Z+TD09/+L69jw6XuNXCk/qJVfCt1j8
	ro//gSbl+utXXujsZjKzGl3w5mX5f0VdJhcERCp3Y2sRS8VdUBJFPI3bOWSsf8NNEIoFvQ/d8YH
	A0LbbDf7rIJbQmFt6tu2a+BfI+r4ObpEra+1UpKZol0xX8oEWXYMUbfuCymlXeKytlnwuthDdqR
	xJXgr/H21uci41lVeJQOE5KI/J8VQmTfC3Kl28FByW7gu5CPWK1acFleFEugo1WP01t2y6kkHL+
	G4cqM66uqiswOCVadtuHj1P6HEEwx1p122NE81sh0LZ2ACXf0hU3ITZf1KsKlUrqQrQYDXHAKi4
	lUdqmQhSDv/r616BjwvEyKW4qR9g==
X-Google-Smtp-Source: AGHT+IFyyXNW5PdLb1EAji6FZwxk9z7oFuqaX4IQuCCEMfZdy25gAvQgNKkIYiereVgd1Zd4VZyqew==
X-Received: by 2002:a5d:5847:0:b0:427:7cd:7b1d with SMTP id ffacd0b85a97d-429bd6a4d9fmr100959f8f.40.1761840621896;
        Thu, 30 Oct 2025 09:10:21 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm33124857f8f.8.2025.10.30.09.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:10:21 -0700 (PDT)
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
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/4] drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 30 Oct 2025 17:10:08 +0100
Message-ID: <20251030161011.282924-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030161011.282924-1-marco.crivellari@suse.com>
References: <20251030161011.282924-1-marco.crivellari@suse.com>
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

Adding system_dfl_wq to encourage its use when unbound work should be used.

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
index 7a899fb4de29..8c4d79f6c14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6033,7 +6033,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
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
2.51.0


