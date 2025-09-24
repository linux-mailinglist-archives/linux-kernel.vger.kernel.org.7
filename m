Return-Path: <linux-kernel+bounces-830881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6240B9AC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA1F1896ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6304F3128D8;
	Wed, 24 Sep 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTEP9tP5"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01721FF44
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729229; cv=none; b=BWGHKLzcbGSov4Q2qDsKHE1yZWmSw9iOexoLan8ylyssgUgQCJiy/qGN3UAkUNnWv2oIE1JUyJ04mR5kGwq2B1YCW8CLnhPnjAB/2laccfSwbKSS29wEXn8MwMr5oLeNdMIJpkDQWS//jrEa3d9mFNUVtopHCyGUkptA2EUy7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729229; c=relaxed/simple;
	bh=1PUNlHIAYtCH55z1RdMjhD1jhr0FPn3wNb7XI9Lq6xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1QI0EfjlH6nzveuSNUK/LMleQ4UBxD95VC4odcVfkD/EjTGQC95A6mkrar0V+Gu5moKPp4Pp8A2wOVDcRvlu4pRTdhrEvXwlWMeIQXiocG7nBDkrBLThV0pry6GGiMF+RAyWAIQkEsGnjKikS3rFrZqMHvyueG5vu9b20kIyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uTEP9tP5; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea473582bcaso1300430276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758729227; x=1759334027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ws36E4l6sDZ0NgTD31F0HXvzlU5qFwYdqyOPAZNL3c=;
        b=uTEP9tP5bDcl9prhys/XUgupR6QJxTpv9JoRmKqdHXUbMNWG4f+BR66aO85uVUIHng
         UufipDJlFFR+fSUCcpTk/pf8wIeuePmjMuIrpboHmSnsvY7Wa6VGz6N8HGmZ+qNcZdkY
         wNrRkOhYTezFljyl7Y5bM98UTTcQxFsavDibS2RGGlneTvgFbq6iayoNBG0RoBW2kJct
         0o4lzd9a0cCAwD+pQCyt634J+tFeqhFRvSR2mGZcnca8Nzz0pvTMlUM8MDMBAQSG7q/B
         ++TR1Fp0acm7kIpz+hJlRyLkF1Gc67qqQ1v3kRQDsqrzSWW0IyCOrteGUO7pmS2ryNXl
         eHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729227; x=1759334027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ws36E4l6sDZ0NgTD31F0HXvzlU5qFwYdqyOPAZNL3c=;
        b=VtUTcZKrZzF3nuKZE49u2HUWLKcy00TD+k/gR8k6SOn4x1r12tn/OGQr2fHTMufyLm
         lxjfn/n0u8kOVDxOWtCA8eJ0d9nAjOFvBDKUog1RlJi80J37E5V24272lKiH9KoacEf9
         admmPGCNlFpoOTbmjsjCJMezMr+NW5x/kqtW2ANf5ExXWTOOx9oyXRAnKcwOtkV05qKc
         P0Ach+gLfCVLS/hpPSm33lMvV0RAR2gwVsPpMuE82DMJjWSwZvVnzkBQmKkzWDjiTo+e
         c9vR37UE91QVLy/a99+qb4N1TsN2EVrb2rk55jNrFQxRDjWcCXJEMBHvxfmWIxC3Ldro
         AeMg==
X-Forwarded-Encrypted: i=1; AJvYcCXSHzuSstcyzeEiTiS5n+gtV9Bx8p/G9rMW/fmP5Ha33jaR36VbxV1Pg9ln9cjJ2MHXDRQmqGoqgX6tusY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw89a1z/MDZyo8FAo9c4eUFq1eyIsFakzJP13NZoTjTc5c2KtJ8
	xs08EHgiUkj1M4GzsGOwRXXQy4gIMrZETV9fok5nTH2sHCNiCfh1mHC3lmOs1y7tZIyBcVIb99/
	+58lU/m95GbqP0zUAN8C+kdpaKJloUm2xdPxMOzg5DQ==
X-Gm-Gg: ASbGncvyjrjP1xbBGbsrySS73aFxsjPaCB8GsH4fBbuJdKKlSokrz5VBPVvfYgsXV+1
	/ZT/fnjaYAupWinVLq0lgJQn4RrJa32ZwWWVGp8CyT9w9HWLassYbYpWPSNjREMX5bMu/rU2AOD
	I5zmVWT68tgyVqCncfi7Md/KyDd48SUJ+93wPfg6quY2EoLYIFVXWGTyFBcVz0QfodfqctiRsuL
	dGd8LozGKQiwh8nQif2e1ser/F1NpofMC2fLw==
X-Google-Smtp-Source: AGHT+IG/0HOlWN+Opy8mk1rlXCX6lREWcCWPZFITT3xAhxjSLe4cF9GNTsFZhuk9Ow8vzBprt7QptbBAX/tQMBdgAFw=
X-Received: by 2002:a05:690e:1648:b0:633:b317:9cea with SMTP id
 956f58d0204a3-6361a90013cmr66977d50.8.1758729226717; Wed, 24 Sep 2025
 08:53:46 -0700 (PDT)
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
In-Reply-To: <614f726c-4d6d-463b-a8b3-26d3df590575@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 24 Sep 2025 17:53:11 +0200
X-Gm-Features: AS18NWBv34Nq6YjDF4uwQFfPTxm1VXqbNiERHa_duVzXNf8ehBq83NeR0ORga00
Message-ID: <CAPDyKFoPOejFT+=OBoLTBXj5GYuHFwwnY9qGROTynrtHT=mCAw@mail.gmail.com>
Subject: Re: [PATCH v3 20/24] pmdomain: core: Default to use
 of_genpd_sync_state() for genpd providers
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
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

On Wed, 24 Sept 2025 at 13:41, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Ulf,
>
> On 03/09/2025 13:33, Jon Hunter wrote:
>
> ...
>
> >>> Following this change I am seeing the following warning on our Tegra194
> >>> devices ...
> >>>
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 17000000.gpu
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to 3960000.cec
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 15380000.nvjpg
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 154c0000.nvenc
> >>>    WARNING KERN tegra-bpmp bpmp: sync_state() pending due to
> >>> 15a80000.nvenc
> >>>
> >>> Per your change [0], the 'GENPD_FLAG_NO_SYNC_STATE' is set for Tegra
> >>> and so should Tegra be using of_genpd_sync_state() by default?
> >>
> >> This is a different power-domain provider (bpmp) in
> >> drivers/firmware/tegra/bpmp.c and
> >> drivers/pmdomain/tegra/powergate-bpmp.c.
> >>
> >> For the bpmp we don't need GENPD_FLAG_NO_SYNC_STATE, as the
> >> power-domain provider is described along with the
> >> "nvidia,tegra186-bpmp" compatible string. In the other case
> >> (drivers/soc/tegra/pmc.c) the "core-domain" and "powergates" are
> >> described through child-nodes, while ->sync_state() is managed by the
> >> parent-device-node.
> >>
> >> In the bpmp case there is no ->sync_state() callback assigned, which
> >> means genpd decides to assign a default one.
> >>
> >> The reason for the warnings above is because we are still waiting for
> >> those devices to be probed, hence the ->sync_state() callback is still
> >> waiting to be invoked. Enforcing ->sync_state() callback to be invoked
> >> can be done via user-space if that is needed.
> >>
> >> Did that make sense?
> >
> > Sorry for the delay, I was on vacation. Yes makes sense and drivers for
> > some of the above drivers are not yet upstreamed to mainline and so this
> > would be expected for now.
>
>
> I have been doing more testing and do see a lot of "tegra-bpmp bpmp:
> sync_state() pending due to" on our platforms for basically are driver
> that is built as a module. It seems a bit noisy given that these do
> eventually probe OK. I am wondering if this should be more of a
> dev_info() or dev_dbg() print?

Yes, I agree. We have had similar reports for other platforms too.

I intend to send a patch for this in the next day or so.

Kind regards
Uffe

