Return-Path: <linux-kernel+bounces-743144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 134C4B0FB25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCF47B6C27
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236C923370F;
	Wed, 23 Jul 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfMl+0B+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836EE230BFF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300341; cv=none; b=cxUtUKeQQ7fvxwYSukyxAi4rvdGjbhBpjXbmMZeXT8ssmLdISttpFDEdkGaIJClE85O1ZfMMlmJ7psk5RKDLUPbWSJCq6lH8yEB9zDh7VKA99MtcWbj/Qu0JcH+UbeeSTOWaiOc4/AAijCUMgtvDMlGY0b7+k5rQcda/TSQWLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300341; c=relaxed/simple;
	bh=EXouJm0VSKA0V7Xn1kj17NJL/SKguIMKAEbQQ7HHWh8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uQDgNnsDdWFv81KL9skm9wqf5x/kkBN+yg6zIc42kRzAOrlpf8RBvOFU6IAZsGrsXA/x5eLW5lp6TEacBfm8ogG21OhoHgmbip9rJ1k9nsOzp3bUikOqXhh1OUl//PeCYnSaHr2DRV/7fLlp85Xeqvd9HX/LD6aMTiYXGG4XYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfMl+0B+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5BAC4CEF5;
	Wed, 23 Jul 2025 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753300340;
	bh=EXouJm0VSKA0V7Xn1kj17NJL/SKguIMKAEbQQ7HHWh8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=NfMl+0B+09GA2aHaT4xvdSfVqDiKO6xxRqM16/okyJxwAEaW/tMej+uf63IKpsZsh
	 xnFJLEEvsQQRuM3m1HfbLR6Hun1tH8R3roC4CoFt2+iwQQizvmPAnozgH+NmuhP/EZ
	 G1UaKnd9BK1icU8SueE+EvWPDYaHe9oiZVC1UgAq3Hi6bzf6zZ8Mh6SmxAOroV7Fwz
	 gEe2BS99Khp0egZw571M2wQvflgyjXQNe2ebZG06zAEH9KMneEAR1LjVkY2qBCznZJ
	 EWJr9ipdN2upYL3QqroHSY9zqJc+b193jQXpqZqDCegScGEXPqG0Y1MfOM1Gs4qwkA
	 HMFdrXO6hrV8w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uefVm-00000000Qul-1JKF;
	Wed, 23 Jul 2025 15:52:22 -0400
Message-ID: <20250723195222.167138246@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 15:52:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexandre Ghiti <alex@ghiti.fr>,
 ChenMiao <chenmiao.ku@gmail.com>
Subject: [for-next][PATCH 2/3] ftrace: Make DYNAMIC_FTRACE always enabled for architectures that
 support it
References: <20250723195208.164959427@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

ftrace has two flavors:

 1) static: Where every function always calls the ftrace trampoline

 2) dynamic: Where each function has nops that can be changed on demand to
             jump to the ftrace trampoline when needed.

The static flavor has very high performance overhead and was only created
to make it easier for architectures to implement the dynamic flavor. An
architecture developer can first implement the static ftrace to make sure
the trampolines work before working on the more complicated dynamic aspect
of ftrace. Once the architecture can support dynamic ftrace, there's no
reason to continue to support the static flavor. In fact, the static
flavor tends to bitrot and bugs start to appear in them.

Remove the prompt to pick DYNAMIC_FTRACE and simply enable it if the
architecture supports it.

Link: https://lore.kernel.org/all/f7e12c6d-892e-4ca3-9ef0-fbb524d04a48@ghiti.fr/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: ChenMiao <chenmiao.ku@gmail.com>
Link: https://lore.kernel.org/20250703115222.2d7c8cd5@batman.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..28afc6941e7a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -275,7 +275,7 @@ config FUNCTION_TRACE_ARGS
 	  funcgraph-args (for the function graph tracer)
 
 config DYNAMIC_FTRACE
-	bool "enable/disable function tracing dynamically"
+	bool
 	depends on FUNCTION_TRACER
 	depends on HAVE_DYNAMIC_FTRACE
 	default y
-- 
2.47.2



