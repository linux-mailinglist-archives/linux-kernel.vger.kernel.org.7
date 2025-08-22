Return-Path: <linux-kernel+bounces-782753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C298CB324D9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9617B58653D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA832D73B1;
	Fri, 22 Aug 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvZ/RVvA"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93C1A5BBA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900002; cv=none; b=tgxK4mJAgl944XNd01eWT9HiyYhi81TlQmiwUl79KF6/rF9c6OpN481VZ5SIcuY/NwB5LwtHym2/HLzFhmujE/qt6eZ6KtXZne+/0d8w4satxC02B3Ryjgd4iNnI6xv1bHOs7WtrNSDqGi0o0jcbK3TjlCe5Ea6Sb9L0vEJ8RSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900002; c=relaxed/simple;
	bh=Do+JP/8nyALg3izGJ5X13xOHbeb+5hr3yfAmzYVtOHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=av0IzUjQT/HBo6xKgQcbqGWg/mJs2Vnpk8mxCd0VXNX6k+3pjtHvzRW9wcCZkZGn/f+eJ/mz088TnsNFfSWoblxvVK4NcSpSzV9LoF/XcVtfnsPcoFRpYftRJgZQNnyy4d4mIdDfJDD6T5cKX4UeVpGPje3lEOfEVKcjO0Cj+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvZ/RVvA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3252589a47cso763125a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755900000; x=1756504800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27a5/X7zn8hMoq+43xDaLAEXrC+YLxEOzCiaDSpbx+M=;
        b=FvZ/RVvA+CPrQodSX1P2tiGjeMGy3eFu/qaKxYGYks7ncdxanElZRNiEov20paNS/M
         xr6SGIPnuNtWyVWS0pxDpW6ig0Hi7i3MWLBdUQTIdj2hDN0KOX2kwWbNUlOU3PomyF+z
         Xn7PbkpsBHywoZdqciT9i/2+n70CuoHJoof3+d9q9b1QMnYrHIgOqNWzs/380srjS0Me
         yF5VX1SgKfashXiXlxEUqKFZEwNu0lftwZI4UK2O1oDZREd0zyLcnTyTGpyM15Ozxyci
         ffGFROtXvdKU5Ynd1UGXjHaB9wXMKkbOfaUN2hzfC+r0tK9siUXXy48RS3ZeAh0OYjrT
         QJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755900000; x=1756504800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27a5/X7zn8hMoq+43xDaLAEXrC+YLxEOzCiaDSpbx+M=;
        b=Fh15Uk8KUTXL4pseMSxIu6F9rHTT9GC4PShs9Q/p/uldFO6PB70dqSGBoOTcqz4pG2
         JJumR1FWCVnND2Odm/NPdoZJkbSD+vBa4aiuUW0KuiJnCVlLZMfA6bBw5Bl//XtKMP3k
         4tVSSrALQB6UjyDhT7jOncK35BvhuJdRRGPtuUGhKWMpi5IFcqLxSXuRq8XAMHwbHVx/
         SmMFlezoMy6b3+bJFa6ieLD08qDIyQuIpIOXj87xRxKt6VGdGWkpdFMZknxV8pIiTwcS
         Oth0SY5vecmq3XxZAxIndq4tsjV0/PXmuRxnthy5ggj8nz/RnrJ38okQ90dDRCp21lec
         U/vA==
X-Forwarded-Encrypted: i=1; AJvYcCXzDTPowIH4kyzd6aXmiJbSTO/VJR9Y2CwHmJkB5i60XDQ5J10afK+rLHG8sFH/iLtOeD7+h0sLB+2xjr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlF+FNjz1gmhRwHK4FtjLtvL4+Ftu6MY8f7gyYHeHeHn1gC0f
	kTmYxfjK1FZI7+cA55QrPpiDh20I1sdIYTkKtfHiwMyNBQ5iCbJUpilqmnar7Oq6Xg0=
X-Gm-Gg: ASbGncvO0R5sL7gZ0R+C6t9xNJGQETiU97m/sLyPucd4NlejAXqga1K/978RmVZdnpR
	9DOvCaCxWMudV+fwXYT2uvGPQwZxpFUSaFMCcDk06+aNkuHOYP0OhelAswU3tk6u6UOHWOq/cQL
	PZ5LCM8IRtso1myCakxbNm0ntFMBGc2AAOW7ZSDocBgJAJ6jSNiAo6TNLJqOna6PHKDDNaPSXU+
	2ES4vIgR/abbFU/Z61BcvYONTRzfBq/HNF+9dX9OEJ0Z385as1x/HqpKD68pJwQjjSh59H5D21s
	OQLC/1PtiEWgxrO9qr/xPeZQym8tABBd30Zj8e6eH3poElj1CMdhGEy/Sw2Pts69ZrPmC7FvdW4
	Vn+ZqNYclb/WzDDTjk9UOulfPYRDfRKzyReqkLuPyF7TrBkGyEYhN2jSZ1bMuEyIA
X-Google-Smtp-Source: AGHT+IFfgq+FgRUVzS/dXB0ywpaXJzol3g6ler9CYy/+YGeYcKS1hqdTax7kq94uT6c6IDNSXBEN0Q==
X-Received: by 2002:a17:90b:3943:b0:312:dbcd:b94f with SMTP id 98e67ed59e1d1-3251d5437bamr5744750a91.11.1755900000064;
        Fri, 22 Aug 2025 15:00:00 -0700 (PDT)
Received: from fedora ([172.59.161.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b375sm671860a12.29.2025.08.22.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:59:59 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: Felix.Kuehling@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH] gpu/drm/amd/amdkfd/kdf_queue.c: removal of kfd_queue_buffer_put
Date: Fri, 22 Aug 2025 14:59:50 -0700
Message-ID: <20250822215950.243504-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed kfd_queue_buffer_put to call amdgpu_bo_unref directly.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  1 -
 .../drm/amd/amdkfd/kfd_process_queue_manager.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c           | 16 +++++-----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 67694bcd9464..2bc0365b2ce9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1312,7 +1312,6 @@ void print_queue_properties(struct queue_properties *q);
 void print_queue(struct queue *q);
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size);
-void kfd_queue_buffer_put(struct amdgpu_bo **bo);
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
 void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7fbb5c274ccc..b13817e4a829 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -610,7 +610,7 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 		}
 
 		kfd_queue_unref_bo_va(vm, &pqn->q->properties.ring_bo);
-		kfd_queue_buffer_put(&pqn->q->properties.ring_bo);
+		amdgpu_bo_unref(&pqn->q->properties.ring_bo);
 		amdgpu_bo_unreserve(vm->root.bo);
 
 		pqn->q->properties.ring_bo = p->ring_bo;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index a65c67cf56ff..dd529e37c0e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -224,12 +224,6 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 	return -EINVAL;
 }
 
-/* FIXME: remove this function, just call amdgpu_bo_unref directly */
-void kfd_queue_buffer_put(struct amdgpu_bo **bo)
-{
-	amdgpu_bo_unref(bo);
-}
-
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
@@ -343,11 +337,11 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	struct kfd_topology_device *topo_dev;
 	u32 total_cwsr_size;
 
-	kfd_queue_buffer_put(&properties->wptr_bo);
-	kfd_queue_buffer_put(&properties->rptr_bo);
-	kfd_queue_buffer_put(&properties->ring_bo);
-	kfd_queue_buffer_put(&properties->eop_buf_bo);
-	kfd_queue_buffer_put(&properties->cwsr_bo);
+	amdgpu_bo_unref(&properties->wptr_bo);
+	amdgpu_bo_unref(&properties->rptr_bo);
+	amdgpu_bo_unref(&properties->ring_bo);
+	amdgpu_bo_unref(&properties->eop_buf_bo);
+	amdgpu_bo_unref(&properties->cwsr_bo);
 
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
-- 
2.50.1


