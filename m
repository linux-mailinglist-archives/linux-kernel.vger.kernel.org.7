Return-Path: <linux-kernel+bounces-815677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C026B569BD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DAA3BA9D4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A41FE45A;
	Sun, 14 Sep 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOUlbR7E"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9851F7575
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859886; cv=none; b=p1mXN+DtOxX5am5CeDBTEfP6FZp+DEZF9Rj0YkZ1NTpjU27xm8VR9ntROFBY20EJxF83+ATcknW/EkdAOhKc+YL2bC0WD3lm/JpmM13JRs3QeNJqzfy4u4rCvijfEii/AnQvIxV8Wb3/qT/XEQZ4MWgCNuzfOT6PECJi/cg8Dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859886; c=relaxed/simple;
	bh=W9lhcPQWYJCkan7KXgFZubDkcctJGU3MKVzKoE7qJJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5Fqxl4kH/10+JwOHZoi2pdSrK1D4x3udep0LoAk6gchXs203aM4to1UeQLkEXZhiyf1qs1Hyo5t9jzGr2eIkF+73ND76tSRCp6GteK9lZJAE6wEtW7mNsePTmtAjkdEKAEjZsZYieuo/NLNBCTeh7l8ZgwORImpJZTZuwIAFXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOUlbR7E; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f720ffe34so3879963e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757859883; x=1758464683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOL0NG0zrkRA/YQSYESdMqzkPZLcb4cVfP68XzHxZyE=;
        b=OOUlbR7EyCHxqtSIAxrA+u/f/9oGKZIcudmDCPjEcQBVLCDI46rpKpnHLYnsXq+zrJ
         His8MFiZVkZpPkF1bwSyESdD6vVYgblpPc2oW0U5Y++ajqWwIEQ7g1D61bRz67Bshkh5
         tfQpVB8vUflQK+Us/F9cqM/SnGwqTg25YKHO9KTdbvrv8QBeeMyfbf4hxpeJOUq51ovI
         IYqg2Fv87XpIus0qgP0CAA6EFC9AhfaSartmhoXeny2dEqWigG5RPxueWkf96BamFY44
         DJhc4dGvH/z8ulLn2y/GMkVdKiBipYt47/L3SgiQz12P64u6a00VtSy+0mBoeIezf9Do
         s+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757859883; x=1758464683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOL0NG0zrkRA/YQSYESdMqzkPZLcb4cVfP68XzHxZyE=;
        b=ddY2TjkVfYEWkBzg+nTqDPlkciEuLEMcj0UFjTM/noNxZ3uVSzOQUyODyPw9lz+L9W
         Xb1RWkDeqP3f/8qtrfvZ4Vz2ApR5W7UREAQbRdGcPZiPD5nT8bctDhqPyhPWcCfWspo7
         KepOXRaO6sl7wDIfiqzmAKQMCSqhuk2uxIWEZKSvBZY6VHFa017rUwciMmS7w6ZWy4kD
         LpsB3hU7cj7iMYd0AaT7Uiy0G9RRa2tw1v6Bs62PQN8tg8n6tBc/TulG7h8ZOsJjzXK9
         D9ed1gSx0WLfAl8JedZV4ZuRou4KE17NzdzhQB9ONyJZEIh1uyP0ohmU7wJvR+imsS9M
         vPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpuNsj/Z/wvymiGkfSLhb0YNuwydLDdoC5GLk3+gXr5yx8uzS+3LkeSMYAp3Rai0iWjY+fa4kbbsvflD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSUf4gl8uG73O8eqK35mfbFNg/ZXx57JHgiru8VlQIlejhvTNW
	xO3v8zYcowI2RoK3ctbUg3+4jJRA/ZvXp6FwlMJKRtgfAYFzY8Nm1NR9QhVuHb89LUxMq4e2lJl
	fz8hHRZtg1LwtgGgKvygJFBmEyYRYYTk=
X-Gm-Gg: ASbGnct9Jp9UrDZ86F598YpiasOWlZuJPjZi8IlQgdVcMwk+dd5LGs86kzHYeRhlj49
	WSRude65UVLXbCvZkWQVzVTNZX2SAsROxkncEdSqTSzjRTu9YeDi/TEKIngaZbLh+mZWFxg4/eU
	sssE+NaUnw4mfxf0uQa7coBoyy+rHea3YChugOg+P3bpW2NsJKpE/kF+hfMMPSyM5XYD4T9xMCw
	TG3/J7GJV7k5wGsFg==
X-Google-Smtp-Source: AGHT+IGlv2ax57xdAxcgpKY7t6yHDH97U54LvSlSNzVOFQKCGM9THTfZg99iHUHNfg3ngRBiUo+Ka2Gu4jNs1BVijrs=
X-Received: by 2002:a05:6512:1256:b0:55f:6bc8:19b7 with SMTP id
 2adb3069b0e04-56d79b23437mr4070925e87.15.1757859882794; Sun, 14 Sep 2025
 07:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513-tx2nx-role-switch-v1-1-d92ea1870ea5@gmail.com>
 <CALHNRZ8H66g98ThQKZJAT2UohVNtt6OS=rKd5wtcT1YwBLURqA@mail.gmail.com>
 <CALHNRZ84+KGwioU=7ZOL=O39cR_VSRJBaV42MsA4fymXNJC6+g@mail.gmail.com>
 <CALHNRZ9zfjV-ZttJd_ydgEaWk7XB+3YPfKGuYXLBL9qA8Exv0g@mail.gmail.com>
 <CALHNRZ-HTFz38xZFsbpG6C3r_xDQTLNOZWPX21TzNPaLyxf6Xw@mail.gmail.com>
 <xmirimw2guubgrf6umt4qiknpyjaepkrx4oggcmaffoyd5sli2@kzewnjv3bkjf> <CALHNRZ9uJ9g6BGhUmBaaMM3DhQDh7mTtqKKr0A98X-5V4ompEg@mail.gmail.com>
In-Reply-To: <CALHNRZ9uJ9g6BGhUmBaaMM3DhQDh7mTtqKKr0A98X-5V4ompEg@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 14 Sep 2025 09:24:31 -0500
X-Gm-Features: Ac12FXy5JXU7gOyeU6ClkGO-LvqM22dVNb4lFs5nwsHzDncJiwk16On4YrZpLD0
Message-ID: <CALHNRZ-7LFz=C70hWBPox2EYD-t=Cs-buN+N=4xVGaNHg41ahg@mail.gmail.com>
Subject: Re: [PATCH] arm64: tegra: Remove otg id gpio from Jetson TX2 NX
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 1:56=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
>
> On Fri, Aug 1, 2025 at 4:43=E2=80=AFAM Thierry Reding <thierry.reding@gma=
il.com> wrote:
> >
> > On Thu, Jul 31, 2025 at 04:36:17PM -0500, Aaron Kling wrote:
> > > On Mon, Jul 14, 2025 at 12:35=E2=80=AFAM Aaron Kling <webgeek1234@gma=
il.com> wrote:
> > > >
> > > > On Mon, Jun 30, 2025 at 2:27=E2=80=AFPM Aaron Kling <webgeek1234@gm=
ail.com> wrote:
> > > > >
> > > > > On Wed, May 28, 2025 at 12:42=E2=80=AFPM Aaron Kling <webgeek1234=
@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, May 13, 2025 at 4:10=E2=80=AFPM Aaron Kling via B4 Rela=
y
> > > > > > <devnull+webgeek1234.gmail.com@kernel.org> wrote:
> > > > > > >
> > > > > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > > > > >
> > > > > > > The p3509 carrier board does not connect the id gpio. Prior t=
o this, the
> > > > > > > gpio role switch driver could not detect the mode of the otg =
port.
> > > > > > >
> > > > > > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dt=
s | 1 -
> > > > > > >  1 file changed, 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p=
3636-0001.dts b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.d=
ts
> > > > > > > index 26f71651933d1d8ef32bbd1645cac1820bd2e104..81f204e456409=
df355bbcb691ef99b0d0c9d504e 100644
> > > > > > > --- a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-00=
01.dts
> > > > > > > +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-00=
01.dts
> > > > > > > @@ -669,7 +669,6 @@ connector {
> > > > > > >                                         vbus-gpios =3D <&gpio
> > > > > > >                                                       TEGRA18=
6_MAIN_GPIO(L, 4)
> > > > > > >                                                       GPIO_AC=
TIVE_LOW>;
> > > > > > > -                                       id-gpios =3D <&pmic 0=
 GPIO_ACTIVE_HIGH>;
> > > > > > >                                 };
> > > > > > >                         };
> > > > > > >
> > > > > > >
> > > > > > > ---
> > > > > > > base-commit: 405e6c37c89ef0df2bfc7a988820a3df22dacb1b
> > > > > > > change-id: 20250513-tx2nx-role-switch-37ec55d25189
> > > > > > >
> > > > > > > Best regards,
> > > > > > > --
> > > > > > > Aaron Kling <webgeek1234@gmail.com>
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > Friendly reminder about this patch.
> > > > >
> > > > > Re-reminder about this patch.
> > > >
> > > > Yet another reminder about this patch. It's been over two months
> > > > without a response and many other patches have been pulled in the
> > > > meantime.
> > >
> > > Reminder yet again about this patch. It's now been two and a half
> > > months without even an acknowledgement from the maintainers.
> > >
> > > This one is getting annoying. What does it take to get a response fro=
m
> > > the tegra subsystem maintainers? Does time have to be pre-allocated b=
y
> > > the company to look at patches that aren't from @nvidia.com's? Are
> > > there certain times during a development cycle? When responses happen=
,
> > > it seems like there's a lot of activity. But then everything goes
> > > silent again for months. I've not seen any pattern to it so far and
> > > it's becoming extremely frustrating.
> >
> > Just people being busy. Nothing more, nothing less. I'll pick this up
> > once the merge window closes.
>
> If I understand correctly, the merge window closed on August 10th. And
> I still haven't seen any movement on open patches. If everything
> unrelated is on hold until after Tegra264 launch or something like
> that, it would be nice to at least set that expectation instead of
> everything being held arbitrarily in suspense.

Is there any intent to pick up this or any of my other pending patches
for 6.18? Once again, I see many other things queued for 6.18-rc1, but
not this. This was sent in before 6.16-rc1, and now looks to be missed
even on 6.18.

Aaron

