Return-Path: <linux-kernel+bounces-837301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C8BABE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B60818934D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE182C178E;
	Tue, 30 Sep 2025 07:53:00 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154F2BEC34
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218780; cv=none; b=AR+ohhnbr/6dOWRbfbQfTOvcsknSUnWIGnRG0K7bnqcVzMHZatzZpw7hGI92B1fQyuOye1ehJHdjvXKLARHUnpkICucfaqA+zN/i8qpm3k+uWdI4aJqV1OdDWhk/DkqUuMZ5LkJdkjz+kubv1bCTnQdVI5Niwi3NGwsQXu9eGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218780; c=relaxed/simple;
	bh=Ks2i8mOpB744eUk2A/ODTB+R+UAfytF25Eq134pKwt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmrK856+XRNepvC6UX4/oiXbsajFuuAj6cn4HThKB8vDrFTETtEVreex6xCKp4JGlf5c2Q6xGXJVn/DX5bhFhZO1CHEd17KE6hduMbScyrmgP4p1Auu+/nFu/8iF5CWNFxkPBnZj+ZQHxmiKpQk6se4gcEaKqeZ1iYhDqtBMrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8e32821b5bcso1899092241.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218777; x=1759823577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aa5DrkK9lamemzbezkeJMzZtq5kF5RPmPk7WlbJcb3g=;
        b=ln2EGufBlh51eA5scRNHNkNrwmUOPtbUSaBzNRbl9SAST2ycR7aWVx+iAdXTvjTANJ
         v5tsSlY38I+mmqRj/UzRxRD47hrev85D1hJjYOqj6UnRixGha5744b6YbYfnyL9mj7Tu
         SQaAxQDz1IlsTj0KlPfzDmtFULzvby7QseHnBzj2vitWpzQ2Fic5QLR3GrF0N0uXARbz
         qytvXmiZx9C988XZw7fUtX6Y6saq3ZwsrCOWs/7qJtkncfFe66ZgP4SnAQroFAf7iK8U
         FJXdNwQRB1jweryL/vq3aJ/Z5jb2IE2q/9AXGMW6bVdOk4L2+PjdsqpmE0FrpHhO4u8K
         kHiA==
X-Forwarded-Encrypted: i=1; AJvYcCWDncKx9F4CGZpjJhWJxptcDro9AoNF8QChobsFqqaQVzCFnZtofju0ENN2+f7k24q2xAXatqgKsY4Q758=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7FUeGLkFFKuqqfAJyi+ySuQ4k9qp3ltb8SasbxDBevPi0Wug
	VzR1sXYqGAKUsbXLU1Zis00c60ls7w2j2eU4bvJwpphjFEh0V2yhMi37TExDkGvt
X-Gm-Gg: ASbGnctrHoqgFoZaLe0NUlubvwWCNDGAKLsPj2ikm4lRi64iKlAYOHXWEi+bfECZkSW
	65jZ2NvmUEoLAgE1GwzzRlrGxzIx4ofTw+hTQk/cynRr/+ZxzaWhJW9G6i3ful1SwCECNIiclG5
	tMl0sK61wRqDUe//jkT4g2zyyrWOhSD1ZI0iH+ptk1DbgFRB+BrNtL5fYPemRDHmOJK0QAyaSLZ
	o2l93IZjaR3NN7A/A29t8tBs/t2Yvdg4+ZOYHUkivUAWrs+BDJta7XDZpSbmpCxyIpTKWXO6M+a
	QWQ1vwxhfDtWzyMHYpdrl8nx0uumzxVzUOfD8P65EvPRITf3G6/hM7mrF/eacvZyFaBG+vxv9Gp
	w71omnwPowa1KC/Xfm3BuJr6OJ79IRI/tp/SWkWBdrBO/f3Ma0ufM86FuD6a8vjY0hLjOAgZrnG
	JXs4Rcntp6m1yCajQyXJw=
X-Google-Smtp-Source: AGHT+IHnI4ap3n0lmrzky3xM0FcYE071xUcOtI3gnkWO+Eft4bR2O3gzFrejWCO3avJxQPlTwUS7aA==
X-Received: by 2002:a05:6102:e0a:b0:525:33a9:c71 with SMTP id ada2fe7eead31-5acce75ac3emr6958579137.24.1759218777244;
        Tue, 30 Sep 2025 00:52:57 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5be147da365sm2358689137.9.2025.09.30.00.52.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 00:52:56 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8e32821b5bcso1899082241.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:52:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX75wDI5Ky2oOSBGCrNqpt38I5YqjsT0ltwFke3Mzv66cL7RdOuImNVImJmxi5kZOtXjG+ZUK/sOsggq4U=@vger.kernel.org
X-Received: by 2002:a05:6122:3c92:b0:54a:a5ac:5107 with SMTP id
 71dfb90a1353d-54bea256dccmr7837048e0c.15.1759218775649; Tue, 30 Sep 2025
 00:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916084631.77127e29@bootlin.com> <aMt5kEI_WRDOf-Hw@zatzit>
 <20250918094409.0d5f92ec@bootlin.com> <aMzhgDYOuG4qNcc0@zatzit>
 <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org> <aNJVqSpdAJzGliNx@zatzit>
 <20250923114849.2385736d@bootlin.com> <CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
 <aNNvaN4xJtKBFmWT@zatzit> <cd9763b7-919a-4b44-a347-f1491d9584b9@beagleboard.org>
 <aNtXnAeLj3xNwkyE@zatzit>
In-Reply-To: <aNtXnAeLj3xNwkyE@zatzit>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Sep 2025 09:52:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+sUZpMtbCtWqJMiL_JC_nFEJcFDOoZJZPhhzhY8zQJQ@mail.gmail.com>
X-Gm-Features: AS18NWCn2Nf_ET6vEoGNsB6ZKan8jeS0YTKv9inR2GremBjiwmJIe_zbvyBIsgE
Message-ID: <CAMuHMdV+sUZpMtbCtWqJMiL_JC_nFEJcFDOoZJZPhhzhY8zQJQ@mail.gmail.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion at ELCE
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Ayush Singh <ayush@beagleboard.org>, Herve Codina <herve.codina@bootlin.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Andrew Davis <afd@ti.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org, 
	Jason Kridner <jkridner@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 30 Sept 2025 at 06:34, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Wed, Sep 24, 2025 at 10:33:50PM +0530, Ayush Singh wrote:
> > On 9/24/25 09:41, David Gibson wrote:
> > > > On Tue, 23 Sept 2025 at 11:49, Herve Codina <herve.codina@bootlin.com> wrote:
> > > > > On Tue, 23 Sep 2025 18:09:13 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > > Ah, right.  To be clear: we absolutely don't want multiple addons
> > > > > > altering the same nodes.  But I think we could do that in ways other
> > > > > > than putting everything under a connector.  This is exactly why I
> > > > > > think we should think this through as an end-to-end problem, rather
> > > > > > trying to do it as a tweak to the existing (crap) overlay system.
> > > > > >
> > > > > > So, if we're thinking of this as an entirely new way of updating the
> > > > > > base dt - not "an overlay" - we can decide on the rules to ensure that
> > > > > > addition and removal is sane.  Two obvious ones I think we should
> > > > > > definitely have are:
> > > > > >
> > > > > > a) Addons can only add completely new nodes, never modify existing
> > > > > >     ones.  This means that whatever addons are present at runtime,
> > > > > >     every node has a single well defined owner (either base board or
> > > > > >     addon).
> > > > > In this rule I suppose that "never modify existing ones" should be understood
> > > > > as "never modify, add or remove properties in existing ones". Because, of course
> > > > > adding a full node in a existing one is allowed (rule b).
> > > > What if the add-on board contains a provider for the base board.
> > > > E.g. the connector has a clock input, fed by an optional clock generator
> > > > on the add-on board.  Hooking that into the system requires modifying
> > > > a clocks property in the base board, cfr. [1].
> > > > Or is there some other solution?
> > > Hmm.  My first inclination would be that this case is not in scope for
> > > the protocol we're trying to design now.  If the widget provides
> > > things to the base board as well as the other way around, it's no
> > > longer an "addon" for the purposes of this spec.
> > >
> > > But it's possible I've underestimated how common / useful such a case
> > > is.
> > >
> > > Note that I'd expect the existing overlay mechanism to still be
> > > around.  It may be ugly and not very well thought out, but its
> > > drawbacks are much less severe if you're not dealing with hot unplug.
> >
> > Well, while that was not an initial use-case in my mind, external clock
> > inputs are a valid use-case when talking about connectors for board headers
> > specifically (e.g. pocketbeagle connector).
>
> I guess I'm not familiar enough with modern embedded hardware.  I'm
> having a hard time wrapping my head around what's going on here.  If
> the external clock input is optional (hence under a connector), how is
> anything on the base board dependent on it?  If nothing on the base
> board is dependent, why do we need to modify its properties to
> represent it?
>
> Is this a design flaw in the clocks binding?

In my example, the external clock input is indeed optional, and not
used by the base board itself.  Still, it is a clock input to the SoC,
and may be used as a reference clock when an add-on board is connected
that needs to use the exact clock frequency of that reference clock.

https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/renesas/white-hawk-ard-audio-da7212.dtso
AUDIO_CLKIN_V is the optional clock input to the SoC.
GP1_25/SL_SW2_V/TPU is the reference clock (actually it is not
generated on the add-on board, but by a PWM controller on the base
board, but it could just be a crystal oscillator on the add-on board
instead)

I hope this makes it clearer.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

