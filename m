Return-Path: <linux-kernel+bounces-867995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0AC041AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A195A357437
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D039C1DD525;
	Fri, 24 Oct 2025 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGhzKjfe"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643518A6A7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272164; cv=none; b=jIHahZZ7C1DDxTZ2Owqw0pOM1PfG3SVWTIT06Tjgcys/cwcdokORq3IyaOyT6EbE5hhsU8bwsUvt7EtXWNDSeZ4wzwiglPe51hZCob8qrHj30GXlWiMJiBQqPpU4qoEVVj9dz/UXAAgLBsRDfc3IwIAqdfnJDPiZ4Db9RskmqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272164; c=relaxed/simple;
	bh=715hOslgu7y016qxUdrtVMFM0PPhVFT1NOgcdmQqdD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYWn4ciibVz6erT4BqGgfewx3d2zHIwk6f2AL4OD49HP3SLaibmD6guBx6eCqu7twbmHsPRqygtr7WJhqvOnWIPAvW5uVrR0kdZIk1RIzeEhoC1ozmTTkexoNwThZzg4oLHdH9gxof1r6ccpt84eazaLSuEKiMTi/LK3xardeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGhzKjfe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1616146a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761272161; x=1761876961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI0Vwi2MFtORL9n5J5tJUkBs2QczZqahhbzv7dm+XZ4=;
        b=SGhzKjfeycASiQAcOTlEgFu6zLhc0xjJuaaYWbaK7tqCA1oA6CyK/Cq6xBkxjPHA+X
         LPRApMyD4zu7LhqAOtGYDipgnpxgHOW4s3z468OeIBnp3oXIoyi0zMZSq8v+j2gLDAPY
         pjM2+r8bbjINWvRwxMgfBJM1Z44XkrNk9PEXQSgB9k8gYxiOSWg/UJ8PcfvcNm8ke9Rd
         Z5Ed1NOlVmWHmGzMf1HRjnJ/26iskOKxGXVeRJs58AgPhEQwhpnUfVTfIbr1udX9MjCR
         P3YE/vaZ++t8StTQlmMaRnMUlUgaa6TmeFXWSzTcFHEIaiWdwyZ4uEU0xRs2x8JZHaQd
         u+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761272161; x=1761876961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI0Vwi2MFtORL9n5J5tJUkBs2QczZqahhbzv7dm+XZ4=;
        b=uwWgziCWXfWqlNc5GwSnJPrtk32TYmjBvxznIrXmkC90hclD6kvbe+uEoCF+haqQLV
         Y/z+PkoVhPxmwfWjNO547eIs7KHdUGUX7S5muP7Xdwt80XGGvMVkUCVTdEzwpgS7LUQM
         vHPSjaRVHEOqXn0ApIacSKQWl6/57ytEW3Xxm1oSaiGXYmaUMzDh2s/dospK390jW1sH
         PcfEmKHLPBmr2n8h3JLqFviDDpmPHgOEgjKwbdBSLe2X3nwf4x0ULH9NrAkKjuE1UwJ4
         xq8zor1CXWKYpHL4r2wiLFbt6FHJpL84xsvk55dPZivOd3DtReHlbgzhjJxRX9j3OiYU
         +cbA==
X-Forwarded-Encrypted: i=1; AJvYcCXNrYUiSFEyfvxYrDDMHYbYCbGQOVfJVqCOJbOEJK4vBHOcw27Y3n5S8jswC6TLsrSZKPSff+knKU9U3PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVkBH+B7TCQR16aTdV/F2N99uIM/cmR07HITXi60JeVhnGR7r
	HBvJ+OVrPqhP9ZnnJPq9rEIgpNqvwZbLIp/unQhal4BFtZuq4103nMT3nOjk4Oz/l5j5dWHcarO
	Tm21nfzIPmfaDNE5F8XhAgCImGJ0JS05ocnve
X-Gm-Gg: ASbGnctBxAf2EXEoHFQF5YqqmEIPDTJnLbKLJFKCRR4yf3tYOrdL67DEFpRJHh0rxi4
	A761jPhfXhNJi53BVW/mRBvkdc4WlE4QaldxLvMHqWw5GlVvmh7q8LDawQyDcAF003Fc67SMtG0
	CoK/7LEKmkPh0BBNRmufwZLKE+oykyaD80SUMI/TEYQY7urpfeR/nQuAoGL+x3BvZGIewXZdKAD
	xKQp7zNqS7wRBpPDCEynuSfSTSCAqcHqiXmoLUdxNmk7WWJ6NO1b4TqgqZc/UjJraLLk6o=
X-Google-Smtp-Source: AGHT+IElNfoS47SY7t+lKBFv7+5KrhLxG98q130ySpWKzXc0GkoN0tmuT6t9nFhyiYXpfSO3SfnNJSOMNthXNwS/NDA=
X-Received: by 2002:a17:90b:1b50:b0:33b:d371:1131 with SMTP id
 98e67ed59e1d1-33fd66f565amr743481a91.34.1761272160901; Thu, 23 Oct 2025
 19:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-auxiliary-v2-1-a353dc9e6b1a@nxp.com>
In-Reply-To: <20251024-auxiliary-v2-1-a353dc9e6b1a@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 24 Oct 2025 10:15:49 +0800
X-Gm-Features: AS18NWDZ9oaK7UwbUVQe-rbcE0CXdttwjA1LC6T8fVyGVAC_wDzugHZZMraTOl0
Message-ID: <CAA+D8AOF+3he6nV6yDRnept2Epo1yTZgJnn+P4H8hkktec5wEw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx: imx8mp-audiomix: use devm_auxiliary_device_create()
 to simple code
To: Peng Fan <peng.fan@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 9:46=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> Use helper function devm_auxiliary_device_create() to remove some
> boilerplate code.
>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu wang
> ---
> Changes in v2:
> - Update commit log per Frank
> - Add R-b from Frank and Abel
> - Link to v1: https://lore.kernel.org/r/20251023-auxiliary-v1-1-0a16fa4c3=
cdd@nxp.com
> ---
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 39 ++++-------------------------=
------
>  1 file changed, 4 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-=
imx8mp-audiomix.c
> index 775f62dddb11d8cfd17a4ebf7a677ef399c5e617..131702f2c9ecfd693af47094f=
e61b486ae6e8f6d 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -230,50 +230,19 @@ struct clk_imx8mp_audiomix_priv {
>
>  #if IS_ENABLED(CONFIG_RESET_CONTROLLER)
>
> -static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
> -{
> -       struct auxiliary_device *adev =3D _adev;
> -
> -       auxiliary_device_delete(adev);
> -       auxiliary_device_uninit(adev);
> -}
> -
> -static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
> -{
> -       struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> -
> -       kfree(adev);
> -}
> -
>  static int clk_imx8mp_audiomix_reset_controller_register(struct device *=
dev,
>                                                          struct clk_imx8m=
p_audiomix_priv *priv)
>  {
> -       struct auxiliary_device *adev __free(kfree) =3D NULL;
> -       int ret;
> +       struct auxiliary_device *adev;
>
>         if (!of_property_present(dev->of_node, "#reset-cells"))
>                 return 0;
>
> -       adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> +       adev =3D devm_auxiliary_device_create(dev, "reset", NULL);
>         if (!adev)
> -               return -ENOMEM;
> -
> -       adev->name =3D "reset";
> -       adev->dev.parent =3D dev;
> -       adev->dev.release =3D clk_imx8mp_audiomix_reset_adev_release;
> -
> -       ret =3D auxiliary_device_init(adev);
> -       if (ret)
> -               return ret;
> +               return -ENODEV;
>
> -       ret =3D auxiliary_device_add(adev);
> -       if (ret) {
> -               auxiliary_device_uninit(adev);
> -               return ret;
> -       }
> -
> -       return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_un=
register_adev,
> -                                       no_free_ptr(adev));
> +       return 0;
>  }
>
>  #else /* !CONFIG_RESET_CONTROLLER */
>
> ---
> base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
> change-id: 20251023-auxiliary-3998bced9cb9
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>
>

