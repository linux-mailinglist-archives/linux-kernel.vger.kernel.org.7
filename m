Return-Path: <linux-kernel+bounces-841455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59783BB75C4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97D219C5E55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD182868B2;
	Fri,  3 Oct 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="TSsxDRvA"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3924501A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506293; cv=none; b=M/P1/cJzubNUVHTHIgcPYxojUK552BUbtqN8D/jxaIp51uhdEcqnhr0j2fqLfALb/rShxnEofOGHlAU0Uo2gT8ibBOGkjjRQbPBAMHUNhZSE+viq8nrKXQrIPKF4EqGHrlly5p16ZAyOLLy+4zQ5eFL5BSiat4rZVa+Z+BqLAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506293; c=relaxed/simple;
	bh=Zb7fyuiXcHrGNivhEDyxDjANeqiLLU7pVIdpqSK1jd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hGF5AY1yzgi33bvFzubYo9w8rqpm8qSfJkJivv5E9GN3qSEp+7jYebWb18vEXEd872avTg2EDEyc25F7Fr/vzYCxWIReBnWfH6l/lKNmUryXkWVldG75kSOv5e5fFfm8tdFjQfCT8V1tNME+plwJ0s1fQ9dkWm1uh2joOlybwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=TSsxDRvA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4dfb1f481ecso30068051cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1759506289; x=1760111089; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CcjsGAtJBDRTbKSc6ZGZGbuEJNUcV2kb0nQ6sHCx+Sk=;
        b=TSsxDRvAuFSugPPdWQiHQaOCyxapN1gxma2art4K8NNb0r5gI0PLUKeeBmNEC/g29X
         P+qL7o+/23b6lFo90qqvTgrvZI2ynRhn4sl5kRW289vD14gXXCa+MO+tLzdfLALabkFq
         JE4eRsY5LTMnzLTBNDy136JyrfsVl4k3K2kNSDiYwVYyUXwJfi5wE8rtNW/E1tuptsWm
         nZzDfDha+02v1UaUfcI65QGkFLc+QQQ4/sgatX4OoMXDmgCDQENc+LRPZfaMBMvMqn6W
         FzO7KyE1n/tPeMwA6TE+3bBpIcbE5UOcV1Epgxc4dmPgsDYMwXHUVBum+C2sWYwC8TEv
         J+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506289; x=1760111089;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcjsGAtJBDRTbKSc6ZGZGbuEJNUcV2kb0nQ6sHCx+Sk=;
        b=uJkx7CMHgbgATlL7Vc8v6IL1M2mHAlM6vAjBW53tQ50qi57oSqq26eXaj/z52hsqjs
         5ru9w9YyGUMgN+lldZYoc+oqEPFZ7aGLUPwElBmMjj6DrX/V9K79Wim6aAFEKFQy6J3O
         18MknhEVZqmGmJ7/YluvxFjg7mBkNhgSlbNM2inktgBIvI9Eer7plhDPJOG7CJF6E/P4
         Ds9b8N0V93QoGgyFMfpN+6XPyR7T/uu5XiDPYFLshAaA8k+7r9ZTFHncseQUilQvYRNr
         uTyMKSPkyhz34hDtgFhG1O2oHOVIB1JV1v+DoeIezbZJj5gfJV9eYJJa1+dCwnfhkhvO
         gsWA==
X-Forwarded-Encrypted: i=1; AJvYcCVv13dtvLQbRtLnFKjLVJjutJmYWphEdU9ML6XM2nujI06IUhfJUJNlsYOftadJYGM8nwU3noxcdgadOjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3i1jHGkhhYzJ0DTLnVab3jLaGrU5Dc7TlQc4/dnfZtUADsm8
	Os8kQ6M24ZKiPQ/qwnVZpb3V+zpNuR1NpG+8LBAmoOHDlQ6Bz3XhKC/slOjdXcucdr8=
X-Gm-Gg: ASbGncu01/cOYswc6dioxPMUj1CYMpEeEU7KkTYZ2O/RKwW9Tv9nuzUZi0qZ4l2pu5E
	OTvA74JCZ7Pn65N1MgHqjxR9jNp4x97xRNTLW9FMeSu2hVxJv/zzxJJMy7iR50v0a4VjWr3K0JW
	IlJUhAps/jhgE1x18ItGpCUyRmQQIvbIw3rI4aAO2t6cbrhiuqSgnOP7+DvtDvRcMlTTKHSxgaI
	Zp5I/O8jMoOMnw2Qgvrx5NMpJfN+UWYj1FfB8kAkAwMRux36p6pWrM3Fn2z/gGk1qr0U4o/KUka
	EMPTPEXjn3u5rrFbzmQ+HXrBr7XJJ1FwrASYVc+/cAIQCFnKVsbW4yrdIYg1Zu7JaHmdbMEf1qf
	GcCebV3el1wZfOUv4Zo6dTLv5nvnEQlGMRe2UwUA6lF9vP7dKHj/Mnrq1d2F+avJ/Q7l2kkeLfR
	cgVw==
X-Google-Smtp-Source: AGHT+IG3nggyzp6rBeV7O8SFngJ0q7vh9MKYuGI8B+E0xgcql9QjTelcIZpNtFB3s282izeII55ing==
X-Received: by 2002:a05:622a:343:b0:4b5:e9e3:3c90 with SMTP id d75a77b69052e-4e576a5d586mr46819141cf.9.1759506287912;
        Fri, 03 Oct 2025 08:44:47 -0700 (PDT)
Received: from [192.168.42.140] (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55aa44901sm41212601cf.18.2025.10.03.08.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:44:47 -0700 (PDT)
Message-ID: <e22a74d0298d7318c59841f706f6f731c77241db.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: mtk-mdp: Fix some issues in mtk_mdp_core.c
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Haoxiang Li <haoxiang_li2024@163.com>, minghsiu.tsai@mediatek.com, 
	houlong.wei@mediatek.com, andrew-ct.chen@mediatek.com, mchehab@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	hans.verkuil@cisco.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Date: Fri, 03 Oct 2025 11:44:45 -0400
In-Reply-To: <20250917094045.28789-1-haoxiang_li2024@163.com>
References: <20250917094045.28789-1-haoxiang_li2024@163.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jvh4cueVjwyOExiJXg2C"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-jvh4cueVjwyOExiJXg2C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


Le mercredi 17 septembre 2025 =C3=A0 17:40 +0800, Haoxiang Li a =C3=A9crit=
=C2=A0:
> Add check for the return value of vpu_get_plat_device() to prevent null
> pointer dereference. And vpu_get_plat_device() increases the reference
> count of the returned platform device. Add platform_device_put() to
> prevent reference leak. Also add platform_device_put() in mtk_mdp_remove(=
).

I think we should improve the subject a little. What about ?

  media: mtk-mdp: Fix error handling in probe function


Nicolas

>=20
> Add mtk_mdp_unregister_m2m_device() on the error handling path.
>=20
> Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Add check for vpu_get_plat_device()
> - Add platform_device_put() in mtk_mdp_remove()
> - Add mtk_mdp_unregister_m2m_device() on the error handling path.
> - Modify the patch title and description. I think you are right.
> =C2=A0 Thanks, CJ!
> ---
> =C2=A0.../media/platform/mediatek/mdp/mtk_mdp_core.c=C2=A0 | 17 +++++++++=
++++++--
> =C2=A01 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
> b/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
> index 80fdc6ff57e0..8432833814f3 100644
> --- a/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
> +++ b/drivers/media/platform/mediatek/mdp/mtk_mdp_core.c
> @@ -194,11 +194,17 @@ static int mtk_mdp_probe(struct platform_device *pd=
ev)
> =C2=A0	}
> =C2=A0
> =C2=A0	mdp->vpu_dev =3D vpu_get_plat_device(pdev);
> +	if (!mdp->vpu_dev) {
> +		dev_err(&pdev->dev, "Failed to get vpu device\n");
> +		ret =3D -ENODEV;
> +		goto err_vpu_get_dev;
> +	}
> +
> =C2=A0	ret =3D vpu_wdt_reg_handler(mdp->vpu_dev, mtk_mdp_reset_handler, m=
dp,
> =C2=A0				=C2=A0 VPU_RST_MDP);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&pdev->dev, "Failed to register reset handler\n");
> -		goto err_m2m_register;
> +		goto err_reg_handler;
> =C2=A0	}
> =C2=A0
> =C2=A0	platform_set_drvdata(pdev, mdp);
> @@ -206,7 +212,7 @@ static int mtk_mdp_probe(struct platform_device *pdev=
)
> =C2=A0	ret =3D vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(3=
2));
> =C2=A0	if (ret) {
> =C2=A0		dev_err(&pdev->dev, "Failed to set vb2 dma mag seg size\n");
> -		goto err_m2m_register;
> +		goto err_reg_handler;
> =C2=A0	}
> =C2=A0
> =C2=A0	pm_runtime_enable(dev);
> @@ -214,6 +220,12 @@ static int mtk_mdp_probe(struct platform_device *pde=
v)
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> +err_reg_handler:
> +	platform_device_put(mdp->vpu_dev);
> +
> +err_vpu_get_dev:
> +	mtk_mdp_unregister_m2m_device(mdp);
> +
> =C2=A0err_m2m_register:
> =C2=A0	v4l2_device_unregister(&mdp->v4l2_dev);
> =C2=A0
> @@ -242,6 +254,7 @@ static void mtk_mdp_remove(struct platform_device *pd=
ev)
> =C2=A0
> =C2=A0	pm_runtime_disable(&pdev->dev);
> =C2=A0	vb2_dma_contig_clear_max_seg_size(&pdev->dev);
> +	platform_device_put(mdp->vpu_dev);
> =C2=A0	mtk_mdp_unregister_m2m_device(mdp);
> =C2=A0	v4l2_device_unregister(&mdp->v4l2_dev);
> =C2=A0

--=-jvh4cueVjwyOExiJXg2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaN/vbQAKCRDZQZRRKWBy
9KWiAP0QJQMSss66nBhuvWdyP3z+yb6Q5jk6MMuOVBfPG9I+XgEAlm/xzfuJ8BPA
DxlLGE1JMwN8N8zLQzYhKhp61WB8XwQ=
=RvA4
-----END PGP SIGNATURE-----

--=-jvh4cueVjwyOExiJXg2C--

