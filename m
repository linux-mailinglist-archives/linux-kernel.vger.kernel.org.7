Return-Path: <linux-kernel+bounces-733895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42CBB07A54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA9D7BA06D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94252F6FAF;
	Wed, 16 Jul 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgKqTKQp"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986C433AC;
	Wed, 16 Jul 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680904; cv=none; b=blt+yBOHXawsZCQK9skXKtwyFQPPxIIVN6Om+zkXjjMG505F83Fd5G09PBMCk9I1Bzqlc3qwdTwrBhY9cs9s+4Fo+pBPUE+AOiV3gxA5RlsoxE86ZbGvzvWTfZC54DfE5bKXH/HYoH/A9eczNuyuZiY6ekj9wGUJkQwNUmu5dqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680904; c=relaxed/simple;
	bh=luNcCeVwgq4z+l5cMRU2yESpupALk7pbDHbenqpr7AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH6n0dBhjLwEi9BmAUETOq0/yW+5CLf7WG56jCYwLuO8WHfXTj7x3BQ2we5e0C8VNXziGlAy1RNlHAgAbRPVXSfkKUhojb6+uSfKyY4ShSAClG1F8FThnmFilSAb/bW0G/CFUQs60PvcvOAgvJExTPho6lzLUTgGf9JK208U7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgKqTKQp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a77ffcb795so455331cf.0;
        Wed, 16 Jul 2025 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680901; x=1753285701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/rm8scvzUXrihtknqjtLAemYGQPHMAAfEFq95mpGyA=;
        b=DgKqTKQpDnjj94Ku8vUlNe1lW7W+4MFvx2bQfx+rhnMApb6wwTk9QWHVNuQBd7ZHaQ
         1gj494u3Xicl5Ne7gFlLiCDMTreF+6J4bzOOgJCP4xFsc3GXuvoU+xC96nKOLvZIFOEt
         JAhxw/8Hx9+DNTcGhbMCDOr57ccpj4taUwuOXTRgcf+mn0TdgAzUToYEdQluel1uywct
         UeUUsqSoiyiUyPPfU2DwSrKFwIfTpi6gilJUUzgrnDXgnswq6xen97asKtNZBBknYWgU
         686Z/R5VvTcW/7Y0umj26L01yoZpWB9neojEpl16igiFWilb05/DcPYKE7pcEgs8/hYj
         Gkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680901; x=1753285701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/rm8scvzUXrihtknqjtLAemYGQPHMAAfEFq95mpGyA=;
        b=QUL8ZShrGvyXhcOsAHooiQlP0LpNwuWTJT+Nnl7MnLY+ONBZXGhzG0ey+Wo/JoXaxE
         4YU1r0Mbo1j9J0Y6SDsiiNzzwB7KGXIL4Eaw+kXPC4K7CG4PvatmHi73n/ylVH4YeoSm
         8i0lZ8063pMIabCt040PXa08h5BLGkKy6BO8ooyWJPRCs+BLwIaYiczpmkZDwo+CdiW9
         3imXRArkD9slmojMJjAcBpB0uJqWwLKIGf1Yxc2Aptfv5k8KHLKzZCLmJD+xjoIPpKnE
         QBrQMpgiNFT0bydU1wfIQ6VmYZ/msktUAAlkQFj9p8n41QUeJDkJ56j/Qhdlj5KnOHl/
         Jrlw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQBimSk3lrU2Wf6WdHNTK9Jn3anbqTZrEEghWZ/bQTZDLUlvn5mscOjKAKuulhds0YgKU9GD3pg6n@vger.kernel.org, AJvYcCUJLaVPC9UpiN0vv0SzZ/5pkNwzO6k+pAA4UOSuhr3t5qkVRy3GR7VFh84ySexpxWiMdVAOm76i0MK2pJwO@vger.kernel.org
X-Gm-Message-State: AOJu0YylVfi1ku9Qx9t5e0MP9X0lHpsDfHuDb13Uk15ZGEPIixSX5zNT
	o4YZF7LyHQxOg+MIxkRjhHZmF4V83oexHsZCgcLZL3bvrGbQ3eoOBAE8eNWEYM9aoc/Onaxppa3
	envpBJJqJWQTNXoIohRK3Gr5gKuo04JM=
X-Gm-Gg: ASbGncvAN3ki73VmFrOOh0j8V6G7YJQE8gRQ9Kz2JuKq2hmlwUOBl52rw7Zibaffxmy
	oVyLGc4D107/34oZREqJtmJDgQBD3ccjXuPQyw5Bvn8l2PZn+4lSzqoPP8dNG8jMjhfPDGTGwLV
	WtyjKy8YDlmZ9eAY4LZfsnmsqf/H0IsTpAdAIW7O16+Dr+p0+XoenLB9cRgAHbcyG+jsJsprcmU
	L5xl2wZ
X-Google-Smtp-Source: AGHT+IGZkuwYf/CRlFpg8ouV1Ni1Gc+/D2pROcmk1GXPjk7rcMxm2v3iwcET9Iy7rmi/yw6IZUJYr4N4D+vNkrJvXEw=
X-Received: by 2002:a05:622a:1309:b0:4a7:70a5:e726 with SMTP id
 d75a77b69052e-4ab90cc9bedmr58696201cf.52.1752680901038; Wed, 16 Jul 2025
 08:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABjd4YzCL3U9yf65FUBE6EMqFjZHosULU7fUcjVo9VJ_=Ov+Dw@mail.gmail.com>
 <20250716143016.620430-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250716143016.620430-1-amadeus@jmu.edu.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 16 Jul 2025 19:48:09 +0400
X-Gm-Features: Ac12FXy9WoL4TICFh6J03oGYZT5PkKMhZ242n-cx_vXoVMHQVGR-YEvxeooikVM
Message-ID: <CABjd4YzVqOssjMH0VUiUJF78dV9n6Dq6EipWYqUXoxHu6ehUSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency
 scaling support
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de, 
	jonas@kwiboo.se, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	ziyao@disroot.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:30=E2=80=AFPM Chukun Pan <amadeus@jmu.edu.cn> wro=
te:
>
> Hi,
>
> > > There has often been the argument that selecting a frequency that has
> > > the same voltage as a faster frequency does not save any power.
> > >
> > > Hence I remember that we dropped slower frequencies on other socs
> > > that share the same voltage with a higher frequency.
>
> Sorry, but soc.dtsi on rockchip doesn't seem to have dropped slower
> frequencies with the same voltage?
>
> rk3562.dtsi: CPU 408MHz -  816MHz 825mV | GPU 300MHz - 600MHz 825mV
> rk3566.dtsi: CPU 408MHz -  816MHz 850mV | GPU 200MHz - 400MHz 850mV
> rk3576.dtsi: CPU 408MHz - 1200MHz 700mV | GPU 300MHz - 600MHz 700mV

They were dropped for RK3588 when merging the CPU OPPs that I
submitted, after respective feedback from Daniel Lezcano [1]. GPU OPPs
for RK3588 were merged before that discussion, so they still carry
"lower frequency, same voltage" entries.

[1] https://lore.kernel.org/all/731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro=
.org/

> > I.e. here the mainline kernel will always choose opp-1008000000 as
> > long as the regulator voltage is 875000 uV, unless explicitly
> > prevented from doing so by userspace. Whereas the BSP kernel [1] would
> > request different frequencies for different silicon, e.g.
> > opp-1200000000 for a silicon specimen with a leakage value of L4 and
> > opp-1416000000 for a silicon specimen with a leakage value of L8 - all
> > for the same regulator voltage of 875000 uV.
> >
> > So my 2 cents would be: no added benefit in having "lower frequency,
> > same voltage" OPPs defined here until we implement an OPP driver
> > reading the NVMEM programmed leakage values and selecting different
> > *-L* voltages for each OPP depending on those. Once there is this
> > support in the drivers, those OPPs can be added together with
> > leakage-specific voltages (opp-microvolt-L0..11).
>
> I assume this has nothing to do with the NVMEM driver?

There is an OPP driver in BSP code (for v6 BSP kernels) or a custom
cpufreq driver (for v5 BSP kernels) which read factory determined
leakage values for the particular silicon specimen from an OTP (NVMEM)
cell and select different initial voltage values for each OPP based on
that. Those voltages come from opp-microvolt-L0..11 DT properties,
where -L0..11 represent different leakage values. Default is no -L*
suffix.

These are then further tuned in the BSP code by stepping over adjacent
regulator voltages until the PVTPLL provides a frequency closest to
what the OPP defines. The kernel then uses this calibrated voltage for
the particular OPP instead of the original DT provided one, as it
better suits the particular silicon specimen and operating conditions
(PVTPLL =3D process, voltage and temperature adjusting PLL).

The calibration process can result in varying voltages for PVTPLL
based OPPs, even if the DT listed the same voltage for each, so it
might make sense to list those once OPP calibration support gets
included in mainline driver code. Before then they won't be used by
any of the energy aware governors and would thus only add bloat.

> From [1], we can see that the voltage used by the same board from
> 408MHz to 1008MHz is the same. The actual test is also like this:
>
> The first  board: CPU 408MHz - 1008MHz both 850mV | 1200MHz 862mV
> The second board: CPU 408MHz - 1008MHz both 875mV | 1200MHz 875mV
>
> [1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64=
/boot/dts/rockchip/rk3528.dtsi#L227-L271
>
> > Right now OPP values with frequencies lower than 1008000000 won't be
> > selected by any of the energy-aware cpufreq governors anyway, because
> > their voltages are the same. Exercise for the reader: try to convince
> > e.g. the "schedutil" governor to select anything below 1008000000
> > without touching
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq :) This may
> > change if OPP tuning logic is implemented such as in [2]: that will
> > try and find the _voltage_ resulting in PVTPLL providing a frequency
> > closest to what cpufreq requested, and use that for the in-memory OPP
> > table instead of what was provided by the DTS.
>
> Thanks for the clarification, so should we remove 408MHz, 600MHz and
> 816MHz from the opp-table? Is this also the case with GPU's opp-table?

I would say yes, drop for now and add them later when the need arises
(i.e. once we have driver support for OPP calibration using
PVTM/PVTPLL feedback).

They do not hurt per se, but they result in something unused right now
becoming part of the device tree ABI, thus limiting options to rethink
stuff later.

Best regards,
Alexey

