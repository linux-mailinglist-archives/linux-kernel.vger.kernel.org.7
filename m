Return-Path: <linux-kernel+bounces-830913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDCBB9AE21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFBD19C632D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01031197A;
	Wed, 24 Sep 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/ycQpXv"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34C2E7BA0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758731678; cv=none; b=ryIstWXOscwxoHN97/pJTQ6mFbnSt4UvtOBNvliWYMhTuXVTKZtxTjItd3z52xeAPwz7uBU0VnPr0aezWV8w32kac9gL3yCGpRnok44OlTcE2ioPbAm10BgDCyc9ClQMaKu5SvO+A2viRvd+CJVmgRP4sUwxa+SpVXfOEdwJ5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758731678; c=relaxed/simple;
	bh=k/u2n53JY/JdPN7YzmXrl4IRaYFdQjMkNV9SQT9X0Ww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LdymcOY3+MOITdCfG3QV6Z+GlPTD9zMKRylCfRu9wqMAFj95krB/p35R5sGElsGjGslCkZE627qDEe+uDmyzOjKZzQ+ozNvpTNeyJ+9EMYLKS5wK+rEIkkg1LGuSHUWEzM6kKMD35JAq6XBAvhc/rXh62w34f1ps1iW3v80hcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/ycQpXv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f3a47b639aso41523f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758731675; x=1759336475; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ArNEHc23GpAhtyDj0RZTGS3tjfuBxBH3HMLWunMO3p4=;
        b=a/ycQpXvkdDNGEJp+OLDLAdl84HJ0VBAZ8e8zrkb5vs++qfRtpIqZxVaiZShFXCTTX
         uLgkTYEq2szqnFcwMSXKMmH0iXHFkSYbUuLS3vmwLobc4ZGgLgFRcJYi5uddl2GqJvAO
         cFMmNiFFTgSrQ1LKZ07YUsK2hDEa07Pfmv+SaSSYpn29XZZ1UPtDjo5aN6FyWBQZ+QtW
         vOcneKSV0zfiGffMUiM5gHFcWwCYpINBps8ZTk1VnyzrNneHuyO+EbBXffgNozZpCZbM
         +Enep1czMjsvnU1XRy1svZhT223dPjc8iQFGEW6uUzXBPXb1rdoIQ4JKU/6a+6o5Bbqj
         Wcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758731675; x=1759336475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArNEHc23GpAhtyDj0RZTGS3tjfuBxBH3HMLWunMO3p4=;
        b=J6xNd/6S2yVcIiW18nALgwPb1qop7f5JZRamVqBJjbjV6z+zQrU63XqNggBgau5Pz7
         PAeJJw6D4sAPHqfAqTsLdgVKMS+Dhl73FO8aqYUZ4rG/8xsClXAOOF/8aVoQx4h60qyT
         I3m+TNye5WiXH2RTQJuqtbE/4J+sgD37avSyW9omP7kcJ2R6T1Zd56rlFwK2uLz59zmF
         g85vxhqYtmum8MfwfjSXbEvjcP9ZX9AX24sB5Djpy8Km9RNRZIh5iOrGasYFcTQYe0yf
         SykCQFZ75MTenQMYZCztdPhfZ5X+ZOI5XHuSFWayQOhxukwFYrxDd6HSrOlb3is3BXwC
         PLrg==
X-Forwarded-Encrypted: i=1; AJvYcCX+gT9UJ3leuabENrWwdGMAnxzLaape8+6KLyxrZyYLuE3PPnEqoEci6FY2AFlN3VmyP1xmI96rL+5mJJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1vX4OsGYCGVZdfeKvWpV+gXd0z/OfTdwnfgWsXea2CeIcMsd
	uPdjO5djHLRhoGT6sUAp/2c88nPVa8fZXPWhg8Fp1MdYfgRve8U2gqVb
X-Gm-Gg: ASbGncuCmQtuFS5bt39xtLJDD+uCc6ozhoOauqD1EqdlRMCi8+sH5yxicWR0sm0DQLY
	yyyPXRKa4fK94u9JlIdbgWglIVSh2tjpgHOhQ5VLXX9yaN7LHeVQMMqsjtwf8TIJUeehFHrxfae
	xMzJ7lwGfpSkrCW+ozJXkycSPBrQ+R/TYrikoIdWB32aektSEB+8mF/TM+WB+hiwnxtQ95rH2L/
	inoNa/KMWr9D2lq8hMURq9Aaayr74rI+nLfiN0evJuq4EtbqEzFcDzny9qlZjQ8L/GQigq6eoAc
	ehhyFBHfH2E3GVVBvifcO5MYvVXpNBpDiCyT+FzQFVjRq2FdJUx31037t224NleavPZcd1l8iO/
	N8rA7dzVv3JscHVoW7DLagsFzAp/9Lpc+
X-Google-Smtp-Source: AGHT+IHZlFODryvhCu0CCG3gt/BlBaQ8kwhswBlExrCAJNPYed+bNEQkB+8BqmYf3YVynM8ofoZtGQ==
X-Received: by 2002:a05:6000:2910:b0:3ee:1296:d9e6 with SMTP id ffacd0b85a97d-40e4a70cd17mr530669f8f.61.1758731674953;
        Wed, 24 Sep 2025 09:34:34 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf53cesm30967913f8f.59.2025.09.24.09.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:34:34 -0700 (PDT)
Message-ID: <9c4bffd48ae568c568352d9a8412531915ff2119.camel@gmail.com>
Subject: Re: [PATCH] i3c: fix big-endian FIFO transfers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Alexandre Belloni	
 <alexandre.belloni@bootlin.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Jorge Marques
 <jorge.marques@analog.com>, Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Manikanta Guntupalli
	 <manikanta.guntupalli@amd.com>, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 17:35:02 +0100
In-Reply-To: <20250924150303.3601429-1-arnd@kernel.org>
References: <20250924150303.3601429-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 17:02 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Short MMIO transfers that are not a multiple of four bytes in size need
> a special case for the final bytes, however the existing implementation
> is not endian-safe and introduces an incorrect byteswap on big-endian
> kernels.
>=20
> This usually does not cause problems because most systems are
> little-endian and most transfers are multiple of four bytes long, but
> still needs to be fixed to avoid the extra byteswap.
>=20
> Change the special case for both i3c_writel_fifo() and i3c_readl_fifo()
> to use non-byteswapping writesl() and readsl() with a single element
> instead of the byteswapping writel()/readl() that are meant for individua=
l
> MMIO registers.
>=20
> The earlier versions in the dw-i3c and i3c-master-cdns had a correct
> implementation, but the generic version that was recently added broke it.
>=20
> Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and
> i3c_writel_fifo()")
> Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This was a recent regression, the version in 6.16 still works,
> but 6.17-rc is broken.
> ---
> =C2=A0drivers/i3c/internals.h | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 0d857cc68cc5..0f8a25cb71e7 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -38,7 +38,7 @@ static inline void i3c_writel_fifo(void __iomem *addr, =
const
> void *buf,
> =C2=A0		u32 tmp =3D 0;
> =C2=A0
> =C2=A0		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> -		writel(tmp, addr);
> +		writesl(addr, &buf, 1);

Didn't you meant writesl(addr, &tmp, 1)?

- Nuno S=C3=A1

> =C2=A0	}
> =C2=A0}
> =C2=A0
> @@ -55,7 +55,7 @@ static inline void i3c_readl_fifo(const void __iomem *a=
ddr,
> void *buf,
> =C2=A0	if (nbytes & 3) {
> =C2=A0		u32 tmp;
> =C2=A0
> -		tmp =3D readl(addr);
> +		readsl(addr, &tmp, 1);
> =C2=A0		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
> =C2=A0	}
> =C2=A0}
> --=20
> 2.39.5
>=20

