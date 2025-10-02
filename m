Return-Path: <linux-kernel+bounces-839828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E148BB2812
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE91422DB1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C51258EF0;
	Thu,  2 Oct 2025 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecc8Gmgu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0A288AD
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759381857; cv=none; b=UuAH+nufe/5kOzemUnceSVzdCBntyd6kn3LkRRBDNwM6BbKC00K3s1MoOiaQg7ckHDMtAuXDpdHWv+AsBSNMjXwYl/RIIWpOmHtznxhWDSmdCZL6TPv1N+g5qatjpO1KXR/AOeQdyow5ihEcpDX0kehINsBsvzPpo1kE9VP9cXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759381857; c=relaxed/simple;
	bh=5XWH2/JhTQcKccHo72MsVhJxxM8INYY2KMjRDAsxQPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n73WqgTTXtQXMuT2UWFnggdVQcYZl/KzQSDbY8ZdgUvgXYemJi0lbCd7SVGteBnJHx6RWpG6sOlr+W9KPXqeCtnRkDBx8IOCPMpD20PNDTEWhpwn3gsN+RAoC7fRBp9EKiht4SpUNdc4AIb1Slk0tGRFxe+VfsPSWwDwrgw4tTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecc8Gmgu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759381854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4JQvSrEFCsoxe5xRRs2Oi0PpRnlMQT2kkhwm1m9/XgY=;
	b=ecc8Gmguofg1UC6D+r00Pta7P8xJeJGmqnxhn6dZ8WQl02Cqp18wZfQKsPJHr5QJqofb9S
	MI5IcZVS/A9rthnkMgtWOyqb08VHDIfZWYrPohjbjHm5uuMYUK0exif/0RJqUn6DeLRElL
	PZs1mKAkYN0qYCE++ETvJhDuTx7kT5I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Y4o2EzyGOKWo5YHMJVxvHg-1; Thu, 02 Oct 2025 01:10:52 -0400
X-MC-Unique: Y4o2EzyGOKWo5YHMJVxvHg-1
X-Mimecast-MFC-AGG-ID: Y4o2EzyGOKWo5YHMJVxvHg_1759381852
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28e90fe10feso2938495ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759381852; x=1759986652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JQvSrEFCsoxe5xRRs2Oi0PpRnlMQT2kkhwm1m9/XgY=;
        b=N0MKKRkSpwDLSGU7FRm1iP57urnNxhsRq0bvp7uU0t7hh4ziF1JeqYmVEQwdF6HBnC
         8gt+CT9GVo8YeKcNnyvv0afJE8OM09aOHZLBsorENHvvycjlhpnYNLF30+efZMXKthqZ
         cEyhNtnRlMAmX8NqIwKcGdnFfEafjR8SsawegwB1Uhz0PVTu5sVTULUEnDgAbFOnbZIG
         VMVV2jL2e/roIVTW+WwxKj7ul+B/NoDOQT2G0FkJ6U0mysfdoEgd2cQ6c0z7W6C8Np38
         34mkuqJxe4ADTSOLjQpgFVppRMqlkHZ9gs8b5wiocOnsMGeJt+J4etSep8yhVU+P0BxF
         +yEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEFMzxaKe8Myc+hHqwkfUOj0AKph5apeVDUDoRZCif9L3sIsG5H50+Opiq5j7/fIl7tMOeJnKu/zLDhbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZ43IsYZBFrta71MA8Esj5uuLhAKEpRGkGTfpEbWCI+brOZ8n
	ZNRWxysxkBIjWD2mLHj3GgH/f1dpYNzxIKYrIPFZapf2DNHt165+TVspnR+/OXQqgFeGBzCjdIl
	LDxyXqriTGC6aYX+VjSLEyfS0P40uSNC/fqqp20SwHM7LCDvgY6AK+VYh/LfD/UU+XA==
X-Gm-Gg: ASbGncvT2zYmUIVgRsmzKuQElsfyn0+2jbPXeYiY09W02ztXONFBJYGKvsbSbA5yjek
	NwWOirgsc2jRpiYx0qM55iO4j6HWDK9mxy0gaerCFHo+rpVXHivLautIcR2Y54V1J+/r6iNdOrl
	LTj3phbt/+SR1yJU4PZ+UwZbYAM34GEQJ0dEIq0lQl6r8/DS7o5zPMlZnbxdDJrJ6NNFLSR0wJX
	K0ak6A1xPxBrgBHIcmjNAbgNi9fs+5Qg9lAbMFoCgMn4CJAHOSWcTw9YPEWYG+PKll8lDS+NW2b
	+L3L3IO1nREezvB1ns5zURx3jcZ1Vw0byGTT7lnhAD8EdF0=
X-Received: by 2002:a17:902:ea0f:b0:27e:f005:7d0f with SMTP id d9443c01a7336-28e7f32fa44mr76227925ad.44.1759381851855;
        Wed, 01 Oct 2025 22:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdvHBv1w/DMsRepJmnrpr/Uz5Or//RIDtinprbRfs9s6Y2noLSrKbxSpBIfjIvctsC+934vg==
X-Received: by 2002:a17:902:ea0f:b0:27e:f005:7d0f with SMTP id d9443c01a7336-28e7f32fa44mr76227545ad.44.1759381851283;
        Wed, 01 Oct 2025 22:10:51 -0700 (PDT)
Received: from kernel-devel ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1e9de2sm12545715ad.121.2025.10.01.22.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 22:10:50 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: glider@google.com,
	elver@google.com,
	dvyukov@google.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	m.szyprowski@samsung.com
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] kmsan: fix kmsan_handle_dma() to avoid false positives
Date: Thu,  2 Oct 2025 14:10:24 +0900
Message-ID: <20251002051024.3096061-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reports an uninitialized value issue in dma_map_phys()[1].  This
is a false positive caused by the way the virtual address is handled
in kmsan_handle_dma().  Fix it by translating the physical address to
a virtual address using phys_to_virt().

[1]
BUG: KMSAN: uninit-value in dma_map_phys+0xdc5/0x1060
 dma_map_phys+0xdc5/0x1060
 dma_map_page_attrs+0xcf/0x130
 e1000_xmit_frame+0x3c51/0x78f0
 dev_hard_start_xmit+0x22f/0xa30
 sch_direct_xmit+0x3b2/0xcf0
 __dev_queue_xmit+0x3588/0x5e60
 neigh_resolve_output+0x9c5/0xaf0
 ip6_finish_output2+0x24e0/0x2d30
 ip6_finish_output+0x903/0x10d0
 ip6_output+0x331/0x600
 mld_sendpack+0xb4a/0x1770
 mld_ifc_work+0x1328/0x19b0
 process_scheduled_works+0xb91/0x1d80
 worker_thread+0xedf/0x1590
 kthread+0xd5c/0xf00
 ret_from_fork+0x1f5/0x4c0
 ret_from_fork_asm+0x1a/0x30

Uninit was created at:
 __kmalloc_cache_noprof+0x8f5/0x16b0
 syslog_print+0x9a/0xef0
 do_syslog+0x849/0xfe0
 __x64_sys_syslog+0x97/0x100
 x64_sys_call+0x3cf8/0x3e30
 do_syscall_64+0xd9/0xfa0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 0-89 of 90 are uninitialized
Memory access of size 90 starts at ffff8880367ed000

CPU: 1 UID: 0 PID: 1552 Comm: kworker/1:2 Not tainted 6.17.0-next-20250929 #26 PREEMPT(none)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
Workqueue: mld mld_ifc_work

Fixes: 6eb1e769b2c1 ("kmsan: convert kmsan_handle_dma to use physical addresses")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
The hash in the "Fixes" tag comes from the linux-next tree
(next-20250929), as it has not yet been included in the mainline tree.
---
 mm/kmsan/hooks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 90bee565b9bc..2cee59d89c80 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -339,13 +339,12 @@ static void kmsan_handle_dma_page(const void *addr, size_t size,
 void kmsan_handle_dma(phys_addr_t phys, size_t size,
 		      enum dma_data_direction dir)
 {
-	struct page *page = phys_to_page(phys);
 	u64 page_offset, to_go;
 	void *addr;
 
 	if (PhysHighMem(phys))
 		return;
-	addr = page_to_virt(page);
+	addr = phys_to_virt(phys);
 	/*
 	 * The kernel may occasionally give us adjacent DMA pages not belonging
 	 * to the same allocation. Process them separately to avoid triggering
-- 
2.51.0


