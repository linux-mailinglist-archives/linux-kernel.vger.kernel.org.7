Return-Path: <linux-kernel+bounces-841636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C5BB7DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 381F24EA72B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2022DC79F;
	Fri,  3 Oct 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTogVdCm"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E701199931
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515365; cv=none; b=MqBWu4rKckJmWDlvM2EdvuD+kRCzn20NyqQnXVkeOhYl5AmwNPk8/rVL96EnWMm3HPZH2oS1pQvSPnt8ZKBojqtVbjeyp5mO1ag+1Du5Vd9sRXcZ0HbCKDWtAq+xYQE2JRbcBM5Q1pZrdlNVPMYQFMmjodNbCFb63ti+bWm2s/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515365; c=relaxed/simple;
	bh=DWENI6DuXEJ8v7lUaZGvnNMdfDIGbQfCAclwdMGY22A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qI3eEDMzUWFrNbBprv1dIq0diQuy34oAk+PoFA4bjeLNGKK9vNK91NPCRkYXHc8dEoejqi+MIq4bE9Cv7gpErQ5SNSTlPr9zktEKWWyol8RUCSqO2+aqJ6f+ORf+A2kvM3eE+JwgOiW3zF7bzzYg+ly+z0y4XYFXm2TQpbu1Yak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTogVdCm; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-77f9fb2d9c5so8615857b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 11:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515362; x=1760120162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA+2wesaVrYL13Ek9PytzgyCt01NNN1W3ZjSk7cfKyA=;
        b=HTogVdCmeZbs/su7w+K8BnsdCVVsoGvhgVN4YfVlUSieWK5p1PQoMiWEUCj9h+saV0
         SPZaf0LHkxsB8FG5ryuriE9z8L/dRF8g+2JInPpb1LTrl425ozWfdkYImxz3Yc3xG5Bc
         bET4Dca9yz11TGw/u6Gvlb5vISzWzJ7tiLS0cVTIkhzrSkI/F9QtoyQWrHxIkGDgD4xh
         cC3ILjpy0tbWT2UdavsL5I9XVgHWGAgKX5JA7XsQX81GdGgMNc5eTsUOG/aLcqUuYEa4
         ILfZmClWS5pOUXFKMKMHfJdt73VMZH+qm6zOuiIhPNWIWbmCp3d+NbdkIkNkBLtgmp+d
         6Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515362; x=1760120162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA+2wesaVrYL13Ek9PytzgyCt01NNN1W3ZjSk7cfKyA=;
        b=swdbPc6XTeObw4Ge1Cq1UnNEVjmAxhCNpFISsRnaQn+qdzLSPMwV7qQyQ3ebJmW/DM
         jwpejkm7Pu3GLqerzUnYEXLOdSOrmd1VOU7OPZhajkNCx/rWHI4a8Hgl4fTbkjCBCj4H
         puAuW3baaYjB1kPqbpzvBHSruKwx0LzckEJdBIAF/f8JOG+B6qs1yLIjtIODUcOqGbM0
         iAqRpJsv2cFqkrzVz7NMetTzPDsp6PbMsFoWC9V/8KGpNeb25+UM4SaOecZbiVLpkox8
         JnigVImFzc1OVyL6DTFUsw9kQPGb0Ac8FQsgG/vQ3NjzLriaAu5Zc8gwxPV7WBuGSPq4
         Uq0A==
X-Forwarded-Encrypted: i=1; AJvYcCVoqbph+zv0rthhWQ/jU5R51vMj5owfjbfzxFkI2dvRRoTJecaAGf6BBnT3vd1asqwuOkgwxcppxopz2+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3+uZGd+l2aGsxB0d6jUCG5EchICPErwMdyGaQPp5tKsYH+Fd
	m6YghHBsb4kuDjrueLrNXKsYl1R0h4QWGs2/H2CGpcYGSO8bU16XZWKkkeMgfhEX6/kmsBy6roy
	x7NKUNmJ4fTDCIrrvRTUfkd1NvSCEvEEDRlfUXJs=
X-Gm-Gg: ASbGncuP+pJsuxe4M/EesCn9meX9AndooTsDCOQBqYeNpM8bjCcnptk+FHIkSy5GDnV
	46Oz4X77xqLZC2S7jyAeO0Uw4c/Xite7vCvvvrssyV6jXUEv5azG6d1pcFPojtPIo0nZFE/gzhn
	boPFHlv0TgO6z3nvLqC8MMWbSN8W8d4mGfmh2FEriQh0duaxiYtRHZgA2qeQmbGegyHvJ4UnbgP
	37OqUnfPjDRGraf4iis6dE6qhI1YZpCc6BBHmD3FCmY6HfeXExwN6O542U0l1KFVr6VGL2ZJmN3
	cPbAIsuB2nrQkyH16PLvROjJt1qnEqJ4
X-Google-Smtp-Source: AGHT+IHcaFQJqVTztaB0e9RyZeNiAagOyj3g8KNYxpfdC0wTuijqki+QAQ/mSLPGzCBtgMgInYIWdXqQgPlyAlcpaNk=
X-Received: by 2002:a05:690e:28d:b0:604:3849:89a8 with SMTP id
 956f58d0204a3-63b9a076118mr3027885d50.16.1759515362277; Fri, 03 Oct 2025
 11:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929-mt8196-gpufreq-v5-0-3056e5ecf765@collabora.com> <20250929-mt8196-gpufreq-v5-4-3056e5ecf765@collabora.com>
In-Reply-To: <20250929-mt8196-gpufreq-v5-4-3056e5ecf765@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 11:15:51 -0700
X-Gm-Features: AS18NWBanN0MXtcDFrnukKn4J7dSEQIT7fLhFbzGJzYOporRHK4S0vyKzeHBSFc
Message-ID: <CAPaKu7Tz9tw=fbz17kpPn1Pj_YsGRJZR9o28zkfiBgvxL3rdxg@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] mailbox: add MediaTek GPUEB IPI mailbox
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:47=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> The MT8196 SoC uses an embedded MCU to control frequencies and power of
> the GPU. This controller is referred to as "GPUEB".
>
> It communicates to the application processor, among other ways, through
> a mailbox.
>
> The mailbox exposes one interrupt, which appears to only be fired when a
> response is received, rather than a transaction is completed. For us,
> this means we unfortunately need to poll for txdone.
>
> The mailbox also requires the EB clock to be on when touching any of the
> mailbox registers.
>
> Add a simple driver for it based on the common mailbox framework.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/mailbox/Kconfig             |  10 ++
>  drivers/mailbox/Makefile            |   2 +
>  drivers/mailbox/mtk-gpueb-mailbox.c | 318 ++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 330 insertions(+)
[...]
> +static irqreturn_t mtk_gpueb_mbox_thread(int irq, void *data)
> +{
> +       struct mtk_gpueb_mbox_chan *ch =3D data;
> +       u8 buf[GPUEB_MBOX_MAX_RX_SIZE] =3D {};
nit: move to inside the if-block below.
> +       int status;
> +
> +       status =3D atomic_cmpxchg(&ch->rx_status, GPUEB_MBOX_FULL | GPUEB=
_MBOX_BLOCKED,
> +                               GPUEB_MBOX_FULL);
> +       if (status =3D=3D (GPUEB_MBOX_FULL | GPUEB_MBOX_BLOCKED)) {
> +               mtk_gpueb_mbox_read_rx(buf, ch);
> +               writel(BIT(ch->num), ch->ebm->mbox_ctl + GPUEB_MBOX_CTL_I=
RQ_CLR);
> +               mbox_chan_received_data(&ch->ebm->mbox.chans[ch->num], bu=
f);
> +               atomic_set(&ch->rx_status, 0);
> +               return IRQ_HANDLED;
> +       }
> +
> +       return IRQ_NONE;
> +}

