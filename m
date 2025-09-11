Return-Path: <linux-kernel+bounces-812747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91780B53C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18BC1C821C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8098E25A34F;
	Thu, 11 Sep 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhBTEhlo"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493C258CC1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618341; cv=none; b=jfi7eckpRBOFfbEIJDCO4b0tguOo5y8iASnLJhDmM+6iU/ZGmzNNu61qJhgkW6e+8vGuniyD+kD5jYSpZ4H5XwatqJvCvrpOuIBgcUgdvHd9kmy7EpkFBTEgrEBqQaVhfZdN5fl0kycxgsmUDhp3RDsBLdMXnB1nYHq8lsTvxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618341; c=relaxed/simple;
	bh=/Ke+Nb1gsfRDyew1MtLRw+g0cKYvwkI9gUaQtMkfHhc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AQsfGiVxmXV+QF3a4oimovPlT6oZlrZLTMs9fiNN2MR2uW1tHVKsKvUjA7CGC8+X8ImLH3JO7CMS7VQuJFBz+gIVWa6uxDjP6SdBHQHBL9Obqem6O14dWgiDPu77D8rRkRsXgwDtOX4RghpJ3Rf0LUFg7nz4J16ItqUn9vVzAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HhBTEhlo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806e03cso12638015ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757618339; x=1758223139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OMzXnLutBDyDe0cFRFFwMkAW7rZFHmfwIn2gFvrd1lk=;
        b=HhBTEhlo91F/z8s/YWhnCFAAItY0ag+FYMpIyS8PKv3K9LbiyiIXXWjpUl1XduZGSt
         eJDaLqXskADYkvkfvTC+kxhWDFbNU6MXAlUBLiAXCvXDF3MbKMdP65S2DWPmZ6pJmt8+
         rsn02XrZ15QdQorR/VFucKhbRrwAfe56jwXDGp/dua3FT1wdrnJLNLSEX6F4r50OTxvg
         pWuHfDBWJ6qHn04Vx3NuOj9F5u2qtUzmguwYErYki1QD6sMxyIVKkeBBsjhdImLHjAJZ
         i5agY+LsJII9QjgCjygXMuORb+JTWSDXUgwILmmVyq3xWIZ8nXl9bA1OdRFQFszhsy+2
         ppEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618339; x=1758223139;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMzXnLutBDyDe0cFRFFwMkAW7rZFHmfwIn2gFvrd1lk=;
        b=EHvKIEWeogJ42rgpevdnSTbpD4KhTOXoEsmT6NMPD+/7HPfdOus9+6zT/hIPjydMD2
         2xRw3RdjGCBuXFk8lwgKa6eIyGPEv4z7PAwCZ0C8fFnbgTdTR5mNoC24J2nFvztstePO
         c6oSD+ehpEBB8XGt1Qx8jZWFAXDh+dZY4/YTfUh4gvVPdOU9LZg8DN+1KuzIeA1yGnR4
         AN1/xI1qaqP6VQCf3qzkPgyJjus18AwFvS83YUiDFn/ox34RFzgdYoGncjRoMB92CrEI
         OeOUyMFQZG5Yvb9h+ay/wG2oNRnc3/NKJUlojVtBNqcrHz2wyMR4/uQLtnlPFZiAhSse
         4SeA==
X-Gm-Message-State: AOJu0YzFZjyrL92e4rAYO++dwlQiCAPMmv6GVFFChpC1c3GJj5tSCHlQ
	mPQ7KoNEiRkNz0D5Xb14R/6QfBXJ5CqZqRrRPKuYMsYUaiUA1RfcX7ZZeIuVLRzSOg15lX2CKb9
	3/x4UAqi2VXFkv9ZPcIbI2h0KteZ9M6vX8A1iPehHJED9oQ53G+v8pOY=
X-Gm-Gg: ASbGncvP2PwZSXHiVBidazTkUgMm7wr3QevxxwI7O2u+wINQszA69WCtqo8RDXUG3Qi
	pBRvcLsA3/qCdEdWQLwT+sEl3Yn31u3yXwfmeQW7gs5chkKg+GDr7SeyrbZjwDctbzcDP0vjG9x
	L5f5p4jBMQIMnbE+FeloADnkBlXcPQcjcsxIS0zuOQC+MB6fbEC/6fQFjC9lzXQIUCW51aD8b9Q
	Frbizzt6oFQOlOEotWWFL5LLNn6gLNjxylvNIkQ8y6dYwPpwWHL0XLceSnLHrBSdVfUqBDT/GYc
	sTpNqw==
X-Google-Smtp-Source: AGHT+IFcvNFERCt1pxcRVC0LrxIO5qX9I6ZaHaKu41AXHxq/mmXTSKA/Xpf/xNIANgUEzlw3GdicyiK9s1eIUs3kKeA=
X-Received: by 2002:a17:902:f60c:b0:24c:c8d1:2bec with SMTP id
 d9443c01a7336-25d26a50ba4mr4742195ad.40.1757618339416; Thu, 11 Sep 2025
 12:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Sep 2025 00:48:47 +0530
X-Gm-Features: AS18NWDec12kyfne2e8LlQ-fqp880gCW8MHrmOTo3P_JiNjAs1Vmr9Ipa42F9ss
Message-ID: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
Subject: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error: use of
 undeclared identifier 'HWCAP_GCS'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on arm64 defconfig
with clang-20 and gcc-13 toolchains on the Linux next-20250909
till next-20250911 tag while building selftests/arm64.

Regression Analysis:
- New regression? Yes
- Reproducibility? yes

First seen on  next-20250909
 Good: next-20250908
 Bad: next-20250909 till next-20250911

Test regression: next-20250909:
selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
identifier 'HWCAP_GCS'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
identifier 'HWCAP_GCS'
  390 |         if (!(getauxval(AT_HWCAP) & HWCAP_GCS))
      |                                     ^
1 error generated.

The suspected commit pointing to,
  kselftest/arm64/gcs: Use nolibc's getauxval()
  a985fe638344492727528e52416211dda1c391d5


## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250911
* Git commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
* Architectures: arm64
* Toolchains: gcc-13 and clang-20
* Kconfigs: defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29827060/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250909/log-parser-build-clang/clang-compiler-basic-gcs_c-error-use-of-undeclared-identifier-hwcap_gcs/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32RzudgbCUiqGUoFtquJ9IEIDXZ
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32RzudgbCUiqGUoFtquJ9IEIDXZ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32RzudgbCUiqGUoFtquJ9IEIDXZ/config

## Steps to reproduce
 $ tuxmake --runtime podman --target-arch arm64 \
 --toolchain clang-nightly \
 --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/32RzudgbCUiqGUoFtquJ9IEIDXZ/config
\
 LLVM=1 LLVM_IAS=1 debugkernel dtbs dtbs-legacy headers kernel kselftest modules

--
Linaro LKFT

