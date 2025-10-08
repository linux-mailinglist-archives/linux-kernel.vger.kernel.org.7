Return-Path: <linux-kernel+bounces-844997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA3FBC33E9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F7D3BD295
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591F2BD5A8;
	Wed,  8 Oct 2025 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgMNO5jQ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0928A731
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895036; cv=none; b=aayfUZWDiz7pmUqYM1ocFc3CFzL1GNG4LwBy5ESOu2AaTOZReKpKgWNbunHhFMITcg/fDjFsU7sNPeCYQgVjRUI+9O2C68/s3nguNwiIJmpmzejSP0dB8TihGPpxVMbD+2XT+ullnDYxya3hr4tc8X8I+iW32EOZvxAwA6wLCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895036; c=relaxed/simple;
	bh=cjYOvoxJBqceOZhoJPv3vUDJmtfq6xGwk1bsFb9wEqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+V3uEYYDB1rF6YaI8YqXfN6+Q5u+HmcS5steZLTaey3s/so90puDBSj5TJvx0E3uGb+aHuDcBz0ymYdNVHMlfSIpKeBWYYfR5GRsyRdzP/gYAUxlS2cGWsi6wRFFcMO5RydScfjewpXu3Z12AoJOrq0hj3utghWrHBJzyNXwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgMNO5jQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-269639879c3so64253925ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759895034; x=1760499834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VInhF7vun+ADbuDP4f7RWZ7/1hOQvgwkDekOvwy950Y=;
        b=QgMNO5jQO/Ql7rRgwkv/ihUqZ4CoX8ad4l//RI/bpgq7oiRRky6aF17xLr/0L5LJUE
         uJ0NYe+8kzwfBZ2kWHb9cRjazCgWAtBOe4790YPiqjkribgSa3wc/KtNIKcrPPdHHJJb
         gIlTLZ/ah9YysF4cbZMglHi3ggeCRFlQJHGzhTbboLM5kbT4uP+6XAGdBYPuEAehP6ji
         DrIch6TE8s2AxnzW1Q7UkNNS68dmxl5H1UWBq83FoKktX6im8Nzna3SvRSZZblTCcx1j
         gOD3z4g05Q2BDpDBBYMySKZpw1Kga9nOrN6qWUnHGFHWZ8APczYizpqIbWlM27eLawEX
         DITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895034; x=1760499834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VInhF7vun+ADbuDP4f7RWZ7/1hOQvgwkDekOvwy950Y=;
        b=OLKvnCW9ic99POC43TB2UGr6V1QBTEy+XssbdxgSXHXdJFQXGg1bPh5yWUTJHKQy+R
         qx5Rp2M5rzQ3x7uDocTwU2HouyAApSekxO+WoVPTjOyW/iXBXY9gl6MBav3TS9ImgLRT
         Qs5ZWvxnbkXKJ5JR3dZ7AWAcDKVMXzuoJg6jvq6ae9Rj1l6KhxNs8jHfxtPKDMzUnmrW
         OC+89IemBKZ7P+RbhreB0Eu5Jx0q09kIrWCjF9uMu2WwKte+OmOdHdx4crHjldVVMI6u
         xicnyRyhuPwgv3/CjCjulJ2AudNt+ARWa7NPWECWq5wzfJnoanGVLs5vvlYux5FnsfWx
         USgw==
X-Forwarded-Encrypted: i=1; AJvYcCXSWa31P02mr//tIdEvPptDt6mxIzmjfoogwQkpQtn0kXuWS6fnRslhYg3TI+EEoPRiFbIPhMaX43i1XO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LEF8r+9gYyd0MyDVd0SPSngOfuLDCOHGgYrBPz8WY/A8ivOp
	nQKEGnBtv57QbMYNsjkOymQmLTZZvUSYQtfQkwcXCCC9F2TOTlaGwK0d
X-Gm-Gg: ASbGncvvab/m8hi/sI68Tnhwc+lN4Su9W2NC31qUDAIiN8KTlTIMNB3cRxjHpzbTK2m
	BE8FykNsunOIw9YMwfbwI7VZRZrKqeyfEmmp1IWRGLNohrgy3TIk0lmiiOKFfchYtgKK7vxo5w5
	bKDutMv+VuF2J4W/9QBhQdTWDffKS/tIYIEIhT/OpH3Z77QFLeLvoFMWFk/TGtViwnSWPagEv5i
	JBlBkxOx6t9V3zwIy0j2UISF3lMWahkjSUXYCMfMK2xeRXwmoSCm9zAODD6XtzRbyAltwUzzMmQ
	n4rw78/2w5fKRPNK7geaOxoek6aT3gErGNDL+4fHASAXAEe23Mz8ldYxGN6sSXVjZYRqKAw0MuP
	Oo92aQaiQ+vr4jxZtDuRkXgDgYrGUHbdR9jq1CKHG7xnaMDIFAUc2vv3Pe/twRTZMIk2ENwVMCK
	k7tSTJ7Ju7evM4ajYIFogZPhxDJwJp8AyEe4XRCQ==
X-Google-Smtp-Source: AGHT+IG54xKXiUdy0DJwzKQZzIjcR2wGAtdfxZQRffoyREgsAb1SOl9FlsAzbJO0UqlUtTWKuOGgcw==
X-Received: by 2002:a17:902:ce0d:b0:26b:da03:60db with SMTP id d9443c01a7336-29027373dabmr24286355ad.13.1759895034268;
        Tue, 07 Oct 2025 20:43:54 -0700 (PDT)
Received: from localhost.localdomain ([155.117.84.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280c9sm182813505ad.53.2025.10.07.20.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:43:53 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: Felix.Kuehling@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: use atomic functions with memory barriers for vm fault info
Date: Wed,  8 Oct 2025 03:43:27 +0000
Message-Id: <20251008034327.2475547-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atomic variable vm_fault_info_updated is used to synchronize access to
adev->gmc.vm_fault_info between the interrupt handler and
get_vm_fault_info().

The default atomic functions like atomic_set() and atomic_read() do not
provide memory barriers. This allows for CPU instruction reordering,
meaning the memory accesses to vm_fault_info and the vm_fault_info_updated
flag are not guaranteed to occur in the intended order. This creates a
race condition that can lead to inconsistent or stale data being used.

The previous implementation, which used an explicit mb(), was incomplete
and inefficient. It failed to account for all potential CPU reorderings,
such as the access of vm_fault_info being reordered before the atomic_read
of the flag. This approach is also more verbose and less performant than
using the proper atomic functions with acquire/release semantics.

Fix this by switching to atomic_set_release() and atomic_read_acquire().
These functions provide the necessary acquire and release semantics,
which act as memory barriers to ensure the correct order of operations.
It is also more efficient and idiomatic than using explicit full memory
barriers.

Fixes: b97dfa27ef3a ("drm/amdgpu: save vm fault information for amdkfd")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c            | 7 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c            | 7 +++----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b16cce7c22c3..ac09bbe51634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2325,10 +2325,9 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					  struct kfd_vm_fault_info *mem)
 {
-	if (atomic_read(&adev->gmc.vm_fault_info_updated) == 1) {
+	if (atomic_read_acquire(&adev->gmc.vm_fault_info_updated) == 1) {
 		*mem = *adev->gmc.vm_fault_info;
-		mb(); /* make sure read happened */
-		atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index a8d5795084fc..cf30d3332050 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1066,7 +1066,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1288,7 +1288,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1304,8 +1304,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index b45fa0cea9d2..0d4c93ff6f74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1179,7 +1179,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1474,7 +1474,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1490,8 +1490,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
-- 
2.25.1


