Return-Path: <linux-kernel+bounces-746329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE644B12597
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305EBAA6996
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2490225B30E;
	Fri, 25 Jul 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBzfVGiG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1025A32E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475658; cv=none; b=HokVqP2rid9/r74+YRId8jPlWDaO2A0AAk5VM6ehqUKr9UBVnL7rVpp73FWWaYn2yi9S0WtHG+RVMiZNDf9Mb4AtDfL0Ie/jgS5ScYnMgqtFasUclZ4I/O88IGU5yxRvNEahUWwg/9sFq0wHO/Nbcc9zlvbm4ng3xWwCjsH45gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475658; c=relaxed/simple;
	bh=lJAJPMjorckSa1MQsNEN+TaX/8IGzovjdFYDSD0sZwE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ck9mma9cXedLHVLIfAaKVXfqkqchATaPUQJQRafDjORhlIAmoAHlHgeQMLATkDkViAPBrE/43+GNmXfkLcyvA/Cdb+cMUcXt6FTBmSgHblmKfBIpzAVnTsqJP0nl4Diygwq5GAi+UI9IjxrluTTN2f2WdAnvrU+I5381NRWHX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBzfVGiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27815C4CEE7;
	Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475658;
	bh=lJAJPMjorckSa1MQsNEN+TaX/8IGzovjdFYDSD0sZwE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=pBzfVGiGNB0nILUaeuCTqQXD5cRLnDwGRWYE0enal5hCs0mxN/r7bXqhoGrCgOfzF
	 g0NMl45Mmxnm7PqDm6VoaA4ef+43lN0yMwj18zuqTteAhXpi0NkUgbsz4yhBhy8HyF
	 t8jYfQ61fmhPpn9V3dzyVTknO01dnR+tT6eBN8/SWtWrbZ/WEg+fV7zUvjkQY09TfT
	 qNjQiqD+3ZgeQ5Ph+Sz8h9+T7Kr+XvdlAC7dV4+aMJIvCYS/lwEOdpuM6z9VovghAs
	 so5wwvsnzjt95OhbZJdLBYQYJ8PT5WdmVwMKhGZSDlaJtPQ/AtYIAuuVSchbL/DmCg
	 a2x31dBqIfwPA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7Y-00000001QcN-14vN;
	Fri, 25 Jul 2025 16:34:24 -0400
Message-ID: <20250725203424.107916458@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:33:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 John Ogness <john.ogness@linutronix.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Petr Mladek <pmladek@suse.com>,
 kernel test robot <lkp@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 01/25] objtool: Add vpanic() to the noreturn list
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

vpanic() does not return. However, objtool doesn't know this and gets
confused:
kernel/trace/rv/reactor_panic.o: warning: objtool: rv_panic_reaction(): unexpected end of section .text

Add vpanic() to the list of noreturn functions.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/073f826ebec18b2bb59cba88606cd865d8039fd2.1752232374.git.namcao@linutronix.de
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507110826.2ekbVdWZ-lkp@intel.com/
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/objtool/noreturns.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index eacfe3b0a8d1..6a922d046b8e 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -38,6 +38,7 @@ NORETURN(mpt_halt_firmware)
 NORETURN(mwait_play_dead)
 NORETURN(nmi_panic_self_stop)
 NORETURN(panic)
+NORETURN(vpanic)
 NORETURN(panic_smp_self_stop)
 NORETURN(rest_init)
 NORETURN(rewind_stack_and_make_dead)
-- 
2.47.2



