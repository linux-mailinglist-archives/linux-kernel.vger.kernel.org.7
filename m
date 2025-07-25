Return-Path: <linux-kernel+bounces-745768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E46B11E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698403AF338
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F218A2451C3;
	Fri, 25 Jul 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T2dhEqI0"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0092D24113D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445676; cv=none; b=bdzdCNgJ7QKU1zEHH7HTw/7jH1CYPZ18lSlYoO6eEIkhpkJ61R26DL48ROZl+GRJOCv4CVeTC/7kqP9Kt5UiC4tfOmdT7uy3ZxbQipS1FPTZG+EnykmQf1gscEd+2/WkoCZxtD33mK4Fl6o8XbguWuRfvi3cxZi3XBIGiM/Iy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445676; c=relaxed/simple;
	bh=AyRroNoAAfZMLYMuOWzL5KFUvjXMr31GJOyZqB2g5AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBj4p8ZQ2Ie5mVqz2pmoQ3qpEyxEygk98Tx3Jj5Sh8eeBOJcYra3SZqC9dl5dxbOsxc7xKla0rex6DkU2cLlaza2LS25F9FckPjf+GHGsdjxtxNTi41lpN7kepuIjVku3MuJOr7EN5XQ+mFSpL6h0vIBgknYcISG7lIyWWOTLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T2dhEqI0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so1984739a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753445674; x=1754050474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t63BOHgVickClQUeVRs7VclE4TnB0fFJ8koSEGsWT2s=;
        b=T2dhEqI0AQHMjquQhEptB/XMRS97Do3AdBq1MwJXadd7VzbXet5cw4/xGC6B40/Tgx
         jl9aToDC6dfP3dsTF9cAzRTKdr7iSxUVrTMQfk7N7CGIYG7N1wH2FdKgSeY8tlp5mlj8
         FGbV3cTtRiiNKMQ1zVLC6pTpL5Y7riiKVZwTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445674; x=1754050474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t63BOHgVickClQUeVRs7VclE4TnB0fFJ8koSEGsWT2s=;
        b=t5OCGR+VaHAgEv5XmBMF9+j3sIuOZNW8qc5fNR0wFvCtbvX66GS0T58Y6W12tiL82f
         9lsb/0W2XkfLLvH7auWbENBB95Zzt0SA83O4RR86Dhute+0n7Yjk2/Wdf9RkiSSMRxJw
         eNGqOSEDl9TGYJ1ri4HKh2vUKblrSqeh3B1N0S+1EFhAYdeO38dMODnO7Ka6rV57hfcg
         MO1NRyKdBLyCrtFSxtidOdn/8RIfhDfKvJXFy82tudgCAMpIk5NklJqWiF7ufA8DkleD
         p/uy81lOzSWNOv7bbi9VERmkO/BCy3z2/KeW227H8bDlZN5xhaZNn3IKcUGRnXb5+rQc
         +H7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCqGOejipzlEAteLV/iWDQNS07A4pEPEFVNWy5Zqxtp9Ox6ODHgbh53TS6USgVDmDn6u56PN1yAYAAmkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqT+XF6k3MuZ+MFUU2hnbixn9jFkJ3plUN1AJe5NB06ERi+4B
	Jj0WPdb7k48CJlB7YYLse2at5t9BFS3Pc2G3POssqJy11HDAL7LnNile/f0g9arW5sFcD6K5xZM
	EPUU=
X-Gm-Gg: ASbGncvP/FX6RHwopbOWwrNccIVIgQipv4Xon9uKt+B8I4qMwshDL4nEy9msZmhD83I
	tJxj2RXU0IMNejFZm7o8pNYt+SrAcc5m8tJyjptrNoj0fWXX4+CaIFJpfuXZPE3DM4RTuSVoK9Z
	Z20BZtxaMpJlhabneGgfvBS3W/HUujtjAP3lO1cEAuwHwA8FLuUgyJMelS2sABaT9FzQIMd7a6q
	LGpHJOwcF3qOpiP90zWY0DQQBEJVQ3LwPVuUzRGckIYbSSQ7u63gR9eCwbxvS3BFmozAXWTCsNA
	g8OQmAYSQiGYmiDuoge2NmoIDXbwalG30pkgyr4uPRm9fXjLUiTNV0ArQmRXyRQbRAvjK3FwUve
	tFqhts6Wrj1roUXUaG3/jAeoPBPTnWHBuAcFoVADdfzkq5TcXgF84qdgXP7t1yw==
X-Google-Smtp-Source: AGHT+IFS9Moc7GyCYctP395wbKfTT3Nq+G4+hE5/1mMvOPFJoi9XrBGXF9K++z9O0MmkG9gJGJ+4pw==
X-Received: by 2002:a17:90b:1b4c:b0:311:ad7f:329f with SMTP id 98e67ed59e1d1-31e77a229aamr2533359a91.31.1753445673878;
        Fri, 25 Jul 2025 05:14:33 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6639cff0sm3402405a91.36.2025.07.25.05.14.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:14:33 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748e378ba4fso2635818b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:14:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8za1Ab1smk6AG6R/dpjiqKEANz8Jmk1MxlF6t1BaHSmJIYhd74NjJ+0qKsCMUT8ma2jFmiKxkOIqxGEk=@vger.kernel.org
X-Received: by 2002:a05:6102:3053:b0:4e6:67f6:e9af with SMTP id
 ada2fe7eead31-4fa3fa71860mr256656137.9.1753440125688; Fri, 25 Jul 2025
 03:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-27-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-27-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:41:29 +0800
X-Gmail-Original-Message-ID: <CAC=S1ni_6YRK0RWheKZJDgCknaZzPsde0J4dFdmkNhY7HMMD+w@mail.gmail.com>
X-Gm-Features: Ac12FXwspafB6XO0s33DaaDCIfXTapXC0TbPbPDsXvwxpmO6Wfy_iIb8kWhO-Rk
Message-ID: <CAC=S1ni_6YRK0RWheKZJDgCknaZzPsde0J4dFdmkNhY7HMMD+w@mail.gmail.com>
Subject: Re: [PATCH 26/38] arm64: dts: mediatek: acelink-ew-7886cax: Remove
 unnecessary cells in spi-nand
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, 
	daniel.lezcano@linaro.org, mwalle@kernel.org, devicetree@vger.kernel.org, 
	linus.walleij@linaro.org, linux-remoteproc@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	olivia.wen@mediatek.com, shane.chien@mediatek.com, linux-gpio@vger.kernel.org, 
	linux-phy@lists.infradead.org, airlied@gmail.com, simona@ffwll.ch, 
	herbert@gondor.apana.org.au, jassisinghbrar@gmail.com, jiaxin.yu@mediatek.com, 
	andy.teng@mediatek.com, chunfeng.yun@mediatek.com, jieyy.yang@mediatek.com, 
	chunkuang.hu@kernel.org, conor+dt@kernel.org, jitao.shi@mediatek.com, 
	p.zabel@pengutronix.de, arnd@arndb.de, kishon@kernel.org, 
	kyrie.wu@mediatek.corp-partner.google.com, maarten.lankhorst@linux.intel.com, 
	tinghan.shen@mediatek.com, mripard@kernel.org, ck.hu@mediatek.com, 
	broonie@kernel.org, eugen.hristev@linaro.org, houlong.wei@mediatek.com, 
	matthias.bgg@gmail.com, tglx@linutronix.de, mchehab@kernel.org, 
	linux-arm-kernel@lists.infradead.org, granquet@baylibre.com, 
	sam.shih@mediatek.com, mathieu.poirier@linaro.org, fparent@baylibre.com, 
	andersson@kernel.org, sean.wang@kernel.org, linux-sound@vger.kernel.org, 
	lgirdwood@gmail.com, vkoul@kernel.org, linux-crypto@vger.kernel.org, 
	tzimmermann@suse.de, atenart@kernel.org, krzk+dt@kernel.org, 
	linux-media@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 5:50=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> There is no need to specify #address-cells and #size-cells in a
> node that has only one non-addressable subnode, and this is the
> case of the flash@0 node in this devicetree, as it has only one
> "partitions" subnode.
>
> Remove those to suppress an avoid_unnecessary_addr_size warning.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt7986a-acelink-ew-7886cax.dts | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-acelink-ew-7886cax.dts =
b/arch/arm64/boot/dts/mediatek/mt7986a-acelink-ew-7886cax.dts
> index 08b3b0827436..30805a610262 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-acelink-ew-7886cax.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-acelink-ew-7886cax.dts
> @@ -98,8 +98,6 @@ &spi0 {
>         flash@0 {
>                 compatible =3D "spi-nand";
>                 reg =3D <0>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <1>;
>                 spi-max-frequency =3D <52000000>;
>                 spi-rx-bus-width =3D <4>;
>                 spi-tx-bus-width =3D <4>;
> --
> 2.50.1
>
>

