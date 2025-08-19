Return-Path: <linux-kernel+bounces-774873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43841B2B8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2417B5E81D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA41C30FF06;
	Tue, 19 Aug 2025 05:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRvoWVBp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F821D3EE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581295; cv=none; b=acZ7dPxXnuQeUW7plyc9ODJHx/zhcDpxK8YqChzTka5/OBLlundEtiyAkdEoT99BYcpQhH9bQbEiLgx/N1mnJxyjfRKMCcMdc4Iz7zO7w35pms/Lc0qc0fqzYBCIyO9IHwDhtTD6nX0+RYfVfYXF9I0kpFKzZXIUEByMG2ll9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581295; c=relaxed/simple;
	bh=TnZhiAWCrZWafIbYyXSOmSfyF0yUlmDWQDgwedIaYj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/lxvHNwrKQrK+BvA+xIyJrGn049zh0piFxXTAcYVyho/tU7gXmWFADM5qr/FxkljsNle6JYj4TQJHXfe/jw6wc/hMh7wcunEydlgdRhQVns5thfEIO5Z8RCBHVkTeE81z+yQ9YYxGTQaceCY2YpFXH0d8b8yIl9nuyxWiSKhQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRvoWVBp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755581294; x=1787117294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TnZhiAWCrZWafIbYyXSOmSfyF0yUlmDWQDgwedIaYj4=;
  b=jRvoWVBpwq8p0kZ0HotdS8wXzSves2r4Jj62bYLwTtj4nQCB5ay6+P4q
   NZrh3Nmh6WxCJQJDRjZf0Z0bQmK57UPFMOEyOdkLAQHoPVZhtSs8q6vOX
   vlWKRps0b85hx7yMLTAIqKYIJ97GGRIppaM+ru8xOAj7FDP7mOoRFJeSx
   6HD9ojOtyUEH1O6/Z+HY1FsRKHYl5Od/tpw6gszB4T7S9IUyX7sDOnAdu
   LStXiDgn0bx2rjXwkMLcobWym55/8TicvQNtANF9CS/1vw8lDEAktOb84
   LhBUJPxbSrmr91+/wQAQfhmfXNAi4pFmbPI2cs4m2sYxOva/B+rhsTSQV
   Q==;
X-CSE-ConnectionGUID: qHTno6mNSCWo6SGcHlH31w==
X-CSE-MsgGUID: fa5+7wVpQRuzApSWlZTwYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="61446373"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="61446373"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 22:28:14 -0700
X-CSE-ConnectionGUID: zchajo5mQ2iD2auBC9vD+Q==
X-CSE-MsgGUID: 3cyaSsxIT8Gz5npPDKtWhg==
X-ExtLoop1: 1
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO desk) ([10.124.220.33])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 22:28:12 -0700
Date: Mon, 18 Aug 2025 22:28:07 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: lirongqing <lirongqing@baidu.com>
Cc: tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
	jpoimboe@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, david.kaplan@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v3] x86/bugs: Fix GDS mitigation selecting when
 mitigation is off
Message-ID: <20250819052807.mpqdtauhs33uxnay@desk>
References: <20250819023356.2012-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819023356.2012-1-lirongqing@baidu.com>

On Tue, Aug 19, 2025 at 10:33:56AM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The current GDS mitigation logic incorrectly returns early when the
> attack vector mitigation is turned off, which leads to two problems:
> 
> 1. CPUs without ARCH_CAP_GDS_CTRL support are incorrectly marked with
>    GDS_MITIGATION_OFF when they should be marked as
>    GDS_MITIGATION_UCODE_NEEDED.
> 
> 2. The mitigation state checks and locking verification that follow are
>    skipped, which means:
>    - fail to detect if the mitigation was locked
>    - miss the warning when trying to disable a locked mitigation
> 
> Remove the early return to ensure proper mitigation state handling. This
> allows:
> - Proper mitigation classification for non-ARCH_CAP_GDS_CTRL CPUs
> - Complete mitigation state verification
> 
> The change fixes the following runtime issues because mitigation is off
> in non-ARCH_CAP_GDS_CTRL CPUs:
> 
> [    2.809147] unchecked MSR access error: WRMSR to 0x123 (tried to write 0x0000000000000010) at rIP: 0xffffffffb34527b8 (update_gds_msr+0x38/0xe0)
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
> Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v2: refine the commit header and Reviewed-by: Pawan Gupta
> Diff with v1: directly remove return 
> 
>  arch/x86/kernel/cpu/bugs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index b74bf93..9e0b9bf 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1071,7 +1071,6 @@ static void __init gds_select_mitigation(void)
>  			gds_mitigation = GDS_MITIGATION_FULL;
>  		else {
>  			gds_mitigation = GDS_MITIGATION_OFF;
> -			return;
>  		}

With the "return" gone, braces are not needed in the "else" block (although
it is a bit strange to have braces only in the "else" block to begin with).

Sorry, I missed to spot that in the previous review.

