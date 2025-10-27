Return-Path: <linux-kernel+bounces-872539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B3C11673
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4678019C74D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA12FE057;
	Mon, 27 Oct 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvqfUfAn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EC2798E5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597175; cv=none; b=NB0OePjtyDXe7wvIGYUAKsiykVIj1Dn045dDQpquzCgyz4+6tlTVKbGe07LwLX1dYVqAV31LhqHkXjTci0KFIwapKGV7UM4Qr3Emv3RA+tV6u7YrWlo6zuZV/jf5DGX+qeX2kyjWRaB/OAixHGTWr+ElUDXv0RY1/TAxtdtLGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597175; c=relaxed/simple;
	bh=BtAlgxNZjGGgI/dxScVsmUb+YMCXiamkahS9o1su6Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb1As4MjP4FtECRwZz5dDf7gS4E8cECFUZYUsGJS3NeIw5/UT/IRW4Zdp71KxvvUa1t579b7wMq91Pi3y+hkH+zH5reKTY1/mJ1nxJA9lrRKX3oTjdXeaRCesEPcJOLyvgJq0fCETk7I7ZSJIrYEw1798juxJwu56ZxRin2Arjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvqfUfAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6285FC4CEF1;
	Mon, 27 Oct 2025 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761597175;
	bh=BtAlgxNZjGGgI/dxScVsmUb+YMCXiamkahS9o1su6Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvqfUfAnZpQv9hgmUcq15ioZ3sj2uORjN1rlJkEsYXADWIZiG1I9VtQWM9lgavfeP
	 HmQo2Et/eGUm4Bo1D8wtUwOOOA6sr+IOp6EFh6ZSysT7HEFN57QeMJ9UMB87/0Yu0a
	 Ov+3capPs1knvmOgbuOz4b7pTakTx0QMa1PZJaZyO/4Ob1pgvYObCKn34dR/ftaagl
	 kztoibdVbuzu3I6VGWvNeD936a7Zjqh3ggveAE+Y0cqhaDCeAs3f9bzMMx3QfL2b+z
	 uwhj3pUiFpyrMiCGFsfI5lrs3o46IX/tuVBgIeoi0VmYkLisj0rMRMBz7eB3TZucWE
	 qgIRWc5bRc46A==
Date: Mon, 27 Oct 2025 13:32:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Thomas Huth <thuth@redhat.com>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, 
	Zheyun Shen <szy0127@sjtu.edu.cn>, Kevin Loughlin <kevinloughlin@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Li Chen <chenl311@chinatelecom.cn>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/smpboot: Mark native_play_dead() as __noreturn
Message-ID: <s54pjvfbalaoklswugeft2ikjyrdz7oqvwybztinphde2thz7x@vtlr6ctocfbx>
References: <20251027155107.183136-1-thorsten.blum@linux.dev>
 <i4o6cr4x364xsk7ftas5guggjt4xdvawurrohveahi75iba5aj@dl6plusoxtin>
 <EA25BB49-DCF0-4868-878D-8BC5217380A1@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EA25BB49-DCF0-4868-878D-8BC5217380A1@linux.dev>

On Mon, Oct 27, 2025 at 08:56:18PM +0100, Thorsten Blum wrote:
> On 27. Oct 2025, at 20:28, Josh Poimboeuf wrote:
> > On Mon, Oct 27, 2025 at 04:51:02PM +0100, Thorsten Blum wrote:
> >> native_play_dead() ends by calling the non-returning function
> >> hlt_play_dead() and therefore also never returns.
> >> 
> >> The !CONFIG_HOTPLUG_CPU stub version of native_play_dead()
> >> unconditionally calls BUG() and does not return either.
> >> 
> >> Add the __noreturn attribute to both function definitions and their
> >> declaration to document this behavior and to potentially improve
> >> compiler optimizations.
> >> 
> >> Remove the obsolete comment, and add native_play_dead() to the objtool's
> >> list of __noreturn functions.
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > 
> > Is there an objtool warning that this fixes?  If so, it would be helpful
> > to put it in the description above.
> 
> Not that I'm aware of.

Ok.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

