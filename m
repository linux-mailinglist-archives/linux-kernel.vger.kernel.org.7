Return-Path: <linux-kernel+bounces-883391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9913C2D460
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6BE034B6BE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F69D31A562;
	Mon,  3 Nov 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdY6+cyA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7223164A6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188849; cv=none; b=huRlBqvsfhwV3LrhSGhF1lP5EIcQMdnXaOU724hzAVMgtfcvhaK2k9ier0CODzHCKQKJNVUUuRkynfz4LITkNbC/QRpEiVt5sMj9Di0ctiWTOLtuaZ6qfJDYT8EIH6Xbky3nhs7JvRiFn/96VUdTWvbESl8XRQYYZCZKD7f8vDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188849; c=relaxed/simple;
	bh=rxf/DFxOMu7y7Qzph2316RyYrDl3vWmKExiwHnpsMmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xv5XzekLkPtojUApl3BqMyeBQOTTRoyvKoZiDjoyIYKNEwhV9a3E+pR1ghbUjIfRsfQKHUPFENE4j9TVruV9z7bOtGqXQ/VWwHE236xoQd5aaF92gVROY2NhJk4ryk2x3lhlCnqT9Ko7OMcWDV1811Gph28pF4nHTaYZQqEVf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdY6+cyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D45BC4CEE7;
	Mon,  3 Nov 2025 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188849;
	bh=rxf/DFxOMu7y7Qzph2316RyYrDl3vWmKExiwHnpsMmU=;
	h=Date:From:To:Cc:Subject:From;
	b=XdY6+cyA42Brplz7GJUaE2PcFsTKELeQJvohu6P9JjxlAFFugJ8eQ21mcozkxlFnO
	 ETT4mkiQQ7/CIS/9HQyQPauxVUBRChAbznSd4Jk+xHAwyTXQh3ZySKImso1PJeYIYa
	 6S5RRlKp4h9xT14n/AdXSAy806PZdMOpTR8YIFx9LdTyuTs5YgO4nN4qMgST47b9nl
	 +3aSneB9TWcR7rHXnmSdGlCIS5qsIWRmI3mWJGw04SZVo5OJfFgovfz8wl5h44qSAW
	 kMMz05dn2bCFAzSnJq1fKV9gM6r3dMYdpXDUjwhMhlzANe+puZa0awWLapNLxh2ANp
	 UCnBrC1q9ZuFw==
Date: Mon, 3 Nov 2025 13:54:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1] tools headers asm: Sync fls headers header with the
 kernel sources
Message-ID: <aQjeLkiMCefq02my@x1>
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

  6606c8c7e8188656 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")

This addresses these tools build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/asm-generic/bitops/__fls.h include/asm-generic/bitops/__fls.h
    diff -u tools/include/asm-generic/bitops/fls.h include/asm-generic/bitops/fls.h
    diff -u tools/include/asm-generic/bitops/fls64.h include/asm-generic/bitops/fls64.h

Please see tools/include/uapi/README for further details.

Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/asm-generic/bitops/__fls.h | 2 +-
 tools/include/asm-generic/bitops/fls.h   | 2 +-
 tools/include/asm-generic/bitops/fls64.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/include/asm-generic/bitops/__fls.h b/tools/include/asm-generic/bitops/__fls.h
index e974ec932ec189f9..35f33780ca6c3727 100644
--- a/tools/include/asm-generic/bitops/__fls.h
+++ b/tools/include/asm-generic/bitops/__fls.h
@@ -10,7 +10,7 @@
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned int generic___fls(unsigned long word)
+static __always_inline __attribute_const__ unsigned int generic___fls(unsigned long word)
 {
 	unsigned int num = BITS_PER_LONG - 1;
 
diff --git a/tools/include/asm-generic/bitops/fls.h b/tools/include/asm-generic/bitops/fls.h
index 26f3ce1dd6e44872..8eed3437edb95c1c 100644
--- a/tools/include/asm-generic/bitops/fls.h
+++ b/tools/include/asm-generic/bitops/fls.h
@@ -10,7 +10,7 @@
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __always_inline int generic_fls(unsigned int x)
+static __always_inline __attribute_const__ int generic_fls(unsigned int x)
 {
 	int r = 32;
 
diff --git a/tools/include/asm-generic/bitops/fls64.h b/tools/include/asm-generic/bitops/fls64.h
index 866f2b2304ff639f..b5f58dd261a3707d 100644
--- a/tools/include/asm-generic/bitops/fls64.h
+++ b/tools/include/asm-generic/bitops/fls64.h
@@ -16,7 +16,7 @@
  * at position 64.
  */
 #if BITS_PER_LONG == 32
-static __always_inline int fls64(__u64 x)
+static __always_inline __attribute_const__ int fls64(__u64 x)
 {
 	__u32 h = x >> 32;
 	if (h)
@@ -24,7 +24,7 @@ static __always_inline int fls64(__u64 x)
 	return fls(x);
 }
 #elif BITS_PER_LONG == 64
-static __always_inline int fls64(__u64 x)
+static __always_inline __attribute_const__ int fls64(__u64 x)
 {
 	if (x == 0)
 		return 0;
-- 
2.51.1


