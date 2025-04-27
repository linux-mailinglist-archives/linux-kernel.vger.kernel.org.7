Return-Path: <linux-kernel+bounces-622252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47798A9E4AE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 23:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7BB3B6E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45021E7C2E;
	Sun, 27 Apr 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GkFvbw7Y"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698632701C4
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745788708; cv=none; b=j11LSzFQHEZ7K7qo1nKgM2UbsbrzT0wtfDMq1yqr1sNfdXVSgbB6n+XIMuUMxLxFAOhceSbOWJMR7GKfdylogiRESIJpUtEkN4oAzyVTkees1ny7MwqjqdU76R3LIa8YbWcFko32xy2lphiFZlOJMe4C/GU4aMlJ8t1Ax2s/nxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745788708; c=relaxed/simple;
	bh=fWMtqJihhAL1V/siSnMyi4JDsF99tVmAT6A4RAg9yYw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Mfs7l6ZPsUNGZcXwVhqWoTbX23Y7MQG1VC+7ubaOI+Jj3t/9W4VHlIJuapJR1XRLggcKh3ltwYawRyMF7oNUY6anjEhQ0IOYXJpQHHDry/mdNG/YbZZxzWtKehIWIduTzasSooYnHYtkx2nid7AdZA5HvyEsmrWED11s1Qu5q50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GkFvbw7Y; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53RLHijD2366687
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 27 Apr 2025 14:17:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53RLHijD2366687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1745788666;
	bh=Ef+g//iaW9SBhRKXRgfhdG7gKtyYpx61dluDthiBNSs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GkFvbw7YIOrLDqxC8dr0MMnVn9SzT4F34CTnlxGX1qcHDO6jHfU+02Mm7CssRL1Aa
	 F9VROzOYsUKuUFtT+KA2MMRDxZkJyM9JllYxtKmZ41kApvJIHNa99YbajQ8UVMjkeO
	 I3QpXox8HpeQE6XvhBkFquJ7/gyExhh7MANSItFgrgwsMi6y/TTAkwRI05gqg7XiBD
	 RJ1LfjajQnxHE7jR2nLx3U2PIHFldZYe7n7QPyyjRPcRdqMPrwWOZNkX+CEUJStIs/
	 QMRoq5Xzof3PMtG5Lc8wFDBaX6N/OfBx3AMYF3X7KOHUvVmFj/kfOGNYLUJH2fMkdS
	 UGwfrYa8h3YTg==
Date: Sun, 27 Apr 2025 14:17:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>
CC: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] [RFC] x86/cpu: rework instruction set selection
User-Agent: K-9 Mail for Android
In-Reply-To: <0fc64201-03cc-4c3e-af86-7ef11c3505a0@app.fastmail.com>
References: <20250425141740.734030-1-arnd@kernel.org> <aAyiganPp_UsNlnZ@gmail.com> <d2b0e71c-e79b-40d6-8693-3202cd894d66@app.fastmail.com> <aA0vft1cPuvzdZvJ@gmail.com> <0fc64201-03cc-4c3e-af86-7ef11c3505a0@app.fastmail.com>
Message-ID: <E0609153-438F-4665-9291-CC848F3BE58B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 27, 2025 6:24:59 AM PDT, Arnd Bergmann <arnd@arndb=2Ede> wrote:
>On Sat, Apr 26, 2025, at 21:09, Ingo Molnar wrote:
>> * Arnd Bergmann <arnd@arndb=2Ede> wrote:
>>
>>> CMOV is missing not just on old Socket 5/7 CPUs (Pentium MMX, AMD K6,=
=20
>>> Cyrix MII) but also newer embedded Via C3, Geode GX and=20
>>> Vortex86DX/MX/EX/DX2=2E The replacement Nehemiah (2003), GeodeLX (2005=
)=20
>>> and Vortex86DX3/EX2 (2015!) have CMOV, but the old ones were sold=20
>>> alongside them for years, and some of the 586-class Vortex86 products=
=20
>>> are still commercially available=2E
>>
>> Very few (if any) of the commercially available products will run=20
>> modern 6=2E16+ kernels, right?
>
>No, at least not in absolute numbers=2E As far as I can tell, the RDC
>SoC family is the only one that is still around, after Quark, Geode
>and Eden were all discontinued around 2019=2E
>
>There are multiple known RDC licensees (DM&P/Vortex86, xlichip) and
>probably a few more with custom chips=2E They lag behind Intel and AMD
>by about one patent expiration time, and maybe a decade behind Arm
>SoCs, so they only just arrived at quad-core SMP, LPDDR4, and SSSE3
>instructions and have announced upcoming 64-bit chips=2E
>
>They do have super-long support cycles, and there are a few markets
>that absolutely require kernel updates for many years, so I would
>still consider the 586-class embedded chips more relevant for future
>kernels than 30 year old PCs, and the 686-class embedded chips
>more relevant than 20 year old laptops=2E
>
>> Note that the real danger the 32-bit x86 kernel is going to be facing=
=20
>> in 2-5 years is total removal due to lack of development interest, but=
=20
>> I think we can support 686+ reasonably far into the future, and can=20
>> keep it tested reasonably - while covering like 99%+ of the currently=
=20
>> available 32-bit-only x86 products on the market=2E The fewer variants,=
=20
>> the better=2E
>
>I agree that this is the endgame for x86-32 and that eventually
>the while thing will be remove, and every simplification helps, but
>I still don't think that removing 586 earlier helps enough to
>outweigh the cost here=2E
>
>The situation is similar on 32-bit Arm, where we currently support
>armv4, armv4t, armv5, armv6, armv6k, armv7, armv7ve and armv8-aarch32=2E
>Removing armv3 a few years ago helped a lot, removing the extremely
>rare armv6 will help as well, but there is little value in dropping
>CPU support for v4 and v4t as long as v5 is there, or v6k and v7
>as long as we have v7ve and v8-aarch32=2E My guess would be that we
>can remove armv4/v4t/v5 at the same time as i586/i686 and
>some other 32-bit targets, followed by armv7/v7ve/v8-aarch32
>much later=2E
>
>       Arnd

"Commercially available" doesn't mean "binary distribution=2E" There is a =
whold world beyond the desktop distros=2E

These kinds of systems run embedded stacks that are at least in part compi=
led by the appliance vendor to allow for higher configurability=2E


