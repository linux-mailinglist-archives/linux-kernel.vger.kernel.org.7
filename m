Return-Path: <linux-kernel+bounces-865037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FCEBFC0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0384318C5A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF3626ED4B;
	Wed, 22 Oct 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaKCGn9K"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECD26ED51
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137917; cv=none; b=r+20RPZazZByNjxE9hsQCUStyXBzrpgmUM2y9F7VEmCYInouJbuF60QyiP/s6yoYd21z9pxz/7NI37uHRiCfA869fAG2iZWk9bemtHitCbdgD73Dam8nsqnWxwyl6go0aKxkQ10jlH2exn9Qdyc1U0SHbpEpsXAz6H+zs8v9Eio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137917; c=relaxed/simple;
	bh=H4pCf2E8dk4WvlnMMwozrZLRBkTXI8sJf6rrBnOqLaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3vhcB/cpAXS7bZ6uk2U8U/DBe3AhYlWf1BgAvzR8+MATOK0G95Fn5uFmhgwhCfIzNv1lEp/dhIVQV02DEhns/uDX5Ds8lgCwUo/lCJHvtkiJ9bs4P6Dn+CcaKnG6cquuMpogvUi2IAfE2Iz39nvDag3TJMO0ff8rvblGJ2A+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EaKCGn9K; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcab69so66825707b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761137915; x=1761742715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rjG53ExIK1WFjeDIAAZczTfr0kaW2lHML1A9qjZU6Y8=;
        b=EaKCGn9KDwPXk4eytrlDByFi/M1eyHOrNFWnuB3s/7rLPCbgShnVLR3Fq009a05a2d
         GlgTmj/EZ8PT2DgrWQBjjnCHLoogCvYFaicEJo6uuJIsbp5hBgk77FuJqnnihmzoJcH3
         46zczdRg0knhdxFz7kdgkPzYf87Cu6aThkkv1L5cj5uH5SeCfbPVYKqjJ9Xb2dLhGjd+
         F/Ox6WDawhFarBzVTCFUQBC5qnzsp8m4YXN+bMV8FBlYbhJoS0Vbjl3+luTP8PLoMGKD
         X3pejzAtPns3kjKQezl3xPSrJdnOfMClojpysZovOrj4rRwLpWPE4u1XJvXfpjfxAwW/
         bFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137915; x=1761742715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjG53ExIK1WFjeDIAAZczTfr0kaW2lHML1A9qjZU6Y8=;
        b=vwS5iqXSPQYl1V9CyGK+2M0vWmqHLWjpp3IzzZQ8X69nnDWLYSzyOYcMVD+EEg58gH
         d0ad87vrjxlxqYO1TpadFKLdH7RuDQJos/tpkIoxnidJXEkZACeSx6xSK2kr41xwkeZc
         eRFGCbwZ1I/Vbku/By5JFiXX0M6CxnynvLX/nzDgYnJ6bdfXMnQalUG/NsjWAwtQnL60
         1xDEjiwT4VAfwOWUBC//xzJbZpMauxXfwIVb63IS9WgNS+RahrRQwvUf3Vt4foFTlcGY
         Ky3O4DT0FS3F1zAvhExA/EumLWo0tK2MmPQwL1oWZ10R7OpRq2UTKkrhDre1K7pqmoDv
         I8NA==
X-Forwarded-Encrypted: i=1; AJvYcCWxWjI8HgX1r+h5KVPvPQzkzn1jjzFCXIMVtmsZCkDXoOHRPEiZQtP/xk4A4KuaSNbuZLcb1mU0yZrc4ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRKB5JXBIcX8pwGCzTRp4ijJpUblbZBmDCFoKTJ8I86yVu5Od
	BodM7fhL++x313Fmyl5LhR2va9CzXeYnkWZWbKqwt7UppTijO4GK91Eb61aAA0Pb2zj9Vd55GWG
	gDan3Kv4YJ+kEEV9X7B/pYRXa2ppnlDyBe1Hkq2VGgw==
X-Gm-Gg: ASbGncv8+eEoR3pCwmBJDPLSecAz7++F1FyupqmsL398LnwndeC1TlVZTW5xTdkDazV
	5TLKvBXKn2G6oG+MGuMAI1PU3NrfnmX9uQQDjzEAz0RUgU9QAXlmq2IkLxxTgm0EYysMUIq9nXz
	x/n4yw5dDgsG1cb12LronrOkSb96OiAnWlA83M/pDJ4ur/U/9h83lAlF8vFmj9sxCGCLKorOCsw
	2P0KfXzxC829z7ljMukEj9a5Py7BO19dKQLsiQggAOTWyiHaslcgraDg/56w4bGbp5efsf5
X-Google-Smtp-Source: AGHT+IEpKfqQAP/glDCUgAVJgatRBUGG4LJgEA2qJzeL/hKIAfZyo7XzIeJETd/S1CbVK1X+8E38/575DImRXb9n0+g=
X-Received: by 2002:a05:690e:4182:b0:63c:da95:21a4 with SMTP id
 956f58d0204a3-63e161b6c8bmr15719971d50.25.1761137915143; Wed, 22 Oct 2025
 05:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925143122.39796-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250925143122.39796-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 14:57:59 +0200
X-Gm-Features: AS18NWBK_6SEKp0LPrIDEzZP10EAnrhsIWSa5DHPeYttYjGzKLOmquHgZnWl3Xc
Message-ID: <CAPDyKFq9oxUfdfF-TOGLgi7b4aYay40H-VaEq-s=C3F2eVOBVw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pmdomain: mediatek: Add HWVoter and MT8196 Support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, nfraprado@collabora.com, fshao@chromium.org, 
	y.oudjana@protonmail.com, wenst@chromium.org, mandyjh.liu@mediatek.com, 
	mbrugger@suse.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 16:31, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The initial series [1] was refactoring the bus protection regmap retrieval,
> adding modem power sequences and support for the RTFF hardware found in newer
> generation MediaTek SoCs - and adding support for Hardware Voter, HWCCF Infra
> power on, and MT8196 domains.
>
> That series was doing a bit too much in one shot, and then a discussion about
> the whole Hardware Voter started, so I decided to split that in two parts:
> one dedicated only to the refactoring, modem and RTFF [2], and one that only
> introduces MT8196-specific parts.
>
> Since the refactoring series [2] was merged upstream and the Hardware Voter
> discussion came to an agreement on how to proceed (resulting in all of the
> MT8196 clock drivers being also merged upstream), it is now time to send
> the final piece of the Power Domains (MTCMOS) support for the MediaTek
> Kompanio Ultra (MT8196) SoC.
>
> So - this series finally adds support for handling the Hardware Voter type
> of power domains in the MT8196 SoC, for secure infracfg power control, and
> for all of the power domains found in the MT8196 SoC - using all of the
> newly introduced support (HWV, RTFF, etc).
>
> This series was tested on multiple MT8196 Chromebooks now for more than 3
> months, and works just great; the last test was performed on the Collabora
> MediaTek integration kernel tree based on next-20250909.
>
> P.S.: This is a v2 because the initial series ([1] v1) contained patches
>       that I am sending in this series.
>
> [1]: https://lore.kernel.org/all/20250623120154.109429-1-angelogioacchino.delregno@collabora.com/
> [2]: https://lore.kernel.org/all/CAPDyKFoe9=4KgOsPUX6FOE+yPxdUqAxRec5yKY2h6uFOeUvvDQ@mail.gmail.com/
>
> AngeloGioacchino Del Regno (5):
>   dt-bindings: power: Add support for MT8196 power controllers
>   pmdomain: mediatek: Add support for Hardware Voter power domains
>   pmdomain: mediatek: Add support for secure HWCCF infra power on
>   pmdomain: mediatek: Add support for MT8196 SCPSYS power domains
>   pmdomain: mediatek: Add support for MT8196 HFRPSYS power domains
>
>  .../power/mediatek,power-controller.yaml      |   4 +
>  drivers/pmdomain/mediatek/mt8196-pm-domains.h | 625 ++++++++++++++++++
>  drivers/pmdomain/mediatek/mtk-pm-domains.c    | 305 ++++++++-
>  drivers/pmdomain/mediatek/mtk-pm-domains.h    |  49 +-
>  .../dt-bindings/power/mediatek,mt8196-power.h |  58 ++
>  5 files changed, 1012 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/pmdomain/mediatek/mt8196-pm-domains.h
>  create mode 100644 include/dt-bindings/power/mediatek,mt8196-power.h
>
> --
> 2.51.0
>

The series applied for next, thanks!

Kind regards
Uffe

