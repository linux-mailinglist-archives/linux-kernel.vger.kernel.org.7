Return-Path: <linux-kernel+bounces-774906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C97B2B90C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA4B5821DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646B2571AD;
	Tue, 19 Aug 2025 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gUusRoSk"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8A212B28
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583330; cv=none; b=Vxer4QHzpoigL7JnV6Gk5G60xxS0pMiwBcJd8y7NsiBF2EZd1bYGv9Tk6yzlD50VCgN4vOo9iX+S2vu1Mel5iv5s93bJMA3a4COyUTtOb9DZKQdz5mmzjQQ/6x+2UH8MDzyq3Mr+KU7KtEua9FxDH5YM+gKMv8r5xtYwf/FoTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583330; c=relaxed/simple;
	bh=5UOBwM3FuM3CqepL4vT1QVB/0S6gmYCpUeqUxFqp2aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCZ0DS3JZ+0lb7htaBwkzDu8AK0oodd3VUOnXU3LXMa1W/T3BoHC1RwxYw8aklcpwYVmLq212wNehf6FYZLEgiSBLg1lxhKTYZ8XqCNu40edwOmNKeeTasJHVnLekAF1/wgJ65quQJAtfsoZ7t0H8ManIy4tDQlJeoRmbNHv54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gUusRoSk; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-53b17378b74so1817938e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755583327; x=1756188127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXR2SIVmzRbhWkmgj79yu4WBPuxOGQNxUcObjKJ7UfA=;
        b=gUusRoSkGx1G53X5rG8F2oCH+/WUQEoFy4CST4Ce47TBqS8TjDGV3Ibt6MfitDDWM6
         /Y5VB5vCdNhUgudBnzpAX0u3fIKByJJo2ciAbanRUT67Pi8Of9BeSzJMpwx79i97ZgtZ
         z6HdW9lbdd3JiPWuH1FWMj4HK183u0GK9SqVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583327; x=1756188127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXR2SIVmzRbhWkmgj79yu4WBPuxOGQNxUcObjKJ7UfA=;
        b=Z3X/yAMFmoIYIFXIVimhvppG7lydKnr/kbugNWHChhc4dzgUJR8UK2bVdgIeutJMVg
         2hh37YrP4dB0jUH+z2vYeOqNVeooxXOXlOYl4GjYRPbzkQJ//RzsaQQK9x4AlaFSePKJ
         bEeUXZoTAxmKxEctlRsxbncmwOn3hzrqXZw5+UDkr3kYRawizMt4FwmmlWsD2fPqiz9s
         FMPgudMO93KGv5mAbGorHrz940g26xaEkRlu1sZBkD9qHzad118ZkT/LCn7m+jpaqktf
         2yhOQKlyfi24VL583uPKSa0zRpeQylIJ0H+XoKC9eJ/8EMEl1es53qM3kpUn4vqhilyF
         J4FA==
X-Forwarded-Encrypted: i=1; AJvYcCUYTPeLWLZjjKBFr0CtnLGvpKUwGW8irvRyM5AbUtB+eQIi0WQW5avshfjTey6hiSG0e31tN5nWqSv1Jew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPh9pHfuWfyREEBmXAdzZwSkOT//gxJ7pNBLNtUlFOcPpP5GEi
	ND2gaEjMr1Vzf171WQCDKjFwT/X65BOFwPOvch8zZ2q0ddXamWRxRKdM4zUV+//C6PkR8Qh1qoN
	m6so=
X-Gm-Gg: ASbGncvTNxYPalYvWjpTDiN3f8aTlu7KGgDI/f7OAPx7Y+OGETd/+qrLm+y49kdy3Ft
	SQZRfjFHt5VdarxxLHuRUm9Ap5vPYlGutgy0Ql7XkNc3/9JpGx3GdE9WcDuqIZJ2QHjBHah7s3X
	8STXDV4AoK4PGvfIrSeud/0iHUQs1vMMwe9tvakNf/m/AXXaqSiL1Y2pLqQe0D1iXhMI8FZm3ON
	0IbH30rUwMcQW/colXUJb4DL8doGU5Vf1acinOiUYKTO6SLdySMpDg/l6CvHK7cOihd5WZRFaiE
	5urx1Vpfy7Adfs5YQVAos0MUGXS5bhh2D1D5oWke1llA+l95wMCqo/zErj68uktS0MgcbXL/P/P
	XJ1Ydd6xjPZFyk9dHMf26wIHfLH/TPNp3l93k40qmP3+FMQ/uYgGiypAsJau2+rkNkB+Y
X-Google-Smtp-Source: AGHT+IHejdlIbRMRJ8RDSmseSYtIMRP9St3qRthseO+BNjMsU2et28M3mG4cZD3MSHTawh7AqEiXtA==
X-Received: by 2002:a05:6122:d8b:b0:530:72da:d13d with SMTP id 71dfb90a1353d-53b5d0f11e1mr452984e0c.1.1755583326845;
        Mon, 18 Aug 2025 23:02:06 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bed9fe1sm2596855e0c.16.2025.08.18.23.02.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 23:02:05 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-89019079fbeso1299614241.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:02:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcYlz0JRRDYLTZdJmS1A6lcIQr0oFlmMy5csQ8Ig921dPLC2mrJ6IHWBK/rVPLk5VmOzObuO0DiNQfexc=@vger.kernel.org
X-Received: by 2002:a05:6102:3f0c:b0:519:534a:6c5e with SMTP id
 ada2fe7eead31-519534a7300mr195467137.33.1755583325362; Mon, 18 Aug 2025
 23:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818084242.1045095-1-payne.lin@mediatek.com>
In-Reply-To: <20250818084242.1045095-1-payne.lin@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 19 Aug 2025 14:01:29 +0800
X-Gmail-Original-Message-ID: <CAC=S1njekmPyq5653Ybi8+7i2_+Dx978aJOQNUTuRBs0ef0sfw@mail.gmail.com>
X-Gm-Features: Ac12FXydKLVgTfkAYyLB7X6R_EuK2D-Oxvhl2cOx65LzvRizoLO1BDAMlYJ--fU
Message-ID: <CAC=S1njekmPyq5653Ybi8+7i2_+Dx978aJOQNUTuRBs0ef0sfw@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: mediatek: correct clk setting AUX_RX_UI_CNT_THR_AUX_FOR_26M
To: "payne.lin" <payne.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com, 
	vince-wl.liu@mediatek.com, jh.hsu@mediatek.com, 
	Bincai Liu <bincai.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 9:37=E2=80=AFPM payne.lin <payne.lin@mediatek.com> =
wrote:
>

Start the patch title with "drm/mediatek: ".

> From: Bincai Liu <bincai.liu@mediatek.com>
>
> Updated the definition of AUX_RX_UI_CNT_THR_AUX_FOR_26M from 13 to 14.
> No other code or logic changes were made; only the macro value was modifi=
ed.
> This change affects the timing configuration for AUX RX at 26MHz.
> The formula is xtal_clk / 2 + 1.

The datasheet says "It should be set to the ratio of the half cycle
XTAL clock to the 1MHz clock.", which doesn't align with your formula,
so please explain (1) why this is needed and (2) whether it's tested
on any MT8195 or MT8188 based devices, in the commit message.

Also, you'll need a "Fixes:" tag[1] if this fixes a bug.

Regards,
Fei

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html=
#describe-your-changes


>
> Signed-off-by: Bincai Liu <bincai.liu@mediatek.com>
> Signed-off-by: Payne Lin <payne.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp_reg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/medi=
atek/mtk_dp_reg.h
> index 8ad7a9cc259e..f8c7b3c0935f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> @@ -301,7 +301,7 @@
>  #define AUX_TIMEOUT_THR_AUX_TX_P0_VAL                  0x1595
>  #define MTK_DP_AUX_P0_3614                     0x3614
>  #define AUX_RX_UI_CNT_THR_AUX_TX_P0_MASK               GENMASK(6, 0)
> -#define AUX_RX_UI_CNT_THR_AUX_FOR_26M                  13
> +#define AUX_RX_UI_CNT_THR_AUX_FOR_26M                  14
>  #define MTK_DP_AUX_P0_3618                     0x3618
>  #define AUX_RX_FIFO_FULL_AUX_TX_P0_MASK                        BIT(9)
>  #define AUX_RX_FIFO_WRITE_POINTER_AUX_TX_P0_MASK       GENMASK(3, 0)
> --
> 2.45.2
>
>

