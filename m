Return-Path: <linux-kernel+bounces-845706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E290DBC5F55
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF73420B78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A52F60CB;
	Wed,  8 Oct 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ZP2GCAk5"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53D2F60A4
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938524; cv=none; b=oPZ8ZIQGi/Y7x0XNexzDDydrY/ZSzSQWSGyZeQMz/Yhw+VZFhLURDLvmxcUS254JZFWzZLmez2Slx6AcMkWn/jzTb+H/q9eLHU0cgYSRpCC8PnI2C+bQekfUP8yjmAuI3YBhWt9G/y7rGmFJROIVrItRf6u4XM4GT4YVt/XWmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938524; c=relaxed/simple;
	bh=zhZiUCvW+T830NMycXrll9vvv5Hp3tr4BT1okA0UDN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap4Pftvo0/5wbOi5kgeo9dU7y42ddRA6XDwnks9xAT1w6ppaZ3n+t5QT+b/scJrOF/v0M9qLToSFWrtoEXGxPdUN6ELYO3WMaKq4zFSrrCZL1WPko31zf+LNNrOsRQ4d4L9zUo0FC1HZkBe7oj8sg+2MEmvELczb92f26oa5os4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ZP2GCAk5; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 5765D478AB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:38:57 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 2760B4788F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:38:56 +0300 (EEST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 7E220200B39
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:38:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1759937935;
	bh=O0S7kP1pKw5k090uPkLgOjv7DG7xTqcbUDRbQRUBK4Q=;
	h=Received:From:Subject:To;
	b=ZP2GCAk5HByjek3y/YW6ueN2pSKtlXmNlXTZWIGbM5zjrhOjzYap8fIo82opic9QJ
	 Fr1lcjrLxdrIh671WidDPli+9ZE2D7TazNpaC8inVgbMOypsfStWG90giqMQG/u4c9
	 eUcIO3y9ScGzzWLLEEixcGFqd9CpRAybgHt3m/FCVkexobUJgoZfSkG7IG2dMYS2Wh
	 Na+AbsFa2dhPtLKYnDjBp+JQtj9xW/dx+oTjI0WEz8ryChuj6RREk5pUCw70S94vWk
	 H7ibXj3Cdm2A04VXbyq143ai8PCTBKUPK8Iq86zVvCynK/CcN99L67ujyMIdR57G5L
	 WbRUFcCsAsvKA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3612c38b902so78700981fa.2
        for <linux-kernel@vger.kernel.org>;
 Wed, 08 Oct 2025 08:38:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXfDnWc7SXy9hMqWnkwzDF7JjmM/Bxoi+D5OIQQyVzZkrDOOW+QMuDesCqHSELkJBV7eX6ibnaoqrY9k2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwzKNmGun2QrG/5in/mvn8F3Yy793mqJi9mPT9QqG3LqcSepTz
	B+G+pp4yE4t7krFkYh+BsOZ0nHHMoFA+9nJz9EGaKYj1RrjjHHxxOEVCmngZgBEjCtjC4CxUc4Z
	WnwpdL3Ownh+GQ+LqFrfmBFfS4TOIqhs=
X-Google-Smtp-Source: 
 AGHT+IEaNxRCF+Ebrlsy7YqbhZZ7XNMUuB7InyIhPOaWQVepkpbiWFH0awkJq3FM4jy15HSDVOEXGd35+MOTBXUpvcY=
X-Received: by 2002:a2e:b88e:0:b0:332:3562:9734 with SMTP id
 38308e7fff4ca-37609ce61admr10368631fa.8.1759937935005; Wed, 08 Oct 2025
 08:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008135057.731928-1-lkml@antheas.dev>
 <f6d4145b-3295-4a98-9074-d4d1b7b466ae@kernel.org>
 <CAGwozwGkbJ7qQw6EXF96UjzF5GOi4qRxp2JZFsi4MPbNa97Cyg@mail.gmail.com>
 <b50be0eb-19c3-410d-839b-65c6a73ab6b9@kernel.org>
In-Reply-To: <b50be0eb-19c3-410d-839b-65c6a73ab6b9@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 8 Oct 2025 17:38:43 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFH6gh-p=qshraF5bKRZVpc5qmxQhk+RO+U3ECDTaRpyg@mail.gmail.com>
X-Gm-Features: AS18NWAse2z0ajnnZHXwrXZQ13X5wqCpQRIfE6dF5Pw9CLWqMZgFo4tFf4Oi3ms
Message-ID: 
 <CAGwozwFH6gh-p=qshraF5bKRZVpc5qmxQhk+RO+U3ECDTaRpyg@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86/amd: pmc: Add Lenovo Legion Go 2 to pmc
 quirk list
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam-sundar.S-k@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175993793570.2776557.11637734053115542367@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 8 Oct 2025 at 17:14, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 10/8/25 9:18 AM, Antheas Kapenekakis wrote:
> > On Wed, 8 Oct 2025 at 16:06, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >> On 10/8/25 8:50 AM, Antheas Kapenekakis wrote:
> >>> The Lenovo Legion Go 2 takes a long time to resume from suspend.
> >>> This is due to it having an nvme resume handler that interferes
> >>> with IOMMU mappings. It is a common issue with older Lenovo
> >>> laptops. Adding it to that quirk list fixes this issue.
> >>>
> >>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4618
> >>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>
> >> This makes sense for BIOS in the field.
> >> If this is fixed in the BIOS later I'd like to narrow the quirk at a
> >> later time.
> >
> > That would be ideal. Especially since the issue is known and fixed in
> > Lenovo laptops from the last three years so it should be easy to fix.
> > Currently, there are two BIOS versions that would need quirking,
> > RRCN11WW, RRCN10WW.
> >
> > What are the side effects from blocking the Nvme handler? Other than
> > OPAL support handled by the built in BIOS, which is a semi-antifeature
> > for a device like this.
>
> The inability to use a storage password is the only side effect I'm
> aware of.  Given the form factor I tend to agree it's not "high
> priority" and thus this quirk makes sense.
> >
> > I should note that there are other pressing issues with the device.
> > Users report HDR brightness is not at correct levels compared to
> > Windows and the brightness slider sometimes breaks after sleep.
> >
> > HDR brightness might be a bug in Bazzite specifically, due to a
> > blanket quirk we apply to disable the PQ curve on internal displays
> > (essentially the panel that had the brightness bug on e.g. Zotac Zone
> > also reports supporting PQ but it does not). I disabled it for the Go
> > 2 but have not double checked it is disabled due to not having a
> > device. Users said there was an improvement after disabling it though.
> >
>
> Wrong audience for this issue.  I would raise this for discussion on
> dri-devel if it happens on a mainline kernel without extra distro
> specific quirks added.

The reason I raise this here is to say since the device has more
pressing issues currently, a BIOS fix for OPAL should be prioritized
accordingly.

I do not have a dev unit so I cannot reproduce these two issues and
user reporting is inconsistent so I will leave it there. The PQ quirk
is in gamescope, where the issue might very well be.

> > Antheas
> >
> >> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >>
> >>> ---
> >>>    drivers/platform/x86/amd/pmc/pmc-quirks.c | 17 +++++++++++++++++
> >>>    1 file changed, 17 insertions(+)
> >>>
> >>> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> >>> index d63aaad7ef59..0fadcf5f288a 100644
> >>> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> >>> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> >>> @@ -204,6 +204,23 @@ static const struct dmi_system_id fwbug_list[] = {
> >>>                        DMI_MATCH(DMI_PRODUCT_NAME, "82ND"),
> >>>                }
> >>>        },
> >>> +     /* https://gitlab.freedesktop.org/drm/amd/-/issues/4618 */
> >>> +     {
> >>> +             .ident = "Lenovo Legion Go 2",
> >>> +             .driver_data = &quirk_s2idle_bug,
> >>> +             .matches = {
> >>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "83N0"),
> >>> +             }
> >>> +     },
> >>> +     {
> >>> +             .ident = "Lenovo Legion Go 2",
> >>> +             .driver_data = &quirk_s2idle_bug,
> >>> +             .matches = {
> >>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "83N1"),
> >>> +             }
> >>> +     },
> >>>        /* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
> >>>        {
> >>>                .ident = "HP Laptop 15s-eq2xxx",
> >>>
> >>> base-commit: a8cdf51cda30f7461a98af821e8a28c5cb5f8878
> >>
> >>
> >
>
>


