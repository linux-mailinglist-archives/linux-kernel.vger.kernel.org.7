Return-Path: <linux-kernel+bounces-851033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA4BD55C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEE7C502ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB332D3724;
	Mon, 13 Oct 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZSQu07P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A12367D9;
	Mon, 13 Oct 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373616; cv=none; b=EztdA2jvpZjbZ9y0xoIoO4fy+2Ec/dTEblHenUO8byh278hXQKB4NILZN1rnu4HvKT0/CL1Yi9lbk9+yTRx0UbNYcu7+XfBB7mLXLOe10X9FDh7i983+Z9raP2kFjCU+i2PUwvetweeSNUfhQp2WziEsCoed3cedlhnQ72SIdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373616; c=relaxed/simple;
	bh=hs5Dm6BPAEGHFTEY/NVYLFoUg8OkvqoPEabZITp2GSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TVPbRPg5bueZ8AgnAHDvomQwRzZlnupjwY/kK7MoWf5J2MA+3s8q+EjgT0kFbPmkjrH1O5Utf67vPQuXQLCS2kbBM+c32pJTS2jpqbPGQrdDqo4oaqIw24X0qmx53/N84Wsb88+Lc4pwjbxvsgPkeYe83dbeq5X5rGpXcEFItdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZSQu07P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D77C4CEE7;
	Mon, 13 Oct 2025 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760373616;
	bh=hs5Dm6BPAEGHFTEY/NVYLFoUg8OkvqoPEabZITp2GSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XZSQu07P4SgkBBZjCn0RGnl0R5rV5/5dNJSGZOUAAsLQYCfUrfnNS+2HXe4K3m8l/
	 KspWTGFqpB6+C8D6h76oWfo9JXkqDf2a34ASBb98qAVwnmZ9Btt2ElduQT2WpPTwww
	 kmiBHNzSKdUzad5WTPGTAhE4J8bGtJo1Iu5u+uJCq98zd4m34G+qLiBvGhsU7F+Csv
	 HWvSoO80bQv/kATFT6eHFXH67KQXHE+9CuWPspkyUx+j4KM1t6j5TFunRpv9sPvTbQ
	 9iKwbP2ZPelsuuF5j7/TZi2mOfSFBbkWV2a2oDkxTMJMYb1C8FClYtFZyuYVCnuH7T
	 j0FoiJN2A1P0A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,  Changyuan Lyu
 <changyuanl@google.com>,  rppt@kernel.org,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  anthony.yznaga@oracle.com,  arnd@arndb.de,
  ashish.kalra@amd.com,  benh@kernel.crashing.org,  bp@alien8.de,
  catalin.marinas@arm.com,  corbet@lwn.net,  dave.hansen@linux.intel.com,
  devicetree@vger.kernel.org,  dwmw2@infradead.org,  ebiederm@xmission.com,
  graf@amazon.com,  hpa@zytor.com,  jgowans@amazon.com,
  kexec@lists.infradead.org,  krzk@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  luto@kernel.org,  mark.rutland@arm.com,
  mingo@redhat.com,  pasha.tatashin@soleen.com,  pbonzini@redhat.com,
  peterz@infradead.org,  robh@kernel.org,  rostedt@goodmis.org,
  saravanak@google.com,  skinsburskii@linux.microsoft.com,
  tglx@linutronix.de,  thomas.lendacky@amd.com,  will@kernel.org,
  x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
In-Reply-To: <mafs0wm4yluej.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	13 Oct 2025 16:59:32 +0200")
References: <20250509074635.3187114-1-changyuanl@google.com>
	<20250509074635.3187114-2-changyuanl@google.com>
	<ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
	<mafs0wm4yluej.fsf@kernel.org>
Date: Mon, 13 Oct 2025 18:40:09 +0200
Message-ID: <mafs0h5w2lpqu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 13 2025, Pratyush Yadav wrote:

> On Fri, Oct 10 2025, Breno Leitao wrote:
>
>> Hello Chanyuan, Mike,
>>
>> On Fri, May 09, 2025 at 12:46:19AM -0700, Changyuan Lyu wrote:
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -492,7 +492,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
>>>  	 * needn't do it
>>>  	 */
>>>  	if (!use_slab)
>>> -		BUG_ON(memblock_reserve(addr, new_alloc_size));
>>> +		BUG_ON(memblock_reserve_kern(addr, new_alloc_size));
>>>  
>>>  	/* Update slab flag */
>>>  	*in_slab = use_slab;
>>> @@ -642,7 +642,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>>>  #ifdef CONFIG_NUMA
>>>  			WARN_ON(nid != memblock_get_region_node(rgn));
>>>  #endif
>>> -			WARN_ON(flags != rgn->flags);
>>> +			WARN_ON(flags != MEMBLOCK_NONE && flags != rgn->flags);
>>
>> I am hitting some sporadic warnings at early boot on a production kernel
>> (6.16). Unfortunately this issue is not easily reproduce for me to test on
>> upstream.
>>
>> 	09:14:44  BIOS-provided physical RAM map:
>> 	09:14:44  BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
>> 	09:14:44  BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x0000000000100000-0x0000000064cb7fff] usable
>> 	09:14:44  BIOS-e820: [mem 0x0000000064cb8000-0x0000000064dc3fff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x0000000064dc4000-0x0000000065b13fff] usable
>> 	09:14:44  BIOS-e820: [mem 0x0000000065b14000-0x0000000065b61fff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x0000000065b62000-0x0000000065ed0fff] usable
>> 	09:14:44  BIOS-e820: [mem 0x0000000065ed1000-0x0000000065f2bfff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x0000000065f2c000-0x0000000066621fff] usable
>> 	09:14:44  BIOS-e820: [mem 0x0000000066622000-0x0000000066630fff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x0000000066631000-0x0000000068107fff] usable
>> 	09:14:44  BIOS-e820: [mem 0x0000000068108000-0x000000006819dfff] ACPI data
>> 	09:14:44  BIOS-e820: [mem 0x000000006819e000-0x000000006a48cfff] usable
>> 	09:14:44  BIOS-e820: [mem 0x000000006a48d000-0x000000006c58cfff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x000000006c58d000-0x000000006c5dcfff] ACPI data
>> 	09:14:44  BIOS-e820: [mem 0x000000006c5dd000-0x000000006cfdcfff] ACPI NVS
>> 	09:14:44  BIOS-e820: [mem 0x000000006cfdd000-0x000000006e9fcfff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x000000006e9fd000-0x000000006fffffff] usable
>> 	09:14:44  BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
>> 	09:14:44  BIOS-e820: [mem 0x0000000100000000-0x000000107fff655f] usable
>> 	09:14:44  BIOS-e820: [mem 0x000000107fff6560-0x000000107fff656f] type 128
>> 	09:14:44  BIOS-e820: [mem 0x000000107fff6570-0x000000107fffffff] usable
>> 	09:14:44  random: crng init done
>> 	09:14:44  ------------[ cut here ]------------
>> 	09:14:44 WARNING: CPU: 0 PID: 0 at mm/memblock.c:668 memblock_add_range (mm/memblock.c:668)
>> 	09:14:44  Modules linked in:
>> 	09:14:44  Tainted: [S]=CPU_OUT_OF_SPEC
>> 	09:14:44 RIP: 0010:memblock_add_range (mm/memblock.c:668)
>> 	09:14:44 Code: 28 80 3c 01 00 0f 84 04 fd ff ff 4c 89 ef e8 6c 77 09 00 e9 f7 fc ff ff 0f 0b 83 7c 24 1c 00 0f 85 9c fd ff ff e9 c5 fd ff ff <0f> 0b e9 be fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 6b fd
>> 	All code
>> 	========
>> 	0:    28 80 3c 01 00 0f        sub    %al,0xf00013c(%rax)
>> 	6:    84 04 fd ff ff 4c 89     test   %al,-0x76b30001(,%rdi,8)
>> 	d:    ef                       out    %eax,(%dx)
>> 	e:    e8 6c 77 09 00           call   0x9777f
>> 	13:    e9 f7 fc ff ff           jmp    0xfffffffffffffd0f
>> 	18:    0f 0b                    ud2
>> 	1a:    83 7c 24 1c 00           cmpl   $0x0,0x1c(%rsp)
>> 	1f:    0f 85 9c fd ff ff        jne    0xfffffffffffffdc1
>> 	25:    e9 c5 fd ff ff           jmp    0xfffffffffffffdef
>> 	2a:*    0f 0b                    ud2            <-- trapping instruction
>> 	2c:    e9 be fd ff ff           jmp    0xfffffffffffffdef
>> 	31:    44 89 f1                 mov    %r14d,%ecx
>> 	34:    80 e1 07                 and    $0x7,%cl
>> 	37:    80 c1 03                 add    $0x3,%cl
>> 	3a:    38 c1                    cmp    %al,%cl
>> 	3c:    0f                       .byte 0xf
>> 	3d:    8c 6b fd                 mov    %gs,-0x3(%rbx)
>>
>> 	Code starting with the faulting instruction
>> 	===========================================
>> 	0:    0f 0b                    ud2
>> 	2:    e9 be fd ff ff           jmp    0xfffffffffffffdc5
>> 	7:    44 89 f1                 mov    %r14d,%ecx
>> 	a:    80 e1 07                 and    $0x7,%cl
>> 	d:    80 c1 03                 add    $0x3,%cl
>> 	10:    38 c1                    cmp    %al,%cl
>> 	12:    0f                       .byte 0xf
>> 	13:    8c 6b fd                 mov    %gs,-0x3(%rbx)
>> 	09:14:44  RSP: 0000:ffffffff85e07d48 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
>> 	09:14:44  RAX: 0000000000000020 RBX: 0000000000001c00 RCX: dffffc0000000000
>> 	09:14:44  RDX: 000000000009f000 RSI: 000000000009d000 RDI: ffffffff8685ebf8
>> 	09:14:44  RBP: 0000000000000002 R08: 0000000000000020 R09: 0000000000000000
>> 	09:14:44  R10: ffffffffff200570 R11: fffffbffffe400b2 R12: 000000000009d000
>> 	09:14:44  R13: 0000000000100000 R14: ffffffff8edf5ce4 R15: ffffffff8edf5ce0
>> 	09:14:44  FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
>> 	09:14:44  CR2: ffff888059e2dff8 CR3: 000000005bc1d000 CR4: 00000000000000b0
>> 	09:14:44  Call Trace:
>> 	09:14:44   <TASK>
>> 	09:14:44 ? __memblock_reserve (mm/memblock.c:936)
>> 	09:14:44 ? add_early_ima_buffer (arch/x86/kernel/setup.c:413)
>> 	09:14:44 ? parse_setup_data (arch/x86/kernel/setup.c:500)
>> 	09:14:44 ? setup_arch (arch/x86/kernel/setup.c:245 arch/x86/kernel/setup.c:958)
>> 	09:14:44 ? start_kernel (init/main.c:922)
>> 	09:14:44 ? x86_64_start_reservations (arch/x86/kernel/ebda.c:57)
>> 	09:14:44 ? x86_64_start_kernel (arch/x86/kernel/head64.c:231)
>> 	09:14:44 ? common_startup_64 (arch/x86/kernel/head_64.S:419)
>> 	09:14:44   </TASK>
>> 	....
>> 	Memory: 49640988K/66772816K available (54946K kernel code, 19058K rwdata, 22636K rodata, 2940K init, 120968K bss, 10650188K reserved, 6291456K cma-reserved)
>>
>> So, there is a memory override, and I am curious about it. Do you think it
>
> Yeah, it seems IMA is reserving a region that overlaps a region reserved
> by something else that doesn't use memblock_reserve_kern().
>
>> would be useful to expand this warning to dump more information about the
>> issue? (only compiled tested)
>>
>> 	if (flags != MEMBLOCK_NONE && flags != rgn->flags) {
>> 		pr_warn("memblock: Flag mismatch at region [%pa-%pa]\n",
>> 			&rgn->base, &rend);
>> 		pr_warn("  Existing region flags: %#x\n", rgn->flags);
>> 		pr_warn("  New range flags: %#x\n", flags);
>> 		pr_warn("  New range: [%pa-%pa]\n", &base, &end);
>> 		WARN_ON_ONCE(1);
>> 	}
>
> I suppose this would be useful. I think enabling memblock debug prints
> would also be helpful (using the "memblock=debug" commandline parameter)
> if it doesn't impact your production environment too much.

Actually, I think "memblock=debug" is going to be the more useful thing
since it would also show what function allocated the overlapping range
and the flags it was allocated with.

On my qemu VM with KVM, this results in around 70 prints from memblock.
So it adds a bit of extra prints but nothing that should be too
disrupting I think. Plus, only at boot so the worst thing you get is
slightly slower boot times.

-- 
Regards,
Pratyush Yadav

