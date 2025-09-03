Return-Path: <linux-kernel+bounces-798294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68741B41BED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013D0682E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44DB2EB5AF;
	Wed,  3 Sep 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNsa3txk"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E727702B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895645; cv=none; b=PkuQXW0QPthq4hNHwRIm5Isck3cSHAJ6Gs/4LGPP1rHxqBWn4w1K5Sn1T5BMDONDBpqC9ghswFUI2BFdZsONIHCXbLYoDCeRVNxLChG3uCXqctl/0ipMS6D5mr1q/CfSKGG3gQYN2xO0k61JB5x+HNW7UeIgFepn+QmX0G+4iUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895645; c=relaxed/simple;
	bh=HlSQD/VcE7uTwqqaKdqNmC0YhBGljeq3jMyA/8WahEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtHNV5dMqydfl2yPTHGLaTibvwPTWXqLJgpWH2Rqf6OCH2BoZDn2E2c4a4PNTUvMLO4xmr2Gnew+l4hzWOZOqoXezwxTVLkZdezHysaoHOfT70ztmtOlKvWyMfNNOxHy52C5CvOp+Q5aXyolT6QUXANIUyLnHLtbaL/gDx9BQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNsa3txk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-723ae0bb4e4so16669667b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756895642; x=1757500442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0EtKdPy1PWYpoHwEbU4TADx/7jEVJjgADRxCA2SS1U=;
        b=pNsa3txkMPk0JmkBQ6ost49GtUPwfNYEMlQLerpJLPJJuCY/OBJDQWrclT4nskjZKJ
         /GRSZPSVi067JuT9kt7hyNPv9AnHATRcVhY82Q7MV/30LnpSzWRbRjf/eEyOvz9Rc3vF
         QV707A1f1fZQ1H9CVIMXq90GDOLk3Z/xkI4GM6UHooTLGrG3RtVY4krgqoVQ0Q6nHdRg
         kQne6po2Vmg4Sjt9dYg82OByagYfX3fvTx5vOpohjri1dw9cE4rf3ZKtA3tAlM98WzAA
         rvXfGictDga7SPLbdJ1rn+kWlwkhFSKjBAYQq9sgsQinC4r7xAARoY6JtibDsXqAlRA2
         2wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895642; x=1757500442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0EtKdPy1PWYpoHwEbU4TADx/7jEVJjgADRxCA2SS1U=;
        b=Lc9YdLb9vybZS1o3ljqaXLxojh4hschtRd/ecrGx/yMEVZgvgd0HR41j1PbG84S9GA
         qq5YTpIrjEIsq/M1yrDJ7qmP/cbAF9PXHGvcG45YerrA/UUzS62Y9avlP1xJb7iedkkc
         sG8ChfDQbSZnyTcVFhLKNKaO2puFn5oQF0TZOg/Qn81VTFP6uAxaggwIJ/dwrFDnmJpx
         IEFUn1rpS1vKBU41LPlSrWgy0lf6RYVRI3U3cV+h7vjDQG9QI78ReO+Ld4GPkH3qEkpp
         AS3cwGD2XV3OFtk8SHHdygrNyXy8GuxrhFyFgXJQL5ZUYZlChvM1ALx3aBPhdzxDnYyu
         mAKw==
X-Forwarded-Encrypted: i=1; AJvYcCUnghupJ495R/DYjGH5Z+8PY9I15myltbfKQdmz8rTHDIVfZKoDMYd2z09Fs/rY/LEyzAp1/jg14NGOq0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOG78E+/vGCyAR66vGudaIZbJ577HxuyRYzPGpNKl4JFi1P86G
	5CQjJOcMr957smW14Xp8OzWAwVdyvTi4lW1z7NNlVir8IMnkSoTXaJyOYc87Sv3wttSvn1iW6Ly
	xUrh6sTo/x1nb00lQxfwLOKrFM2irRZ3Ja5tgderw+w==
X-Gm-Gg: ASbGncu+5benKelzeZNJTTEakQdoXdAsW2KWQ8fbSNBLWV1DRbeH2+tVTXQlF4GEkY7
	74gknrQ+JTKdEDXBkxSqcdhlsUvwnDgbap4e1unrqcyZKf89WCB3froNl2QUB6Xj6HxaiPeQ1u3
	99/uUAjGD5Lzanuqd15oleg8yymsFkTEpZ7AEQvtth7lSWf/AcyFfnJnwtNCJoR2YELKlWhIHfo
	Hq1cq1VOATiiWQN7Yk=
X-Google-Smtp-Source: AGHT+IFfKLxV9tyzOQnEikdZaazb4yoGYzUJMKmsuTzVmQ83iHm/xqY/KhFL0iCqSoFlmWwQqKTl/pZIy8pjx3bEoRs=
X-Received: by 2002:a05:690c:9992:b0:71f:b944:1015 with SMTP id
 00721157ae682-7227656cde8mr166303267b3.48.1756895642243; Wed, 03 Sep 2025
 03:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org> <97231ac9-5cde-49bf-931b-d5baf6d2d2d1@ti.com>
In-Reply-To: <97231ac9-5cde-49bf-931b-d5baf6d2d2d1@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Sep 2025 12:33:25 +0200
X-Gm-Features: Ac12FXxVFiRwM0u9ulXeQmiXI7_oecrVOWSFM0H3YtDXDfcwWKQ-S2uZTHsACkk
Message-ID: <CAPDyKFr8AYuS2aEVs8X2As1NzXnbea4rPLKiF5=fKjq=PAeZgg@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Sebin Francis <sebin.francis@ti.com>, Saravana Kannan <saravanak@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 09:39, Sebin Francis <sebin.francis@ti.com> wrote:
>
> Hi Ulf,
>
> On 01/07/25 17:17, Ulf Hansson wrote:
> > Changes in v3:
> >       - Added a couple of patches to adress problems on some Renesas
> >       platforms. Thanks Geert and Tomi for helping out!
> >       - Adressed a few comments from Saravanna and Konrad.
> >       - Added some tested-by tags.
> >
> > Changes in v2:
> >       - Well, quite a lot as I discovered various problems when doing
> >       additional testing of corner-case. I suggest re-review from scratch,
> >       even if I decided to keep some reviewed-by tags.
> >       - Added patches to allow some drivers that needs to align or opt-out
> >       from the new common behaviour in genpd.
> >
> > If a PM domain (genpd) is powered-on during boot, there is probably a good
> > reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> > powered-off before all of its consumer devices have been probed. This series
> > intends to fix this problem.
> >
> > We have been discussing these issues at LKML and at various Linux-conferences
> > in the past. I have therefore tried to include the people I can recall being
> > involved, but I may have forgotten some (my apologies), feel free to loop them
> > in.
> > > I have tested this with QEMU with a bunch of local test-drivers and
> DT nodes.
> > Let me know if you want me to share this code too.
> >
> > Please help review and test!
>
> During testing on a TI platform, I observed new kernel warnings after
> applying this patch series:
>
> ti_sci_pm_domains 44043000.system-controller:power-controller:
> sync_state() pending due to fd00000.gpu
>
> These warnings occur when a device (in this case, the GPU) has no driver
> bound to it. The fw_devlink_dev_sync_state[0] in the core has a check
> before printing this warning. It checks whether the device driver has a
> sync_state handler OR the device bus has a sync_state handler in the
> dev_has_sync_state[1]. If both conditions are false,
> fw_devlink_dev_sync_state[0] performs an early return before printing
> the warning.
>
> Before this patch series, both handlers were absent for device driver
> ti_sci_pm_domains and the device bus, so both conditions failed and no
> warnings were printed.
>
> This patch series adds a sync_state handler for the bus, which now
> satisfies the second condition. So it doesn't do an early return and
> proceeds to print the warning.

Thanks for the report and testing!

Indeed this is the new and expected behaviour. I agree that it's
certainly questionable if those prints should be at the warning level.

We should probably downgrade those to dev_info(), at least. Let me
send a patch to see what Saravana and others are thinking about it!

>
> [0]: https://elixir.bootlin.com/linux/v6.16/source/drivers/base/core.c#L1777
> [1]:
> https://elixir.bootlin.com/linux/v6.16/source/include/linux/device.h#L909
>
> Thanks
> Sebin

[...]

Kind regards
Uffe

