Return-Path: <linux-kernel+bounces-878995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBCC21EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86FB3A43DA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D32F2E2663;
	Thu, 30 Oct 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7qfsxbO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2E2E7198
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852282; cv=none; b=UBAWcDQFohIgBY4BcUIPl1/8Vmd1SrpMt85vGUnXK43UaEPCbTfA/JE2wqvAc9pVepvE3xcsF1fGtVOl5qkRO30/o+QC7qkrqCq6uaQ7OAsD5W0s0FQJonPZFLHR6mn6lvcQvIgzI9e1AsLB5mdKWo0FEKArzEjPIIBSBfB7EIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852282; c=relaxed/simple;
	bh=ElrXgu5/6xmif6tI7ecktlmvL8AO7hOZe+lhNKfz7Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nkt8iXcqs5gArsWAmrpF/4eEQo7pXuAT0dZedebyqay3DpnqkPeW8xeSyrReMg+C/hxK5ltiRKJmti+LMKmQmuBmvWU56w3rZKNjCvY3XCgOwYSUb1CtILOiH0VrMvFy4byCrd0oP/DS77QVav1nqL8fR/cSmJhUiFZQCLfhQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7qfsxbO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso245169966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761852279; x=1762457079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzCB8jIK8FF50evWPCp3i6KvsKUySMbzRnMGfOqE7VU=;
        b=B7qfsxbOlRmXNS+NAYWCKiuuUwDiaBm5u0bIsx05QP/t+SrapLrhI+MMw64W2AjFEJ
         6OGs6m3KougM3+imFScRH+fb6xgyefAlW4GiaQanIKfNGbNCkw7hXHOOsIWzQfet3l1j
         bm3YkYpdGYWcqmWRGSGcNYeWCaz2c5xxkydjQNxNUV42QNbjefqqn6MQWmYWLjlERFg1
         TdmSw0eCqRxR5hKN772dSZQxPH8ih98oELTY4gQLFmR2UCv3yHPAM6XFsne7tNChvSBr
         wdZry0KgIb5nlPVH3+c/MrDGmNNZDLI84f6JMuZ2TXG3nk0rn0+7iKVsFMmAZc5LyteB
         /bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761852279; x=1762457079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzCB8jIK8FF50evWPCp3i6KvsKUySMbzRnMGfOqE7VU=;
        b=shKO4zmQJuZLlW8CdJMeQVfy1nv1ESdQgjQMH9aNXHEAHd0fE5DmNPjQVinGBWoj9r
         i1ZlrrZGKOTsfOV6kWwTEZTrvcILbdBp7P54ubgxL/CM1cTbksgrGtuSKFcskPrR5KrK
         fTskRGDlSOQZ5sh2YpFxyuB15LU1DP7HbkU3+dHurYd/ifurcUAJJvRP05PFaC9otoAE
         DG+Eo0Q3svLMWUe1of8dNTtQ2jQ3a2gSBV+I1VoHN5nvCUaxGkJkYxxsLWn7uu/hQ3Zg
         bmSWv9zK0A/ZuFHkKkP7p92bm+0dkjn3j09yNKP2CGLu094MvtWuXHpRslncXBmaTbuJ
         AiVA==
X-Forwarded-Encrypted: i=1; AJvYcCUMjHdjwbNVYyIS7cUDpowINOfZpnMpwaUGo1f3p7XTHNakwjH5o9OiwM76wfCfZEm3r/pOevuVQKbJiw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGhw9oOFYtPk0I7SAjivjo9g+ljZkHV/eI3CHmIwwVcs2jCMxl
	kCK7NQ2dgVZWuOsif/ZXiS2+MlVscXqlpsYDLFO8uttRW8Dz/mmEoVtT
X-Gm-Gg: ASbGncsAFt1MCRypPX0HVnV9Ai9zPAamqwtLnanPm9TXHRCITa0stF6gUUJwgJk+5w7
	W0Q/13+lV9U9XcutYnFq+eHb/z7xZASFJIZeLTSwz7HtuWzGtOkq5VtnBNWcp/E8VJG0uqfFP5L
	kapAlQi/2YxzXxGEnHUfrXgBeI31w3UROek60C/Dr7Uz8UBM8/y1XQgvLw+qtE1yNU1QPqk2X50
	50Armrvykxp3TabGGDO02iU94xVmOc0JYhYvusgPp/qDQ9xNGaxJj1Y1KgLI4nQSnnY5BVXK/M/
	EVyeNNmfi6dG2iyr7r7NEyfuRl/FSBV/+2Tk2uG5n+9WdBWqhmOrUOqa9w6yJyIxjgcoJXBlW0K
	ygLP9WdEDL+sjHicblOnw6OVqDto29ls4NPqBUv+Z+2h59mFQQX5CXvF4PgAl7SawC1VD5UaAeo
	WqSlxrIrISBD9oeVrTbclTIvH3oWeao5woBljIMOz/sC8p+D2Vo/GJU4evdo8Fk3DRr88nX+uDU
	g==
X-Google-Smtp-Source: AGHT+IHAE2zfsvxg+WnKGQngg9O6/M2cc0o7OkY6Hhcq5Dlt181nXlixhzrIiYnYnVNrtbX+aXzOuA==
X-Received: by 2002:a17:906:fe41:b0:b3d:73e1:d809 with SMTP id a640c23a62f3a-b707061fd71mr80792866b.48.1761852278602;
        Thu, 30 Oct 2025 12:24:38 -0700 (PDT)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85445e81sm1827260866b.64.2025.10.30.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 12:24:37 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:24:35 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Sheetal ." <sheetal@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH V2 4/4] arm64: tegra: Add tegra264 audio support
Message-ID: <zxcety2tqsv6p5p2rqaa3e4un44m2loo4zm5goeansuf5zdly6@jqeg2hm5rmcz>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
 <20250929105930.1767294-5-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="istw733rho4drg3w"
Content-Disposition: inline
In-Reply-To: <20250929105930.1767294-5-sheetal@nvidia.com>


--istw733rho4drg3w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 4/4] arm64: tegra: Add tegra264 audio support
MIME-Version: 1.0

On Mon, Sep 29, 2025 at 04:29:30PM +0530, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
>=20
> - Add the audio devices for the tegra264 SoC in the tegra264.dtsi file,
>   which includes sound, HDA and APE(Audio Processing Engine) subsystem
>   nodes.
>   APE subsystem includes,
>    - I/O interfaces such as I2S, DMIC and DSPK (all the available
>      instances).
>    - HW accelerators such as ASRC, OPE, MVC, SFC, AMX, ADX and Mixer (all
>      the available instances).
>    - ADMA controller and Interrupt controllers.
>=20
> - Enable the audio nodes in tegra264-p3971.dtsi platform DT file.
>=20
> Signed-off-by: sheetal <sheetal@nvidia.com>
> ---
>  .../arm64/boot/dts/nvidia/tegra264-p3971.dtsi |  106 +
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 3190 +++++++++++++++++
>  2 files changed, 3296 insertions(+)

Applied, thanks.

Thierry

--istw733rho4drg3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkDu3MACgkQ3SOs138+
s6H7xg//eVts+nMHcP4RRSRZowrB9Hev9Ui98kXJyEnnlm0YVJ1AYLz7kUIHXMVk
gwdifz6s85sfO+nufj469hlCm877zZwW+gO2gTwF3t7hh0mZ6tRVT0qqgI9phsM9
IkBFhAlmqFZeznEUhYQ0RktdN1h0RW0nWhG7fzyUMLS9RltTMHCDgbl8ckXoTLBn
9i1coz/Zm3puDLiPDE/LsmASeYXhtaB5bbkNLlbdN7yrrWOSEJMXTFbllErAv37b
Ycaa7gyZJviyjOO0/245sg4QO+PHcPFdBbxtV4CaON96uSdlIWqAcQUZKUvAKPMO
4OJ2pKTo7VIMzvXmkcqpbPWySOrFj2sfLTb3jQX+W7KTv2R9n9HxkANbJ0rQn7+z
rr4xzQFVfsTd2LP6Mr84wStmyDdlXF9+kwVnH/F7tKT3ZAj3bL93Q77W1tPduHwz
qlRLtQgCVX0KuTb7Tezs1IXbxgaetulHzWRa8ayIYhb9gNf7gZi3C0PUSPP7BtWF
p7cMVV7yq0bqRZ2q+PanKUvNUzNS4zJJoAuMHGtXdR6pedUq+T3SHoqdmxmRo2bO
5gTYoHd18rOs2+43CqRmgfHmqm+Ei4k4pJSVmIIQMKGbzHvn2Y3uPgugI4GUPP2P
KxhijmcU+KzqlklSQ/xNrTdLYyoLiOWdCi/AFzSbRoc0TsfT+oU=
=sxTn
-----END PGP SIGNATURE-----

--istw733rho4drg3w--

