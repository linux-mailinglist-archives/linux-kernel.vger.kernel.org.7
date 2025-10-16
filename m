Return-Path: <linux-kernel+bounces-855789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F48ABE2514
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FD43BF030
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93763164AF;
	Thu, 16 Oct 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF/BJoL9"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258231159C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605979; cv=none; b=p8utrzu/oWusxwP8cD0CFpLBqNeTv8aplEfuP5UkpJjsyIsRmwGTQpOpYOq00GpptginQn0+rcLnN/q49WI1Z3VbeqnOTy/DGMUMh5+qbAXSQsjxwuKR+MYXic/JlrEKC+2GkqRGqzrAhUiYgn/Js3kW3Y9B9EZg5LADKCODh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605979; c=relaxed/simple;
	bh=GGEUW6KOaLX1UlGivWjcTY6fgAcKRSv+ggwdMcd5xFI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jRdPgrpwRXVrULNLu+sv7ERQ/UGIXjawMZPw7euQCg7FicZZCdGR90BNpwW8Zcc3R3RgzqaTQo+TmU8QVy/UnhPezqxMoUMAFinhGWIWo78EdG/BMhpicV/f3Mfq0Gzog2Xs4Cy6B28q8OMGAINa2C+FMs9RT6jPgZAOCv1wZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF/BJoL9; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-36f13d00674so373947fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760605976; x=1761210776; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dy4LI72X5M+MuvyXzIBRU1PdeSk9XBJhqjZ4dH7N3+A=;
        b=BF/BJoL9ITXW6cVnPD3uV97iH6V9onQfOpRCBVlXiZzU4vFZAoNwTM0vIbxPZ5+jJQ
         pH6rpL+NFItGZ62xLy60v+0an4xUeHMWWC3ORt0olIYt6tQ2zy+5OHLlphz477CIlldv
         qGcX11c6rFlvybJ/T4JT5WcpUgZkemJDPMochyNsrIp5gdLSi2WqhuUwD7P9hkoKPj7E
         D26CwZ5bJ8zpP8aH3lmrzf1cKsKlvZCEKUHSLXjB+u1GnDYxJONOZ4gWfYRN1+nzqHgr
         ACIoLEdM6g7Q/Pnjvo+qiomSJJ5glYu044ZD84TwbtuG6bevWatGHRpBm+7fR9OiNvRk
         +pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605976; x=1761210776;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dy4LI72X5M+MuvyXzIBRU1PdeSk9XBJhqjZ4dH7N3+A=;
        b=f0+Kbc2otxNXUT6Zh2DRi/pQ/ScO3wPxfjUnZLZyB/rFtZAOmk/AZ69cXd02vwEOri
         b4pvRXs+UtR8yxC5gPuh2OCegjW/81v7fZHoQmbwi7fH++yEKrSS82gOdkCxPKgEQ5Hd
         vMl3lKDMpqcVUph1GM8WJ2Bf9ApYPGFnuxBRDFt+ZfVMt/ZFbB3ImjuJNdGyVA8MOkfP
         7U6HHMvaAYe6btTNecoQxnfgDYHMYrowa5lhocqqiYeE2lQm/XOZ2PTye+mNqQeNvWF6
         Gf380Ybqc+eyKjBfxEebKUh7T67usy5r7zMAxTm8CyAtvbNvBhwuXpDYAGPzgug33bhL
         aGLA==
X-Forwarded-Encrypted: i=1; AJvYcCUPwad0n0oOrBVK5ULR3sqVaMGfR2/rgo+AFLX16LBmJ1TOW3uFidIw5xDo4DSOLGrbHVMB8ZNKwjf/haI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DhpORjLGlRSSAi3dTsPzjFWoy0jHl1kShzD45IQm5zbGoVVG
	wtQo2LYXGP7AxdsWPVmSn942TeeJcDrF0wRq1dGDAO02yvFpydeJU4OdkLBSPnDxuNnig21WYl6
	tuUO+yetlBL4GtNfzZ6m2XTDuwacpL/n4ViGS
X-Gm-Gg: ASbGncsyoEgMH9nqPCLzA72rPqyEn+2H9N3qjIy85sHdbKoyOML30Zr3C9Vh2yE6nfp
	XgexPosuDoYknsi/UzRQ4YnajYRhC/1Gll85sLrtgOD/BJqYYfhzM/HF1RsaSqDFwtvOKf1vEM2
	30qGoOEQBvqet5nkzYJhRlvshMhuxjQBkQxwc6FYVexMKCHBPLc1HLodlZh8jRQ9eaWqsGv2Us3
	Nd4knZkPixBu+6NJ/kihfeRJzdKyR2/hDA5PpF3rQpgvnyRv7rgAjr0z0UlYDDQrZjbelEQUwzg
	ajSe9KQDJyVQbJf5zSDuW7EL2w==
X-Google-Smtp-Source: AGHT+IHfYpaDwbZicHiKXMwiEdTDiYPjCUL8oMAPlA3iukvSjByLOjP1KViIlQWUfEfwTsqBbfQbhxijoyuuRP6KxVI=
X-Received: by 2002:a05:6870:4688:b0:395:b63a:520a with SMTP id
 586e51a60fabf-3c0f6d3d4e5mr15094463fac.22.1760605976500; Thu, 16 Oct 2025
 02:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 16 Oct 2025 17:12:20 +0800
X-Gm-Features: AS18NWDBnnTJr-RaCzpBeJW6Pe-tjeTQo9kyzhNbqEpulebVD7iGbdjXceFntUE
Message-ID: <CAAfSe-uGLQ5fC31BggZ73P1vp5YckvntOy5CH_MGD3S+cp_TtQ@mail.gmail.com>
Subject: Impact of RISC-V C Extension on Linux Kernel Size
To: linux-riscv@lists.infradead.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I was recently asked how much the RISC-V C extensions can shrink the
Linux kernel size. I looked it up online and could only roughly
predict a 25% reduction in theory. But I couldn't find more specific
data on the Linux kernel program. So I compiled a few kernel images
with or without RISC-V C extension and would like to share the data
and analysis. Maybe someone will also be interested.

The kernel version is v6.18-rc1, toolchain is
riscv64-glibc-ubuntu-22.04-gcc-nightly-2025.09.28-nightly.

Compile with C extension is the default, so to disable C extension on
riscv64, I hacked two Makefiles like below:

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index ecf2fcce2d92..e51810608695 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -61,7 +61,6 @@ endif
 riscv-march-$(CONFIG_ARCH_RV32I)       := rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)       := rv64ima
 riscv-march-$(CONFIG_FPU)              := $(riscv-march-y)fd
-riscv-march-$(CONFIG_RISCV_ISA_C)      := $(riscv-march-y)c
 riscv-march-$(CONFIG_RISCV_ISA_V)      := $(riscv-march-y)v

 ifneq ($(CONFIG_RISCV_ISA_C),y)
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f60fce69b725..0c93c397fed0 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -46,6 +46,7 @@ endif
 always-$(KBUILD_BUILTIN) += vmlinux.lds

 obj-y  += head.o
+AFLAGS_head.o  += -march=rv64gc
 obj-y  += soc.o
 obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
 obj-y  += cpu.o


First with C extension (default):

    $ make defconfig
    $ time make vmlinux -j32
       real 4m27.219s
       user 57m28.761s
       sys 5m19.494s
    $ size vmlinux
        text     data     bss       dec      hex  filename
    13294359  6288266  423589  20006214  1314546  vmlinux

Without C extension:

    $ make clean
    $ time make vmlinux -j32
       real 4m34.450s
       user 58m52.848s
       sys 5m25.042s
    $ size vmlinux
        text     data     bss       dec      hex  filename
    17728589  6288586  423589  24440764  174efbc  vmlinux

Build time for both is close, and we can get 25% and 18% for text
section and vmlinux size reduction respectively with C extension
support.

I also get performance test results with perf on Pioneer Board, which
is running kernel 6.6.111,

With C extension,

Performance counter stats for 'netperf' (3 runs):

          9,966.81 msec task-clock                       #    0.995
CPUs utilized               ( +-  0.04% )
               780      context-switches                 #   78.260
/sec                        ( +-  1.74% )
                35      cpu-migrations                   #    3.512
/sec                        ( +-  3.30% )
               121      page-faults                      #   12.140
/sec                        ( +-  5.86% )
    19,924,390,238      cycles                           #    1.999
GHz                         ( +-  0.04% )
     7,681,821,013      instructions                     #    0.39
insn per cycle              ( +-  0.88% )
                 0      branches                         #    0.000
/sec
                 0      branch-misses

          10.01376 +- 0.00290 seconds time elapsed  ( +-  0.03% )

Without C extension,

Performance counter stats for 'netperf' (3 runs):

          9,967.98 msec task-clock                       #    0.995
CPUs utilized               ( +-  0.02% )
               772      context-switches                 #   77.448
/sec                        ( +-  1.78% )
                33      cpu-migrations                   #    3.311
/sec                        ( +-  4.63% )
               126      page-faults                      #   12.640
/sec                        ( +-  2.12% )
    19,925,181,546      cycles                           #    1.999
GHz                         ( +-  0.02% )
     6,639,648,698      instructions                     #    0.33
insn per cycle              ( +-  0.96% )
                 0      branches                         #    0.000
/sec
                 0      branch-misses

          10.01589 +- 0.00309 seconds time elapsed  ( +-  0.03% )

IPC from 0.33 (without C) to 0.39 (with C), IPC is improved by 18%.

Thanks,
Chunyan

