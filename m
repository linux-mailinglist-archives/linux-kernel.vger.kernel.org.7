Return-Path: <linux-kernel+bounces-802034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99715B44CF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138E61B27809
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F28266591;
	Fri,  5 Sep 2025 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EqE4M6jg"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F09211F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048492; cv=none; b=nSXYtxr37jSVWblCxBw9vzXgAaLzRIEsmnrJgmI/Fq208g7yUGmnK9xmyc83xo25RkWl8EqSw7z3Z0dTBgLhCRlKyv/DRowOmNomJK96Uj13HQ/O9uz4SCpKp4RUIZaMbhWml3r69LWcBKLWO+HdPLumjrBkjtsxldfT8Sjmkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048492; c=relaxed/simple;
	bh=njvK5FtQ51xwKW4s0pYsz4x7aMPMIyJMS4OWthiAzGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoxvGjk3f0XjqtPK1Jy2kNkGMF/C/GTmhd1jdMhIdjv+4CkNPMsMvWoGsgVqECKaZxuB8HWJxv0AchfSFVMQEbIn6yDSYSUEUqRzTs8bTTXDtcIBELAqig1rtMRUY+lx5vs55NS5wWrhWz2+NjNIt+8tKTja92BrDBhXV9UuaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EqE4M6jg; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-337e714b3b4so14004531fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757048488; x=1757653288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3pbQnf8CUqRojAhpUlOIMWVPCuywXIR601pJXOx+Vk=;
        b=EqE4M6jgR5rIe5A3xGBaoGQXZmnZP4E/gqVhNrv/kjCXnKsX9khbaYkyXBKGzPb+Bd
         zrJcN5xf8rSCZemJI0eE0QKlXb5vXzm70IvIBc9x+vP0uP+mbJUF3L4g/vn4kZQaNLl7
         S1hPR0QEyIcqbXYwqikiaRaU28v05PdWrCe6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757048488; x=1757653288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3pbQnf8CUqRojAhpUlOIMWVPCuywXIR601pJXOx+Vk=;
        b=SxN4F5uasohQcFN2ody5NVFF09GnGq9eg/qyTZKj3wkcDmjARiCl4beFYe294SDc96
         lDUEJADlNVGtBgdDjmHivUbPlyyLjZ46+V92zL1l/dsaxvXMnc12/ArMMR5r9QytwEyM
         qFSsJ0EWV1koy0IAopRFSn+EcICP8vEEAekGEiUTHqHmXeOnbvM6UkkYy8m9PrQLXpuV
         W1o/YKmVRMbHs/Y3B4D2/yvuqNKmxxlQjAbkYs9QW044DXJK6yzw53bjLiuz67aEA0PZ
         nI6QYe6hv2dxo3LyzXN4b/zwu5Gs+s9stNONXiLC0mDTM6i3bv+IjLtlq85GTK5m8y3r
         or7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX53hjHQTS5o9W4Jfz2PUvAjUbX46NC0bIVXazCLX3qnhkpK2qDV/Fvya2CU/Twu95YAzvSTuRRDWFOt3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBK5OVLoRH9j8Bt2teA1s94pexu1Ssxy2KTE3q+TcYcaxL9bnb
	mAXiAp5iDfWNf2a7TbS9ddWGbpwPabarK+DS8NpVOEdU4VSAPXygKV0eY15kuKk9IsnyvK+YJs2
	ljxiEnRqGigc77im+f9/KBaLFCaRgfvEbLEV9ffb6
X-Gm-Gg: ASbGncvNaPATq26ySiAa06lhPUT2bmg4Ld4HoI66infPe4tBZAD/wLO+BEb2S2D00WA
	xxVGNAWeTdjX3YwXNdzgMKPMF3drnuhCGbxDmqVfltEGcry8qKq7uqwmFTOx+5DQEbf7z9fllTX
	gBghOq+ox66i6oMdG81p6wVeExj1E/4jcG+DHtuuZ/k4Ljvki4KSSJWl5cvFpN8j3t4ujHIytYy
	qH9SJFKA9V9fDE/3vqA0oTivhb16GIHuXY3Gg==
X-Google-Smtp-Source: AGHT+IG10f/KUXsl9teEaeQj7H79dcAZoPGx48y81i6F/mMxgob5Z7ShaCVyVzMRSRmKn/PqDEFL3jvm3MNUmJiY2p8=
X-Received: by 2002:a2e:be1d:0:b0:336:dd88:6a02 with SMTP id
 38308e7fff4ca-336dd886e73mr50101251fa.43.1757048487955; Thu, 04 Sep 2025
 22:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-14-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-14-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 13:01:16 +0800
X-Gm-Features: Ac12FXxt8YDULnOSESMbWAKIOZ29Yui3hZN9Zs_7tmp-v_md5T4Hs_0EWckqSKk
Message-ID: <CAGXv+5E-EM6aMR3M=rk2HMT8qCn5J-zuqFtPJP0G1x7+Lj1gEg@mail.gmail.com>
Subject: Re: [PATCH v5 13/27] clk: mediatek: Add MT8196 vlpckgen clock support
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

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 vlpckgen clock controller, which provides
> muxes and dividers for clock selection in other IP blocks.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile              |   2 +-
>  drivers/clk/mediatek/clk-mt8196-vlpckgen.c | 729 +++++++++++++++++++++
>  2 files changed, 730 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8196-vlpckgen.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefil=
e
> index c415453e02fd..031e7ac38804 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -151,7 +151,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195_VENCSYS) +=3D clk-mt81=
95-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_VPPSYS) +=3D clk-mt8195-vpp0.o clk-mt8195=
-vpp1.o
>  obj-$(CONFIG_COMMON_CLK_MT8195_WPESYS) +=3D clk-mt8195-wpe.o
>  obj-$(CONFIG_COMMON_CLK_MT8196) +=3D clk-mt8196-apmixedsys.o clk-mt8196-=
topckgen.o \
> -                                  clk-mt8196-topckgen2.o
> +                                  clk-mt8196-topckgen2.o clk-mt8196-vlpc=
kgen.o
>  obj-$(CONFIG_COMMON_CLK_MT8365) +=3D clk-mt8365-apmixedsys.o clk-mt8365.=
o
>  obj-$(CONFIG_COMMON_CLK_MT8365_APU) +=3D clk-mt8365-apu.o
>  obj-$(CONFIG_COMMON_CLK_MT8365_CAM) +=3D clk-mt8365-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c b/drivers/clk/med=
iatek/clk-mt8196-vlpckgen.c
> new file mode 100644
> index 000000000000..c38d1e80a5ba
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c

[...]

> +static const char * const vlp_audio_h_parents[] =3D {
> +       "clk26m",
> +       "vlp_clk26m",
> +       "vlp_apll1",
> +       "vlp_apll2"
> +};
> +
> +static const char * const vlp_aud_engen1_parents[] =3D {
> +       "clk26m",
> +       "vlp_clk26m",
> +       "apll1_d8",
> +       "apll1_d4"
> +};
> +
> +static const char * const vlp_aud_engen2_parents[] =3D {
> +       "clk26m",
> +       "vlp_clk26m",
> +       "apll2_d8",
> +       "apll2_d4"
> +};
> +
> +static const char * const vlp_aud_intbus_parents[] =3D {
> +       "clk26m",
> +       "vlp_clk26m",
> +       "mainpll_d7_d4",
> +       "mainpll_d4_d4"
> +};

The above parents lists are incorrect. What we want is to exclude the
"clk26m" parent and only have the latter three parents. That is why
we have the parent index table below.

So please remove "clk26m" from the lists that are used together with
vlp_aud_parent_index.

I apologize if my previous explanation wasn't clear. The index table
is meant for "skipping" parent mux values when the values don't start
from 0 and/or the values aren't contiguous. The number of values still
has to match the number of parents given. The index list below is
essentially saying that "parent 0" is actually at "mux value 1".

> +static const u8 vlp_aud_parent_index[] =3D { 1, 2, 3 };

After this is fixed,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

[...]

