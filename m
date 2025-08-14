Return-Path: <linux-kernel+bounces-769524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE99B26FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDB6AA3C52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EBE243946;
	Thu, 14 Aug 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryG4sJdb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D28B1D7984
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755200435; cv=none; b=M3+CtY9A+FPpkoMpvDY1RrmCVjifFVQpg+e1lJUl013KMrxPA6GXleFKWHrxjTl+BiPl5Q+fmN1qbtiPB3gZ5fVuFYsZejE2o5w/AFuYBjE3t5Mw/cN2cYQZbD5k5Rp6ipU5Zn9VyS4Amc7GVn4nk1nYM89wS8Ir95E/uMbHT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755200435; c=relaxed/simple;
	bh=9IVVNg0D6cN7qoCyhNlCAb/IqIr6ARbRYyRGiFTdT90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tt4eS5BLfgMMPAOjbBEPGF4efULjs93YO0ZRiAljD8uJQk0TzuF/TG+OgjFPmRORkQOwjt5Tlr+UTHqDjoBJUI86QiwkHW0pn1GBHfy9kcTz+WYx09b4SCji38at/NG8i/J0kpgitrwRVdAAk6e81yItZ193bGEFZ+LZBc00xCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryG4sJdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35554C4CEED;
	Thu, 14 Aug 2025 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755200434;
	bh=9IVVNg0D6cN7qoCyhNlCAb/IqIr6ARbRYyRGiFTdT90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryG4sJdbKpbWY3kY9ou4AeuX13BHq8yynRG7H4ZuO/Js4I9gfUCcf5s6e/C4clI9S
	 t10FRBLePFrKKRobXtFnShzyAQeUTW/7fruZDDVA3Ma3azg1SqYESHmCZir2anxq5v
	 3ooccyu8Yy7exlElp20bBsWo09RSQYUuSafJnChvB/2RfgZ3nXF3OVbZJRzEEAgX3N
	 Hm3hVqibNTZwoqt51HuYSSZsnmpMTTzA5V9qrC03Ape0r6oQ/+frnj4rMmRYqa+0+2
	 NkzTQbBeCa/JLgVkczPG5mTbZE5AV/yv+RNGlsKLYd2vBut4msZUAt3lRML3w3ydrl
	 71Y8JsSPfTijg==
Date: Thu, 14 Aug 2025 12:40:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, kees@kernel.org,
	alyssa.milburn@intel.com, scott.d.constable@intel.com,
	joao@overdrivepizza.com, andrew.cooper3@citrix.com,
	samitolvanen@google.com, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250814194029.GA2179272@ax162>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>

On Thu, Aug 14, 2025 at 01:17:32PM +0200, Peter Zijlstra wrote:
> Hi!
> 
> A while ago FineIBT started using the instruction 0xEA to generate #UD.
> All existing parts will generate #UD in 64bit mode on that instruction.
> 
> However; Intel/AMD have not blessed using this instruction, it is on
> their 'reserved' list for future use.
> 
> Peter Anvin worked the committees and got use of 0xD6 blessed, and it
> will be called UDB (per the next SDM or so).
> 
> Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
> had to switch the hash register to EAX in order to free up some bytes.
> 
> Per the x86_64 ABI, EAX is used to pass the number of vector registers
> for varargs -- something that should not happen in the kernel. More so,
> we build with -mskip-rax-setup, which should leave EAX completely unused
> in the calling convention.
> 
> The code boots and passes the LKDTM CFI_FORWARD_PROTO test for various
> combinations (non exhaustive so far).

Must be perfect :P on my hardware:

cfi=auto (i.e. cfi=fineibt,paranoid):

```
[  +0.000861] SMP alternatives: Using paranoid FineIBT CFI
...
[Aug14 11:33] lkdtm: Performing direct entry CFI_FORWARD_PROTO
[  +0.000005] lkdtm: Calling matched prototype ...
[  +0.000000] lkdtm: Calling mismatched prototype ...
[  +0.000014] CFI failure at lkdtm_indirect_call+0x1c/0x30 [lkdtm] (target: lkdtm_increment_int+0x0/0x30 [lkdtm]; expected type: 0x4d3fe584)
[  +0.000027] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  +0.000004] CPU: 0 UID: 0 PID: 3232 Comm: cat Not tainted 6.17.0-rc1-debug-next-20250814-02528-g3aebcf0edb14 #1 PREEMPT(full)  724b1db7f580ddb34e14b43820ff16d9fd75d36c
[  +0.000004] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05/12/2024
[  +0.000002] RIP: 0010:lkdtm_indirect_call+0x1c/0x30 [lkdtm]
[  +0.000008] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 49 89 fb 48 c7 c7 30 49 fd c1 b8 84 e5 3f 4d 41 3b 43 f5 2e 4d 8d 5b <f0> 75 fd 41 ff e3 90 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f
[  +0.000002] RSP: 0018:ffffceb847387d38 EFLAGS: 00010216
[  +0.000002] RAX: 000000004d3fe584 RBX: 0000000000000001 RCX: 332c9ba94c7b7c00
[  +0.000002] RDX: 0000000000000002 RSI: 00000000ffffefff RDI: ffffffffc1fd4930
[  +0.000002] RBP: 0000000000000002 R08: 0000000000000fff R09: ffffffffb025b2a0
[  +0.000001] R10: 0000000000002ffd R11: ffffffffc218e0d0 R12: 0000000000000000
[  +0.000002] R13: 0000000000000006 R14: ffff8bc3c3d3b000 R15: ffffffffc1fd47c0
[  +0.000001] FS:  00007f025f833740(0000) GS:ffff8bc6febb8000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f025f5bf000 CR3: 000000017036a002 CR4: 0000000000f72ef0
[  +0.000002] PKRU: 55555554
[  +0.000001] Call Trace:
[  +0.000002]  <TASK>
[  +0.000002]  lkdtm_CFI_FORWARD_PROTO+0x39/0x60 [lkdtm 57ec71482c5cb110c2f23373ae7338671243d293]
[  +0.000008]  lkdtm_do_action+0x26/0x40 [lkdtm 57ec71482c5cb110c2f23373ae7338671243d293]
[  +0.000009]  direct_entry+0x147/0x160 [lkdtm 57ec71482c5cb110c2f23373ae7338671243d293]
[  +0.000009]  full_proxy_write+0x9e/0x140
[  +0.000005]  vfs_write+0x11b/0x3f0
[  +0.000004]  ksys_write+0x79/0x100
[  +0.000002]  do_syscall_64+0x85/0x920
[  +0.000003]  ? do_user_addr_fault+0x271/0x680
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000002] RIP: 0033:0x7f025f6931ce
[  +0.000036] Code: 4d 89 d8 e8 64 be 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  +0.000001] RSP: 002b:00007ffd001e8930 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007f025f6931ce
[  +0.000001] RDX: 0000000000000012 RSI: 00007f025f5bf000 RDI: 0000000000000001
[  +0.000001] RBP: 00007ffd001e8940 R08: 0000000000000000 R09: 0000000000000000
[  +0.000002] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f025f5bf000
[  +0.000001] R13: 0000000000000012 R14: 0000000000000000 R15: 0000000000000000
[  +0.000002]  </TASK>
[  +0.000001] Modules linked in: lkdtm ...
[  +0.000047]  hid_logitech_dj hid_razer nvme nvme_core nvme_keyring spi_intel_pci nvme_auth spi_intel
[  +0.000006] ---[ end trace 0000000000000000 ]---
[  +0.000002] RIP: 0010:lkdtm_indirect_call+0x1c/0x30 [lkdtm]
[  +0.000008] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 49 89 fb 48 c7 c7 30 49 fd c1 b8 84 e5 3f 4d 41 3b 43 f5 2e 4d 8d 5b <f0> 75 fd 41 ff e3 90 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f
[  +0.000002] RSP: 0018:ffffceb847387d38 EFLAGS: 00010216
[  +0.000002] RAX: 000000004d3fe584 RBX: 0000000000000001 RCX: 332c9ba94c7b7c00
[  +0.000001] RDX: 0000000000000002 RSI: 00000000ffffefff RDI: ffffffffc1fd4930
[  +0.000001] RBP: 0000000000000002 R08: 0000000000000fff R09: ffffffffb025b2a0
[  +0.000001] R10: 0000000000002ffd R11: ffffffffc218e0d0 R12: 0000000000000000
[  +0.000001] R13: 0000000000000006 R14: ffff8bc3c3d3b000 R15: ffffffffc1fd47c0
[  +0.000001] FS:  00007f025f833740(0000) GS:ffff8bc6febb8000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f025f5bf000 CR3: 000000017036a002 CR4: 0000000000f72ef0
[  +0.000001] PKRU: 55555554
```

cfi=fineibt,paranoid,bhi

```
[Aug14 12:27] Linux version 6.17.0-rc1-debug-next-20250814-02528-g3aebcf0edb14 (nathan@ax162) (ClangBuiltLinux clang version 22.0.0git (https://github.com/llvm/llvm-project.git 9f96e3f80f5d25e50ca8423d4eb9063989b85f0b), ClangBuiltLinux LLD 22.0.0 (https://github.com/llvm/llvm-project.git 9f96e3f80f5d25e50ca8423d4eb9063989b85f0b)) #1 SMP PREEMPT_DYNAMIC Thu Aug 14 11:11:44 MST 2025
...
[  +0.000860] SMP alternatives: Using paranoid FineIBT+BHI CFI
...
[  +1.406475] lkdtm: Performing direct entry CFI_FORWARD_PROTO
[  +0.000005] lkdtm: Calling matched prototype ...
[  +0.000001] lkdtm: Calling mismatched prototype ...
[  +0.000012] CFI failure at lkdtm_indirect_call+0x1c/0x30 [lkdtm] (target: lkdtm_increment_int+0x0/0x30 [lkdtm]; expected type: 0x0b71a5dc)
[  +0.000027] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  +0.000004] CPU: 3 UID: 0 PID: 2100 Comm: cat Tainted: G        W           6.17.0-rc1-debug-next-20250814-02528-g3aebcf0edb14 #1 PREEMPT(full)  724b1db7f580ddb34e14b43820ff16d9fd75d36c
[  +0.000004] Tainted: [W]=WARN
[  +0.000001] Hardware name: AZW MINI S/MINI S, BIOS ADLNV106 05/12/2024
[  +0.000002] RIP: 0010:lkdtm_indirect_call+0x1c/0x30 [lkdtm]
[  +0.000008] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 49 89 fb 48 c7 c7 30 89 46 c2 b8 dc a5 71 0b 41 3b 43 f5 2e 4d 8d 5b <f0> 75 fd 41 ff e3 90 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f
[  +0.000002] RSP: 0018:ffffcf77c4507c68 EFLAGS: 00010283
[  +0.000002] RAX: 000000000b71a5dc RBX: 0000000000000001 RCX: f242256082c3a100
[  +0.000002] RDX: 0000000000000002 RSI: 00000000ffffefff RDI: ffffffffc2468930
[  +0.000002] RBP: 0000000000000002 R08: 0000000000000fff R09: ffffffff9a85b2a0
[  +0.000001] R10: 0000000000002ffd R11: ffffffffc19e40d0 R12: 0000000000000000
[  +0.000001] R13: 0000000000000006 R14: ffff8ed41e1e6000 R15: ffffffffc24687c0
[  +0.000002] FS:  00007fda4f785740(0000) GS:ffff8ed7d4738000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007fda4f744000 CR3: 000000016856f005 CR4: 0000000000f72ef0
[  +0.000002] PKRU: 55555554
[  +0.000001] Call Trace:
[  +0.000003]  <TASK>
[  +0.000001]  lkdtm_CFI_FORWARD_PROTO+0x39/0x60 [lkdtm 57ec71482c5cb110c2f23373ae7338671243d293]
[  +0.000009]  lkdtm_do_action+0x26/0x40 [lkdtm 57ec71482c5cb110c2f23373ae7338671243d293]
[  +0.000008]  direct_entry+0x147/0x160 [lkdtm 57ec71482c5cb110c2f23373ae7338671243d293]
[  +0.000009]  full_proxy_write+0x9e/0x140
[  +0.000004]  vfs_write+0x11b/0x3f0
[  +0.000004]  ? __lruvec_stat_mod_folio+0x7c/0xc0
[  +0.000002]  ? set_ptes+0x12/0xa0
[  +0.000008]  ? do_pte_missing+0xb8c/0xf00
[  +0.000002]  ksys_write+0x79/0x100
[  +0.000003]  do_syscall_64+0x85/0x920
[  +0.000004]  ? do_user_addr_fault+0x271/0x680
[  +0.000002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000002] RIP: 0033:0x7fda4f4931ce
[  +0.000027] Code: 4d 89 d8 e8 64 be 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  +0.000001] RSP: 002b:00007fffe1b7c780 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  +0.000002] RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00007fda4f4931ce
[  +0.000002] RDX: 0000000000000012 RSI: 00007fda4f744000 RDI: 0000000000000001
[  +0.000001] RBP: 00007fffe1b7c790 R08: 0000000000000000 R09: 0000000000000000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fda4f744000
[  +0.000001] R13: 0000000000000012 R14: 0000000000000000 R15: 0000000000000000
[  +0.000002]  </TASK>
[  +0.000000] Modules linked in: lkdtm ...
[  +0.000044]  hid_logitech_dj hid_razer nvme nvme_core nvme_keyring spi_intel_pci nvme_auth spi_intel
[  +0.000016] ---[ end trace 0000000000000000 ]---
[  +0.000002] RIP: 0010:lkdtm_indirect_call+0x1c/0x30 [lkdtm]
[  +0.000009] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 49 89 fb 48 c7 c7 30 89 46 c2 b8 dc a5 71 0b 41 3b 43 f5 2e 4d 8d 5b <f0> 75 fd 41 ff e3 90 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f
[  +0.000001] RSP: 0018:ffffcf77c4507c68 EFLAGS: 00010283
[  +0.000002] RAX: 000000000b71a5dc RBX: 0000000000000001 RCX: f242256082c3a100
[  +0.000001] RDX: 0000000000000002 RSI: 00000000ffffefff RDI: ffffffffc2468930
[  +0.000001] RBP: 0000000000000002 R08: 0000000000000fff R09: ffffffff9a85b2a0
[  +0.000001] R10: 0000000000002ffd R11: ffffffffc19e40d0 R12: 0000000000000000
[  +0.000001] R13: 0000000000000006 R14: ffff8ed41e1e6000 R15: ffffffffc24687c0
[  +0.000001] FS:  00007fda4f785740(0000) GS:ffff8ed7d4738000(0000) knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007fda4f744000 CR3: 000000016856f005 CR4: 0000000000f72ef0
[  +0.000001] PKRU: 55555554
```

I also tested

    cfi=fineibt,bhi
    cfi=fineibt,bhi,warn
    cfi=fineibt
    cfi=kcfi

which showed no additional errors.

Cheers,
Nathan

