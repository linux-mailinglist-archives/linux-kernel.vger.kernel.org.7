Return-Path: <linux-kernel+bounces-880605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85441C261E6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 829CB4F41A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE59283C89;
	Fri, 31 Oct 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9UQI5y6"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4934279792
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927920; cv=none; b=J15wNNBz68nuwZhq1h9noJr+vcGBaU4/vXgnY+L88OmRSFK5OyvHqXopDTLxORCL9cWfWXt/nVfsWZJfXwPliB3i09kW6V+v6TQGlS1fjBq3k3Z3bvBWM67mS1D9CrkA2s092+67H9gfaVtrOOvIs3kay4PjruPIqdXOfLisgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927920; c=relaxed/simple;
	bh=8RX6Dbpiq3dCPXxN/J33SXBc20l/3zBbyGrlOyx9sZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyY5oc975K+27SRWR+z9gbeBtyGVidaD4oJOZ13RfR7jDAzmGhtuw6+ew6hYJsbQ2XgBzHLDFkupK1dIJGTlaQkY0PAw1xNhUIyq57+dQ91M3wctE0HS+xQhbQW1M7rHBJ3YYexHSlQTnV6q604AGGm5REnK70IHB+hJIXULYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9UQI5y6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6408f034513so433151a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761927917; x=1762532717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpYe/7mq49sINy5nrhbkqdvXniyS9DNZSIVJcYyqnRE=;
        b=U9UQI5y6Pagk3mHe5vp3mpp5Ep4VGvnbWVjyeCBNa2ZaHGBuDMZGvdNeDdymCFuBnK
         iPM3YLQ68bdK60vfJZQ+WXfl5Y5JJ20t4F/JoZU7L1HmT24LYG4xEpOq87JMuT53/RD5
         y72oWuNWfhLdlW5Aag8K5rCsmwOJc0w0fNYaVn71Ex2hWml4qpUGjFw1N2GcqGYvntPR
         g+9+M9Ct3I3gyKjmD8HpF0UJrLktemUA3bxaiVX3Q3TSKKj4DwtIfmDKJAyuUb4ChNdb
         3rDeaZqoOZxpxUkYKrbffz4M9ISRJCycNye9quRBMgSfdpvrh6rCsLfTVPLtZPpnUbwo
         PBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927917; x=1762532717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpYe/7mq49sINy5nrhbkqdvXniyS9DNZSIVJcYyqnRE=;
        b=IocaNEb0c7MDftvvf98z0Z5gbHBGYOqUtpinggy2VDQd6EuAMWDeMAeqbjZQz9NwX1
         Rz07bpDKNdDh3JlyM3QBWrYmVNmBjOhCvBbkx9yJQ4ZWrq/4HlfLHgZrCsMRmbyJIEGb
         fQ7FzontE6U1lbo2fHtjv6fnjT/v3c2gLb1+VuAVY4Feg9dtMR805slVOI/UeiCofEGV
         IriepwPVma8vMNfJW40EFT6vmFqsHsO2vNDlKJjgu7kz+ZFeDieOk4irFhuJgmhh3g6i
         G3en9xejbNDAECFdD7WHz4Q1563FKtmrrbRMHByd2cRPKgLrRIJcRpMYPFy8Dr5slZQR
         1Etw==
X-Forwarded-Encrypted: i=1; AJvYcCWnAu1mB/rmHynpLGgA84gH1cYDpol/HVzVroouj129Y9B42d6NDtQLBuKNHIvEAxXUR9OJ3kjVXZaL8ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLtexH2ytm3u0woDV81SPUnI1ofXKBDB6T/P2MVeD/He63vNj
	shHn3Or3G0hxjF2+WSJK8jvDt1wsZSagFXV1HSLTotXy+4gymhwde1RAhtk3HVdUHuqClVwRHax
	5y+ELnFDE/TzhgKzAktjdpTfNH2RCXsk=
X-Gm-Gg: ASbGncsPPRiGMNJ+fVzWZ7lY/NkTyRURX2FcC9lWrj5zaaN5iLMOExA2SeVSQ7oAuM3
	H/NOL94kCfny1od2xEbx+Olc3lQvqKcCRZB6gIKUELMRqQLOwhrutdNE51O4J6Ch4AQveNKSAC4
	nppnS83q1oY1/ZBIKEh6u6Ob6yUlCaTKylH7IlGQZthubQD7kD3O4GZJnUyU4rgN/LGYARkNVZ2
	N7atbYcG661TVRi1xL3+MBjOdBDewmzhmxb2fRe6pIYYLyhT0QRpSTDQ883GxXnKqMCuHNgcSm3
	/NRIw8G6tJ0eaij9K40njlel2Q==
X-Google-Smtp-Source: AGHT+IGuREERpP9JnpVQxE2gx2N8ATYZhyw+bQKD7/ebUCH+Mrw5ZxZqHBK0mqRWetMsnJ5y47gWO+g8EPh6uo/ICFg=
X-Received: by 2002:a05:6402:2744:b0:63c:343:2485 with SMTP id
 4fb4d7f45d1cf-64076fe6cd9mr3672370a12.3.1761927916424; Fri, 31 Oct 2025
 09:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
 <20251031-liehen-weltoffen-cddb6394cc14@brauner> <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
 <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com>
In-Reply-To: <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 31 Oct 2025 17:25:03 +0100
X-Gm-Features: AWmQ_bkK66nXWWUBfCViwvAvnwp-VB0qpGt3aWzeH7OijeWkiVZsNRWYzD9jixw
Message-ID: <CAGudoHFC9vfHZsgjvib=Hy8wNom27wYG+iJz=5G_6zNQHF2ndA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 5:04=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 31 Oct 2025 at 08:13, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I slept on it and I think the pragmatic way forward is to split up
> > runtime-const.h instead.
>
> I don't think that would be wrong, but I do think the real bug was to
> include runtime-const.h in any headers at all.
>

I think that was the right call, just that realities of going past
amd64 caught up with the header mixing the dependency-lean (if you
will) access with dependency-heavy patching of it.

Again with names_cachep as an example: there are different spots which
use it. On paper, fs.h can include the right header(tm) and everyone
is transparently covered. Without that every single .c file has to be
adjusted.

But that's only few spots, so one could argue that's a minor inconvenience.

Suppose one was trying to make systemic use of of the machinery for
other stuff. For sake of argument, say everything marked
ro_after_init?

With a lean header it will be feasible to sneak it in to something de
facto included everywhere.

[snip]
> End result: I think your patch to just use
>
>   #ifdef MODULE
>
> in the header was the right one. Except instead of that
>
> +#ifdef MODULE
> +#define __USER_PTR_MAX USER_PTR_MAX
> +#else
>
> thing, I think the right thing to do is to just do
>
>   #ifdef MODULE
>    #include <asm-generic/runtime-const.h>
>    #undef runtime_const_init
>  #else
>    #include <asm/runtime-const.h>
>   #endif
>
> in the x86 uaccess_64.h header file.
>

While I can concede __USER_PTR_MAX naming is not the best here, I
think your approach looks weird but it also complicates things.

I take the intent would be still to fail compilation if
runtime-const.h is included. The file is there for the premier
platforms, but most platforms still resort to
asm-generic/runtime-const.h. I think it would be beneficial to have
that sucker also cause compilation failure if included for a module.
That way someone developing on a non-mainstream platform is less
likely to post a patch bogus on this front.

> Let me think about this a bit more, but I feel really bad about having
> missed this bug. I'm relieved to say that it looks largely harmless in
> practice, but it really is me having royally messed up.
>

Sure, there is no rush whatsoever. The original patch was meant to be
a 5 minute detour and it is not holding up any work.

