Return-Path: <linux-kernel+bounces-875576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF8EC19595
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B823A834F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42757320A03;
	Wed, 29 Oct 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RPdF8Xqf"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5020301483
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729303; cv=none; b=LySA3IjeRgr4/bkNYrZv8795veQ7/Y5I6Ff+tliWEvnbjZ+5hy2iwGVUXj1mrmHSkvSCf1pvTOUA9IrJirn8OWsMn8KIGh20JX2JHbGXNJV1ez2ETyx21s/7357GL80OCLikXS0lz2yyhFm0n/vbn7Sr7T+0FlGKLbZmjMfn1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729303; c=relaxed/simple;
	bh=aKg/dTYkKJuSKY4S6pQwZeiHexpMmm8CZZ4NB6VQNM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6UK5emKYr746whpXboY7ydsrQ+JdApqWTwijKSWXcKi4Z3nOFf/anjMEnAFN7wxQ/F64mATrCoCmA915O1TPs2WNKw13y2K9qldB1bHL5toiWGYXMN8LBa/h+XC4KoG24r8To+O2GHAnoZbFPVFJJo7ZGr9i4alGpMzufIDd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RPdF8Xqf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-592f22b1e49so6368559e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761729300; x=1762334100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5TG0ueaKuFAyQO0OV9etRSInulzLHrCU1Q3MeGK1uY=;
        b=RPdF8Xqf1Mj99taZigzOxjfOZl+JG2zfkjEEqQU8Q2NHT4LV0XAUrnvJGotDvJVmRs
         mGdT3gn7qUYFlRl7FgE1zjzTjYAzHiMx1kO8hzM4oAhfLJWK8jhbzX2JK046ujcFjvBX
         G4QbO6ynWg/MLDLUS3iIq/k9ql3z+2GCN0nGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729300; x=1762334100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5TG0ueaKuFAyQO0OV9etRSInulzLHrCU1Q3MeGK1uY=;
        b=CoPfGf2LU6EMXwSuLuPV8kkccWhc/sZ/jl7dnE5DJC1+oQN+IAL1UMxNl1CfimuKXH
         0ly46oyqE/ACo8OaRGoenVyyidivd78Sz6KnZUirgg9FYLg7saIGOC3ucc1sHI0mz+Vo
         GiH6TctQKsEYGqQn09wewLvTGqOk28lwYg+8kDMlgXOXDh1cxXPa6U5HCzSowO2BaJiD
         rOJetKa5MaxOqqGRic68WTEKWtPZSKUXNcWdL6iwVQP214nv39w7Xjw3N8UkLzhTmVHO
         7/Nvmth4jjlCBK6+iokFtfb5HBPFChmN/oUuSI500JVXyeGoJzz3PrGY1llyoqCK/TQt
         MC7A==
X-Forwarded-Encrypted: i=1; AJvYcCVjQ+bCPH19bkBgRnxHoWGV2V2cx0/mf9zHUca9rjFB90Id1RNHmYN99WccQ8NJfjI69wOVbvRuc9kLSw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvhl0xzFobchamFUR+U00rbPDJenzUHRyNPBf3Rtz/02zZBDd3
	tHoTIqegkEmPitUIA4n9vWuBWAJGU/Hhhx69/5sircb+K5gzszIB9zMYS8ecNePDw8RYQFfMERW
	iCBlKsFj97SvjOTKVfvMb/GLhiTm99IXfjKZ+WpC0
X-Gm-Gg: ASbGncsNYfPUaTSMZQMdZDdcDcd7JPPUV8blNTYJvh5A2ow6yruZ8ObqGEEWQCdmJpP
	81nr29Ru/1ZNWukkMmGkZjizhP97PP6/YwRX9lKAWGpGAdplHUs8pQdbvvG2bV0RFXmW1p06gyQ
	MyHTMjAlBEmpaacD6tGm3/lSkL8+03XHYKtIYFwbEsLGzzyfdmGvdUmKNE8gLIdqKLfosVqbqPh
	bS6S0+382ZV6m7ItDvVdxkFcMFrPSQNcM8S58ufAmQhlM1MPW9QpZJjp+Mbwsbn331hlEcPUn+h
	c4TAbN7fJ+p2rA==
X-Google-Smtp-Source: AGHT+IEdzCz5CagXh2U1asZRsfKQhXvsI7kXu6etELWvVx9B3yH4c3fTQRn6qbqQRMN7bG9dn46906V22dlPmaM6Xt8=
X-Received: by 2002:a05:6512:1150:b0:592:f2fc:51f0 with SMTP id
 2adb3069b0e04-594128b54famr828019e87.30.1761729299812; Wed, 29 Oct 2025
 02:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015084103.10737-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20251015084103.10737-1-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 29 Oct 2025 17:14:48 +0800
X-Gm-Features: AWmQ_bkTadC0tGmcwZKXgN_YyBG7Nl3lIGZgDu08N9ula1vkSppNL4aPMzmz71k
Message-ID: <CAGXv+5Gs5_j5L3+HT7K-XYwVG6S8ZGhHZkEcS0HpdkcjRQq2oQ@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: mtk_scp: Construct FW path if
 firmware-name not present
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, arnd@arndb.de, andersson@kernel.org, 
	matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:41=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> After a reply on the mailing lists [1] it emerged that the DT
> property "firmware-name" should not be relied on because of
> possible issues with firmware versions.
> For MediaTek SCP, there has never been any firmware version vs
> driver version desync issue but, regardless, the firmwares are
> always using the same name and they're always located in a path
> with a specific pattern.
>
> Instead of unconditionally always relying on the firmware-name
> devicetree property to get a path to the SCP FW file, drivers
> should construct a name based on what firmware it knows and
> what hardware it is running on.
>
> In order to do that, add a `scp_get_default_fw_path()` function
> that constructs the path and filename based on two of the infos
> that the driver can get:
>  1. The compatible string with the highest priority (so, the
>     first one at index 0); and
>  2. The type of SCP HW - single-core or multi-core.
>
> This means that the default firmware path is generated as:
>  - Single core SCP: mediatek/(soc_model)/scp.img
>    for example:     mediatek/mt8183/scp.img;
>
>  - Multi core SCP:  mediatek/(soc_model)/scp_c(core_number).img
>    for example:     mediatek/mt8188/scp_c0.img for Core 0, and
>                     mediatek/mt8188/scp_c1.img for Core 1.

I know this patch has been applied, but this scheme doesn't actually
follow what is already in the linux-firmware repository.

For all the supported platforms, the first core, even for multi core SCP,
already have their firmware uploaded as just "scp.img". Multicore SCP
is seen in MT8195 and MT8188.

I guess I can send a followup patch?


ChenYu

