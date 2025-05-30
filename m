Return-Path: <linux-kernel+bounces-667921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3AAC8B70
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A0516BFA4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B221CA0A;
	Fri, 30 May 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jx2Tk+lM"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D93221D87
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598543; cv=none; b=TYXa98HhbWK1p659zW4MCQ4V0RJURPGWOflpTcbQgbKXpqBlEoUiQPeEOC6mI9NvBDrqubA83j5d2nzJ3kFRbbT6jSgvrGIqfJlCS83Z4ZTroi35CFlIcHMOTxJD38wf8pwo7ShXLKjLXLDA06ZNm3Nngu2+bnQIxqZ8NGDuiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598543; c=relaxed/simple;
	bh=b0TFhFz66sFrGEwBpP8D9ETS2sHd7pzb9TO/YyI/+/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBZ70pQFGrrtdW0ADJhG0cF0EvZFYy7xxg2ipdWq7EbgDaTjRG571jWDIft6AFAYfFJh5MciBQEVphKWpUDEqCaWFBCm6E5B9Qkc8XAbTqHyzqEilBWRWYUOUmH8gW40xGRGY92UxcRhCsCm+f4FjO4MHVg+UANAj9H1jwrm+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jx2Tk+lM; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-52f404ddf3eso1174092e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748598540; x=1749203340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BX16TfDwmJeuNsVzAioGXDE8NBNHgG/KwWmvHJtVfv4=;
        b=jx2Tk+lM3g9vqnFPZ1EcVbWeoM1sSBlFthcULa+r7zTtIJR3fTRqssvQqIGQ0kOFTm
         x5ig6ZXEMBXl4FwM56HnRBCNcN+Q4iTpAg7fia/pjF+S3KcZduzAbHp+BuUTi4NEUMs9
         wIPMQdPl/Fx6U4Th79fdWaWEIG3l08NheyFvVkNpVhbtqKG/+Ywck45omAFdAIPj9wu2
         AE0lOzG1/W6RWQyBP0BPA6IUkmgsfuKwjwWBlxy6p8ezHOLR/eOr7bjd+OxG/trARuo0
         ZVGTP/CEfHgAVWcT7/zMAzytHbQ6Ibrl1lZARv8a2qIwXjhRcw4i8Mqmfzj89GUdNij7
         WETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748598540; x=1749203340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX16TfDwmJeuNsVzAioGXDE8NBNHgG/KwWmvHJtVfv4=;
        b=Qwfb/I+4oOhnnaMA/8ZLYxHPzn7LODavEjV7XG3s4u1+pr4HokqW6MpmY5L4b2phXb
         JYm1LAICUy9ZMWTy8C68l7Fx+JMR3LC3lbQ73xVfWXXAXUNUfIxA2t5Vz6nyWi6CaN6e
         62SAqIwkSK0IQFAmdCeJ4nBfVqR0+YPPwl2ySOoRRnoD8FVC8LQ6PvGdrYEnw2bhxggK
         onfOPQR50rsRdUtjzwxb+E6UIGt7GZvt9kIFN7SIwpJvX7lSB8q/tRZ67l8MKsx3pOgf
         MHcPogq3T4fpXXBLFiju/0nx/kGgTNQnS+Qa5HACZ/Dypumay21DTZZtI7XBUWgupX/a
         0v7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQP27tTbl0111eVKqHVUtuj8jvXP2mIg17OBTf33Cw0AZBQAj87REGJAK1inxQlPYC/qSUwKkW7el0G80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0u0+wsdvr6jHgIphGzGiwhwDuw2uRgIe+Z0CvouaFHS1ijRO
	zSMWQrjP672oFELuxws2M18z0p11+ILPo3NqfeCDT+bG7Vl12DI2dBxQVM/74Bfg8lVL6ywZ2fd
	VYmTo7R8kgw3N+Ye689gVwenprjraDaOwewYUKoWE1g==
X-Gm-Gg: ASbGncvceEKzyQ/CNZAOIAMjw9gsX2JybpBoh19V3T4m9TRZ2zp1M9oRP1RC/4AersU
	ZaHV06VY8UUbsR5j+5RyTQLZbVvx4nwglBcUzabLYDPPhaxqM2/zrcS/0m39F+CmIOl/CAvjA1M
	oKsZF4ud1kghQy9bjPQqq2J6qdSxMGvSzsavCuwr9aj8Mb
X-Google-Smtp-Source: AGHT+IFCDzCsC18lIEI9eoPRpN1VBwQuWtrYeQzK5FfBQTEKVxOjXzBK+FhiElxrVAbMsJjHyUqfWwTNH+a+X8F2fyY=
X-Received: by 2002:a05:6102:4b08:b0:4e5:8eb6:e8dd with SMTP id
 ada2fe7eead31-4e6e40d655dmr2670174137.5.1748598540530; Fri, 30 May 2025
 02:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt0F_vR-zOV4P8m4HTv6AecT-eEnrL+t5wgAaKPodi0mQ@mail.gmail.com>
 <6e0ef5cc-b692-4d39-bec4-a75c1af3f0aa@arm.com> <CA+G9fYs_nUN2x8fFJ0cfudHWbCOLSJK=OhEK0Efd1ifcjq_LRg@mail.gmail.com>
 <5a277d1d-c7b1-430c-a463-1e307a2823f6@arm.com> <03e6283e-2ef7-498c-9460-8411114711e2@arm.com>
 <e6db6396-cb1e-4e24-8fd0-3cce388a3913@arm.com>
In-Reply-To: <e6db6396-cb1e-4e24-8fd0-3cce388a3913@arm.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 30 May 2025 15:18:49 +0530
X-Gm-Features: AX0GCFuc1bDuO-IvLHLzjp596VNTvH9_C6fgPX5wyzKbvtGEon1kLQjQtXhQSq4
Message-ID: <CA+G9fYuroDkk3qrd7yJJG7twZV0sM=t3mDjhrBMm==q2MjS41A@mail.gmail.com>
Subject: Re: arm64: juno-r2: SSD detect failed on mainline and next
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux.dev, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Fri, 25 Apr 2025 at 20:48, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 11/04/2025 8:11 pm, Robin Murphy wrote:
> [...]
> > OK, I found it, but I'm still not sure what exactly to make of it - it's
> > the pci_request_acs() in of_iommu_configure(), now being called early
> > enough to actually have an effect. Booting with EDK2 already using PCI
> > prior to Linux, here's what I get for `sudo lspci -vv | grep ACSctl`


Linux version 6.14.9-rc1
# lscpi
00:00.0 PCI bridge: PLDA PCI Express Core Reference Design
01:00.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:01.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:02.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:03.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:0c.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:10.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:1f.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial
ATA Raid II Controller (rev 01)
08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8057
PCI-E Gigabit Ethernet Controller


Linux version 6.15.0
# lscpi
00:00.0 PCI bridge: PLDA PCI Express Core Reference Design
01:00.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:01.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:02.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:03.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:0c.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:10.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:1f.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)

> > with 6.15-rc1:
> >
> >          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
> > UpstreamFwd+ EgressCtrl- DirectTrans-
> >          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
> > UpstreamFwd+ EgressCtrl- DirectTrans-
> >          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
> > UpstreamFwd+ EgressCtrl- DirectTrans-
> >          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
> > UpstreamFwd+ EgressCtrl- DirectTrans-
> >          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
> > UpstreamFwd+ EgressCtrl- DirectTrans-
> >          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
> > UpstreamFwd+ EgressCtrl- DirectTrans-
> >
> > whereas with the 6.14 behaviour they are all '-'. I don't have a working
> > root filesystem with the U-Boot setup, but if I boot it with
> > "pci=config_acs=000000@pci:0:0" then the kernel does assign the bridge
> > windows and discover the ethernet/SATA endpoints again. I can spend some
> > time getting NFS working next week, but if you're able to get lspci
> > output off a machine in the "broken" state easily that would be handy to
> > compare.


On the 6.15, After adding this into Kernel boot args
pci=config_acs=000000@pci:0:0

The SSD was detected and mounted successfully.

Linux version 6.15.0 +  pci=config_acs=000000@pci:0:0
# lspci
00:00.0 PCI bridge: PLDA PCI Express Core Reference Design
01:00.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:01.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:02.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:03.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:0c.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:10.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
02:1f.0 PCI bridge: Microsemi / PMC / IDT 89HPES16NT16G2 16-Lane
16-Port PCIe Gen2 System Interconnect Switch (rev 02)
03:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial
ATA Raid II Controller (rev 01)
08:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8057
PCI-E Gigabit Ethernet Controller

> >
> > So at this point it would seem to be something about how Linux
> > configures ACS when doing it from scratch. What I don't really know is
> > where to go from there. I do know Juno's possibly a bit odd in that the
> > switch supports ACS, but both the root port and endpoints either side of
> > it don't. Could this be tickling some subtle bug in the PCI layer, and
> > what is EDK2 doing that makes it not happen?
>
> Just following up on where I ran out of ideas. I poked at things a
> little more, and from a process of elimination, the culprit appears to
> be is that we enable ACS source validation on the downstream port while
> its secondary bus is still 0, *then* we get to the "bridge configuration
> invalid" bit and reconfigure the bus numbers, but after that, config
> space accesses to the secondary bus still apparently fail to work as
> expected.
>
> What's now beyond me is whether this is just an ACS quirk of this
> particular switch, and/or whether there's something we could or should
> be doing in the PCI layer.
>
> All I can suggest a this point is that you could at least sidestep the
> problem on the LKFT boards by updating them to a less-ancient version of
> U-Boot which supports PCIe for Juno (looks like that landed in 2020.10),
> which should then configure the switch at boot such that the bus
> numbering doesn't need to change when Linux probes it - that appears to
> be the only "magic" thing that EDK2 is doing.

I will work with my team to address these issues.
Thanks for your suggestions.

>
> Thanks,
> Robin.

- Naresh

