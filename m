Return-Path: <linux-kernel+bounces-820474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B6B7EB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876C61C01F31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901B303A1B;
	Wed, 17 Sep 2025 10:26:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADD22B584
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104764; cv=none; b=KY7oTZTeDZRmu1aQVYE5QpKwSfBFVs4Fds6h8Kd/mTtoNuebaU4FwxGpcxgi5LfCWmX1SfbTtEL6E97s/mX2qZJ9mrDl5jRKGwljRB5sqs9u7bCqwCbj+AsSumTPzVDaqBwCEYPWmetABczG+WUYF4vwU33Q++vrlSh1Ldse1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104764; c=relaxed/simple;
	bh=qOATxe7YHEeUxYdiJOxifjy5dg1cX8mE99RsBSDdIXM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RzY7wZBd+EPKr6cFCkjLovWbU28TqkYdCiFDtSHbnOu1Gn+T587+o0i+M22G/9nagz0h1sQd4xz+ZzvgKjUC09Q+KAeT/jSM7WZEDBnA+/wTWAl8h6g62ANnbKvGTJwXSwC5THYtmmlDPahOBLd76ln1Uwe4zUNfUZBjtP/+V9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4020e59b735so175013205ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104762; x=1758709562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B85rVoswbzudbsfvLMiTT0eyxEQ7zlNvGUF+wCih0LI=;
        b=PkMd4xzH0+/+uQYQMIL0P2BTgBw/3YggqS5E4qWGIOalF9OCdJlPlUod1nhnAuImmP
         nKPU1wf9Ts+oOWU8WzDrqSIbL6nYNxIC/Wltpi0l6Azom1x8VgMpNh5Mz5hQeZA9fwoF
         UWwJB1G5X0nmSfKzPMZzrdbrQVzkkQweV5rS07mveoLkiXLf2DZavQZ9yHByaA3wOOIU
         wQDjil4dSJum5Ed1zoNU4ISnP0cvfzS9JOGfVvDrTzVwyuMyIPcVO+zIVRLP1GznYqHV
         UNQ526detz6HIhYxcfNJOSHKXQY1ENM/cC8W8QBjwqcgFXOe7X8q7KhX9DB+maARUcN8
         2mug==
X-Gm-Message-State: AOJu0YyIBfQyyraR3Gk0vyxUMkFsQZ5UjRi1BzuBvE/O7r9SdeTM1mww
	8vs/hBcCegE4RLOB2//Elv9NKliIqatqw/xgWP4gyCn0GO++oq9+03tjB7S8zlUuD5tznjXeGmI
	kbeCTD+db84o53s8hJim2MRwJRi5mSi2hYY2jctYTaimKRtUu8oCsgGDMvkk=
X-Google-Smtp-Source: AGHT+IFp1GEUhiEifNAZUU92F2K/2QbyDOO+RfNSYEFntJeP6zSWvmZbcvvjrYMq7VegYk7kTcUhWksKvNEXogYe5xNtiuRkK1xP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:423:feda:f15d with SMTP id
 e9e14a558f8ab-4241a5330e9mr18133745ab.22.1758104762195; Wed, 17 Sep 2025
 03:26:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 03:26:02 -0700
In-Reply-To: <CAPrAcgNtStXdajzsDgWqyLVAMok5gpKtmt=zU2vWNr93hhzGPg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca8cba.050a0220.3c6139.0fa5.GAE@google.com>
Subject: Re: [syzbot] [net?] [usb?] WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to run ["make" "KERNELVERSION=syzkaller" "KERNELRELEASE=syzkaller" "LOCALVERSION=-syzkaller" "-j" "64" "ARCH=x86_64" "LLVM=1" "bzImage"]: exit status 2
  GEN     arch/x86/include/generated/asm/orc_hash.h
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  HOSTCC  scripts/basic/fixdep
  UPD     include/config/kernel.release
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  UPD     include/generated/uapi/linux/version.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  UPD     include/generated/utsrelease.h
  UPD     arch/x86/include/generated/asm/cpufeaturemasks.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  WRAP    arch/x86/include/generated/asm/fprobe.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/mmzone.h
  WRAP    arch/x86/include/generated/asm/irq_regs.h
  WRAP    arch/x86/include/generated/asm/kmap_size.h
  WRAP    arch/x86/include/generated/asm/local64.h
  WRAP    arch/x86/include/generated/asm/mmiowb.h
  WRAP    arch/x86/include/generated/asm/module.lds.h
  WRAP    arch/x86/include/generated/asm/rwonce.h
  WRAP    arch/x86/include/generated/asm/unwind_user.h
  UPD     include/generated/compile.h
  DESCEND objtool
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/libfdt/fdt.o
  HOSTCC  scripts/dtc/libfdt/fdt_ro.o
  HOSTCC  scripts/dtc/libfdt/fdt_wip.o
  HOSTCC  scripts/dtc/libfdt/fdt_sw.o
  HOSTCC  scripts/dtc/libfdt/fdt_rw.o
  HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
  HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
  HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
  HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
  HOSTCC  scripts/dtc/fdtoverlay.o
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  arch/x86/tools/relocs
  INSTALL /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/include/subcmd/exec-cmd.h
  INSTALL /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/include/subcmd/help.h
  INSTALL /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/include/subcmd/pager.h
  INSTALL /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/include/subcmd/parse-options.h
  INSTALL /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/include/subcmd/run-command.h
  INSTALL libsubcmd_headers
  HOSTLD  scripts/dtc/fdtoverlay
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/exec-cmd.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/help.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/pager.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/parse-options.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/run-command.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/sigchain.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/subcmd-config.o
  HOSTLD  scripts/dtc/dtc
  HOSTRUSTC scripts/generate_rust_target
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/sorttable
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/gendwarfksyms/gendwarfksyms.o
  HOSTCC  scripts/gendwarfksyms/cache.o
  HOSTCC  scripts/gendwarfksyms/die.o
  HOSTCC  scripts/gendwarfksyms/dwarf.o
  HOSTCC  scripts/gendwarfksyms/kabi.o
  HOSTCC  scripts/gendwarfksyms/symbols.o
  HOSTCC  scripts/gendwarfksyms/types.o
  HOSTCC  scripts/sign-file
  LD      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/libsubcmd-in.o
  AR      /syzkaller/jobs-2/linux/kernel/tools/objtool/libsubcmd/libsubcmd.a
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/weak.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/check.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/special.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/arch/x86/special.o
  MKDIR   /syzkaller/jobs-2/linux/kernel/tools/objtool/arch/x86/lib/
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/builtin-check.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/arch/x86/orc.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/elf.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/objtool.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/orc_gen.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/orc_dump.o
  GEN     /syzkaller/jobs-2/linux/kernel/tools/objtool/arch/x86/lib/inat-tables.c
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libstring.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/libctype.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/str_error_r.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/librbtree.o
  CC      /syzkaller/jobs-2/linux/kernel/tools/objtool/arch/x86/decode.o
  HOSTLD  scripts/gendwarfksyms/gendwarfksyms
  LD      /syzkaller/jobs-2/linux/kernel/tools/objtool/arch/x86/objtool-in.o
  LD      /syzkaller/jobs-2/linux/kernel/tools/objtool/objtool-in.o
  LINK    /syzkaller/jobs-2/linux/kernel/tools/objtool/objtool
  UPD     scripts/target.json
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  CC      scripts/mod/devicetable-offsets.s
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTCC  scripts/mod/symsearch.o
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CHKSHA1 include/linux/atomic/atomic-arch-fallback.h
  CHKSHA1 include/linux/atomic/atomic-instrumented.h
  CHKSHA1 include/linux/atomic/atomic-long.h
  UPD     include/generated/timeconst.h
  UPD     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  RUSTC L rust/core.o
  BINDGEN rust/bindings/bindings_generated.rs
  BINDGEN rust/bindings/bindings_helpers_generated.rs
  CC      rust/helpers/helpers.o
  RUSTC P rust/libpin_init_internal.so
  RUSTC P rust/libmacros.so
  BINDGEN rust/uapi/uapi_generated.rs
  RSCPP     rust/kernel/generated_arch_static_branch_asm.rs
  RSCPP     rust/kernel/generated_arch_warn_asm.rs
  RSCPP     rust/kernel/generated_arch_reachable_asm.rs
  EXPORTS rust/exports_helpers_generated.h
  EXPORTS rust/exports_core_generated.h
  RUSTC L rust/compiler_builtins.o
  RUSTC L rust/ffi.o
  RUSTC L rust/pin_init.o
  RUSTC L rust/build_error.o
  RUSTC L rust/bindings.o
  RUSTC L rust/uapi.o
  EXPORTS rust/exports_bindings_generated.h
  RUSTC L rust/kernel.o
error: expected one of `,` or `}`, found `;`
  --> rust/kernel/block/mq/gen_disk.rs:12:23
   |
12 |     fmt::{self, Write};
   |                       ^
   |                       |
   |                       expected one of `,` or `}`
   |                       help: missing `,`

error: aborting due to 1 previous error

make[2]: *** [rust/Makefile:553: rust/kernel.o] Error 1
make[1]: *** [/syzkaller/jobs-2/linux/kernel/Makefile:1286: prepare] Error 2
make: *** [Makefile:248: __sub-make] Error 2



Tested on:

commit:         05af7647 Add linux-next specific files for 20250916
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124d0f62580000


