Return-Path: <linux-kernel+bounces-779591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AFB2F5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9BEAC2ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1476C30C357;
	Thu, 21 Aug 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDzRSnd7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79130BF74
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774528; cv=none; b=gST9NmothSN+Z1mnfdCRf8VVNvI+nnXDWM+ta7uoHqtQ7Qi28YFWcZb6nvpagC+/wBP/yxcQC2FB8MFKJfYRSBYy7y+xobj3+VqlPo6p63+mrQvje8OnJnKSUFvb04/2JFF8QUe9wv26mqptjJ8cGygghD/MwWogLmcJZdq7BAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774528; c=relaxed/simple;
	bh=wo8fFKRkmyhr5A9bJwCdfaCDsrAwCqyfhGhNWQU/vBQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r0EQc9nx6Mk2/8zsQd5C5plAiG+zP/SRvlCd7fW92WgKVMa/93uiXFKsfUofKULFkSJpo4xCSyjTsMIdfj0YrmOb2gG8OF1Mok3pt63/hf8xF/OGJSwrgEglCJZAoT9twur0iMR5iUUN/AokgeRm2OWwfrHbd/+79plhU+lau6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aDzRSnd7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445827be70so9351745ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755774526; x=1756379326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pz2lRLfqaRELH/ch1+xtt9bzWUsIFWaw5ujjaHxpXSw=;
        b=aDzRSnd7uoiFkFfBlVIj2veQLDMlFA7G7zPibH0Rwsg+7vzGedri9LSdnQMzx60DbT
         o77rcufHdxH9AvvD8POlpA/fnmiwErBc+1WRlHDsBfQwl/+eOzS/SodxWDaopcBPL+bh
         yqdrYORkYDLlv0f9euBiCHBcHgXGFObQ6oGdt6N1uMBn3m26I1P5igUf2SZmY2fh/xEw
         VRvr3gCBGTd2nwWDJvgl6VlhK6oIhPNt/ZAoz5cuLcQqjItczbunNqTqJY8It7bOStj+
         HtRDZAnygQEdFdlOvbhNA5U5YOoMU59WrLQujvLV1JnBDC/Bqd1ZJFTQU5QDcFC40qco
         BLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774526; x=1756379326;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pz2lRLfqaRELH/ch1+xtt9bzWUsIFWaw5ujjaHxpXSw=;
        b=JW3XN0fJHLYQIylH8eoGGRxdrZSk70qZD2dHjqyqezblYfNOh4CHnRPamG6wExPNq5
         fcC7crgobGYUzS44CL36b2vyTy+1ZONjj6kuXxOisEmgRX1wt9f5U6sZRtwaIa1HX/p2
         cPfoTjWeZQIs7IrDagt9r83VbnkSHpFlwXoDR4/nule0MeyYP7OxbJSykS73Ls6g6jR/
         rscg9z1mewMlz3ASjt4svbvWi5KlwpF9XbwbAQzh0nAluBK0IeTICG72pTT98rQmSThE
         aCJd+D7Ov7YRWptxec41KsqBEA/hOYmWwUtbNpaGldmcS82B38JxxQjivx8tB1YfVLwT
         Xcvg==
X-Gm-Message-State: AOJu0YyztX9BiTuiUQprdvkGwRMwDq224UU/+K6olEwURrWkjM1ZCE/C
	ldB258J7n1xdKvsws4uLY9Go8TmoTha/d7YRW6uWxJK775k0nFqTnlR9bBo52pI9g9Mo1+s8e8w
	lz3qFU3AwEa7JfOTevw/UaC7wajy79Ogi2ymgEbM8IwcwPCBexdz/B54=
X-Gm-Gg: ASbGnctrWzLrryupcs3ti4ALiJbjxC56O37XaOHSb265ZB+o4WfMP7563f40t9vdO6X
	d36QnXtTD8pnLZPHnntMx+0y2CV0D4pqL9IhHp1ALe76860sqk1qdSJze1hu2a33TWtmuPEZBoS
	R65c1KwCS4YM0FmfHi7JQ1x9TPxh9C3CTfy7aqYxR9Ou6mTXuj/E3JALYqYuq7JYPGyN0f0XCDv
	sogGwK5wIlEPxriLaCpwt9hvD5xcrGgIeJm3w==
X-Google-Smtp-Source: AGHT+IGqJIXkeZ1cPE92KQPkVZFoOov2gyYnj+M9lqpBVRW5SAgiAAGuqW38eqvgWo6dJioAKo2uIFcmCS3PrSxJ3x0=
X-Received: by 2002:a17:903:3d0c:b0:246:571:4b24 with SMTP id
 d9443c01a7336-24605714c82mr21886425ad.61.1755774525706; Thu, 21 Aug 2025
 04:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Aug 2025 16:38:34 +0530
X-Gm-Features: Ac12FXxrwC8J1BsX_IcVeNAB7p8j33bNwbFGted2nZTmpvEH-5C9tgp38KBgcNs
Message-ID: <CA+G9fYss3ztUGNvEu07Veck+09Lsied5TGbb-2fSw8H5wxRaJw@mail.gmail.com>
Subject: next-20250821: tinyconfig: kernel/panic.c error: implicit declaration
 of function 'panic_print_deprecated'; did you mean 'panic_print_set'? [-Werror=implicit-function-declaration]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors are noticed with arc, arm, arm64 defconfig
with clang-20 and gcc-12 toolchains.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250821 tinyconfig kernel panic.c error
implicit declaration of function 'panic_print_deprecated'; did you
mean 'panic_print_set'? [-Werror=implicit-function-declaration]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

* arc, build
  - gcc-9-tinyconfig

* arm, build
  - clang-20-tinyconfig
  - clang-nightly-tinyconfig
  - gcc-13-tinyconfig
  - gcc-8-tinyconfig

* arm64, build
  - clang-20-tinyconfig
  - clang-nightly-tinyconfig
  - gcc-13-tinyconfig
  - gcc-8-tinyconfig

* parisc, build
  - gcc-11-tinyconfig

* powerpc, build
  - clang-20-tinyconfig
  - clang-nightly-tinyconfig
  - gcc-13-tinyconfig
  - gcc-8-tinyconfig

## Build log
kernel/panic.c: In function 'panic_print_set':
kernel/panic.c:954:9: error: implicit declaration of function
'panic_print_deprecated'; did you mean 'panic_print_set'?
[-Werror=implicit-function-declaration]
  954 |         panic_print_deprecated();
      |         ^~~~~~~~~~~~~~~~~~~~~~
      |         panic_print_set
cc1: some warnings being treated as errors

## Source
* Kernel version: 6.17.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250821
* Git commit: 7fa4d8dc380fbd81a9d702a855c50690c9c6442c
* Architectures: arc arm arm64
* Toolchains: clang-20 gcc-12
* Kconfigs: defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29616870/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250821/build/clang-20-tinyconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31aRY2vQ0cMol9wA63TKkoCPsxC
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31aRY2vQ0cMol9wA63TKkoCPsxC/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31aRY2vQ0cMol9wA63TKkoCPsxC/config

--
Linaro LKFT
https://lkft.linaro.org

