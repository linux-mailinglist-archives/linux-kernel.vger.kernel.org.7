Return-Path: <linux-kernel+bounces-749132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D677B14A83
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8E7188D8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA64A285C9D;
	Tue, 29 Jul 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTg5a0fl"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53092749E0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779297; cv=none; b=OwF00zx8yV0gk/wyENh2c52VYkm2yHgBBMsF6wH6v17eemAAl62Z/A/m6zMvzGbvtIWt3qyE+RLcpvYjZ2ov9FzkDCb5G2vbd9Kjh03dTotLkgBTjx3K4fY+akWbzIzkNcj61GAqDjVKiNRuxJX2F2AZ9cKXqf+2PG/mIfnlqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779297; c=relaxed/simple;
	bh=T3zyoANKYAJ4AvVpw72Tq73mKPpbJLuoebt+YaG1elQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGgG/iBsNsmI/S1eZISvQdLGNevgpTuiEuTGKW553z7F+LRmUTB1bXkEHet7rLYLLAWd5T8qv8EmNCBWC1mEfXcYxlFtaWbVpQHSlHBF7z4n72p3uMtzmMD7wLbEEF6NVqWI2shmOZHSMWuiHTfH/6WA3Psdeb+y4Ywac71UJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTg5a0fl; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ea58f008e9so3954568fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753779295; x=1754384095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfbsxkFJQf8cWQTKmEBs/1hRt5cWB9+/Q3iqwitKzTg=;
        b=GTg5a0fl9BMtBgZd3WqpvglPxUOec4bG7JpUhfCHWD8IyZXodkST6v5UJAHXa2MyX9
         MEbaIHaO2GZ8reaXiZsSr7cVESbBPf1CVzt7TicmXopv7uYwrC8Ss6mgF0YIXA7GL9rq
         l8S7x7pq6EfkpbbToGLwfUshBtfq/Ka1BN2mRDt2VhMon0mb0m6MD918wFZ9h+/D5RkX
         EGw214mam3rxgknHuKnp9HEKSiiSe2Iq4XH7sazhK3GryfLbElj1LxYhwu01KitANpQE
         2H5qMGOylYoJ6dE+Lu2YAquZ0cJhlBhWnOUMyS5oj3lUbDKjG5fgnbi4eqIPGjVUzwnM
         ZRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753779295; x=1754384095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfbsxkFJQf8cWQTKmEBs/1hRt5cWB9+/Q3iqwitKzTg=;
        b=hhvFPFpFIghWSd5/gwi1vbA3ARlrRi2tb9thvwZpExzonj2akoxS1kJO9eD+/SIPme
         QkZH4Fzy8Zwf02VhAqH+/z3DnMAvJ8UQR/jIw2ZpxCbs0of1YMI0pLxORAwMmg4T+twr
         leGtfhvvpxcp51DjNpQKT8yU41vzGvOfwzh1onAC/ZsrP5Y42zLaETple1eS323xhW1H
         E9K92g2fw8EwP6lCE1gwDeChZmbg/px5cjZEIMex8FGLL6j0Yg+7J84UTm6ZBvtHqa7W
         XSvkP+HbvVOY/IuE4JE8ZPxo3rAu1dO9kgGiCiLTwayLxBl17jJYNhk4P5OZJUcJqw7H
         6kKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFrYMAjl/IQ82XpBS0DPCWkozIKCMNiImHZyGcEomz+cAhAGQ7gIf+X2lwesnG1rm/uJBWaQUNtE7x0Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWuTMnzueP3aXOwRqYngZK5HvFC8YAja/czWdR9BpSr4Dw5ip1
	UHlvfXUnzzl8NHZGXzJIY4dqzJCtB9V9IdmJp0aUTksGA7gh34ax4p/JkQL9uOQ/tnfggpll/oa
	BbCEnupStrTmBFt4QaBY5tkmlj3R6OKE=
X-Gm-Gg: ASbGncvM1LC4lf2NgkqZ87KAioxx2WoE7zeO9jPuOC0e7zO9sAuxkE0oTkL+iVvB69m
	Fpr1A6K/OaghMWGZmpUb8RQtUMC5hiLV/uu0bk0BU9ZbsqW8Ds+tnVBCm2SBIm/r5kFaxdN0OqB
	wJNbA/qFnST83qjnpAqyj5j/UrRcSP9XDhiE2nXfq2wl57N1JQYn7tNZPrtpv1NrzvC/tBYtJwm
	3NenVWf
X-Google-Smtp-Source: AGHT+IGTcd9NOa90kmOr1VvjB20fRDPHUxTkmJDOv2L7UxY1nAmAc0lKtrGG4k+Ud+Hduw4Tdeh+owTgWq3fUeeUddQ=
X-Received: by 2002:a05:6870:390f:b0:2d5:b914:fe40 with SMTP id
 586e51a60fabf-30701ace60dmr8965460fac.20.1753779294625; Tue, 29 Jul 2025
 01:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729042621.6403-1-suchitkarunakaran@gmail.com>
 <2025072925-lint-agreement-77e8@gregkh> <CAO9wTFg_jCUZ+DxXVDM11_715r6ALJ=HyRXkcBxhGrBUo4iVUg@mail.gmail.com>
 <2025072931-recount-stifling-73e8@gregkh>
In-Reply-To: <2025072931-recount-stifling-73e8@gregkh>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 29 Jul 2025 14:24:43 +0530
X-Gm-Features: Ac12FXyqLsqk5XOEKlKg-Vrv5qDx8UbUsXGBmuVo13r_qFb-1txgM8c-57KVn1s
Message-ID: <CAO9wTFj1qCkhNG24hAWDfZqoJy4mhPFf6mKp=jg7GnaLmHix-w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/intel: Fix always false range check in x86_vfm
 model matching
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 at 13:26, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 29, 2025 at 12:23:27PM +0530, Suchit Karunakaran wrote:
> > On Tue, 29 Jul 2025 at 10:58, Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> > >
> > > On Tue, Jul 29, 2025 at 09:56:21AM +0530, Suchit Karunakaran wrote:
> > > > Fix a logic bug in early_init_intel() where a conditional range che=
ck:
> > > > (c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_WILL=
AMETTE)
> > > > was always false due to (PRESCOTT) being numerically greater than t=
he
> > > > upper bound (WILLAMETTE). This triggers:-Werror=3Dlogical-op:
> > > > logical =E2=80=98and=E2=80=99 of mutually exclusive tests is always=
 false
> > > > The fix corrects the constant ordering to ensure the range is valid=
:
> > > > (c->x86_vfm >=3D  INTEL_P4_PRESCOTT && c->x86_vfm <=3D INTEL_P4_CED=
ARMILL)
> > > >
> > > > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural
> > > > constant_tsc model checks")
> > > >
> > > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > >
> > > > Changes since v1:
> > > > - Fix incorrect logic
> > > > ---
> > > >  arch/x86/kernel/cpu/intel.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/inte=
l.c
> > > > index 076eaa41b8c8..6f5bd5dbc249 100644
> > > > --- a/arch/x86/kernel/cpu/intel.c
> > > > +++ b/arch/x86/kernel/cpu/intel.c
> > > > @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86=
 *c)
> > > >       if (c->x86_power & (1 << 8)) {
> > > >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> > > >               set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> > > > -     } else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=
=3D INTEL_P4_WILLAMETTE) ||
> > > > +     } else if ((c->x86_vfm >=3D  INTEL_P4_PRESCOTT && c->x86_vfm =
<=3D INTEL_P4_CEDARMILL) ||
> > > >                  (c->x86_vfm >=3D INTEL_CORE_YONAH  && c->x86_vfm <=
=3D INTEL_IVYBRIDGE)) {
> > > >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> > > >       }
> > > > --
> > > > 2.50.1
> > > >
> > > >
> > >
> > > Hi,
> > >
> > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent =
him
> > > a patch that has triggered this response.  He used to manually respon=
d
> > > to these common problems, but in order to save his sanity (he kept
> > > writing the same thing over and over, yet to different people), I was
> > > created.  Hopefully you will not take offence and will fix the proble=
m
> > > in your patch and resubmit it so that it can be accepted into the Lin=
ux
> > > kernel tree.
> > >
> > > You are receiving this message because of the following common error(=
s)
> > > as indicated below:
> > >
> > > - You have marked a patch with a "Fixes:" tag for a commit that is in=
 an
> > >   older released kernel, yet you do not have a cc: stable line in the
> > >   signed-off-by area at all, which means that the patch will not be
> > >   applied to any older kernel releases.  To properly fix this, please
> > >   follow the documented rules in the
> > >   Documentation/process/stable-kernel-rules.rst file for how to resol=
ve
> > >   this.
> > >
> > > If you wish to discuss this problem further, or you have questions ab=
out
> > > how to resolve this issue, please feel free to respond to this email =
and
> > > Greg will reply once he has dug out from the pending patches received
> > > from other developers.
> > >
> > > thanks,
> > >
> > > greg k-h's patch email bot
> >
> > Hi Greg,
> > I've a question regarding backporting this fix. Can this fix be
> > backported to stable kernel version 6.15.8? Also, should I send the
> > backport patch only after the initial patch has been merged in
> > mainline or linux-next?
>
> Did you read the document that my bot linked to above?  It should answer
> those questions :)
>
> thanks,
>
> greg k-h

Hi Greg,
I did go through the document you linked. I just wanted to clarify
about the backporting process, especially since the merge window has
already started and it might take some time for this to be merged into
mainline. Regardless, I'll send the backport patch after the initial
one has been merged.
Thanks again, and I apologize for any inconvenience.

