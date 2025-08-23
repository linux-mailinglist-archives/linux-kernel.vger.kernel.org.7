Return-Path: <linux-kernel+bounces-783122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BEB3299C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6450F9E4D58
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66092E763D;
	Sat, 23 Aug 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFWJB8rU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D413AD4B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963252; cv=none; b=IZkZppa6eQScHnmlT+mBOk9hnNM3nw7yQXfsn390BiDG5RREZFyO7tCEP1inc7Udp7iY4QQvM2mPWgAqf2WMsZZFvA+dxjH1KrZQU2ZLLeinlnQtr+Y8UNK93MJZ0qUVds7YhquNeXC3dZzsjH4Py49eDEWzQjkNYTauVLPk6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963252; c=relaxed/simple;
	bh=kTALLSkXGcreCjIk5ouErmIww5GXzdh4sJZ7jSXzRQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvCiZUHE7SItY2QS1jBM3vs5DVguOmQefvnziztcVZ72KHohlM7z0p3xGMkgtd4bTx7Ib2jvsp/wmHypiemtuHn+3R3tafBZvn1nfpW6yosljGJMIQ258PSyEmMCw59iRJbaPEXTcSPozFRv7WtDjc5c/q4GEo5grdJRmr2W7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFWJB8rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895AAC19421
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755963250;
	bh=kTALLSkXGcreCjIk5ouErmIww5GXzdh4sJZ7jSXzRQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fFWJB8rUZTR7k1mJNnrOp0U9u6ycN8+Jk8coMcewCtLpogIycNkCI8WXsKET7qRB3
	 pltxGuwxlWfyUyFzOT0Y6UANrSTTY7h+e7Tt0uYdoSK+vN5376+mmga3ro7rt8AcKd
	 xQeJ4b0D11X7cokEVT6D+Z06sQ8efpan8xGj9KS3eAJDbUK1HzkS7xhEKduqugylqf
	 1arOlaqD4Uxogfzbl2IJUvMpwbuKakn+ZvTkXngEoExybeS67OA8uzF4u11pZkOjbu
	 gabqZmJULI6gjywr73jsXKqhTv55m20yYbXP/ZS7VRp5XfoQGy+1vh8OUMFiyHFlSG
	 plEWMicPJ/Srg==
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso2615830b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:34:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW052QCagwEL7Zl7iY8noi1cn3jWuXKGHknbTiU4ZaSqDLFaBscE4yM+OphKkBf4dyKiDTL4+FrEi3UYWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNC3wD+aiBQtZb896kybdfO+I43ETTgY1jx7oyFNojPI9483sG
	Lutpvl3ZWZsiT9LxwfdRyioY7i0PkeKGexr0q8RqWzHWhkAf2fLPfiFNtfp3EQMe3bst5lwt52/
	mtajmkEAyQ+kqx7u2W+FQH/BnR2fpmg==
X-Google-Smtp-Source: AGHT+IH4plAM5KbETmxDDjvC+xXEie7PQ9eZg3ukysPt7y/ninQ9lLmP959MYy/IC7jqNGnL7Y1cqkNrWOy3mIJtmoY=
X-Received: by 2002:a17:903:2012:b0:240:2145:e51d with SMTP id
 d9443c01a7336-2462ef440e3mr63417535ad.31.1755963250030; Sat, 23 Aug 2025
 08:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-mt8173-fix-hdmi-issue-v1-1-55aff9b0295d@collabora.com>
In-Reply-To: <20250818-mt8173-fix-hdmi-issue-v1-1-55aff9b0295d@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sat, 23 Aug 2025 23:35:19 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9mS+VRu9T45xawO-jdT0Zk+JR3XMbj7So3LuiUfO8_0w@mail.gmail.com>
X-Gm-Features: Ac12FXw07uZw-AZ_HWLRa8XVVMEzzj7o_IkjPil9tjxcN8KsqqRfui-EkO3JR-w
Message-ID: <CAAOTY_9mS+VRu9T45xawO-jdT0Zk+JR3XMbj7So3LuiUfO8_0w@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi: fix inverted parameters in some
 regmap_update_bits calls
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	Guillaume Ranquet <granquet@baylibre.com>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Louis:

Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> =E6=96=BC 2025=E5=B9=
=B48=E6=9C=8818=E6=97=A5 =E9=80=B1=E4=B8=80
=E4=B8=8B=E5=8D=8810:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In mtk_hdmi driver, a recent change replaced custom register access
> function calls by regmap ones, but two replacements by regmap_update_bits
> were done incorrectly, because original offset and mask parameters were
> inverted, so fix them.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: d6e25b3590a0 ("drm/mediatek: hdmi: Use regmap instead of iomem for=
 main registers")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 845fd8aa43c3c91659808d9e6bb78758d1f9b857..b766dd5e6c8de6d16bff50972=
b45c3c1a083b985 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -182,8 +182,8 @@ static inline struct mtk_hdmi *hdmi_ctx_from_bridge(s=
truct drm_bridge *b)
>
>  static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
>  {
> -       regmap_update_bits(hdmi->regs, VIDEO_SOURCE_SEL,
> -                          VIDEO_CFG_4, black ? GEN_RGB : NORMAL_PATH);
> +       regmap_update_bits(hdmi->regs, VIDEO_CFG_4,
> +                          VIDEO_SOURCE_SEL, black ? GEN_RGB : NORMAL_PAT=
H);
>  }
>
>  static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool en=
able)
> @@ -310,8 +310,8 @@ static void mtk_hdmi_hw_send_info_frame(struct mtk_hd=
mi *hdmi, u8 *buffer,
>
>  static void mtk_hdmi_hw_send_aud_packet(struct mtk_hdmi *hdmi, bool enab=
le)
>  {
> -       regmap_update_bits(hdmi->regs, AUDIO_PACKET_OFF,
> -                          GRL_SHIFT_R2, enable ? 0 : AUDIO_PACKET_OFF);
> +       regmap_update_bits(hdmi->regs, GRL_SHIFT_R2,
> +                          AUDIO_PACKET_OFF, enable ? 0 : AUDIO_PACKET_OF=
F);
>  }
>
>  static void mtk_hdmi_hw_config_sys(struct mtk_hdmi *hdmi)
>
> ---
> base-commit: afb39542bbf14acf910012eee2d4159add05d384
> change-id: 20250818-mt8173-fix-hdmi-issue-287cf353b077
>
> Best regards,
> --
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>

