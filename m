Return-Path: <linux-kernel+bounces-720253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181A7AFB91D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE044A649E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA6322F764;
	Mon,  7 Jul 2025 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eEIItSYk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WX6Rwkjs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF16227EAA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907110; cv=none; b=Gm6aLkvkN4yTKciiU+8QYPHSKtoj77A5CdcQJLwuMl0DgVOxczyTCncnFwg+n/2BL/RfTPNuKYZ1rB3oxdlCKYGsyp5ofucKzqsxO6awIU4R46hESpeLSojUhHNNCNeiPw2n6hGwVlmMyhVwkaCWG7h5fSz/93ec6NH1vXBi/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907110; c=relaxed/simple;
	bh=06MGt39LsqGSUhPV94+hP4L8EkX+7nMB0woh5SXVhY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmdsSylb8NoR540KSizm6Im21qtu0F1DdsbbLALeEJ9cBKkdiU53uCi8PKmsnWw7yB35rfVQKaunhECaYpcbqqOMOkHd9WsK/fiRLjeAf5EcVQ2SUn2baSCl0hYDNY5YhzAR7qk+JvkFiBBdWd8nOqdmQNsqkCEhhm3+cDxvg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eEIItSYk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WX6Rwkjs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Jul 2025 18:51:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751907107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/LOiAvJ72lpg6zVQ7UqekT6IMCqQe42xPEKSqzYEjo=;
	b=eEIItSYkf3kuxJc5fKC/8LY6qpD/XV6mtOt1ghF+XupNyBzX9UC1BEWvf/h5ZvTLyCfLtq
	+VGZlMYMyMuHKMZXAKWNTUsl1vzxUjiFAYjDY+SORbX4TXCOShk0yrpjWOBaBHHsLCuP+c
	uVHSwI7YG4ifX9+sRp6DxASKqzRQgGLeo7jRoc63PSx6/nxKjnpdjzyPo1vG+lCIyNXAfo
	O/aV7PIYydGgTFT5ipsJy438WS0hC7amyWdlDQTD8l7Ef+TOtwZSd+V3r4rd7nyWy0S+Gl
	bF5qAup0su4tSgtZCRLmSs8f7bbGxvkCeg9bKukVWVzpMwT+RAy+nVYndKk91A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751907107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/LOiAvJ72lpg6zVQ7UqekT6IMCqQe42xPEKSqzYEjo=;
	b=WX6RwkjsxuvXp5xu/qIIboGbGxIhwRiIThApdDPjKUCU8k54UCHuNVT+wQLH85PvZcE7Lk
	kxySsqZAs0Abg8Bg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/44] ASoC: Intel: avs: Include CPUID header at file
 scope
Message-ID: <aGv7IZmcqiYSU4My@lx-t490>
References: <20250612234010.572636-1-darwi@linutronix.de>
 <20250612234010.572636-3-darwi@linutronix.de>
 <da5bf77b-5bdb-440f-92b5-db35d8687987@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5bf77b-5bdb-440f-92b5-db35d8687987@intel.com>

On Mon, 16 Jun 2025, Cezary Rojewski wrote:
>
> The existing location of #include isn't my best work, clearly. Thank
> you for addressing that, Ahmed. For the avs-driver bits:
>
> Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
>

Sure, no problem.  Thanks for the Acked-by :-)

