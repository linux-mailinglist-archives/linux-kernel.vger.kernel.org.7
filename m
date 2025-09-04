Return-Path: <linux-kernel+bounces-801227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E67B44265
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C56FA00387
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CF2F3C0C;
	Thu,  4 Sep 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUTZoGyb"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BE2264BA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002441; cv=none; b=is68YP4gwiN0EentF9xG3WY3CbvBuqb1oq2C9xrslDUJN8p2Qvm05YsjXJeoy7de/ysApus/9NLu7Bh6yqPsacXzeCloUIBv9RR5QtIKbaRT2GTBwboMcZCY65OV4tObtgv2H03ruOgKLyq7Uf0D1PPR0I4Y96N2l9n9tYqYzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002441; c=relaxed/simple;
	bh=SCIQY83Ai8L6ppcKGEoiXaAz3OxldpZnLcgYpg99d7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQQZirAUrQN23K3gVw9b/7P1zP91YCRJr/1jS80xur/gRThVaBnvspM+2B37sDLMN6T1LB7kbBdKJCem8pWVOCoVtU6jFtQKt05LxAIRkF2/CsPsE6p2VtC2QqtmpbAtgcn3Yqj+ijIi8E0znEq1lWuDmwmBD/dziMB1fV5Yaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUTZoGyb; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d6051afbfso12999127b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757002439; x=1757607239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34lNRxMzfknWqY04/AB2pJSWANkSMT5gO6BsVZXifm4=;
        b=tUTZoGybKf5NO1TbvCn5D/0BXtDiAhaC56u/iaiXBs7ktFYED47SF49PI42QVnnatd
         wJ5XQ6n7KiAjrxaw6i6wvksPkMLlqjZgf3CTfzp7VksIlu52YFCyau6lOAov6MVOB89j
         dCj6e5yQXs6MfJ+LASfl5BklE/9NnpM3TBXBxlwlKk9N19S4MHP6PJgkOR3Q5MMOEI2P
         9Qa9R2q1PQHe24UvPOrkwgr4w07kPHC922eJFUWacf6i3x3yYhXhF2vpVsXsn3MAiD9K
         XnPheOr2gvrpRBn8pWAmwALFcvoG6Py3Xl/2CF5KPpPetrnS36eXJ7hQOaZqBxmf2FcC
         tVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002439; x=1757607239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34lNRxMzfknWqY04/AB2pJSWANkSMT5gO6BsVZXifm4=;
        b=KFycFcBYHRFEDgIjIpnuZkOTCrPRmrYjkKFdq7V0l60ANprFhIRRmm/syNmWsLWhRO
         4QgVgc0+BRDL6XApXTZT5dAvBK5LUds949VWF9Vlllcs2hwwyqzT2SAcoxh3qyDZUz1x
         5BmjA6WeWru1YGbOSvN+4/eZYAlGjL1vh9WSxqlmrXP7nUFC2nqTJqNWo7iQpDptDjld
         EoRW28xiIUF3s8mn4X3Au621XqWj5vo2naDCALa25cSykOIEcRC3tuV1SYHIPp5jsG+4
         FJk4tTX13LIkOyhe7dNcZEboXYh6doOGI8k7QQJCLgcR2Rll62FxwkH5J2ELcFEoW3tY
         Au0A==
X-Forwarded-Encrypted: i=1; AJvYcCUGycwD1Utl9b5YoXLVurg3I0S0HwEX6JXpAbggsSc/tZ1Ei/H/5Ah5KCQK3FbngEWb/ydQj/MRMNZaPGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzbpczR/BxmGDgewh0r3ieSaRCqCOFXuFFH3HYZnSRQAfXj3C
	YqbH4v1awLD/wOO8ekD2WcYc56Wyg6JGy30Xyd32QJbd54xY3+wjk8LS7AwajZyKz4S2hdFhTtQ
	L8SJLlo9O6WYZf76HBRyzJ9oNMiX4gSehfNeb7rjyUVrFxZCRFmbi
X-Gm-Gg: ASbGncvXuXzuhVJtqE0hIkWq9fE3/txQjggLoHiVWE56Eh7Egfp3OaDfcNro3e5M4Fe
	xNw/iful8tvNgPRPBeUvi+AnWCiRcG74CGUcTopyNZogcwwzO8kuUl2N39i/hYfcqq0qVbXD+ln
	QBvdO1FwlJpBdcDFXVsRJUAuWxx9g8LWY0IAsNyw1GrxDuuraWgzN/dnPsm3zVHiDvqIW7WAHM9
	ZvhOKutKd1frzZ+p6U=
X-Google-Smtp-Source: AGHT+IFe25JJfIitrkNKnpsxQsW1d7VW/a+cN6wV++u6O89PnozjGikgZBb8eB5tx+iecXdZ104l7hvqarDF0/07phY=
X-Received: by 2002:a05:690c:892:b0:71f:b944:1035 with SMTP id
 00721157ae682-72276570b19mr190820407b3.50.1757002438362; Thu, 04 Sep 2025
 09:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <CAPDyKFpAOLiBOoAhv+GQcobU_g_AWrB9iyOGmodROLtRmR30JA@mail.gmail.com> <3332408.jE0xQCEvom@workhorse>
In-Reply-To: <3332408.jE0xQCEvom@workhorse>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 18:13:22 +0200
X-Gm-Features: Ac12FXz9UlnEpxChoPr8ZDpfm4GCrxu0_n8TKBl4W_IvQlCRnoCLN10fhI0kdWY
Message-ID: <CAPDyKFqBgKxhUCaNwUAMHUKorCPH44AfCe1VncO7jU-soy39Dg@mail.gmail.com>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, linux-rockchip@lists.infradead.org, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 14:50, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Thursday, 4 September 2025 11:17:01 Central European Summer Time Ulf Hansson wrote:
> > On Tue, 2 Sept 2025 at 20:23, Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> > >
> > > This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.
> >
> > I can't find this commit hash. What tree are you using when testing this?
> >
> > Are you trying to revert 0e789b491ba04c31de5c71249487593e386baa67 ?
>
> Probably, I did the revert on a rebased branch and then rebased the revert
> onto v6.17-rc4 so it likely is the wrong hash here. I'll fix this in v2 if
> there is a v2 (it might actually become a different patch, see huge text
> below, sorry!)
>
> >
> > >
> > > On RK3576, the UFS controller's power domain has a quirk that requires
> > > it to stay enabled, infrastricture for which was added in Commit
> > > cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()").
> > >
> > > Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
> > > genpds on until sync_state") appears to break this quirk wholesale. The
> > > result is that RK3576 devices with the UFS controller enabled but unused
> > > will freeze once pmdomain shuts off unused domains.
> > >
> > > Revert it until a better fix can be found.
> >
> > This sounds a bit vague to me, can you please clarify and elaborate a
> > bit more so I can try to help.
> >
> > What does "UFS controller enabled but unused" actually mean? Has the
> > UFS controller driver been probed successfully and thus its
> > corresponding device been attached to its PM domain?
>
> It means the UFS controller driver has probed, but does not find a
> UFS storage chip connected to it, and therefore reports a probe
> failure. This is a possibility on single-board computers like the
> Radxa ROCK 4D, where the UFS storage is a separate module that plugs
> into some headers.
>
> > Moreover, the behaviour of dev_pm_genpd_rpm_always_on() is orthogonal
> > to what 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on
> > until sync_state") brings along with its corresponding sync_state
> > series for genpd [1]. Again, more information is needed to understand
> > what goes wrong.
>
> The reason why Rockchip's UFS driver needs this function is that once
> the RK3576_PD_USB power domain is turned on on the RK3576 SoC, it should
> not be toggled off again until a whole SoC suspend/resume cycle because
> the off/on operation is seemingly not idempotent.

So how about adding some prints in the genpd->power_on|off() callbacks
to see what goes on during boot. Along with some prints in the UFS
driver's ->probe().

In particular, what is the difference before and after the revert.

> This does not preclude
> turning off the power domain if the device isn't used at all, e.g. the DT
> node is absent. This is why the affected PDs are not marked as always-on
> in the PD init data for the SoC, as the device driver is the best place to
> set this during runtime.
>
> The way I got to this commit is through a bisect between the UFS node
> being enabled on the ROCK 4D (commit 00abee2b18342d6c2f6f37225682fa7ca0d33142)
> and v6.17-rc4. The bisect landed on the pmdomain merge commit
> (commit fc8f5028eb0cc5aee0501a99f59a04f748fbff1c) as the first bad commit,
> so I checked out v6.16, cherry-picked the UFS node enablement, made sure it
> works fine with that, and then rebased the 44 pmdomain commits that this
> merge commit merged onto this base. I verified that the tip of that then
> exhibited the faulty behaviour, namely that my ROCK 4D was locking up
> some time after boot, right after the kernel log message
>
>     [   33.756516] vdd_npu_s0: disabling
>
> so presumably when unused regulators and domains were being disabled.
> Aside note: setting vdd_npu_s0 to always-on also works to work around
> the issue, and I'm not quite sure why, because this regulator is not
> used for anything right now so this may be some peculiar SoC silicon
> design where VDD_NPU is leaking into the part that the UFS PD actually
> should be gating, preventing the lockup on accident.
>
> Anyway, so I did a bisect between the UFS introduction and the rebased
> tip of the pmdomain branch, and landed on the commit I'm reverting.
>
> The problem exhibits itself not when the affect PD is first turned off,
> but when the NPU regulator is turned off. How could this be relevant to
> power domains at all? I have no idea.
>
> I admit that I don't understand the commit I'm reverting, as it talks of
> keeping powered-on genpds on, but the code sets a member called "stay_on"
> to false.
>
> However, reverting it 100% reproducibly fixes the observed lockup. The
> lockup does not occur if an UFS module is connected to the SBC.
>
> It seems `dev_pm_genpd_rpm_always_on` is never run if UFS experiences
> a probe failure, so I'm not entirely sure how this specific commit
> changes the behaviour in a way that makes it unhappy. I agree the
> solution is probably not a revert here. Also, adding an unconditional
> `dev_pm_genpd_rpm_always_on` in the failing UFS probe path doesn't
> work, likely because the driver is unbound. Maybe this is a complete
> red herring and `dev_pm_genpd_rpm_always_on` is unrelated.
>
> The only other device that uses RK3576_PD_USB is the usb_drd0_dwc3
> usb controller. This node is not enabled in my rebase-pd-onto-ufs-enable
> branch, so even assuming the problem is that the usb driver is missing
> the same `dev_pm_genpd_rpm_always_on` call, that shouldn't matter
> becuase nothing else is using that power domain. Unless, of course, our
> description of that power domain is incomplete, which is possible.
>
> The problem may be that this was always racey and the genpd changes
> just made the race go wrong more often.
>
> Another observation: my kernel log during afflicted bootups contains
>
>     rockchip-pm-domain 27380000.power-management:power-controller: sync_state() pending due to 2a2d0000.ufshc
>
> A further observation: pd_ignore_unused does not fix it. Looking at
> the revert and experimenting, removing the `stay_on = false` is not
> what actually fixes my problem, but removing the
> `#ifndef CONFIG_PM_GENERIC_DOMAINS_OF`, even without setting
> pd_ignore_unused, fixes my issue.
>
> This is probably a big enough clue to suss out what's going on; that
> I *need* "[    2.868987] PM: genpd: Disabling unused power domains"
> to run quite early before the regulator that feeds VDD_NPU is disabled
> after the bootup completes unless an UFS module is present or the UFS
> controller is disabled makes me think this is another peculiarity of
> the RK3576 power domains hardware, because none of this I just wrote
> sounds like the words of a sane human.

Thanks a lot for sharing more information!

As I just responded to Heiko's email, my guess is that PM domain needs
the genpd->power_off() callback to be invoked first, before it can be
properly powered-on via genpd->power_on().

In some way we need to make sure the PM domain (genpd) is in a correct
state before we call pm_genpd_init(). Exactly how, I think you can
explore with different approaches.

[...]

Kind regards
Uffe

