Return-Path: <linux-kernel+bounces-858170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C5BE931D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 909FF4F857D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43558339716;
	Fri, 17 Oct 2025 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F76yofh+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265EE33970F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711180; cv=none; b=qukmNBKf/rJfPuGxSJVRqqs7VDqlEksxYGvJU5HMhUZ+KPfdfkpq0O6tIcdeMCyEQb9whVWgSgq9HSnqPSsN1CEfUs7JACgM9tX57AZUlpjEu/+slxdCDQ3nm2HBbW/8PFglsssS8HAQWoufGZ8UDHJBh58+0cmiubxcAukiZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711180; c=relaxed/simple;
	bh=GEi6gBQmI47L7JB2L547+kIiTNO1mJCQfz3AZmP/Oco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEnQw5OqvhNg7attVoxuK07PGaFB2bvp0RTUviVuizTTConMq9M0xrYdoO/0g00bfUDuJZOg5YPgUyMucuYVAMrUQh9llilR2MyDjh74Rpkg3sAYG7NKk+P5Zu5gl2fdaTjzY0WZa2wtNJGLjEeNjObjLGc0kkaiDiNeQYc0b0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F76yofh+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760711179; x=1792247179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GEi6gBQmI47L7JB2L547+kIiTNO1mJCQfz3AZmP/Oco=;
  b=F76yofh+a7bFtTZF0gXEv4Up0cscj6+hn/4HkBF0UmqgM9CLJtkEun5Z
   8rLIh3wV+osxB2Llj4wXLalj1uqur6v94d+ORNR21gSrEFjqE00GxecJ9
   wj3oQSTLPzSNGs6syy/r8jgsLZGy8/ggoiXsPk8Pb12xCdJ9q/SCtX0Ve
   AghoXftE/hmsZVUmyLy1dNgIF1QgrMVp31iVg95sRCaXZQjSpAqoed4BP
   R93KGtWh2DofXeoXg40H/RoaT10Ey/1YixEwdCOQTT9LMucPoC43q5764
   2XfXP90l3q/kQDtQRVysj7xOq4InOuKSKIIRoUafxx8Nl4bfysHeEPPiR
   g==;
X-CSE-ConnectionGUID: LO7vfoajTySAO5NnmvLsNw==
X-CSE-MsgGUID: bNYsCV4nRlGMLEIgj1g6xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63012274"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63012274"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 07:26:18 -0700
X-CSE-ConnectionGUID: ofWPS03CQiGEZ6k2lcrNDw==
X-CSE-MsgGUID: PrmO9UHNTNariydWTakaiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="187841778"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.40]) ([10.125.108.40])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 07:26:18 -0700
Message-ID: <a7fa4a93-2d80-4c1d-af91-9dad9626ed9f@intel.com>
Date: Fri, 17 Oct 2025 07:26:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123
 do_clear_cpu_cap+0xdc/0x130 on Intel(R) Atom(TM) CPU N450 system
To: Salvatore Bonaccorso <carnil@debian.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 =?UTF-8?Q?Lauren=C8=9Biu_P=C4=83ncescu?= <lpancescu@gmail.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Sohil Mehta <sohil.mehta@intel.com>, "Chang S. Bae"
 <chang.seok.bae@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 1117002@bugs.debian.org
References: <aPJNPPFKsPKJWlLn@eldamar.lan>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <aPJNPPFKsPKJWlLn@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 07:05, Salvatore Bonaccorso wrote:
> [    0.008282] RAX: 0000000000000000 RBX: ffffcd5fc00bfd18 RCX: 0000000000000000
> [    0.008282] RDX: 0000000000000001 RSI: 0000000000000070 RDI: ffffcd5fc00bfd78
> [    0.008282] RBP: 0000000000000070 R08: 0000000000000000 R09: 706f20676e697274
> [    0.008282] R10: 7473207473616620 R11: 64656c6261736944 R12: ffffffffb8f20ba0
> [    0.008282] R13: ffff8ad332718090 R14: 000000000000061c R15: 0000000000000000
> [    0.008282] FS:  0000000000000000(0000) GS:ffff8ad378ec7000(0000) knlGS:0000000000000000
> [    0.008282] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.008282] CR2: 0000000000000000 CR3: 000000005842c000 CR4: 00000000000006f0
> [    0.008282] Call Trace:
> [    0.008282]  <TASK>
> [    0.008282]  do_clear_cpu_cap+0x106/0x130
> [    0.008282]  early_init_intel.cold+0x4d/0x11a
> [    0.008282]  init_intel+0x2a/0x2c0
> [    0.008282]  identify_cpu+0x18c/0x750
> [    0.008282]  identify_secondary_cpu+0x50/0xa0
> [    0.008282]  start_secondary+0x7c/0x160
> [    0.008282]  common_startup_64+0x13e/0x141
> [    0.008282]  </TASK>
> [    0.008282] ---[ end trace 0000000000000000 ]---
> [    0.354753] smp: Brought up 1 node, 2 CPUs
> [    0.354797] smpboot: Total of 2 processors activated (6666.06 BogoMIPS)
> 
> Any ideas?

That's a fun one.

This looks to be this code:

                        pr_info("Disabled fast string operations\n");
                        setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
 
because we can see the pr_info() and I'm assuming that the 'feature' is
X86_FEATURE_REP_GOOD (0x70) which we can see in RSI/RBP.

But X86_FEATURE_REP_GOOD isn't even a real CPU feature, it's one of the
synthetic ones. The only way I can see this happening is if
MSR_IA32_MISC_ENABLE_FAST_STRING is mismatched between the boot CPU and
a secondary.

Could you boot the system on a known good kernel and run this, please?

	rdmsr -a 0x000001a0

That'll dump out MSR_IA32_MISC_ENABLE on all the CPUs.

When was the last kernel that worked for you? Also, do you have old
microcode? Can you dump the beginning of /proc/cpuinfo, please?

processor	: 21
vendor_id	: GenuineIntel
cpu family	: 6
model		: 170
model name	: Intel(R) Core(TM) Ultra 7 155H
stepping	: 4
microcode	: 0x24

I can see your microcode version in dmesg, but not the cpu
model/family/stepping.



