Return-Path: <linux-kernel+bounces-779022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D26AB2EE09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACEB16F8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8AA25B31C;
	Thu, 21 Aug 2025 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNHJcOSH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10351F7569
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757051; cv=none; b=HWfKP/JB0xpKkqilt5L0ZnXFpoaGUeEOL2DEVJ3Oc9bwAvdh4JOF/h2iAtRNLRe8QgPugiXQ3TnQfyrivV25+BWKFZpduotmVph6DmF0JwAzENpQMwVDxuKcU0jdFfCe7qhMPx0xq5neS2IiDcndTUukwrNwVNCTONpdqJENwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757051; c=relaxed/simple;
	bh=NFXZ8d6DONeLT3o7EGxOYd2k57YC00W1HOmV31OoEZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKT2y7JSj7j9Ik+tidcRmI6onpHrToQNZcy1puKsEcLEMxHTUkXcCt1V6nT3rLF1W4LnPI2C2veUF71AfPRZ37zqqA9hZxfg5WzG9UDBbpwvdcSgyAuavvAb91pNLMPsvMPgmtmVWR51wWiTBmDx4Mn5fOkXtAG/e50mZETL+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNHJcOSH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755757050; x=1787293050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFXZ8d6DONeLT3o7EGxOYd2k57YC00W1HOmV31OoEZM=;
  b=MNHJcOSH+ip00WwLLwicARqXrdsCsUAYIQeBDPsWGah9yujUDrts+mFD
   NSXU5beS8Fh602RcD/ybiq7XfPaewjA/DtAZyGGQ8k9Gq76wnP1mKDeZm
   RAUacDBMT650yB5P+t0iTSCt4SQLjK7KuQkjfvmSln29V99GBWZ626LCz
   3gsZUQxYkzjcMkbWZlfzpt0EIf1p96GHBKb1FIOJUbHfHRnKpPH4N6oH0
   fP7pUkVpJ0EzPAkHwOHENFX3aUaQZ0w6ixgHUZybQ3lRH0iUPwvRJpV34
   Tua0NqNV+Mx5LAJvAnma0epumoyg/AzEm8buUspsg5kBawH+VQaMw9ASB
   w==;
X-CSE-ConnectionGUID: zwI8+OjUTuySfEjmAvB6og==
X-CSE-MsgGUID: KwmumsXvRwqmz7JkOpLXlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58104472"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58104472"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 23:17:29 -0700
X-CSE-ConnectionGUID: 7szQSDp7TTKijjinByQ3FA==
X-CSE-MsgGUID: 7sme4xeiQZOi+sNHBIMFGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167940379"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 23:17:28 -0700
Date: Wed, 20 Aug 2025 23:17:23 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Message-ID: <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819192200.2003074-5-david.kaplan@amd.com>

On Tue, Aug 19, 2025 at 02:21:59PM -0500, David Kaplan wrote:
> @@ -2646,11 +2650,18 @@ early_param("spec_store_bypass_disable", ssb_parse_cmdline);
>  
>  static void __init ssb_select_mitigation(void)
>  {
> -	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) || cpu_mitigations_off()) {
> +	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS)) {

Nothing major, but this change belongs to the next patch that cleans up
cpu_mitigations_off().

