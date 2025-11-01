Return-Path: <linux-kernel+bounces-881406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E852C2824F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE253B0536
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2E1DFE26;
	Sat,  1 Nov 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIBh4tfl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAE231C9F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013532; cv=none; b=Bi+JqCjSjdac5xG5Ynpsi1jPkpxRr2J4mU2VnL/V1gy1lnOse8DrNDSdb8YPF9XG5h8JQ9LSSMGCFrqWWlX27gxaep5TfmUqWaIq4mTfeZ/H6QdthLgmNcyK+4vdepQyiHMwlhXeGMdak6+f2zGpATRPK88Tfg1nF6G234wgFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013532; c=relaxed/simple;
	bh=dqWRi5SzLBO3lxw4syQZjPJpjVm/CA0eEcTHZOlLyNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A6/F/z/s4neHbb7FSJiF52Y80wUr9C5XaBsrwIEU5t+ppS2aLxVz/RVhgfMEdKiQq4mDKOwIMt8PFuhbo8e/y0pRBb+cjIJdxnFrzcOE8oUFGMEZEi4p7X9NvijHZSbQtk6SQJ/qpcJ+Tt3N+NZJ8yjzjGjefAuamPoW20UzyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIBh4tfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E4EC4CEF1;
	Sat,  1 Nov 2025 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762013531;
	bh=dqWRi5SzLBO3lxw4syQZjPJpjVm/CA0eEcTHZOlLyNg=;
	h=Date:From:To:Cc:Subject:From;
	b=bIBh4tfllnpfk3+19vBy+2N6oAZjC2vXypv2b4qR6biTStL1T41FoOiCyZBYrU6NV
	 96HUWCFKrgmZuJSi9tnkb0w5SnplXBFMUoCOaRvrkt2oMgjrz3JOIRH+l7t1yn1Ybo
	 fkXHMFkgnKXVNZassVq/3+6EJCWIwmfGrdxuyDRDo4brM4LJt6civU4ozlus6teYq0
	 yalaDw3P3/jT2BzF7hM43PZClttJMeatNTCtxooBEOZqWqaiRAV6izaacf/54M1Nf9
	 KdeECZJmpyNBrzxssjDYg9NU6XUPB8hQOrqegYrcM+cuhFIj6V4WkMompNrHGTUJJp
	 jOYoqfNKTlD5g==
Date: Sat, 1 Nov 2025 13:12:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers x86: Sync table due to introducion of
 uprobe syscall
Message-ID: <aQYxWEtq-UE0ALFU@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick the changes in this cset:

  56101b69c9190667 ("uprobes/x86: Add uprobe syscall to speed up uprobe")

That add support for this new 'uprobe' syscall in tools such as 'perf trace'.

Now it is possible to do a system wide 'perf trace' to look if this new
syscall is being used:

  root@number:~# perf trace -v -e uprobe
  <SNIP>
  event qualifier tracepoint filter: (common_pid != 33989) && (id == 336)
  ^C
  root@number#

  $ grep -w uprobe tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
  336	common	uprobe			sys_uprobe
  $

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl

Please see tools/include/uapi/README for further details.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 92cf0fe2291eb99b..ced2a1deecd7ce08 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,7 @@
 333	common	io_pgetevents		sys_io_pgetevents
 334	common	rseq			sys_rseq
 335	common	uretprobe		sys_uretprobe
+336	common	uprobe			sys_uprobe
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	sys_pidfd_send_signal
-- 
2.51.0


