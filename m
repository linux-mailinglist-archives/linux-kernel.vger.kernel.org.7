Return-Path: <linux-kernel+bounces-881391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B277C28200
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346863AB6B3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C941DED49;
	Sat,  1 Nov 2025 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYTQqEkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3841192B84
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013003; cv=none; b=Ckhd+YyvnPhrO/w6gULA3Kujlmfn87fXOvEOzv3qxicGVrTPKQ6+O4SKwbaFlw7r5JNqibveRhwBLfcoAiIxG/fSYa5qtzztJ8FjSXC53G/YOqaD8npShoqIc5soZ439Mmydw92lka+Doo+h4sGW082C7tPsqQ7Ntd0JKpsmYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013003; c=relaxed/simple;
	bh=aa/gqAz9RaWN80zemM688XDWfvLb70mREOY7Xxyt7bk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bg9xyXmxRialN9A4zGQk8CBNbWVZAmkm9CJje82wI8wZY/ypXsvcVXigR4EmFq7TdtmuXwoKL95NkEgD5CjQvYvtUvn82lTUnHE0psr+9+YkKJcsVrBZWKXWdS9SJE3q10RXy4gqSxDrSB7OamY+C6AYZ3mW8qh6wjIMLVk8jRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYTQqEkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0188C4CEF1;
	Sat,  1 Nov 2025 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762013002;
	bh=aa/gqAz9RaWN80zemM688XDWfvLb70mREOY7Xxyt7bk=;
	h=Date:From:To:Cc:Subject:From;
	b=nYTQqEkmiview9FIhkwppkOJmXfzGLTMStxbUyib9PJblrELBRnmphn9xpmO0Un9x
	 Wiplwf/2NIIsgu5w0UAFWGhFDracx/3uMLaFB4JwlkT+1CBvP3gRZNbPoj6aH/uAGx
	 yxcMPixbN6rvi+cTbtzGi+XFwGyydeJXEGDhwrA+m5fq8rYkBArLTfkhGfDCM8LueJ
	 eVtIS0JrZavDWO+adZfriMWFwmJAQko3acGtfc8D6XspesNTWXO/XDyA0iFCpxCC4a
	 H8e+vSH8B7lodSQNn7rLUp/y0gd14CDo3UGHelgrnTacPVwizNHpe9EXuyXUutT9Yo
	 ZuuXnc8Zg60wA==
Date: Sat, 1 Nov 2025 13:03:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers: Sync uapi/linux/fcntl.h with the kernel
 sources
Message-ID: <aQYvRnFbgvCCl5ID@x1>
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

To pick up the changes in this cset:

  e83f0b5d10dcf628 ("nsfs: support exhaustive file handles")

That doesn't introduce anything of interest for tools/, just addresses
these perf build warnings:

Warning: Kernel ABI header differences:
  diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index f291ab4f94ebccac..3741ea1b73d85000 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -111,6 +111,7 @@
 #define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
 
 #define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
+#define FD_NSFS_ROOT			-10003 /* Root of the nsfs filesystem */
 #define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */
-- 
2.51.0


