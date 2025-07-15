Return-Path: <linux-kernel+bounces-731170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC4B05052
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B454A4601
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59362D0C6E;
	Tue, 15 Jul 2025 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A43henmj"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE825F99B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554228; cv=none; b=aWnNtTmTrvt42nx5VVTsm/Dp+cXCEDyioFDyyR7MV1wFD7qGze2r8ifmFYcEnjhB/5NPEF0G8rS0cyU1iddqBSWu8mkc49Xm+5y6bJyPn1O2dEBrRXyy/a8p3tI+odvYytUO5odrilfKsi2ImggxfZfawrxJgjKa7qMBzNm1rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554228; c=relaxed/simple;
	bh=HEym2MfRYDRe1WStyHMOT8vdThlsV2VAJ0myxALEAgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kI0fB/3kMGgdE/XEMQfDtbb9Gv+hjl4uFd9TEzKgAs95h8mdzad7QbZj1QrB8jyzvAi9jJA2riiAgYsv/gBybfoiyYhOXjdchXtVhh5w1euCf0vBIYTMznQcU5dn/g9ADf4bYhBhLb8U4a1BK7exUAu+XK1FOVAqqID73nrFHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A43henmj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31d578e774so5061143a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752554226; x=1753159026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqg4UcH4HOCD8WdGE4+ik0rgx/yjtc/u1ELlwLDaNkk=;
        b=A43henmj4KmroWVbHwKFQPtrnX1jzu3bqWZrGcEcn43gimxYAkUn3PRoJ30w9fVUBQ
         0HYPp4Ti/KOmPGMhBaqOsQ5R7qRKn3IxWkeMxxoAp9qwQb3xwAMy9nJYouryCge+thrA
         5GkzURi4DmrwjmLYQ3JDfXVRm36S1Fs7MGY3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752554226; x=1753159026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqg4UcH4HOCD8WdGE4+ik0rgx/yjtc/u1ELlwLDaNkk=;
        b=NbsgLXjmt4b9GSkdGJNhy25/Ev0bYOJdCg8kXXv/4Xp6IGzmOLEigWojQ+oGEBnqeo
         reHhwJ+xhEWvIsG8Fst2eWKvH1YZiNTZtHFMMgfetE46iS/97KvzPMV1ady4p4EnPsYs
         IyZVoT89F2J7s3l6tPITg+VL/6Z/HILzV6yt3Rq12UD+mtY9Ft4O366wygX2pMsSdif+
         XFdL5nQT+dPS6XImqajWmyyHYQHPIIqcgRc2uJIG3a2zGn7YbF2FXvjS+oPJPMQhE2cJ
         9qaeKzGf53l5pSpBckibRou2qjZdDRxONIzLw9r9L4edtVtcvlU200grvpCOjN5jDPyB
         M0ag==
X-Forwarded-Encrypted: i=1; AJvYcCV83fBfX5/THLUx0szVr3XqJE0E4U3cBpchQb5lIV1d44T1a08Xbo6u/MyMCA0Hih8xSD0mCaoImjtInUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvGKD1Ej3jGR+U+lEEnNLN3jmRqaj1XPZHWqztdqab9FowDO4
	fpXefOLKlNSgyVPqqVr4yXCZ2BkpqWTh97VpuA3Hbbnk/i7ICNjeDB4Rmtwrfu75RTObnOtBL2m
	MN5C9EzUCHo2naf7DF4lxow0Gji6TwspTNpKOielS
X-Gm-Gg: ASbGncvYjf6xuI0VCyC7o8dAwHoNudd857qwyIz3hR+Vn1r4ILMP/x1ZH78pr2vp0vG
	asDiqpsZiN7LhLhfspyh4SARxGiQW3sWjGnYioU9E7fqJ1cDn4tfL3E1CwJJ+v6i5KUonNhxWUP
	md1MA3QIFcVotthJUaDZVYknB5p8LJPcb5cZJTUR6PLENPorE2GmCXRKNwPokneDaR6jbjqn2sN
	19yNVapQN5g8IigPDEiIvEutqDQsTgUs0pAl9YK0KHyIw==
X-Google-Smtp-Source: AGHT+IHf1xc3dLDnNYF/fDC0d2YbPGxvPK9FwAjwgXDKEU1kkJL2K+WT5K+79jl9PQ6eV0yj7I0MMHxdLoUbmyObj2Y=
X-Received: by 2002:a17:90b:57ef:b0:30e:6a9d:d78b with SMTP id
 98e67ed59e1d1-31c8f88d387mr3132859a91.12.1752554225889; Mon, 14 Jul 2025
 21:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624143220.244549-1-laura.nao@collabora.com> <20250624143220.244549-19-laura.nao@collabora.com>
In-Reply-To: <20250624143220.244549-19-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Jul 2025 12:36:52 +0800
X-Gm-Features: Ac12FXyo_hm6-LevP76Ht3AHw10mSGdmwELcsNXs6PZZNLb0jYOFlkoLp35KGco
Message-ID: <CAGXv+5ERCTTJVfgfY=LLTKasz7RpTdpPfHJDKtKiUfcYyrS8uQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/29] clk: mediatek: Add MT8196 adsp clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 24, 2025 at 10:33=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> Add support for the MT8196 adsp clock controller, which provides clock
> gate control for Audio DSP.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig           |   7 +
>  drivers/clk/mediatek/Makefile          |   1 +
>  drivers/clk/mediatek/clk-mt8196-adsp.c | 193 +++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-adsp.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index cd12e7ff3e12..d4c97f64b42a 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -1068,6 +1068,13 @@ config COMMON_CLK_MT8196
>         help
>           This driver supports MediaTek MT8196 basic clocks.
>
> +config COMMON_CLK_MT8196_ADSP
> +       tristate "Clock driver for MediaTek MT8196 adsp"
> +       depends on COMMON_CLK_MT8196
> +       default m
> +       help
> +         This driver supports MediaTek MT8196 adsp clocks
> +

This is part of the AFE block, and really should not be a separate
device node nor driver. The AFE driver should internalize all these
controls and ideally model some of them as ASoC widgets so that DAPM
can handle sequencing altogether.

So please drop this patch, and also drop the entry from the binding.

I've mentioned this to MediaTek's audio and clock owners, though I
assume this request was somehow lost in the process.

ChenYu

