Return-Path: <linux-kernel+bounces-842220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BDBB941C
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 07:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14B0E4E1E85
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 05:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DABC1DFE22;
	Sun,  5 Oct 2025 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G27dcEQh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176EE6FBF
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 05:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759642113; cv=none; b=Ocw+0kNAqRLgM5Op5OtSRpfbsrkEwBi0YHnVKS2L1ezh7lY3Hj887C1xyU7SCYJRLz7xnHuhd2gjsbUMXxTsVKMPEgbK8TaCjA+vSEBAsADCORK823z8VFQsp9+svlRccuUduxmKQF3WivF5BV9ysbwzhkM47swxr2+RuRXkcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759642113; c=relaxed/simple;
	bh=lSQ8HAtiqRvKPWBUdmp32X4c9mOaWNkPum34eaq65nY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=elKCBBGq3ePVmSRxYWBJty+RZI0PwRLgQdpC44lSkHkUuYQBM/Usjq9sPZB7mFkdVB/v7dlOARSuvjPcoEnYW8+M0LHlaemf1rzMld9lAWxWcSPJhDw6PioDcvCPk/nP6IQZsd633aa7K6cBHb8JIFqDHF7lWZEDgjOkEc/sOo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G27dcEQh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3F38440E0194;
	Sun,  5 Oct 2025 05:28:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3TUA45zQHCYB; Sun,  5 Oct 2025 05:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759642097; bh=lSQ8HAtiqRvKPWBUdmp32X4c9mOaWNkPum34eaq65nY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=G27dcEQhBBh5P8KICkNcZJrmVIhmdkDtRPIJHQ3QzuLMKv1jW3stSGBPrhcdVrPBy
	 zksi2ZyQq6m3sEkEzz+W46oubhQksZhzA3Y4/1BsZUZfuONBJSj6i8AVZn64fp/j6S
	 RLsSuqQ7MslQL1B8i3RmOwgufXe8HA333L40K4JgCmUikRcCEfbirF02pG488f9Pjz
	 pCzB+M9tlOcdzWG4qULvN41Fx/ASZNh/qBvPTJOSEiVO6sFu7/ZLsyIqvsLNP5fmCg
	 uGPYRDquN6Vj2JjitjuhKGH5cYzJZSEZ1uBSOQs7c3CdnwgbKeUTnlpsxX8weHeN88
	 aY+Ob9IRhjtCfP9Uu+RfuodBneeRBIlZ74Ks8vZh5w/LuBnRAb5jSyV64AaYF7VvOi
	 G9XqEFDhZzfCjwyxrVxD2zWENl1Kdti1b3Uj3oKhdwFTBv8EzDRvYWsNhqMJ9K75hF
	 Qgj5MeTBuOI5D2bINKWTBnn/gA1b4i0BjQLwEAafvGhnACDK4JdyScaYu3wpRlm9xw
	 fsAC5U5DLSnpo2Eo47wXqx8jfpTk8ov7zgUKXaWxXVN/9JgX22bhYNRjtrzXIhAZaf
	 171+OX7BaMeqURrGhqFH7qw/buElXLmlV9Q0oEKF55+BFZ3Nw61Nao+kd7jbUK81lo
	 paNadokGw55LeRKbinbcX8Ow=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3035:e62:bf7a:f880:d6ab:37f8:f6f8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34CD340E00DE;
	Sun,  5 Oct 2025 05:28:01 +0000 (UTC)
Date: Sun, 05 Oct 2025 08:27:54 +0300
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>,
 Xose Vazquez Perez <xose.vazquez@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Alex Murray <alex.murray@canonical.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86-ML <x86@kernel.org>,
 KERNEL-ML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC=5D_x86/microco?=
 =?US-ASCII?Q?de/intel=3A_Refresh_the_revisi?=
 =?US-ASCII?Q?ons_that_determine_old=5Fmicr?=
 =?US-ASCII?Q?ocode_to_20250812_=28Aug_2025=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <8826a146-ba01-4f97-9fc5-7bf42c1e768d@intel.com>
References: <20251004222528.119977-1-xose.vazquez@gmail.com> <8F0DE1AD-5532-4581-9716-581FB2777404@alien8.de> <8826a146-ba01-4f97-9fc5-7bf42c1e768d@intel.com>
Message-ID: <F5790843-AB8B-4E07-8A62-5F777249CFCF@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 5, 2025 6:58:05 AM GMT+03:00, Dave Hansen <dave=2Ehansen@intel=
=2Ecom> wrote:
>On 10/4/25 19:42, Borislav Petkov wrote:
>> This is turning into exactly what I was afraid and I warned it would tu=
rn onto:
>>=20
>> 1=2E https://git=2Ekernel=2Eorg/tip/952df63ef426b21d6da14bb48748f12b0ae=
2fe36 - we *just* updated it and there's already a new one
>>=20
>> 2=2E Random people - not Intel - are going to be sending updates too=2E
>>=20
>> This is a mess waiting to happen=2E ;-/
>
>In the end, we've got an lightly documented patch that doesn't make a
>lot of sense to apply=2E Not exactly a unique situation=2E ;)
>
>Xose, do you have any specific, practical reasons this should be
>applied? Honestly, I don't hold the "HIGH" Intel SA rating in super high
>regard=2E

That's the problem=2E It'll be needless and endless discussions of the sor=
t: oh, why do you need to update those revisions? But but, I need this and =
that=2E Oh but you don't=2E Blablabla=2E=2E=2E Upstream has these revisions=
, why aren't they backported=2E=2E=2E?

Versus: people should always update to the latest microcode and we're not =
tracking this in the kernel because there's really no need to=2E

And none of those issues exist anymore=2E

This is one of the reasons why I'm making sure the loader always works and=
 is very easy to update microcode=2E You always update and that's it=2E

So you don't need any of that unnecessary work=2E

Thx=2E


Small device=2E Typos and formatting crap

