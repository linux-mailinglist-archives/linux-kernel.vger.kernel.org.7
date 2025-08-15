Return-Path: <linux-kernel+bounces-770178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731BAB27814
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599245A6B80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF0238C23;
	Fri, 15 Aug 2025 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POb9c3nA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615810942
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234523; cv=none; b=KbW59kyA2lJkn3vQnh/81VAZWPPArj0bMcEcZjNcPDjw1zviONYEZ5VGNuAm5slpTAmMjIzFZgnAAx9ldba5XQjWma6by9U705Y63W0EJ/FZ6TmBwI6a1ynpdtZKSuDGvlYxgL0y0fAg4YBNKtoyRz+fPKINUW9gbPtvJkcTHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234523; c=relaxed/simple;
	bh=fARppgmQLdDG+Oo817Wx/utbZjvGDXSobDfZUGHYwrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+iWVHTJHtJtSwRuoJFhk8OEiIyPgvNCHM0F/Gzk7RzCEkEOK0vSoFfT0izx+4POhr1E7tGT7SuWTnKuagDOJH3XSmokItCJDwLx7g3WD00AjAJeu2OK3rFiElrMAN6ZpgrKT87jOLrMFXnHC82qxZ6PNIWLL19GJjf4w6qKM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POb9c3nA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755234523; x=1786770523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fARppgmQLdDG+Oo817Wx/utbZjvGDXSobDfZUGHYwrU=;
  b=POb9c3nAiNHLkCcV4uBIUBuKqg0+m+Y+52865nL7Iep9CYdM3FsVbaTk
   cJp09UQQ6PGbsbT35TVG7ZK3i0a0zwsatE4pTzOuCPO7CBafzDe/IMIxZ
   ZSTaRudCKqT+6xP0j3JG2A0BG/wJ2Sc7pUTkGZBi3bR6UpJncC/qOy7+m
   ESr526VNoD9vbJ2ZDJ3kPHwlOhGpdO5e5VKLjVLMll77ADIGF6zZJ/Twu
   FzhV2iMTnJi5/PsyRKqBu8V+muBjQGyaMstDNT4d47GKmVYKJZeLYM9nH
   6NRNmrfSUeiSD9ve4LxP7mNCYs+LOqOMjXo3cGc5dqYV8bx4xbYBL0uTP
   A==;
X-CSE-ConnectionGUID: o1Dr0OMzSN6gAbIJiqx6eQ==
X-CSE-MsgGUID: 8d6TCWxFSzm2trLnxlD1EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="67829288"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="67829288"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:08:42 -0700
X-CSE-ConnectionGUID: tfAlX/NuQliU2/sVdqAv1Q==
X-CSE-MsgGUID: RAvDZ1p1R2222/UQqxT7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166569328"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO desk) ([10.124.223.76])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 22:08:41 -0700
Date: Thu, 14 Aug 2025 22:08:33 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: lirongqing <lirongqing@baidu.com>
Cc: tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
	jpoimboe@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, david.kaplan@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Fix GDS mitigation check for CPUs without
 ARCH_CAP_GDS_CTRL
Message-ID: <20250815050811.gm7nxcd7wn47lshy@desk>
References: <20250815035334.4230-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815035334.4230-1-lirongqing@baidu.com>

On Fri, Aug 15, 2025 at 11:53:34AM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The commit 8c7261abcb7ad("x86/bugs: Add attack vector controls for GDS")
> caused call traces during secondary CPU initialization because it didn't
> properly handle CPUs that lack the ARCH_CAP_GDS_CTRL capability.
> 
> For CPUs without ARCH_CAP_GDS_CTRL support, we should set the mitigation
> to GDS_MITIGATION_UCODE_NEEDED rather than GDS_MITIGATION_OFF, as these
> CPUs may still be vulnerable but cannot disable mitigation.
> 
> Add the missing check for ARCH_CAP_GDS_CTRL to properly determine the
> mitigation state for affected CPUs.
> 
> [    2.809147] unchecked MSR access error: RDMSR from 0x123 at rIP: 0xffffffffb3452807 (update_gds_msr+0x87/0xe0)
> (update_gds_msr+0x87/0xe0)
> [    2.809147] Call Trace:
> [    2.809147]  <TASK>
> [    2.809147]  identify_secondary_cpu+0x72/0x90
> [    2.809147]  start_secondary+0x7a/0x140
> [    2.809147]  common_startup_64+0x13e/0x141
> [    2.809147]  </TASK>
> [    2.809147] unchecked MSR access error: WRMSR to 0x123 (tried to write 0x0000000000000010) at rIP: 0xffffffffb34527b8
> (update_gds_msr+0x38/0xe0)
> [    2.809147] Call Trace:
> [    2.809147]  <TASK>
> [    2.809147]  identify_secondary_cpu+0x72/0x90
> [    2.809147]  start_secondary+0x7a/0x140
> [    2.809147]  common_startup_64+0x13e/0x141
> [    2.809147]  </TASK>
> [    2.809147] ------------[ cut here ]------------
> [    2.809147] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/bugs.c:1053 update_gds_msr+0x9b/0xe0
> 
> Fixes: 8c7261abcb7ad ("x86/bugs: Add attack vector controls for GDS")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index b74bf93..3af911c 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1071,6 +1071,8 @@ static void __init gds_select_mitigation(void)
>  			gds_mitigation = GDS_MITIGATION_FULL;
>  		else {
>  			gds_mitigation = GDS_MITIGATION_OFF;
> +			if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL))

This check is already present few lines below.

> +				gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
>  			return;

To avoid duplicating, a better fix could be to not return here, and let the
next block DTRT:

         /* No microcode */
         if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
                 if (gds_mitigation != GDS_MITIGATION_FORCE)
                         gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
                 return;
         }

