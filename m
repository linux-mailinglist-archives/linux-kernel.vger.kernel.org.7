Return-Path: <linux-kernel+bounces-745083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04244B114AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AEF27B7AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B9F24293C;
	Thu, 24 Jul 2025 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xntmUQ80"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70E12DDA1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400227; cv=none; b=kedaI7w3tZzfCKvKolySJLnuV/97wJ1NvxoS0GHANGYugpGMEZDWS8Tr1QfaFVkj5cG38GynCNI6L6F3FIDz4Uspa8LWMVCQ031zkjlrpBJiQ/tFdCInLGfyCvl4c+UV66DGAjCeNXSrV7Y9y9qd1EtDMMjqhtZlbVs8ND1y7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400227; c=relaxed/simple;
	bh=OYEsvWI+7LpwTezqF4Qm5CPF9lFolmJzH6gAS9dw9e0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HFlV1F7jUpvgX5lPpLqd/Ka8PIkXM/J6BjkXIqm4lEEzrUwFmG1p89xWgWFZkGe/afQgCbSvf6bim4iS/iMouX/oMs+hsV6g5PBtGrxN5zYSiKV9g1DrbLNiaX8Zn8E9kieQ4xDTF42Bk3WtXJ28nPM7hY8c5dSbzsKlBJdIskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xntmUQ80; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c8a5053c2so12909525ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753400225; x=1754005025; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+gXzIdU61xINYweA3A+NL6d5ZRp4vso9nWy72/uM8k=;
        b=xntmUQ8069CCEJZ1+QsoUa/CvcNa9mMZvT0YRFlsFr8zQ6G5mY2qc6/vmfCwRDE3kE
         Eh7XW3iwq5Q3G3dJtHb4np7agFL/CwurX3xieAfKa+/JSWCEfY3UObHqTfy1Vfrr248D
         NETsvI0msfI102Tb9klP2VXTAhHaSWBiVljTsBtTO6MdGvcwvE3oALpaud2YXuWBsiQ/
         Gfc+Gn4+9QWIOrbhXBDxqIrK3ZW06tBOphX7pYE3LTpcKHyIhklKhLSnIyvz1MkXsXEp
         9SuGb2xmA1EJMWFY/+n3tLlIEhvEg8gjhbhxpzN6cHGCWATB00hpcWcmmlbjZkandQB8
         wnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753400225; x=1754005025;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+gXzIdU61xINYweA3A+NL6d5ZRp4vso9nWy72/uM8k=;
        b=UDTvJLwd6kzOF8waNxpJ+TMJBwSsK9evYnpMqgzPAfIBvMdrSb62TPT6ALJ5xXCuJG
         1PFYzYHYvpzA9MZbBopVXQjcYoBBIXih2bDcnSAPSJ3J1PFCL0mW08dSMvpUWAmwgzLk
         Ic6EDrgIrGwlVDl3JqQiry7gq78e3s8m6TyulGN6kBJqxxmtExw4JN1pANKFfGfCqmw1
         W4VYynDejdWjTUhTk2FBiGEWCMnpbiitVAa9ZCgFHs3H6i5A9OaQ8NRKxoWz1B3xz6Jx
         NY13YrabUisAAScaDhzRKDR2GgejtsB6KEXKPBWcWJ8pxYN0kn64cfRBlKUusLqW0V2E
         /DrA==
X-Forwarded-Encrypted: i=1; AJvYcCV0HcNIVV4NPdnq3axD5Kufx2QfkQwvPSmn8ONIPPi4Mz+A+PTAex88gSVVsVbumMnJ2HYFixwX+u1VyWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3VjSg6LUTR4Se17nGC/JIzZavsNxQebDSBIqyJXCiqhPLYxI
	r882s0zHT06gH/YOJxIPUCzr88BL9Q6Vbf12PcqzTklLGG5EKXsfMxva/rqUbKLLtqM=
X-Gm-Gg: ASbGncu8LlNqb9wOFu/vCWjB+3Tq44tBHOmKPJKNRa6Fus7H57F0tCKMlM2D/gbATyT
	/W0ATeEHYL4Knl9QDVIDX8sutDGpCz/ghvHOi9TiqX/wX1IVWIC4hWpSq2vcbSGJ5kxsgtID5Rt
	lZGnT48DRw7UzR7Fl86QTBxXnbJ/KHsYzRjB8yftTPUPgQGpnjaUjaAvUvBogeLVhrkcJhdZQBZ
	xwLsLpAkVoMjVb3gD7AgXZIsZk0P3GgVTU8QiroSbfwiAoWllsw/Gb3c1byIH1+FC4FEy/clClI
	booYrApVLfzTwHVjkmjuKsBs2q1IuTRhLZglWMQNXZF0iIrnWK28lhTZlYJuS753ClpNh1BB9iH
	oNGb80wmz/rNFwb7UQgq7ZAyNPGW0uz9L
X-Google-Smtp-Source: AGHT+IFr7l7kjkqrXt81vLsMKucPZmY9zD/JPe8FlvG5PsYFoAY8mYZhkhl/H2Tn5r65e1Axf3ZuZg==
X-Received: by 2002:a17:903:1b63:b0:223:653e:eb09 with SMTP id d9443c01a7336-23f98161f8dmr123171695ad.7.1753400224864;
        Thu, 24 Jul 2025 16:37:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc706sm23598685ad.106.2025.07.24.16.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:37:04 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 00/11] riscv: fine grained hardware assisted kernel
 control-flow integrity
Date: Thu, 24 Jul 2025 16:36:53 -0700
Message-Id: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJXDgmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Mz3aLM4uSy+OzktEzdNAtTw7QkI0Mji6Q0JaCGgqLUtMwKsGHRsbW
 1AHi6z7JcAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>, 
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com, 
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com, 
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com, 
 heinrich.schuchardt@canonical.com, andrew@sifive.com, ved@rivosinc.com, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This patch series enables fine grained control-flow integrity for kernel
on riscv platform. I did send out a RFC patchset [1] more than an year ago.
Since it's been a while, I am resetting the versioning and calling it a RFC
due to following reasons

- This is first (in a while)  and I may have missed things.
- Earlier patchset were not fine-grained kcfi. This one is.
- Toolchain used to compile kernel is still in development.
- On asm indirect callsites, setting up label need toolchain support.

It is based on 6.16-rc1 with user cfi enabling patchset(v18)[2] applied on it.
Hardware guarantee on kernel's control flow integrity is enforced via zicfilp
and zicfiss riscv cpu extensions. Please take a look at user cfi enabling
patchset for more details and references on these cpu extensions.

Toolchain
----------
As mentioned earlier toolchain used to develop this patchset are still in
development. But you can grab them here [3]. This is how I configure and
compile toolchain.

$ ./riscv-gnu-toolchain/configure \
--prefix=/scratch/debug/open_src/sifive_cfi_toolchain/INSTALL_funcsig \
--with-arch=rv64gc_zicfilp_zicfiss_zicsr_zifencei_zimop_zcmop \
--enable-debug-info --enable-linux --disable-gdb  --with-abi=lp64d \
--with-label-scheme=func-sig \
--with-linux-headers-src=/scratch/debug/linux/kbuild/usr/include

$ make -j$(nproc)

If `-fcf-protection=full` is selected, toolchain is enabled to generate
labeled landing pad instruction at the start of the function. And
shadow stack push to save return address and sspopchk instruction in
the return path.

riscv kernel control-flow integrity
------------------------------------

As with normal user software, enabling kernel control flow integrity also
require forward control flow integrity and backward control flow integrity.
This patchset introduces CONFIG_RISCV_KERNEL_CFI config, hw assisted riscv
kernel cfi is enabled only when `CONFIG_RISCV_KERNEL_CFI=y`. Selecting
CONFIG_RISCV_KERNEL_CFI is dependent on CONFIG_RISCV_USER_CFI.

To compile kernel, please clone the toolchain (link provided above), build
it and use that toolchain bits to compile the kernel. When you do `menuconfig`
select `Kernel features` --> `riscv userspace control flow integrity`.
When you select `riscv userspace control flow integrity`, then `hw assisted
riscv kernel control flow integrity (kcfi)` will show up. Select both and
build.

I have tested kcfi enabled kernel with full userspace exercising (unlabeled
landing pads) cfi starting with init process. In my limited testing, this
boots. There are some wrinkles around what labeling scheme should be used
for vDSO object. This patchset is using labeled landing pads for vDSO.
We may end up using unlabeled landing pad for vDSO for maximum compatibility.
But that's a future discussion.

Qemu command line to launch:
/scratch/debug/open_src/qemu/build_zicfilp/qemu-system-riscv64 \
  -nographic \
  -monitor telnet:127.0.0.1:55555,server,nowait \
  -machine virt \
  -cpu rv64,zicond=true,zicfilp=true,zicfiss=true,zimop=true,zcmop=true,v=true,vlen=256,vext_spec=v1.0,zbb=true,zcb=true,zbkb=true,zacas=true \
  -smp 2 \
  -m 8G \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -device virtio-rng-device,rng=rng0 \
  -drive file=/scratch/debug/open_src/zisslpcfi-toolchain/buildroot/output/images/rootfs.ext2,format=raw,id=hd0 \
  -append "root=/dev/vda rw, no_hash_pointers, loglevel=8, crashkernel=256M, console=ttyS0, riscv_nousercfi=all" \
  -serial mon:stdio \
  -kernel /scratch/debug/linux/kbuild/arch/riscv/boot/Image \
  -device e1000,netdev=net0 \
  -netdev user,id=net0,hostfwd=tcp::10022-:22 \
  -virtfs local,path=/scratch/debug/sources/spectacles,mount_tag=host0,security_model=passthrough,id=host0\
  -bios /scratch/debug/open_src/opensbi/build/platform/generic/firmware/fw_jump.bin

Backward kernel control flow integrity
---------------------------------------
This patchset leverages on existing infrastructure of software based shadow
call stack support in kernel. Differences between software based shadow call
stack and riscv hardware shadow stack are:

- software shadow call stack is writeable while riscv hardware shadow stack
  is writeable only via specific shadow stack instructions.

- software shadow call stack grows from low memory to high memory while riscv
  hardware shadow stack grows from high memory to low memory (like a normal
  stack).

- software shadow call stack on riscv uses `gp` register to hold shadow stack
  pointer while riscv hardware shadow stack has dedicated `CSR_SSP` register.

Thus its ideal use existing shadow call stack plumbing and create hooks into
it to apply riscv hardware shadow stack mechanisms on it.

This patchset introduces `CONFIG_ARCH_HAS_KERNEL_SHADOW_STACK` along the lines
of `CONFIG_ARCH_HAS_USER_SHADOW_STACK`.

Forward kernel control-flow integrity
--------------------------------------
Enabling forward kernel control-flow integrity is mostly toolchain work where
it emits a landing pad instruction at the start of address-taken function. 
zicfilp allows landing pads to be labeled with a 20-bit immediate value. 
Compiler used here is following the scheme of normalizing function prototype
to a string using C++ itanium rules (with some modifications). See more details
here [4]. Compiler generates a 128bit md5 hash over this string and uses
first non-zero (scanning from MSB) 20bit segment from the 128-bit hash as label
value.

This is still a work in progress and feedback/comments are welcome.

I would like to thank Monk Chiang and Kito Cheng for helping and continue to
support from the toolchain side.

[1] - https://lore.kernel.org/lkml/CABCJKuf5Jg5g3FVpU22vNUo4UituPEM7QwvcVP8YWrvSPK+onA@mail.gmail.com/T/#m7d342d8728f9a23daed5319dac66201cc680b640
[2] - https://lore.kernel.org/all/20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com/
[3] - https://github.com/sifive/riscv-gnu-toolchain/tree/cfi-dev
[4] - https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/434

To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Masahiro Yamada <masahiroy@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nicolas.schier@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Liam R. Howlett <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
To: Bill Wendling <morbo@google.com>
To: Monk Chiang <monk.chiang@sifive.com>
To: Kito Cheng <kito.cheng@sifive.com>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: llvm@lists.linux.dev
Cc: rick.p.edgecombe@intel.com
Cc: broonie@kernel.org
Cc: cleger@rivosinc.com
Cc: samitolvanen@google.com
Cc: apatel@ventanamicro.com
Cc: ajones@ventanamicro.com
Cc: conor.dooley@microchip.com
Cc: charlie@rivosinc.com
Cc: samuel.holland@sifive.com
Cc: bjorn@rivosinc.com
Cc: fweimer@redhat.com
Cc: jeffreyalaw@gmail.com
Cc: heinrich.schuchardt@canonical.com
Cc: monk.chiang@sifive.com
Cc: andrew@sifive.com
Cc: ved@rivosinc.com

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
Deepak Gupta (11):
      riscv: add landing pad for asm routines.
      riscv: update asm call site in `call_on_irq_stack` to setup correct label
      riscv: indirect jmp in asm that's static in nature to use sw guarded jump
      riscv: exception handlers can be software guarded transfers
      riscv: enable landing pad enforcement
      mm: Introduce ARCH_HAS_KERNEL_SHADOW_STACK
      scs: place init shadow stack in .shadowstack section
      riscv/mm: prepare shadow stack for init task
      riscv: scs: add hardware shadow stack support to scs
      scs: generic scs code updated to leverage hw assisted shadow stack
      riscv: Kconfig & Makefile for riscv kernel control flow integrity

 Makefile                               |  2 +-
 arch/riscv/Kconfig                     | 37 +++++++++++++++++++++++++-
 arch/riscv/Makefile                    |  8 ++++++
 arch/riscv/include/asm/asm.h           |  2 +-
 arch/riscv/include/asm/linkage.h       | 42 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable.h       |  4 +++
 arch/riscv/include/asm/scs.h           | 48 +++++++++++++++++++++++++++-------
 arch/riscv/include/asm/sections.h      | 22 ++++++++++++++++
 arch/riscv/include/asm/thread_info.h   | 10 +++++--
 arch/riscv/kernel/asm-offsets.c        |  1 +
 arch/riscv/kernel/compat_vdso/Makefile |  2 +-
 arch/riscv/kernel/entry.S              | 21 ++++++++-------
 arch/riscv/kernel/head.S               | 23 ++++++++++++++--
 arch/riscv/kernel/vdso/Makefile        |  2 +-
 arch/riscv/kernel/vmlinux.lds.S        | 12 +++++++++
 arch/riscv/lib/memset.S                |  6 ++---
 arch/riscv/mm/init.c                   | 29 +++++++++++++++-----
 include/linux/init_task.h              |  5 ++++
 include/linux/scs.h                    | 26 +++++++++++++++++-
 init/init_task.c                       | 12 +++++++--
 kernel/scs.c                           | 38 ++++++++++++++++++++++++---
 mm/Kconfig                             |  6 +++++
 22 files changed, 314 insertions(+), 44 deletions(-)
---
base-commit: cc0fb5eb25ea00aefd49002b1dac796ea13fd2a0
change-id: 20250616-riscv_kcfi-f851fb2128bf
--
- debug


