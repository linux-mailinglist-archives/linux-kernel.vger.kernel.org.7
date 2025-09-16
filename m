Return-Path: <linux-kernel+bounces-818193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD4B58E12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A8E16A518
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC912C11F9;
	Tue, 16 Sep 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oj+3g52D"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A7296BDA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001690; cv=none; b=dlK9rYTq9BV1fEs2pv+HfiCJlxzl0Ih7qLcdOs2unvoT8FbeJdgDlhro6HmeVHMGUpWxRAwB1k70FRY7cJuFrGa51XnbiMeuo8oCONlO6f4zGDCxUYOX940v8OlzaoGenlPXN4BZiv6kHPFxudOfUI6P52GS985Z3++YUNH6uY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001690; c=relaxed/simple;
	bh=E2uWLYg3FMkNgpZTrHVVVc4rBvzh5/YBlD80cZCv3AA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qbQhbbB3DIibQicNQV273NhBmCk0kAyes6kvi1Iqs7JG1ddmms8WOryERh1gVVB1CLnzDcEj6PdoDmEVcoX5AeGLGcvcTEKCIzfJKqIaX5F8fTzuv8Zu+03g3jiJz9dBMSIxupprA9bdQDPmVwQkIJSBfARMpIbsMrEaRFdCmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oj+3g52D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445806df50so40124695ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758001688; x=1758606488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6I4vQkRpdnZ7dgAYiGmYLTNrTd2ZtFDNajrfOoR45L0=;
        b=Oj+3g52DCv7cldbRwq+b7GLXbDw0O2xC4vU6Biig2Uy+ichXzTvHFsfZ5x40+dXrvY
         MYcovyYnRrWvhKNXrDKYlg68jH0OYapxKhJ9jQ1DX7gPLqglOJV+1UPWRagBU8j7Csu9
         ezL5ars2RrUquaqPJsVI8nrYkQjw8zwtIraeMFG1vcdQryd6ChvrwPGH0u6K4CM5tWjN
         8myUKS2J4Nic/AZae4TJnIrdinKCg00/mgUp/gHjvYvoFa48CnN4QbjLy36wCvFRSO3+
         zztFCBHB6hA83wjA9f25u2bo+r4tlRKFkLcTz5ua2wKDLNqHqTH4dMH1nCVJ2gt3Ppf5
         ghKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001688; x=1758606488;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I4vQkRpdnZ7dgAYiGmYLTNrTd2ZtFDNajrfOoR45L0=;
        b=pImfpaRmSvI8mdbz0MRG2NT/nDntjYV5c2dNcT2d5twKwf7B7zO9NKHzJf8GqLlz3O
         uxxBjbHj3RFB954BpXD0UnDGMIuJsc89ZYsXvpHMXdMnoNKa0r/QAN6eeYwHW4AOv0r6
         ssmV4AgnNAdivGGMKzIGsfRFz39QVHiQp2AAHXM0PBS5z4BMjG+uMND2vv/2t/L0PRCA
         Pt3bFQW62sqcUnWHCTskL70JKUO4kYL+CeZ/xNIixVzRGc83RjyF+GUYlc8ReiID+p1K
         s5QXuoXRS+dOaP/N8JP5Q9jhaVkF8BTH6M6ZkqVnO/omDdPXXFEqNrA1HvwjWDoVjlAj
         wdog==
X-Forwarded-Encrypted: i=1; AJvYcCUNMpuixOsYptmy3thPANrhij3+kJCViYbZdodf+jcA6YgNHl95m9nYhs3Jmc9K76uGC+WvlaVAwD62bj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CBf5YVtFFv9aGT3U5J/fM9nrtt6yYGLCeiMPwbCtTNww9YZl
	ODOKvoyU5hZO/jo0R2GsJtet0HG9xJi8fpc8yxeuMgHC8rJ1mVXaix+QkmgR51U+5nV/zY4Z/Ub
	+t3szhDThlokn/ViixxkAxP8YBasr83/idJpb/PrQAA==
X-Gm-Gg: ASbGncs52RU2KZB2qerDALTyualN6TaZlimCp4qimbZOU4gIX5Hzms/9iGsVo8suse1
	IxFJZuQYZu+jRwh7rSUkzarG/+Dri3cpyZvIPlQq6TdACPciZoOFsmUvYI2vP0kdD8WOImm9egj
	wfIznXcFLB3n3qtrAe2fSs9hRCANywHgIoxOvygrJtyFXOX0UZ9O/jPpusxGkmSq1e/8qdijyJm
	DA6YgMV0HVha9oym7MXil4TzdeZHAFssbx43GBwJ3cG0Dri4oPW0tyt58L39beYFKatRpru
X-Google-Smtp-Source: AGHT+IGlyV0fslNXwltIa0zfwhqmtTg9Rcz2i3N9litNb3DEzz9VPq/c8d7ozuUucZC+Rr2ydlzIY5gSnStEkKTFv64=
X-Received: by 2002:a17:903:4b0c:b0:24c:965a:f97e with SMTP id
 d9443c01a7336-25d23e10c8dmr195037845ad.2.1758001688493; Mon, 15 Sep 2025
 22:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 11:17:57 +0530
X-Gm-Features: AS18NWChJdvp4Jcne5Z1CbUS1ZAGIP4hD5Fge2myTdRe9ZSVPsYDAB_gGWhrEME
Message-ID: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
Subject: next-20250915: error[E0425]: cannot find function `atomic_read_acquire`
 in crate `bindings`
To: rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on the arm arm64 and x86_64
with rust config build on the Linux next-20250915 tag.

First seen on next-20250915
Good: next-20250912
Bad: next-20250915

Regression Analysis:
- New regression? yes
- Reproducibility? yes

* arm, build
  - rustclang-lkftconfig-kselftest
  - rustgcc-lkftconfig-kselftest

* arm64, build
  - rustclang-lkftconfig-kselftest
  - rustgcc-lkftconfig-kselftest

* x86_64, build
  - rustgcc-lkftconfig-kselftest
  - rustclang-nightly-lkftconfig-kselftest

Build regression: next-20250915: error[E0425]: cannot find function
`atomic_read_acquire` in crate `bindings`

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
error[E0425]: cannot find function `atomic_read_acquire` in crate `bindings`
   --> rust/kernel/sync/atomic/internal.rs:124:37
    |
124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
    |                                       ^^^^^^^^^^^^^^^^^^^^ not
found in `bindings`
...
201 | / declare_and_impl_atomic_methods!(
202 | |     /// Basic atomic operations
203 | |     pub trait AtomicBasicOps {
204 | |         /// Atomic read (load).
...   |
216 | | );
    | |_- in this macro invocation
    |
    = note: this error originates in the macro `impl_atomic_method`
which comes from the expansion of the macro
`declare_and_impl_atomic_methods` (in Nightly builds, run with -Z
macro-backtrace for more info)
error: aborting due to 34 previous errors

For more information about this error, try `rustc --explain E0425`.
make[3]: *** [rust/Makefile:553: rust/kernel.o] Error 1


## Source
* Kernel version: 6.17.0-rc6
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc6-next-20250915
* Git commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
* Architectures: arm, arm64 and x86_64
* Toolchains: gcc (Debian 15.2.0-3) 15.2.0
* Kconfigs: rust config

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29894207/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250915/build/rustgcc-lkftconfig-kselftest/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32l4UDzp0FMtS73JeG3kWpcoQrm
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UDzp0FMtS73JeG3kWpcoQrm/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UDzp0FMtS73JeG3kWpcoQrm/config

--
Linaro LKFT

