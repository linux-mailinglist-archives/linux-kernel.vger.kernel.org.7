Return-Path: <linux-kernel+bounces-783632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD699B32FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDAC444D31
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA832D9EC9;
	Sun, 24 Aug 2025 12:44:05 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCE2B2D7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756039445; cv=none; b=EFhkwqaqmXaKm4jU1gQ1ymKWSrLDilHbGMevgWhuKhH4Wnmw0oTIs9WFv3Ib2WI6vfMwWSK5I+7e8TgxLbx8A4hea8tMXCE2p5QyhXwUAN24rCHb9Tluuv5cqte9hyk2UO7RnsBp4BwRQCUd/YKtAfQrrq10Y9ldT94wRXwmfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756039445; c=relaxed/simple;
	bh=EGrSHTapPc7vwzx+kgXnQiuYgGdua0vWOKBlIYZjWGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7mEtz6Asf3bROtwn+fXsmdKPZBgHHO8jhYQDVHAHV2noMtNCZw+tfB4zWVmbwQnrZUWBpmIArCX0QYc0JE0OKG/i8x1QWoMhx3zPv260SdxFf+3anlMLTVGHiA3iUU5K35L/+rarKqsXCydL2GV1wYUQKTAZixHkbxnKyvy1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.vlan11.wl120.cc.ntu.edu.tw (ip24-218.wifi.cc.ntu.edu.tw [140.112.24.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id DED282E6C3;
	Sun, 24 Aug 2025 20:44:01 +0800 (CST)
From: b10902118 <b10902118@ntu.edu.tw>
To: oleg@redhat.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	b10902118 <b10902118@ntu.edu.tw>
Subject: [PATCH 3/3] ARM: ptrace: minimize default bp_len for hw breakpoints to pass check
Date: Sun, 24 Aug 2025 20:43:17 +0800
Message-Id: <20250824124317.390795-4-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824124317.390795-1-b10902118@ntu.edu.tw>
References: <20250824124317.390795-1-b10902118@ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTRACE_SETHBPREGS fails when setting a hardware breakpoint on a
non-4-byte aligned address with a valid length to a 32-bit tracee. The
length should be valid as long as the range started from the address
is within one aligned 4 bytes.

The cause is that ptrace_sethbpregs() can only modify either
addr or ctrl of a breakpoint per call, but always checks alignment in
hw_breakpoint_arch_parse(). If a breakpoint has ctrl.len=4 (the
default), then users cannot set the addr to a non-4-byte aligned
address. Likewise, if the addr was previously set unaligned, users
cannot set ctrl.len to 4.

This patch mitigates the issue by minimizing the default bp_len, so
that any possibly valid address can pass the check with it. However, it
does not solve misaligned addr/len in modifying existing breakpoints;
further work may be needed to remove or relax the alignment check.

Signed-off-by: b10902118 <b10902118@ntu.edu.tw>
---
 arch/arm/kernel/ptrace.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 7951b2c06..920cf77d1 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -415,12 +415,26 @@ static u32 ptrace_get_hbp_resource_info(void)
 static struct perf_event *ptrace_hbp_create(struct task_struct *tsk, int type)
 {
 	struct perf_event_attr attr;
+	int min_len;
+
+	/*
+	 * min_len ensures any possibly valid address can pass alignment
+	 * validation with it.
+	 * In PTRACE_SETHBPREGS, addr and ctrl can only be set one after one. If
+	 * addr is set first, ctrl will remain as initial value.
+	 */
+	if (type == HW_BREAKPOINT_X)
+		min_len = (tsk && is_compat_thread(task_thread_info(tsk))) ?
+				  HW_BREAKPOINT_LEN_2 :
+				  HW_BREAKPOINT_LEN_4;
+	else // watchpoint
+		min_len = HW_BREAKPOINT_LEN_1;
 
 	ptrace_breakpoint_init(&attr);
 
 	/* Initialise fields to sane defaults. */
 	attr.bp_addr	= 0;
-	attr.bp_len	= HW_BREAKPOINT_LEN_4;
+	attr.bp_len	= min_len;
 	attr.bp_type	= type;
 	attr.disabled	= 1;
 
-- 
2.50.1


