Return-Path: <linux-kernel+bounces-790545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5A3B3AA12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553293BBE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174427700A;
	Thu, 28 Aug 2025 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3AT0WBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B5275B1B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405865; cv=none; b=OLT84IImf57A7gvsxOSl+g47ak4K+cmNgJfv6qbAm7Sfx7yL1Nscc4KaQV6A6oU8aDVkIKa4OqrBtqhwzuZtKuAPLESPgfrVxeAmGSAMhhs2PAx8fr6V9B96H1CfQOm0U53aIAPv/maOrMTXRBZEOFYKQ1A42ORcHLlTk9jvYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405865; c=relaxed/simple;
	bh=ZsrBnjZrAGmas9VV/NlTzzDoN92w9B6jeA6SVe3XhqE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=r9nLdOGlsvbzOtFiX1hqs9op5wYNPKjZcdsVq2Q2p4LtiOW3KD++swTd0zvXskSRlpGqogV39Zoc8+ElAoMxLqB/p71Egun+z0H5V8Qqcb2h3rmRG+Xx4TnPDiLzZI7HOHvWZb7x6RxDNcZuZk5dghFduOOtigUWSZn5m3mntww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3AT0WBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBA1C4CEF8;
	Thu, 28 Aug 2025 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756405864;
	bh=ZsrBnjZrAGmas9VV/NlTzzDoN92w9B6jeA6SVe3XhqE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=D3AT0WBgDpykwVL+S/gh6qFvsIQ3WSuZLxU1CW2nj186om07nIj9yMBBjF09N8Ei2
	 hG4QJRbAtI39L77W/v8sgb11Q+wkIPTMq0jVDVekKRpkss9gBva/ytcMyS7OND2OoD
	 Sp1KZ5bKlKasLyiuu0EOUa1jegrT0K9V3+9PqJGbQKExTJ3Y+I4eYcHjYiD6irjNOj
	 EmhKx0fi49E9yVBQbGsoT+erYjhZPmlq2+2TisIQx7nVkwT55TGC+Tb3JTjwjQTgB6
	 ZE++vRXg47wIES1tc50qcb7gceprOig2GkzFLj0RGT8dFWC99tP7BKfd+WEQ7Itf1W
	 6fYjn0YWoVgEQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urhPB-00000004Gsy-3G3a;
	Thu, 28 Aug 2025 14:31:25 -0400
Message-ID: <20250828183125.629250914@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 14:27:57 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [for-next][PATCH 3/3] tracepoint: Do not warn for unused event that is exported
References: <20250828182754.733989525@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are a few generic events that may only be used by modules. They are
defined and then set with EXPORT_TRACEPOINT*(). Mark events that are
exported as being used, even though they still waste memory in the kernel
proper.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/20250825231355.939259124@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 71d2e085c49e..ec6827d00d79 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -223,8 +223,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #ifdef CONFIG_TRACEPOINT_WARN_ON_UNUSED
 # define TRACEPOINT_CHECK(name)						\
-	static const char __used __section("__tracepoint_check") __trace_check[] = \
-		#name;
+	static const char __used __section("__tracepoint_check")	\
+	__trace_check_##name[] = #name;
 #else
 # define TRACEPOINT_CHECK(tname)
 #endif
@@ -381,10 +381,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
+	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
 	EXPORT_SYMBOL_GPL(__traceiter_##name);				\
 	EXPORT_STATIC_CALL_GPL(tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
+	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL(__tracepoint_##name);				\
 	EXPORT_SYMBOL(__traceiter_##name);				\
 	EXPORT_STATIC_CALL(tp_func_##name)
-- 
2.50.1



