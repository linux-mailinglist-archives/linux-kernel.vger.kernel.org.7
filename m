Return-Path: <linux-kernel+bounces-872505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3CC115AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E45244F8D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3A326D45;
	Mon, 27 Oct 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjRCMRnU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58E320A02
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595990; cv=none; b=LCDJZbxHWrKf/mON1NJi14VL2zl/z+1c56grfEoM6zRzPjRTIhNbpl5uKNU+GDZBfHkpg5ciuzFBSm7P1GLazQmZmkjVqTjsYcH3WXP9bZRqlamr3X9Wx0lB83pjrAK+v5AZwdCowZ4WdY+2haUJ21P02n9lc7Ssf8KLyhaQk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595990; c=relaxed/simple;
	bh=TRc2cNMJakW8L7s2VJlLPPVNKdonDXG7LBipYY++350=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mIuuVaFCmGZhY5VS/PCm+NgAN9VNdPrhb7DHfEnopKdtq9P9pKogDchTre7t4VmWPrOFxh1v+yAAJ2izp6yJgcnrYajoOBkfcb0kXvspNGDqKoTOPRmQ/lHm0GoVLzKnKuV0ZZQ2FJxyg7OKd2WU2gw6NKCqo3xkOh7EGXsg3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjRCMRnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF92EC4AF0B;
	Mon, 27 Oct 2025 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595990;
	bh=TRc2cNMJakW8L7s2VJlLPPVNKdonDXG7LBipYY++350=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rjRCMRnU/2tiBb0T9+77qJMssbNxP4vCS3cAmXP0k9zGOlc7/GlYaPGJFIe+nVyz+
	 Ndy3d1YAmwH2oB9lvDBtfL7cqVe1sJlTFBpRTNRR0m0KEdr+ZXhM3OSAmnEmcvJ5DL
	 jMaYi1gbyNisNj1fiiRCuDrAwnFjxQsh/LTGnnECNdy/jQwMnv8VQeFZYgGKFI04ph
	 OueE5Ehf89osLmBVlHndpERU+caDh4KsZ/oA49HVw+VMTm26sMNn+8vAK6njPtSj/R
	 JeltEwBLyOFUbl4QanxsFArHAF1XzPqGVuTUux4PQ6a9bn12+sFOnO4nlqsdqhAz61
	 M78szlu8SppcQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vDTb8-00000004PnZ-2Wjg;
	Mon, 27 Oct 2025 16:13:46 -0400
Message-ID: <20251027201346.456025827@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 27 Oct 2025 16:13:28 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH 3/5] tracepoint: Do not warn for unused event that is exported
References: <20251027201325.076180660@kernel.org>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/20251022004453.089254920@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1e53d3626c78..8a56f3278b1b 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -227,8 +227,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * defined tracepoints are used. It is discarded after the build.
  */
 # define TRACEPOINT_CHECK(name)						\
-	static const char __used __section("__tracepoint_check") __trace_check[] = \
-		#name;
+	static const char __used __section("__tracepoint_check")	\
+	__trace_check_##name[] = #name;
 
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
@@ -382,10 +382,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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
2.51.0



