Return-Path: <linux-kernel+bounces-831928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F8B9DEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E8D1BC2DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3977F24167A;
	Thu, 25 Sep 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxMVl0qB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E71A4F12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786669; cv=none; b=XRAwLK9zLADAW54SPKOxfCsoBls+0VnrpRi7u2YEUZWtGS5eONXcLzoK9x9cdX8nIuVjd9rbVPF7QXvUb2LG23CXpC8uGexFlUPzrn7Aar3+fM+pw8VT83r7CITl58fSy5QOkIyVBjk4ZugiqmTqFK8/zVj6Ijb+MEUfKmD4ftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786669; c=relaxed/simple;
	bh=8POI4Z8NIgZ9eWulLcxOFUXzrhQybf9IS1kQegq4pqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VfX/5y1ZMyKzJA7+Ea3ZvS09TdGo3tqU1dg40qqEgsd4eFy2ozL2o3Yr5e8le61nEpJOpmyLOb70dYVJq1ypELVZZJWoRm+JhavsvJd5bZVm5+siuv8/e6Jfc4J3hrkbvudnLuB3LHzzTGJfosaplOTiqd3omeeM0a+sPW74pPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxMVl0qB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e29d65728so3819125e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758786665; x=1759391465; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8POI4Z8NIgZ9eWulLcxOFUXzrhQybf9IS1kQegq4pqU=;
        b=BxMVl0qB/IhbbwwcS/ND2xQVShrlSPHTg9FpdxPlaYnf/e3pccXQ5rEE5zluSPXmB+
         2j6fudl3ismmVblhVI6j8xU5X7x1zmCoaRlaCHXIEw2rRNUrogOHU8WNf4hHt8LbAIam
         XIOyHrzrYbgU7z0S020+RtC+693Zd1i7QDD7JEjRtKjzHaGDfRZXRn2R2FT/BnY4CxSE
         9Ra9eYJs0KBsXLMU/7vl951R2KoRR5Q5N7t6QesBW8sx++y7Wz8bZtHG9IGBz+4Xl/aa
         umPi1tmAzHiX47T4hix1u9k99gO1jrkrPPVmcVdkEEaaDVr1ZQyzfaT+a6UGvBIupja/
         448w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786665; x=1759391465;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8POI4Z8NIgZ9eWulLcxOFUXzrhQybf9IS1kQegq4pqU=;
        b=lLM0hXXYEPJ2M8U469J9q1gEyUKDUMG+3XXRFXp+rkoj7GGQTI9X4xJxykjAEYaFDV
         vG8MeVE234FA+DvRRUxr+vIioald9nOu3ZNfvcrr458bjASOlGh3QmTOUeusWdnUnouz
         UCE+t9ytb/SwiSx9c1UZh1/qqznf9jbddpLhwSj19UWdvyoP9cN8v9795WeG6hwirkik
         rYUefrSNssRvO3SY8IlMbJHNMSQCeHGgmhrRj7rt+PV3NqGyo2riZCDUjg2PuK2k2ktc
         Ky3GzcTn2hmyyOeLz/NoDui3StQ3x2osawBKFBfutdRVNFpzqhrkLlLCqZUWvz/wzMxP
         WuYw==
X-Forwarded-Encrypted: i=1; AJvYcCXiD3MgUk7PK785tnSKzBgxaexLGOvna95dBifnfL9HmYGLskCP8HbhMaNdSpHv+pWJRQVer+ls/d97NiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7epZlZZ7jEq/3N/ZwE9ZhpmwpgKoLuONEDwB94XrR1GluVbYw
	RC8umubZTYJ1naQVzQNLZQGsg6H1o6gCUBtMxS6MyDtxsVsjk09EA4yM
X-Gm-Gg: ASbGncsLJvGiDZ0I6ytfhNYihB8FH2/gDzsB7rglzM92htRtg8pGnargsg7engKDA2j
	4cDDrUz5mIhxSfefDGrnP9ExCBR5CCTFf3gYxPy6zL0A1Vnv7hd2StPCLAFndd18e4fLJCw/tq2
	RJWJaqk0KdRd+Lm3WMvEJiylApf00EL1G7FansX318ldWZjrGspCYudx8Efy0Na+Xsqcc0yUoxN
	VHpWGgTOkqWwEaqGjlUIZ9kFE5uRreX5JKqf9rZwUtXZKwALhPdcBTkuYgT+bgj9SrSstTF81Se
	sxhAIu2OJAzAUWXFbYpjl3VXRW1SLLN3d0izBue3FZv6wc31Gis/XRXtVGgBx68yn3UnP5uaVPv
	x8ycWInvrEh9S9X5302cV6w==
X-Google-Smtp-Source: AGHT+IGUuGO0MctI5suTsLaRzPLAL3wVtTajfyppJ7wHXCpSF63TKkBkV3h0klrqzYRmhS5fxuQM5A==
X-Received: by 2002:a5d:5d84:0:b0:3ee:14e9:23d2 with SMTP id ffacd0b85a97d-40e447770abmr2010911f8f.8.1758786665164;
        Thu, 25 Sep 2025 00:51:05 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f62sm64575345e9.15.2025.09.25.00.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:51:04 -0700 (PDT)
Message-ID: <37d47af4f4d5220764efc5870630fdfc1e9be2c9.camel@gmail.com>
Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>, Jorge Marques
	 <gastmaier@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jorge Marques	
 <jorge.marques@analog.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Frank Li <Frank.Li@nxp.com>, Arnd
 Bergmann <arnd@arndb.de>, "linux-i3c@lists.infradead.org"	
 <linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>
Date: Thu, 25 Sep 2025 08:51:33 +0100
In-Reply-To: <DM4PR12MB6109367F36487B582ED8EA968C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250924201837.3691486-1-arnd@kernel.org>
	 <2wtpklapw5ogsevuvk2l4ngvw7hymer2y4cc454h47u2d7tq44@4mknmpk5yzil>
	 <DM4PR12MB6109367F36487B582ED8EA968C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-25 at 07:37 +0000, Guntupalli, Manikanta wrote:
> [Public]
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Jorge Marques <gastmaier@gmail.com>
> > Sent: Thursday, September 25, 2025 12:47 PM
> > To: Arnd Bergmann <arnd@kernel.org>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>; Jorge Marques
> > <jorge.marques@analog.com>; Wolfram Sang <wsa+renesas@sang-
> > engineering.com>; Frank Li <Frank.Li@nxp.com>; Arnd Bergmann
> > <arnd@arndb.de>; Guntupalli, Manikanta <manikanta.guntupalli@amd.com>;
> > linux-
> > i3c@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
> >=20
> > On Wed, Sep 24, 2025 at 10:18:33PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > Short MMIO transfers that are not a multiple of four bytes in size
> > > need a special case for the final bytes, however the existing
> > > implementation is not endian-safe and introduces an incorrect byteswa=
p
> > > on big-endian kernels.
> > >=20
> > > This usually does not cause problems because most systems are
> > > little-endian and most transfers are multiple of four bytes long, but
> > > still needs to be fixed to avoid the extra byteswap.
> > >=20
> > > Change the special case for both i3c_writel_fifo() and
> > > i3c_readl_fifo() to use non-byteswapping writesl() and readsl() with =
a
> > > single element instead of the byteswapping writel()/readl() that are
> > > meant for individual MMIO registers. As data is copied between a FIFO
> > > and a memory buffer, the writesl()/readsl() loops are typically based
> > > on __raw_readl()/ __raw_writel(), resulting in the order of bytes in
> > > the FIFO to match the order in the buffer, regardless of the CPU
> > > endianess.
> > >=20
> > > The earlier versions in the dw-i3c and i3c-master-cdns had a correct
> > > implementation, but the generic version that was recently added broke=
 it.
> > >=20
> > > Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and
> > > i3c_writel_fifo()")
> > > Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > This was a recent regression, the version in 6.16 still works, but
> > > 6.17-rc is broken.
> > >=20
> > > v2 changes:
> > > =C2=A0- add code comments
> > > =C2=A0- write correct data buffer
> > > ---
> > > =C2=A0drivers/i3c/internals.h | 12 ++++++++++--
> > > =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h index
> > > 0d857cc68cc5..79ceaa5f5afd 100644
> > > --- a/drivers/i3c/internals.h
> > > +++ b/drivers/i3c/internals.h
> > > @@ -38,7 +38,11 @@ static inline void i3c_writel_fifo(void __iomem *a=
ddr,
> > > const
> > void *buf,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u3=
2 tmp =3D 0;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me=
mcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(=
tmp, addr);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
 writesl() instead of writel() to keep FIFO
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
 byteorder on big-endian targets
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
/
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writesl=
(addr, &tmp, 1);
> > > =C2=A0=C2=A0=C2=A0 }
> > > =C2=A0}
> > >=20
> > > @@ -55,7 +59,11 @@ static inline void i3c_readl_fifo(const void __iom=
em
> > > *addr,
> > void *buf,
> > > =C2=A0=C2=A0=C2=A0 if (nbytes & 3) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u3=
2 tmp;
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D=
 readl(addr);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
 readsl() instead of readl() to keep FIFO
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
 byteorder on big-endian targets
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
/
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 readsl(=
addr, &tmp, 1);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 me=
mcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
> > > =C2=A0=C2=A0=C2=A0 }
> > > =C2=A0}
> > Reviewed-by: Jorge Marques <jorge.marques@analog.com>
> > > --
> > > 2.39.5
> > >=20
>=20
> This patch fixes the sub-word transfer case on big-endian kernels, but it
> still does not address the scenario of little-endian kernels accessing bi=
g-
> endian FIFOs.
>=20

I would argue that's something for callers of these functions to care about=
.

- Nuno S=C3=A1

> With the current version, i3c_writel_fifo() and i3c_readl_fifo() only wor=
k
> when the FIFO has the same endianness as the CPU. On platforms such as th=
e
> ZCU102 (Zynq UltraScale+ MPSoC, Cortex-A53, little-endian), the I3C FIFOs=
 are
> big-endian, and this patch alone is not sufficient - transfers fail in th=
at
> configuration.
>=20
> We have validated this on ZCU102, and the mismatch between LE kernel and =
BE
> FIFO is still an issue.
>=20
> On top of this fix, explicit FIFO endianness support is required, as prop=
osed
> in [PATCH v7 3/4] "i3c: master: Add endianness support for i3c_readl_fifo=
()
> and i3c_writel_fifo()". That approach adds an endian argument and uses
> writesl_be()/readsl_be() where necessary, e.g.:
>=20
> static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nbytes, enum =
i3c_fifo_endian endian)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (endian)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 writesl_be(addr, buf, nbytes / 4);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 writesl(addr, buf, nbytes / 4);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nbytes & 3) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 u32 tmp =3D 0;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (endian)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writesl_=
be(addr, &tmp, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writesl(=
addr, &tmp, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> }
>=20
>=20
> Thanks,
> Manikanta.

