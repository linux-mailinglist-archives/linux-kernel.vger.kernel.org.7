Return-Path: <linux-kernel+bounces-875633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8005C19736
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421B819C2A11
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628832B9BC;
	Wed, 29 Oct 2025 09:45:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C0328638
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731118; cv=none; b=R8A6MEJFt7e3vq+EkvYVfAT7QP0m+zmMPI0zzhNgDG5m2PA/mwiQ2VjqXfnqJ/GewsW5KL4W4VThGcPkEH6vNn/5fDtVmVQVer9aEiRMIOdfjv8cm8JKMvH1eAkecxjjrIOoqIUbG64fRqZuGGSoXqk2qaQosdPTCK3DkD2yl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731118; c=relaxed/simple;
	bh=xTmmv17sUAY11/9gUhl4LxxIdSchsp/k7bMtJNnlzAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LMV0dvscTmrp0IAKp9j9k6JaKX0KdlpKkpV72WCImKOHJ6Trbb6h0e7LO+sNPUMNUexmoZb9s3ibo6h+Wt7Lhlo+fYocJwqfIr0uJiGjgwMDrN6l43ZAgFNBGkKmX+ru5R0+YbB38A6j6f2hWdsskAaJTn28wbwfP63Pd85fy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f50830cab4ab11f0a38c85956e01ac42-20251029
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:388f82e1-4ff5-4309-a409-6fa73e35711b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4c0e2d3b35af40567075f32366f56a80,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|15|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f50830cab4ab11f0a38c85956e01ac42-20251029
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1483650547; Wed, 29 Oct 2025 17:45:09 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	emil.renner.berthing@canonical.com,
	nicolas.schier@linux.dev,
	masahiroy@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH 2/2] riscv: Remove redundant judgment for the default build target
Date: Wed, 29 Oct 2025 17:44:29 +0800
Message-Id: <20251029094429.553842-2-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251029094429.553842-1-jiangfeng@kylinos.cn>
References: <20251029094429.553842-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of KBUILD_IMAGE is derived from $(boot-image-y),
so there's no need for redundant checks before this.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 arch/riscv/Makefile | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3998d4036f15..4c6de57f65ef 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -134,21 +134,6 @@ endif
 CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
 
 # Default target when executing plain make
-boot		:= arch/riscv/boot
-ifeq ($(CONFIG_XIP_KERNEL),y)
-KBUILD_IMAGE := $(boot)/xipImage
-else
-ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
-KBUILD_IMAGE := $(boot)/loader.bin
-else
-ifeq ($(CONFIG_EFI_ZBOOT),)
-KBUILD_IMAGE	:= $(boot)/Image.gz
-else
-KBUILD_IMAGE := $(boot)/vmlinuz.efi
-endif
-endif
-endif
-
 boot					:= arch/riscv/boot
 boot-image-y				:= Image
 boot-image-$(CONFIG_KERNEL_BZIP2)	:= Image.bz2
-- 
2.25.1


