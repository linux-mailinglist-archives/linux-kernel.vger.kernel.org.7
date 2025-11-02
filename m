Return-Path: <linux-kernel+bounces-881630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B9C28986
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 04:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 075EF4E16F4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 03:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94A12C544;
	Sun,  2 Nov 2025 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ba+ni+Nk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7D4A3C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762053576; cv=none; b=ZD2nSCU9U4X1ghyg3lZJFUgreef2Blpm7gmSRhxipfI46w96pGV35R/enQ6G+DHxcUNZ7HUEs7zd4zV4yOnl2XDbakzea7g0T9gKzP+u69kXh/VqBcLzXmWq3ctqEbAlG1G7A7rGEDere7whnL+W20xnZu9AFwkR6hLiQoEC/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762053576; c=relaxed/simple;
	bh=OpfpPIF0FAOQIQ6J9k/BzwstL3azrmYNk+tF3wh9dfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Od9uJT4q0UpiWSltdszwfKud0k9t4E9dvm/cIxMu1I43RUjyNc0t8yLk2R/enOeID9a/7ptuAYqqNrJtHXUFiHZLLYRLq1AhvRj0RNqJiDD20d5bh/rpSemwiZxqwN7knOCVmaASM+uE/Og788/S2WOE3zynJnnyo4L0r+EHnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ba+ni+Nk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762053575; x=1793589575;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OpfpPIF0FAOQIQ6J9k/BzwstL3azrmYNk+tF3wh9dfw=;
  b=Ba+ni+Nk9f1dyPr//Ksu82bT0DDIX5SFQKtmbZQrp9gDUUfvvFhcybfD
   z9ExDxVJDEUnMvK9ifyEfd0luzEx6WiulTiESmV0N8+CmltQyJ7w2QlGu
   bdoM5I/SThseJSXMtH27lI+ZsqdaiXUQyzNdCeH0NqHFrWTiJBhsHxlTq
   ARyaRrD6nLRpB913I91xb4Jj+J9GCZp/Ou9WsB01eEyusXlvndZjTg4Cq
   7ZR/14FalyUeYmwE0yVb38zbFdbu8YBC+6UlLjHiK/r0GKuQaRi+fv3E+
   09kcVqe+Enb/+a+Xpz8ToHT4Gfa9nrqn2LGV1Cnu3Nwq9L11jc01ry3Da
   w==;
X-CSE-ConnectionGUID: Dkzcj54AQqCGPdC4aqeHsg==
X-CSE-MsgGUID: pnJOPkJYTjS4APvb9uFytQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="74462361"
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="74462361"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 20:19:34 -0700
X-CSE-ConnectionGUID: bmCNi3uWRMKvOsBgy1+5Sg==
X-CSE-MsgGUID: /+w3pXMMT2mYSFdhF3gSCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="187295258"
Received: from kvalverd-mobl1.amr.corp.intel.com ([10.125.182.77])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 20:19:33 -0700
From: Marc Herbert <marc.herbert@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  x86@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/msr: add CPU_OUT_OF_SPEC taint name to
 "unrecognized" pr_warn(msg)
In-Reply-To: <20251101100325.GAaQXa7UF-Ru2yqdI1@fat_crate.local> (Borislav
	Petkov's message of "Sat, 1 Nov 2025 11:03:25 +0100")
References: <20251101-tainted-msr-v1-1-e00658ba04d4@linux.intel.com>
	<20251101100325.GAaQXa7UF-Ru2yqdI1@fat_crate.local>
Date: Sat, 01 Nov 2025 20:19:27 -0700
Message-ID: <m2bjll15q8.fsf@kvalverd-mobl1.amr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks Boris for looking at this!

Borislav Petkov <bp@alien8.de> writes:
> Taint flags are expensive and we don't have flag for everything. And when
> userspace is poking at MSRs, that's similar to putting the CPU in
> a out-of-specification mode of sorts. So I took what's closest.

I tried to be very thorough to justify the change but I did not mean
some alternative implementation was available, sorry if I gave that
impression. I just struggled to make sense of some unrelated crash logs
and that's really all from my point of view. I mean all for now at
least.

> What is not clear to me is why do you need to dump the fact that it tainted
> here and dump the taint flag too?

You mean the "%s", tainted_flags[OOSPEC].desc bit? Not sure I understand
your question. That was just a way to re-use the existing string. But as
found by the kernel test robot, that was a mistake because
tainted_flags[] is not exported to modules. I missed that msr.c could be
compiled as a module, apologies. I've removed that in v2, I want to make
this change even simpler and append this instead:

  pr_warn( "... (pid: %d), tainting CPU_OUT_OF_SPEC.\n",

> Also, why aren't you using print_tainted()... 

AFAIK print_tainted() shows all current flags, not just
CPU_OUT_OF_SPEC. So a full print_tainted() display would not make
unambiguous which specific flag is being set, even more so considering
writing MSRs can happen a very long time after boot. But, much worse:
the CPU_OUT_OF_SPEC taint loop has not even been set yet when this
pr_warn() is run...

> ...  if that is really necessary?

This patch is not "really necessary". Its purpose is only to save hours
or even days for people trying to make sense of crash logs. In my ideal
world, it should always be easy to tell "who tainted what when" from the
logs without an corresponding expert and/or searching the source code. I
admit this could harm job security ;-)

This is not unusual, for instance TAINT_OOT_MODULE is not printed
literally in the logs yet this other pr_warn() clearly points the finger
at mod->name(s) in the logs:

  pr_warn("%s: loading out-of-tree module taints kernel, mod->name);

Some other flags have a much narrower range which makes the lack of
finger pointing a non-issue.


