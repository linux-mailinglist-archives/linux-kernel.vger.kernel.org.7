Return-Path: <linux-kernel+bounces-837677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979DFBACE56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CE617D6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F192F60A4;
	Tue, 30 Sep 2025 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEhVLWWm"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19603146A66
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236208; cv=none; b=Sv74uoOQzWjoqeuekqaey1kddg9BxfyuEavo4io8bh/tyQDwViIHRtiDrjCprzNwSjyYKnAaC4C5FetfzKfN05t07WEyZ44OLoZct5z15NwQwnpX1YEYTEzjA3pcoZ1JrmBKinvCcKbDaLWbYbT28ms6xX69WXYLDFg2JYE4qfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236208; c=relaxed/simple;
	bh=QnQeibjSRFSP40OHNh7RhWh+U6kpwxTlw1H0q2TQGa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjHUHNwc4Ak1c8gQxWADWUukJcagWlv9otR+2UwvdcIGWBuqrGfWZgLSvuTYCxZbiuCPO03L0zBfzo+ecMz2o4IVuGUC10Mw067jV26COZEYiz+r6t4MAKaoh38hL2iC5D9OScyu5SoENfadrm2hs5d/eP4c5L21LTJ5ZAL8Q6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEhVLWWm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so6265718a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236206; x=1759841006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1/Agq+DmRlV3c936zuz7MXdyoSR3KCIK7Avb8fH1+Us=;
        b=WEhVLWWmArAT/onG8Rie2YQkjnIcQgx90XBVtct7ZKzp9vH7AiHaAiOQ70ov8Av/VL
         vCVbILxOM6NrYCEG9a4pzHTHYUJ4x347tn8EpU0k0csARIgX5KrOjgDqCat96c3a9Ckx
         eVa35i97qvoOQ9ZjIQxsQtfdCKuDslov98NnHTVskZN0ehhMwsI0eCiatWthHi8IJQvB
         gvvy9NGrK8OEFTGgIdI2hzqsXb4yYmBAv9o+JmKsfEH6wvZP4INLQr7rU8zO8YbD2vEt
         6shHaIaqfa6wY1M7cfxdJrx85mv5EsQ+kt94a7M43MxJTvyavn2sSl3tgJ/2oEpy6ACy
         tCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236206; x=1759841006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/Agq+DmRlV3c936zuz7MXdyoSR3KCIK7Avb8fH1+Us=;
        b=pEzelnK5OdxAlr2JFzU/mj+psarhrUV22SNEy08Jikwshn3U3Bk+S3rOYMeNw35nuF
         KSCbywqO6EiXD/MVRbAcuC3Gt/t9CnCOZHAH1fhqj53fsskO3e7I+DnWNrEFRJVIoPZR
         Ebg1UZ4LEblfoMZH6PY/UHhTGX12bksAXrQJ1mrp2e/6smyF4F42/Aip5bc4N2//qGoV
         /l9UbndrKygNpCD2f+ulPHAHzI9H/Ve2+F1pYa1lElckvy5eaFfh4ejukDfHAz36Ov1k
         eyujLAb3tUCOIrorfWEBik3EJ7yNIcYTinsZr6YPhiPTAQPCuP5I/atstwBNDtjcl4zq
         /qEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR0KxAyZPN4sT5iZ4HLzBjBIkoGHqAkOxDI029Wng1K3/sq50DVfD9qFvXRdqLY+ew0qHG74N67MUweY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrfSq+nPAiiorDwNPl8zA6nKmaqVljR2vtGVPFBIsD1DfnDMF
	5LF00pgM7uXZxgVeGf3IwgT26yZezqPt2HWfYL4CbjIfk88Ttz9XVaWP0MXRqpevSDASaRosjgp
	nv2HkHSOAFQNRubJuTkFc/mOapCKIetg=
X-Gm-Gg: ASbGnctronBi/XZAVD/DmnjttmRONQlENJ6UOCs/tIFF3heHOfipw5vfciFjAp3wYpB
	dW7Q1nn33uCTYYDoNlg19YrWXbamDyeM0y2G8aE+0qDkNJ8h11TSxfPUsEtI2ZT5TDi8xcqwN5q
	stgUGaUplxn1d/uvDr0Z1nXp50o+96vNJMpnjCtye4z82QxtRiCRzPPjccYVczDHca5dCS/UkVp
	FHxHd6H07zLfHupv6jQ3nyqner1gs5xsOdE5QKpSCrdNpnVhUdnV3jnVGC4MzyHiQTk1tI=
X-Google-Smtp-Source: AGHT+IGlDVENqyPUF/wBYi60oP57IjahL5kiurXffE7HAwGcLmim1a+I7hD66oNEXQccJV8ZSViK42Xuiz9c9fax5QA=
X-Received: by 2002:a17:90b:58c5:b0:32e:d011:ea0f with SMTP id
 98e67ed59e1d1-3342a2d1bacmr17879511a91.25.1759236206384; Tue, 30 Sep 2025
 05:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919183042.273687-1-marek.vasut@mailbox.org>
In-Reply-To: <20250919183042.273687-1-marek.vasut@mailbox.org>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 30 Sep 2025 14:43:14 +0200
X-Gm-Features: AS18NWDS9-HN51yhqFAHzOnB17BCVRavC4Epbi5odLIjFtiVIVzgVXHC6qF2PyQ
Message-ID: <CAH9NwWcK_z_4CcDBRYS2nf3AxYV9-XwirvTd+O9uJtHMhyA3Og@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: add HWDB entry for GC8000 Nano Ultra VIP r6205
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Simona Vetter <simona@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the GPU/NPU combined device found on the ST STM32MP25 SoC.
> Feature bits taken from the downstream kernel driver 6.4.21.
>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Acked-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: etnaviv@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> index 8665f2658d51b..32d710baf17fe 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -196,6 +196,38 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
>                 .minor_features10 = 0x90044250,
>                 .minor_features11 = 0x00000024,
>         },
> +       {
> +               .model = 0x8000,
> +               .revision = 0x6205,
> +               .product_id = 0x80003,
> +               .customer_id = 0x15,
> +               .eco_id = 0,
> +               .stream_count = 16,
> +               .register_max = 64,
> +               .thread_count = 512,
> +               .shader_core_count = 2,
> +               .nn_core_count = 2,
> +               .vertex_cache_size = 16,
> +               .vertex_output_buffer_size = 1024,
> +               .pixel_pipes = 1,
> +               .instruction_count = 512,
> +               .num_constants = 320,
> +               .buffer_size = 0,
> +               .varyings_count = 16,
> +               .features = 0xe0287c8d,
> +               .minor_features0 = 0xc1799eff,
> +               .minor_features1 = 0xfefbfad9,
> +               .minor_features2 = 0xeb9d4fbf,
> +               .minor_features3 = 0xedfffced,
> +               .minor_features4 = 0xdb0dafc7,
> +               .minor_features5 = 0x7b5ac333,
> +               .minor_features6 = 0xfcce6000,
> +               .minor_features7 = 0x03fbfa6f,
> +               .minor_features8 = 0x00ef0ef0,
> +               .minor_features9 = 0x0eca703c,
> +               .minor_features10 = 0x898048f0,
> +               .minor_features11 = 0x00000034,
> +       },
>         {
>                 .model = 0x8000,
>                 .revision = 0x7120,
> --
> 2.51.0
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

