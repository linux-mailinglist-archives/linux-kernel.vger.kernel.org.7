Return-Path: <linux-kernel+bounces-832019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9ABB9E270
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DDA1B284C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DEB278772;
	Thu, 25 Sep 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDfV18p6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141B279DCE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790660; cv=none; b=RECfKYSLj5qsk5fL9n1iuevSz0z9/NxCblLxyb32TiC+qbWMUvibaylfIP6H6Z6i3c1ykYW3t4ost0Hs+Y7OgWXyDNr/mJmNpCaI+euibyBVFwPiWFzVR+Zvo4ifRmmY21pfM2xW+4FTizvnGQCqoU8mCy1WMXihLBoQOgMd28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790660; c=relaxed/simple;
	bh=JDV6lQyFHzUzwoPhPLVE57nzZPLAlDFfGvCbbrW4Ng0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B90aiZVGjdbbBrLo8/Xexo4V8u7Abf9c9oxiHLBSpAE9o2Yj6lL1yYCtBQWiuZDPknj5Ou7CA5L3TftohLpfIwJZOtFIHZhpt0bFz/HaDWqteGvyNXKF+rmUKN6GtBdzFwHaRkZmFafrYB8Tu2RMhGNeji4WpcFYOqvtZh4HlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDfV18p6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso4557205e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758790657; x=1759395457; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JDV6lQyFHzUzwoPhPLVE57nzZPLAlDFfGvCbbrW4Ng0=;
        b=SDfV18p6F8HCq8oyQ0R8cry16vZJI9vvxt76J4HYF4BsNUHKSQI9oE9ldgN7fWKlZs
         S9HLOibZdL/YAet1G+3kMdCupyk33zF0eELRP7oZckaldmKDLRvgwIQjF6wxDHp18T/H
         DgpiPMqi+mIAFih164NEGs5+oD7v/jLWL1tNotHLek35QDKipP4fOK+ni85ZKt3ABsa7
         SRRLdWdwyzDfFluPVDBQAzxnvSgPgK7K2GZ5Jgat7vUlT1qq4N/IjrFnVWRYTcNz2VkY
         7x+Hf5xt3mdbd4GSGNw89lTlWn3WF32CJVRG39vYEOvt/S3XJ5pZI6NNed0BKy2n028k
         JJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790657; x=1759395457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDV6lQyFHzUzwoPhPLVE57nzZPLAlDFfGvCbbrW4Ng0=;
        b=XFbe+8JjHlJ1QP6IQQhLNsmUTHPcZCZUJuemY/llESNkGFESMotrChw6SiebLJ8jZx
         ZrSf8SoY0BHqy1DFqmlqXfh6OLCWGLWz4OEQItSWNvWBij17tqxVDEolxA65tCUFshEW
         3dvk67Y14s1aG02+L3tvZNcIhbAZ10uv+gr4+fgQCev6+OS5gXGfu17O17mOkWJLF9Ri
         Oj/Drw4aVCIxDWtINYmFsld50KNmYfB8j1wwrYWo0fxBkdd3GUJoN/6iSrasSxXySA4F
         lpy3JE1+L1aN1A3imgI57k2Nl7NfSxUpaPvsXQgdy8//2Qe9s8xPt/FHcybF7yBwDcL+
         dbbA==
X-Forwarded-Encrypted: i=1; AJvYcCWDUpojmkurRmARCuaSNY5d0580ro32llSs8uvi1dvD5HDjkcUPHDQXxQnTNHrGeIiRgI4kOluvCCxxZH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3Z9hX1Hl/a4fPI2B3vNN/0AG+MMdsV1eFj93b78DCGkGbGTa
	eNpyNhVFXb8iH9RW80oeIpyj3vpao5Zvhc2uCszEZ5/EtGOx/+JI75veX/rnHngB0Oo=
X-Gm-Gg: ASbGncvsyzDoMU/93wdaLOMGL54y596ngN80hDs67eveh1xumuup7+7Loq8N0sPa+RL
	WAIeyOL4tgmEMmWHdHfNAVpSo5pv+zOX+AUxr4sR69XUR0YRKOyxbPvWPDkmCmGH35cfE8c6lLl
	lqFT5Thm8MDIxrxH1wI/n+PIONnnNL1F8VlPt3NKPFTXyLAu/vhHDMMQm+LU2Nh+BezVcxExDdD
	sodfjHzdCOeEiCEP/9i1nRcewGxsnrkW68EpC1he9iOHFOZhyvMsohgFIc15tzYskGmLlfJblLd
	CVwpghk92cMMTirhJBljZLH/p5Np3KdJ+VFQpBjUhqwHQWtlp18p3oOKVAs6fPQK1uSj33tsBvd
	rnz6VIgkMdZpQY5kp1FPW6hjF/xkHPL0=
X-Google-Smtp-Source: AGHT+IFwc/ogQyexaRhKy29O42WYdUKH6a2Y0I5hHzY/tZTegkQSMJsUIpoh57przGHqAXOZ2bO9Og==
X-Received: by 2002:a05:600c:310c:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46e35d550acmr11127985e9.25.1758790657222;
        Thu, 25 Sep 2025 01:57:37 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb2eesm2188803f8f.12.2025.09.25.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 01:57:36 -0700 (PDT)
Message-ID: <e5a6789230840b31ef0f60ca0a770a4fb266da2a.camel@gmail.com>
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
Date: Thu, 25 Sep 2025 09:58:04 +0100
In-Reply-To: <DM4PR12MB61093CEE50990ECC403D3FB98C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250924201837.3691486-1-arnd@kernel.org>
		 <2wtpklapw5ogsevuvk2l4ngvw7hymer2y4cc454h47u2d7tq44@4mknmpk5yzil>
		 <DM4PR12MB6109367F36487B582ED8EA968C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
	 <37d47af4f4d5220764efc5870630fdfc1e9be2c9.camel@gmail.com>
	 <DM4PR12MB61093CEE50990ECC403D3FB98C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-25 at 08:47 +0000, Guntupalli, Manikanta wrote:
> [Public]
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Sent: Thursday, September 25, 2025 1:22 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>; Jorge Marques
> > <gastmaier@gmail.com>; Arnd Bergmann <arnd@kernel.org>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>; Jorge Marques
> > <jorge.marques@analog.com>; Wolfram Sang <wsa+renesas@sang-
> > engineering.com>; Frank Li <Frank.Li@nxp.com>; Arnd Bergmann
> > <arnd@arndb.de>; linux-i3c@lists.infradead.org;
> > linux-kernel@vger.kernel.org; git
> > (AMD-Xilinx) <git@amd.com>; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
> >=20
> > On Thu, 2025-09-25 at 07:37 +0000, Guntupalli, Manikanta wrote:
> > > [Public]
> > >=20
> > > Hi,
> > >=20
> > > > -----Original Message-----
> > > > From: Jorge Marques <gastmaier@gmail.com>
> > > > Sent: Thursday, September 25, 2025 12:47 PM
> > > > To: Arnd Bergmann <arnd@kernel.org>
> > > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>; Jorge Marque=
s
> > > > <jorge.marques@analog.com>; Wolfram Sang <wsa+renesas@sang-
> > > > engineering.com>; Frank Li <Frank.Li@nxp.com>; Arnd Bergmann
> > > > <arnd@arndb.de>; Guntupalli, Manikanta
> > > > <manikanta.guntupalli@amd.com>;
> > > > linux-
> > > > i3c@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
> > > >=20
> > > > On Wed, Sep 24, 2025 at 10:18:33PM +0200, Arnd Bergmann wrote:
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >=20
> > > > > Short MMIO transfers that are not a multiple of four bytes in siz=
e
> > > > > need a special case for the final bytes, however the existing
> > > > > implementation is not endian-safe and introduces an incorrect
> > > > > byteswap on big-endian kernels.
> > > > >=20
> > > > > This usually does not cause problems because most systems are
> > > > > little-endian and most transfers are multiple of four bytes long,
> > > > > but still needs to be fixed to avoid the extra byteswap.
> > > > >=20
> > > > > Change the special case for both i3c_writel_fifo() and
> > > > > i3c_readl_fifo() to use non-byteswapping writesl() and readsl()
> > > > > with a single element instead of the byteswapping writel()/readl(=
)
> > > > > that are meant for individual MMIO registers. As data is copied
> > > > > between a FIFO and a memory buffer, the writesl()/readsl() loops
> > > > > are typically based on __raw_readl()/ __raw_writel(), resulting i=
n
> > > > > the order of bytes in the FIFO to match the order in the buffer,
> > > > > regardless of the CPU endianess.
> > > > >=20
> > > > > The earlier versions in the dw-i3c and i3c-master-cdns had a
> > > > > correct implementation, but the generic version that was recently
> > > > > added broke
> > it.
> > > > >=20
> > > > > Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() an=
d
> > > > > i3c_writel_fifo()")
> > > > > Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > ---
> > > > > This was a recent regression, the version in 6.16 still works, bu=
t
> > > > > 6.17-rc is broken.
> > > > >=20
> > > > > v2 changes:
> > > > > =C2=A0- add code comments
> > > > > =C2=A0- write correct data buffer
> > > > > ---
> > > > > =C2=A0drivers/i3c/internals.h | 12 ++++++++++--
> > > > > =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> > > > > index 0d857cc68cc5..79ceaa5f5afd 100644
> > > > > --- a/drivers/i3c/internals.h
> > > > > +++ b/drivers/i3c/internals.h
> > > > > @@ -38,7 +38,11 @@ static inline void i3c_writel_fifo(void __iome=
m
> > > > > *addr, const
> > > > void *buf,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 tmp =3D 0;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wri=
tel(tmp, addr);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * writesl() instead of writel() to keep FIFO
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * byteorder on big-endian targets
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wri=
tesl(addr, &tmp, 1);
> > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0}
> > > > >=20
> > > > > @@ -55,7 +59,11 @@ static inline void i3c_readl_fifo(const void
> > > > > __iomem *addr,
> > > > void *buf,
> > > > > =C2=A0=C2=A0=C2=A0 if (nbytes & 3) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 tmp;
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp=
 =3D readl(addr);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * readsl() instead of readl() to keep FIFO
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * byteorder on big-endian targets
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rea=
dsl(addr, &tmp, 1);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
> > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0}
> > > > Reviewed-by: Jorge Marques <jorge.marques@analog.com>
> > > > > --
> > > > > 2.39.5
> > > > >=20
> > >=20
> > > This patch fixes the sub-word transfer case on big-endian kernels, bu=
t
> > > it still does not address the scenario of little-endian kernels
> > > accessing big- endian FIFOs.
> > >=20
> >=20
> > I would argue that's something for callers of these functions to care a=
bout.
> If each I3C driver has to handle FIFO endianness individually, it introdu=
ces
> unnecessary duplication and overhead across drivers. Centralizing this in=
 the
> FIFO access helpers keeps the logic consistent, avoids repeated boilerpla=
te,
> and reduces the chance of subtle bugs.

I mean, that's what spi and i2c drivers do already.=C2=A0With enum i3c_fifo=
_endian
you're already forcing users to care (or know) about endianism so they migh=
t as
well just pass the data in the proper order already (not sure if it's such =
a big
'burden').

That said, I'm not really in the loop for i3c so not sure what the expectat=
ions
are. IOW, have no strong feeling about this at all :)

- Nuno S=C3=A1

> >=20
> > > With the current version, i3c_writel_fifo() and i3c_readl_fifo() only
> > > work when the FIFO has the same endianness as the CPU. On platforms
> > > such as the
> > > ZCU102 (Zynq UltraScale+ MPSoC, Cortex-A53, little-endian), the I3C
> > > FIFOs are big-endian, and this patch alone is not sufficient -
> > > transfers fail in that configuration.
> > >=20
> > > We have validated this on ZCU102, and the mismatch between LE kernel
> > > and BE FIFO is still an issue.
> > >=20
> > > On top of this fix, explicit FIFO endianness support is required, as
> > > proposed in [PATCH v7 3/4] "i3c: master: Add endianness support for
> > > i3c_readl_fifo() and i3c_writel_fifo()". That approach adds an endian
> > > argument and uses
> > > writesl_be()/readsl_be() where necessary, e.g.:
> > >=20
> > > static inline void i3c_writel_fifo(void __iomem *addr, const void
> > > *buf,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nbytes, en=
um i3c_fifo_endian
> > > endian) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (endian)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 writesl_be(addr, buf, nbytes / 4);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 writesl(addr, buf, nbytes / 4);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nbytes & 3) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u32 tmp =3D 0;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (endian)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write=
sl_be(addr, &tmp, 1);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write=
sl(addr, &tmp, 1);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > }
> > >=20
> > >=20
> Thanks,
> Manikanta.

