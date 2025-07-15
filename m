Return-Path: <linux-kernel+bounces-732017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B415B060F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8771C506FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B041295528;
	Tue, 15 Jul 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLO5cj2w"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC65293C6E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588580; cv=none; b=pjpBK54eRvIpROYag6DcVJpYeoAXW8EAXxNt5yYGHIS19vKxrHdseXx74G0NNbBklwAOpZRVJ99WHuk+PKyJx2ubALaJcWdezHGsNwAVGCUu1MBqxh3cEgDw4wwrDLBhAkfaAK7lE2zUHFqDtemBkl5fvdNvG0KoTVpnE1Io58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588580; c=relaxed/simple;
	bh=8IsG4LWjsZ/JSPgVdpO6Ex9/9B06kDxYohYOARb8H5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baHL0ghFcsPUkfSa5tH/0gCLmdkpgI0F5e/X4/h0D9eUdTFnfPuPmuUQq9ji0J8bluxAlRTLJxVrDaUOiVFV/Z1TqpUEwtrBtBBRDCIpf980vQ+nxNwarxWFiMBDTMWJarwpBrVQydqmXqdODkjThX7x6k2VJSvOwPba4iMa64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CLO5cj2w; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-714067ecea3so42418827b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752588578; x=1753193378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bmzfIS791V99d1Ua1vhHPiiIrS0ff5q5gbk/6URD+qs=;
        b=CLO5cj2wfse0XNLaTx3EvoiTqeJjvXRHfFNFE9VyVN7e3PjYTU1BG0jrGVmShOFhVk
         RNa33q9us0CjfpeFrJ5rhsxkupLKmxevaN3sbt25POxZE8+Be+nuECzi9CelFOrpj+Qk
         sWwovx771dasqJbBpesoj9CXfmpZ59i+5hN5DJiWptPxutTSbzLr5vLm9uoHTW8QDDX0
         f/XVrm/OenSK4cQ/E7VHSm0KIf/oK/+1SbDFGTdo/OQscLCQS7HmQm0ErbFYUx4pH4KJ
         hXHaS2eKf0zKOOFRPsYQkO2IUdqY2pGuDWxI5kUTPEjaZS2uhMEKcsA000hiimgymhIL
         7qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588578; x=1753193378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmzfIS791V99d1Ua1vhHPiiIrS0ff5q5gbk/6URD+qs=;
        b=A/GNKESyzsxM7WtrHwQFOWQoclM12g/CXGjC19WF20HuJnue1tB8Zsxc/vzzMx9sw/
         KsuYysaLBMT5V7yNQ0Fgi8XXoM4748na2sEuo4SZ8dD6ekqzbxj+HRxwko27nmm8NasT
         x0MVN3l6+tpP3ib3+6tjBRd23WOXnf5lYI4pacExwePwcHr0NOtjUOxt9eMOxCAgM6TQ
         4cKJev12AbTW61F7hI4uwWbcWIbHWXMsNVSWSKsDH4Me8kfQq/MwKo8riuw9oeQYVL6Q
         6R0jNjAF4qDpXxEKEZfqTvZcQc8bito06N4K9WBEcc3zSYay7OMdasXENgtCJDVFPl/l
         KZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKUI+/qpXF5jd5Rr07n+4gnJ3ltWsHZ5kLlP+7Y1E4atIovzzda+BlomNsR8jt/ioikaKQXdjYlJ6m6CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPe4c/GFauM7ry5EAZhgpEFJRU3s+Mw1gkcyYMCuOnw+uSe+5
	osBXN8bw8iQfFhkZyKrkLpNpiLTxeMe+qFtPnCCnwYMpmBu4F3iNyvKOeZe0P4iqbqgNQsqyyob
	tp3GyDuGrQ5WhDmrEtBNqp1lQbKxZSDkgixFUpv5btQ==
X-Gm-Gg: ASbGnctaunVEQ2W9MyZDVmaRUL1RVltdsnHBoa6dwt0Tc1l+iI2q3WSBIKUN+jlWpRg
	ktUWHLxOtZkDUYG1N39oX2fGH/Vxsacry4lNlfp2R4aKKLbutO6d1hQk5eTN+HpY/ifT+vTjims
	+Y2IGbeOXUGuyKV1De59JC6MMqFhxFkSe7FEP6MwmsoPfnpz58vcT6HhcnjCKTQxlJh+Kd/cIZt
	DIY2owE
X-Google-Smtp-Source: AGHT+IE98901gEcrRNSUihoeT/4rQ7pCPgteeZyh+KNnxIQiEUnJhDDaQ4hcLxAbANGBHie7GXLCAxvDvoVssfzciBU=
X-Received: by 2002:a05:690c:fcc:b0:70e:29d2:fba1 with SMTP id
 00721157ae682-717d79eb927mr253244047b3.23.1752588578209; Tue, 15 Jul 2025
 07:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-depspmdomain-v2-1-6f0eda3ce824@baylibre.com>
In-Reply-To: <20250715-depspmdomain-v2-1-6f0eda3ce824@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:09:02 +0200
X-Gm-Features: Ac12FXzWeXj4G9w6y6bRUIiRIIfhiACwSOMXyZAJepX0VKpzYw_PeSt2K2xdbqw
Message-ID: <CAPDyKFoqeh+-TwSR1_J3976LGmVZ1WYH6gBeuhwWpaq9HO4umA@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: ti: Select PM_GENERIC_DOMAINS
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: vigneshr@ti.com, nm@ti.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vishalm@ti.com, 
	matthias.schiffer@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 10:50, Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Select PM_GENERIC_DOMAINS instead of depending on it to ensure
> it is always enabled when TI_SCI_PM_DOMAINS is selected.
> Since PM_GENERIC_DOMAINS is an implicit symbol, it can only be enabled
> through 'select' and cannot be explicitly enabled in configuration.
> This simplifies the dependency chain and prevents build issues
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - update commit message
> - fix select rules
> - Link to v1: https://lore.kernel.org/r/20250704-depspmdomain-v1-1-ef2710556e62@baylibre.com
> ---
>  drivers/pmdomain/ti/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
> index 67c608bf7ed0..5386b362a7ab 100644
> --- a/drivers/pmdomain/ti/Kconfig
> +++ b/drivers/pmdomain/ti/Kconfig
> @@ -10,7 +10,7 @@ if SOC_TI
>  config TI_SCI_PM_DOMAINS
>         tristate "TI SCI PM Domains Driver"
>         depends on TI_SCI_PROTOCOL
> -       depends on PM_GENERIC_DOMAINS
> +       select PM_GENERIC_DOMAINS if PM
>         help
>           Generic power domain implementation for TI device implementing
>           the TI SCI protocol.
>
> ---
> base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
> change-id: 20250704-depspmdomain-2c584745dca8
>
> Best regards,
> --
> Guillaume La Roque <glaroque@baylibre.com>
>

