Return-Path: <linux-kernel+bounces-692250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74282ADEEED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 16:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0B57AD933
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF442EAD09;
	Wed, 18 Jun 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hwL7rjVx"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F82EAB86
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255957; cv=none; b=gKYKBcLuwugbgLPIzM4FDGXNZ7MI7vR8XWl2qrSctUFHgyAjGR+7tvykjc+n5fXmOob+MuGayqx8hrvEbl6Nlk5BY3+S/hGhKgW1uA54dxRUdJsKjLUwu7n+nIkY6pZ31jUxnxexTTJX6tyH4DQ6rNJmSfI3977Qvp9U3/aGCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255957; c=relaxed/simple;
	bh=7kj7G2jswNX3K0YTdwCRIBC9FAqoENBLPyK5Aq5xsG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDUjEIsIcPxg3hszuqa0BxIzsQ48CKUaFAAzB4XiZ41im2VqmHfJV7/MO7kQUL0UXa38qbDT4V56ZziEIT2P/w2Spi8W9lVDj1GSz3NcVVgQTn3MoMrFjkDBCGiOifJorZnZmQeIwAChDYg99avd2M+qgaNIweHckNWSEV9dZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hwL7rjVx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so10664833a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1750255952; x=1750860752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz84Hc3uQ6sKBV5PwfzjhcRcDvTwqgSKPuxbgQX5TiY=;
        b=hwL7rjVx7+zCjsgfT/jaB+YQC3AUTUKtmx0B18LgDMmsDoxkiuaEhtcN9m1DphsY05
         A0Or5UbDzrWx5JnGTb6P16sUKCS6s0MaZOYi5a0J57Bd6LbIWTtfH3cq5NR0qbhDyqgu
         6vEMyawYoA7vM70lxtjqlsnMVSuMIfl2y3bbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255952; x=1750860752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cz84Hc3uQ6sKBV5PwfzjhcRcDvTwqgSKPuxbgQX5TiY=;
        b=wqZn1vHUfH0SglpA0nR4OAt9dDtnyWJZ4x5QNUqVvqpUJhAPig1ECaZCMeG8MDlwbT
         Hzi/nqIbqrwE/Hc4yuReKvhAoI1/22IgZg04su8PhkRcis5bLP787tb3hLxWYggcG7uy
         0vgrw0ksp0MDvgkpMwzzuv+mZKdb7017N5EP2UKam44VVxLT5niNMfV/7SBmPKmvecxq
         LB+uVzLJaA4EFe8stAO9a4Bf0KMMwmRIWOQUK37bVRy16vMCZx38DFu7ARWltngJCNCM
         uoVHqSuiP62cKNPraeBWxRnmksJElzEm1OHvigAPN46DG3N3756tfaOA21P06w9FOaCA
         l6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3uGw1xKlo2C8oC3csLEsuoY44BD2BTOg/DKtWBIIJdH10/zh5rE5HnJCbu4n7GIJOLGOvM3IppkVAMDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5X/n+hlyE93Rs3lidFl8XazwQ0u58KZ7ffsicoIUtcrfLju5
	1r5NgpMd6Fu9ygPjBer1Dkwuf/jQNDD3I5xV5UmPnHXSUKE8E6TYrlGx6BG48eDoSEY=
X-Gm-Gg: ASbGncsNjG3CIFcVE7MadC4tKguzUGbf1IPSVExJxq/U8PO9h9i8McclIXQ1bHeJFHi
	eXq8vgRr202MT06wW68P/lUEjTV4+YFe+DnDRzxRKZOqBGrW+5OQ1qYk5px6Bp9i+Mbz4ybTEQy
	hNYwrkpbMi4wvHA2ZDqhPbuY2jm8qwniT5FX5/hQsOHx6FqLAJLGhHaFMUWnsouOy2Vh0iZIMHL
	eTzTrjXo5iR3VtAlVDjN7vYtz2nKv4ZMmyGRvP1NHk8jrTLBBLJMO4wGT/Lc/NZc6SfNag7rRrJ
	NpHj5lU2TZJXwhgyFbsYNxnlnS3um+2y2M7sfEprhAKBhDSAPkXFf/CcN5ghiRlvMxd1ii8MmA=
	=
X-Google-Smtp-Source: AGHT+IGngqXytowFqo9vFefDWIVGWRd6341iJxu/XHfEW5ddA5khtLzeGEkme1kvilPhkRGvjw4AVA==
X-Received: by 2002:a17:906:9f91:b0:ad8:9257:571b with SMTP id a640c23a62f3a-adfad32fa19mr1651880266b.16.1750255952414;
        Wed, 18 Jun 2025 07:12:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8929371sm1062739466b.117.2025.06.18.07.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:12:31 -0700 (PDT)
Date: Wed, 18 Jun 2025 16:12:29 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <superm1@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:VFIO DRIVER" <kvm@vger.kernel.org>,
	"open list:SOUND" <linux-sound@vger.kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 6/6] vgaarb: Look at all PCI display devices in VGA
 arbiter
Message-ID: <aFLJTSIPVE0EnNvh@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
	Mario Limonciello <superm1@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux.dev>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:VFIO DRIVER" <kvm@vger.kernel.org>,
	"open list:SOUND" <linux-sound@vger.kernel.org>,
	Daniel Dadap <ddadap@nvidia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
References: <20250617175910.1640546-1-superm1@kernel.org>
 <20250617175910.1640546-7-superm1@kernel.org>
 <20250617132228.434adebf.alex.williamson@redhat.com>
 <08257531-c8e4-47b1-a5d1-1e67378ff129@kernel.org>
 <4b4224b8-aa91-4f21-8425-2adf9a2b3d38@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b4224b8-aa91-4f21-8425-2adf9a2b3d38@suse.de>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Wed, Jun 18, 2025 at 11:11:26AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 17.06.25 um 22:22 schrieb Mario Limonciello:
> > 
> > 
> > On 6/17/25 2:22 PM, Alex Williamson wrote:
> > > On Tue, 17 Jun 2025 12:59:10 -0500
> > > Mario Limonciello <superm1@kernel.org> wrote:
> > > 
> > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > 
> > > > On a mobile system with an AMD integrated GPU + NVIDIA discrete GPU the
> > > > AMD GPU is not being selected by some desktop environments for any
> > > > rendering tasks. This is because neither GPU is being treated as
> > > > "boot_vga" but that is what some environments use to select a GPU [1].
> > > > 
> > > > The VGA arbiter driver only looks at devices that report as PCI display
> > > > VGA class devices. Neither GPU on the system is a PCI display VGA class
> > > > device:
> > > > 
> > > > c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
> > > > c6:00.0 Display controller: Advanced Micro Devices, Inc.
> > > > [AMD/ATI] Device 150e (rev d1)
> > > > 
> > > > If the GPUs were looked at the vga_is_firmware_default()
> > > > function actually
> > > > does do a good job at recognizing the case from the device used for the
> > > > firmware framebuffer.
> > > > 
> > > > Modify the VGA arbiter code and matching sysfs file entries to
> > > > examine all
> > > > PCI display class devices. The existing logic stays the same.
> > > > 
> > > > This will cause all GPUs to gain a `boot_vga` file, but the
> > > > correct device
> > > > (AMD GPU in this case) will now show `1` and the incorrect
> > > > device shows `0`.
> > > > Userspace then picks the right device as well.
> > > > 
> > > > Link: https://github.com/robherring/libpciaccess/commit/b2838fb61c3542f107014b285cbda097acae1e12
> > > > [1]
> > > > Suggested-by: Daniel Dadap <ddadap@nvidia.com>
> > > > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > ---
> > > > � drivers/pci/pci-sysfs.c | 2 +-
> > > > � drivers/pci/vgaarb.c��� | 8 ++++----
> > > > � 2 files changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > index 268c69daa4d57..c314ee1b3f9ac 100644
> > > > --- a/drivers/pci/pci-sysfs.c
> > > > +++ b/drivers/pci/pci-sysfs.c
> > > > @@ -1707,7 +1707,7 @@ static umode_t
> > > > pci_dev_attrs_are_visible(struct kobject *kobj,
> > > > ����� struct device *dev = kobj_to_dev(kobj);
> > > > ����� struct pci_dev *pdev = to_pci_dev(dev);
> > > > � -��� if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
> > > > +��� if (a == &dev_attr_boot_vga.attr && pci_is_display(pdev))
> > > > ��������� return a->mode;
> > > > � ����� return 0;
> > > > diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> > > > index 78748e8d2dbae..63216e5787d73 100644
> > > > --- a/drivers/pci/vgaarb.c
> > > > +++ b/drivers/pci/vgaarb.c
> > > > @@ -1499,8 +1499,8 @@ static int pci_notify(struct
> > > > notifier_block *nb, unsigned long action,
> > > > � ����� vgaarb_dbg(dev, "%s\n", __func__);
> > > > � -��� /* Only deal with VGA class devices */
> > > > -��� if (!pci_is_vga(pdev))
> > > > +��� /* Only deal with PCI display class devices */
> > > > +��� if (!pci_is_display(pdev))
> > > > ��������� return 0;
> > > > � ����� /*
> > > > @@ -1546,12 +1546,12 @@ static int __init vga_arb_device_init(void)
> > > > � ����� bus_register_notifier(&pci_bus_type, &pci_notifier);
> > > > � -��� /* Add all VGA class PCI devices by default */
> > > > +��� /* Add all PCI display class devices by default */
> > > > ����� pdev = NULL;
> > > > ����� while ((pdev =
> > > > ��������� pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > > > �������������������� PCI_ANY_ID, pdev)) != NULL) {
> > > > -������� if (pci_is_vga(pdev))
> > > > +������� if (pci_is_display(pdev))
> > > > ������������� vga_arbiter_add_pci_device(pdev);
> > > > ����� }
> > > 
> > > At the very least a non-VGA device should not mark that it decodes
> > > legacy resources, marking the boot VGA device is only a part of what
> > > the VGA arbiter does.� It seems none of the actual VGA arbitration
> > > interfaces have been considered here though.
> > > 
> > > I still think this is a bad idea and I'm not sure Thomas didn't
> > > withdraw his ack in the previous round[1].� Thanks,
> > 
> > Ah; I didn't realize that was intended to be a withdrawl.
> > If there's another version of this I'll remove it.
> 
> Then let me formally withdraw the A-b.
> 
> I think this updated patch doesn't address the concerns raised in the
> previous reviews. AFAIU vgaarb is really only about VGA devices.

I missed the earlier version, but wanted to chime in that I concur. vgaarb
is about vga decoding, and modern gpu drivers are trying pretty hard to
disable that since it can cause pain. If we mix in the meaning of "default
display device" into this, we have a mess.

I guess what does make sense is if the kernel exposes its notion of
"default display device", since we do have that in some sense with
simpledrm. At least on systems where simpledrm is a thing, but I think you
need some really old machines for that to not be the case.

Cheers, Sima

> Best regards
> Thomas
> 
> > 
> > Dave,
> > 
> > What is your current temperature on this approach?
> > 
> > Do you still think it's best for something in the kernel or is this
> > better done in libpciaccess?
> > 
> > Mutter, Kwin, and Cosmic all handle this case in the compositor.
> > 
> > 
> > > 
> > > Alex
> > > 
> > > [1]https://lore.kernel.org/all/bc0a3ac2-c86c-43b8-b83f-edfdfa5ee184@suse.de/
> > > 
> > > 
> > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

