Return-Path: <linux-kernel+bounces-731723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51564B058A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EFA7B3A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE042D948C;
	Tue, 15 Jul 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LT1+Hunb"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09921547C9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578599; cv=none; b=EuCegQGwkdoT4GgYJpm6AlLD0mLdnJkkMoan2YmcdlPI4QPdqj6Q/qVkIWQcHCnwjwv+1UgAK0kb1fIs9jXT6BZCvSAJU7ttg7YIbmT9O4dgoGCOAtcCXpQe9aBh2HlD3R2VrcDL+1ftXnLMmzAHK9hfRg7VWMi3qZEc8VpnMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578599; c=relaxed/simple;
	bh=IY0RYliD52Wg81NkyznsIfbLs+A8l+WlswZeYFbvDtU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uCfsms7HAuqgc6sUTkSeNKUKJFupVlHBYQwxOPMPZ8bK28AWNuEGF917egNybKgLcsRNdIcsgCACqK+2OH3SSTIWlMu7J0+SfsSA8BTli3POouRFKAE6t7/JwcGzDJe0CF2Z/fhdkIG1nnQtioF4ohCxoME169JwrvMRxG/l6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LT1+Hunb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3138b2f0249so4337826a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752578597; x=1753183397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4NcnVHT6qn7BJ6Ec3gjN6DJVTr3Q8w/Kv+WVRHHdtL8=;
        b=LT1+HunbmHPmfaBZkk0c6U0u0nY2XMys8P+ish4ovpjEtMU5+qpsSfZ8Z8Fmg0+85o
         f/alJDM81uA1EfywJYJpG+YMCKyYOwy6iJU8aoPritUulmFir6JKKXYlSA5uJC2fT+1z
         gMgxWLn4i0BSN98p0wb65+YXGCh6eWPXIDl4a6E0Zu5oHQr6y3fwMBIbyjmI8lvdaIeS
         K2DKF565O2iV7Y0Jr/vmYQwmB7kHczDMIEZPJcFqMwIMe0sLJ6sctM21mmtSWb/h1EZP
         4LvIw87V6jAjHZ9q4WpAoZDneOoSi86NC3RyRdylx0l7ZP2fKMEayui2VupGSsQvfQ0/
         QPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578597; x=1753183397;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NcnVHT6qn7BJ6Ec3gjN6DJVTr3Q8w/Kv+WVRHHdtL8=;
        b=sBdqyxjIKX1k+M1Lh/wEAzjGwuGfjdgyJTm3FjiyYvYihr4Dc7bc80JORv1nvAAT+A
         Evdwdmi7LDlfoYdHRifOASHMATBWQTOuaGtyLMyqxYQbYH3KaEYkWgplvxvwevKOKn06
         ZEY6Y8+kNbpRZBH5sJU/DQFJmS5/pdZPsu/0aeqoreLjL5tjIevHfjw1dcwfaZb77Fis
         V9uUpTwdelyFAcyZIO1BPufoHFCic6+gIGVp/bOQXrGYMWgomKa2f3WaixPetZg/vCpO
         QLRjnzIuQG6pghiTlQpTGQ30+4hLSPk+oom5feKVUymYbpBsE1oKhHAdbsSXNgpFJwdt
         bNwA==
X-Gm-Message-State: AOJu0YxfNaKy0BYi9QKkHAJ4y7i7JkpbwnHHB/kwdNfO95mJHg+LVpSx
	UEUwuUkX7wUr81r3pPXcJ0fbv5N/waZOIXylJqhMO0zxUdeSzwgezrRJg9VLqTMOZZ4CG08lFzW
	V+D/KG6dP25bEHvKj7GW4OTGaYk3PeWDL5vzwba/ZJHB8Wq8LeWDUmqw=
X-Gm-Gg: ASbGncu42jX+LRJuMYe5NAOXCbpetYqJNfyvJteJ4dvxev9gcDkzYiV1xe0T6ZcCNPe
	WJ36aYuRHNeyruRAg6uz0X68YQ73HnbZwiqA9cUx9dMPGwHWt4LsDiVeDsb8TY9EnkwkuFbw+s1
	m/l9Gv94AVFZ49hgDWdRlu4EBQzq7AxdTHIlrAzt7vC6hNihhWDNk4uaK+rPmA0YLkz4XXDeu2+
	XLy0SDc1Y9iVV/SlyOi58Zebc5Jfr8+7E+2+4HhLdVE7L+hyx4=
X-Google-Smtp-Source: AGHT+IELZ4SimOBJO6yrghuVWIOvvAedlzL4IeD6zPpIQjSz8JGeh7uFbZ7kG0dhBVgjaSWgYEdK7o4EE+MZnbE6CoQ=
X-Received: by 2002:a17:90b:4c0d:b0:315:af43:12ee with SMTP id
 98e67ed59e1d1-31c50e1763cmr20865064a91.16.1752578596648; Tue, 15 Jul 2025
 04:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Jul 2025 16:53:04 +0530
X-Gm-Features: Ac12FXw5_VIt4EBOG5y1_FGQ9hbqKjaE3fl3SBQ4AiBXr0z1r7gqAHncSjssGvY
Message-ID: <CA+G9fYusqGejrepNPCR-7ZZDPeQQfZgf2z=_aUz_03QHm7Ccaw@mail.gmail.com>
Subject: selftests: arm64: mte: check_prctl.c:72:17: error: use of undeclared
 identifier 'AT_HWCAP3'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Shuah Khan <shuah@kernel.org>, Benjamin Copeland <ben.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The selftests arm64 mte build failed on the Linux next-20250703 onwards
with clang-20 toolchain. still seen on today's tag next-20250714.

First seen on the tag next-20250703
Good: next-20250702
Bad:  next-20250703 (next-20250714)

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Boot regression: next-20250703 check_prctl.c error use of undeclared
identifier 'AT_HWCAP3'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
make[5]: Entering directory '/builds/linux/tools/testing/selftests/arm64/mte'
  CC       check_buffer_fill
  CC       check_child_memory
  CC       check_gcr_el1_cswitch
  CC       check_hugetlb_options
  CC       check_ksm_options
  CC       check_mmap_options
  CC       check_prctl
check_prctl.c:72:17: error: use of undeclared identifier 'AT_HWCAP3'
   72 |         if ((getauxval(AT_HWCAP3) & hwcap3) != hwcap3) {
      |                        ^
1 error generated.
make[5]: *** [../../lib.mk:222: selftest/arm64/mte/check_prctl] Error 1
make[5]: Leaving directory 'tools/testing/selftests/arm64/mte'

## Git Changes
git log --oneline   next-20250702..next-20250703
tools/testing/selftests/arm64/mte/
1f488fb91378e kselftest/arm64/mte: Add MTE_STORE_ONLY testcases
391ca7c81b85c kselftest/arm64/mte: Preparation for mte store only test
d09674f98cdbf kselftest/arm64/mte: Add mtefar tests on check_mmap_options
64a64e5d12f07 kselftest/arm64/mte: Refactor check_mmap_option test
49cee364c8665 kselftest/arm64/mte: Add verification for address tag in
signal handler
ed434c6e08132 kselftest/arm64/mte: Add address tag related macro and function
2e3e356560ef5 kselftest/arm64/mte: Check MTE_FAR feature is supported
cfafa517c9e65 kselftest/arm64/mte: Register mte signal handler with
SA_EXPOSE_TAGBITS

## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Project: https://regressions.linaro.org/lkft/linux-next-master/next-20250714/
* Architectures: arm64
* Toolchains: clang-20
* Kconfigs: defconfig

## Build
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250714/kselftest-arm64/arm64_check_ksm_options/
* Test run: https://regressions.linaro.org/lkft/linux-next-master/next-20250714/testruns/1615508/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2zrW3Ut4mYWOxPVnJTOY5qrft0P
* Build link: https://storage.tuxsuite.com/public/ampere/ci/builds/2zrZgjFum1wBbTRrsvDGnHC9JMt/
* Kernel config:
https://storage.tuxsuite.com/public/ampere/ci/builds/2zrZgjFum1wBbTRrsvDGnHC9JMt/config

--
Linaro LKFT
https://lkft.linaro.org

