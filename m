Return-Path: <linux-kernel+bounces-749275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E763DB14C37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC144E6068
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4328A1E4;
	Tue, 29 Jul 2025 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx8BZDMK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3568633F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785009; cv=none; b=D+XD0waK6Ypd8w3TUfIqePoHXnTekKeHEKY+xHvpNok0EfZAmtUPNKzQOJXcdzmOtgtycT6pwJPF3/INNYp2wLd0d1UMPlNN/C1NUdhwbmuo8I+mTOqrPgzj0Mdt1l5iK66iPg5I0WG4zW7wR8D/ltpIsJ4LeqzFbEXZzlmdT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785009; c=relaxed/simple;
	bh=RHKBe9feYBm7P2xs18cmwRFRksTsCYDPPsP7rqksKP8=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=u+arh+KrabIm9VQfP3kYRIyJBzD5JbCk5ktM7heT/aPc+YHakHO8Sjccrztsk6luxojhoCbnE83TuVyCGYYQv3dfnCHcdkkFrg9aW1VK0akzaexLMw0/KGZah3JjNBvuU/XpKzGJirxpMsuqar+T7bpFdKfaPkpCVX/h4J/mZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx8BZDMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13481C4CEF5;
	Tue, 29 Jul 2025 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753785009;
	bh=RHKBe9feYBm7P2xs18cmwRFRksTsCYDPPsP7rqksKP8=;
	h=Date:From:To:Cc:Subject:From;
	b=Qx8BZDMKFyQpW76c1ByBoJLHhagNV+33jTstSRWRj++VVmAdrtNQ3/cyTEdjr/25e
	 ttV/HC+kMzXJbA/0+FIkm6FylCKTZEujnocduyOMcKaZ+JJxWRWWrXtNlUrB6zJn2A
	 82UaGXdSNczdega3RukL22nVUWFjsYt1HIWVabrxedsvXHB54hFu3Vlnrr8d2JirDJ
	 7jGBs7IKujk3lhYv9wSYUC3/sv3vGnY2Bu5u1XliyK2JBeawHs3Ge+bl23qXAziw75
	 oMoEFYZFsAe0+DzWgnqGNoI35koAtIUSvUjNzirAYlREQOOIVbzsP2qqk5w/lcQtBp
	 39DKdzIE1ernA==
Date: Tue, 29 Jul 2025 19:30:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.16
Message-Id: <20250729193005.348d7df8206d3e9ac438fd57@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.16:

 - Fix a potential infinite recursion in fprobe by using preempt_*_notrace().


Please pull the latest probes-fixes-v6.16 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.16

Tag SHA1: 1d7c77d4dfae320b756b5d0bcd04ecce5a38fbeb
Head SHA1: a3e892ab0fc287389176eabdcd74234508f6e52d


Masami Hiramatsu (Google) (1):
      tracing: fprobe: Fix infinite recursion using preempt_*_notrace()

----
 kernel/trace/fprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
commit a3e892ab0fc287389176eabdcd74234508f6e52d
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Tue Jul 29 08:47:03 2025 +0900

    tracing: fprobe: Fix infinite recursion using preempt_*_notrace()
    
    Since preempt_count_add/del() are tracable functions, it is not allowed
    to use preempt_disable/enable() in ftrace handlers. Without this fix,
    probing on `preempt_count_add%return` will cause an infinite recursion
    of fprobes.
    
    To fix this problem, use preempt_disable/enable_notrace() in
    fprobe_return().
    
    Link: https://lore.kernel.org/all/175374642359.1471729.1054175011228386560.stgit@mhiramat.tok.corp.google.com/
    
    Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
    Cc: stable@vger.kernel.org
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ba7ff14f5339..f9b3aa9afb17 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -352,7 +352,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 	size_words = SIZE_IN_LONG(size);
 	ret_ip = ftrace_regs_get_instruction_pointer(fregs);
 
-	preempt_disable();
+	preempt_disable_notrace();
 
 	curr = 0;
 	while (size_words > curr) {
@@ -368,7 +368,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 		}
 		curr += size;
 	}
-	preempt_enable();
+	preempt_enable_notrace();
 }
 NOKPROBE_SYMBOL(fprobe_return);
 
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

