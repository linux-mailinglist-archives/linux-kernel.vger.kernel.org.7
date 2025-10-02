Return-Path: <linux-kernel+bounces-840744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AE5BB5219
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B342484BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE042253F2B;
	Thu,  2 Oct 2025 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IP0NImhb"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AE1E5711
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437136; cv=pass; b=S5P15iI7O8447Ahao8k4CXYMoMqa1UslPY8eNzMx17GD0f5I0UPUdXgpHFAGbLHiltH1yWtSzqFsz5hbea8KJSlDML8LZzh06M0WBeGmc51HRJAS6gclU4xiFAtrR+6ed/14/M7XguhTSeGkxlboAShorCS+f31cQU17JyZt58Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437136; c=relaxed/simple;
	bh=NjFt9POZmKZtxILhFsv4Paq5wzzFbW3PoGLAUZXSFFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nC81AMMNen3vNwLulmP3wOc9Jsb0gj4iUQyaOXpvpU+FuM5Niv+0vd79L7JaxSeen/lNaEOj6G0bl+T/LnsWiA3lWmmJKO6WIXZXfz5s3WEErEkjyndcWQNJiEvFj/DzLbvYUYzwcJhcNyEmFrQgDJHjj6f7K8hsVcM9H19Qegs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=IP0NImhb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759437123; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hf0yNY6pev48pP3lvEFXwIcZXa7vqHM/nGQwRaZcgqryOJXtFGWejbHSrbRQ0E5GZ5rinHU96gEJOHmoORuVhmKfUf4zV1LCQoUrzJH4NPBeoVm0ngkarybKLRLvpukUPeJk8nfaOuPpRRGKr5eKgdoJCkuNHqhQkQMNcoTHgGA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759437123; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xXXabHF2wi/vPQGoTBb6Z4j9GeDgIGTwwWUPHpDInQs=; 
	b=RuiRRCXaEQ4+IuR/eyZVuS3Ufx2SWWm8tg+9hs9J0awRasjF+rpeH4YLqmd7ijgvuKFbc4/bl3KrvoyzeZEMxFBM4XqkkI9jpRH9u9t3+2GtKr9p7+1SJdlVjfayhTAXUAk1Nng8wCQuisyX9y40CveKASpWNIxIVSYFSyHblDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759437123;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=xXXabHF2wi/vPQGoTBb6Z4j9GeDgIGTwwWUPHpDInQs=;
	b=IP0NImhbmsb7jd5lr+1RBhaP/8ZJZJIwbhFDyoNGu7hEYQ6wB46GRBYglaAG6KFW
	5yhl1yolEyk2atTRZ0SRfUHR5NL1pRDPwAmIs8mS3+oysynKKkdCRQM0S9T4dAPPKwr
	JhLvBRjNrOP1rehsKmJnUSmkHKDhG7N2McM8VfMs=
Received: by mx.zohomail.com with SMTPS id 1759437121782218.431267913679;
	Thu, 2 Oct 2025 13:32:01 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Yury Norov <yury.norov@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, NVIDIA <YuryNorovyury.norov@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL] bitmap for 6.18
Date: Thu, 02 Oct 2025 22:31:57 +0200
Message-ID: <8170477.EvYhyI6sBW@workhorse>
In-Reply-To:
 <CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com>
References:
 <aNrm_14uJmGE7MYC@yury>
 <CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 2 October 2025 18:46:01 Central European Summer Time Linus Torvalds wrote:
> On Mon, 29 Sept 2025 at 13:07, Yury Norov <yury.norov@gmail.com> wrote:
> >
> >  - almost complete consolidation for HIWORD_UPDATE()-like macros from Nicolas;
> 
> Argh. I don't love this, but I've pulled it.
> 
> That new interface is a bit odd, and I had to wrap my head around it a
> bit, but it actually looks fine when it's a single bit or it already
> has a mask defined for it, and the end result is something like
> 
>         FIELD_PREP_WM16(BIT(1), val)
> 
> Yes, this is often longer than what it replaces, but quite readable,
> and I think it's a good thing.
> 
> But then we have GENMASK.
> 
> The macro from hell, that was a mistake from day 0, but then took over
> despite always being illogical.
> 
> It was so illogical that it had to have lots of error checking,
> because it always had the wrong interface and as a result lots of
> people got it wrong.
> 
> So now it has compile-time checking of the bits to make sure people
> get notified when they invariably get things wrong.
> 
> The only saving grace of that thing is that checking. I feel that
> often the *only* reason to use GENMASK() over any other alternative is
> literally that it checks the arguments so much because the interface
> is so horrific.
> 
> It does "high, low", which is often very unintuitive, and in fact the
> very commit that introduced this thing from hell had to convert the
> sane "low,high" cases to the other way around.
> 
> See commit 10ef6b0dffe4 ("bitops: Introduce a more generic BITMASK
> macro"), and notice how ALMOST ALL use cases were switched around to
> the illogical "high,low" format by that introductory phase.
> 
> And yes, I understand why that person did it: many datasheets show
> bits in a register graphically, and then you see that "high .. low"
> thing in a rectangle that describes the register, and that ordering
> them makes 100% sense IN THAT CONTEXT.

Hi, that person here.

My datasheets indeed show registers in the probably verilog-derived
high:low notation. An example of what that looks like is publicly
available[1]. The PWM hardware there is the same as the one I'm
working on for the RK3576, where I was motivated to finally address
the HIWORD_UPDATE copypaste throughout drivers. During this work I
discovered, and was told by others, that this is in fact more than
just a Rockchip-specific convention.

The HIWORD_UPDATE macros specifically had the issue that they liked
to deviate from each other, e.g. in argument order. This made jumping
between drivers awkward, because the same symbol could mean two different
things.

FWIW, I am also not a fan of GENMASK's high-to-low order. I do
however prefer it over bare hex values, but that's likely because I
can't really do hex math in my head. I don't know what 0x7ff << 1
is by heart, and I wouldn't know what bit would end up being the
first set bit there.

Since this new macro is decoupled from GENMASK however, I think
people other than me will find it to be useful. Macros that make you
think about whether your mask can be statically checked at compile
time will probably result in fewer people shifting a sign bit into an
awkward place without knowing. It already stopped me from doing
precisely that.

> 
> But it damn well does not make sense in most other contexts.
> 
> In fact, even in the context of generating mask #defines, it actually
> reads oddly, because you end up having things like
> 
>   /* Status register (SR) */
>   #define I2C_SR_OP               GENMASK(1, 0)   /* Operation */
>   #define I2C_SR_STATUS           GENMASK(3, 2)   /* controller status */
>   #define I2C_SR_CAUSE            GENMASK(6, 4)   /* Abort cause */
>   #define I2C_SR_TYPE             GENMASK(8, 7)   /* Receive type */
>   #define I2C_SR_LENGTH           GENMASK(19, 9)  /* Transfer length */
> 
> (Yes, that's a real example from the kernel), and notice how *oddly*
> the numbers flow in that series: instead of being a logical
> progression of 0 .. 1 .. 2 .. 3 etc, you have 1 .. 0 .. 3 .. 2 .. 6 ..
> 4 etc)
> 
> I really have an almost irrational hatred of GENMASK (note "almost". I
> think it's rational). I hate it so much that this almost made me not
> pull the end result just because a few conversions were just
> horrendous.
> 
> The very first conversion in that series does this:
> 
> -               mci_writel(host, TIMING_CON1, HIWORD_UPDATE(raw_value,
> 0x07ff, 1));
> +               mci_writel(host, TIMING_CON1,
> +                          FIELD_PREP_WM16(GENMASK(11, 1), raw_value));
> 
> and no, that new version is *NOT* more readable than the old code. I
> had to really read it several times just to understand what was going
> on, admittedly because the old HIWORD_UPDATE() macro was also odd.
> 
> But at least that old HIWORD_UPDATE() was odd in a "natural" way.
> 
> And it's all because GENMASK() is a horrible horrible interface, and
> should only be used for generating other #defines for actual masks
> when you read the datasheet.
> 
> Anyway. I just wanted to state how much I hate GENMASK(). It's almost
> fine for when it is appropriate, but this is an example of where it's
> very much not appropriate.
> 
> I wish we had a saner form for generating bitmasks with a better
> interface. The "high,low" thing is horrendous when what you want is "I
> want X bits starting at X":
> 
> Maybe we could introduce a new macro to go with BIT(x), and call it
> "BITS(low,high)". Yes, we'd have to replace a few existing driver uses
> of BITS(), but not very many.
> 
> Am I the only person who would find "BITS(1,11)" to be much easier to
> understand than "GENMASK(11,1)"?

I'm with you on that, but others may disagree. This is may be an
artefact of Latin writing going left to right while our Arabic
numerals go right to left, I think. Different people will have
different cutoffs for where numerals conceptually start for them
and where text ends.

But then again I also think the writel(var, addr) order is unexpected,
and `ln -s target link_name` is off, and if find(1) tells me paths must
precede expression one more time I'm gonna lose it. So maybe taste in
matters like this isn't tied to numerals at all.

> 
> Random "Linus rants" email over.
> 
>              Linus
> 

Kind regards,
Nicolas Frattaroli

Link: https://opensource.rock-chips.com/images/3/36/Rockchip_RK3506_TRM_Part_1_V1.2-20250811.pdf [1]




