Return-Path: <linux-kernel+bounces-764118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A79B21E46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056CE16EDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB09C254B19;
	Tue, 12 Aug 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QJsSR8+m"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A662D3ED7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979961; cv=none; b=XLURrAVDK2TPvLsBhXXZZAZGmMurRnVBFy5VArZQ9Oko/JjybSADKK609JUjqXqJkweTFzCVzm/tDLMBGUgkgrDxXDl4+B0MKzPV5MhaYNYLqpBKlBKRacRRF1Iz4OIm7ZJZvXvbl9JWaa4sbe3OUsqGL+NHYqyvj0kjrYyKCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979961; c=relaxed/simple;
	bh=JwoVUph7JdF+eUAGcD2R4C4BHZniihsGUMw3tU+0Hjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QC5XId10n0SaLM6j7U8ZiWHh7WI6KHR9kiH41gkpgeefP8i2Ah0sZg9iG5XUVbPjd5/nnClo2ceJc+wIdYEOSUODneczkhFxXBnuVSwQuJzmfxrbYB7p92GWFRhjCgqd+Xhxt01Mbtvju8yEbeScsh15rD5FAoXv/fYSU4YUgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QJsSR8+m; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-86a052d7897so421237939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754979957; x=1755584757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efQ/Khh+wi0B0rIIu872y8FB8xkosRs89Ye5o6WmuwM=;
        b=TB+ogbZB5m6qg++ISDYQ52dsp1jKDQXyaI7MrunWKleNIU8RVnr8b5Q1Sy/Y0O9NiN
         c3Nwm7FqwAk3PUJQPV1SQqGht7bXpN6eIDp9bvv2S6R3SlyQHq3xbq38yBGUmYNTtxbT
         L7r97IByQXGQ+Ai/vMAwFN6Q0j9gRqPBIElrKxs22Crjm1OM6xpBmyR9PLarPkVMX8O1
         jrRm0tPap0vw+ZtOBWIv7Is6R6/37U+qJWSEefoEryJ/fCG+46aoDFbJ3rf1JIVY/Ywa
         PchGV0GC4AbQLm9n1Xm7jlh53/wmi9rOj0QAkS3BM5bZQCtJD+jwBbYaGIF+l7wRzMOj
         oqhg==
X-Forwarded-Encrypted: i=1; AJvYcCXtPBSdpS7DoziznYN1Qtf852XyeuGPuCMLiDvt+fWOAK9l60gfvwOoC5sMi9tY9/9SVPgYJxPqr5B9HdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRuJx6TXAfxvYd1/99Eii5xttBrpKX9DKx3X0pTHyVO9y6EElQ
	3BHWKGyiAMIOXucGiwPbCIj0gVkY0Kw1EQZFuFjJ0hb7mj8fvIQzAZ62f6pDugg+ONJM8KRrNWS
	zN6+p82smCKBDVZV9kgwWZvks8e1uhOczwoNrmC/f+f/+OwGD61LvJQpz1MRb7zKOi5SoTS2wdS
	7fWyN1ajCRUOqRc6Ym/6J4a79jh+txOn1L4wuMy3v23SHyp9gGPOF4kYVvN71KHIb+aBxac0jFX
	uaYmYj8zeZamyS79hYx0zv9pQ==
X-Gm-Gg: ASbGncutgGTS1PEur9nnQSdjcsFUOcEQJ5r8aBH03GO/wcAdu9VLWQ53lA3vk/is9oM
	IGqXH64almZlUcPCJRoI4162VThz5wqnLUwBg05D80dN9hGanSKEcFci4yxkWLLGw1HXpxbR+6C
	e17IufWwNtl5pwswNMuk3w6LSDZDOoD8RfnrPt1zXH4p4t51UR3d9O7JpEWjTdUUQOpIp+R8uYg
	kBgB7vXMS+XFmT9979g80bRkhGME4h+IMxCmZSN6nP6kL4cBG4xId+3jQv2pjTMg+enwRo7g6aQ
	R2oFMXswE/s6mmSMgXEeqIOqAL5SFjT1Vq2F5f4hO0SkU0LIhBdTIWsj4axdoHGiU0VjcQj/rGF
	uVqluz/la6Wo/AOqgnRLQsS8EaWS25+Olfdq75/zsnYHskB4nabhpPAFo+ARhvSksLu6k249Iex
	CAc6Z1zw==
X-Google-Smtp-Source: AGHT+IFpVUIAL55YbUSck+NXlhwBY4/HRQFtAWByO3yQ3/nkYmOcFjDJEEqXbFA5nsAWvRPas91MF8YKDbz5
X-Received: by 2002:a05:6e02:b4e:b0:3e5:3d13:5d8f with SMTP id e9e14a558f8ab-3e55af70131mr38752855ab.9.1754979957370;
        Mon, 11 Aug 2025 23:25:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50ae9c492edsm685296173.50.2025.08.11.23.25.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:25:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400499ab2fso46344355ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754979956; x=1755584756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=efQ/Khh+wi0B0rIIu872y8FB8xkosRs89Ye5o6WmuwM=;
        b=QJsSR8+mK50HbIV2kqKWlPi/pEbTvhnCU0996GgI+pgIm/tBeZkQYG2Mp6Uf1cbOin
         BlO5CpvOX9G/fakcXK2TwqxocxNcSrboUIWj4gV/lsSCALYzXTc15jOERQ9iS8rLvxwq
         QL9YU5CxQVihWU2NH1p983cdnt3pQo8oO1qlo=
X-Forwarded-Encrypted: i=1; AJvYcCXusWz37is7r6gX1hcvkIZ/exQ7fdiNB9o4oRCnDncNQWVjEg5sdo3JZjlnLWXsxGt2aA8wB1XV63LTSTY=@vger.kernel.org
X-Received: by 2002:a17:902:f70c:b0:240:3f39:2c73 with SMTP id d9443c01a7336-242fc0eeffamr33535235ad.0.1754979955625;
        Mon, 11 Aug 2025 23:25:55 -0700 (PDT)
X-Received: by 2002:a17:902:f70c:b0:240:3f39:2c73 with SMTP id d9443c01a7336-242fc0eeffamr33534825ad.0.1754979955053;
        Mon, 11 Aug 2025 23:25:55 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aa9257sm291805895ad.153.2025.08.11.23.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:25:54 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	richardcochran@gmail.com,
	monis@mellanox.com,
	kamalh@mellanox.com,
	haggaie@mellanox.com,
	amirv@mellanox.com,
	dledford@redhat.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] RDMA/rxe: Return CQE error if invalid lkey was supplied
Date: Mon, 11 Aug 2025 23:12:31 -0700
Message-Id: <20250812061231.149309-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit dc07628bd2bbc1da768e265192c28ebd301f509d ]

RXE is missing update of WQE status in LOCAL_WRITE failures.  This caused
the following kernel panic if someone sent an atomic operation with an
explicitly wrong lkey.

[leonro@vm ~]$ mkt test
test_atomic_invalid_lkey (tests.test_atomic.AtomicTest) ...
 WARNING: CPU: 5 PID: 263 at drivers/infiniband/sw/rxe/rxe_comp.c:740 rxe_completer+0x1a6d/0x2e30 [rdma_rxe]
 Modules linked in: crc32_generic rdma_rxe ip6_udp_tunnel udp_tunnel rdma_ucm rdma_cm ib_umad ib_ipoib iw_cm ib_cm mlx5_ib ib_uverbs ib_core mlx5_core ptp pps_core
 CPU: 5 PID: 263 Comm: python3 Not tainted 5.13.0-rc1+ #2936
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:rxe_completer+0x1a6d/0x2e30 [rdma_rxe]
 Code: 03 0f 8e 65 0e 00 00 3b 93 10 06 00 00 0f 84 82 0a 00 00 4c 89 ff 4c 89 44 24 38 e8 2d 74 a9 e1 4c 8b 44 24 38 e9 1c f5 ff ff <0f> 0b e9 0c e8 ff ff b8 05 00 00 00 41 bf 05 00 00 00 e9 ab e7 ff
 RSP: 0018:ffff8880158af090 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff888016a78000 RCX: ffffffffa0cf1652
 RDX: 1ffff9200004b442 RSI: 0000000000000004 RDI: ffffc9000025a210
 RBP: dffffc0000000000 R08: 00000000ffffffea R09: ffff88801617740b
 R10: ffffed1002c2ee81 R11: 0000000000000007 R12: ffff88800f3b63e8
 R13: ffff888016a78008 R14: ffffc9000025a180 R15: 000000000000000c
 FS:  00007f88b622a740(0000) GS:ffff88806d540000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f88b5a1fa10 CR3: 000000000d848004 CR4: 0000000000370ea0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  rxe_do_task+0x130/0x230 [rdma_rxe]
  rxe_rcv+0xb11/0x1df0 [rdma_rxe]
  rxe_loopback+0x157/0x1e0 [rdma_rxe]
  rxe_responder+0x5532/0x7620 [rdma_rxe]
  rxe_do_task+0x130/0x230 [rdma_rxe]
  rxe_rcv+0x9c8/0x1df0 [rdma_rxe]
  rxe_loopback+0x157/0x1e0 [rdma_rxe]
  rxe_requester+0x1efd/0x58c0 [rdma_rxe]
  rxe_do_task+0x130/0x230 [rdma_rxe]
  rxe_post_send+0x998/0x1860 [rdma_rxe]
  ib_uverbs_post_send+0xd5f/0x1220 [ib_uverbs]
  ib_uverbs_write+0x847/0xc80 [ib_uverbs]
  vfs_write+0x1c5/0x840
  ksys_write+0x176/0x1d0
  do_syscall_64+0x3f/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://lore.kernel.org/r/11e7b553f3a6f5371c6bb3f57c494bb52b88af99.1620711734.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index a54d80004342..b7645de067f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -346,13 +346,15 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
 			payload_size(pkt), to_mem_obj, NULL);
-	if (ret)
+	if (ret) {
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
+	}
 
 	if (wqe->dma.resid == 0 && (pkt->mask & RXE_END_MASK))
 		return COMPST_COMP_ACK;
-	else
-		return COMPST_UPDATE_COMP;
+
+	return COMPST_UPDATE_COMP;
 }
 
 static inline enum comp_state do_atomic(struct rxe_qp *qp,
@@ -366,10 +368,12 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
 			sizeof(u64), to_mem_obj, NULL);
-	if (ret)
+	if (ret) {
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		return COMPST_ERROR;
-	else
-		return COMPST_COMP_ACK;
+	}
+
+	return COMPST_COMP_ACK;
 }
 
 static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-- 
2.40.4


