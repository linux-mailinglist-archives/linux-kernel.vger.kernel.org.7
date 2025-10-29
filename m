Return-Path: <linux-kernel+bounces-877047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78476C1D108
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0425420C52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422535A148;
	Wed, 29 Oct 2025 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EABGJVls"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54033F369
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767686; cv=none; b=QBp3To3K5glqfggUTxpqpQ62tG0hgL+RsBQkB87Nx3cuIOT911stauAPQ8drkJpNbEl2MUPILcbqQwh/hA3Q6tNNnOCQJ5QeUWE4vifkkTF/7Kmaf8eyxq+7fh8I3iI2HUXoGUKJCcRpzdOXn1WK7QoBqRj6mY7qKN9LKdQ+pdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767686; c=relaxed/simple;
	bh=byIwb2P1xzSyr7J2uiJPoWxM/iVSABJR6EsR8lHx1IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaVhdg4ZQI/IbFBubHtMxWNck6GQT+fMfuCT4TH7B26ozHeghwgfE+wDAKLc2PIQKIHE5o+Osha/pazNywmhWuVvt6ggaxFMVfWuTZRYq+2jJR3Dmega9YhUJ6eUOAUxHhtSVxXgQEiikC+b+tcw/UkHfPak9eAhbeeXl38AVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EABGJVls; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592ff1d80feso239186e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761767683; x=1762372483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byIwb2P1xzSyr7J2uiJPoWxM/iVSABJR6EsR8lHx1IA=;
        b=EABGJVlsIzlENWjl88+JnLNvWYpEpfoji3CFjGsIycxaBnrElD8wX/Cm+kKzIeOd4r
         kOn++9nwD/dcTEUcDJfv2+yoViWCCctsFGPfmqO5vgm3vLTz5pxJdDkfh7vdvIePFb7T
         gNyEb9f0dvcZDGwsqE5tekfh6teafGDFRtfsdHD7mwf5hspSCA13pYiQW985vG90ldtx
         22wG489KTZwKnGevLxLY1MbpQdirFXpz2Sbs2CvtWmWsuBONVcKJg9hULLf0OaAFsY2+
         xqZBSWpNhRr/F39OeuS/N6rl3oJ7P3xcv/pi/UO0n9supusdqiKk1U8lewDQS7cQwZfX
         oB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761767683; x=1762372483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byIwb2P1xzSyr7J2uiJPoWxM/iVSABJR6EsR8lHx1IA=;
        b=jvZlPWePA5ne7uRGDSKWiJ+lxj0VYYCsa0hogw2q4lN+DVgQogQDi7MRjbh+oAMKp6
         xdwohk3RjWIjGE2ImczQ/8qtWm2Hyy6ylGM6qj0Cxj49fJSK8dAV0zj+NR/RVRuHty1H
         aD1l3FmVa8IpsnWSEZ9vrMk4Jb4pTW/uUZr4gipAh5rH5wDGCsTP0HjE9IWLCjAqY8Fl
         hRgXxO0F4sCpTwRji1T+TQ38dMIbOc/DcU1CHF95DxoHTXR53HNd6R3zhus9jN865v7J
         VWrqgBBucr3+y/k5OgGH7LqoGVkkT3Ei6NR2PlEBc3c04UqRotkHeIRYFZNqHXGJVmMx
         u4AA==
X-Forwarded-Encrypted: i=1; AJvYcCW08zWIoTnc4eikG/FkJNKRKNVtPlOHQcSwsNCDqWQvj7IJVUSON/CXye9IIQa+wymJA7y1wnHfEN9HR4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YaUSpzjL5oVyBfxFFFPmi40L3MChzMhIZ6uYw+PVJ09621i5
	jvmmjdbViyy4cVEAKbPu5DSDpYVCYtzeEMIjpknD1rOyOMprvJHAiybFgb8rHZkwU4S0ft+CAHH
	//Xz9Mk8l2s8bJQR/aydW4HGS8ucNs4tv7Q==
X-Gm-Gg: ASbGncuNbnejVMwXiwxiBfphGnvSUf5P5elT/IHx6o0JKoFgtzPFrS64hZ/xIJ3uk99
	PotlmuppDdy0k3qj4pRJ8xOdBHaTEFmDpuRKzQ7LTE0yIyHbgT8znLe3lRnKFOvBLY2zaJGmo1M
	AD1rqTyLTnnpxDjp7r2V9xzIskS9O7uE+dkiHTEyb94qaFaZNmgGjo+2iW6TTtKqzK7DQ6H0ocJ
	3EAHmjtJX+jDScZ24Tdujh+XgwbsCEuN+/94cRg3297Hit/pab5nfqqTCfN
X-Google-Smtp-Source: AGHT+IE6nugI1RSYlE3lv5TXNplpg9rsZEQvlWlTN2w7AYCpm8+Ow1fHujfDgKlmIubO4wrE3hHviFIzmPX3ZC2l8So=
X-Received: by 2002:a05:6512:2206:b0:591:c473:5bc7 with SMTP id
 2adb3069b0e04-594128c4d81mr1440914e87.50.1761767682551; Wed, 29 Oct 2025
 12:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803-p3450-mts-bug-v2-0-6307125408c3@gmail.com>
 <20250803-p3450-mts-bug-v2-1-6307125408c3@gmail.com> <8ed69b4c-f656-47fa-a247-1c8d94dcc35d@nvidia.com>
 <CALHNRZ86NjcNJhRJd+jtD_7fRTFJ2szPFAAN3HSad_xwnVrHWQ@mail.gmail.com> <0049bde1-15e2-4c33-8de9-49f3df0d7650@nvidia.com>
In-Reply-To: <0049bde1-15e2-4c33-8de9-49f3df0d7650@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 29 Oct 2025 14:54:30 -0500
X-Gm-Features: AWmQ_bl-wrrhUBBpyLWRd1g2YRWbeHiuYgX2sFzM3mLqIPmPO5WuwhlB1ygmVeg
Message-ID: <CALHNRZ_odC8jcu9h_ZKJ9+449pBhmYfXF=vBkprxYkqXhabM9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: tegra: Add reserved-memory node for P3450
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:32=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 24/10/2025 18:46, Aaron Kling wrote:
> > On Fri, Oct 24, 2025 at 11:16=E2=80=AFAM Jon Hunter <jonathanh@nvidia.c=
om> wrote:
> >>
> >>
> >> On 04/08/2025 04:14, Aaron Kling via B4 Relay wrote:
> >>> From: Aaron Kling <webgeek1234@gmail.com>
> >>>
> >>> The Tegra210 L4T bootloader ram training will corrupt the in-ram kern=
el
> >>> dt if no reserved-memory node exists. This prevents said bootloader f=
rom
> >>> being able to boot a kernel without this node, unless a chainloaded
> >>> bootloader loads the dt. Add the node to eliminate the requirement fo=
r
> >>> extra boot stages.
> >>
> >> I test this platform and don't see any problems. I assume that this
> >> would prevent the board from booting.
> >>
> >> What bootloader are you using? Is this from a particular L4T release?
> >
> > Please see the longer description of my setup on the revision v1 patch
> > here [0]. I am specifically using the cboot prebuilt from L4T r32.6.1
> > as it is the last version to support usb input in the fastboot menu
> > [1]. The rest of the boot stack is from L4T r32.7.6. The partition
> > layout xml is here [2], which requires setting odmdata bit 11 to allow
> > reading bootloader partitions off the sdcard. There is no u-boot
> > involved, only cboot.
> >
> > I've had another report of the same issue, on a pure L4T r32.7.6 boot
> > stack as well. The Nvidia downstream u-boot won't copy
> > external-memory-controller nodes, namely the memory-region ones, from
> > the cboot dtb to the kernel dtb unless the phandles match. Nv-tegra
> > gitles isn't working right now, so I can't link directly, but on
> > branch l4t/l4t-r32.7.6-v2020.04, file arch/arm/mach-tegra/dt-edit.c,
> > see line 31. Which means that such only works if u-boot destination
> > FDT is the downstream dtb. Using a mainline dtb causes the
> > memory-region dt tables to not be available, thus the emc kernel
> > driver fails to probe and emc clock stays stuck at 204MHz on
> > p3450/p3541. Hence the user from the report trying to cut u-boot out
> > of the mix in order to get emc scaling. And then hit this issue.
> >
> > You were able to boot with a mainline dtb on the DTB partition and a
> > kernel on LNX, without u-boot and without this change? I have not been
> > able to do this. The boot flow will get past nvtboot_cpu, but falls
> > apart inside cboot due to the corrupted in-ram dtb, never getting to
> > kernel logs.
>
> Yes, I am using r32.5.1 currently (which was probably what was available
> at the time I enabled testing). But with this I am able to boot an
> upstream DTB with the upstream kernel using cboot (no u-boot). However,
> please note that I don't use the upstream DTB for the bootloaders (MB1,
> MB2, cboot, etc). I specify the kernel DTB in the
> /boot/extlinux/extlinux.conf file so only the kernel uses this.

So the problem is with memory training, which is run in
TBC/nvtboot_cpu. Iiuc, which is a limited understanding, mts primes
with the dt emc tables from the bootloader dtb from RP1. Then if dt
emc tables exist for the kernel dtb from DTB, it will copy the trained
data to there. And on newer l4t versions, I don't know which version
that started on, it will copy to a reserved memory location and set
the location in the kernel dtb from DTB. This piece will fail if a
reserved-memory node doesn't already exist in the kernel dtb from DTB.
Causing the cascading failure described before.

For Android, cboot just boots an android boot image on LNX. There's no
u-boot, extlinux, etc etc. I've got the downstream dtb from RP1, since
the bootloader only works with the downstream layout. Then I've got
the mainline dtb from DTB for handoff to the mainline kernel.

Extlinux isn't useful for my usecase of android, but I'm in contact
with people using Linux distros. So I'm curious if your setup copies
the reserved-memory nodes to the extlinux FDT. Like, does the emc
driver initialize properly and allow scaling?

Aaron

