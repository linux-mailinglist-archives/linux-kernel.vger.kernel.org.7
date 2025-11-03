Return-Path: <linux-kernel+bounces-883228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB6C2CF64
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1602D620E9A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8A1283FF9;
	Mon,  3 Nov 2025 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzhajc3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23818EFD1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183331; cv=none; b=mEu5zZKQuRAMUZEr5upS0RdXpg17nbWwU2VoUu+WpkHR5ftwk2dl3yRMFVY5cPKtQJxttuZ0UQf9U9jGR4Y53UubST1aaCHJZkjqu7yhHUfxGoA2Bp+Ro3d3EmWj7v61uFz8KmwElv6aSaMiTfVWBBtfS6ACc+wQiof4hyy97zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183331; c=relaxed/simple;
	bh=5khjE9Wr9VYi984UYLWA8s+1bl7n3Pz2O2JZ0gCcz/s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=idIP0KNaqfDM6jvwk8m0URU+JJ+BdDZkKNw8TCnjkZLpbLFPMEJllS4u0UAI+YDbj/Ps445ODMeui2eS0Yu0tI/bkrQAPQdHlhHSaRlVxs3gjEx/xGXh3P5tB9LFxkMDWYpGWwBMjZqjrYyJExcThdL6vEh87Aim8UwqgbtHd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzhajc3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C894DC4CEE7;
	Mon,  3 Nov 2025 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762183331;
	bh=5khjE9Wr9VYi984UYLWA8s+1bl7n3Pz2O2JZ0gCcz/s=;
	h=Date:From:To:Cc:Subject:From;
	b=Zzhajc3LuJCLiGNi9T7RXcRe+mx/I4cXmuWILsX8e9CxmcxhI4PGTi479apG7YI3H
	 ni22VwrBdVEBpzOcQFXAyXTOjjzLqECtXfwETL0I/ZDkXGi+B0rZWI4jzqYm+oatQk
	 X7n1qDJK84mtonK32k160JX2IjqbTlJ0W8d6G+qQS1TH2SlAZQ+LGNtugoObOwhWa6
	 flOO0Q3doxt3sxoWR9NLLPHQjCz4mDcuCnz2jw5D9cXFuUcBfWqcCiTEfkd4UXv0XI
	 +Ka2G3sTsM3rpBEoDPIIqKeQj6fWKE+PHdZA1y0FU/Yhs1Dj92vPTmdbHPtjNR9WOh
	 lpUECJMCZwVoA==
Date: Mon, 3 Nov 2025 12:22:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers svm: Sync svm headers with the kernel
 sources
Message-ID: <aQjIoIDY94n336Hw@x1>
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

To pick the changes in:

  b8c3c9f5d0505905 ("x86/apic: Initialize Secure AVIC APIC backing page")

That triggers:

  CC      /tmp/build/perf-tools/arch/x86/util/kvm-stat.o
  LD      /tmp/build/perf-tools/arch/x86/util/perf-util-in.o
  LD      /tmp/build/perf-tools/arch/x86/perf-util-in.o
  LD      /tmp/build/perf-tools/arch/perf-util-in.o
  LD      /tmp/build/perf-tools/perf-util-in.o
  AR      /tmp/build/perf-tools/libperf-util.a
  LINK    /tmp/build/perf-tools/perf

But this time causes no changes in tooling results, as the introduced
SVM_VMGEXIT_SAVIC exit reason wasn't added to SVM_EXIT_REASONS, that is
used in kvm-stat.c.

And addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h

Please see tools/include/uapi/README for further details.

Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/svm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/svm.h b/tools/arch/x86/include/uapi/asm/svm.h
index 9c640a521a67006d..650e3256ea7d7339 100644
--- a/tools/arch/x86/include/uapi/asm/svm.h
+++ b/tools/arch/x86/include/uapi/asm/svm.h
@@ -118,6 +118,10 @@
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018
+#define SVM_VMGEXIT_SAVIC			0x8000001a
+#define SVM_VMGEXIT_SAVIC_REGISTER_GPA		0
+#define SVM_VMGEXIT_SAVIC_UNREGISTER_GPA	1
+#define SVM_VMGEXIT_SAVIC_SELF_GPA		~0ULL
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
 #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
-- 
2.51.1


