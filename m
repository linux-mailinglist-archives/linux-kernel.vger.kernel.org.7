Return-Path: <linux-kernel+bounces-892976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465DC46429
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B8A188190F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D827306B05;
	Mon, 10 Nov 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bLhs95W/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED622538F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774055; cv=none; b=e4G3bNcZXH/fj/bPoncb1PScE+f/CCsNkEr9WcY1b+sUHpKgbPZQYtMXjKcG1mYtObolu/mB3IM78G4OpM3IUE6SV1LGQNqjiu7GeyI+9RPoGh3pfmUYvt4LHvbW9PQKSY0jQjgJvUALvf6k4KRauHe9BrhcRp7ghg3Rcouncz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774055; c=relaxed/simple;
	bh=jkOmmZrIAKvzRw6jHaQFVI+8IoifLKg0H8PIjeuWx9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui8IO5nRwUfCX/blz/0yJRsYpy4bc6EiUUkx3KFwV9i7QW7L9m/ScNe9WfiaqbuR2OKrfRMdE22bIxIzdsHSTxDQl2DKf1OC1U51SX95T55AL//82xdB3l2ivYmdJql0cgrW7egkwWAGOPPNN++oX8g5tC7F+ZgBBuWXzGBCIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bLhs95W/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF27A40E01FA;
	Mon, 10 Nov 2025 11:27:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NAiTqxELW6D6; Mon, 10 Nov 2025 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762774035; bh=QWgMfXoYBXjSYZ66KLBQMvY/lapHUz2YPyS91z8NS00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLhs95W/Y38hWFhNzrEO1KSToo747GdOwqzY6ycP3L0iJL40i3cGSgg3DRgK/LCFH
	 v/WIVVfuFPv9M9VpZRxT40A201WTeh0Am8AQ8kBifbAWiQQGX5oNAeyc2Yrnvog57H
	 MAa8wxhua2eN4DyeWLFiyk/wv9d0fR7HKJ+b2kCfRB14u3Ft9qvfEiHWK1W6vUEGl/
	 cDUchQp9ht8XccWmAHqji3kS+/hZg8gjBEhjBDHl/h151xxdWHQUPiZra/vBUTaEMT
	 PDxOODs8M1fDRHpE/HmYhKyl0zReEtJml/4Ye3eMgYvJ6Jfme1ZBrAKbxvxFg8Cu9/
	 xtyHvgLgMWjWdfpjlvMUzirjf/QsXXHeyqdMAJ2aCHbdcFM9i0MbpIG1+BWyVDQCyB
	 RVseuZj0IAO2RxcPkHpVBV2FkoDRu5vOW8qd3zOalzvfzVW7h+6djWaXbFlskU4HAK
	 UjZe6uo1KgsY0m0Eu3EYcT3UbYmCmHO2j6RViIf2qYhYGHWyO1pzTPyeV3yXu6EppO
	 HvONVpu4713wvF0bgjFriAMjtpGCNC1q291LO+eI+iHVWCtWe/jPVAtn12OIe2P5Ot
	 J4Hpju/asE5Perz/RCj7loiqu1aEQ8PqgIycmAK3Wf559DTX+3qVvSaLlt4t5N6T0k
	 d1g6myE5dYUbESrhkvCg4Tns=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3AB2D40E01FD;
	Mon, 10 Nov 2025 11:26:48 +0000 (UTC)
Date: Mon, 10 Nov 2025 12:26:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, peterz@infradead.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de,
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com,
	rppt@kernel.org, vbabka@suse.cz, x86@kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH 02/21] x86/mm/asi: add X86_FEATURE_ASI and asi=
Message-ID: <20251110112640.GVaRHL8GME4ODowica@fat_crate.local>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-2-2d861768041f@google.com>
 <20251025100642.GVaPyhMp4CEmsYW3xy@fat_crate.local>
 <DDSLTWM2FL58.3MIDS5WUOEEZW@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DDSLTWM2FL58.3MIDS5WUOEEZW@google.com>

On Sun, Oct 26, 2025 at 10:24:35PM +0000, Brendan Jackman wrote:
> Hm yeah, I actually also thought I had some direct feedback from one of
> the x86 maintainers saying not to expose it here. I can no longer find
> that feedback on Lore so I think I must be misremembering, the flag
> was already hidden back in [0].
> 
> [0] https://lore.kernel.org/linux-mm/20240712-asi-rfc-24-v1-5-144b319a40d8@google.com/
> 
> If that feedback indeed doesn't exist

Just ignore everything whoever might've told you or not - we override all
previous statements! :-P

From Documentation/arch/x86/cpuinfo.rst

"So, the current use of /proc/cpuinfo is to show features which the
kernel has *enabled* and *supports*. As in: the CPUID feature flag is
there, there's an additional setup which the kernel has done while
booting and the functionality is ready to use. A perfect example for
that is "user_shstk" where additional code enablement is present in the
kernel to support shadow stack for user programs."

So it is all written down now and is the law! :-P

> then personally I'd lean towards exposing it right away, I don't see that
> much downside in terms of ABI, since ASI kinda "doesn't do anything", from
> a SW point of view it's just a very weird and complicated NOP. It's hard for
> me to see how userspace could grow a functional dependency on this flag.
> Whereas for general monitoring it's handy.

The point is: once all the ASI code lands, we should show it in cpuinfo. As
in: "this kernel supports ASI" and not "there's asi in cpuinfo but well,
that's not the whole deal."

Makes sense?

> > Not an early_param() ?
> 
> Oh this is just for consistency with pti_check_boottime_disable(). But,
> I think that function actually exists because of init ordering issues
> that aren't relevant here, so early_param() seems fine to me (or, if I
> find some reason why it doesn't, work, I'll add a comment in v2 to
> explain why we don't use it).

Ack.

> Thanks for taking a look :)

Sure, np.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

