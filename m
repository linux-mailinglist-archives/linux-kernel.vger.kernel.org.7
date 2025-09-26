Return-Path: <linux-kernel+bounces-834540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F2BA4E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AED1739A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7930C101;
	Fri, 26 Sep 2025 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/jCaOJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF52F83AC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911520; cv=none; b=YKswI2o72Jf/OjsglalgeESsNyXnReASKJxTCeUkDXgcDhne7PIKo3RVHnI8KXLSwIZ+dmdkSKY4dG4JUQo2QP1QFh4ibMEDqHifczXoRkG0G5+k96PARfqt66I2IrfKjC3SzyE0ca7umIdqIBBYZQZL8CY7p1fxUegn5fOmH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911520; c=relaxed/simple;
	bh=SIhhC70ZafIZdhpf5QK6kPv8M5FVssRVUsU2SoDh5Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EThevtWgeiFn5mdnDFZmFiCXKIRHJHOPAf0AOcP970tED2PXdWtr49jhip5JlO5NwpzmkunoKrssCVUXMjUOZV7o1QeGHa2Z7jztAKMYEyILgr1pwO4lGDq4k0g2snPstWPpW6Vs5cKXP5NnOcxlw1fZcRXecLIXSfKOJ0z5iTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/jCaOJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42236C4CEF7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758911520;
	bh=SIhhC70ZafIZdhpf5QK6kPv8M5FVssRVUsU2SoDh5Xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O/jCaOJIXLZjSllN/2ofZA2RVfSN07j1LaJCip6hRmo4sjeF5khYmnmNc21OErn6h
	 ioMprt8MURY3XZYyzpEfYO6V3B06G5w1Oi+oCkb7kxfKrDq1xne7cCfIvXkemVRwbA
	 SO4cJJghx/yzyTOyrwyZE3Um+rWzUAPst22aeKBUXeU1nELwyJHdWwUVFnjySFXCuG
	 m76Uc1n2MVkrF5FjKKkVoDdRoep+fbAaY/d2ViGvgzrLk2JFWlBh2v78kWLwZahPRe
	 VukFHJuMg52WppH1rj8dqAwCoDIUVO2nf2WZ21UCS69TVYBkK2EDguhZ7Ztp08Ok2J
	 G13+SxgCGZaBQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce892b7dso1615535fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:32:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvi3k4E+iQDKE+0boVr5Q9DMhnPEq0x8kMQUh/5++RK1197qx59bJAl9cttcN9Bpq7a3rJ2f0r1dmxmkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWc5Bh4boZMUFt3gjgOCVR9UsZRLQOZ6sWza22YnXSNVtXVeP
	xL2GPr/2FCiogLVyn/q8wsZmBLxmWVdu1nfHWeqmlAQFdk6nfHV57IwfvMrMavKtUh1BkoL9ZzF
	HWZsUHnFWUOlWFcCZKWnlK185jzmxVjo=
X-Google-Smtp-Source: AGHT+IHQ2t6zuV9+X6oQidiodBx57lKDsZJ+8jy7iRJOp5uLHdaHXHPcu6jZPSAQSN/4JeZYKxN1kqBEZI9GddQUzio=
X-Received: by 2002:a05:6808:4f5f:b0:43f:3eff:1ef3 with SMTP id
 5614622812f47-43f4cef0c27mr4373992b6e.43.1758911519476; Fri, 26 Sep 2025
 11:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3303305.5fSG56mABF@rafael.j.wysocki> <3571055.QJadu78ljV@rafael.j.wysocki>
 <e47c4c32-faea-4b24-a77e-9a3ec0e2b757@kernel.org>
In-Reply-To: <e47c4c32-faea-4b24-a77e-9a3ec0e2b757@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 20:31:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h3r8PKU6Q1bL0yr1seuVH3HRrdBa9-+x5eQUuU0CsYkQ@mail.gmail.com>
X-Gm-Features: AS18NWCVxPzoRLRx-vXZAbFhFKSYMPd2ncHeSLXFuGvMtf3MBMgkm8qLFbKeCL8
Message-ID: <CAJZ5v0h3r8PKU6Q1bL0yr1seuVH3HRrdBa9-+x5eQUuU0CsYkQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PM: hibernate: Combine return paths in power_down()
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:29=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 9/26/25 11:41 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > To avoid code duplication and improve clarity, combine the code
> > paths in power_down() leading to a return from that function.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The actual change looks fine to me.
>
> Since it's used in "both" a success and failure path would you consider
> using "wakeup" for the label instead of "rollback"?  Or anything else
> you can think of that doesn't have a connotation of failure.

Sure, "exit" comes to mind for instance.

> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Thanks!

> > ---
> >   kernel/power/hibernate.c |   32 ++++++++++++++------------------
> >   1 file changed, 14 insertions(+), 18 deletions(-)
> >
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -708,21 +708,11 @@ static void power_down(void)
> >       if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> >               pm_restore_gfp_mask();
> >               error =3D suspend_devices_and_enter(mem_sleep_current);
> > -             if (error) {
> > -                     hibernation_mode =3D hibernation_ops ?
> > -                                             HIBERNATION_PLATFORM :
> > -                                             HIBERNATION_SHUTDOWN;
> > -             } else {
> > -                     /* Match pm_restore_gfp_mask() call in hibernate(=
) */
> > -                     pm_restrict_gfp_mask();
> > +             if (!error)
> > +                     goto rollback;
> >
> > -                     /* Restore swap signature. */
> > -                     error =3D swsusp_unmark();
> > -                     if (error)
> > -                             pr_err("Swap will be unusable! Try swapon=
 -a.\n");
> > -
> > -                     return;
> > -             }
> > +             hibernation_mode =3D hibernation_ops ? HIBERNATION_PLATFO=
RM :
> > +                                                  HIBERNATION_SHUTDOWN=
;
> >       }
> >   #endif
> >
> > @@ -733,12 +723,9 @@ static void power_down(void)
> >       case HIBERNATION_PLATFORM:
> >               error =3D hibernation_platform_enter();
> >               if (error =3D=3D -EAGAIN || error =3D=3D -EBUSY) {
> > -                     /* Match pm_restore_gfp_mask() in hibernate(). */
> > -                     pm_restrict_gfp_mask();
> > -                     swsusp_unmark();
> >                       events_check_enabled =3D false;
> >                       pr_info("Wakeup event detected during hibernation=
, rolling back.\n");
> > -                     return;
> > +                     goto rollback;
> >               }
> >               fallthrough;
> >       case HIBERNATION_SHUTDOWN:
> > @@ -757,6 +744,15 @@ static void power_down(void)
> >       pr_crit("Power down manually\n");
> >       while (1)
> >               cpu_relax();
> > +
> > +rollback:
> > +     /* Match the pm_restore_gfp_mask() call in hibernate(). */
> > +     pm_restrict_gfp_mask();
> > +
> > +     /* Restore swap signature. */
> > +     error =3D swsusp_unmark();
> > +     if (error)
> > +             pr_err("Swap will be unusable! Try swapon -a.\n");
> >   }
> >
> >   static int load_image_and_restore(void)
> >
> >
> >
>

