Return-Path: <linux-kernel+bounces-889357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D80C3D5DD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4EF1887E36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8579230F7FD;
	Thu,  6 Nov 2025 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BilsIi7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCC27F171;
	Thu,  6 Nov 2025 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461249; cv=none; b=RcEhioK2VCknoVu0eQxDf3ReoZeWFLmAglBEzuhzLvKIV3e5/5NJkrE9ksi80vU9LbifVrXPL80Yb/kEV8z5BOlL60iDEbwub5yadMjK5fv4iKSNY51h/Vvoqy2N6IDg93tRoCYKwwde9OaJ3sHdONPz2cyvRAmzxpxNZPE9cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461249; c=relaxed/simple;
	bh=yFE45xUeyRToW/LYfuSzBROugsxOLDRHIwVj4mqpocY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHI/aji0q/GOxYUynxhPvm8xbfxZBkYEXPKzzQ1ucD07bRX/1clFJvWXQLlyswTf2hA+TfVGQNOhOrpb4kvjSVf+z4fPti9VSarQTPnsvNpGZy9jycCzPd7ofsmT1Jwig0ULcpoC2sW+oV4VCj1Xc/vr2jZc4JqdwvkAt064/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BilsIi7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435F4C4CEFB;
	Thu,  6 Nov 2025 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762461248;
	bh=yFE45xUeyRToW/LYfuSzBROugsxOLDRHIwVj4mqpocY=;
	h=From:To:Cc:Subject:Date:From;
	b=BilsIi7KzQuRkIY3JpJDUObJuBcaGlU1uirt6lLAWSgYNpJnLlPKNnkxASoC3J1Zd
	 orjWg/16XkBWUK/Y9W9xN00WksNptGbyMxR7Ykob2H/sCeOWzGUUDpfEye8g7CsTVU
	 b+Usq2YC0ObyKPLZR42s9X5iDkgZUyXRLcfl3BPp/nP8wq7VpOC2LFRy4YJ+9Ft8K2
	 KeTbN1pjxZ35hekuaUxRcwwRtzULhaBtdRqhiAHWecFHtc09JCFAI6b5CxxdxjwzZl
	 jCWyUSA7w3v0mtNSz0YZaCKwUARO7/a3IIuKdmBLwgk8DUCl9rLqBOz7s8ihfgrCCj
	 eLeII2VsG258g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.18
Date: Thu,  6 Nov 2025 17:33:53 -0300
Message-ID: <20251106203353.919035-1-acme@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2025-10-31 18:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.18-1-2025-11-06

for you to fetch changes up to 7f17ef0d47b9aa01b89a92b2514fbfe800d8aeca:

  perf symbols: Handle '1' symbols in /proc/kallsyms (2025-11-03 14:54:31 -0300)

----------------------------------------------------------------
perf tools fixes for v6.18:

- Add James Clark as a perf tools reviewer.

- Handle '1' type symbols in /proc/kallsyms, related to anonymous Rust closures
  in the DRM panic QR encoder, caught by 'perf test'.

- Sync kernel header copies: MSRs, uprobe syscall, DRM_IOCTL_GEM_CHANGE_HANDLE,
  KVM exit reasons, etc.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (14):
      tools arch x86: Sync msr-index.h to pick AMD64_{PERF_CNTR_GLOBAL_STATUS_SET,SAVIC_CONTROL}, IA32_L3_QOS_{ABMC,EXT}_CFG
      tools headers uapi: Update fs.h with the kernel sources
      tools headers: Sync uapi/linux/prctl.h with the kernel source
      tools headers: Sync uapi/linux/fcntl.h with the kernel sources
      tools headers x86: Sync table due to introducion of uprobe syscall
      tools headers x86 cpufeatures: Sync with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h to pick DRM_IOCTL_GEM_CHANGE_HANDLE
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      MAINTAINERS: Add James Clark as a perf tools reviewer
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools headers svm: Sync svm headers with the kernel sources
      tools headers UAPI: Sync KVM's vmx.h header with the kernel sources to handle new exit reasons
      tools headers asm: Sync fls headers header with the kernel sources
      perf symbols: Handle '1' symbols in /proc/kallsyms

 MAINTAINERS                                        |  1 +
 tools/arch/x86/include/asm/cpufeatures.h           |  5 ++
 tools/arch/x86/include/asm/msr-index.h             | 20 ++++++-
 tools/arch/x86/include/uapi/asm/kvm.h              | 34 ++++++++++++
 tools/arch/x86/include/uapi/asm/svm.h              |  4 ++
 tools/arch/x86/include/uapi/asm/vmx.h              |  6 ++-
 tools/include/asm-generic/bitops/__fls.h           |  2 +-
 tools/include/asm-generic/bitops/fls.h             |  2 +-
 tools/include/asm-generic/bitops/fls64.h           |  4 +-
 tools/include/uapi/drm/drm.h                       | 63 +++++++++++++++++-----
 tools/include/uapi/linux/kvm.h                     |  3 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h |  1 +
 tools/perf/trace/beauty/include/uapi/linux/fs.h    |  5 +-
 tools/perf/trace/beauty/include/uapi/linux/prctl.h | 10 ++++
 tools/perf/util/symbol.c                           |  6 ++-
 16 files changed, 147 insertions(+), 20 deletions(-)

