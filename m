Return-Path: <linux-kernel+bounces-819987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E8B7D362
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457911B2633D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA4276028;
	Wed, 17 Sep 2025 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTF3sjvw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC9264634
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758085925; cv=none; b=lQGEXfAxS8YHIy9jtC/KgC8Nd3Y120jdRwFxsLOxWFa0wyz+zEZEukuB/gBbhlQF1XLQa0lJchvIsWAyZkbgajQwlvStX1aB2Z/tNLojSw+DHQa4LUPrpjKGAR2C17dqRGCzrla/enhsvXKmKh6Srd2xWACh8wS0WNYMSr46Qbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758085925; c=relaxed/simple;
	bh=VoFVRTu+TV7a7FwjyeQE+1U9+S0MN9fubcv/ZxJuLhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeKbcDQ6o9EMJVSuX+K0wrfmWw2vQ+Zdoo0MAkKdgnmk4mFf3n2gtH8kArliRAJG0z5OeYDKRcdKCjhmjLxjspTW9lyms/JJKD6UcKHTAoSmSm+uzK16KTrrI9BU5bG86KWHdoKniiwvfwehBPXpS/ItfYxbY/zHXmtZuEHg3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTF3sjvw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758085924; x=1789621924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VoFVRTu+TV7a7FwjyeQE+1U9+S0MN9fubcv/ZxJuLhI=;
  b=aTF3sjvwAyyyuf3mmT8zK0uXibGTgUdCvuq5A6UqJbASgbg098QAbkA+
   5wBIbw2C3v5cfS02yoE+5R9VwMboj/ndUVzPgNqJPPsfS4HsxYVllkgjh
   bltnh0D3vpgWFjahdvRyS7tNECkT6GvOSeLIo7AcB5tsryu5LBt6wEj++
   fWRJXo3WghbfiWe8IGuLU/LjwgfAHs8K0OV8S5O37aTRwZlV5ZSPapazm
   /9ZPLH8jOH8yOsYZOne5q6AKc3gOaahLsOs8F2VU7JoxOnaN18Swq7FA6
   FZkhsW84/NVeYz1mQtXxIR3SslZA/82IAGeQVL3UsJAt2kKyig017O9Qp
   g==;
X-CSE-ConnectionGUID: hMY3I78ARwagJme6Bb7Eqg==
X-CSE-MsgGUID: 1P5FQiaBSv6f0wZFg/2eAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64015145"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="64015145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 22:12:02 -0700
X-CSE-ConnectionGUID: Qxoa7LHrTAKAFSyxw7zbPg==
X-CSE-MsgGUID: +jBA7/2YR3qKP+6NszyIaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="206098157"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO desk) ([10.124.222.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 22:12:01 -0700
Date: Tue, 16 Sep 2025 22:11:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Qiang Liu <liuq131@chinatelecom.cn>
Cc: tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
	jpoimboe@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Rate-limit the SPECTRE_V2 messages
Message-ID: <20250917051154.4tosn7aj5ps4r5c4@desk>
References: <20250917032857.22441-1-liuq131@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917032857.22441-1-liuq131@chinatelecom.cn>

On Wed, Sep 17, 2025 at 11:28:57AM +0800, Qiang Liu wrote:
> During stress-ng testing, excessive SPECTRE_V2 messages overwhelmed the
> low-speed serial device, causing system soft lockup. This issue can be
> resolved by implementing rate-limiting for the relevant log outputs.
> 
> The log as below:
> [121017.083236] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.098606] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.102398] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.102421] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.102532] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.102550] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.102569] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.133670] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.148497] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.163674] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.185720] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.287675] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.300205] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.335075] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.346428] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.428517] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.450328] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.592131] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121017.592865] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
> [121037.642577] watchdog: BUG: soft lockup - CPU#68 stuck for 23s! [stress-ng-procf:2483051]
> [121037.642578] Modules linked in: ...
> [121037.642697] CPU: 68 PID: 2483051 Comm: stress-ng-procf Kdump: loaded Tainted: ...
> [121037.642698] Hardware name: XFUSION 2288H V6/BC13MBSBC, BIOS 1.29 11/25/2022
> [121037.642706] RIP: 0010:console_unlock+0x283/0x350
> [121037.642709] Code: 00 e8 01 15 00 00 55 9d 45 84 f6 0f 84 46 ff ff ff e8 71 f8 ff ff 85 c0 0f 85 e8 fd ff ff e9 34 ff ff ff e8 df 14 00 00 55 9d <8b> 44 24 04 85 c0 0f 84 f8 fd ff ff e8 9c 84 99 00 e9 ee fd ff ff
> [121037.642710] RSP: 0018:ff607726b60abc00 EFLAGS: 00000246
> [121037.642711] RAX: 0000000000000000 RBX: ffffffffaef699cc RCX: 0000000000000008
> [121037.642712] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffaef6c228
> [121037.642713] RBP: 0000000000000246 R08: ffffffffadabd540 R09: 0000000000aaaaaa
> [121037.642713] R10: 0000000000000001 R11: ff2cf962c6a5b550 R12: ff2cf962c2700000
> [121037.642714] R13: 0000000000000000 R14: ffffffffaef6c228 R15: 000000000000008c
> [121037.642715] FS:  00007f2021c07640(0000) GS:ff2cf9e0be700000(0000) knlGS:0000000000000000
> [121037.642715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [121037.642716] CR2: 0000000000e3b7a0 CR3: 0000003f41266005 CR4: 0000000000771ee0
> [121037.642716] PKRU: 55555554
> [121037.642717] Call Trace:
> [121037.642722]  vprintk_emit+0x118/0x120
> [121037.642727]  printk+0x58/0x73
> [121037.642731]  bpf_unpriv_handler+0xbf/0x180
> [121037.642733]  ? proc_taint+0x1d0/0x1d0
> [121037.642738]  proc_sys_call_handler+0x13e/0x250
> [121037.642742]  new_sync_read+0x10d/0x1b0
> [121037.642745]  vfs_read+0x14e/0x1b0
> [121037.642747]  ksys_read+0x5f/0xe0
> [121037.642750]  do_syscall_64+0x3d/0x80
> [121037.642753]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> Fixes: 0de05d056afd ("x86/speculation: Warn about eIBRS + LFENCE + Unprivileged eBPF + SMT")
> Fixes: 44a3918c8245 ("x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting")
> Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
> ---
>  arch/x86/kernel/cpu/bugs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 36dcfc5105be..22fb2113cbe6 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1809,11 +1809,11 @@ void unpriv_ebpf_notify(int new_state)
>  
>  	switch (spectre_v2_enabled) {
>  	case SPECTRE_V2_EIBRS:
> -		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
> +		pr_err_ratelimited(SPECTRE_V2_EIBRS_EBPF_MSG);
>  		break;
>  	case SPECTRE_V2_EIBRS_LFENCE:
>  		if (sched_smt_active())
> -			pr_err(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
> +			pr_err_ratelimited(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);

Just a thought, pr_err_once() might be sufficient, repeated warnings
doesn't add much value.

>  		break;
>  	default:
>  		break;
> -- 
> 2.46.0
> 

