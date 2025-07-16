Return-Path: <linux-kernel+bounces-734284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6EDB07F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524251770D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5198B27A123;
	Wed, 16 Jul 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XVTYrgvD"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5157C19E83C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700785; cv=none; b=SFJ4KzLk6NQuyR/XAKRADo8UWmcGTZ3rugoJVTTBg/s5eTfF6sBmNKlvbr5JyPLl8o7P88qd7nE7T9mepT+7v6V+xC4Px5XCWyffeiMndi/nvpwEwiqWQ6hptai1alFLe/yXzePRAZGjINnLtlBQXlryZhVU4O3AcQEFnPZyWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700785; c=relaxed/simple;
	bh=MG4I0srfD+rmri6ZMGzCO+CMCwOgLC9l11n+IM4fkHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLrAE1q3PQN6BGf7TKQLpAdI/geVCxXs9nkbHZcUHjstYA4jy58yJwlb0z55cgL7f54IhudcTibd9STFHAoNXdtwCnOdAlPkGJmZu/H/Pm4THjYCdi3zZeKy3TUfIg9qqsLiFtLOancwAIJzHFe30e7DdASq71D54m+fp7FyED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XVTYrgvD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 2A7D82054681; Wed, 16 Jul 2025 14:19:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A7D82054681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752700778;
	bh=aK73iNz3LAM0/H0Jozbq3JVLk/2Tf7eq6SIfTIdaXc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVTYrgvDXsd1N6WeL30udbrOWv/bZre0T3kpgpvaKQCBt11uAsWtM/Irp2Ce90FCk
	 XiCPNgKyEqPNVtPdrlFvm+4CyzETtL/ptoxWsg6sK9yk80TLsTOQcdAg32jDe159B5
	 j+q4bmNxixOCZ4BzGavzprvEJ0zSRH7jDmgLCa6c=
Date: Wed, 16 Jul 2025 14:19:38 -0700
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Jared White <jaredwhite@microsoft.com>
Subject: Re: [PATCH 1/2] x86/build: only align ENTRY_TEXT to PMD_SIZE if
 necessary
Message-ID: <20250716211938.GA7142@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1752092219-16248-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <d9e9ae3a-7637-4a0b-892d-9b7c6335c1d7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e9ae3a-7637-4a0b-892d-9b7c6335c1d7@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jul 10, 2025 at 06:14:20AM -0700, Dave Hansen wrote:
> On 7/9/25 13:16, Hamza Mahfooz wrote:
> > PTI requires the begin and end of ENTRY_TEXT be aligned to PMD_SIZE.
> > SRSO requires srso_alias_untrain_ret to be 2M aligned. This costs
> > between 2-4 MiB of RAM (depending on the size of the preceding section).
> > So, only align when PTI is enabled or SRSO is enabled.
> 
> This seems so utterly random.
> 
> I don't think I was even aware of the SRSO restriction here. Looking
> over it now, I do see the vmlinux.lds.S changes and this does make sense.
> 
> But I'm really worried that we've grown more dependencies on this
> alignment. Let's say, for instance, that you forgot to address SRSO in
> this patch and the mitigation got broken. Would we have ever known?
> 
> I'd like to hear a lot more from you about why 2-4 MiB of RAM is
> important and what the environment is where you presumably know that
> there are no Meltdown or SRSO vulnerable CPUs.

We are using it to run a stripped down kernel (see [1]) on top of
HyperV for OpenHCL. It is only intended to run OpenVMM ([2]).

1. https://raw.githubusercontent.com/microsoft/OHCL-Linux-Kernel/refs/heads/product/hcl-main/6.12/Microsoft/hcl-x64.config
2. https://github.com/microsoft/OpenVMM

