Return-Path: <linux-kernel+bounces-893046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5862C466B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 959BD4E9B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64530F536;
	Mon, 10 Nov 2025 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bwfc+6cg"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB530C37A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775921; cv=none; b=DmqkQ6jd6VsMXzGUwkZcRwvHXJteKkrOmZUMPHrj8HAFxdOtdxzAtP2r7q2nqErI9DGAtzdS6hE4DiFXFSP/PLPPORS5zu86sU79MVXE2L4yMjtzX+o6rHj2wlP659zN1EH8oxiFBZcVpcneL+XgxCBHXjF1ExcILOy0KoQ2grA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775921; c=relaxed/simple;
	bh=jv50UUcxEyqfqF9uFRD7OvWr/dXultcIfCRsaBDCQUs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=az/ZdkijrvKqMV2NThmbm/U548mMmC0lkkoVzL41z3srl/887XQSKy0TOLfewUiTPROirFMtXpuNsnlsCTXyUsk40Ux0vggqVQudcT37RlfUBuYTzodkoAVxAYzhgJQSFHRoh5XeBiimTKeGuQQccCXd/3owujFofKNHyriENBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bwfc+6cg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=AunU+fA9b71Eyx5ksFHxLbJWEddIQ60YwA7g3UFMIZ4=; b=Bwfc+6cgG7HrjcyAhv6KFnVS0v
	NPZ8akbEkyrYXwu5pfknQCeY1T/Nyq5XPLF0143QMwPJuZ5kZ0p8A6aEgHM32FfGHHQX6mycw3/aD
	u++yWI7MMbxw4lgrEJMjftc/BQMvDLi2x9/ibzEIUtd1yRmcqP4SPKFIybFtu0b+vFA+isb7pnUxW
	1g1SF51o1GJIY3zWqW04u+FokT8h2dtkTIOxZM1xD7wpP02KCf9C12AnMgu4nFY97ohb3Cv1hIxgS
	73F6JphRBMTh2wbyYewJt5ooWMyfxviCbTr6CR0gmjAXTQbDDk3A0OT2trWLQQ7kcjh6dVtgAULgW
	AdEV2y6w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIPfv-0000000AZem-3cAB;
	Mon, 10 Nov 2025 11:03:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 6904F30305C; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115758.339309119@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 kees@kernel.org,
 acarmina@redhat.com,
 jpoimboe@kernel.org,
 mark.rutland@arm.com,
 torvalds@linuxfoundation.org,
 maciej.wieczor-retman@intel.com
Subject: [PATCH v2 11/12] x86/bug: Implement WARN_ONCE()
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Implement WARN_ONCE like WARN using BUGFLAG_ONCE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |    9 +++++++++
 include/asm-generic/bug.h  |    2 ++
 2 files changed, 11 insertions(+)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -176,6 +176,15 @@ do {									\
 #define __WARN_printf(taint, fmt, arg...) \
 	__WARN_print_arg(BUGFLAG_TAINT(taint), fmt, ## arg)
 
+#define WARN_ONCE(cond, format, arg...) ({				\
+	int __ret_warn_on = !!(cond);					\
+	if (unlikely(__ret_warn_on)) {					\
+		__WARN_print_arg(BUGFLAG_ONCE|BUGFLAG_TAINT(TAINT_WARN),\
+				format, ## arg);			\
+	}								\
+	__ret_warn_on;							\
+})
+
 #endif /* HAVE_ARCH_BUG_FORMAT_ARGS */
 
 #include <asm-generic/bug.h>
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -176,8 +176,10 @@ extern __printf(1, 2) void __warn_printk
 	DO_ONCE_LITE_IF(condition, WARN_ON, 1)
 #endif
 
+#ifndef WARN_ONCE
 #define WARN_ONCE(condition, format...)				\
 	DO_ONCE_LITE_IF(condition, WARN, 1, format)
+#endif
 
 #define WARN_TAINT_ONCE(condition, taint, format...)		\
 	DO_ONCE_LITE_IF(condition, WARN_TAINT, 1, taint, format)



