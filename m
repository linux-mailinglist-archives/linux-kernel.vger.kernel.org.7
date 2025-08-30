Return-Path: <linux-kernel+bounces-793007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E0B3CB75
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00844580B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA927979F;
	Sat, 30 Aug 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W400+Sa+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60E271457
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756564800; cv=none; b=JMOb5xFqwEcaBRo5k00rmVMPQ9y5RnQa/o4iDK18syFJglDMoFMn494UvkiFWTipcy7w4akw1fkLFrkr1GHbjeavPDnvtvbtPGVRzwbAcp6U2+BDU9OEF8p8fbsvtZnOdYXWaBArWzi7tUaCqrztMq4luWQ7/7rVKGdHhH/wp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756564800; c=relaxed/simple;
	bh=cBM4QPHJZ48Q7uu+0Wm/JpBxCyUwFXoFG9xhoQVbkcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zjw6EzyZO6a0tVBdpZrt2ItgSFLMFb+aUbo+EJYNARXZOhOr6Bx6cUa8xaZ9bI1n+l9wfUd1cJ0dPxzHsM5VlOMQw6GaXXZ5MTA1TaGwd21Bf6eUsk2z8p6q3R/2SJul0Qn4PTLFmjidyI9xSX95mOn0BtTSA00eeZKtkH4fFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W400+Sa+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afebb6d4093so500501666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756564797; x=1757169597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnYxwTXcXTNDsxyzzEKw7FQf3C933WxzhGWGRLrooys=;
        b=W400+Sa+MZkUUsY7KWQXQW50wlfN4j+afo1pyaWQ0mMi1ukWIVi+4ArS3g6JFgIzD0
         o4FiZ7SeFogfTc+9YKHbLqY992wEY4poKDN5uAuCJY2fOOvUh23mlqyFr6wPWhkjl/SJ
         Byj66Wo14hwVNu52862fTCV2j27kU3ydEOoRrPUWJoYx9y6LHrpV/8sx7QcWZctQm05V
         hbtRQv3toiltujBTfu8dsS17tGyRwH8xooY81wZUOYZJfYaNixoIIH76PQco4bdIU2fI
         JINgnyA5DrGbnCA88uFF44Do5dhJPAAvS/hcJ1jILpNmvqwdx+IDsgEylDdCyW7j2EsL
         j0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756564797; x=1757169597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnYxwTXcXTNDsxyzzEKw7FQf3C933WxzhGWGRLrooys=;
        b=KDXR372HCst/QBp5mPqJeELDCsuxxNU+6hkNlyqHMvi2Yig/qaq+vyTfZk/IJvyDWr
         UQAmrizLySKr87bU/lse8VQRRx4DncADrBML6LmsXp5/cjQGLMyUYyRhhVGZ+WH/rMjy
         jM2Z3wQIHnNgWX2fUsKz7QHTfeIvOcYSLZbAU0l0B+PuJqDnRx+CZg7E6fgDMDqk93Pf
         IxpBJ3PI5860EpQKr9jsGBKoB1WUwtaCoTePfRywni+oyUSj6csmbrKd3vpXU4QwMHRQ
         SE64ZJtLqRHvTQPqdpQP43njYTJrRdJCtn7p5He0mmAO9vs0vYXHDNon00KqiXnJLjbi
         x8xw==
X-Forwarded-Encrypted: i=1; AJvYcCXhOttc8TgTQlt2+2irENGoiXPgpSXJPIGpxxqEqLdXV3O4AF9CuHO33+k2HS4Hyguknf/j87VyF//1+/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZ/ZTds/Kw/3Cz6MUKsAvzDZ8RUzIv6GFJd4yuuMAau2eOi3g
	J48rJP1vXtOUx3VcJiA2wbjee6F1fM/3BMdp3HlQHgYSUqs5PNlxzXBtluk8o+cqaLGsJmSHdAs
	kT/iEcqPYxoxLOGUFnUq2FxRKIJFsD/QOduHfBG4=
X-Gm-Gg: ASbGncu/LDeYOU//pPlTyiIb9W0rs4CmtickNpZHduYjqnPOxbGdJS7fJUh1MAE7LlZ
	a9nUU9f123OzVtdP+Y75/9WaqaAwZ9aRSqey46zHhXJuc7U+hAbM18M2spHt0sDlk7KdTn4JVPz
	KPaR4UPCVB1HPDRbzglErruaexE4y/RR0J2xaYb0fXxFTZLTXaUmuWGswS/KKp8i5iRDCP6Ke+7
	oNQHGZ0Ls0Np2UUXw==
X-Google-Smtp-Source: AGHT+IGlsP1VdRE2NfS5RR/YiUFvRvXRJSxmBDwbybhrTXDAS16+DabBZlFJhx+HvkU9pFb7W4ldKTqv0mR9m9h32w8=
X-Received: by 2002:a17:907:3cd2:b0:afe:9777:ed0e with SMTP id
 a640c23a62f3a-b01af2e15camr201527766b.0.1756564797176; Sat, 30 Aug 2025
 07:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010324.15595-1-jefflessard3@gmail.com>
 <CAHp75VdF=_LQbHJozUGExCmDd4UW4oJ0-deT=aEdnQjCOotsVA@mail.gmail.com> <67046EE4-FBE6-41FA-AB03-B0E01FA1C274@gmail.com>
In-Reply-To: <67046EE4-FBE6-41FA-AB03-B0E01FA1C274@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 17:39:20 +0300
X-Gm-Features: Ac12FXxKyo7FX6N92ULxD3fn4jagSp6DA-e98MaEBHIryIp27R2C45r-7zcKTOA
Message-ID: <CAHp75Vc3DHUJwA+S4PGfoZxGtdqVq3GTF6_BEnJFo+=sFMmfDA@mail.gmail.com>
Subject: Re: [RFC PATCH] auxdisplay: line-display: support attribute
 attachment to existing device
To: =?UTF-8?Q?Jean=2DFran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 4:55=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
<jefflessard3@gmail.com> wrote:
> Le 30 ao=C3=BBt 2025 05 h 15 min 23 s HAE, Andy Shevchenko <andy.shevchen=
ko@gmail.com> a =C3=A9crit :
> >On Fri, Aug 29, 2025 at 4:03=E2=80=AFAM Jean-Fran=C3=A7ois Lessard
> ><jefflessard3@gmail.com> wrote:
> >>
> >> Modernize the line-display core library:
> >> - Add the ability to attach line-display's sysfs attribute group direc=
tly
> >>   to an existing parent device (not only via a child device) using
> >>   device_add_groups(), allowing coherent integration with subsystems l=
ike
> >>   the LED class.
> >> - Implement a global linedisp_attachment mapping for unified and race-=
free
> >>   attribute access, context lookup, and cleanup, shared between
> >>   traditional register/unregister and new attach/detach paths.
> >> - Modify sysfs attribute accessors to retrieve context using a consist=
ent
> >>   to_linedisp() mechanism.
> >> - Add a new num_chars read-only attribute reporting the number of disp=
lay
> >>   digits to allow static non-scrolling message from userspace.
> >> - Ensures thread safety and proper list removal for all attachments
> >>   operations.
> >
> >Thanks for working on this, can you split it into 5 patches?
>
> My pleasure! Thanks for your feedback.
>
> 5 patches? I can't see how these changes could be split into 5 patches.
> Maybe the commit message is too verbose and needs to be shortened.
>
> If needed to be split into multiple patches, it could be:
> 1. Add attach/detach capability
> 2. Add num_chars sysfs attribute + ABI doc

Yeah, the commit message was a list of 5 things, hence 5 patches. I
haven't read closely to map each listed feature to the possible
change.  The description of to_linedisp() sounds like it can be split
to a separate patch. I really want to see the attachment/detachment
patch separate with the explanation "why?". I am not sure I see the
point.

> I am also thinking to add a 3rd one to pad the message when length is sma=
ller
> than num_chars. Current behavior is to wrap around which seems weird to m=
e.
> E.g. for 4 chars:
>
> Current behavior:
> cat "123" > message
> results in "1231" being displayed
>
> Padded behavior:
> cat "123" > message
> would result in "123<blank>" being displayed
>
> Any thoughts on that?

It's basically the question of circular vs. one time message exposure.
When it's one time, the padding makes sense, otherwise the current
(circular) behaviour seems normal to me.

> >More comments below.
> >
> >> Backwards compatibility with existing users is maintained, while enabl=
ing
> >> uniform n-segment sysfs API and richer information for integrated driv=
ers.

...

> >> +static struct linedisp *delete_attachment(struct device *dev, bool ow=
ns_device)
> >> +{
> >> +       struct linedisp_attachment *attachment, *tmp;
> >> +       struct linedisp *linedisp =3D NULL;
> >> +
> >> +       scoped_guard(spinlock, &linedisp_attachments_lock) {
> >
> >Use guard()() and drop NULL assignment.
>
> I'll use guard()().
>
> NULL assignment was to prevent invalid pointer in case the device is not =
found
> in the list. But you are maybe suggesting to drop declaration of linedisp=
 and
> then directly return the linedisp within the loop and to return NULL afte=
r the
> loop?

This won't work as you want to clean up the things.

> >> +               list_for_each_entry_safe(attachment, tmp, &linedisp_at=
tachments, list) {
> >> +                       if (attachment->device =3D=3D dev &&
> >> +                           attachment->owns_device =3D=3D owns_device=
) {
> >> +                               linedisp =3D attachment->linedisp;
> >> +                               list_del(&attachment->list);
> >> +                               kfree(attachment);
> >> +                               break;
> >> +                       }
> >> +               }
> >> +       }
> >> +
> >> +       return linedisp;
> >> +}

The usual approach here is to use list_entry_is_head() after the loop.

  list_for_each_entry() {
    if (...)
      break;
  }

  if (list_entry_is_head(...))
    return NULL;

  linedisp =3D ...
  ...
  return linedisp;

...

> >> +static struct linedisp *to_linedisp(struct device *dev)
> >
> >As per above.
>
> Same.

Same.

...

> >> +       &dev_attr_num_chars.attr,
> >
> >This needs a Documentation update for a new ABI.
>
> Agreed. I think it's also worth documenting the other ABIs along the way =
since
> they are not documented yet. Then, what Contact should be documented?
> Is there an auxdisplay mailing list?

Your or no-one's? Is it a mandatory field? In any case the ABI must be
documented, w.o. doing that any good patch is simply NAK
automatically.

--=20
With Best Regards,
Andy Shevchenko

