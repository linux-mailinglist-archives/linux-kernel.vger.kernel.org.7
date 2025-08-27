Return-Path: <linux-kernel+bounces-787509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E82FB37746
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA7A361273
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC02046BA;
	Wed, 27 Aug 2025 01:42:26 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A71F8908
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258945; cv=none; b=XT4tyUOcqIzD+4GZbSxBHG3atNtZUul7fJ9Fr5atZvCPbHw6LtWlQQOpDf1U8qHmABb+wxi8R2Qb4Fv+neLm8NGrPkKq4EOwKNunwE6oPRCmGgTBJXv4jd8tFENzxOypf5rvNmI8B20UvtNUo6NnPYVHUP0kXGBOIqsy83331o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258945; c=relaxed/simple;
	bh=hyHqqgsKCQITQyRm5hh0V/liS81UjB7HvC7eoO7k/08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XhHf9DoYYi9jo3AMGyzcLdxFJQXl0rTkAtkXcMPJe2GR2vS0ZxDmSVKe9gnnI4xuWEb6vl8CJrEYO94xv0U1u8aaFQUyJODPqB7p1Qhuzm6XAK4ZweHoDbUcSUm3KRMMSGQmKRMJ67LyQEcksBTlL7TVOczoL2Gce4jzf1/uIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.. (unknown [101.12.130.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 6BF5D31F50;
	Wed, 27 Aug 2025 09:42:14 +0800 (CST)
From: Bill Tsui <b10902118@ntu.edu.tw>
To: oleg@redhat.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bill Tsui <b10902118@ntu.edu.tw>
Subject: [PATCH v2 2/3] arm64: ptrace: minimize default bp_len for hw breakpoints to pass check
Date: Wed, 27 Aug 2025 09:41:12 +0800
Message-Id: <20250827014113.5852-3-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827014113.5852-1-b10902118@ntu.edu.tw>
References: <20250824124317.390795-1-b10902118@ntu.edu.tw>
 <20250827014113.5852-1-b10902118@ntu.edu.tw>
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

Signed-off-by: Bill Tsui <b10902118@ntu.edu.tw>
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


