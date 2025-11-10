Return-Path: <linux-kernel+bounces-893052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB95C466D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E0D3BE6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2830CD9C;
	Mon, 10 Nov 2025 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTF0bYxW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E56310624
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775925; cv=none; b=u3GFtDZZmXtXBspDcMVo7W8OAK5JJ7O17r1/ZF22lvoFws2iWVD0pptqrUqBhY6aZwlLxyHYnPndxGGvNGkd6YtmwvfEK4ZBo6xyY7TtNMQoinQTHo2QUjSTnKeOl8UxORuw1z0iWwwVU06UDmaRKspomN+tAjfAwAnGfDwhmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775925; c=relaxed/simple;
	bh=WtA1JCoGG66vGlW/CyH2TrNoV0lBhThLggqaXOWNdhQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SjoP7WJGsJkiilTcfqqGiTrGNkalRSWBuHARi6zDAGUXz6YQ6vOgNNyu+VtoHBs83vL1fw2PCtyyAQYeAagt7+u5Qee6FZXQV/0BmSAUghRrN5GihT9OdcooktQB9s5X4COerxhzBkw1i93vpmzcr91o29FJ15Ook8gjdGkIiH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LTF0bYxW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=GIfqOc8Lp2Lf6hr4PQNWDBlZLxdBIQ7Nk6BPMG3El9s=; b=LTF0bYxWBGdjRM1wfxVEFchGxJ
	ayAG0hfV5Kp048+vgibLoNlWbY+C0NpiIMZOHfPbVFQQ3zuEY7G6RUGqndCeVCSTCwck4VDQLCa3T
	qLL2Q7isz0vTkSSAbfVI1EH9AiA3/2O3dY7VULMb8x8t3/6EFCZ2J34ThpiO4f/iEfOK3/SLQNt1U
	n1Lw3OnGabsmRVblCh97SIbfY8E86fUR7MN+J0zRjHyGP1bQIDedAol4btvXGfQXtJDBFzrA0A2Eu
	sD1kirh31k5sUzz1iFCfTb91bllP5dfcIvUJvt0x1fQKinc96/sKkIvosJz1BlSdETPz5kn6ToTjb
	o2PQW0Fw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQXb-0000000EPAn-2iil;
	Mon, 10 Nov 2025 11:58:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 538EE302E03; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115757.690999560@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:39 +0100
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
Subject: [PATCH v2 06/12] bug: Implement WARN_ON() using __WARN_FLAGS()
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

This completes 3bc3c9c3ab6d ("bugs/core: Pass down the condition
string of WARN_ON_ONCE(cond) warnings to __WARN_FLAGS()") and makes
WARN_ON() and WARN_ON_ONCE() behaviour consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/bug.h |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -109,19 +109,29 @@ extern __printf(1, 2) void __warn_printk
 	} while (0)
 #else
 #define __WARN()		__WARN_FLAGS("", BUGFLAG_TAINT(TAINT_WARN))
+
 #define __WARN_printf(taint, arg...) do {				\
 		instrumentation_begin();				\
 		__warn_printk(arg);					\
 		__WARN_FLAGS("", BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
 		instrumentation_end();					\
 	} while (0)
-#define WARN_ON_ONCE(condition) ({				\
-	int __ret_warn_on = !!(condition);			\
-	if (unlikely(__ret_warn_on))				\
-		__WARN_FLAGS("["#condition"] ",			\
-			     BUGFLAG_ONCE |			\
-			     BUGFLAG_TAINT(TAINT_WARN));	\
-	unlikely(__ret_warn_on);				\
+
+#define WARN_ON(condition) ({						\
+	int __ret_warn_on = !!(condition);				\
+	if (unlikely(__ret_warn_on))					\
+		__WARN_FLAGS("["#condition"] ",				\
+			     BUGFLAG_TAINT(TAINT_WARN));		\
+	unlikely(__ret_warn_on);					\
+})
+
+#define WARN_ON_ONCE(condition) ({					\
+	int __ret_warn_on = !!(condition);				\
+	if (unlikely(__ret_warn_on))					\
+		__WARN_FLAGS("["#condition"] ",				\
+			     BUGFLAG_ONCE |				\
+			     BUGFLAG_TAINT(TAINT_WARN));		\
+	unlikely(__ret_warn_on);					\
 })
 #endif
 



