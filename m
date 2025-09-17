Return-Path: <linux-kernel+bounces-821764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65077B822F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAF77BA0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B730FC0F;
	Wed, 17 Sep 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+Z9zdoC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4DF3112A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149216; cv=none; b=T10gDuOdtTyo6xJ/9U05weIbz382W4aFIdNnxjkZN5shZMr3pz+8FWdbsmbhEo3X4Yw9FbcLFGfCKl0ftH1uQjCuvqz21ECX7tyAdmZbtD17gpKVlKYOuncckmacngzhl6+6iO95qVqmzy3bd9nhIi0+SB5rgg1IQGn+SfYfHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149216; c=relaxed/simple;
	bh=LlKlnIkb/uhYi19BID0vhoWyhvmzW1tnVCvq2ITLLwQ=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=WaTiLnYnICcciXtuCNdYvqCNAflLwe3mfpEYlBkhs82fuXh0VJ5me0zeKR9f2lIEDukd/LSpjwFKXSp3+B3NGHxKTDMvZ/qxO907W6+z/PCFThJNVc9uxul/bWXWHGNGFBVFmGKQZMN0W7JeXnSZXTLh+eDAYbO1oQZBMBjm5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+Z9zdoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A7FC4CEE7;
	Wed, 17 Sep 2025 22:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758149216;
	bh=LlKlnIkb/uhYi19BID0vhoWyhvmzW1tnVCvq2ITLLwQ=;
	h=Date:From:To:Cc:Subject:From;
	b=G+Z9zdoCxNq/d1l83sbQDpfL/oe0NW7x+73bVPbeKAaBDqq2fkd2p79asYP/z7Nfw
	 HLs8W3cqbignBwnpkNL8WFEcx7nExANHKPM0APB8wDEDVWWxOvBfBnCSkgGmtNLsI5
	 rVcGLdWkbBeGqoVE4G2u07xEIh9obxWIF0IRqd0pZKaCZ5tKHKHszoaYtMk40vn2G9
	 2MyBO0x8tGauRtNTJWv+jSnRY3A1P0EGxGRP5OxD7LVL0wk/t+wVDrxxixKMw3/7+U
	 laYkdcF44n/PMTEAJNiiz4yYKziesVD1QQpJrwBjboboWM7wpSe3um/K0uX4XR4vvu
	 HMR7MmVU0bc5Q==
Date: Thu, 18 Sep 2025 07:46:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wang Liang <wangliang74@huawei.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.17-rc6
Message-Id: <20250918074652.b9d4842fb41b5bd810b1add7@kernel.org>
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

Probes fixes for v6.17-rc6:

- kprobe-event: Fix null-ptr-deref in trace_kprobe_create_internal(),
  which handles NULL return of kmemdup() correctly.


Please pull the latest probes-fixes-v6.17-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.17-rc6

Tag SHA1: 53d1ffce26bf97c7170952518cadb4445b4c1ba7
Head SHA1: dc3382fffdec2c1d6df5836c88fa37b39cd8651e


Wang Liang (1):
      tracing: kprobe-event: Fix null-ptr-deref in trace_kprobe_create_internal()

----
 kernel/trace/trace_kprobe.c | 2 ++
 1 file changed, 2 insertions(+)
---------------------------
commit dc3382fffdec2c1d6df5836c88fa37b39cd8651e
Author: Wang Liang <wangliang74@huawei.com>
Date:   Tue Sep 16 15:58:16 2025 +0800

    tracing: kprobe-event: Fix null-ptr-deref in trace_kprobe_create_internal()
    
    A crash was observed with the following output:
    
    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
    KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
    CPU: 1 UID: 0 PID: 2899 Comm: syz.2.399 Not tainted 6.17.0-rc5+ #5 PREEMPT(none)
    RIP: 0010:trace_kprobe_create_internal+0x3fc/0x1440 kernel/trace/trace_kprobe.c:911
    Call Trace:
     <TASK>
     trace_kprobe_create_cb+0xa2/0xf0 kernel/trace/trace_kprobe.c:1089
     trace_probe_create+0xf1/0x110 kernel/trace/trace_probe.c:2246
     dyn_event_create+0x45/0x70 kernel/trace/trace_dynevent.c:128
     create_or_delete_trace_kprobe+0x5e/0xc0 kernel/trace/trace_kprobe.c:1107
     trace_parse_run_command+0x1a5/0x330 kernel/trace/trace.c:10785
     vfs_write+0x2b6/0xd00 fs/read_write.c:684
     ksys_write+0x129/0x240 fs/read_write.c:738
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0x5d/0x2d0 arch/x86/entry/syscall_64.c:94
     </TASK>
    
    Function kmemdup() may return NULL in trace_kprobe_create_internal(), add
    check for it's return value.
    
    Link: https://lore.kernel.org/all/20250916075816.3181175-1-wangliang74@huawei.com/
    
    Fixes: 33b4e38baa03 ("tracing: kprobe-event: Allocate string buffers from heap")
    Signed-off-by: Wang Liang <wangliang74@huawei.com>
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ccae62d4fb91..fa60362a3f31 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -908,6 +908,8 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 			return -EINVAL;
 		}
 		buf = kmemdup(&argv[0][1], len + 1, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 		buf[len] = '\0';
 		ret = kstrtouint(buf, 0, &maxactive);
 		if (ret || !maxactive) {

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

