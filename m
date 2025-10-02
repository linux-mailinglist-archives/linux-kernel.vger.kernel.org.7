Return-Path: <linux-kernel+bounces-840516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC45BB4964
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47C824E1866
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6363723E342;
	Thu,  2 Oct 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a7AVwFKp"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDB236A70
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423583; cv=none; b=bVtNo296IvIs+HuVIrd7GQL09nVLXTLe5t3+VJq+4GoM4RfEURNOxRd0yYciPJ8MePgejXm0yS9lGYnLRL8yKr/UWnuR38cTyH/3qAj02rs2/nFCLTrMRtLgp4XUT3wp50Oyga16dH/GQMvD8nQKRvw6+XbbnZkjgiJbBH9dUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423583; c=relaxed/simple;
	bh=QLyV/yM++26FneUT3uH4L6P1odlqjQgGMfZW6jkOWbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGJUl7wSn2ZUlDJiWz++5rsOp4AWwDv6Sov39WbuXRy/yVYuV2FAodTRWCPbgCizxcBdBz7cD3asBzZgSIVs4pUbyuiiYX8zVm4h+aPd2xxAWXfAX/YpGqWcf3knZBQvzkoJ8n4hnn4XLhToLXyV4DfpKAgVEXC5FCnyJgYQHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a7AVwFKp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78ead12so245778666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759423579; x=1760028379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vzsEhVXUVbwA+f8Wq3Hi/pcxlbcP2wMVdzZNvAfvdM=;
        b=a7AVwFKpqR7KkJwKZkk68xiuJaWXdTFYlFcTgogE9RPQcaQdmuK2HGzUFejVWyzRKC
         0VbbmwweiMOyqOHvDR/sWiOrd+SoJHEtPOk8QMOe3TT/J/6JUcZvhAQh+Zwzoy1bPLsF
         ahBgnmJsrZ2KRJVi8RuWjDpQ5t3KvQh+kszqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759423579; x=1760028379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vzsEhVXUVbwA+f8Wq3Hi/pcxlbcP2wMVdzZNvAfvdM=;
        b=m7pJP/S9xYnwNkBk4KjUo5KCqLTRckuKhTqE4s4Icotuoc2RwS2CNPgiB3HY9qUDZf
         WXu+TtkNdIvaGp7ZB7nFZB4eWK4bo9x/1HbHUir4p52qDaBvwwP+wGrxsyBF0x458Ndo
         h+fTWczFzoNKJnAHbKhJW3JVaaL+QPPXBbd5OfWp+Im7H69L1jh/cRBWkn9zO7l1XkSD
         JYkduSxDelfs2SSH/VNezO9kBwWOs4juQCzv+T4KyndNS1rITY45OUYdNjOXHmlqIy0c
         Qx4B9WCQzXMF/TEYxonJBr/4ldFbIUpIuY0WWn7l5d/gXa30HXXpfy5mp/HDGVgWigf8
         MYWQ==
X-Gm-Message-State: AOJu0YzKxXBmJEchoeX1DgtLh3YAIb22X+ifAwTGlcVn2m4xvpYs53jX
	aQk+qcRSTPAR1uGZbWymHoxzL54a7ERncF83EzX4AIaTEeGCO0f+SctEQ263BWInhxEP88m7zVL
	eXsNY2lc=
X-Gm-Gg: ASbGncsUpA6dfYDl35a50w9mMAYEggliYtN5ypoU5vAttNrjBu904DeYgfzi2zU5Y1Z
	oKQzRZva7az56rYvS6IoxOy37fu72LSRDNpF/mkhxKcI4QK/2Quilc18EUD+9HXpA6GaSgm1jCL
	CO4PU6l+J9duzhkK//gix7ANMHr2KpUz6dqco9LpZqNBeI558qmwJwS8JQ56+FW4NPSIbarYhNY
	4AtqJRlwIHvDnzl8uLeeFAjs+aheE/CmFdxYptVsXRvyYQ3xytK9kRHcITeZa/mmcEdkwJ58p5d
	7JqIs/b9093SksLGelfeyG9r2qeqZg/0/RvHlV/wlUViDDkE6c5ffN0Barv1PnWTFNmz67JY87V
	c7Lh0d3tR1LoICZDGP97ZWEttXXUaodEm6jhXNo11kH+fvkR6OdVWOAj3TxvYu9E7bGS2oBPwUH
	ChkOqTFLFqW1kUfADSTVFyCt6rE8Ecqrc=
X-Google-Smtp-Source: AGHT+IE6BOvu8qWRRgRzeEXx3IAEDPc9NYOl+xiSZOx3+jBZdtiGbP+yxGxdTZ//HMzEV4NUYR/5Eg==
X-Received: by 2002:a17:906:eecd:b0:b3f:f6d:1dae with SMTP id a640c23a62f3a-b49c1d6150emr13943066b.12.1759423579229;
        Thu, 02 Oct 2025 09:46:19 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa637sm236970666b.12.2025.10.02.09.46.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 09:46:18 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so213996266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:46:18 -0700 (PDT)
X-Received: by 2002:a17:907:1c1b:b0:b42:9840:eac1 with SMTP id
 a640c23a62f3a-b49c4393389mr10071766b.49.1759423577719; Thu, 02 Oct 2025
 09:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNrm_14uJmGE7MYC@yury>
In-Reply-To: <aNrm_14uJmGE7MYC@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Oct 2025 09:46:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com>
X-Gm-Features: AS18NWDTSnffJM68wOZw79kbKNNh0jg-232_U3V11UlxV_WYxRiq56cGPnOaxk0
Message-ID: <CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap for 6.18
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, NVIDIA <YuryNorovyury.norov@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Jakub Kicinski <kuba@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 13:07, Yury Norov <yury.norov@gmail.com> wrote:
>
>  - almost complete consolidation for HIWORD_UPDATE()-like macros from Nicolas;

Argh. I don't love this, but I've pulled it.

That new interface is a bit odd, and I had to wrap my head around it a
bit, but it actually looks fine when it's a single bit or it already
has a mask defined for it, and the end result is something like

        FIELD_PREP_WM16(BIT(1), val)

Yes, this is often longer than what it replaces, but quite readable,
and I think it's a good thing.

But then we have GENMASK.

The macro from hell, that was a mistake from day 0, but then took over
despite always being illogical.

It was so illogical that it had to have lots of error checking,
because it always had the wrong interface and as a result lots of
people got it wrong.

So now it has compile-time checking of the bits to make sure people
get notified when they invariably get things wrong.

The only saving grace of that thing is that checking. I feel that
often the *only* reason to use GENMASK() over any other alternative is
literally that it checks the arguments so much because the interface
is so horrific.

It does "high, low", which is often very unintuitive, and in fact the
very commit that introduced this thing from hell had to convert the
sane "low,high" cases to the other way around.

See commit 10ef6b0dffe4 ("bitops: Introduce a more generic BITMASK
macro"), and notice how ALMOST ALL use cases were switched around to
the illogical "high,low" format by that introductory phase.

And yes, I understand why that person did it: many datasheets show
bits in a register graphically, and then you see that "high .. low"
thing in a rectangle that describes the register, and that ordering
them makes 100% sense IN THAT CONTEXT.

But it damn well does not make sense in most other contexts.

In fact, even in the context of generating mask #defines, it actually
reads oddly, because you end up having things like

  /* Status register (SR) */
  #define I2C_SR_OP               GENMASK(1, 0)   /* Operation */
  #define I2C_SR_STATUS           GENMASK(3, 2)   /* controller status */
  #define I2C_SR_CAUSE            GENMASK(6, 4)   /* Abort cause */
  #define I2C_SR_TYPE             GENMASK(8, 7)   /* Receive type */
  #define I2C_SR_LENGTH           GENMASK(19, 9)  /* Transfer length */

(Yes, that's a real example from the kernel), and notice how *oddly*
the numbers flow in that series: instead of being a logical
progression of 0 .. 1 .. 2 .. 3 etc, you have 1 .. 0 .. 3 .. 2 .. 6 ..
4 etc)

I really have an almost irrational hatred of GENMASK (note "almost". I
think it's rational). I hate it so much that this almost made me not
pull the end result just because a few conversions were just
horrendous.

The very first conversion in that series does this:

-               mci_writel(host, TIMING_CON1, HIWORD_UPDATE(raw_value,
0x07ff, 1));
+               mci_writel(host, TIMING_CON1,
+                          FIELD_PREP_WM16(GENMASK(11, 1), raw_value));

and no, that new version is *NOT* more readable than the old code. I
had to really read it several times just to understand what was going
on, admittedly because the old HIWORD_UPDATE() macro was also odd.

But at least that old HIWORD_UPDATE() was odd in a "natural" way.

And it's all because GENMASK() is a horrible horrible interface, and
should only be used for generating other #defines for actual masks
when you read the datasheet.

Anyway. I just wanted to state how much I hate GENMASK(). It's almost
fine for when it is appropriate, but this is an example of where it's
very much not appropriate.

I wish we had a saner form for generating bitmasks with a better
interface. The "high,low" thing is horrendous when what you want is "I
want X bits starting at X":

Maybe we could introduce a new macro to go with BIT(x), and call it
"BITS(low,high)". Yes, we'd have to replace a few existing driver uses
of BITS(), but not very many.

Am I the only person who would find "BITS(1,11)" to be much easier to
understand than "GENMASK(11,1)"?

Random "Linus rants" email over.

             Linus

