Return-Path: <linux-kernel+bounces-868099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F88C045BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C5384E2622
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDC2221578;
	Fri, 24 Oct 2025 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vl/ciuJ5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44CD515
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761282082; cv=none; b=ucPZ0tCjqYxJDU5n08GBCPN+zHU5eYQ1eeH1WCg6tu4euEL3xafXSa/QTpt86rq8J0rlZEhr08/gSgU0DNxom11Ta5cpUV/f1O5KybjlkXW9gpRJdv6+jk+NEEtOM+gxuy8JCIC+H7GKWw1uy6rjgmGmM1O2LQ2jDj7L17qMcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761282082; c=relaxed/simple;
	bh=4BOPF/TzT3wD8qEVDfTl/b7wBTgrIXT6aR/pCH3uUVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkSxnbvVn5c5dFQ4KJYaq5LA6/PRiKem+0RyCW7/iOa14KJOLfHmfqey8ZDg+TpGjDrh4bOZbNoPIHOQCnuYsMtWLpVYRrMwyHVHbmoJUg7VtCuHb2gTpG62jbAyvSYxh39JFlSsaRJNXkcq8Vnhbn7FHSxr0iTnibgKT5t3TB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vl/ciuJ5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761282080; x=1792818080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4BOPF/TzT3wD8qEVDfTl/b7wBTgrIXT6aR/pCH3uUVk=;
  b=Vl/ciuJ53tFTLU3X6ErAXD47bgcIrV5OLIYrizrg9M17JbLf2MEFrn09
   KiSSEtsB2tYgIH3avOFMjFaHbwLbchXxfWG911ZTfIMRtHWCpOXdZ4PXm
   tRJrmw2aiQWTmuct1Z42hLPgRn8zfgaTjARQa2vLy1F8qqlQrw7X3RcMA
   y8Z7SvP9zi6YksyfWrP58ds8/1h+cpg9klIdGidTWL+GDdUeofYMwxzX8
   WOBntAEGpbp5lXCbxw8aBld+NI6BSjaTmBAh8FeQHEX/eCJjjghe8WA0z
   pLM9sL1zQlxktEadpKTiBQlNtEyNIGuk1ahNKbX8uNiHTLv+M4kAvXNNw
   Q==;
X-CSE-ConnectionGUID: klkSABxLTLePzUMzPtLrbg==
X-CSE-MsgGUID: 0tR1u/VMRiaduV1J1jsgXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73750416"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="73750416"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 22:01:19 -0700
X-CSE-ConnectionGUID: eOchSQIYSSKR//H0yugPUw==
X-CSE-MsgGUID: SMefkpw/QqaRudqDozDOEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="184054149"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO desk) ([10.124.221.191])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 22:01:03 -0700
Date: Thu, 23 Oct 2025 22:00:58 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
Message-ID: <20251024050058.stc2nthc2bklhyqv@desk>
References: <20251013143444.3999-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:33:48AM -0500, David Kaplan wrote:
> Dynamic mitigations enables changing the kernel CPU security mitigations at
> runtime without a reboot/kexec.
> 
> Previously, mitigation choices had to be made on the kernel cmdline.  With
> this feature an administrator can select new mitigation choices by writing
> a sysfs file, after which the kernel will re-patch itself based on the new
> mitigations.
> 
> As the performance cost of CPU mitigations can be significant, selecting
> the right set of mitigations is important to achieve the correct balance of
> performance/security.
> 
> Use
> ---
> As described in the supplied documentation file, new mitigations are
> selected by writing cmdline options to a new sysfs file.  Only cmdline
> options related to mitigations are recognized via this interface.  All
> previous mitigation-related cmdline options are ignored and selections are
> done based on the new options.
> 
> Examples:
>    echo "mitigations=off" > /sys/devices/system/cpu/mitigations
>    echo "spectre_v2=retpoline tsa=off" > /sys/devices/system/cpu/mitigations
> 
> 
> There are several use cases that will benefit from dynamic mitigations:
> 
> Use Cases
> ---------
> 1. Runtime Policy
> 
> Some workflows rely on booting a generic kernel before customizing the system.
> cloud-init is a popular example of this where a VM is started typically with
> default settings and then is customized based on a customer-provided
> configuration file.
> 
> As flows like this rely on configuring the system after boot, they currently
> cannot customize the mitigation policy.  With dynamic mitigations, this
> configuration information can be augmented to include security policy
> information.
> 
> For example, a cloud VM which runs only trusted workloads likely does not
> need any CPU security mitigations applied.  But as this policy information
> is not known at boot time, the kernel will be booted with unnecessary
> mitigations enabled.  With dynamic mitigations, these mitigations can be
> disabled during boot after policy information is retrieved, improving
> performance.
> 
> 2. Mitigation Changes
> 
> Sometimes there are needs to change the mitigation settings in light of new
> security findings.  For example, AMD-SB-1036 advised of a security issue
> with a spectre v2 mitigation and advised using a different one instead.
> 
> With dynamic mitigations, such changes can be made without a reboot/kexec
> which minimizes disruption in environments which cannot easily tolerate
> such an event.
> 
> 3. Mitigation Testing
> 
> Being able to quickly change between different mitigation settings without
> having to restart applications is beneficial when conducting mitigation
> development and testing.
> 
> Note that some bugs have multiple mitigation options, which may have
> varying performance impacts.  Being able to quickly switch between them
> makes evaluating such options easier.
> 
> 
> Implementation Details
> ----------------------
> Re-patching the kernel is expected to be a very rare operation and is done
> under very big hammers.  All tasks are put into the freezer and the
> re-patching is then done under the (new) stop_machine_nmi() routine.
> 
> To re-patch the kernel, it is first reverted back to its compile-time
> state.  The original bytes from alternatives, retpolines, etc. are saved
> during boot so they can later be used to restore the original kernel image.
> After that, the kernel is patched based on the new feature flags.
> 
> This simplifies the re-patch process as restoring the original kernel image
> is relatively straightforward.  In other words, instead of having to
> re-patch from mitigation A to mitigation B directly, we first restore the
> original image and then patch from that to mitigation B, similar to if the
> system had booted with mitigation B selected originally.
> 
> 
> Performance
> -----------
> Testing so far has demonstrated that re-patching takes ~50ms on an AMD EPYC
> 7713 running a typical Ubuntu kernel with around 100 modules loaded.
> 
> Guide to Patch Series
> ---------------------
> As this series is rather lengthy, this may help with understanding it:
> 
> Patches 3-18 focus on "resetting" mitigations.  Every bug that may set feature
> flags, MSRs, static branches, etc. now has matching "reset" functions that will
> undo all these changes.  This is used at the beginning of the re-patch flow.
> 
> Patches 20-22 move various functions and values out of the .init section.  Most
> of the existing mitigation logic was marked as __init and the mitigation
> settings as __ro_after_init but now these can be changed at runtime.  The
> __ro_after_init marking functioned as a defense-in-depth measure but is arguably
> of limited meaningful security value as an attacker who can modify kernel data
> can do a lot worse than change some speculation settings.  As re-patching
> requires being able to modify these settings, it was simplest to remove them
> from that section.
> 
> Patches 23-27 involve linker and related modifications to keep alternative
> information around at runtime instead of free'ing it after boot.  This does
> result in slightly higher runtime memory consumption which is one reason why
> this feature is behind a Kconfig option.  On a typical kernel, this was measured
> at around 2MB of extra kernel memory usage.
> 
> Patches 28-30 focus on the new stop_machine_nmi() which behaves like
> stop_machine() but runs the handler in NMI context, thus ensuring that even NMIs
> cannot interrupt the handler.  As dynamic mitigations involves re-patching
> functions used by NMI entry code, this is required for safety.
> 
> Patches 31-40 focus on support for restoring the kernel text at runtime.  This
> involves saving the original kernel bytes when patched the first time and adding
> support to then restore those later.
> 
> Patches 41-44 start building support for updating code, in particular module
> code at runtime.
> 
> Patches 45-47 focus on support for the Indirect Target Selection mitigation
> which is particularly challenging because it requires runtime memory allocations
> and permission changes which are not possible in NMI context.  As a result, ITS
> memory is pre-allocated before entering NMI context.
> 
> Patch 50 adds the complete function for resetting and re-patching the kernel.
> 
> Patches 51-53 build the sysfs interface for re-patching and support for parsing
> the new options provided.
> 
> Patches 54-56 add debugfs interfaces to values which are important for
> mitigations.  These are useful for userspace test utilities to be able to force
> a CPU to appear to be vulnerable or immune to certain bugs as well as being able
> to help verify if the kernel is correctly mitigating various vulnerabilities.

Although it adds some complexity, this adds a very useful feature. Thanks
for doing this series.

Just curious, for patching indirect branches, was replacing alternatives
with static_calls considered? I haven't looked at the feasibility, but
static_calls seems to be more suited for post-boot patching.

Thinking out loud, patching in something similar to suspend-to-RAM flow may
reduce some corner cases. Barring the BSP, the APs gets reinitialized in
that case.

