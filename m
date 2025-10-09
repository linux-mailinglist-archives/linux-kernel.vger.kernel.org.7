Return-Path: <linux-kernel+bounces-847104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543CBC9DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37204189364D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AFF21B9C5;
	Thu,  9 Oct 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYKFIKAi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81398217F2E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025062; cv=none; b=u7YGTImtnJacv73xwQ+P1qsrCX/Aj5Po7siIJeiawPEKgD+bSSZfJXz9frKYLvCwIhpD0OV4CT3hO7VpBS2cCtuWtfpTSPB9V1bPfxRCs7UaEeOKIO+x/BQ+SuInkXAuapt9abEzCvCrNEMU0c72PYhBZbPnC1bXI5+MVCZK3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025062; c=relaxed/simple;
	bh=oqCiSEaK/CXbJQc5Mfhj+q2z2MDVR57q4sgvaV8GGOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hanJOhRyKzBXRnA9SjdHjF62QfXnHp+R2YKAPo4qTmkMAcrjAtpuv/KRobAeSSHSF3Vp8p36IFpro/ATSZMks7FLB4OOcabTkOS2WDmKU39S5LPLwQZtRUq3RUbS/SUs3fL4Hr2LVIj8o6RzFId2X8ywD39nBUt7Fv8hDMnI59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYKFIKAi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b35e176dbso1338370e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025059; x=1760629859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+VNY9R8yQKDAJxRqhzKPZJpQZDH8tA/l3NpvhAQTr8=;
        b=kYKFIKAiPg+y4Mv0IH+1+BCvIQqtOYGC+tEN4ErLWJpuMwoPMOqIP1xh4DeIDsY0a4
         /fBHw4vdesJ0y/hZKnZImPxC1MfMBW5HHnoledNQwekkZTane31Wd06xzjjDNa9+612A
         xw2IAUH8D0DDPo/Z4klAX3ELyqqUAc90q+drU3CIMZH4d39q2M/76gWv/7yJ09SpT1xF
         pUcF7g1dpjReF3Rqb/4OcYwXXheLCSvooOikgqFlovX21KR/RuIh9G4Z2WDFIAsauPf9
         8sYoDm2QoYNr1G8AtCarzgC0aC5rDxLxToAlSI3ZQe8ovenxxKAnZHehJOd7Z3/OCc9k
         2d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025059; x=1760629859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+VNY9R8yQKDAJxRqhzKPZJpQZDH8tA/l3NpvhAQTr8=;
        b=CI/+KnyO4bmcV2QB2ntoN738b3OL+vdRrEK3ih8Lb+An+3Vm6jB6syk4k7JNrHpvNL
         +8fUnWSmI8/EmMeQCxpovGFOQhNuZzU0WFeOto4dKnin/clWtv2AYD1h0Ztlts/zdlds
         x5DOTi0/UrH5K8kaoq+wHpkayBwFH9UzOKob+48M8t3KvYZNle5L85ggH0tgQhT7Z5fO
         nRPUM/V8HsPkurooukewGFWt1xdk5K5KWQRVS8Km7godD8Xx6BdTVI1VxvBnn/HFoHdI
         6mWy18rpDZyc6k2F2Hzwp8sa+PJhxEZyrPxHdzDjEaGBhzlMA4uauX2EkTo9Br66KODr
         3unw==
X-Gm-Message-State: AOJu0YyO8Unw8A/2U+XPz0kMfiiErYgYcmIwkw7mNA+mIRaC5U38FC2a
	um7sFcEufJ2CdC8Z5o3pCHdr8riANvnXbn9V570TIkj57lFfGeVTcz1j+DefwTA03BhihjAmiQI
	XI5O0Ur/S49s3hbAKbQ4CeoYA5oelTpU=
X-Gm-Gg: ASbGncvdKZc7aRu7IfjyhQ7bWm/97wEJU44QDBKbKxPQfkRLZUhiqkCwDiYZucBH1/F
	ccaDoZtrZNLx0hbEf9eKGo/gxtb/cB/3Q0PUUMg9MPT2J0Q40Gs33xuDGzoX4OBHhgcpYcrVZLE
	mM7z/Ne4CVvSVRW2QrIgU+53jiwuRe+Ac2clH1hqSo+dhv761uDAdlXY6T3zzNCiZDHBaGo6sPs
	PEgxHG1Mvy8ECaTYu0lYpTO/0iRne9Bb3y6JNYKpFxGXrkP+bglaMmPgA2OX3T2/6HdwLGPPA==
X-Google-Smtp-Source: AGHT+IGCz6kyrNMGZfF7mHGiGA1mN6qo/DBfCwuR4XMn/PLCmliuIqx/GMYKMcFBKeHDxiG/EoYou5Gzuu9tNjb3+7A=
X-Received: by 2002:a05:6512:3e04:b0:579:b74e:eed4 with SMTP id
 2adb3069b0e04-5906d8e71c8mr2109959e87.37.1760025058333; Thu, 09 Oct 2025
 08:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <87zfa016bd.fsf@osv.gnss.ru>
In-Reply-To: <87zfa016bd.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 12:50:46 -0300
X-Gm-Features: AS18NWBh7SBpC1ZKOpXcFQcgndJY0ccsddCUh_06BPZlHfLhXkFfuz7yJ_izvfc
Message-ID: <CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Angelo Dureghello <angelo@kernel-space.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Thu, Oct 9, 2025 at 11:46=E2=80=AFAM Sergey Organov <sorganov@gmail.com>=
 wrote:

> > I tried booting 6.17 on an imx6sx-sdb board and it booted
> > successfully:
>
> Now after further investigations of the issue I find that success
> a bit surprising.
>
> I've found that my problem is cured by a commit in
>
> https://github.com/nxp-imx/linux-imx
>
> that works-around an issue that looks like imx6sx generic problem, and
> should probably cause troubles on imx6sx-sdb board as well, but doesn't?
> The commit is:
>
> commit 65cf3a49ab15cdbbede3c97fd6bba731a3cd366f
> Author:     Anson Huang <b20788@freescale.com>
> AuthorDate: Tue Aug 18 15:53:54 2015 +0800
> Commit:     Octavian Purdila <octavian.purdila@nxp.com>
> CommitDate: Thu Feb 23 14:21:42 2017 +0200
>
>     MLK-11375-2 ARM: imx: disable cpuidle for imx6sx
>
>     i.MX6SX CPUIdle with ARM core power down has issue
>     and cause system hang during kernel boot up, disable
>     it for now and will enable it when busfreq driver
>     is ready.
>
> Later (by the DAG, not by date) on the same imx_4.9.11_1.0.0_ga
> branch at that repo, there is:
>
> commit 816978f83b1d8dd6ce3bd5dd62223dbfdf74bdd3
> Author:     Anson Huang <b20788@freescale.com>
> AuthorDate: Mon Oct 20 16:16:20 2014 +0800
> Commit:     Octavian Purdila <octavian.purdila@nxp.com>
> CommitDate: Thu Feb 23 14:21:42 2017 +0200
>
>     MLK-9708 arm: imx: add low power idle support for i.mx6sx
>
> that effectively reverts the aforementioned commit while adding a lot of
> other stuff. The resulting kernel also boots fine on my hardware.
>
> Curiously enough, neither of these commits are there in the latest
> branch lf-6.12.y there (and that kernel hangs on my board as well.)
>
> Provided the latter commit is indeed the right fix for imx6sx support in
> the kernel, what's the procedure to get it to the mainstream Linux
> kernel?

It seems that your observation matches what Angelo (added on Cc)
reported a long time ago:

https://community.nxp.com/t5/i-MX-Processors/imx6sx-kernel-hangs-at-rootfs-=
mount/td-p/964920

I'd like to know if the bootloader version plays a role in the
different behavior that we see on the imx6sx-sdb versus your board.

I used U-Boot 2024.07 on my imx6sx-sdb. Which version did you use? Is
it based on an old NXP U-Boot tree?

Does using a recent bootloader make the hang disappear?

