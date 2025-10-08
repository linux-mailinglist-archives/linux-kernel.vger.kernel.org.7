Return-Path: <linux-kernel+bounces-845583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77AEBC56D8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B42B3AB018
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF52E8DEA;
	Wed,  8 Oct 2025 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="J4XA8TNC"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0980279DCD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933562; cv=none; b=s33sogdqTjC5wNr3XffcXBaelh8NF4gK3WOrTUt1ozkEossAeXlli+bGw365dfRVwFmcDOXMxsD6SGf75vI3rSGVKNKVc0EKFkdVorEaszZ2r83uYjoR9TV4nReYaJn/J0GIP55dI4DtnFPXlD5lmEZQde/vYITXww2onZJY6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933562; c=relaxed/simple;
	bh=6rKMdLNQeheV0nXKVJ7hMBXupmT9rhjbFh4r+fuSFxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTFVKBazvnHn1NBh2Esongxmpdbe5MIFxPrMPnAAj9qj7MTc5Z4D6+Nel6/hriKN4E/xVVSdIoW8qwcsAiBBNSouu3btnzGZ2+vW7Z9uqPOXs5LAM8u4crrCHlYFkwM3os+RxeYKrPaHOwhwCMRej1VGqzL0exau+AV5McNqGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=J4XA8TNC; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id AECCE5E7BB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:18:50 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 305235E72A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:18:44 +0300 (EEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id E9F15200B11
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:18:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1759933123;
	bh=jEyWwa68ZwN7vyBFbYqkt5R7Ucf0ICsYRPcjjiumWXs=;
	h=Received:From:Subject:To;
	b=J4XA8TNC76ZGkn8eGHAR3HkTaqvKbeGNuBrpS9MqSYwvBWpl6fd4sXYqn1kbNGeIb
	 ZCaX+UrXqFHKVs1AFaaRetJHVECdzkqv+IgQ1nVzkFVOU1PNCNmMKViMLcoVL4KsQg
	 f470Nkyfty51KmsG2n/AY4DDTVd20DksEldnE1FH5qWwVYuN+rEqRCH7VTUqBmI0rz
	 uyrBafFV3+kBIvRJdlOq8EiQLAZ4n0Yp2qYTGUfSulwQE+Dq8DDq6EedjdPNlKBZFC
	 icThL4DcE+JgVxE6Er1zIoypcM5tR8mW95wiFTVp0mUu+yHSoiaZzrmod740wvhllu
	 9ykzvvdBb6vow==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-36a448c8aa2so62104521fa.0
        for <linux-kernel@vger.kernel.org>;
 Wed, 08 Oct 2025 07:18:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUZGdbMs+cj393k4GdpVgOOFpAKoRBerSfWEUUIvsO9JfSAzNYYyPlLwZgSCx7DK5PYargeaA5PesBL9/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6eXjtWi3z8KMHEPskZYBMAwtBwfuNNF/PwCvO8qhyBEhMXPt
	TloGMqBOAdg74I8steAck/8OBC7qO+UUb5CMrGi/Gc2YyZfMraMg6ODk4iDGTpbSDLcmYxruJJl
	awJuAVMtqwV3py20C8AZv0FYQLANgMpY=
X-Google-Smtp-Source: 
 AGHT+IFYy3GO+YTWAYmdN6/49q9L3wpjcc/lY/h8o7FdkNkDsR4aHMFiemr5kMvKlBBLMn7v0jh2fLALd/qXuCqDT7A=
X-Received: by 2002:a2e:a10b:0:b0:36d:6ae3:816b with SMTP id
 38308e7fff4ca-37609d3a324mr8299711fa.13.1759933122411; Wed, 08 Oct 2025
 07:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008135057.731928-1-lkml@antheas.dev>
 <f6d4145b-3295-4a98-9074-d4d1b7b466ae@kernel.org>
In-Reply-To: <f6d4145b-3295-4a98-9074-d4d1b7b466ae@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 8 Oct 2025 16:18:31 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGkbJ7qQw6EXF96UjzF5GOi4qRxp2JZFsi4MPbNa97Cyg@mail.gmail.com>
X-Gm-Features: AS18NWCGRSpMIJba1jh4CD-RedBHmwYK3QP0XlXHEKbGTMGty1V6GWNG_i9gtIk
Message-ID: 
 <CAGwozwGkbJ7qQw6EXF96UjzF5GOi4qRxp2JZFsi4MPbNa97Cyg@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86/amd: pmc: Add Lenovo Legion Go 2 to pmc
 quirk list
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam-sundar.S-k@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175993312312.2497748.7504576057015337101@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 8 Oct 2025 at 16:06, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 10/8/25 8:50 AM, Antheas Kapenekakis wrote:
> > The Lenovo Legion Go 2 takes a long time to resume from suspend.
> > This is due to it having an nvme resume handler that interferes
> > with IOMMU mappings. It is a common issue with older Lenovo
> > laptops. Adding it to that quirk list fixes this issue.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4618
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>
> This makes sense for BIOS in the field.
> If this is fixed in the BIOS later I'd like to narrow the quirk at a
> later time.

That would be ideal. Especially since the issue is known and fixed in
Lenovo laptops from the last three years so it should be easy to fix.
Currently, there are two BIOS versions that would need quirking,
RRCN11WW, RRCN10WW.

What are the side effects from blocking the Nvme handler? Other than
OPAL support handled by the built in BIOS, which is a semi-antifeature
for a device like this.

I should note that there are other pressing issues with the device.
Users report HDR brightness is not at correct levels compared to
Windows and the brightness slider sometimes breaks after sleep.

HDR brightness might be a bug in Bazzite specifically, due to a
blanket quirk we apply to disable the PQ curve on internal displays
(essentially the panel that had the brightness bug on e.g. Zotac Zone
also reports supporting PQ but it does not). I disabled it for the Go
2 but have not double checked it is disabled due to not having a
device. Users said there was an improvement after disabling it though.

Antheas

> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> > ---
> >   drivers/platform/x86/amd/pmc/pmc-quirks.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> > index d63aaad7ef59..0fadcf5f288a 100644
> > --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> > +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> > @@ -204,6 +204,23 @@ static const struct dmi_system_id fwbug_list[] = {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "82ND"),
> >               }
> >       },
> > +     /* https://gitlab.freedesktop.org/drm/amd/-/issues/4618 */
> > +     {
> > +             .ident = "Lenovo Legion Go 2",
> > +             .driver_data = &quirk_s2idle_bug,
> > +             .matches = {
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "83N0"),
> > +             }
> > +     },
> > +     {
> > +             .ident = "Lenovo Legion Go 2",
> > +             .driver_data = &quirk_s2idle_bug,
> > +             .matches = {
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "83N1"),
> > +             }
> > +     },
> >       /* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
> >       {
> >               .ident = "HP Laptop 15s-eq2xxx",
> >
> > base-commit: a8cdf51cda30f7461a98af821e8a28c5cb5f8878
>
>


