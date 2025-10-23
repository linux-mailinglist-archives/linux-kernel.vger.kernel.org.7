Return-Path: <linux-kernel+bounces-867793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B5C03828
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F303B334B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D9D246781;
	Thu, 23 Oct 2025 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZbKdB97"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752B239E97
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254331; cv=none; b=MSCmRDVqaOlEmFv5YVyE456z31FLWv7Ru6CRCYmg5P56R2NVO1LLsYJvxR1QYSSilqOFiQUHAgyj/sA0vEqfQBuSzTV9G1j37nN0dKZ1LC+wy7t+yVJHhfvanqTgBIaxMpik09leyg03C2oav3NKBlI8mJUJEOFrNYROxD2pXBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254331; c=relaxed/simple;
	bh=zqdMx4BWZftJP4zcBY1Z5+B4QE2/WdMi8WQpGousUlE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTPcwVOaCub4QGAmtDgi3PfDTclIn3Bk9Q9wAEVDa7pSkCl6Dhcoo+Mn++17og0teRhqNP1Sy6WKFyxHM955moG5SH91fuHg2diLkxyF2GwhmCIo6harR4swPE6ZJ37x8VjzlWPaOh6IKCgZsUQvaTYc3hh397awQdKTR45JzRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZbKdB97; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3c2db014easo290222766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254325; x=1761859125; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zqdMx4BWZftJP4zcBY1Z5+B4QE2/WdMi8WQpGousUlE=;
        b=LZbKdB9782hnt5yuzxvL/FP5J+lrBGenS+LYB67OCB+nbkrzAnRVPaxwcmNzTescW+
         GBsN18jvvXO1lvL39X83B4T3wDVKP29wKXkPpnuMpw1BOBf2az47MLQe0Bi+Wyj0vQfN
         sDYq/XsbyLo9IM0Jo4eSf0N1qdZc0uyWMLEt5eeQFdU10n+mtb0BMi71TFiSpQrpVowC
         6QuZWhLB+/xWf7nIf8fwedNtSMhc5fF4tSh1N+NillFo+BBPFPOjZeX19niDp1KdrBxc
         qOeL21sqHDYJAOzF1H7AnaQzRdHzsvapJgU1voOoyKU3uLKf2E7yaeyGWvMXM45offQg
         iZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254325; x=1761859125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqdMx4BWZftJP4zcBY1Z5+B4QE2/WdMi8WQpGousUlE=;
        b=RM2ZFW942RJUh0/LVdAaEI1+Sa86todmsR6A9xz2CobTT6b+lJI40nnGccpyfYurTt
         cbEKBELTuNn6b6gDE4ANMw3CIrf0pKT1sWC38Sbyhz2bm34IqCmbnh7tqSdpoWHldiPN
         b4oBNyLhAgtJQW5k/AdNfoxZ7HSWIw9UNk1ZUkYnaezGp3TDJrsBEEtSHobjNrnd+9ze
         VvL4ZYrh0zUCr2bid2sU3N7X8n1G/BcYAFluIoBwL1BZK5hpFLFrTWagdLC6McLo0JIS
         hsLIUNrXYmYTu0/9gPY17LzSkb8bDrf/kd0MXhZ35YCgmngZBGFsStnRxL7qpnOZzZ9C
         vYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVFhCvJUlqSGtoiPq0a0CT6IOTANoQkp3MpOyUgB0TGaJwPj350iL5WiNuTQD7WvTrFGg2qv6Zb+434W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzedaoM+EjkhI//LZb3+JG4M2sdpODaaGYxJexMYoJ6rsp5zWuf
	JgfWSDTqkfsozPxe2z1hZ53WOJOcPzl334TP+SMWogrez/u4aRlEjOtN
X-Gm-Gg: ASbGncuM4Vfhvo3aLEEeLrsTvU5D2mMHfhZDZLthYuAhiiivouHvyFBPyunc6cmdqQL
	WRi+Ab5ngFgiPTbafB24eSho6ct5NgjVUlgPfvwunQd0zr1YnDLbQmiUZ3BuOVrwTshDwXoE/DY
	L1Vtm325EJ0PXdFfeIHEnUJORDt1Vu5yDa6dhfmYUb6hf0XXiew6E5tpnEAoPjKO4ueaKektGJj
	tVGZ6YRT99uS+Yz4zRQ2RQUhc4Z6pRDcv2WMIpXMk3hIZmYg/zpxr0WpLaL1D6lyLXDLhb7V6iN
	pUiOmbi1GP8csP7Lpp1ddg6jchaB7gCEey1zTiEAJK3WqFoTpVIbGt+QsOOYIujYtslE5Hd4Cw6
	wxPMc0MaGNMTJcz4GaiUMfpmC49BBuMoJqNsr8j3eAVJVE8GuNSQNmikT7c0uNLSP7j6wASwCOn
	Kfr/uxNF2t/dV89SSZvqu6hgxdS2NCE4M4eAXkpznzBaPZTAlqHdfEstwxAQBQqcnX4k2sKyLlJ
	gnFhw==
X-Google-Smtp-Source: AGHT+IHwxspN3hm1IKB4H9V+c3IpDHqztSqky8Q11VvJkuMeM6pHmJx5hJJAnadnKwijqWeRSs5KTw==
X-Received: by 2002:a17:907:9415:b0:b6d:2d0b:1ec2 with SMTP id a640c23a62f3a-b6d51c3132amr473461566b.54.1761254324927;
        Thu, 23 Oct 2025 14:18:44 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144ece8sm310786266b.68.2025.10.23.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:18:44 -0700 (PDT)
Message-ID: <cd436879784d6843a32c12abff9f9a60d4c6da93.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] riscv: dts: sophgo: Add syscon node for cv18xx
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Longbin Li <looong.bin@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang	 <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@gmail.com>, Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Thomas Bonnefille	 <thomas.bonnefille@bootlin.com>, Ze
 Huang <huangze@whut.edu.cn>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date: Thu, 23 Oct 2025 23:18:43 +0200
In-Reply-To: <20251020083838.67522-3-looong.bin@gmail.com>
References: <20251020083838.67522-1-looong.bin@gmail.com>
	 <20251020083838.67522-3-looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Longbin,

On Mon, 2025-10-20 at 16:38 +0800, Longbin Li wrote:
> Add top syscon node and all subdevice nodes for cv18xx series SoC.
>=20
> Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>

Successfully tested in host mode on Milk-V Duo Module 01 EVB:

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
(please don't forget to take this tag into your v4 if it still will apply)

> ---
> =C2=A0arch/riscv/boot/dts/sophgo/cv180x.dtsi | 26 +++++++++++++++++++++++=
+++
> =C2=A01 file changed, 26 insertions(+)

--=20
Alexander Sverdlin.

