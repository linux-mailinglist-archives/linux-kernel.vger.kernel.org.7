Return-Path: <linux-kernel+bounces-746572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58860B12871
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A57B7771
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A811BE871;
	Sat, 26 Jul 2025 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AL2Dm17g"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C81B4F2C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753493534; cv=none; b=TJAwLUTdJTlVVNaF5gja7IsVheTejd3B9OAEMIhYVbhp4Lk41DH65i200Jl6bwsmGYj1uVi/fYIU1pNBgLux8fesvbSA0UdylVXPwA+7ObFKZm8pAiMJ1tnER35uwNOkVGhGdh1IMuXk6s9MZV2XlRdBZOqMTLKwkbbBraYHmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753493534; c=relaxed/simple;
	bh=ERSKE2YPsUt5J3C4s7ImvmpnHaAX5kUY/ey+LoxTY+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY8+8CiWBj+VXUGafsqsPui1d44Q2GU9+LQZQuy9o2FowqIhRWfaH7utnKgvD9wauqaIIUTRAQby/EHtePq7SpILaRp0jrrxV3pAI+yPyarfRTbg60tvETfVlqenJ7cMYOjsxlQbc2l5qXzJEJZ/Cl537lOIbspRz82CCOE3Vq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AL2Dm17g; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f18108d2so76545ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753493532; x=1754098332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HouJp9ENFta3TdxImwDrQ4Eb1yCkqF3EASDfGijiHSE=;
        b=AL2Dm17gQCeZKtl8DIlf+HNE5LI1ajJ6Uo0ac25AsGYfOOL/2V/KXdEfANub/kgIgf
         bdUKU43rk3YAcdwko59yQkWNipAYeYprgF1On8GWAaSJGoLcJXkwjLc9uq5+NUmC4Lsy
         SRWaNeQbuO2h9E4g/yZ6lLvUW56+i4gUNUgZ1MIjxLrFMul0mlQ+eaPzkeiIh331RmOe
         oRBaWeRYs4Cptal9xnxu2bA2tWqvHSFRC5YnraphHb6MUXYj9PWtFnlCalWJCqDCniz8
         CQgJf6DXy61rqG0NRtPJDoBwIOzST2iLFkGaC3ltmKSmkcSeIpS8c5VOLAjUYYoWreZr
         LHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753493532; x=1754098332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HouJp9ENFta3TdxImwDrQ4Eb1yCkqF3EASDfGijiHSE=;
        b=Yglby1rAYR79K7acsXR+bPzaRc+9Q7k0uNN3gy/WgJdsA/ayF79CSoekNKJG8eoPmC
         9BDrbX4BWxMh2V4rzSNRv7ptduVlB7xy6ERKNM00NBXpjJXcthSSLODpLz4mJ/WqKOhl
         U6gVDJxQi3RoKbgJY09wE2jBlkt5bzTtVTyOEJBWgZgOZkwQk0+RBMsfXD9z7nMKcl5A
         hoolLCsUXJ3l+ml8Ti8mUoEmfUD3ImVfiAwOhfryUzVh0sXTS9g7fIa3Z3i/rWhsYtGH
         wp+fveSJdFTGg1XKzVeXaXND99CAZqwnn+didx8cNqZEwJzp61LNB+xttmg11SiqH/Ya
         f28w==
X-Forwarded-Encrypted: i=1; AJvYcCXj3bsQ2xixyJfxEV+UHk1SvXFUvaZ2stzs+XvA29MuHFJSDHfh+RVPTL8ukw4xtf4TZV/Mj2hEExyhakU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMN/ASbt4JsHB+lyGz4JwZuuyfSNF7/hSmBF0DE8sf13nEa+fL
	AuGvxlahou5oceE6mjC78f+n5k9Y6riu1WYKRWZ6gECNObV4Xe9vnD9H/nuWgzD71vza5AH4o3x
	+WY1UhRWld0RVfBDCG4PLf3yd7R41dhq0CWaZ5CzV
X-Gm-Gg: ASbGncts53IJs2aZpMDUXvbroTL0SZuwAfUOGVsVqyBgKhDqXSAE5Y1uqg0QPS4Qjuq
	9oe+Ws6UQ7+ktKeqM9vjk00JRW30hX3DgulKad9k771cO202Y9DaqyK0dwckS+LyCOdB8SnGPW5
	auMAL2mcs9wbcpMSPqzSrOcErXgnoTK8nUsVheS9hA9lbL7D1lf2Q1Ul34rvEidT5nmIFdSr/2h
	5P3ZvFC2Qv48uMer6hKxQQbmXD2d8ERYpE3
X-Google-Smtp-Source: AGHT+IHxvtOxMieVBRs+M19eacQ83IcBYf28oqu1rkfBjCcHhLe8R8dVY8uXbXOfQCtRTb32qWptfmfEs2xW2kHQ+FM=
X-Received: by 2002:a17:902:fc85:b0:223:2630:6b86 with SMTP id
 d9443c01a7336-23fc587f42amr839715ad.7.1753493531478; Fri, 25 Jul 2025
 18:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724000219.GA2976491@ax162>
In-Reply-To: <20250724000219.GA2976491@ax162>
From: Peter Collingbourne <pcc@google.com>
Date: Fri, 25 Jul 2025 18:31:57 -0700
X-Gm-Features: Ac12FXyn_qMia1DJjG41bJkbm7uNAl6-sLSfXFmydo2Y78IwHe3Ic3UJ9-KM3x4
Message-ID: <CAMn1gO4-ps4mOkqGgWdNFOK8g=VQnx8boRX7=bPADKy4aoi_PA@mail.gmail.com>
Subject: Re: Crash on QEMU shutdown with x86_64_defconfig+ThinLTO+CFI after
 LLVM commit 9878ef3abd2a
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 5:02=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Peter C (as Peter Z is also on CC with other kCFI folks),
>
> I bisected a crash I see when shutting down a QEMU virtual machine
> booted with a kernel built with clang tip of tree and ThinLTO and kCFI
> enabled on top of defconfig to your LLVM commit 9878ef3abd2a ("CodeGen:
> Respect function align attribute if less than preferred alignment.") [1]
>
> $ git show -s --format=3D'%h ("%s")'
> a933d3dc1968 ("Add linux-next specific files for 20250723")
>
> $ clang --version | head -1
> ClangBuiltLinux clang version 22.0.0git (https://github.com/llvm/llvm-pro=
ject.git e67f3237d6242d1c362fa52e782ddfd5ae54a8af)
>
> $ make -skj"$(nproc)" ARCH=3Dx86_64 LLVM=3D1 mrproper defconfig
>
> $ scripts/config -d LTO_NONE -d WERROR -e LTO_CLANG_THIN -e CFI_CLANG
>
> $ make -skj"$(nproc)" ARCH=3Dx86_64 LLVM=3D1 olddefconfig bzImage
>
> $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/downlo=
ad/20241120-044434/x86_64-rootfs.cpio.zst | zstd -d >rootfs.cpio
>
> $ qemu-system-x86_64 \
>     -display none \
>     -nodefaults \
>     -M q35 \
>     -d unimp,guest_errors \
>     -append 'console=3DttyS0 earlycon=3Duart8250,io,0x3f8' \
>     -kernel arch/x86/boot/bzImage \
>     -initrd rootfs.cpio \
>     -cpu host \
>     -enable-kvm \
>     -m 512m \
>     -smp 8 \
>     -serial mon:stdio
> [    0.000000] Linux version 6.16.0-rc7-next-20250723 (nathan@ax162) (Cla=
ngBuiltLinux clang version 22.0.0git (https://github.com/llvm/llvm-project.=
git e67f3237d6242d1c362fa52e782ddfd5ae54a8af), ClangBuiltLinux LLD 22.0.0 (=
https://github.com/llvm/llvm-project.git e67f3237d6242d1c362fa52e782ddfd5ae=
54a8af)) #1 SMP PREEMPT_DYNAMIC Wed Jul 23 10:30:40 MST 2025
> ...
> [    1.091342] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [    1.092163] CPU: 2 UID: 0 PID: 155 Comm: ifdown Not tainted 6.16.0-rc7=
-next-20250723 #1 PREEMPT(voluntary)
> [    1.093631] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [    1.095245] RIP: 0010:xfrm4_dst_lookup.llvm.2597333927409562488+0xac/0=
xc0
> [    1.096294] Code: 12 8b 47 28 89 44 24 30 48 8b 3f 48 89 e6 31 d2 e8 d=
9 9e f6 ff 65 48 8b 0d 11 5f 63 01 48 3b 4c 24 38 75 0a 48 83 c4 40 e9 fc <=
ff> ff fe cc e8 3b d7 24 00 cc cc cc cc cc cc cc cc cc cc cc ba 4a
> [    1.099091] RSP: 0018:ff422e64c03bfce0 EFLAGS: 00010246
> [    1.099899] RAX: ff2413ab81e95710 RBX: ff2413ab81e95740 RCX: 000000000=
0000001
> [    1.100961] RDX: ffffffff9e644197 RSI: 0000000000000000 RDI: ff2413ab8=
1e95710
> [    1.102001] RBP: ffffffff9e705850 R08: 0000000000000006 R09: ffffffff9=
f5523e4
> [    1.103011] R10: 0000000000000000 R11: ffffffff9d28d270 R12: ff2413ab8=
1857001
> [    1.104031] R13: ff2413ab81e95830 R14: ffffffff9e705850 R15: ff2413ab8=
1e957c0
> [    1.105097] FS:  00007fc43bee46a0(0000) GS:ff2413abff95a000(0000) knlG=
S:0000000000000000
> [    1.106204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.107050] CR2: 0000560f4233b1c8 CR3: 00000000028a2005 CR4: 000000000=
0771ef0
> [    1.108058] PKRU: 55555554
> [    1.108477] Call Trace:
> [    1.108907]  <TASK>
> [    1.109235]  shmem_destroy_inode+0x1e/0x40
> [    1.109822]  evict+0x2c9/0x340
> [    1.110248]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    1.110969]  ? fsnotify_grab_connector+0x50/0x75
> [    1.111601]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    1.112349]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    1.113124]  ? _atomic_dec_and_lock+0x2c/0x50
> [    1.113832]  __dentry_kill+0xb3/0x220
> [    1.114393]  dput+0x47/0x8b
> [    1.114871]  do_renameat2+0x492/0x650
> [    1.115365]  __x64_sys_renameat2+0x47/0x60
> [    1.115982]  do_syscall_64+0xc8/0x1f0
> [    1.116508]  ? arch_exit_to_user_mode_prepare+0x9/0x60
> [    1.117278]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    1.117973]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [    1.118714] RIP: 0033:0x7fc43be4af2e
> [    1.119304] Code: 08 00 f7 d8 64 89 02 48 83 c8 ff c3 49 89 f2 45 31 c=
0 48 89 fe b8 3c 01 00 00 48 c7 c2 9c ff ff ff 48 c7 c7 9c ff ff ff 0f 05 <=
48> 3d 00 f0 ff ff 76 10 48 8b 15 1b ef 08 00 f7 d8 64 89 02 48 83
> [    1.122003] RSP: 002b:00007ffdc8a3f9d8 EFLAGS: 00000246 ORIG_RAX: 0000=
00000000013c
> [    1.123107] RAX: ffffffffffffffda RBX: 0000560f27b9e6f6 RCX: 00007fc43=
be4af2e
> [    1.124056] RDX: ffffffffffffff9c RSI: 0000560f27b9e6f6 RDI: fffffffff=
fffff9c
> [    1.125113] RBP: 0000560f27b9e51f R08: 0000000000000000 R09: 00007fc43=
bee32b0
> [    1.126134] R10: 0000560f27b9e51f R11: 0000000000000246 R12: 0000560f2=
7b9f2e3
> [    1.127148] R13: 0000560f42338030 R14: 0000000000000000 R15: 0000560f2=
7b1f389
> [    1.128222]  </TASK>
> [    1.128558] Modules linked in:
> [    1.129114] ---[ end trace 0000000000000000 ]---
> [    1.130101] RIP: 0010:xfrm4_dst_lookup.llvm.2597333927409562488+0xac/0=
xc0
> [    1.131451] Code: 12 8b 47 28 89 44 24 30 48 8b 3f 48 89 e6 31 d2 e8 d=
9 9e f6 ff 65 48 8b 0d 11 5f 63 01 48 3b 4c 24 38 75 0a 48 83 c4 40 e9 fc <=
ff> ff fe cc e8 3b d7 24 00 cc cc cc cc cc cc cc cc cc cc cc ba 4a
> [    1.134589] RSP: 0018:ff422e64c03bfce0 EFLAGS: 00010246
> [    1.135360] RAX: ff2413ab81e95710 RBX: ff2413ab81e95740 RCX: 000000000=
0000001
> [    1.136369] RDX: ffffffff9e644197 RSI: 0000000000000000 RDI: ff2413ab8=
1e95710
> [    1.137407] RBP: ffffffff9e705850 R08: 0000000000000006 R09: ffffffff9=
f5523e4
> [    1.138442] R10: 0000000000000000 R11: ffffffff9d28d270 R12: ff2413ab8=
1857001
> [    1.139563] R13: ff2413ab81e95830 R14: ffffffff9e705850 R15: ff2413ab8=
1e957c0
> [    1.140673] FS:  00007fc43bee46a0(0000) GS:ff2413abff95a000(0000) knlG=
S:0000000000000000
> [    1.142116] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.143131] CR2: 0000560f4233b1c8 CR3: 00000000028a2005 CR4: 000000000=
0771ef0
> [    1.144199] PKRU: 55555554
> ```
>
> If I add 'cfi=3Doff' to the cmdline in the '-append' value when booting
> the exact same kernel, I do not get a panic on shutdown. I initially
> noticed that this only happened on linux-next but not mainline, so I
> bisected Linux and landed on a seemingly innocuous change. Only once I
> realized that LLVM 21.1.0-rc1 had no issue did I think to bisect LLVM
> for the change, which landed me on 9878ef3abd2a.
>
> I suspect that the run time patching of FineIBT / kCFI is involved,
> given the way the Linux bisect went and the fact that turning off CFI at
> run time results in no issues (hence CC'ing Peter Z). The fact this
> requires LTO is suspect as well. I know little about the run time
> patching that x86 does but it has had problems with the alignments of
> functions changing such as when GCC would not respect
> '-falign-functions' on __cold functions. Does this deviate from GCC's
> behavior? I am not sure how to better uncover what is going on here.
>
> [1]: https://github.com/llvm/llvm-project/commit/9878ef3abd2a48fcfb81357d=
581dac292b52ddb3

Hi Nathan,

My LLVM patch was intended to align (no pun intended) the behavior
between Clang and GCC. I was unaware of GCC's __cold behavior; there
may be a difference there.

I was unable to reproduce the issue locally using the LLVM and kernel
revision you mentioned. The resulting kernel boots as normal. I expect
my kernel may be getting "lucky" with the layout somehow.

I recently added a --randomize-section-padding flag to lld which is
meant for performance benchmarking [1], but I realized that it should
make it easier to reproduce the issue by trying different seeds until
you get a "unlucky" layout. I tried a patch like this:

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 51367c2bfc21e..77a4027b75282 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -102,6 +102,7 @@ vmlinux_link()
                ldflags=3D"${ldflags} ${wl}-Map=3Dvmlinux.map"
        fi

+       ldflags=3D"${ldflags} ${wl}--randomize-section-padding=3D1"
        ${ld} ${ldflags} -o ${output}                                   \
                ${wl}--whole-archive ${objs} ${wl}--no-whole-archive    \
                ${wl}--start-group ${libs} ${wl}--end-group             \

but the link fails:

ld.lld: error: ./arch/x86/kernel/vmlinux.lds:51: unable to move
location counter (0xffffffff8281cb3d) backward to 0xffffffff82804000
for section '.data'
ld.lld: error: SRSO function pair won't alias

I imagine there is some incompatibility with linker scripts, or at
least with Linux's linker script, but I haven't had a chance to look
at it yet.

Peter

[1] https://github.com/llvm/llvm-project/pull/117653

