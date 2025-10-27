Return-Path: <linux-kernel+bounces-872436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A04C113A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63E165644F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8732ABF6;
	Mon, 27 Oct 2025 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+pWdnDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3932ABF1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593332; cv=none; b=JnXe9QRLiBF8zKwAtvlhIG5msoi1FysbpeLP4Sp7ObBImIiPBHQoAORDp3sXv6NWZR5H3w7G0PQUoJE63gsnX7uVfCMsqwmMB3DVDzMBCWEGgo3n7jiISAI2eJ6964gK8bj9u3C9uE5NRH9wvBbcWYf03dd6JxHMMNV3pF7w29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593332; c=relaxed/simple;
	bh=LnCAmTJr89lAwx9RdlPpuQm1PdsRldlbYxWXejceaTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdAaYPYXpXB5ch1eiXCAih62AUxmL9/d9TnHOc7jhL/lsaUFc2NitFlZKMSdSheGZv3whrIqf8BBjOiBRqrMQo5B3Z+PvQlf/ObCrcE+LWRf7iC0pC3FxK8t83RwJkWx8iFyfU2Bm5Y27NoJOf7LMJDbhHeHpJ05tGvV1inkX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+pWdnDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646F9C4CEF1;
	Mon, 27 Oct 2025 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761593332;
	bh=LnCAmTJr89lAwx9RdlPpuQm1PdsRldlbYxWXejceaTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+pWdnDGbX4cmNVg4Qjw+Zlb/AHUZ+HsfIU00VxaGgYHtwZkWzLUfjhCc6suBPRL8
	 E22e+/mS9dQtZ+5pQDBeK9tsCgDNgGMPPrhuuBTESQQDxucnvuaT59buYq38Fu42eh
	 NGF+SO+8go9xojoWnNznSUUkk6V4kWzBqYfVbDoruaRyBdiKnNDYu37VskSStuhR0O
	 Iy3T3mnrDRA2YF2YXvIy5JPOTryrk2o1A2n4hHH9Qzo2j+P+8oH4PXcbABlnic1ojN
	 K3fUzyLsw/TF5gQrmzROdb6unoF9FdctHHIiNkXTGSNfLWZQfuS7Tm1yrDo2UBMgIz
	 krHLa/TVx8arQ==
Date: Mon, 27 Oct 2025 12:28:49 -0700
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
Message-ID: <i4o6cr4x364xsk7ftas5guggjt4xdvawurrohveahi75iba5aj@dl6plusoxtin>
References: <20251027155107.183136-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027155107.183136-1-thorsten.blum@linux.dev>

On Mon, Oct 27, 2025 at 04:51:02PM +0100, Thorsten Blum wrote:
> native_play_dead() ends by calling the non-returning function
> hlt_play_dead() and therefore also never returns.
> 
> The !CONFIG_HOTPLUG_CPU stub version of native_play_dead()
> unconditionally calls BUG() and does not return either.
> 
> Add the __noreturn attribute to both function definitions and their
> declaration to document this behavior and to potentially improve
> compiler optimizations.
> 
> Remove the obsolete comment, and add native_play_dead() to the objtool's
> list of __noreturn functions.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Is there an objtool warning that this fixes?  If so, it would be helpful
to put it in the description above.

And same for the other patch.

Otherwise it LGTM.  Thanks!

-- 
Josh

