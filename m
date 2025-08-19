Return-Path: <linux-kernel+bounces-775159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABDDB2BC14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967801B61F12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881353115BD;
	Tue, 19 Aug 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RS0bKH9J"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8303115B1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592843; cv=none; b=Mhh5k1c4y/ztVGDisJVUvvZdo9b69vKOwPYKB0pfXfsJJcQYxHT4bq+r3f5M/eCpfJPGGSjhQGafm8zZbIgaBA2Gw5P45d3nNOxWtvdAIkhdE7QRFYFf03y7nSKX4dCs8P0oGSMdnhfZsA2D8PwPwYfUiILonfYWMpHrjwjC9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592843; c=relaxed/simple;
	bh=s4rCdNrJl4PbZFUL3SQdLxne9G64dePB0cGlGicB9/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GJZwUvr5U/abF7WeLj4GmQNRTXaWVi3JjZ+CWJwNb+RGjygzBAnriC0YIdUbd0WxeLGpyGjVwPeF44uffoY0CaWilQgUWpMFH993p65XUOsvfzraWQr/KMwdtrCehjgWvbUnhqzoUn3DFoXN5JtDNjm078yURFM7UqP4iRfJdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RS0bKH9J; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so104077a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755592840; x=1756197640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fOvEbU0Cnc0FjNAEZg7vmgeVRfzmShXkhUtYM2eUAbM=;
        b=RS0bKH9JwTp4NOYDbvLcuQAXEuro4ovoSLC0dfi/6W2kyEufHBw1EFh83wvL0PAXTS
         tt8KUdOhe6G09a/F+EBJ40jx22AiMiDn14nUmebvCSDugwk1xNlgwFER/gaGJ6E5JgKZ
         WIL2E/4hFeICmZqBx6H4I+0d1NNbd1yarUof7T/Z/9/qo9VIqaoIjlycw1BJ24oDcHzF
         eZ4gOHfyQW6Cs7QJuuDC5TG6YcpWeOCLCaJLEgJQm6q83VFrXm+v+plD1e9QwPen4SV1
         mPLy7kbAIzxqqjJiEC1MLycIY/mjdU/QvyJ4/tAysXwXxJRYH3vhsIwmMtY3u/41kZ4/
         WOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592840; x=1756197640;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOvEbU0Cnc0FjNAEZg7vmgeVRfzmShXkhUtYM2eUAbM=;
        b=vNOlnqXYb//d8rP5QMhmhaLd1SNRBi+WOrlGy8QycfwTHptJCnj+CFiMCixmzeDZdK
         oMcYLE0MetDGOcUNPhyJoi6IOfOfUGksvraUGcnuUklmGPeFtGm8b/HV61+Y3DJbkz1O
         uycJ0N95+nWijl1DRYrsZL/Qm2AFO7rDip9GmBw4dKnABN7lnhUqPd+slJbk/VT1nchr
         ug6nna2aTKYJlt8jC3+94fOF1Nl8Atb+NWaasYyRsoIl30VE0n39+0vXU7vWeztY12hl
         dA4T1mkqPVXR2Ax5zWqDD88CwikhrXwYEHTDfL4+TgOkjfQnfPRiR2IGXYTr3c12/Woo
         7MVQ==
X-Gm-Message-State: AOJu0YwnZc/DQ6IPkFjfvvdP7uwyIrhLHRKPh4NbIdtUJI8mthn+Zo0z
	1+dAMkVIwjETRZPjf3aTGysGRc/wEQhLjdPOEse/OS4KO9gYOCeAg6Lx1P1hKENyW64cMEKSubd
	fPVDLVM1W2SfqKYj0YK7wgNWqoMECDqEsh4lw2qsnnOq46Ew74VGQSyk=
X-Gm-Gg: ASbGnctH/ceySQlIYyWmGZ7pleELYGDrandPQURcVqaL1z3yErRo7sOoOCIEnXo0Xin
	2LRIgDe9yosMTCzirCNsg/YsFD+Gm5WNfwMLtwqPxHxnq/2jbHbKhfpA1gGQCmmcDW+g1QNDlvL
	rCxH8LeIm9KlqaN5DT9LxOJHK6EymrzpKhoMKWaPjikLAxcCCdqN0BYmgoX1Kx515K7NJsdEuPO
	VMBz7eyej34ZbLvn2wXuFvR5SK84Z4D62dM9nMUpMst6LKQ6Q==
X-Google-Smtp-Source: AGHT+IEGGBLrKnJA5rKPO3tG/2IpmKWfgJNSJRlHDGAPjusotj2Hf8o9mNnZTQtC90ugTktRZGVV8VN9rh1Puc8/i0A=
X-Received: by 2002:a17:903:1ce:b0:23f:cd6e:8d0f with SMTP id
 d9443c01a7336-245e02d83f7mr22374655ad.13.1755592839617; Tue, 19 Aug 2025
 01:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Aug 2025 14:10:27 +0530
X-Gm-Features: Ac12FXwQ9ahb2ew69m1KVEd7V2w8TSXSPCLlnKGNCFNH7jf-h193q59E6JrscyY
Message-ID: <CA+G9fYv+gELzgcL4y8rOQbTxv2Y2JQTFhNkgUcLbzPJ_yDTziA@mail.gmail.com>
Subject: next-20250818: rust: `ARCH_KMALLOC_MINALIGN` is defined multiple times
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, rust-for-linux@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, wedsonaf@gmail.com, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Build regressions were detected on multiple architectures (arm, arm64,
riscv) with the Linux next-20250818 tag when building with Rust-enabled
configurations (rust-gcc and rust-clang) from selftests/rust/config.

Duplicate definition of ARCH_KMALLOC_MINALIGN in Rust bindings is
causing build failures across affected toolchains.

First seen on next-20250818
Good: next-20250815
Bad: next-20250818 and next-20250819

Regression Analysis:
- New regression? yes
- Reproducibility? yes

* arm, build
  - rustclang-lkftconfig-kselftest
  - rustgcc-lkftconfig-kselftest

* arm64, build
  - rustclang-lkftconfig-kselftest
  - rustgcc-lkftconfig-kselftest

* riscv, build
  - rustclang-nightly-lkftconfig-kselftest

Boot regression: next-20250818 arm arm64 riscv rust
`ARCH_KMALLOC_MINALIGN` is defined multiple times

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
error[E0428]: the name `ARCH_KMALLOC_MINALIGN` is defined multiple times
      --> /home/tuxbuild/.cache/tuxmake/builds/1/build/rust/bindings/bindings_generated.rs:125708:1
       |
5305   | pub const ARCH_KMALLOC_MINALIGN: u32 = 8;
       | ----------------------------------------- previous definition
of the value `ARCH_KMALLOC_MINALIGN` here
...
125708 | pub const ARCH_KMALLOC_MINALIGN: usize = 8;
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
`ARCH_KMALLOC_MINALIGN` redefined here
       |
       = note: `ARCH_KMALLOC_MINALIGN` must be defined only once in
the value namespace of this module

error: aborting due to 1 previous error

Please refer the full build log information in the below links.

## Source
* Kernel version: 6.17.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250818
* Git commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
* Architectures: arm arm64 riscv
* Toolchains: rust-gcc-13, rust-clang-20
* Kconfigs: defconfig+rust

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29578517/log_file/
* Build details 1:
https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/rustgcc-lkftconfig-kselftest/
* Build details 2:
https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/rustclang-lkftconfig-kselftest/
* Build details 3:
https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/rustclang-nightly-lkftconfig-kselftest/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31RcUoS2AqZLljDCs480MNNEyxJ
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcUoS2AqZLljDCs480MNNEyxJ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcUoS2AqZLljDCs480MNNEyxJ/config

--
Linaro LKFT
https://lkft.linaro.org

