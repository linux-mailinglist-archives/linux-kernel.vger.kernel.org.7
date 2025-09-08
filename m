Return-Path: <linux-kernel+bounces-805955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1DB48FEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315203C4B06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84AF30B511;
	Mon,  8 Sep 2025 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAmNuxA4"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987FD221546
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338864; cv=none; b=ggbFhl1Ajn/9vlzI/Eq7gz+ol01WhVhXLYo7i8+M/5qqQln75WlUDEiUMnxMB8QYja6khLspyWSCDLhjwEJAQ7qIS0aDGYJ+MVxHkhWiRmW154ogrGpDta23Joke5HEzVGWK/+ASUux6ThMIU9BjVh95+widcVocpR0bSl/lwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338864; c=relaxed/simple;
	bh=2V6Vwf7sjtvRs7wKxbRndIQxMlyKr4SMXFcsQopTXQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMIs54dZ8NlcoBAax5TR1n/agPkgYCvX8zTnp59lRUC58cSN85HVxJVzyCcmQ3wnSel9plTm88sfbNc1uY85ixyX38/x22DRYuQWHrtCRSk85FgEvl7NXHoLreE0MiVk2+nUdgsnA5cDM7KxxdloIzzRql8uuyp9Pmdcz/rKWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAmNuxA4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d601859f5so36774927b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757338860; x=1757943660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2V6Vwf7sjtvRs7wKxbRndIQxMlyKr4SMXFcsQopTXQo=;
        b=AAmNuxA4yO8Xt02cx35nUOfwaL40zNcgcRICxSG85VyMzW4Kyk0580Sna/vqY1h9h8
         TXPTsUyxgow2oVa7CbO87nnJgGMpo6PE0lrBKtoRfdGIMneSVqDNjQDOtlP/7vZtkh8I
         yDoaLM3yDsRAfjpExa04uDoeautG7OkzFeodmG1nDYIdpkbv9JBZzepE/aNDkFGguVD2
         Neln61VCng6REhZpMb2T52O9ACDpkyV/9fSaq6QIIVRux9xQbxC7kymlqrxn8z1tR0Ud
         Kx3WideSQqNoidlPaGuXXa7LFj3ck0trubCdrN+CcZq02yYgkJ83mIUiPl4xGr3h8ACr
         WLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757338860; x=1757943660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2V6Vwf7sjtvRs7wKxbRndIQxMlyKr4SMXFcsQopTXQo=;
        b=PzqAWIfYam0Xg4QfCwzpCpTITMwX0dypCupMHu4Cr7pfXrzuBZFIKyLvukxS+l2G/y
         vUdZ9zxS7IygEh9ppuDXQ74qXmfia2CABaw1qg/3moJmcexrnFbs/qC+x7aFNtRD00IN
         SgZGmZ5TZknMmyrbQ8CrBo5U6/YkEo6W75h1lPzuw4nQwpM58KSglmdJE4G72EwDSWWz
         dLcwZB1KUN89TQ/F0EKIMxNABdN3/lPpPEHWB7wcPpG0ugtHxM2SwAhns7jD24B6EfSv
         4t5D3DmR7lQvAHQ3plYxDQ4N26H1W7rfBr3Jce6cCJXEKZGLq+Xl4Waxr66YN5oDN+b9
         3G3g==
X-Forwarded-Encrypted: i=1; AJvYcCX0lsa4bk1xtJOpbecIaFTogMW/xppxME7BAzngCnwzrRiszBO8/qUq9kvUJNWnhYGMsRMWJx2SCOfXIpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKKKI7AaXgs8Iy4kLQ7qt5gbV+lLB3BJHNv9m7wvz/ix2iqgy
	o6wlcIQGwkItC0LIAndllBxP4f3JZdgsaW+OqXPeK0zNuRm61HVqlCuWARFRzX2zyVVeh33S7Gy
	pFHnXJVPVDT3i83DdI2+Gw0ARQZ4G7gW+m/OtMmOeXQ==
X-Gm-Gg: ASbGncvcBMlnP3wc5b/I0DpudmSIRa2aGpjREXPpq/H4T1R3nopFfFJwmJGdTLdoKNa
	JbYYvbY7O4rF02m79hDzU1NuIEJc74KHED1wzFkdMiNuPzxCkg74el2xxF6Mmf46dNY5x7Nv0Pw
	rRgtGsSocRNiFCyqOAXA4PlmyIjxol1fw9GUhM3SpPU52aWT2jUuStRuuHQUfd96z9/k5VhXA5C
	cPg18xcHgfbQNNZuCM=
X-Google-Smtp-Source: AGHT+IHmVwzJRbbk8lJqzSugvWpjEX8h6lt6E0HqLrB/JptJ9QEOE6Fe9GxsA7Ca2V1UWceelOk9kemT86vksConx38=
X-Received: by 2002:a05:690c:6e04:b0:722:6a27:4346 with SMTP id
 00721157ae682-727f2fb6a07mr77617367b3.13.1757338860259; Mon, 08 Sep 2025
 06:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
 <3556261.BddDVKsqQX@workhorse> <CAPDyKFpSY+FeKh7ocjQ_nGNZA5+3tWAL8e7ZNKXKNFP-yoiu_g@mail.gmail.com>
 <1953725.CQOukoFCf9@workhorse>
In-Reply-To: <1953725.CQOukoFCf9@workhorse>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Sep 2025 15:40:24 +0200
X-Gm-Features: Ac12FXyAG1t2CYpmPKTCcMgEyVYOTn_3NnzPw6TDBeDE4KlE2WO8yjwKgz822rM
Message-ID: <CAPDyKFofhy5wiNsHUgdtzFwGtO3QPqhVuu1KsPLBWHF08JzqyA@mail.gmail.com>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, linux-rockchip@lists.infradead.org, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 15:14, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Friday, 5 September 2025 16:27:27 Central European Summer Time Ulf Hansson wrote:
> > [...]
> >
> > >
> > > Okay so I believe I have found the root cause of the regression. UFS is
> > > innocent, disabling UFS just happens to avoid it due to how the timing of
> > > things works out.
> > >
> > > The real issue is that the NPU power domains on the RK3576, which are
> > > currently unused, have an undeclared dependency on vdd_npu_s0.
> > >
> > > Declaring this dependency with a `domain-supply` and adding the
> > > necessary flag in the rockchip PD controller to use it does not solve
> > > he problem. This is because the rockchip PD controller cannot acquire
> > > those supplies during probe, as they're not available yet and their
> > > availability depends on the PD controller finishing probe.
> > >
> > > That's why it acquires them in the PD enable callback, but the NPU
> > > PDs are never enabled because they're unused.
> > >
> > > This worked fine when unused PDs were still turned off quite early, as
> > > this meant they were turned off before regulators. Now the unused
> > > regulators are turned off before turning off the unused PDs happens.
> >
> > I see, thanks for sharing these details. What a mess.
> >
>
> Agreed :(
>
> > >
> > > I don't really see an easy way to fix this with a patch that's fit for
> > > an rc cycle. We can't request the regulator early or even just add a
> > > device link, as the regulator is not around yet.
> >
> > Right, I will work on a patch or two that allows rockchip
> > power-domains to opt-out from genpds new behavior and to keep using
> > the old one.
> >
> > I think we prefer to do it like this (should be quite a limited amount
> > of code and okay for an rc), rather than reverting for everyone.
>
> That sounds good to me.
>
> >
> > >
> > > Marking vdd_npu_s0 as always-on would be abusing DT to work around a
> > > Linux kernel shortcoming, which is a no-no.
> > >
> > > What we need is either a way to register with pmdomain core that
> > > certain PDs need a late init for additional supplies, which is then
> > > called before any of the unused regulator power off functionality is
> > > invoked by the regulator core.
> > >
> > > Any ideas?
> >
> > Yes :-)
> >
> > I would suggest implementing an auxiliary driver, along with the
> > rockchip_pm_domain_driver. The main job for the auxiliary driver would
> > be to get the regulator in its ->probe() - and if it fails because the
> > regulator isn't available yet, it should keep trying by returning
> > -EPROBE_DEFER. See more about the auxiliary bus/device/driver in
> > include/linux/auxiliary_bus.h and module_auxiliary_driver().
> >
> > Moreover, when the rockchip_pm_domain_driver probes, it becomes
> > responsible for pre-parsing the OF nodes for the domain-supply DT
> > property, for each of the specified power-domains. If it finds a
> > domain-supply, it should register an auxiliary device that corresponds
> > to that particular power-domain. This can be done by using
> > platform-data that is shared with the auxiliary device/driver. See
> > devm_auxiliary_device_create().
> >
> > Furthermore we would need some kind of synchronization mechanism
> > between the rockchip_pm_domain_driver and the auxiliary driver, to
> > manage the regulator get/enable/disable. I think that should be rather
> > easy to work out.
> >
> > Do you think this can work?
>
> This sounds similar to something Heiko suggested to me, and I agree
> it could work. It does seem like a pretty painful solution though,
> in terms of needed additional code and complexity to basically just
> tell Linux "hey you can't get this regulator yet but please try
> again later without our involvement".

Well, I would give this a go and see what you end up with. The nice
thing with this approach, I think, is that we get a driver and can use
the -EPROBE_DEFER mechanism.

Another option would be to explore using fw_devlink/device_links, to
somehow get a notification as soon as the regulator gets registered.

>
> To that end, I've tried working out a regulator-based solution to
> it, where the rockchip_pm_domain driver registers a "proxy"
> regulator for each power domain that wants a regulator, with its
> supply set to the name of the real `domain-supply` regulator.
>
> The logic behind this was that the regulator core runs a check
> for whether every supply is resolved before it turns off unused
> regulators. The hope was that if we register a proxy regulator
> and enable it immediately in the pm_domain probe, then regulator
> core will handle the actual dependency at precisely the right
> time, namely before it checks to see whether any are unused and
> can be turned off.
>
> As I discovered though, this can't really work. The regulator
> core will in this case just set the supply regulator to a dummy
> regulator when it's enabled in our probe function, and later
> supply resolving passes are then content that this supply is
> resolved even though it is a dummy supply. There does not appear
> to be any way to opt out of getting this dummy supply.
>
> So knowing that this doesn't work, I have another idea, but I
> feel like both the regulator subsystem and the pm-domains
> subsystem will hate this: explicitly create an order between
> the pmdomain idle check and the regulator idle check to make
> sure that the pmdomains idle check runs first.

I think those kinds of dependencies are better solved by using
fw_devlink/device_links.

>
> This would set in stone how the kernel worked previously for
> kernel users that relied on this, but is a conceptually
> unpleasant cross-subsystem dependency.

Then there are other resources cropping up that we need support,
extending to more subsystems. So, no, this does not seem like a
scalable solution to me. :-)

Kind regards
Uffe

