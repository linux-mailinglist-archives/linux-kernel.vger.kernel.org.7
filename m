Return-Path: <linux-kernel+bounces-848925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8207BCED54
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E226B19E2359
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85192AEE4;
	Sat, 11 Oct 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wqIxp567"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822234BA54
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760143688; cv=none; b=eS8VcaKKdRoNCcpajdCKGtcF7dg2cWVNqRYLWVu1frKyf/D8GG+RBAGaUBn1fBv7PXOELaXQAaSFBwa6YTkGcAGR5RRegRDavJP7yE7pg7DlIuOi+CeSs+pLOWIIWH1TDQZl+PWAMBEewHv+8fHC7G9PB67H9Cq5QB+1vMRvdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760143688; c=relaxed/simple;
	bh=JrHO9wcpchpFOEQKduYp9JsrMS6ulK7V3M9OWMip5m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ss5frST0XuVgrRJA8+xwqhQZlJvpwVGFBmWbfQ6OUnAIiGTTf4WTOF3ewHrefactWsIzoJbN9ovvtWbou8B80f82JxP9w7baHr+vUiOoDc4ELr9pI0iMR5XL2mgIUQ81tvEeRCT9/3TfgtmDctsnKwLBw7J5GUOiCM+dBWTtkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wqIxp567; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760143680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cji4z2er6pRmGYHI01Em2KoluPX1Q6shi/bLvXruyQg=;
	b=wqIxp567kScmh0J2IFpMr8rZwffM2m/RoXY7EJfFR0Q22ZONddZP9MLhH4F8UZrDyE/O3i
	gss7dAHbQtxQnpSI072N8sF71OhbVIVSPAuvJWxTfgyE5/w3DPkDvAfMGzs6uuuX1DMHIe
	NvyVa4xfXt6MiCg/F3R+QnQo71nODUo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: KGDB: Replace deprecated strcpy in kgdb_arch_handle_qxfer_pkt
Date: Sat, 11 Oct 2025 02:47:47 +0200
Message-ID: <20251011004750.461954-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated because it can cause a buffer overflow when the
sizes of the source and the destination are not known at compile time.
Use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/riscv/kernel/kgdb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 9f3db3503dab..15fec5d1e6de 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -265,10 +265,10 @@ void kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
 {
 	if (!strncmp(remcom_in_buffer, gdb_xfer_read_target,
 		     sizeof(gdb_xfer_read_target)))
-		strcpy(remcom_out_buffer, riscv_gdb_stub_target_desc);
+		strscpy(remcom_out_buffer, riscv_gdb_stub_target_desc, BUFMAX);
 	else if (!strncmp(remcom_in_buffer, gdb_xfer_read_cpuxml,
 			  sizeof(gdb_xfer_read_cpuxml)))
-		strcpy(remcom_out_buffer, riscv_gdb_stub_cpuxml);
+		strscpy(remcom_out_buffer, riscv_gdb_stub_cpuxml, BUFMAX);
 }
 
 static inline void kgdb_arch_update_addr(struct pt_regs *regs,
-- 
2.51.0


