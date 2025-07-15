Return-Path: <linux-kernel+bounces-732588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17BB0692B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11625674A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF82C08DD;
	Tue, 15 Jul 2025 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of8lTmrQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E672253FE;
	Tue, 15 Jul 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617834; cv=none; b=hf+eLQ5ZF6tdQn9tBfNG42Xuw6yRtn/+Jb2sQlXEusvtjJiBWNJZuvtBbgfosO7Iddn/iBYLmB/ckTiBAJa8680MylbiJsDfD5qsZtyXNu6pMjlBv8ifEWl77MagWRolr+etfJZkcg+zzIlwud3egAYKyTPFOr2sgH6r6Jx0OiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617834; c=relaxed/simple;
	bh=pBasewOutybSgPeTnnFJ9TF1ZtaNHDhit9tLEZUO1C8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVstmZ8s2DPC0rxJ4w41av78DmDjXlL2P/zxIkhYhx6PrxH+WvkEXNztkZazhTamuSMQgn38gyAZR7WO1zJkXoSCKvPLSOURWe+RPo4ej+4ACSS6F1nASv7YPQ12/zIGhRLxCCElfZbCU1oLirbf3T1GAb6C+87AT44/avyCJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of8lTmrQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso8359595a12.0;
        Tue, 15 Jul 2025 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752617831; x=1753222631; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IlpREsArsA65Wjnvz7fR13JpUjf3JpRjm5gzm/gRDbs=;
        b=Of8lTmrQv+ktSWQtOL6D4lFxCWadtgbJeIG29aEl7hwZAuaynGQj2O3rDZQKa7IO2O
         hg0s4jrsE53c2mPwlsKxYMFk+CgFJfL2ECJhMxt1GWSxKM/wQ/UvJzz8gDtTxNy1X3/Y
         BbNi2NSLd4HRSCsvmKgusLAUu+ZX/7qCFHUxsgXBojgQD2CAnSUR+ckfQDujob8vCt9h
         72D4mnp280pt+349kkOTkXd9JXzOUm2X4c3Y99SlIhrC0C70oDlC195E/TxeKNj3xOv9
         7SOaf0R8DnUtoWngQcPV1H7Szc3JHBe13aDdpyY8QlbdS4yBjAab5OEBnFU7MLT52ESN
         ZBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617831; x=1753222631;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlpREsArsA65Wjnvz7fR13JpUjf3JpRjm5gzm/gRDbs=;
        b=n9S46nmlTXimN8jzJgFnwHaD6CB7ZWnJK49XUN+dTwsbAtKF9SWoN706kL8BMXIhca
         HZv+vlSo6g091q/nLcwNessVN8X6taV2aA8BWrA+ZiT3YIvFYu9atV24txz3Th9wIoa+
         CkMikmJF5iKoXnMD6oKJJDruUla6q4U83PkYQUAqbJdD+3OaAvDdimMPnEZJjA94Fc2K
         fvW92SvDe9+XpQq1u+VK4bCjCGGZm8D/b7L+sqy9I4GKzNWsJi2Wf+iMKa9EByOSptbV
         MycNmwMZyXLivahg1r9qrxdmgIV9+RgADhw2iBWKGNu2RGq2D6JtOjmwTq+cu+ZYUjtv
         OJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU20ljxgq6BykxAk6dHmRuwypPH7BdCPMbOqHiAo7r5nSyrQ6KZdH30VQouS/JnC0bd3KnUmCNT+qmYYco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgcNKHzfmWhvugKA0Zf0EREjagSf1Ocv7NxI1GG3aF+WqrHAw
	TVBdVthQQI6GJfDaUsBISB59JpIUJZAdp40uROR0loYXjUM10viIpcJv
X-Gm-Gg: ASbGncvtJoby0AfVNrP9JGRJnjtvUvUmglAn78o+juNZB8QlHMYH+VQ7620lPxdfgXA
	dZujECX7m9vWTj0N4w9QmR+s8USdeT4fCCpfD7bOiNqUxZtQSQVK1CQa4JY0s6/Gl6S/Wb9sFRk
	nXLoW+zLLuqrzVWXSPfOJ6qzj52q8TO2kiiEIv9KijNS2c8vuhpsNx4/nB3FiM1ph/JrZ1904eZ
	C+N/4mPeSgdMNGfxjQ4P4qjhEchKD4kBmhIjcGkguy6E2elYKKoNedJGz2vTgH4tWPeYfPRMUWi
	Df2X8AfbjQkOYZaENSxdXSO7v+3UDlwZZc21SN6Ig4vjbv2LF+KAHF/ZB/rn8X0EZtY9uKzzjMW
	z+MSXq5dSg8a5CUkfMKGtF6RBmWrn4oUM/7Ith5J/mN4=
X-Google-Smtp-Source: AGHT+IFS1FOWt2Mu8j9kFCRNXMuFJFrO5X2nsF/JgZHo3UNGWsUzJOoz0tkKgDtKz4i/peCv+xWi9w==
X-Received: by 2002:a05:6402:2756:b0:604:e33f:e5c0 with SMTP id 4fb4d7f45d1cf-61285dfbc42mr291122a12.30.1752617831067;
        Tue, 15 Jul 2025 15:17:11 -0700 (PDT)
Received: from giga-mm-11.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61274d50d06sm1084048a12.8.2025.07.15.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:17:10 -0700 (PDT)
Message-ID: <ce6c909d9d6724dd36a2b35ff19faa93b5152a0c.camel@gmail.com>
Subject: Re: [PATCH] riscv: dts: sophgo: fix mdio node name for CV180X
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang	 <unicorn_wang@outlook.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Ze Huang
 <huangze@whut.edu.cn>, Yu Yuan <yu.yuan@sjtu.edu.cn>, Thomas Bonnefille	
 <thomas.bonnefille@bootlin.com>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Yixun Lan
	 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, kernel test robot
	 <lkp@intel.com>
Date: Wed, 16 Jul 2025 00:17:07 +0200
In-Reply-To: <20250715221349.11034-1-inochiama@gmail.com>
References: <20250715221349.11034-1-inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 06:13 +0800, Inochi Amaoto wrote:
> As the mdio multipledxer is marked as mdio device, the check complains
> the mdio bus number exceed the maximum.
>=20
> Change the node name to mdio-mux to remove the following warnings:
> mdio@3009800 (mdio-mux-mmioreg): mdio@80:reg:0:0: 128 is greater than
> the maximum of 31
>=20
> Fixes: b7945143bc33 ("riscv: dts: sophgo: Add mdio multiplexer device for=
 cv18xx")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507140738.XRjv3G8i-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202507121830.POx2KDVi-lkp@i=
ntel.com/

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0arch/riscv/boot/dts/sophgo/cv180x.dtsi | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts=
/sophgo/cv180x.dtsi
> index 5f094c6085cb..27056ef70ce4 100644
> --- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> @@ -57,7 +57,7 @@ rst: reset-controller@3003000 {
> =C2=A0			#reset-cells =3D <1>;
> =C2=A0		};
>=20
> -		mdio: mdio@3009800 {
> +		mdio: mdio-mux@3009800 {
> =C2=A0			compatible =3D "mdio-mux-mmioreg", "mdio-mux";
> =C2=A0			reg =3D <0x3009800 0x4>;
> =C2=A0			#address-cells =3D <1>;

--=20
Alexander Sverdlin.

