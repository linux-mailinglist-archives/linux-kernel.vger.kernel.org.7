Return-Path: <linux-kernel+bounces-732931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A60B06DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4567B12B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9CE27A468;
	Wed, 16 Jul 2025 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOVqfcU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A658634A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646926; cv=none; b=mdzpPfjU0XlFb8lBG+i1kEZvTEsBdGyOviSRw1uUDYKhoalwAql0FnIeXD0xpr1o8TxScyjIqe9sqJTmbY1RHCD+1Vbbm8zbPDF+jkQoRI6yPXII6sQpoXftOMZNHptbo6DyQ9REvv/aFGsPMosNpYIOjys2AGRNJoC43JyRD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646926; c=relaxed/simple;
	bh=bXNk16FOygbRrE7KsD8GybCSS+DLDh0tykW0TLKfrJQ=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=bLn0Kk4I2JTf6+4auKU3dvr5aK+t/eaT0c1IjgholMzG7BFEW440CaRkte9BLa7+k9spDQ/x2C2vls/XfSfffnxlaYXyW0RnNskSfgO9REk3bU+VVn9VljuyUFP5Y+rJE2ZjQg8Oz2tK0PU41o/IF1bUj+U8j1oqZj1G4C1ZOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOVqfcU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421FDC4CEF0;
	Wed, 16 Jul 2025 06:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752646925;
	bh=bXNk16FOygbRrE7KsD8GybCSS+DLDh0tykW0TLKfrJQ=;
	h=Date:From:To:Cc:Subject:From;
	b=fOVqfcU0PAg8eLm0AByPsXZe7hVlXCZL9QQITrFre0AowTrb1rgm6KTExOKTghjuy
	 8yaVuX2os0PDMP/NDaLkjNYg7fv2SuYObWLtXMVsY9PsEsBWs75mAOg/hoqpu+1HkD
	 OlJV20v3bWVyJ3R5/6AUK+VBvNymLxMQ4hYJhdtWooyxEqUhrnEjDsODz05dJnvnD7
	 eplL84fgNsV+dahvPUPAjEzu+MNEDts2QshI+voGPnzGtIkugW5h8cddeltrKgQ63f
	 AZzz34mqWSk6i+hEbsjhsh4V86huUORQtMpqVfuTHS0IWhZPFSz+tZIaeO6r6QWg5O
	 26Qp8Oa0vpF1g==
Date: Wed, 16 Jul 2025 15:22:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: fixes for v6.16
Message-Id: <20250716152201.58f9402c011e18f8b0c904ac@kernel.org>
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

Probes fixes for v6.16-rc6:

 - fprobe-event: The @params variable was being used in an error path
   without being initialized. The fix to return an error code.


Please pull the latest probes-fixes-v6.16-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.16-rc6

Tag SHA1: ce8ff29973d1200622606428e017c32f36535d8a
Head SHA1: 1ed171a3afe81531b3ace96bd151a372dda3ee25


Nathan Chancellor (1):
      tracing/probes: Avoid using params uninitialized in parse_btf_arg()

----
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 1ed171a3afe81531b3ace96bd151a372dda3ee25
Author: Nathan Chancellor <nathan@kernel.org>
Date:   Tue Jul 15 20:19:44 2025 -0700

    tracing/probes: Avoid using params uninitialized in parse_btf_arg()
    
    After a recent change in clang to strengthen uninitialized warnings [1],
    it points out that in one of the error paths in parse_btf_arg(), params
    is used uninitialized:
    
      kernel/trace/trace_probe.c:660:19: warning: variable 'params' is uninitialized when used here [-Wuninitialized]
        660 |                         return PTR_ERR(params);
            |                                        ^~~~~~
    
    Match many other NO_BTF_ENTRY error cases and return -ENOENT, clearing
    up the warning.
    
    Link: https://lore.kernel.org/all/20250715-trace_probe-fix-const-uninit-warning-v1-1-98960f91dd04@kernel.org/
    
    Cc: stable@vger.kernel.org
    Closes: https://github.com/ClangBuiltLinux/linux/issues/2110
    Fixes: d157d7694460 ("tracing/probes: Support BTF field access from $retval")
    Link: https://github.com/llvm/llvm-project/commit/2464313eef01c5b1edf0eccf57a32cdee01472c7 [1]
    Signed-off-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 424751cdf31f..40830a3ecd96 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -657,7 +657,7 @@ static int parse_btf_arg(char *varname,
 		ret = query_btf_context(ctx);
 		if (ret < 0 || ctx->nr_params == 0) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
-			return PTR_ERR(params);
+			return -ENOENT;
 		}
 	}
 	params = ctx->params;
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

