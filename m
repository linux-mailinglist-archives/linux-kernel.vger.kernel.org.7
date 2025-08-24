Return-Path: <linux-kernel+bounces-783633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDDCB32FF4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF6C444F1B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6882DA77A;
	Sun, 24 Aug 2025 12:44:07 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9D33F9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756039446; cv=none; b=BARyQJk4vrYu3OFzPADyYzg0Ec3+5EGZitCawbWBsQ8GJM4xFqmUZJrviYswAuX1MuyqWtBOeZ7p2ghnlBq2o5DWkHs5V4M3NPbf8fvwSqQ4XlPf70m7At9DynDygvDhPUVInhGNs22Xwjcp43Mcwm3RF2L3kw1AsU2Kq9Ql/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756039446; c=relaxed/simple;
	bh=UwxLhXbPOcuTU2WHpg6L/Wd9VldYmPQmXcjjJK/f6p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vD5Khq8916AImmP8uUxWbTxhOX3dh504Ur9RKmm5vP7xCRQcIfYW5LnfSNUBYFsjEU/qBYMF4EDGdm/frdSlLD7u/sl57Dszn46aBHsC9ZpEpK8a/ypb6xDGLpn9XFbt6k5gx3tLN0znT7BngQxHo0TRH/sN1fHxH3A47n8SaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.vlan11.wl120.cc.ntu.edu.tw (ip24-218.wifi.cc.ntu.edu.tw [140.112.24.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 75BB22E6C1;
	Sun, 24 Aug 2025 20:43:56 +0800 (CST)
From: b10902118 <b10902118@ntu.edu.tw>
To: oleg@redhat.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	b10902118 <b10902118@ntu.edu.tw>
Subject: [PATCH 2/3] arm64: ptrace: minimize default bp_len for hw breakpoints to pass check
Date: Sun, 24 Aug 2025 20:43:16 +0800
Message-Id: <20250824124317.390795-3-b10902118@ntu.edu.tw>
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

The cause is that compat_ptrace_hbp_set() can only modify either
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
 arch/arm64/kernel/ptrace.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 73c67f743..70c9acd94 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -288,14 +288,25 @@ static struct perf_event *ptrace_hbp_create(unsigned int note_type,
 {
 	struct perf_event *bp;
 	struct perf_event_attr attr;
-	int err, type;
+	int err, type, min_len;
 
+	/*
+	 * min_len ensures any possibly valid address can pass alignment
+	 * validation with it.
+	 * This is for compat mode, in which addr and ctrl can only be set
+	 * one after one with SETHBPREGS. If addr is set first, ctrl will
+	 * remain as initial value.
+	 */
 	switch (note_type) {
 	case NT_ARM_HW_BREAK:
 		type = HW_BREAKPOINT_X;
+		min_len = (tsk && is_compat_thread(task_thread_info(tsk))) ?
+				  HW_BREAKPOINT_LEN_2 :
+				  HW_BREAKPOINT_LEN_4;
 		break;
 	case NT_ARM_HW_WATCH:
 		type = HW_BREAKPOINT_RW;
+		min_len = HW_BREAKPOINT_LEN_1;
 		break;
 	default:
 		return ERR_PTR(-EINVAL);
@@ -308,7 +319,7 @@ static struct perf_event *ptrace_hbp_create(unsigned int note_type,
 	 * (i.e. values that will pass validation).
 	 */
 	attr.bp_addr	= 0;
-	attr.bp_len	= HW_BREAKPOINT_LEN_4;
+	attr.bp_len	= min_len;
 	attr.bp_type	= type;
 	attr.disabled	= 1;
 
-- 
2.50.1


