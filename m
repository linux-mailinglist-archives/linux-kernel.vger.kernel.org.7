Return-Path: <linux-kernel+bounces-870849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D639C0BD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F8DD4E0682
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01FF2D5C8E;
	Mon, 27 Oct 2025 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+TJQiGU"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE253198A11
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543562; cv=none; b=byGJf0RKjDpzeQS1JP6ENGXZJs5ChEXpGy0Q2xQxHr/B8CnGi4EvBfg3JG3r+riT+cHidH2jAbX1HyK9QRYLZ2llFuf2Kvj6IB+Hiu9yGwc0veyykCMek+kvfhPtGGhsKELt487e9w7phYwTMPQg8K0mqr4NqxiNYRPNo6JtKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543562; c=relaxed/simple;
	bh=Dyg2lhD4hCvz2MTn5rxtowsyJjy35Ud3uF3/0mWHWLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZW7+ubsaK0B8TWNLTBd4ViZmnqIqUzXqJOw5DeXOXMZWIWuQ44pumjVUvSCazuI+y7NKWmv2LCuNDrIsDRQ8ElZCIow6M/SCx6VmF6vNmwUVKGXQLONANgMtAAgzLdMyGsVlUbgkzqnPH4YGuUcl1mpS/MiX7hVunDa+ihCsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+TJQiGU; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so4114624a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761543560; x=1762148360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGtjzD1BeaBjDHddgtdZ9WU8el5Ygry6H8PZ/jMJrRs=;
        b=Z+TJQiGUIBr8NxgwAtm8f4WI/aheE2iCoZ4DvWg7SIOJy3Um8nsJtKwESROFjrZ2RM
         NAVtCTqE/Wyc/TnVrYuLYACC3wX5YkNlmHhw3mp74ao6C1rlQSTt5ul23ci8dliLAF0A
         FgVlxDHeRNC/juDMceFcgQLMY/gGpb7EO5S7R6KF0ULrZC2skaJHEHI/NQcWby0oeFiw
         wkEjmybT68s7E7QulpyMbBrZi8+GrYVGXx6vdeQ8oIiH5KCc7lIqJp6BkFScEYwLZXhp
         4mBMNlj/nel1qibhAFN+6N5c3/9xDILDr6UmRy+MCWvtHlmTrU69KVGQUFpR6Yw10lf8
         zcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761543560; x=1762148360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGtjzD1BeaBjDHddgtdZ9WU8el5Ygry6H8PZ/jMJrRs=;
        b=SwykfG7VMdmuZvY/LRpbBYng0z//xmthmnVMC4Vm0t7IEt5bRb4jmNH+IXQ6TCMtqE
         QZMLtcBawTBthizeOcl8RwupRB5IMYYjNv8KfyBRDEt5p7wdMAYHm6q0yD/MOPuHAmfi
         TYoGqyp+zVZkRkch6/GQBhq7yjzX7z+0wQGY6D0BjBILVpXl8RpXkUlKA1X5WpyznymW
         V6OxsCxCKCdE5pRgvLDKDUB0dY4mQbiPfn3h5pM7prqgMK/5n1Kqtpi5w5t6PV0MJ7uL
         m2GQQfcu34IbrFhFdl+uhqcryybnZEX/urF7+6z6e6XQOP8FljNeLb0Ql8v4gtDEZg+Q
         /6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWG7CIp7/xYnMKi5XDx0aHMrOfw+spsJrvtQBxXZg7kq7o2XzbmOrggCQl+kdQWTf7C+Ogv2NdV7OEeWrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZ81Wsuugf0zMSHMVt8ekFXhEAJmTaKXRhBz+32QywqtDMbFa
	nalyiSRdtwJ8Vpb9o+jGOhBxKPfSqU4tz7+UUhquQ2oRFXjmdm9XOBmdQGGJcePn+FEPH/NAwGQ
	DRaIqH/pqfJ4VrBWImANFm+JQS7ooUQM=
X-Gm-Gg: ASbGnct9j+h26QJ+rBhUNCpx1blx0FK2AfbB4dWzvdnMSqqCDAaPSSTaO5W46c1v65p
	iZ280Lml0Y51Y4aXvydCARMC2N63RtLbZgv09GR9osnphbPHW4Q8CykYHl479A7OMxriWU1/StN
	AO6/XuNMKUKolQ8Q4RtTg9S6/+PfYYY/8i5iCT2KFFMTxH4pTe4VCWoBCJWRzyGrf78U3VUcIsf
	/AM5hevMe9h6GqMJFQsEVvU2Tm2ViOVx+aavRcebrT4tao3cPQyZRAdQRcj
X-Google-Smtp-Source: AGHT+IG5Sf9tB2N+w1t0iXdjYTK5KXV5g3IANtwtYYJO6ljlk9IRhJTfDvRLeuH3axMGpYEhZU1jh4opBb4+H/Jk7Js=
X-Received: by 2002:a17:90b:3d0d:b0:334:e020:2f16 with SMTP id
 98e67ed59e1d1-33fafbab2b3mr18325423a91.11.1761543560049; Sun, 26 Oct 2025
 22:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024135716.584265-1-maarten@zanders.be>
In-Reply-To: <20251024135716.584265-1-maarten@zanders.be>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 27 Oct 2025 13:39:07 +0800
X-Gm-Features: AWmQ_bkivSeLBDrdFcjjCqIEzy1egjp-oNFnxwaFGOsZDh-2ho7GB46pKzHMgAQ
Message-ID: <CAA+D8ANhErMaJWAOvjMWc=2xq+bsYBJ5eLeN+jg8B4=K+aQsnQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix sync error in consumer mode
To: Maarten Zanders <maarten@zanders.be>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Zidan Wang <zidan.wang@freescale.com>, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:58=E2=80=AFPM Maarten Zanders <maarten@zanders.be=
> wrote:
>
> When configured for default synchronisation (Rx syncs to Tx) and the
> SAI operates in consumer mode (clocks provided externally to Tx), a
> synchronisation error occurs on Tx on the first attempt after device
> initialisation when the playback stream is started while a capture
> stream is already active. This results in channel shift/swap on the
> playback stream.
> Subsequent streams (ie after that first failing one) always work
> correctly, no matter the order, with or without the other stream active.
>
> This issue was observed (and fix tested) on an i.MX6UL board connected
> to an ADAU1761 codec, where the codec provides both frame and bit clock
> (connected to TX pins).
>
> To fix this, always initialize the 'other' xCR4 and xCR5 registers when
> we're starting a stream which is synced to the opposite one, irregardless
> of the producer/consumer status.
>
> Fixes: 51659ca069ce ("ASoC: fsl-sai: set xCR4/xCR5/xMR for SAI master mod=
e")
>
> Signed-off-by: Maarten Zanders <maarten@zanders.be>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu wang
> ---
>  sound/soc/fsl/fsl_sai.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 757e7868e322..178a6e8fbe2c 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -653,12 +653,12 @@ static int fsl_sai_hw_params(struct snd_pcm_substre=
am *substream,
>                 val_cr4 |=3D FSL_SAI_CR4_CHMOD;
>
>         /*
> -        * For SAI provider mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(=
Tx) will
> -        * generate bclk and frame clock for Tx(Rx), we should set RCR4(T=
CR4),
> -        * RCR5(TCR5) for playback(capture), or there will be sync error.
> +        * When Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will provide bclk a=
nd
> +        * frame clock for Tx(Rx). We should set RCR4(TCR4), RCR5(TCR5)
> +        * for playback(capture), or there will be sync error.
>          */
>
> -       if (!sai->is_consumer_mode[tx] && fsl_sai_dir_is_synced(sai, adir=
)) {
> +       if (fsl_sai_dir_is_synced(sai, adir)) {
>                 regmap_update_bits(sai->regmap, FSL_SAI_xCR4(!tx, ofs),
>                                    FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FR=
SZ_MASK |
>                                    FSL_SAI_CR4_CHMOD_MASK,
> --
> 2.51.0
>

