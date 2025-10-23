Return-Path: <linux-kernel+bounces-867328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DEC02461
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACAEB4E9C96
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4B8257824;
	Thu, 23 Oct 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqm9YOj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1112566FC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235170; cv=none; b=K411fSc11yPSzpR3rF9Ag6DGgmPUWWe4BoQl3bANcNwU/8lH2K4OGFAyCzDLbDxg+vJPcMMhrwP+QBhjUYWF+L3uy5Bc0kKO+YJyZZOuDw283f4Xd7g0mjzflmrv8v6l8XVegM7g8KSzs7q/pyjy2r5Zqq6ESkn92xWNRETFqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235170; c=relaxed/simple;
	bh=HNETIspV1pbV0Y7043vMBsmXaAMmB/3oT01AgEruh5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyAXs7oy5GNCtgKV+jqffeJqCAqb+QH4CKGSOJC7WreFGstG4Z4hPn1WjIbkbWl7JYejx6/7n3dupXQhcWwWOIbmBGOJ9NS99zBNvbd2YPOIW1JB6ti3AwlPj+jCSriVAFn3e8wnTzlGewwLSEhuh1RYTCNBpyMJjZxJ3sax79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqm9YOj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E9CC4CEFF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235170;
	bh=HNETIspV1pbV0Y7043vMBsmXaAMmB/3oT01AgEruh5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iqm9YOj1nwjHauObiKeCKcztOyM7IDzlzvu7DqnfXoWrCbXW8LFQnOaNQwQXRS/vD
	 G93NwnP0QcDAlRnItO34nCtCUky9f5sS8uIW06ELuZh/XCOzOm/HDb1MBsqjFSD1aj
	 tUZsK+U0FhYJA2963vqqMBLycJQx6Y+A1Y7m8Cofj4McSrdU2ytBtGI7MC1J4jK3Hd
	 mzx3D0bfz4oapjweIXnuUQKhb+BuvvR15B9uAYCoh6UoLCFVSpT8LzYnGRU9LK32iA
	 J29QaMXqAP0qOIIA3RnPHS0tkvekxr7aTAvoWDw3Tmz2gp6M+QxSYKuCqRcd71pATw
	 TSezQ+JvIMjNw==
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2897522a1dfso10019885ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:59:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm0bL9E3BBLcvPDAncHPMFKQv+MBgIfcwRZzzLEZStmZSvoLCAch+O85H/KYkaSjulp07TzzUZF54iWhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrloEO/eyit7hvr6EVv+nTQGjmlGx8niItEHGkZRIPtNbWXXC
	JxRBWDZjjbIqSgVFMgnhbKDhTlHVB3YRvxW3botCSDjsBzc7FiZmFiuq53QxJvQ6p14nvTcoruA
	6sWcSc++roTaTlLzHYMFwuf7ONNrRSg==
X-Google-Smtp-Source: AGHT+IECkDSLnMI58q2z6cfhGJynJyGmcN+cdUTnJb3cy4ZottyIHIlB5uHCXuVcpJ10ENJOaHc75BD0rCg14pUbOyU=
X-Received: by 2002:a17:902:d48b:b0:269:a2bc:799f with SMTP id
 d9443c01a7336-2946e0ebfe2mr35532765ad.29.1761235169689; Thu, 23 Oct 2025
 08:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-mediatek-drm-hdmi-v2-v11-0-7873ec4a1edf@collabora.com> <20251023-mediatek-drm-hdmi-v2-v11-5-7873ec4a1edf@collabora.com>
In-Reply-To: <20251023-mediatek-drm-hdmi-v2-v11-5-7873ec4a1edf@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 23 Oct 2025 15:59:17 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8y6C5=jSjzBVVJ2vJq1L+Nf9U0tZvxzVX-e-3g91xEeQ@mail.gmail.com>
X-Gm-Features: AS18NWBPNnpQTLl2v2M-LiIiRpHYJ2lBBGYEU56O8zLVvGRR7Usps46KfOInouI
Message-ID: <CAAOTY_8y6C5=jSjzBVVJ2vJq1L+Nf9U0tZvxzVX-e-3g91xEeQ@mail.gmail.com>
Subject: Re: [PATCH v11 05/11] drm/mediatek: mtk_hdmi_common: Make CEC support optional
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Louis:

Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> =E6=96=BC 2025=E5=B9=
=B410=E6=9C=8823=E6=97=A5
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com=
>
>
> In preparation for adding a new driver for HDMIv2, for which CEC
> is not strictly required, change the of_get_compatible_child()
> failure error to -ENOTSUPP to be able to differentiate between
> error conditions in mtk_hdmi_dt_parse_pdata().
>
> In that case, if -ENOTSUPP is returned, this driver will print
> an informative message saying that CEC support is unavailable,
> as the devicetree node for that was not found, but after that,
> function mtk_hdmi_dt_parse_pdata() will not return error to
> the caller.
>
> This will not change functionality of the mtk_hdmi (v1) driver
> as that is still checking whether CEC is present and, if not,
> will fail probing with an error saying that CEC is required
> by HDMIv1.
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm=
/mediatek/mtk_hdmi_common.c
> index f28e63716d7c2e2c6bdf5b28d24789bc926d2beb..989479fdfe40952762a1b6379=
7bf602b520dcac5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> @@ -253,12 +253,11 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hd=
mi, struct device *dev, struc
>         /* The CEC module handles HDMI hotplug detection */
>         cec_np =3D of_get_compatible_child(np->parent, "mediatek,mt8173-c=
ec");
>         if (!cec_np)
> -               return dev_err_probe(dev, -EINVAL, "Failed to find CEC no=
de\n");
> +               return dev_err_probe(dev, -ENOTSUPP, "Failed to find CEC =
node\n");

The checkpatch show the warning:

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#40: FILE: drivers/gpu/drm/mediatek/mtk_hdmi_common.c:256:
+        return dev_err_probe(dev, -ENOTSUPP, "Failed to find CEC node\n");

I find many driver use ENOTSUPP, so I'm not sure which one is better.
I really don't understand the description about these two error code [1].
If you choose ENOTSUPP, please give me some explain.

[1] https://man7.org/linux/man-pages/man3/errno.3.html

Regards,
Chun-Kuang.

>
>         cec_pdev =3D of_find_device_by_node(cec_np);
>         if (!cec_pdev) {
> -               dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
> -                       cec_np);
> +               dev_err(hdmi->dev, "Waiting for CEC device %pOF\n", cec_n=
p);
>                 of_node_put(cec_np);
>                 return -EPROBE_DEFER;
>         }
> @@ -319,7 +318,9 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *h=
dmi, struct platform_device
>                 return dev_err_probe(dev, -EINVAL, "Failed to get ddc i2c=
 adapter by node\n");
>
>         ret =3D mtk_hdmi_get_cec_dev(hdmi, dev, np);
> -       if (ret)
> +       if (ret =3D=3D -ENOTSUPP)
> +               dev_info(dev, "CEC support unavailable: node not found\n"=
);
> +       else if (ret)
>                 return ret;
>
>         return 0;
>
> --
> 2.51.0
>

