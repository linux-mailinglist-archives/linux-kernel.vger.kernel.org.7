Return-Path: <linux-kernel+bounces-881389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E6C281F7
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2E944E8B4F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932132F6182;
	Sat,  1 Nov 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLBQIVT+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED087239E88
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762012717; cv=none; b=UDWwo/sbnz8gRhsw1HUTmbeVxJQjV6ulKAW3y9laUN69udnlStbOt8cA1Ci6MSKvWsFV8V/9gNDTu+/LkbGfnBwZPIxikR66TWjJ5NSrN12VoVyEGphxg35yii1wtDLApmVlzgTBovQ/DpTUXkbTbK48na+FYKvsz0YO1rRkD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762012717; c=relaxed/simple;
	bh=6tWmvGVZaEyV/y+Aw/Nze1yFnX1SEltkmc+pb7BxqEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jjP7aAROxHZ2t1blFkDniF16n2+4o25YkzeaHWAlCCDPI3s4wieNtyG6V5UtvMnb+JDO65n22wWTDAOUt3nLFXlXyoS/LejgiRdwlbggdEpDBKQMVhq12Rz6oLn6Vf7YP+7PCZcSaifNbIx8jcEE03gm/d7Zi2bRo8Xf20HgRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLBQIVT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082EDC4CEF1;
	Sat,  1 Nov 2025 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762012716;
	bh=6tWmvGVZaEyV/y+Aw/Nze1yFnX1SEltkmc+pb7BxqEY=;
	h=Date:From:To:Cc:Subject:From;
	b=bLBQIVT+TR7tpOo71x1leG2gDv1ENVqhXFTML5bF+MlVhVKO2qBFbwywZDPSci5hv
	 zNxeVHR9rWgsgkhj0Ix5eKGBKeKYNDW2t/TSXmi8oDRZ3sbdEYuCbVfj5uOp+2gmm6
	 TEweA+v2DWHTK9hsKi/biOT0DeKaj52s+bdiNH3r/hyyqoyH4VUe93bvS6jL1R4Jz5
	 rt4dP/BqCNjIhYgTgQ8GAuPRwpHPQxEVOO08ZOCqoldKGLGIeU7nl829J93Z1Fcgg0
	 XAo7RgYCYlH0rUPgT6PdvhMrI10trP8NmfqXYEy52hYxwmKxuugKdQcVPJkCX4859m
	 t+d1pCC39EHjA==
Date: Sat, 1 Nov 2025 12:58:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers: Sync uapi/linux/prctl.h with the kernel
 source
Message-ID: <aQYuKOCLkAr23Quw@x1>
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

To pick up the changes in these csets:

  8cdc4d27019356b0 ("mm/huge_memory: respect MADV_COLLAPSE with PR_THP_DISABLE_EXCEPT_ADVISED")
  9dc21bbd62edeae6 ("prctl: extend PR_SET_THP_DISABLE to optionally exclude VM_HUGEPAGE")

That don't introduce anything of interest for the tools/, just
addressing these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Please see tools/include/uapi/README for further details.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/prctl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
index ed3aed264aeb2881..51c4e8c82b1e9889 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -177,7 +177,17 @@ struct prctl_mm_map {
 
 #define PR_GET_TID_ADDRESS	40
 
+/*
+ * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
+ * is reserved, so PR_GET_THP_DISABLE can return "1 | flags", to effectively
+ * return "1" when no flags were specified for PR_SET_THP_DISABLE.
+ */
 #define PR_SET_THP_DISABLE	41
+/*
+ * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
+ * VM_HUGEPAGE, MADV_COLLAPSE).
+ */
+# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
 #define PR_GET_THP_DISABLE	42
 
 /*
-- 
2.51.0


