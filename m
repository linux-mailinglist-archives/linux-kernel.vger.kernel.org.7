Return-Path: <linux-kernel+bounces-777495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153B4B2DA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E415D17DC97
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530CC2E2DFA;
	Wed, 20 Aug 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TI2qX7Er"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AB2E2DC2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686256; cv=none; b=UHvSaOT7A/k+evrvob3B7Z3Ifdi3LaHFfJ8TA68HBRwSbIt67CS1y5H+7COpjFF7qL++0+e2SJgsdMZ8+qXgExJms7ZJG3alVdSFq7X8dZWje7K1bpXhy4/F/0QE5Fe2EIlo0F+FWC3CPs0R5SNZC2KUX17pGMQ7WAreHUFcoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686256; c=relaxed/simple;
	bh=OFo08HW/KntH/I83D/UysFYPhvG9LOa+MqmK//stgcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+BeRA8YYnFf6EpNNAHkbIkFSeNGMk5WuN1OeJ+suqFZUXtbo2rv3pZQykPYwDSsILA4bZF+o65wNDxRjXlsh6MTqH3sKnZ1Ia++lzqUzkM9lhcezsButhLTcHZwdVSDnjXT4kDf2y3Q6TkdS2MLTBWBlhtI+FAcy6rAN/3+szg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TI2qX7Er; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53b1754a419so4406476e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755686253; x=1756291053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGbsuPE+0ODe6PuJ1PHV7gxJ5+99ZGIndY0/S7JkxJw=;
        b=TI2qX7ErOX6/ux8LjBozZEpW8ZIq7CT0tV05bBWakADb+/EJwy3mdWqqTpoxmp/rsm
         xtNmWK6C5EI3lQSdCWJnHJhVNFxO+mG9iknEIC+ySh/TnmRa8v9jXou4Ifbh7QSYfMfb
         C2oboOrN3H/a6vCH0NnUVPwNoy27AS7lDYsww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755686253; x=1756291053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGbsuPE+0ODe6PuJ1PHV7gxJ5+99ZGIndY0/S7JkxJw=;
        b=lDDV1Tmc/JgM42/ov7kkXFtSz6xykwj2i5U3XO3zNwlPz9l5xl0H8L+XSHk6oirC3w
         Bd6WKkho0GA9yRQrfeLL7LWe5BLYMDSuLlP0jhO6Lur76Uh0W4Q8jr8FwBlvB1O2t/wU
         leP4+5QdFAqjL5salrdg6Jw3QwOTMo/Q1i/vjiRWV3IWkN9awpaS+TIzQRrbwSUtlaOn
         IXlhu38qCdSYOYX2RJCI4xuO8D1XPFAcnwd8yy3yvrZy9OTULn2uiCMe/o78Sid6g+9k
         oqYhTas4hisK1XRp8PEJILWqX4tZ6Rz+Xl9osXvVk4CBA/KWVrduil8avm7eSFK62IkA
         S8AA==
X-Forwarded-Encrypted: i=1; AJvYcCXQhIC4IbEFw3JL6/5Nivy0u0jX7hl8SUtlJetDYTQDxdfLfGAzHqQOoHgL0UInilkxz4UXGtT67md+22k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXeY0/GQNfxpHhnbUuryg1WOx1W0dFcJzM85YKms4hLmKG6xY1
	Y8Nlv+t7z9ZQZuIZfwlS19U+JfPbsfHAuuTyd9XJhg8Xqcec+O+SUR4jA229llQ1sLWKnqqXhht
	J+wY=
X-Gm-Gg: ASbGncuif0XE2tGVOdib0nR7R5xL+lB/wBuSfnnWdVgW2gSxF2QxCvINHGmjzgnhXPz
	aZDBIozup2vKR1QtI1Cv/8TIzKa3h74pS53VKMaqzuU384eSuuxNlYFy45wrGyzKrxJLydS84yY
	FkC0UyfFQRLAUkQjaOk4VoNxxNNHjMGfcO8rx9f8lRke5qqTseG+jSBGUJjRVG/8YqbJ58Dvye9
	s3ff0/HHummh+8Qbj1WEhy+UtvLepmLqAzelGK/5hdm7UA+TW3GCusefmwIui71jdCwe3YINJ51
	DDTqaIhj9C7lFpn7ndKpsFRLiRI3Suh788CJfyRLJ2onnahmO3ZQm/ZeLHroZ96lkeA3psUfF18
	H88bpwdRBK251HUVTUt+tWeOTiGM3m6Vs/wHFGHMfIbKJkajI3U3bAJR7sg==
X-Google-Smtp-Source: AGHT+IGp7p4vNBpH+9dI4zpp0KvkOxjwL6/0BFjWSBkcjKM3oLuDrt2Al3XZf0ZKRNTwdDtfMhbPUg==
X-Received: by 2002:a05:6122:181e:b0:539:1dd2:22fa with SMTP id 71dfb90a1353d-53c6d50c14emr742139e0c.1.1755686253197;
        Wed, 20 Aug 2025 03:37:33 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bed9fd5sm3065007e0c.18.2025.08.20.03.37.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 03:37:32 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-890190b1aabso3759229241.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:37:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX51WhfABARynIZYFXgywzz6EtldKjLLJ5GsgDWTl7ii+YnSBRacFYf1wLua6LWZgOFrR/L/g1GszhWdKg=@vger.kernel.org
X-Received: by 2002:a05:6102:d8a:b0:4ec:c513:f3d with SMTP id
 ada2fe7eead31-51a519bb1b2mr649649137.25.1755686251925; Wed, 20 Aug 2025
 03:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820075405.1041838-1-wenst@chromium.org>
In-Reply-To: <20250820075405.1041838-1-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 20 Aug 2025 18:36:55 +0800
X-Gmail-Original-Message-ID: <CAC=S1njQ5z2Ezz2OXDJ6Pk_9EEPgG3gu=Os7uFv6Lmdq0X77og@mail.gmail.com>
X-Gm-Features: Ac12FXxxuLvE-_OGknatHaznIwKXRs2-9K8o-wweiJyigK7q1-hAihk8TkEg5BU
Message-ID: <CAC=S1njQ5z2Ezz2OXDJ6Pk_9EEPgG3gu=Os7uFv6Lmdq0X77og@mail.gmail.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Use spinlock for context list
 protection lock
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 3:54=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Previously a mutex was added to protect the encoder and decoder context
> lists from unexpected changes originating from the SCP IP block, causing
> the context pointer to go invalid, resulting in a NULL pointer
> dereference in the IPI handler.
>
> Turns out on the MT8173, the VPU IPI handler is called from hard IRQ
> context. This causes a big warning from the scheduler. This was first
> reported downstream on the ChromeOS kernels, but is also reproducible
> on mainline using Fluster with the FFmpeg v4l2m2m decoders. Even though
> the actual capture format is not supported, the affected code paths
> are triggered.
>
> Since this lock just protects the context list and operations on it are
> very fast, it should be OK to switch to a spinlock.
>
> Fixes: 6467cda18c9f ("media: mediatek: vcodec: adding lock to protect dec=
oder context list")
> Fixes: afaaf3a0f647 ("media: mediatek: vcodec: adding lock to protect enc=
oder context list")
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Switched to _irqsave / _irqrestore variants even in helper only called
>   by IRQ handler (Tomasz)
>
>  .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c       | 10 ++++++----
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c     | 12 +++++++-----
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  2 +-
>  .../platform/mediatek/vcodec/decoder/vdec_vpu_if.c   |  5 +++--
>  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c     | 12 +++++++-----
>  .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h     |  2 +-
>  .../platform/mediatek/vcodec/encoder/venc_vpu_if.c   |  5 +++--
>  7 files changed, 28 insertions(+), 20 deletions(-)

Reviewed-by: Fei Shao <fshao@chromium.org>

