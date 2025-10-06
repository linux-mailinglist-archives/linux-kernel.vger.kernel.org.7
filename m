Return-Path: <linux-kernel+bounces-842751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D0BBD763
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAF474EA528
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058C1F3B9E;
	Mon,  6 Oct 2025 09:38:25 +0000 (UTC)
Received: from zulu.geekplace.eu (zulu.geekplace.eu [5.45.100.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338E34BA22
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.45.100.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743504; cv=none; b=SSc2GNbZE/hFwOPMEYh63t3O4Yw15vGRMXojBrWTS3B0yIW4QJ9IaeARpxw6IyVbAthrFPeIHY0GwmaTEO2ZhOiXB0j0uncAaYLMH+M5tPEANesAFXEj9burKOV21luCnduZEb9u9ya5cT2kw2Vq82KnVlyGB3WGgztVUd4MoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743504; c=relaxed/simple;
	bh=bM3eQ1iHMnjI+hHSlUGgsWOL5vu2GQTcxGjwGHxpfIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZQO5fZXmergsgvB2b//27KzrOpASxkNR/o4i/KPFICCjzrdB5WFOMVcWIY9Bivsdg1gQc1GWxvk2JiFZOM8+U6PZb8QIM3iF8h7UyWJlX0TpMurGxR3CEY1lB4N+gj6SysUpT4JvF7iuhaOoaD+o/6r2LTKdpnQRNue7Jr3hHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu; spf=pass smtp.mailfrom=geekplace.eu; arc=none smtp.client-ip=5.45.100.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geekplace.eu
Received: from neo-pc.sch (unknown [IPv6:2001:4091:a241:81e7:34fb:50ff:feac:591b])
	by zulu.geekplace.eu (Postfix) with ESMTPA id 6C1A44A00BC;
	Mon,  6 Oct 2025 11:38:05 +0200 (CEST)
From: Florian Schmaus <flo@geekplace.eu>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH] riscv: entry: fix typo in comment 'instruciton' -> 'instruction'
Date: Mon,  6 Oct 2025 11:37:42 +0200
Message-ID: <20251006093742.53925-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 arch/riscv/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index d3d92a4becc7..9b9dec6893b8 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -455,7 +455,7 @@ SYM_DATA_START_LOCAL(excp_vect_table)
 	RISCV_PTR do_trap_ecall_s
 	RISCV_PTR do_trap_unknown
 	RISCV_PTR do_trap_ecall_m
-	/* instruciton page fault */
+	/* instruction page fault */
 	ALT_PAGE_FAULT(RISCV_PTR do_page_fault)
 	RISCV_PTR do_page_fault   /* load page fault */
 	RISCV_PTR do_trap_unknown
-- 
2.49.1


