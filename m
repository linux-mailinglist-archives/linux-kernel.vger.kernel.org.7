Return-Path: <linux-kernel+bounces-881160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B8C27975
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F80B4044ED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6A92749C5;
	Sat,  1 Nov 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBxXoixk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEA26A0BD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984600; cv=none; b=uQZJgqpub3ghC667cmafBnoQNnv9/cuTw0eYuC65u2majMd6GtuBrm0vQF7w64VHBSheIOBFu0PcOQ4zpvHr6e4CLhm6QIfoMjGcrf9jlXPRX2Qd5vQ7uZqaSUGU+BZEf212ouaS7gC//JofLHaBkxBJB7KOqdGyOcKVr0k52i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984600; c=relaxed/simple;
	bh=bCsEm0pxWIq601ilo0zSNS/tbcHGgSqWB+cUQTCIWjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HscVrJKS7pCRFbz7P5oRMMvC06gP4omsV0jTT9bycH/H+m0iaM3fpCOy0qE2r+3HZsfK+j45VAl4iZ7b9SouVxQOAxYBnz4Bs/XJmBiY0j8H+fVLR2kUV5tzhJ+jvY2kE+AqarEAv6Zf3dJ5KYpUEiptFxP0996fJrJg4UjrNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBxXoixk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso7709200a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 01:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761984597; x=1762589397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0mQAWV3XfpMeJi9ai8J8FQrA7XgmRdoJSKbFj4v+kE=;
        b=OBxXoixkGnkpJZIfHE0jLbJmO0KFJyiq143+bRsBwGjgK+u3tOheNlgfTZqjm2C1MT
         XAUZ9JI/F0ACLP6AZnmwCt+ocGQyBueneTJiMNJ0VFwXkSBtra0R13rYAAtFAVmlfc0Q
         n0oBhByADRy2QHN6Y46TnGOek/G/f0o/qg1DUtZduJZVbLEdM1fXZMY8RvTXkVX63nMZ
         CArmN1nNuMgNaq0wseLzxJRYh6s8cGSg8L5R8NJOnliJG3VaAu4HyhX0IzTfl6uVKLte
         ls50xibceS94V3gbwIZrPX2h2q5/QNqRJWg8TJSBlB7NY2uylbBozdk8xgWpSrY10k5v
         Ye+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761984597; x=1762589397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0mQAWV3XfpMeJi9ai8J8FQrA7XgmRdoJSKbFj4v+kE=;
        b=ry2ZFP8Fz0pLqwIru1f5CqLHxZEzKcRfXSwGpJ4rutMBLVf8/NBTDiEKLRNgYnmjZ1
         InQsR8CbJD/ktaF448L8Q9FxT/HPGXt6hl1rBGifFMNLDZLGCx/yDjs7k2wYuTsm1cj+
         x5q5t3buiwz9amplndvewU3b5kp5LaheBK6awe302Vdf6ctk+ecfEyVCa1DQFdHmGASB
         OWsLb3yJoHTZeXKsIe7MXzb5v5CLGSxPde1wqrwfORtyXA26w5I8HbCl/A906EA4MCfu
         tjhuMYc6JTmtqQv/ya95wrobwNcbHi2AGz9RDiFtUo7MKmvpAQEjxCISqPhgDz+8sWpX
         0YaA==
X-Forwarded-Encrypted: i=1; AJvYcCUqLMDMeVBppxHrmiPmGTL8XQuRbUJkVOpaJ2SL5WotsYixR5UZm4rbRYEuJqax8d7HZ3A07QTCeuvaKRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5KOyMOIoOG8qa3fOiGqQ7/PvANCpMT25jIaI1VVmNcSMb5PJ
	tyqH6n9ADv/qTl0JaJOXtPx36vxjJt77Aj9ozFA26+oUFEtmPMJPXsLE05XMStKdK1nXPOhDXNb
	QlqpZSe1pfoSdklsLnoY3k93oywofPGU=
X-Gm-Gg: ASbGnctdA8/G4HGF7hgPo+sUS+8S6HNV51vmZrbxIW8WSny1aEguJcSftS34qzl0ea/
	fz7UuvH2/rSgMrmojpF2nKVUH1LsRae5NID3rtQI/Eom4DxJke7JbwoYLHXZVCDWw/oRivjadgK
	UYXNm2s8oXyRiwB62EiuWZD5P2/b9g0hf8kyTKc2JVnPLOiYUqLZHxvgn++87+iG498GRGnHVSC
	ZtKWm+SDc7tTrcUy9O4eW7IraRFube0uFhGsjb3OufhGPWvU8+V7T6eoPA=
X-Google-Smtp-Source: AGHT+IEStKAQTy8wZtpmhPqSnnW8TO7bXnzRVtqDvw1DcTKtsF9EE994q0FWQ6fL+UQYmZUp56Mhe4DohrV4ECJKEvI=
X-Received: by 2002:a17:907:3e02:b0:b6d:ba72:7524 with SMTP id
 a640c23a62f3a-b706e270c58mr803014966b.11.1761984596818; Sat, 01 Nov 2025
 01:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-3-linux.amoon@gmail.com> <ukgkfetbggzon4ppndl7gpitlsz7hjhzhyx3dgxqhdo52exguy@bqksd7d27lpy>
 <CANAwSgTECOAoKeJS_=HxkkTP4OJvYu5xGQxY__Auh81v3QT=-w@mail.gmail.com> <e7cttuu5525k7ryvmkh6ifspm5vloj4muazvmp3yxtkgsdtbjs@u4odsfurejxq>
In-Reply-To: <e7cttuu5525k7ryvmkh6ifspm5vloj4muazvmp3yxtkgsdtbjs@u4odsfurejxq>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 1 Nov 2025 13:39:41 +0530
X-Gm-Features: AWmQ_bn4roPSmQJ8KCYtDIOw3rDpVxIdUMmrjbDOUs1b7sXIsyCe60QAiCMVpHM
Message-ID: <CANAwSgTRFMiSN8Q-tndvVXk7NxuNJE7GmcBXq46RQ=Z6-qOLEw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: dw-rockchip: Add runtime PM support to
 Rockchip PCIe driver
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan

On Fri, 31 Oct 2025 at 20:23, Manivannan Sadhasivam <mani@kernel.org> wrote=
:
>
> On Fri, Oct 31, 2025 at 07:33:23PM +0530, Anand Moon wrote:
> > Hi Manivannan
> >
> > Thanks for your review comment.
> >
> > On Fri, 31 Oct 2025 at 14:09, Manivannan Sadhasivam <mani@kernel.org> w=
rote:
> > >
> > > On Mon, Oct 27, 2025 at 08:25:30PM +0530, Anand Moon wrote:
> > > > Add runtime power management support to the Rockchip DesignWare PCI=
e
> > > > controller driver by enabling devm_pm_runtime() in the probe functi=
on.
> > > > These changes allow the PCIe controller to suspend and resume dynam=
ically,
> > > > improving power efficiency on supported platforms.
> > > >
> > >
> > > Seriously? How can this patch improve the power efficiency if it is n=
ot doing
> > > any PM operation on its own?
> > >
> > I could verify that runtime power management is active
> >
>
> This is runtime status being active, which is a different thing as it onl=
y
> allows the runtime PM hierarchy to be maintained. But the way you describ=
ed the
> commit message sounds like the patch is enabling runtime PM of the contro=
ller
> and that improves efficiency (as if the controller driver is actively doi=
ng
> runtime PM operations).
>
> > [root@rockpi-5b alarm]# cat
> > /sys/devices/platform/a41000000.pcie/power/runtime_status
> > active
> > [root@rockpi-5b alarm]#  find /sys -name runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/power/runt=
ime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/pci_bus/00=
04:41/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/net/enP4p65s0/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/net/enP4p65s0/enP4p65s0-3::lan/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/net/enP4p65s0/enP4p65s0-2::lan/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/net/enP4p65s0/enP4p65s0-1::lan/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/net/enP4p65s0/enP4p65s0-0::lan/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/mdio_bus/r8169-4-4100/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/mdio_bus/r8169-4-4100/r8169-4-4100:00/power/runtime_status
> > /sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00=
.0/mdio_bus/r8169-4-4100/r8169-4-4100:00/hwmon/hwmon11/power/runtime_status
> >
> > Well, the powertop shows that the runtime power management is enabled
> > on Radxa Rock 5b,
> >
> > PowerTOP 2.15     Overview   Idle stats   Frequency stats   Device
> > stats   Device Freq stats   Tunables   WakeUp
> > >> Good          Wireless Power Saving for interface wlan0
> >    Good          VM writeback timeout
> >    Good          Bluetooth device interface status
> >    Good          NMI watchdog should be turned off
> >    Good          Autosuspend for unknown USB device 2-1.3 (8087:0a2b)
> >    Good          Autosuspend for USB device USB 2.0 Hub [2-1]
> >    Good          Autosuspend for USB device Generic Platform OHCI
> > controller [usb1]
> >    Good          Autosuspend for USB device xHCI Host Controller [usb8]
> >    Good          Autosuspend for USB device Generic Platform OHCI
> > controller [usb4]
> >    Good          Autosuspend for USB device EHCI Host Controller [usb2]
> >    Good          Autosuspend for USB device xHCI Host Controller [usb6]
> >    Good          Autosuspend for USB device EHCI Host Controller [usb3]
> >    Good          Autosuspend for USB device xHCI Host Controller [usb5]
> >    Good          Autosuspend for USB device xHCI Host Controller [usb7]
> >    Good          Runtime PM for PCI Device Intel Corporation Wireless
> > 8265 / 8275
> >    Good          Runtime PM for PCI Device Rockchip Electronics Co., Lt=
d RK3588
> >    Good          Runtime PM for PCI Device Rockchip Electronics Co., Lt=
d RK3588
> >    Good          Runtime PM for PCI Device Realtek Semiconductor Co.,
> > Ltd. RTL8125 2.5GbE Controller
> >    Good          Runtime PM for PCI Device Rockchip Electronics Co., Lt=
d RK3588
> >    Good          Runtime PM for PCI Device Samsung Electronics Co Ltd
> > NVMe SSD Controller SM981/PM981/PM983
> >
> > PowerTOP 2.15     Overview   Idle stats   Frequency stats   Device
> > stats   Device Freq stats   Tunables   WakeUp
> >               Usage     Device name
> >               1.1%        CPU use
> >             100.0%        Radio device: rfkill_gpio
> >             100.0%        runtime-rockchip-gate-link-clk.712
> >             100.0%        PCI Device: Realtek Semiconductor Co., Ltd.
> > RTL8125 2.5GbE Controller
> >             100.0%        runtime-rockchip-gate-link-clk.717
> >             100.0%        runtime-rockchip-gate-link-clk.714
> >             100.0%        runtime-rockchip-gate-link-clk.489
> >             100.0%        runtime-a40000000.pcie
> >             100.0%        runtime-a40800000.pcie
> >             100.0%        runtime-rockchip-gate-link-clk.718
> >             100.0%        runtime-rockchip-gate-link-clk.706
> >             100.0%        runtime-rockchip-gate-link-clk.708
> >             100.0%        PCI Device: Intel Corporation Wireless 8265 /=
 8275
> >             100.0%        Radio device: btusb
> >             100.0%        runtime-fcd00000.usb
> >             100.0%        PCI Device: Samsung Electronics Co Ltd NVMe
> > SSD Controller SM981/PM981/PM983
> >             100.0%        Radio device: rfkill_gpio
> >             100.0%        runtime-fc000000.usb
> >             100.0%        Radio device: iwlwifi
> >             100.0%        PCI Device: Rockchip Electronics Co., Ltd RK3=
588
> >             100.0%        PCI Device: Rockchip Electronics Co., Ltd RK3=
588
> >             100.0%        PCI Device: Rockchip Electronics Co., Ltd RK3=
588
> >             100.0%        runtime-rockchip-gate-link-clk.711
> >             100.0%        runtime-fc400000.usb
> >             100.0%        runtime-rockchip-gate-link-clk.704
> >             100.0%        runtime-rockchip-gate-link-clk.701
> >             100.0%        runtime-rockchip-gate-link-clk.716
> >             100.0%        runtime-rockchip-gate-link-clk.707
> >             100.0%        runtime-rockchip-gate-link-clk.709
> >             100.0%        runtime-rockchip-gate-link-clk.719
> >             100.0%        runtime-xhci-hcd.1.auto
> >             100.0%        runtime-feb50000.serial
> >             100.0%        runtime-rockchip-gate-link-clk.715
> >             100.0%        runtime-rockchip-gate-link-clk.710
> >
> > > Again, a pointless patch.
>
> This patch might make sense on its own, to enable runtime PM status of th=
e
> controller so that the runtime PM could be applied to the entire PCIe hie=
rarchy.
>
I will update this in the commit message.
> > I implemented a .remove patch to ensure proper resource cleanup,
> > which is a necessary step for successfully enabling and managing
> > runtime power for the device.
>
> How a dead code (remove callback for a always built-in driver) becomes ne=
cessary
> for runtime PM.
>
Ok, understood we don't have platform_driver_unregister in
builtin_platform_driver
I will drop the first patch.

> - Mani
>
Thanks
-Annad
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

