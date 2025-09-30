Return-Path: <linux-kernel+bounces-837595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772FBACB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1919416DD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706B25C81F;
	Tue, 30 Sep 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaYreZ5N"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EE2566F2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232021; cv=none; b=sPfeVfbHd8qqMN+HsX98saK84tD77iy8Cig3cPA301/Pu2tW9sdO/B8UG3AwmIceWx/5LSFlwXpLZu5fuA/6b9QDZlkJSq+kaYS8ZLjSQENu4uUNkCNNbvpULNGvfHDurk/948gqMeobjeA3vnQGOuRfOdKwVoID8GD8OAznyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232021; c=relaxed/simple;
	bh=wDs/WMXVmHJglssnG9XWE+nsIv0PIfh++s/inuvdTo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnhkDdU5Lyg8+ThBG7tlvCly3DkMOrNub3gwQ00lyn4K0JcBWv41tgDCe1egsIO/jQakdHHJh/Ca5/Jw+rfUfBRv6mDhsbrUX2nSyX6NtJ/5P0VDTeo3MDPAZ06MNTXSxFhkuPu1uXgEssQulwFgjgGDWkFK8nG1Iq6hTD9lsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YaYreZ5N; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-749399349ddso72290757b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759232019; x=1759836819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wDs/WMXVmHJglssnG9XWE+nsIv0PIfh++s/inuvdTo8=;
        b=YaYreZ5NYDXWdLn0bPOgsjM0IeKWsMpFcrLiWp+Lj1PeYvdjT6SnPaRvCgBEjrFL+k
         1gPFt7enqKfAGekDUBXVZbqm+lwH/O7ThwYR0Smf/FnqCbQVl8T0cg477MSUNEOcakmp
         iM4uJ7RI4bu3h0jbqhRR/DZwmI3kQMgFrUwGG/fKzS+AKfbgooa94S+cgzBc0OnA0yjL
         VsJvhI7zDlM/FC4m51Gpoe8SRCuYF9WuVLsf26gfvN7+2hEvTQS8vgMioy+sHUH/Wdxb
         Ioeeyn97OV9p3m4Mj2+k9yvVq8FUdWstwzfQoadgIXJVmvyUNv2hVATxDQxNyX8ik5KL
         jYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759232019; x=1759836819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDs/WMXVmHJglssnG9XWE+nsIv0PIfh++s/inuvdTo8=;
        b=wIMW53Fk2RSE0YpVNa2JzWb7ti6YAtwCTmJBky//TZhB61anCri+oaMnuvk1w3ayN+
         0kVN9Leuv/D3fT2Hd3uo7CzVln9SF9jCuIxin+6VM7yQSYAL/MAZBkVexRBcqIJ9HsGx
         5oWr+VM7iQ2D1Gde/UCzJLy0itbOkPXcFwhZOz2jE6V8mH+yYbpwF20TIzFU5rpt44El
         HEBXSXDSNJBVNuubaZqBkS+hNKxF+lDjqHcoIVRPHnUpFRdIe34KJXITW9d/JjSWGlRg
         S3DRGUtPIQ+mKFO+Xq10TO5Ia7MoYxUABjn8kPjj1Uf0tfSilNs4YASCUgVyqfItwGed
         pA1g==
X-Forwarded-Encrypted: i=1; AJvYcCWrN4bRpP9rwAGAxgy43oGFEmiyzpq+M6rQ5j19WILVBxQvrX1A1SD1nqYgL5JFLU5FudPcRsCNsKI5Nx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZCtjAd5Drb7W1VXrdW0M818AhH4z8qltfVRZtumELLxXygsf
	q3kfP9KMHBAvguM2+3NUIFiKoRsS98c4kLp04x3cySUmgNQpHHC0XJ/egIJnthMW9knHGhcrmZW
	UM/aEeAaeDTjmavwSQrj3yXZ19RO+hfXXozHMuzgg+Q==
X-Gm-Gg: ASbGnct5Khk5VarjKptB0vT9bY4sTUV3IjvhwBobW49aFAHbPSfVoV0OfjGsz/I2jGb
	y8DoIdjCnreWe3YZFaC8tWMHh/UI3kd97w+tr2fIfk/lyHnmHFNNbeunojPxRyfP808tWvRDdpq
	0pGzEiWhyPXH7iQACx3gT+MKmxPKrGGQ0Ao7jeha2fh2LIzg8JvdwYTKArEpRdRUGbuXXnDzdEG
	Y3lM2hWsyqbWTlT0PrtUbW6Db9uQbpP
X-Google-Smtp-Source: AGHT+IHYmCvXrXmx8HmNfb0uqyUyQC6vlR8zFTUyxQ5hryXAvEjUkDhlD0XShN9tuuH78Lwr0Mzk9/lfRrtMdvf7nzk=
X-Received: by 2002:a05:690e:15d3:b0:633:a326:3b07 with SMTP id
 956f58d0204a3-6361a85ed4bmr19217063d50.24.1759232018880; Tue, 30 Sep 2025
 04:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-21-ulf.hansson@linaro.org> <4478f28b-47f8-4049-bf17-b7fc95cfac65@nvidia.com>
 <CAPDyKFqSyP3e=JRFYEuFefWVN5SYJWULU8SKzXmrThvyiVGXgg@mail.gmail.com>
 <a904d953-acb2-44f6-81bd-118f7abd22da@nvidia.com> <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
 <CAGETcx9CpOgtPSDK_qPRQ_u58w3fedSFAfFzugXW4eYq2TLECw@mail.gmail.com> <be41e552-e626-4923-a9e7-15acbafc19e3@nvidia.com>
In-Reply-To: <be41e552-e626-4923-a9e7-15acbafc19e3@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Sep 2025 13:33:02 +0200
X-Gm-Features: AS18NWC6HazxLFWbq662GHZ2xE_fLUSaAJYkDxvuA_xOhIOH2MGGHtfY_xpGVhg
Message-ID: <CAPDyKFo+8fw0GrFOazekXrb0zNsRkhzVmbOg45YZU+T2dm_SJg@mail.gmail.com>
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
To: Saravana Kannan <saravanak@google.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Hiago De Franco <hiago.franco@toradex.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 17:32, Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 25/09/2025 23:31, Saravana Kannan wrote:
>
> ...
>
> >> I have been doing more testing and do see a lot of "tegra-bpmp bpmp:
> >> sync_state() pending due to" on our platforms for basically are driver
> >> that is built as a module.
> >
> > It being "built as a module" is not reason enough for this warning to
> > happen though. One of the main points of fw_devlink is for things to
> > work just as well with modules.
> >
> > In this particular system, do you never plan to load the modules? Or
> > is the module load just missing this timeout by a few seconds or
> > something?
>
> We absolutely do load the drivers. Initially, I observed cases where
> drivers are missing, but doing more testing with the necessary drivers
> present, I still see such messages. A lot of our test infrastructure is
> set up to use NFS for mounting to the rootfs and so I am wondering if
> that can also be a factor?
>
> > If these can be turned off, why not turn these off using the sysfs
> > file or the timeout commandline option to turn them off? You are
> > burning power by leaving these on. A warning seems appropriate to me.
>
> Again the drivers get loaded, so that shouldn't be the case.
>

I realized that we also have an orthogonal, but related problem.

In fact, the genpd in question actually may already have been
powered-off, completely defeating the purpose of the printed warning
that we are discussing.

In genpd we enable the ->sync_state() support, no matter whether the
genpd is powered-on or powered-off at initialization. Although, it's
only when a genpd is powered-on at init, when we prevent it from being
powered-off until the ->sync_state() callback gets invoked. Ideally,
we should be able to skip enabling the ->sync_state() support for
genpd in these cases, possibly silencing some of these prints. I will
have a look at this and get back to you.

Kind regards
Uffe

