Return-Path: <linux-kernel+bounces-771264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825BCB284D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6C356050A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B442F9C47;
	Fri, 15 Aug 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTvDIW39"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322A2F9C34
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278310; cv=none; b=d5TsF2isb7/ioxVk6ffHy5L5aNKW/ZTxzxNYMOY65446lbJLYHZS77NqlmBfiLiJeF9Zoycu+wblqZxdG/LwNLEkS0xXRnhhvpcTXSDP5Zx3rj8Wz6c28eEQF8c5mt3UP8E+ou08xyjXPc3Nxtxr8qQX1/VeOKnY21KFMulPf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278310; c=relaxed/simple;
	bh=W/i73JM6TV9NwfUhe5nXojJCkWKCI27EcOqzZJs42N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMwgjyS4wJIYq6CZyCYJPQ9i46gGx/uxU7A/bhq0gtNAJCFmIce+ACSnf4Xqk5eRW8U23zL2zXSdpGEj2/KI5DELzqsf1+dIEqgxma0/0/UIp4JlmMUybewZkrOjvdg99unKVPkM8HGUVxOu58gQt2HJXflDyIrFUY3dp8LrRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTvDIW39; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755278309; x=1786814309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W/i73JM6TV9NwfUhe5nXojJCkWKCI27EcOqzZJs42N0=;
  b=CTvDIW39BdCXzhSOTkhi9iOs9C91CJiqcr8+EvW9b09Ebv/Hiu+qUmgU
   lUSAwPmyMjnQXqi+eR2cf8wRn1Nd9c7L6Oj4cBWYbehR8nffF+3Kkgcph
   RJzwDP/1Ej3FHCl0LimUpbKUVrreT1tG9mnk8zpivYsYvJlyQXLj9dzA6
   VejFxa0veDc3MfQRWDRoXBwGLIN8SrWaLGYE/Qv/E/ODmAHl/lge/Z+vW
   eGImTwizU677UIL0315aJFhWX0USUNWBtM/9CEOcMQOrncGqrgwatsjjj
   JNue9AV6phbT3ANhMvn4WBOpVB8DF3mk2VyURp/xXu3UMec/+HoDB0FE2
   w==;
X-CSE-ConnectionGUID: pKm4OGTAQaCNbf9LhMn1uw==
X-CSE-MsgGUID: RMH/NJSNRk6k0Hgp9tfdlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="45175020"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="45175020"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 10:18:28 -0700
X-CSE-ConnectionGUID: 2YxRqWD3Rt6b0ygAAV7EhQ==
X-CSE-MsgGUID: /+weCBXqRvSQJ2PyBfLuLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167869816"
Received: from gpacheco-mobl.amr.corp.intel.com (HELO desk) ([10.124.223.139])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 10:18:28 -0700
Date: Fri, 15 Aug 2025 10:18:18 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"david.kaplan@amd.com" <david.kaplan@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [????] Re: [PATCH] x86/bugs: Fix GDS mitigation check for CPUs
 without ARCH_CAP_GDS_CTRL
Message-ID: <20250815171818.4jwcl73pz2njcsos@desk>
References: <20250815035334.4230-1-lirongqing@baidu.com>
 <20250815050811.gm7nxcd7wn47lshy@desk>
 <8caaa7fabf2446ffbac922dafaed3dc9@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8caaa7fabf2446ffbac922dafaed3dc9@baidu.com>

On Fri, Aug 15, 2025 at 05:28:18AM +0000, Li,Rongqing wrote:
> 
> 
> > -----Original Message-----
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Sent: 2025年8月15日 13:09
> > To: Li,Rongqing <lirongqing@baidu.com>
> > Cc: tglx@linutronix.de; bp@alien8.de; peterz@infradead.org;
> > jpoimboe@kernel.org; mingo@redhat.com; dave.hansen@linux.intel.com;
> > x86@kernel.org; hpa@zytor.com; david.kaplan@amd.com;
> > linux-kernel@vger.kernel.org
> > Subject: [????] Re: [PATCH] x86/bugs: Fix GDS mitigation check for CPUs without
> > ARCH_CAP_GDS_CTRL
> > 
> > On Fri, Aug 15, 2025 at 11:53:34AM +0800, lirongqing wrote:
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > The commit 8c7261abcb7ad("x86/bugs: Add attack vector controls for
> > > GDS") caused call traces during secondary CPU initialization because
> > > it didn't properly handle CPUs that lack the ARCH_CAP_GDS_CTRL capability.
> > >
> > > For CPUs without ARCH_CAP_GDS_CTRL support, we should set the
> > > mitigation to GDS_MITIGATION_UCODE_NEEDED rather than
> > > GDS_MITIGATION_OFF, as these CPUs may still be vulnerable but cannot
> > disable mitigation.
> > >
> > > Add the missing check for ARCH_CAP_GDS_CTRL to properly determine the
> > > mitigation state for affected CPUs.
> > >
> > > [    2.809147] unchecked MSR access error: RDMSR from 0x123 at rIP:
> > 0xffffffffb3452807 (update_gds_msr+0x87/0xe0)
> > > (update_gds_msr+0x87/0xe0)
> > > [    2.809147] Call Trace:
> > > [    2.809147]  <TASK>
> > > [    2.809147]  identify_secondary_cpu+0x72/0x90
> > > [    2.809147]  start_secondary+0x7a/0x140
> > > [    2.809147]  common_startup_64+0x13e/0x141
> > > [    2.809147]  </TASK>
> > > [    2.809147] unchecked MSR access error: WRMSR to 0x123 (tried to write
> > 0x0000000000000010) at rIP: 0xffffffffb34527b8
> > > (update_gds_msr+0x38/0xe0)
> > > [    2.809147] Call Trace:
> > > [    2.809147]  <TASK>
> > > [    2.809147]  identify_secondary_cpu+0x72/0x90
> > > [    2.809147]  start_secondary+0x7a/0x140
> > > [    2.809147]  common_startup_64+0x13e/0x141
> > > [    2.809147]  </TASK>
> > > [    2.809147] ------------[ cut here ]------------
> > > [    2.809147] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/bugs.c:1053
> > update_gds_msr+0x9b/0xe0
> > >
> > > Fixes: 8c7261abcb7ad ("x86/bugs: Add attack vector controls for GDS")
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  arch/x86/kernel/cpu/bugs.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > index b74bf93..3af911c 100644
> > > --- a/arch/x86/kernel/cpu/bugs.c
> > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > @@ -1071,6 +1071,8 @@ static void __init gds_select_mitigation(void)
> > >  			gds_mitigation = GDS_MITIGATION_FULL;
> > >  		else {
> > >  			gds_mitigation = GDS_MITIGATION_OFF;
> > > +			if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL))
> > 
> > This check is already present few lines below.
> > 
> > > +				gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
> > >  			return;
> > 
> > To avoid duplicating, a better fix could be to not return here, and let the next
> > block DTRT:
> 
> But if cpu has ARCH_CAP_GDS_CTRL, the next block will be skipped, and the
> codes after checking ARCH_CAP_GDS_CTRL block will be run, this is not
> expected

How is that a problem? That is how it was originally implemented.

Infact, the following checks are required for the correct behavior:

         if (mcu_ctrl & GDS_MITG_LOCKED) {
                 if (gds_mitigation == GDS_MITIGATION_OFF)
                         pr_warn("Mitigation locked. Disable failed.\n");
	...
                 gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
         }

If the GDS microcode mitigation is locked before the kernel boot, MSR write
for OFF will not take effect anyways. And you report OFF when the
mitigation is locked to ON. While also triggering below WARN_ON_ONCE():

update_gds_msr()
{
...
         /*
          * Check to make sure that the WRMSR value was not ignored. Writes to
          * GDS_MITG_DIS will be ignored if this processor is locked but the boot
          * processor was not.
          */
         rdmsrq(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl_after);
         WARN_ON_ONCE(mcu_ctrl != mcu_ctrl_after);

