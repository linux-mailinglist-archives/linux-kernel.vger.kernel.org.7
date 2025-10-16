Return-Path: <linux-kernel+bounces-856842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3557ABE5376
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B222019A12D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33D8488;
	Thu, 16 Oct 2025 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rfEUVbVk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9ehScE6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F162D9EC9;
	Thu, 16 Oct 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642492; cv=none; b=WlagZYe9S5Gvurhco4ARyyvE2dLsjM01jHy/n8lwiwCuXqu7n4TBGfvE6o8LR4S1kohUM1OCRECa4udmgi5aKYxsEOsSwBu+iOYvXsyJpsAP4j5WIaF3TCDq0uBFN4DcVQg+SheWEUKlTwh22/81/dVEZICo4WIikP75SWqqOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642492; c=relaxed/simple;
	bh=Pj3R8CiuGY0SXWCGNJpCWI8SGHkFDgjchXQCx1mASdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+pvpIh7NSoK1UlRz/z/RvqU45yzWeS7f6jalNUn/+5FwSmRAMs09IoivlrnO8SyRITfRiwua2NhbEyTFoUaLjsbuKGnxsWJQ39dyL5RyIv7dyDVM7i7+f5aaFYS1bk2k/78jGL98Vub9lu15ze49HpcFPUzkjQ/ylOv2dYJtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rfEUVbVk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9ehScE6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 21:21:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760642488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj3R8CiuGY0SXWCGNJpCWI8SGHkFDgjchXQCx1mASdQ=;
	b=rfEUVbVkuVQxGU/1zNmAjnEwOFOOC+hxZVgcDzQwWnJpnYRuAaR4+L3tDmBk+KsmSomXMj
	Jw/If1H/d2fD18vf/hEPouI8vTUuAwzrgM/GkL8DJRkopcuKOxYDqQ0D+aUZOXhe2CsggJ
	fQ9DqEH9uULK8RPgGNgwoLB+LSRqg+kiP3S/aQvUGSJYHcvhunZ3EVypPVa98uiGJEytri
	gHIx1OBr9TV+6F4iIfWDa6JzDmjAP2fJs6aRl2NMmKrv+55LxOaF2K1wPNO6haQT/H+0zH
	ax65EutVMg8IilmrtBRLHQpGQgJEgF3RcYRZz5GQGnNja5XoxfYQc1B0ki7r8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760642488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj3R8CiuGY0SXWCGNJpCWI8SGHkFDgjchXQCx1mASdQ=;
	b=i9ehScE69UKn9evEUeMLkK4XNPQG9iGHLB2PlBLnPPJyrjPl2u8Ep40pAiHu796yF5Z7Gg
	20b6dqzg8PJ9iICg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v5 01/35] ASoC: Intel: avs: Include CPUID header at file
 scope
Message-ID: <aPFFtvFwgkPCdw-_@lx-t490>
References: <20250905121515.192792-1-darwi@linutronix.de>
 <20250905121515.192792-2-darwi@linutronix.de>
 <20251016105514.GCaPDPEu016XyDocfY@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016105514.GCaPDPEu016XyDocfY@fat_crate.local>

On Thu, 16 Oct 2025, Borislav Petkov wrote:
>
> Why are we even bothering with !CONFIG_X86?
>
> Because this thing has || COMPILE_TEST in Kconfig.
>
> But this thing gets enough compile testing on x86 already so why not
> simply drop the whole unnecessary gunk?
>

Makes sense; will do.

Thanks!
Ahmed

