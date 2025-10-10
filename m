Return-Path: <linux-kernel+bounces-848264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A73BCD0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25ED14FD7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23542F0C6B;
	Fri, 10 Oct 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="CfeBV7NQ"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBA2F0C5B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101821; cv=none; b=VbIQrA2oMBd37j8W8i1W8dykAzs++2KqTd99CY+Ax0VllGuzyOGiWVD95G3IfQ1EMOAxh6kRi+uw52O+1tOv8QJITM9knUf8om/JTEXGXNx459LGXJHJ8nLK3WhQqlEw8bNIohGTV0aspfplI7gk4Y7jpsm7vgJz4lmEo9ImpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101821; c=relaxed/simple;
	bh=4lJlcv8Gr+/KI2ALeNVhZviw1LbftEBNlP6ww8ci/QA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2K4EhYGjjstYaFzVoEu8WNZp7+kGA+oWMK+G7uKDR0GINtQ3s4vnvMe3nrv18RTzaOdqr+xLxwYODCNEnRQziiLyE6dL+tOuC5b7z8GNRf3hZqQWt3jj6eXbTYLxmD3rHjKgwNBwvD7GkLiTpAn9Z0rPMtzK1naavs0NnzZWN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=CfeBV7NQ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d40e0106b6so1142322137.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1760101818; x=1760706618; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1fLwwQtYS9/oCuPHk+DiJAuPGJNAUbU6jjwD4B7N0V0=;
        b=CfeBV7NQ9JjVG3+TVEJ6PC9GqRzfZCJhpwK8Tt3LL8qEaoBO3pPNrOO78v2u3ofMQv
         VFdbUGRpY1IPZo+fJevcJdszGB70vBFH+fqNhtsKTp7UbTMkA5YDEp09sPoYjKSqmgKB
         XqxWGKqD6J2CwdYbyGzghe13nrdKmPq32BnR1QPUEa1BnUfr+66tTWN2WSpsPDwMsH2Q
         wYBeKRN6jF6MIwSJXOnIkZ4Jv7OugDg7mdet76eUhnjzJ6hmdzzQrTR6i7YhFl8FgKQn
         Gzjw90YvD0YyavfrRMHdj9B2bUAhVJN4FiUFli3pOIJKAMH4dlB0B3oui0LDVP6tt82t
         izaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760101818; x=1760706618;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fLwwQtYS9/oCuPHk+DiJAuPGJNAUbU6jjwD4B7N0V0=;
        b=lKZyYPn6Zw3PTzRff/Ab1fSTWRuIjJuBnAHcdmGehko6jYtUXWPG4oM6Ildp5StNUT
         ADxOplA28ZDmW6wcBavy9i6rtZf3Zh+T0li/1jwIPhNrNspahfstqbun+2n3CPS7FMnF
         uWWVhNgxnY7r4ZcO7j4RpMuxz+OoCRO2fg6bQTxkv0ya3wiHHmxJfhFIlrlqYPp8mnAn
         LrRnOd4NNWF2Z72P/NIQyD1zdIqWjfWTiUNuJF1tybs3RYs34wroi1f+UyoV7+9s63La
         vgLHMZ4Sryc+BzVbRA7QWD82+anlcDI1GyxMPywAhJyaC3PwWccDLuHX6BKb29F8Hg6G
         ITnw==
X-Forwarded-Encrypted: i=1; AJvYcCXUfsQ5yTX+d+jTTN/bHxyGg/E5rPqirsFeXd8vhl5/D/8Jne2F1Bckw/rR5BY38rxZ8qCuqZm4wUps+pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmIp4dWS1NtV7pcA7E46De91quiAnwCaPyyAVjv8mjAjCSU15
	H6CWcmsDSbBqolsoE5HaIGfPsiLcsVEZZJGdr7sBPFoJs4ZAHINDwTagApvvmMXTUiA=
X-Gm-Gg: ASbGncuIXlVUNCYhya/fRjWkKSVK+Z3GJaXstw6AzlyAuQmY3io9POyLoIPwB/8BjBt
	skC097thsmxmSVktr6SiFxZBufOS2ifdBxyUUm7+ki0vBtbhJdrBchf1x+ADgq8DXufcjMA9JE5
	DPCNMW8F7/97CjYo4O+85uYcSD6tk9qzFKErJyDnqmB3LzmKN0Jlb/bgtiNWQMa1iK4MfRVCxC3
	b1uMPV5/p7/gT90uDu3meuJvzUpxtO/QyET1bU73eGNfnBECINpw0vPeCcZz7JggFZZ2yoNYQYt
	fyjSLA4Z35cB9jL6xXWhiUqOlyutdP+SRZ8FvNKnBnNAW7nPt62jeVdtGfYhJ4wF09IZFptx+x6
	27wvj0542XXAr9dWbFrhpz+JtHneIG8oFX1MMbIwECGIYl2k=
X-Google-Smtp-Source: AGHT+IFRUo0Z5NcP31jBqlbovhPstCVhPEpvKr9/mW5HAo/OoZxluHpqS1bKY5jZDCTa960/6sgFvQ==
X-Received: by 2002:a05:6102:598b:b0:521:57e7:3b19 with SMTP id ada2fe7eead31-5d5e23ad946mr4722552137.25.1760101816309;
        Fri, 10 Oct 2025 06:10:16 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:ebd3::c41? ([2606:6d00:17:ebd3::c41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf6ce034sm704047241.7.2025.10.10.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 06:10:14 -0700 (PDT)
Message-ID: <09dd8f5915da5a2e01bee3835e8de8e209cc4933.camel@ndufresne.ca>
Subject: Re: [PATCH 11/16] media: rockchip: rga: add iommu restore function
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Sven =?ISO-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>, Jacob Chen
	 <jacob-chen@iotwrt.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Mauro Carvalho Chehab
	 <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kernel@pengutronix.de
Date: Fri, 10 Oct 2025 09:10:13 -0400
In-Reply-To: <bdebed9c-2980-4d5d-9eb3-1cb5e5e8e226@pengutronix.de>
References: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
	 <20251007-spu-rga3-v1-11-36ad85570402@pengutronix.de>
	 <97879b9b078055fb130edfd126d253320ce616a1.camel@ndufresne.ca>
	 <bdebed9c-2980-4d5d-9eb3-1cb5e5e8e226@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-3xuLcpZRvhbRvRP2LvxW"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-3xuLcpZRvhbRvRP2LvxW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 10 octobre 2025 =C3=A0 10:45 +0200, Sven P=C3=BCschel a =C3=A9c=
rit=C2=A0:
>=20
> On 10/7/25 20:30, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le mardi 07 octobre 2025 =C3=A0 10:32 +0200, Sven P=C3=BCschel a =C3=A9=
crit=C2=A0:
> > > Add an iommu restore function in preparation for the rga3 addition.
> > > This is necessary for a soft reset, as the rga3 will also reset
> > > it's iommu paging table to 0 and disable paging.
> > >=20
> > > The empty domain attach/detach to restore the iommu is copied
> > > from the rkvdec driver.
> > We did receive negative feedback after the fact on this one. We will li=
kely
> > upset further the iommu subsystem maintainers with that. Have you consi=
dered
> > adding a restore function in the rkiommu driver, similar to TI mmu and =
Benjamin
> > VSI MMU proposal ?
> >=20
> > I have no precise objection, I know it works, but adding a restore func=
tion
> > seems also pretty straight forward.
>=20
> I haven't considered adding an restore function. I've implemented this=
=20
> to handle potential command stream failures like scaling beyond the=20
> supported 8x factor. I'll probably drop this for now to keep it simple=
=20
> and instead correctly announce the constraints to avoid creating invalid=
=20
> commands in the first place.

Ack, though keep a warning around and some comment about the behaviour. We =
are
human, and may leave some bugs behind, always nice then they are recoverabl=
e.
(though PM runtime cycle also would recover that one).
>=20
> > > Signed-off-by: Sven P=C3=BCschel <s.pueschel@pengutronix.de>
> > > ---
> > > =C2=A0=C2=A0drivers/media/platform/rockchip/rga/rga.c | 24 ++++++++++=
++++++++++++++
> > > =C2=A0=C2=A0drivers/media/platform/rockchip/rga/rga.h |=C2=A0 7 +++++=
++
> > > =C2=A0=C2=A02 files changed, 31 insertions(+)
> > >=20
> > > diff --git a/drivers/media/platform/rockchip/rga/rga.c
> > > b/drivers/media/platform/rockchip/rga/rga.c
> > > index
> > > cd4da01645611e5fb51ed94e09b5f1463dad72c5..0a725841b0cfa41bbc5b861b8f5=
ceac2452f
> > > c2b5 100644
> > > --- a/drivers/media/platform/rockchip/rga/rga.c
> > > +++ b/drivers/media/platform/rockchip/rga/rga.c
> > > @@ -9,6 +9,7 @@
> > > =C2=A0=C2=A0#include <linux/delay.h>
> > > =C2=A0=C2=A0#include <linux/fs.h>
> > > =C2=A0=C2=A0#include <linux/interrupt.h>
> > > +#include <linux/iommu.h>
> > > =C2=A0=C2=A0#include <linux/module.h>
> > > =C2=A0=C2=A0#include <linux/of.h>
> > > =C2=A0=C2=A0#include <linux/pm_runtime.h>
> > > @@ -560,6 +561,19 @@ static const struct video_device rga_videodev =
=3D {
> > > =C2=A0=C2=A0	.device_caps =3D V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_ST=
REAMING,
> > > =C2=A0=C2=A0};
> > > =C2=A0=20
> > > +void rga_iommu_restore(struct rockchip_rga *rga)
> > > +{
> > > +	if (rga->empty_domain) {
> > > +		/*
> > > +		 * To rewrite mapping into the attached IOMMU core, attach a
> > > new empty domain that
> > > +		 * will program an empty table, then detach it to restore the
> > > default domain and
> > > +		 * all cached mappings.
> > > +		 */
> > > +		iommu_attach_device(rga->empty_domain, rga->dev);
> > > +		iommu_detach_device(rga->empty_domain, rga->dev);
> > > +	}
> > > +}
> > > +
> > > =C2=A0=C2=A0static int rga_parse_dt(struct rockchip_rga *rga)
> > > =C2=A0=C2=A0{
> > > =C2=A0=C2=A0	struct reset_control *core_rst, *axi_rst, *ahb_rst;
> > > @@ -657,6 +671,13 @@ static int rga_probe(struct platform_device *pde=
v)
> > > =C2=A0=C2=A0		goto err_put_clk;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > +	if (iommu_get_domain_for_dev(rga->dev)) {
> > > +		rga->empty_domain =3D iommu_paging_domain_alloc(rga->dev);
> > > +
> > > +		if (!rga->empty_domain)
> > Its an error pointer, see:
> >=20
> > https://gitlab.freedesktop.org/linux-media/media-committers/-/commit/63=
47dc7fb967521a77f9ff0774d25ef0cca4c6cd
> >=20
> > > +			dev_warn(rga->dev, "cannot alloc new empty
> > > domain\n");
> > > +	}
> > > +
> > > =C2=A0=C2=A0	ret =3D v4l2_device_register(&pdev->dev, &rga->v4l2_dev)=
;
> > > =C2=A0=C2=A0	if (ret)
> > > =C2=A0=C2=A0		goto err_put_clk;
> > > @@ -741,6 +762,9 @@ static void rga_remove(struct platform_device *pd=
ev)
> > > =C2=A0=C2=A0	v4l2_device_unregister(&rga->v4l2_dev);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	pm_runtime_disable(rga->dev);
> > > +
> > > +	if (rga->empty_domain)
> > > +		iommu_domain_free(rga->empty_domain);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0static int __maybe_unused rga_runtime_suspend(struct devi=
ce *dev)
> > > diff --git a/drivers/media/platform/rockchip/rga/rga.h
> > > b/drivers/media/platform/rockchip/rga/rga.h
> > > index
> > > fc4805ba4e8ef7fb311f780a198ba6ba4d3aff17..e19c4c82aca5ae2056f52d52513=
8093fbbb8
> > > 1af8 100644
> > > --- a/drivers/media/platform/rockchip/rga/rga.h
> > > +++ b/drivers/media/platform/rockchip/rga/rga.h
> > > @@ -75,6 +75,7 @@ struct rockchip_rga {
> > > =C2=A0=C2=A0	void __iomem *regs;
> > > =C2=A0=C2=A0	struct clk_bulk_data clks[3];
> > > =C2=A0=C2=A0	struct rockchip_rga_version version;
> > > +	struct iommu_domain *empty_domain;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	/* vfd lock */
> > > =C2=A0=C2=A0	struct mutex mutex;
> > > @@ -114,6 +115,12 @@ static inline struct rga_vb_buffer *vb_to_rga(st=
ruct
> > > vb2_v4l2_buffer *vb)
> > > =C2=A0=20
> > > =C2=A0=C2=A0struct rga_frame *rga_get_frame(struct rga_ctx *ctx, enum=
 v4l2_buf_type
> > > type);
> > > =C2=A0=20
> > > +/*
> > > + * This should be called in an interrupt handler to make sure no mem=
ory
> > > + * is mapped through the IOMMU while the empty domain is attached.
> > > + */
> > > +void rga_iommu_restore(struct rockchip_rga *rga);
> > > +
> > > =C2=A0=C2=A0/* RGA Buffers Manage */
> > > =C2=A0=C2=A0extern const struct vb2_ops rga_qops;
> > > =C2=A0=20

--=-3xuLcpZRvhbRvRP2LvxW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaOkFtQAKCRDZQZRRKWBy
9K7JAQDtH5ATpeywJXRiQ257tpfW7vvpZX9/3t7E0wbUA/MVsAD6A3FL1LcECnxq
20Ch0znvV9//0YSBl4slG1UocjEBuQ4=
=awm4
-----END PGP SIGNATURE-----

--=-3xuLcpZRvhbRvRP2LvxW--

