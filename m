Return-Path: <linux-kernel+bounces-867933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB59C03F61
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AC234E70F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264FE78C9C;
	Fri, 24 Oct 2025 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe6AISXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687962F5B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266142; cv=none; b=YPY75ZiWLGDacPmIyOSbcqgggY4qjFosy8+oUqcl05/kM8pMA6SBQGl/rujnBvnbK+ozrlKgsy2kFzOSoUGL4qX4fHPOWj/ICorOSRntPrSgZt55GUUEa+lbZoyuSSL7RK6vmxQhAj/7y662heOaE0OO621boIYReG90nNy4o4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266142; c=relaxed/simple;
	bh=PTncCyO74ELUzyL0VC+KcHhY+qg3bMKHZCe+2nsn7iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBFX+uwZaMHjU3jT1/Ood8En4nFQTLNW4pgb40/0d9Ct8OLf8tO9+YNzebX6Q+ziKed9VgfpG4dmSsY8gzBDoGT2GEZ988DXhnmOnvSvJCCFUcepkgHQLt6uzN0QSyNtTSJ4J3z8jST8uA8iUC9dn12PytJH25+f55pnuSGiBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe6AISXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED491C116C6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761266142;
	bh=PTncCyO74ELUzyL0VC+KcHhY+qg3bMKHZCe+2nsn7iQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qe6AISXAncGjND3Hg5i5xoFA245mb6Df8yHAuR7NgV7cFutjfq2sjnyQesy6O0rnM
	 aXMIBo69Grpm3rHiIN1cYNpP0fhXf9n5l/GOYz43WAtUZANiaS49ZgqIA4ll72zaWU
	 LJCpVlHiyggI0G+HANBmd3AWBkQnv/mmoVvkc22lXXsMKWS4IbrnFHgwCLKG1p9pKk
	 jpNSRvkNeEHFvKhOOv4bAa7X45VgkAXmZzElB90MkCQa1t35yCldHG4jZkJ6GVDgKd
	 xgX9FkppKc4Eds+0Th89WLeRZD4rpnqR7q/wL8WqCx9dGDi5dxPrzM3vrQ1FnSYuAt
	 +MJNJZRsIngbQ==
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso1034189a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:35:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUg/ILs+jc5UjM9UFrJ1W5d/5QtsC5/3BmE+LfTXhq29DznjvzxfE7l9j7VaKHNn33R2szS2Eh3N/KXlw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlpdYNZV5sJEXNyMkUWLIatS3N+V9svdo46X+eVxfXfRH1aY8
	yjzY0vW9t1yTe9fCZtK7H1TPxzM846+p7sUYrn1lbcqrfcbUPdkAR+8zLogLlL00Ve1q1HBCbPD
	r2jpfcFfEr3OWkgiPZnG9HFbZ4pg1GA==
X-Google-Smtp-Source: AGHT+IGOMKLHi0CZOHqSh5IjaE+DgAa5Vkrkmi7gYN42ujUfgl+FvecwlSbnjr8WAwwoIN6a4Crw3ctvyAP+BawLEjM=
X-Received: by 2002:a17:902:f712:b0:26b:3cb5:a906 with SMTP id
 d9443c01a7336-29489e109b9mr8169415ad.16.1761266141410; Thu, 23 Oct 2025
 17:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-mediatek-drm-hdmi-v2-v11-0-7873ec4a1edf@collabora.com>
 <20251023-mediatek-drm-hdmi-v2-v11-5-7873ec4a1edf@collabora.com>
 <CAAOTY_8y6C5=jSjzBVVJ2vJq1L+Nf9U0tZvxzVX-e-3g91xEeQ@mail.gmail.com> <a55c9480da785a8618dd60c3f3e0ddc398c5d45f.camel@collabora.com>
In-Reply-To: <a55c9480da785a8618dd60c3f3e0ddc398c5d45f.camel@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 24 Oct 2025 00:35:29 +0000
X-Gmail-Original-Message-ID: <CAAOTY_-f89vzGXzb_xRgpmx050tVM2+Ud6afR5iNycTROSmcYw@mail.gmail.com>
X-Gm-Features: AS18NWCs-ZOjPVHuitqceUJYqSJStFRyUNsop7HMJ8Io7hasX41agsqyg9N4J9c
Message-ID: <CAAOTY_-f89vzGXzb_xRgpmx050tVM2+Ud6afR5iNycTROSmcYw@mail.gmail.com>
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

Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> =E6=96=BC 2025=E5=B9=
=B410=E6=9C=8823=E6=97=A5
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Thu, 2025-10-23 at 15:59 +0000, Chun-Kuang Hu wrote:
> > Hi, Louis:
> >
> > Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> =E6=96=BC 2025=
=E5=B9=B410=E6=9C=8823=E6=97=A5
> > =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:32=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > From: AngeloGioacchino Del Regno
> > > <angelogioacchino.delregno@collabora.com>
> > >
> > > In preparation for adding a new driver for HDMIv2, for which CEC
> > > is not strictly required, change the of_get_compatible_child()
> > > failure error to -ENOTSUPP to be able to differentiate between
> > > error conditions in mtk_hdmi_dt_parse_pdata().
> > >
> > > In that case, if -ENOTSUPP is returned, this driver will print
> > > an informative message saying that CEC support is unavailable,
> > > as the devicetree node for that was not found, but after that,
> > > function mtk_hdmi_dt_parse_pdata() will not return error to
> > > the caller.
> > >
> > > This will not change functionality of the mtk_hdmi (v1) driver
> > > as that is still checking whether CEC is present and, if not,
> > > will fail probing with an error saying that CEC is required
> > > by HDMIv1.
> > >
> > > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > > Signed-off-by: AngeloGioacchino Del Regno
> > > <angelogioacchino.delregno@collabora.com>
> > > Signed-off-by: Louis-Alexis Eyraud
> > > <louisalexis.eyraud@collabora.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > > b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > > index
> > > f28e63716d7c2e2c6bdf5b28d24789bc926d2beb..989479fdfe40952762a1b6379
> > > 7bf602b520dcac5 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> > > @@ -253,12 +253,11 @@ static int mtk_hdmi_get_cec_dev(struct
> > > mtk_hdmi *hdmi, struct device *dev, struc
> > >         /* The CEC module handles HDMI hotplug detection */
> > >         cec_np =3D of_get_compatible_child(np->parent,
> > > "mediatek,mt8173-cec");
> > >         if (!cec_np)
> > > -               return dev_err_probe(dev, -EINVAL, "Failed to find
> > > CEC node\n");
> > > +               return dev_err_probe(dev, -ENOTSUPP, "Failed to
> > > find CEC node\n");
> >
> > The checkpatch show the warning:
> >
> > WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> > #40: FILE: drivers/gpu/drm/mediatek/mtk_hdmi_common.c:256:
> > +        return dev_err_probe(dev, -ENOTSUPP, "Failed to find CEC
> > node\n");
> >
> > I find many driver use ENOTSUPP, so I'm not sure which one is better.
> > I really don't understand the description about these two error code
> > [1].
> > If you choose ENOTSUPP, please give me some explain.
> >
> > [1] https://man7.org/linux/man-pages/man3/errno.3.html
> >
> > Regards,
> > Chun-Kuang.
> >
> >
> I think ENOTSUPP can be replaced by EOPNOTSUPP in this patch safely.
>
> There is only a single call of the mtk_hdmi_get_cec_dev function in the
> driver and the code that checks this particular return code value in
> mtk_hdmi_dt_parse_pdata function is also added by this patch.
>
> I also don't see no other occurrence of ENOTSUPP code in mediatek-drm
> and since checkpatch recommends to prefer EOPNOTSUPP over ENOTSUPP,
> let's replace it in this patch (both code and commit message).
>
> Do you want me to send a new version of the series for this change?

It's not necessary to send a new version of this series.
I would modify this patch when I apply it.

Regards,
Chun-Kuang.

>
> Regards,
> Louis-Alexis
>
> > >         cec_pdev =3D of_find_device_by_node(cec_np);
> > >         if (!cec_pdev) {
> > > -               dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
> > > -                       cec_np);
> > > +               dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
> > > cec_np);
> > >                 of_node_put(cec_np);
> > >                 return -EPROBE_DEFER;
> > >         }
> > > @@ -319,7 +318,9 @@ static int mtk_hdmi_dt_parse_pdata(struct
> > > mtk_hdmi *hdmi, struct platform_device
> > >                 return dev_err_probe(dev, -EINVAL, "Failed to get
> > > ddc i2c adapter by node\n");
> > >
> > >         ret =3D mtk_hdmi_get_cec_dev(hdmi, dev, np);
> > > -       if (ret)
> > > +       if (ret =3D=3D -ENOTSUPP)
> > > +               dev_info(dev, "CEC support unavailable: node not
> > > found\n");
> > > +       else if (ret)
> > >                 return ret;
> > >
> > >         return 0;
> > >
> > > --
> > > 2.51.0
> > >

