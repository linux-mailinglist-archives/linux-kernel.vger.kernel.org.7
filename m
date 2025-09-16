Return-Path: <linux-kernel+bounces-818662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714E7B594D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB093B6E81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD02C237D;
	Tue, 16 Sep 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIFc/3q/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8D25B695
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021042; cv=none; b=a2/IYCmcI4mvxvV59aWNuSvkrgtRrbMliTvdrzeiy7xM09G7FZndQ2MHNeHIyQGPeYXP9ie7UPidlpEBMbZwty71mbbKXrrErWT4FpMsMw796U8/cu1XgWEIIgO/pCpYk5qos7EYCbLA0fHax5ctTgP9M+Hyjc6dniFjrfEyBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021042; c=relaxed/simple;
	bh=/OCeromXmEqYI/Es1TTYHVwWJW+VqClogHhSj6EuVbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qci7z7w7ariUUZe7pDqBwqUNzphJZuGFX5B/VMtz7+8L0Ruijro/hgL0tZeUGVPZLohCtfD/pdie9jNOQq6W85ii//0ocYFZ56zKbHMlHlDo9UEJH5acoeV9Pu0Z2wE6+YhejKV600jc0R8sSElisuBJYf2Ghswl6TB/lkYJL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIFc/3q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46627C4CEFA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758021042;
	bh=/OCeromXmEqYI/Es1TTYHVwWJW+VqClogHhSj6EuVbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EIFc/3q/Xi4FtSEOW05i4pvkm+RqOTZEohTNEHnAqQ8AtG2lw8HsgEj1ZuHVxRllg
	 Z1JVgs1LDCVBf9Xfd2xhZ3TuXqF7RMIU+QbVSFQuupp0q/ZCK4tba9Wo73fenOFHeQ
	 2cofCyHDkaH+bllEzZwMXxZC6bv49iJM7s3mbKwC6cG/rfA3ZI1WG+ryBP5W6MBCZt
	 sdwauQj3Og8814RfpdhZo+B+FEUDXtBuYnZ9khBdsNE/0bG/8GsTEMxPukqFHJ4i7i
	 qckvoLqvcFrr4s26KU1o2W5a0v5YHDYdNS6UmaFtqWYPvcugn1zVhqc+aiajIRedFN
	 yF/Be6hmDbBow==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-75763558ae1so756428a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:10:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUt46W24fwSILNUaGU8PfxQLSHTf/Xe1e0nI9RsfHV3XKO7qR/IF+R+96WZhyagvR0Rpfvx+aQbV+H03Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGwB95SR7/N7/9OWKhlX/jQXH+HrGckWm1kfRNMBlfk0HlfWD
	tgPP7fHcurtgd+cScd46WvtWeV2Uww6ew06Gy26K3lJRLlLpW9J15g00h9rTPqGgl7mcLoFq8t/
	zfGKrG8stcXh9Xjpm9mYaqyQBiwOFptA=
X-Google-Smtp-Source: AGHT+IF0VYEPlBFhsdIdEZMghX7ixkZneNnJF8NCdV6rSXVrCq7PwIvhipfFXbQg7I2krb3I+RkZQsMB+/MfadhjHZI=
X-Received: by 2002:a05:6808:80a7:b0:43d:1ffb:1b08 with SMTP id
 5614622812f47-43d1ffb3372mr4051710b6e.18.1758021041539; Tue, 16 Sep 2025
 04:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5046661.31r3eYUQgx@rafael.j.wysocki> <2243680.irdbgypaU6@rafael.j.wysocki>
 <aMf5ZNW9t_6tfsjy@kekkonen.localdomain> <CAJZ5v0ivX3s=pChGZ_+zeUswJgMPDH2Wi_cGeATyh+M9Tb0LYw@mail.gmail.com>
 <aMh0sRizzRFTtp6z@kekkonen.localdomain>
In-Reply-To: <aMh0sRizzRFTtp6z@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Sep 2025 13:10:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gGcyWfgUxj-ayTj0QXaDa9eayWP7ANfumzGqAU61-vAA@mail.gmail.com>
X-Gm-Features: AS18NWB1MYk_hERbWYACORkIAOwhllsLln5G0yGDyxhkCNVSOoOfBu6FbFMFn6g
Message-ID: <CAJZ5v0gGcyWfgUxj-ayTj0QXaDa9eayWP7ANfumzGqAU61-vAA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] ACPI: property: Add code comments explaining what
 is going on
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Sep 15, 2025 at 10:19=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Sep 15, 2025 at 02:27:16PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Mon, Sep 15, 2025 at 1:32=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Fri, Sep 12, 2025 at 09:40:58PM +0200, Rafael J. Wysocki wrote:
> > > > +                     /*
> > > > +                      * The reference is expected to point to an o=
bject
> > > > +                      * returning a package that contains _DSD-equ=
ivalent
> > > > +                      * information.
> > > > +                      */
> > > >                       handle =3D link->package.elements[1].referenc=
e.handle;
> > > >                       result =3D acpi_nondev_subnode_data_ok(handle=
, link, list,
> > > >                                                            parent);
> > > >                       break;
> > > >               case ACPI_TYPE_PACKAGE:
> > >
> > > And similarly, the result of an evaluation here is a package when a
> > > reference points to a name object (i.e. a data node).
> >
> > Well, I'm not sure how this remark is related to the new comment below.
> >
> > Do you mean that this always happens when a reference is used in ASL
> > to point to the target here?
>
> As long as the target is a non-device object (or name or method object at
> least), which is required by DSD-guide for (non-string-)referenced object=
s.
>
> >
> > But the comment would still be valid in that case, wouldn't it?
>
> After re-reading the first paragraph, I agree.
>
> >
> > > > +                     /*
> > > > +                      * This happens when the target package is em=
bedded
> > > > +                      * within the links package as a result of di=
rect
> > > > +                      * evaluation of an object pointed to by a re=
ference.
> > > > +                      *
> > > > +                      * The target package is expected to contain =
_DSD-
> > > > +                      * equivalent information, but the scope in w=
hich it
> > > > +                      * is located in the original AML is unknown.=
  Thus
> > > > +                      * it cannot contain pathname segments repres=
ented as
> > > > +                      * strings because there is no way to build f=
ull
> > > > +                      * pathnames out of them.
>
> Is the "original AML" relevant? Aren't we just interested in how the
> evaluation result was reached instead of what was its actual path?

So long as the node in question is not referred to via a namepath from
a different place (for instance, a reference property in a different
node), we don't.  However, if there is such a reference to it
somewhere, we need to know that this is the target node of that
reference.

> We won't know the latter in any case. What would you think of:
>
>                         /*
>                          * Evaluating a reference results in a package ob=
ject
>                          * (required by DSD guide) allocated on the fly. =
The
>                          * actual target object of the reference isn't
>                          * available.
>                          */

The target object actually is available, but the path to it isn't
known at this point.

>
> I guess nothing prevents having further string references within the
> object?

The _DSD guide forbids that and they would only work if they were full
namepaths (because of the unknown scope).

Anyway, I think that the comment is as good as it gets in its current form.

> I think it'd be best to deprecate direct references in the DSD guide.

That I agree with, but the code needs to be retained for compatibility
with the installed base.

> > > > +                      */
> > > >                       desc =3D &link->package.elements[1];
> > > >                       result =3D acpi_nondev_subnode_extract(desc, =
NULL, link,
> > > >                                                            list, pa=
rent);
> > > >
> > >
>
> --

