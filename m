Return-Path: <linux-kernel+bounces-879058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E13C222C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C981A20831
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0BE380F26;
	Thu, 30 Oct 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgOdRmjn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA6381E40
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855024; cv=none; b=YuYdkqB8adQNhSCJ/fsIeeh/GfsuAkSWbmRq1lx/k1K6JM/GsZgQcBO7F02rlfdCfuZzSuXpwEoJeeisqjgMIUFrP6FRhkI4slY756MDZK5JGdWz0/mYwjW8FV4wWRzflES4bNDYapDgBf4DewTq6QXJJuVGQ9xaVyWaib5VDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855024; c=relaxed/simple;
	bh=nTifo0zFDHu6FVLLGMm4PK4AB5FvqMdbXF3A+DZOb5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HS1Tg0T3No+GpjCR0pqxdVJhCBaSMSdVZMlkO8Ich0n9Rj4tcIiZTcQZukAYGdiKBglHK4E0eJsKa6hTAepDYvVhPGAUedRh3NnQmA/+YyHjBIrGMmVnwFhv5+VcZJrOxc0MBv9foO7f9fQ2GYAkIpQ5CufmCXQiX/xWf4u0uNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgOdRmjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168CC4CEF8;
	Thu, 30 Oct 2025 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761855023;
	bh=nTifo0zFDHu6FVLLGMm4PK4AB5FvqMdbXF3A+DZOb5c=;
	h=Date:From:To:Cc:Subject:From;
	b=OgOdRmjnuBT8pWj2I7IR47H0LlNnqD7An+c+ruARmiUEb+fol/2nJgFJCJya+irbK
	 J8IXBV1fyia0df0lLEq27WzkoE1aeVeCdUS6LJ0chnFgOufpc+LMhtZ5ASyc+RibtD
	 67Sdb1PAYvHl7BOF0frKmkGbQcbNH1F5DQI0gCpv8ViEJ2kDONHGF/WUVkZGuNU/BB
	 Me/jd5Pi+2OxN5kcM6j2SGJAIg77Ge/9UB68CBP/dqHnZ8McdHA850KN93Lfn5B1oI
	 uVOh7KUc1LTmvCouOrw0z/0AH6IOBHgXLdLXbzYaDbkk7rxdyplc62qu1EIt6Nz+2Z
	 9qPJhJvCvZ2Tw==
Date: Thu, 30 Oct 2025 17:09:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Lauri Vasama <git@vasama.org>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers uapi: Update fs.h with the kernel sources
Message-ID: <aQPF8gVMhK7JHIRV@x1>
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

To pick up changes from:

  db2ab24a341ce893 ("Add RWF_NOSIGNAL flag for pwritev2")

These are used to beautify fs syscall arguments, albeit the changes in
this update are not affecting those beautifiers.

This addresses these tools/ build warnings:

  Warning: Kernel ABI header differences:
  diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h

Please see tools/include/uapi/README for details (it's in the first patch
of this series).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lauri Vasama <git@vasama.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index 0bd678a4a10ef854..beb4c2d1e41cb1bb 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -430,10 +430,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* buffered IO that drops the cache after reading or writing data */
 #define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
 
+/* prevent pipe and socket writes from raising SIGPIPE */
+#define RWF_NOSIGNAL	((__force __kernel_rwf_t)0x00000100)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
-			 RWF_DONTCACHE)
+			 RWF_DONTCACHE | RWF_NOSIGNAL)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
-- 
2.51.0


