Return-Path: <linux-kernel+bounces-624701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114D0AA0689
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428063BCAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D7929E04A;
	Tue, 29 Apr 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPTTb8ox"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE729DB7E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917294; cv=none; b=eYMDsan5PjddiDgrAkXJLuCl3bzjlN2WwZSaBZkaFGn179ig8AdPO5FFmdtexYwGUGtWaiXW5aniheNox4Of7BqRcIdsEWRy1NQOeRYvpp5CaQXRhJNpycZiMfoZl9chxULN88Py/Jk9uNUXjkex2TpdJremJ08ur6pRmcVLy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917294; c=relaxed/simple;
	bh=hxWWyX9jNeJiM+Gnm/7eb97fWWf6EOvid3/flmqvp/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2TiWjj3dyplCz7rUKSxHEfhOn/YKUCHQZv5lTDa/kMUPWqd+DDXcqW2cEKpwQI7xnASfI6HvsEDT+0HFd3dlFa4uxY6MZUagHrUk+9h8ohIXf7c5AO5V462GJfOUoDHcwtT17W+1E6pCR+KnbJspS3bOSytUp/2v/CKYlIRpQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPTTb8ox; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745917292; x=1777453292;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=hxWWyX9jNeJiM+Gnm/7eb97fWWf6EOvid3/flmqvp/Y=;
  b=kPTTb8oxPLwDamAT4f5XraP2B0dLgoHV3UT6roz9+fVFbtKl33XcJKR6
   81zoTyyZiW4g9mf4xVXj/6QgjXOddkUDndjH460QfZu4yrQ51US+CG2as
   r0fqimePiVClWBz58qaw114GYVsHsYVJjLOgYnpPSZWPJHayzDxUbwJsw
   /0zKiK1nQUrmrCEzwYmezxcM2vq45fikL++8SLoi1rxkRAc1RZekrqm7G
   m3TM8PJSP94In1Ga/863C65MdaN+psJP/uQMdLWTc3exqLRXV07zW3cr+
   EwiGIYDbV5HFHIMwVm6D+CaH7Ue/14vDBwf/Y+FO3AsRLoKLkb3a1J4YK
   w==;
X-CSE-ConnectionGUID: hHkS9h1YS6mOoElKudLz+A==
X-CSE-MsgGUID: iM2LJzNXRhyQeQpUcmrFOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58185630"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="58185630"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 02:01:30 -0700
X-CSE-ConnectionGUID: NeMi6CgbTiCEKU46WBdhRA==
X-CSE-MsgGUID: enJGixcvSq+AsS9tMWdm2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="133657857"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.9])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 02:01:26 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "luto@kernel.org" <luto@kernel.org>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
 <jani.saarinen@intel.com>, "De Marchi, Lucas" <lucas.demarchi@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>
Subject: [REGRESSION] x86/efi: Make efi_enter/leave_mm() use the
 use_/unuse_temporary_mm() machinery (linux-next)
In-Reply-To: <SJ1PR11MB61293655E9386DC0FBD263F4B9852@SJ1PR11MB6129.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <SJ1PR11MB6129E62E3B372932C6B7477FB9BD2@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB61293655E9386DC0FBD263F4B9852@SJ1PR11MB6129.namprd11.prod.outlook.com>
Date: Tue, 29 Apr 2025 12:01:22 +0300
Message-ID: <87selrwdct.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Apr 2025, "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.=
com> wrote:
> +Andy, Ingo
>
> Friendly reminder.
> Issue is still seen on latest linux-next runs.
>
> https://intel-gfx-ci.01.org/tree/linux-next/next-20250424/bat-rpls-4/boot=
0.txt
>
> Regards
>
> Chaitanya

Andy, Ingo -

Commit e7021e2fe0b4 ("x86/efi: Make efi_enter/leave_mm() use the
use_/unuse_temporary_mm() machinery") on linux-next regresses as
reported by Chaitanya

Please look into it.


Thanks,
Jani.



>
>> -----Original Message-----
>> From: Borah, Chaitanya Kumar
>> Sent: Wednesday, April 16, 2025 11:39 PM
>> To: luto@kernel.org
>> Cc: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org; Kur=
mi,
>> Suresh Kumar <Suresh.Kumar.Kurmi@intel.com>; Saarinen, Jani
>> <jani.saarinen@intel.com>; De Marchi, Lucas <lucas.demarchi@intel.com>;
>> linux-kernel@vger.kernel.org
>> Subject: Regression on linux-next (next-20250414)
>>=20
>> Hello Andy,
>>=20
>> Hope you are doing well. I am Chaitanya from the linux graphics team in =
Intel.
>>=20
>> This mail is regarding a regression we are seeing in our CI runs[1] on l=
inux-
>> next repository.
>>=20
>> Since the version next-20250414 [2], we are seeing the following regress=
ion
>>=20
>> ````````````````````````````````````````````````````````````````````````=
`````````
>> <4>[    0.203154] WARNING: CPU: 0 PID: 0 at arch/x86/mm/tlb.c:795
>> switch_mm_irqs_off+0x389/0x410
>> <5>[    0.203173] Modules linked in:
>> <5>[    0.203184] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.=
0-
>> rc2-next-20250414-next-20250414-gb425262c07a6+ #1 PREEMPT(voluntary)
>> <5>[    0.203207] Hardware name: Intel Corporation CoffeeLake Client
>> Platform/CoffeeLake S UDIMM RVP, BIOS
>> CNLSFWR1.R00.X220.B00.2103302221 03/30/2021
>> <5>[    0.203229] RIP: 0010:switch_mm_irqs_off+0x389/0x410
>> <5>[    0.203241] Code: e9 4d fd ff ff be 00 01 00 00 31 ff e8 60 ba f9 =
ff e9 29 fe
>> ff ff 48 c7 c7 60 25 a1 82 e8 bf 73 a2 00 84 c0 0f 85 d4 fc ff ff <0f> 0=
b e9 cd fc ff
>> ff bf 0b 01 00 00 be 01 00 00 00 31 d2 e8 1f e9
>> <5>[    0.203271] RSP: 0000:ffffffff83403d90 EFLAGS: 00010246
>> <5>[    0.203283] RAX: 0000000000000000 RBX: ffffffff8389f080 RCX:
>> 0000000100a8c000
>> <5>[    0.203296] RDX: ffffffff83414200 RSI: 0000000000000000 RDI:
>> 0000000000000000
>> <5>[    0.203309] RBP: ffffffff83403dc8 R08: 000000008d3ea018 R09:
>> 0000000000000000
>> <5>[    0.203322] R10: 0000000000000000 R11: 0000000003f55067 R12:
>> 0000000000000000
>> <5>[    0.203335] R13: ffffffff836d0b40 R14: ffffffff83414200 R15:
>> 0000000000000000
>> <5>[    0.203348] FS:  0000000000000000(0000) GS:ffff8884d94f6000(0000)
>> knlGS:0000000000000000
>> <5>[    0.203363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> <5>[    0.203374] CR2: ffff88846dfff000 CR3: 000000000344a001 CR4:
>> 00000000003706f0
>> <5>[    0.203387] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> <5>[    0.203400] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> <5>[    0.203412] Call Trace:
>> <5>[    0.203418]  <TASK>
>> <5>[    0.203428]  use_temporary_mm+0x5b/0x130
>> <5>[    0.203439]  efi_set_virtual_address_map+0x4c/0x250
>> <5>[    0.203452]  ? efi_sync_low_kernel_mappings+0x10a/0x220
>> <5>[    0.203467]  efi_enter_virtual_mode+0x205/0x5b0
>> <5>[    0.203482]  start_kernel+0xa38/0xc60
>> <5>[    0.203492]  ? sme_unmap_bootdata+0x14/0x80
>> <5>[    0.203504]  x86_64_start_reservations+0x18/0x30
>> <5>[    0.203516]  x86_64_start_kernel+0xbf/0x110
>> <5>[    0.203526]  ? soft_restart_cpu+0x14/0x14
>> <5>[    0.203536]  common_startup_64+0x13e/0x141
>> <5>[    0.203555]  </TASK>
>> ````````````````````````````````````````````````````````````````````````=
`````````
>> Details log can be found in [3].
>>=20
>> After bisecting the tree, the following patch [4] seems to be the first =
"bad"
>> commit
>>=20
>> ````````````````````````````````````````````````````````````````````````=
`````````````````````````````````
>> commit e7021e2fe0b4335523d3f6e2221000bdfc633b62
>> Author: Andy Lutomirski mailto:luto@kernel.org
>> Date:=C2=A0=C2=A0 Wed Apr 2 11:45:39 2025 +0200
>>=20
>> =C2=A0=C2=A0=C2=A0 x86/efi: Make efi_enter/leave_mm() use the use_/unuse=
_temporary_mm()
>> machinery
>>=20
>> ````````````````````````````````````````````````````````````````````````=
`````````````````````````````````
>>=20
>> We also verified that if we revert the patch the issue is not seen.
>>=20
>> Could you please check why the patch causes this regression and provide =
a fix
>> if necessary?
>>=20
>> Thank you.
>>=20
>> Regards
>>=20
>> Chaitanya
>>=20
>> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
>> next.git/commit/?h=3Dnext-20250414
>> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20250414/bat-dg2-
>> 8/boot0.txt
>> [4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
>> next.git/commit/?h=3Dnext-
>> 20250414&id=3De7021e2fe0b4335523d3f6e2221000bdfc633b62
>

--=20
Jani Nikula, Intel

