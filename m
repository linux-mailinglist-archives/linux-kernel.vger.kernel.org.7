Return-Path: <linux-kernel+bounces-744042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7881B10746
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F1DAE0BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1125E47D;
	Thu, 24 Jul 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V/vPM8Rb"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FEF25D917
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351335; cv=none; b=ehUpQ4xWE0jz6XbwhWl2rN0NdqKZPr4RrYUmbT/thXfi7N5jSSTOw43E3aW17BeZxgWTKJonGWxcJzSMKF5lR9PCTcvxP4dzpPK+quzLpYDBPVev+akDMlmvE6Bdw9rkKPjhbYJPWszG77tBic67ltfp3URSzP/6x0heC6qZnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351335; c=relaxed/simple;
	bh=KWyqMGEUBT6sPlAYGN8ahqpDMLDIFJaLyGGzuzUqjK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMgV6ubadGP3AycdSDDc11wIYVvBQqIleAOWrE0Ee9kTl4/gPysDJmWQlfwW8HHhvphpXsvWX51DWPFVPK9wBMXYpavd3OacL6yAsX8v9ZmM9r/xVbH9TOZNuFSPOlskLf7rgzdQqYki7KEPTU7oHBL4Zb0vJdBvUj44fFclKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V/vPM8Rb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso810457e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753351332; x=1753956132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWyqMGEUBT6sPlAYGN8ahqpDMLDIFJaLyGGzuzUqjK0=;
        b=V/vPM8Rb1cbKAv+XnKhAJOmIjhQO4tB4NYqtbMsIQL7++wi1r1fweGMRbtHgsBo/Fm
         zYyyOLRDr8faufcUrwibj8Spaz00uUBCsmQ+qSzgCbek0JhsssboISKnyBfMp/3C/YPn
         njKEMYZwFYlJuwY7yQU3VSUy3nc9MBGEtQqBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753351332; x=1753956132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWyqMGEUBT6sPlAYGN8ahqpDMLDIFJaLyGGzuzUqjK0=;
        b=F3CnV86u2J7KLA04NzfliseEyvGcmKLbSviBLuXv9+IPAJY/cwaGkWajOd60j3V3Qb
         C+FqCCMfxmkjBy8DX44joLhhBzgBzj+OFtTLqxeqR/eqztikAwXrNt+mIjlSSPSlO+42
         yACTVOoNR5NyQ6V80inzAB9G2WyCELTqTCZ08ndiY6XhlolwL09szI2neL1Fu2ogJIyc
         70IBGN3AX2DrPzUuMun4T0DvsiEGOhCb/fOSUjbaoofX6yj3rDQk44tt4Tq1w2Mm+gg7
         8httRPcuPmnM+tQx+RAW5vukgWnrHsfS9S1SwtLCSFoyvwgIkeYi4wYEQkS3Neh851e8
         BWhw==
X-Forwarded-Encrypted: i=1; AJvYcCWgJyCIV2PecdNqxcz9T2YViFrEAMkD4MVDcNo07URzl4KpVzlq0VxHZsTxgN49PpdMzjeT/E5fDC4OCRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+ORK+jmEZ5/wQUnK7x7j8K150+ktw2YJbvSdarbKCvG/9bPi
	AAK+4JK+RJx6Gs9RD+u7ncGjB3oGIqkrSb6PfOyzfmnuCf4zCGVs95M7imOpbpZlWts/ASNh5wW
	F+oQ7Nw8Ws+eptTn+5B9RRXOUvRrxVbxdalGmXBn1
X-Gm-Gg: ASbGncuQ18ANHKfwdbb7zua92v3IhEJ32hXfCCex9agoFhTCEwakVozcTkPFz5FO7Fb
	tFofe8EDZiVEMCbVLwr2EvRcGR+65A5HZUk8h6t+MmDQ3qDJ3CzAbYcGJM8fgy6HbpGsihv3pe0
	9vR4+ciBaNMRxjnefezL9+yeD/HwPtllc02t5wUT1XwGvT3YQx6/Sg0eqaLjaO48jG6zyBxr8oN
	8mlttNMqiou7RyIBXRmxcD6EzjUb7Gmx3k=
X-Google-Smtp-Source: AGHT+IESUy0W5d8sN6DOxHQC9VYSfHke7csoBbtn4oiuNMESAIIOLfvRI9EoIcZqqzK+oAmlqA1BtKODIpYwZl1nk3k=
X-Received: by 2002:a05:6512:b06:b0:55a:4b25:b33b with SMTP id
 2adb3069b0e04-55a513879f4mr2300615e87.15.1753351331794; Thu, 24 Jul 2025
 03:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-36-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-36-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 24 Jul 2025 18:02:00 +0800
X-Gm-Features: Ac12FXxwmEtskk9yW4VS4U_sXrqKN7rxCsdJIjp0VaKRTEqFbUzw8Bs63nu9Nbw
Message-ID: <CAGXv+5Gar47gRZoT6DUDpPRabjzoSE==Zi0wrR76A7g-SJL1=A@mail.gmail.com>
Subject: Re: [PATCH 35/38] arm64: dts: mediatek: mt8195-cherry: Move
 VBAT-supply to Tomato R1/R2
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, krzk+dt@kernel.org, 
	conor+dt@kernel.org, chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, jassisinghbrar@gmail.com, 
	mchehab@kernel.org, matthias.bgg@gmail.com, chunfeng.yun@mediatek.com, 
	vkoul@kernel.org, kishon@kernel.org, sean.wang@kernel.org, 
	linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, 
	andersson@kernel.org, mathieu.poirier@linaro.org, daniel.lezcano@linaro.org, 
	tglx@linutronix.de, atenart@kernel.org, jitao.shi@mediatek.com, 
	ck.hu@mediatek.com, houlong.wei@mediatek.com, 
	kyrie.wu@mediatek.corp-partner.google.com, andy.teng@mediatek.com, 
	tinghan.shen@mediatek.com, jiaxin.yu@mediatek.com, shane.chien@mediatek.com, 
	olivia.wen@mediatek.com, granquet@baylibre.com, eugen.hristev@linaro.org, 
	arnd@arndb.de, sam.shih@mediatek.com, jieyy.yang@mediatek.com, 
	frank-w@public-files.de, mwalle@kernel.org, fparent@baylibre.com, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:41=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Move the VBAT supply to mt8195-cherry-tomato-{r1,r2} as this power
> supply is named like that only for the Realtek RT5682i codec.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

