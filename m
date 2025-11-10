Return-Path: <linux-kernel+bounces-893057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76770C466F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27EC18931A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5921D312819;
	Mon, 10 Nov 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ldGXshFt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA63115A1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775927; cv=none; b=T2g1UHjrQti1mYJbOpfK/wvZRAKVLpwwbWZhnPruV+clr9SukbCrp6NA14+O2lp6M8RUJFl8aBo4IrstGZwpJ3jO1IguZsh3AjXLzwmebd+7o3xe3jR1WMcVtQW49W1HZX4tNmUTjgbTUSN55RepWWhWlQacTb6UFtt3q7HyjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775927; c=relaxed/simple;
	bh=XHgjdAC2laFSG+IeNK9oonkhCgzlsiBnhP07D4n+jTk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FDiXN3gownDDhAjG4XvlwsBbYwtos9C7qyTafcFmSJD5CvoAynQAm5HyLVCAmCCETecYjQzPF+0bI6uVB55w0DSyv2gva2BfvQGx3nDxeylEQuxzlkus03jLvYJwz6a1swxBfhm0EG+xffDyJr1cmAoq5VNUFM39MxBCGHnqulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ldGXshFt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=FsgPCWOPtMXCOiGM5hTLthezRlLHddx6RHfFUZthv0I=; b=ldGXshFtWyJ1KOzr3eIISmTFTx
	xdnkylo0EuCm445bjLZiRWjS5Qm4kP7BEz1nd+jGQzzB01ds/WwNb62BrAMtkgQ7lH/C0jyuSI/70
	HAtafu7VltIKkGJMGLGAqWcOoJ9HtISO/lGFnL+loM17DfHioA8yOd3uqN+0CtkAQHQFw5dWt1eW4
	NKQ44j7jhJ09I1ZGnk4iGiLg079dEp41wfCfMIh/FjXa4RcwtbekVYPjmX/r53naxiyrxrEqcOYC5
	qlMjvV/q3U0V65zvfxnfqI+bc2U8V7Km6Ru4N3R1NIv24wqvsgSoyR9LtOMoTbdPOwuk8jflkaGKY
	UjZta7JQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQXa-0000000EP7X-3qWt;
	Mon, 10 Nov 2025 11:58:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 45400300325; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115757.341703850@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:36 +0100
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
Subject: [PATCH v2 03/12] bug: Clean up CONFIG_GENERIC_BUG_RELATIVE_POINTERS
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Three repeated CONFIG_GENERIC_BUG_RELATIVE_POINTERS #ifdefs right
after one another yields unreadable code. Add a helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/bug.h |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -30,26 +30,20 @@ void __warn(const char *file, int line,
 
 #ifdef CONFIG_BUG
 
-#ifdef CONFIG_GENERIC_BUG
-struct bug_entry {
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-	unsigned long	bug_addr;
+#define BUG_REL(type, name) type name
 #else
-	signed int	bug_addr_disp;
+#define BUG_REL(type, name) signed int name##_disp
 #endif
+
+#ifdef CONFIG_GENERIC_BUG
+struct bug_entry {
+	BUG_REL(unsigned long, bug_addr);
 #ifdef HAVE_ARCH_BUG_FORMAT
-#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-	const char	*format;
-#else
-	signed int	format_disp;
-#endif
+	BUG_REL(const char *, format);
 #endif
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-	const char	*file;
-#else
-	signed int	file_disp;
-#endif
+	BUG_REL(const char *, file);
 	unsigned short	line;
 #endif
 	unsigned short	flags;



