Return-Path: <linux-kernel+bounces-819261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CFBB59D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E9F177B14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96265371EB2;
	Tue, 16 Sep 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4wMjvyf"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDF2F7AA6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040011; cv=none; b=Xw1+d07VSgrE2aNvZy+MIr+IJGAMjy8vTjLveH+2dFjJA3R6Hwkhf+ZcBkN7iNz1g84s56XNVR0nrLhA3VkISE3oTXiyd9ql5o1WE/WdGYzDJh/vpwUZC5Javbgb1ECYCcBFk/YBIq/UCKSEEme+08P5MMoioO2qRYikUcJScAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040011; c=relaxed/simple;
	bh=PxBeY2ICmRxL7V6JGWbT7z+W48PkV2S3brfnG0Ta/Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6KraGqhT+eOJ0Lfd4o6A6OsMYM3YVDCDs4p5axhTL6U62t80b5m1eaijbQ7LI+GZBjJPrbjeUQ7xSTElOHfCoDY6KMi7QQdzsS7I7gb/2FLr4fBsrwjNWN1zSYyJn3Uqlid2lR9/APV2GooCGHGRk4gVS74KDl1WKkjNNQJnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x4wMjvyf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7741991159bso7161457b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758040010; x=1758644810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s4w1twc2Jux9/iX+9+EawZxCflWASdrv9dd1/gUc0LA=;
        b=x4wMjvyfpQsM54v6xctYOf/ZA6gD/PaXfUUnF13LhaC/AE9frmq2pERUCFTbcL64MK
         3MVk5LFpY+DSoi5c5VB5u9sd2qh+j3GuZ6dKxDRCPSlnW5efp90fvPg6f9TFZER5qzEY
         NSsQnmYj/0cltUR8/4fSZrJoQL2M9OS4eCk9FwNb/FK2K0ePYoluD9YeUzHHAPOTgRDt
         jlKUkyDwatQfCELkiRrRNt2WJiDHS6zcKuS8lhQwVLqoOGFgZZGTeEmS4p7oFKPEJlX8
         PgT1Jr9YN4v5eq18amIDsAZMaIsuJDNf1IDG8he3x2580UhztMvFZMuNY2Kj6XrfGeDD
         hk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040010; x=1758644810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4w1twc2Jux9/iX+9+EawZxCflWASdrv9dd1/gUc0LA=;
        b=UZvyHbEaJT9x0fMuUYIrQXDNO2gjwlu6KgVpn5gHzGL5WHUpjmOS+gcqt9IY+02HR5
         Zc9GpQkt56MYlpMSYnRY6QYWDMmcXUejpgRrRKeBC/sB3A9DzikinHdRWg03CdVNx0Dk
         u5VJhz74Fjj5AG0zjRnKtr7Z1P2JrD+CrpXGXYSDSop7+iAVmgLVXtu1AkRfcVUFied8
         oOL4asGFycThijNvMVTmOqm1uFPj8gLJuMWfdzZo1wg2gNtYbEkkNOpf9rPUUK+SKcbC
         Eghkq46lGhQ60/Q46ErDEXjIZw3+a9PEvjEA3g4uk66AOujAmWVKe8EFQCd4DV4GJ+ct
         PlGA==
X-Forwarded-Encrypted: i=1; AJvYcCXFyW52suyq3QUsXxd+ODU1T2xJzBHeCa79RLfTVcyeVNn34FCmJk98wbxLRBzufVZSOm5tKoi53k75flI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6v55/UQjUWADsGrdb2h8cg/ROVybs8ktaAcHVp7D5UpV1qED3
	I2vdu7s3IRM1Ix9KGbLwq8nSUIVzLrWrtx1swAqTrAZskPc9KOC/c7ChUI/qNmg+ENSj7qyl42D
	ti5AMvQIeKyBF6CoKMhtIAFREhEq947eHYru3ZtuIbw==
X-Gm-Gg: ASbGncuk7HmfI/hNxelL+9THZ9TRd9iMohyLWxhbQU395SHNTUiKmp8kiGgx8TGdsz6
	55Hrga8jl1n4/zbMHx8uPaNWgGVNoM27cuYj/OwZeOvxsc9uvpJMiA4quIYXmJExwB8I+v2TAJx
	roQxovuuOpiIr3dNcmBpqCvwtFj7Apumpp9nH6D8CSrenS81yd82w9TFyM6nVKUBLF1PQQosNuN
	3hR8YhH6MPzhbK8zp2UYIDcY33m34/j6surLTdAu2wO7hXIU/fMVsVqeKiGu4RXq+zXvPs=
X-Google-Smtp-Source: AGHT+IHuTUY+Teyoa1eWvti9PIr/otK14LfkQmbXX52ZUETrjjVY6olQ+9HFTHWNNqsEYSy8wzDykuGz9e1hPuCuCPc=
X-Received: by 2002:a05:6a20:c28a:b0:262:4378:9df2 with SMTP id
 adf61e73a8af0-26243789f89mr10527030637.44.1758040009637; Tue, 16 Sep 2025
 09:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
In-Reply-To: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 21:56:38 +0530
X-Gm-Features: AS18NWDfejtlQ9zlS_9kzf9pQW6YsiN2lV16eZmPLVxyOpZY0K_VUANrsx-p3cc
Message-ID: <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
To: rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 11:17, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following build warnings / errors noticed on the arm arm64 and x86_64
> with rust config build on the Linux next-20250915 tag.
>
> First seen on next-20250915
> Good: next-20250912
> Bad: next-20250915
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> * arm, build
>   - rustclang-lkftconfig-kselftest
>   - rustgcc-lkftconfig-kselftest
>
> * arm64, build
>   - rustclang-lkftconfig-kselftest
>   - rustgcc-lkftconfig-kselftest
>
> * x86_64, build
>   - rustgcc-lkftconfig-kselftest
>   - rustclang-nightly-lkftconfig-kselftest
>
> Build regression: next-20250915: error[E0425]: cannot find function
> `atomic_read_acquire` in crate `bindings`

Anders bisected this build regressions and found,

# first bad commit:
 [eb57133305f61b612252382d0c1478bba7f57b67]
 rust: sync: Add basic atomic operation mapping framework

>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Build log
> error[E0425]: cannot find function `atomic_read_acquire` in crate `bindings`
>    --> rust/kernel/sync/atomic/internal.rs:124:37
>     |
> 124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
>     |                                       ^^^^^^^^^^^^^^^^^^^^ not
> found in `bindings`
> ...
> 201 | / declare_and_impl_atomic_methods!(
> 202 | |     /// Basic atomic operations
> 203 | |     pub trait AtomicBasicOps {
> 204 | |         /// Atomic read (load).
> ...   |
> 216 | | );
>     | |_- in this macro invocation
>     |
>     = note: this error originates in the macro `impl_atomic_method`
> which comes from the expansion of the macro
> `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z
> macro-backtrace for more info)
> error: aborting due to 34 previous errors
>
> For more information about this error, try `rustc --explain E0425`.
> make[3]: *** [rust/Makefile:553: rust/kernel.o] Error 1
>
>
> ## Source
> * Kernel version: 6.17.0-rc6
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: 6.17.0-rc6-next-20250915
> * Git commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
> * Architectures: arm, arm64 and x86_64
> * Toolchains: gcc (Debian 15.2.0-3) 15.2.0
> * Kconfigs: rust config
>
> ## Build
> * Build log: https://qa-reports.linaro.org/api/testruns/29894207/log_file/
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250915/build/rustgcc-lkftconfig-kselftest/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/32l4UDzp0FMtS73JeG3kWpcoQrm
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UDzp0FMtS73JeG3kWpcoQrm/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UDzp0FMtS73JeG3kWpcoQrm/config
>
> --
> Linaro LKFT

- Naresh

