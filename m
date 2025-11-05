Return-Path: <linux-kernel+bounces-885982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59854C3470F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68538465CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AB8285074;
	Wed,  5 Nov 2025 08:21:12 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42927FB28
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330872; cv=none; b=nnfiHsBZw+NNyGyg1RgTCx9f5qBfz/k8jWcNX1VEiM/TUZ4Hku8YgYhSHFkMBDQ1xfsaErSYszpBZfbjdyLDKUKa57F2wa+GDztJhTtOk3cPfOLSvm+tDdwhiUB41r2+mCn8Ry3SmpJiCjD0zspce3GCWBuwGj+aGtyBMGkBd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330872; c=relaxed/simple;
	bh=e6JLdAGdjpoNipESzIZvmJkTXYj9C2KmS1rRNXGO+f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q01yh4jd7LHR32F7PFjYGyqkcBpnYXaGJgPjrxN7Hxq5LyV/G7ovbyKPaPbYfFTF9LKlIZBXtOTiuxsqElKJ+pJ2yD6GAdiKuCPiaA2ZTX9La5Zwz0ihescVJWWVnEFDshQjavCT9HjBCw7A50coLxhvRO0vz4k0U+D8eNiTAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so2623623e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762330868; x=1762935668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI73gRRV6GzNX9ORLHQ0mMi3EHWfYUNO3hYwkCpEhDI=;
        b=Am0uQRcra/lelEkqvjptjV9WDaxPqM0howQxRAWOPw1WVKDARk5uANwIGfIaIWRlVm
         RMArlUHLxspdwWcWIbgIXZkygKNnncuz+jcpKkTBGnLFiA+VyaWm8AHu/0gITOoqp+RN
         4HO2fT5/t9dNVMWKin7JaXaZyT7tyO3WHEk4upWirPxWh8QmbHs2RR5B7xHJs9EMDzy8
         DODM0d7t3ZkDROzYAVN8Ydc/i5KZsCGfykvQVt4LoEnZh84sy6iF5p381JtbRe2zjlAC
         1+8E6pzRIXm/s8L3+HI9DoK+R43msdEK7tOvyu9C0LArNnde8LvlU5XORxXsrpTt9Piu
         q59Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3vvxSnD3SQ9ZBPbDoswFRt1yUEqVwzNGGWcHYTUwdXU56/mHu5sD+w50KDDYil4vX64giA8ogpdec2Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzFBXz0kGLlcn7j5WIFJSPwrIZBa8Ar2gjbZbvijTe7bU6VR5
	2oyApkNIXYD3HByXaQRNDf211Yie2d6foV4wpd2jg1osnlJvzCzCm43DzS9d7Q==
X-Gm-Gg: ASbGncuQGeGFq86Y+GLpcN/kx52U5ozim7i2AnmKBPneg0ylssO2Ss01A0AwpQ9fxjG
	KFUyZy89e+fnogyJIjNsW2Ce1jUtAkz43/pO25fryFhYxHpDDRP+wyf/Z6zU/coZm4viExyLsxj
	myYnSoNt4tbHCHm4hDObDMs30GHW9xCHwdHMRLo2Oo70rrTFyXeXJhErtP7I8u1BdgsEj95VFuI
	MO8G4KBqQP1I8u5BFDcJNH5HHtqlH43i8y2ES521BBrQUYMGEMUzi6GHAjEVimr1lVYgN+eU0IQ
	/2fT6EbJGNEWrr4a+hDA0pBcErfZB+Knoyg+mExa1cf0ltTi8p1MEz1pE+GAwixrj0j4OYJpk0o
	BkGlI87RQo9fxX/lDocNxzftud973PszgasTEfG3dxI8MNxT0MZzJndtqr+p60s38gYqFY34Gsz
	OVoNLuvjV7Dpv1NQnx+aupqY8Ov36hoPw7gH7JlcBR5gqb
X-Google-Smtp-Source: AGHT+IEPIdRZGyTYgd0WYs652daqGM6/Nw1Bkg3t9uBekNEQtYUKiwSy4gjZcKUmBgs8mRk8kjpkUQ==
X-Received: by 2002:a05:6102:38d0:b0:529:fc9e:84ae with SMTP id ada2fe7eead31-5dd892a1e66mr845802137.24.1762330868241;
        Wed, 05 Nov 2025 00:21:08 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbf30e2763sm2013294137.2.2025.11.05.00.21.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:21:08 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so2623616e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:21:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrCoPcVwKw+rEfqsqOhv1b5GRI98Vi9znywkcJRlS0raxgqsEzQyuf/Ro1+kcGaMCprzlncAolON+MhBY=@vger.kernel.org
X-Received: by 2002:a05:6122:16a8:b0:557:b52a:d553 with SMTP id
 71dfb90a1353d-5598629df7fmr742464e0c.7.1762330867471; Wed, 05 Nov 2025
 00:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr> <2d713719-709d-4b46-8234-2dfe948b836a@oracle.com>
In-Reply-To: <2d713719-709d-4b46-8234-2dfe948b836a@oracle.com>
From: Fangrui Song <maskray@sourceware.org>
Date: Wed, 5 Nov 2025 00:21:20 -0800
X-Gmail-Original-Message-ID: <CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
X-Gm-Features: AWmQ_bmddpJcKyAPiscY0H47mNfA8VNIXsDcqVT0-QaFKHqRf8Me3jITGdYCQ_4
Message-ID: <CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Indu <indu.bhagat@oracle.com>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Tue, Nov 4, 2025 at 1:21=E2=80=AFAM Indu <indu.bhagat@oracle.com> wrot=
e:
> On 2025-10-29 11:53 p.m., Fangrui Song wrote:
> > I've been following the SFrame discussion and wanted to share some
> > concerns about its viability for userspace adoption, based on concrete
> > measurements and comparison with existing compact unwind implementation=
s
> > in LLVM.
> >
> > **Size overhead concerns**
> >
> > Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is
> > approximately 10% larger than the combined size of .eh_frame
> > and .eh_frame_hdr (8.06 MiB total).
> > This is problematic because .eh_frame cannot be eliminated - it contain=
s
> > essential information for restoring callee-saved registers, LSDA, and
> > personality information needed for debugging (e.g. reading local
> > variables in a coredump) and C++ exception handling.
> >
> > This means adopting SFrame would result in carrying both formats, with =
a
> > large net size increase.
> >
> > **Learning from existing compact unwind implementations**
> >
> > It's worth noting that LLVM has had a battle-tested compact unwind
> > format in production use since 2009 with OS X 10.6, which transitioned
> > to using CFI directives in 2013 [1]. The efficiency gains are dramatic:
> >
> >    __text section: 0x4a55470 bytes
> >    __unwind_info section: 0x79060 bytes (0.6% of __text)
> >    __eh_frame section: 0x58 bytes
> >
>
> I believe this is only synchronous? If yes, do you think this is a fair
> measurement to compare against ?
>
> Does the compact unwind info scheme work well for cases of
> shrink-wrapping ? How about the case of AArch64, where the ABI does not
> mandate if and where frame record is created ?
>
> For the numbers above, does it ensure precise stack traces ?
>
>  From the The Apple Compact Unwinding Format document
> (https://faultlore.com/blah/compact-unwinding/),
> "One consequence of only having one opcode for a whole function is that
> functions will generally have incorrect instructions for the function=E2=
=80=99s
> prologue (where callee-saved registers are individually PUSHed onto the
> stack before the rest of the stack space is allocated)."
>
> "Presumably this isn=E2=80=99t a very big deal, since there=E2=80=99s ver=
y few
> situations where unwinding would involve a function still executing its
> prologue/epilogue."
>
> Well, getting precise stack traces is a big deal and the users want them.

**Shrink-wrapping and precise stack traces**: Yes, compact unwind
handles these through an extension proposed by OpenVMS (not yet
upstreamed to LLVM):
https://lists.llvm.org/pipermail/llvm-dev/2018-January/120741.html

Technical details of the extension:

- A single unwind group describes a (prologue_part1, prologue_part2,
body, epilogue) tuple.
- The prologue is conceptually split into two parts: the first part
extends up to and including the instruction that decreases RSP; the
second part extends to a point after the last preserved register is
saved but before any preserved register is modified (this location is
not unique, providing flexibility).
  + When unwinding in the prologue, the RSP register value can be
inferred from the PC and the set of saved registers.
- Since register restoration is idempotent (restoring preserved
registers multiple times during unwinding causes no harm), there is no
need to describe `pop $reg` sequences. The unwind group needs just one
bit to describe whether the 1-byte `ret` instruction is present.
- The `length` field in the compact unwind group descriptor is
repurposed to describe the prologue's two parts.
- By composing multiple unwind groups, potentially with zero-sized
prologues or omitting `ret` instructions in epilogues, it can describe
functions with shrink wrapping or tail duplication optimization.
- Null frame groups (with no prologue or epilogue) are the default and
can describe trampolines and PLT stubs.

Now, to compare this against SFrame's space efficiency for synchronous
unwinding, I've built llvm-mc, opt, and clang with
-fno-asynchronous-unwind-tables -funwind-tables across multiple build
configurations (clang vs gcc, frame pointer vs sframe). The resulting
.sframe section sizes are significant:

% cat ~/tmp/test-unwind.sh
#!/bin/zsh
conf() {
  configure-llvm $@ -DCMAKE_EXE_LINKER_FLAGS=3D'-pie
-Wl,-z,pack-relative-relocs' -DLLVM_ENABLE_UNWIND_TABLES=3Don \
    -DCMAKE_{EXE,SHARED}_LINKER_FLAGS=3D-fuse-ld=3Dbfd -DLLVM_ENABLE_LLD=3D=
off
}

clang=3D-fno-integrated-as
gcc=3D("-DCMAKE_C_COMPILER=3D$HOME/opt/gcc-15/bin/gcc"
"-DCMAKE_CXX_COMPILER=3D$HOME/opt/gcc-15/bin/g++")

fp=3D"-fno-omit-frame-pointer -momit-leaf-frame-pointer
-B$HOME/opt/binutils/bin -Wa,--gsframe=3Dno
-fno-asynchronous-unwind-tables -funwind-tables"
sframe=3D"-fomit-frame-pointer -momit-leaf-frame-pointer
-B$HOME/opt/binutils/bin -Wa,--gsframe -fno-asynchronous-unwind-tables
-funwind-tables"

conf custom-fp-sync -DCMAKE_{C,CXX}_FLAGS=3D"$clang $fp"
conf custom-sframe-sync -DCMAKE_{C,CXX}_FLAGS=3D"$clang $sframe"
conf custom-fp-gcc-sync -DCMAKE_{C,CXX}_FLAGS=3D"$fp" ${gcc[@]}
conf custom-sframe-gcc-sync -DCMAKE_{C,CXX}_FLAGS=3D"$sframe" ${gcc[@]}

for i in fp-sync sframe-sync fp-gcc-sync sframe-gcc-sync; do ninja -C
/tmp/out/custom-$i llvm-mc opt clang; done

% ~/Dev/unwind-info-size-analyzer/section_size.rb
/tmp/out/custom-{fp,sframe}-{,gcc-}sync/bin/{llvm-mc,opt,clang}
Filename                                    |       .text size |
 EH size |   .sframe size |   VM size | VM increase
--------------------------------------------+------------------+-----------=
-----+----------------+-----------+------------
/tmp/out/custom-fp-sync/bin/llvm-mc         |  2124031 (23.5%) |
301136 (3.3%) |       0 (0.0%) |   9050149 |           -
/tmp/out/custom-sframe-sync/bin/llvm-mc     |  2114383 (22.3%) |
367452 (3.9%) |  348235 (3.7%) |   9483621 |       +4.8%
/tmp/out/custom-fp-gcc-sync/bin/llvm-mc     |  2744214 (29.2%) |
301836 (3.2%) |       0 (0.0%) |   9389677 |       +3.8%
/tmp/out/custom-sframe-gcc-sync/bin/llvm-mc |  2705860 (27.7%) |
354292 (3.6%) |  356073 (3.6%) |   9780985 |       +8.1%
/tmp/out/custom-fp-sync/bin/opt             | 38873081 (69.9%) |
3538408 (6.4%) |       0 (0.0%) |  55598521 |           -
/tmp/out/custom-sframe-sync/bin/opt         | 39011423 (62.4%) |
4557012 (7.3%) | 4452908 (7.1%) |  62494765 |      +12.4%
/tmp/out/custom-fp-gcc-sync/bin/opt         | 54654535 (78.1%) |
3631076 (5.2%) |       0 (0.0%) |  70001573 |      +25.9%
/tmp/out/custom-sframe-gcc-sync/bin/opt     | 53644831 (70.4%) |
4857220 (6.4%) | 5263530 (6.9%) |  76205733 |      +37.1%
/tmp/out/custom-fp-sync/bin/clang           | 68345753 (73.8%) |
6643384 (7.2%) |       0 (0.0%) |  92638305 |           -
/tmp/out/custom-sframe-sync/bin/clang       | 68500319 (64.9%) |
8684540 (8.2%) | 8521760 (8.1%) | 105572021 |      +14.0%
/tmp/out/custom-fp-gcc-sync/bin/clang       | 96515079 (82.8%) |
6556756 (5.6%) |       0 (0.0%) | 116524565 |      +25.8%
/tmp/out/custom-sframe-gcc-sync/bin/clang   | 94583903 (74.0%) |
8817628 (6.9%) | 9696263 (7.6%) | 127839309 |      +38.0%

Note: in GCC FP builds, .text is larger due to missing optimization
for RBP-based frames (e.g.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108386). Once this
optimization is implemented, GCC FP builds should actually have
smaller .text than RSP-based builds, because RBP-relative addressing
produces more compact encodings than RSP-relative addressing (which
requires an extra SIB byte).

.sframe for sync is not noticeably smaller than that for async. This
is probably because
there are still many DW_CFA_advance_loc ops even in
-fno-asynchronous-unwind-tables -funwind-tables builds.


```
% ~/Dev/bloaty/out/release/bloaty /tmp/out/custom-sframe-gcc-sync/bin/clang
    FILE SIZE        VM SIZE
 --------------  --------------
  64.0%  90.2Mi  74.0%  90.2Mi    .text
  10.9%  15.4Mi   0.0%       0    .strtab
   7.0%  9.92Mi   8.1%  9.92Mi    .rodata
   6.6%  9.25Mi   7.6%  9.25Mi    .sframe
   5.2%  7.38Mi   6.1%  7.38Mi    .eh_frame
   2.9%  4.14Mi   0.0%       0    .symtab
   1.4%  1.94Mi   1.6%  1.94Mi    .data.rel.ro
   0.9%  1.23Mi   1.0%  1.23Mi    [LOAD #4 [R]]
   0.7%  1.03Mi   0.8%  1.03Mi    .eh_frame_hdr
   0.0%       0   0.5%   636Ki    .bss
   0.2%   298Ki   0.2%   298Ki    .data
   0.0%  23.1Ki   0.0%  23.1Ki    .rela.dyn
   0.0%  10.5Ki   0.0%       0    [Unmapped]
   0.0%  9.04Ki   0.0%  9.04Ki    .dynstr
   0.0%  8.79Ki   0.0%  8.79Ki    .dynsym
   0.0%  7.31Ki   0.0%  7.31Ki    .rela.plt
   0.0%  6.42Ki   0.0%  3.98Ki    [20 Others]
   0.0%  4.89Ki   0.0%  4.89Ki    .plt
   0.0%  3.55Ki   0.0%  3.50Ki    .init_array
   0.0%  2.50Ki   0.0%  2.50Ki    .hash
   0.0%  2.46Ki   0.0%  2.46Ki    .got.plt
 100.0%   140Mi 100.0%   121Mi    TOTAL
```

Here is an aarch64 build:

 cmake -GNinja -Sllvm -B/tmp/out/a64-sframe -DCMAKE_BUILD_TYPE=3DRelease
-DCMAKE_C_COMPILER=3Daarch64-linux-gnu-gcc
-DCMAKE_CXX_COMPILER=3Daarch64-linux-gnu-g++
-DLLVM_HOST_TRIPLE=3Daarch64-linux-gnu -DLLVM_TARGETS_TO_BUILD=3DAArch64
-DLLVM_ENABLE_PLUGINS=3Doff -DCMAKE_EXE_LINKER_FLAGS=3D'-no-pie
-B$HOME/opt/binutils-aarch64/bin'
-DCMAKE_{C,CXX}_FLAGS=3D"-fomit-frame-pointer -momit-leaf-frame-pointer
-B$HOME/opt/binutils-aarch64/bin -Wa,--gsframe"
-DLLVM_NATIVE_TOOL_DIR=3D/tmp/out/custom-fp-gcc-sync/bin
-DLLVM_ENABLE_PROJECTS=3Dclang

% ~/Dev/bloaty/out/release/bloaty /tmp/out/a64-sframe/bin/clang
    FILE SIZE        VM SIZE
 --------------  --------------
  60.0%  71.8Mi  73.2%  71.8Mi    .text
  12.3%  14.8Mi   0.0%       0    .strtab
   8.0%  9.53Mi   9.7%  9.53Mi    .rodata
   6.2%  7.39Mi   0.0%       0    .symtab
   5.8%  6.93Mi   7.1%  6.93Mi    .eh_frame
   4.2%  5.01Mi   5.1%  5.01Mi    .sframe
   1.7%  2.00Mi   2.0%  2.00Mi    .data.rel.ro
   0.8%  1.01Mi   1.0%  1.01Mi    [LOAD #2 [RX]]
   0.8%   932Ki   0.9%   932Ki    .eh_frame_hdr
   0.0%       0   0.6%   599Ki    .bss
   0.2%   294Ki   0.3%   294Ki    .data
   0.0%  40.2Ki   0.0%  40.2Ki    .got
   0.0%  20.6Ki   0.0%       0    [Unmapped]
   0.0%  9.19Ki   0.0%  9.19Ki    .dynstr
   0.0%  8.51Ki   0.0%  8.51Ki    .dynsym
   0.0%  7.41Ki   0.0%  7.41Ki    .rela.plt
   0.0%  4.97Ki   0.0%  4.97Ki    .plt
   0.0%  4.37Ki   0.0%  4.07Ki    [17 Others]
   0.0%  3.35Ki   0.0%  3.30Ki    .init_array
   0.0%  2.49Ki   0.0%  2.49Ki    .got.plt
   0.0%  2.06Ki   0.0%       0    [ELF Section Headers]

> >    (On macOS you can check the section size with objdump --arch x86_64 =
-
> > h clang and dump the unwind info with  objdump --arch x86_64 --unwind-
> > info clang)
> >
> > OpenVMS's x86-64 port, which is ELF-based, also adopted this format as
> > documented in their "VSI OpenVMS Calling Standard" and their 2018 post:
> > https://discourse.llvm.org/t/rfc-asynchronous-unwind-tables-attribute/5=
9282
> >
> > The compact unwind format achieves this efficiency through a two-level
> > page table structure. It describes common frame layouts compactly and
> > falls back to DWARF only when necessary, allowing most DWARF CFI entrie=
s
> > to be eliminated while maintaining full functionality. For more details=
,
> > see: https://faultlore.com/blah/compact-unwinding/ and the lld/MachO
> > implemention https://github.com/llvm/llvm-project/blob/main/lld/MachO/
> > UnwindInfoSection.cpp
> >
>
> How does your vision of "linker-friendly" stack tracing/stack unwinding
> format reconcile with these suggested approaches ? As far as I can tell,
> these formats also require linker created indexes and are
> non-concatenable (custom handling in every linker).  Something you've
> had "significant concerns" about.
>

We can distinguish between linking-time and execution-time
representations by using different section names.
The OpenVMS specification says:

    It is useful to note that the run-time representation of unwind
information can vary from little more than a simple concatenation of
the compile-time information to a substantial rewriting of unwind
information by the linker. The proposal favors simple concatenation
while maintaining the same ordering of groups as their associated
code.

The runtime library can build this index at runtime and cache it to disk.

Once the design becomes sufficiently stable, we can introduce an
opt-in linker option --xxxxframe-index that builds an index from
recognized format versions while reporting warnings for unrecognized
ones.
We need to carefully design this mechanism to be stable and robust,
avoiding frequent format updates.

>  From
> https://docs.vmssoftware.com/vsi-openvms-calling-standard/#STACK_UNWIND_E=
XCEPTION_X86_64:
> "The unwind dispatch table (see Section B.3.1, ''Unwind Dispatch
> Table'') is created by the linker using information in the unwind
> descriptors (see Section B.3.2, ''DWARF Unwind Descriptors'' and Section
> B.3.3, ''Compact Unwind Description'') provided by compilers. The linker
> may use the provided unwind descriptors directly or replace them with
> equivalent optimized forms based on its optimization strategies."
>
> Above all, do users want a solution which requires falling back on
> DWARF-based processing for precise stack tracing ?

The key distinction is that compact unwind handles the vast majority
of functions without DWARF=E2=80=94the macOS measurements show __unwind_inf=
o
at 0.6% of __text size with __eh_frame reduced to negligible size
(0x58 bytes). While SFrame also cannot handle all frames, compact
unwind achieves dramatic size reductions by making DWARF the exception
rather than requiring it alongside a supplementary format.

The DWARF fallback provides flexibility for additional coverage when
needed, but nothing is lost (at least for the clang binary on macOS)
if DWARF fallback were disabled in a hypothetical future linux-perf
implementation.

> > **The AArch64 case: size matters even more**
> >
> > The size consideration becomes even more critical for AArch64, which is
> > heavily deployed on mobile phones.
> > There's an active feature request for compact unwind support in the
> > AArch64 ABI: https://github.com/ARM-software/abi-aa/issues/344
> > This underscores the broader industry need for efficient unwind
> > information that doesn't duplicate data or significantly increase binar=
y
> > size.
> >
>
> Our measurements with a dataset of about 1400 userspace artifacts
> (binaries and shared libraries) show that the SFrame/(EH Frame + EH
> Frame HDR) ratio is:
>    - Average of 0.70 on AArch64.
>    - Average of 1.00 on x86_64.
>
> Projecting the size of what you observe for clang binary on x86_64 to
> conclude the size ratio on AArch64 is not very wise to do.
>
> Whether the size impact is worth the benefit: its a choice for users to
> make.  SFrame offers the users fast, precise stack traces with simple
> stack tracers.

Thank you for providing the AArch64 measurements. Even with a 0.70x ratio o=
n
AArch64, this represents substantial memory overhead when considering:

.eh_frame is already large and being complained about.
Being unable to eliminate it (needed for debugging and C++ exceptions)
and adding 0.70x more means significant additional overhead for users.

> > There are at least two formats the ELF one can learn from: LLVM's
> > compact unwind format (aarch64) and Windows ARM64 Frame Unwind Code.
> >
>
> Please, if you have any concrete suggestions (keeping the above goals in
> mind), you already know how/where to engage.

I've provided concrete suggestions throughout this discussion.

> > **Path forward**
> >
> > Unless SFrame can actually replace .eh_frame (rather than supplementing
> > it as an accelerator for linux-perf) and demonstrate sizes smaller
> > than .eh_frame - matching the efficiency of existing compact unwind
> > approaches =E2=80=94 I question its practical viability for userspace.
> > The current design appears to add overhead rather than reduce it.
> > This isn't to suggest we should simply adopt the existing compact unwin=
d
> > format wholesale.
> > The x86-64 design dates back to 2009 or earlier, and there are likely
> > improvements we can make. However, we should aim for similar or better
> > efficiency gains.
> >
> > For additional context, I've documented my detailed analysis at:
> >
> > - https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering
> > mandatory index building problems, section group compliance and garbage
> > collection issues, and version compatibility challenges)
>
> GC issue is a bug currently tracked and with a target milestone of 2.46.
>
> > - https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-trade=
-
> > offs (size analysis)
> >

