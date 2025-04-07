Return-Path: <linux-kernel+bounces-591004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BF7A7D98F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB622176106
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8F22FF58;
	Mon,  7 Apr 2025 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sjuRosIT"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D521B6D08
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017651; cv=none; b=qXha065lYPKL7dwUZXILsRg5V3ok5lM+WM0Ypxi4/eV4q/HV2Soa83ZwxY80l1tcNXTsC/W674KOwwyQ7NlUmrYkQqiy8yfAfi8qs/+LZ6Hvfd8Zv11+IPYS69FycRf0zNJRVv7CBoAexj1NeyJkX2ly5R7mfpHrWuFS6ea/EPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017651; c=relaxed/simple;
	bh=ScdXEXK3bUhFt+Yi2JcouhlEsXjMdlf4d3ndS+JkYLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXItFMykFmyXyoXAoTYfcu2BceH0xFOYq9kjKJzexBMYcbFc88EpmzHzhIhPsOp97Z6ek9W7sDkZx5Uo2ir/H9kUyrLg6QXAf2Z7eP2Y/S/BdTvoLmuHDPJp+heGK99g1p+nNaG1/pBtSwsITb/dNFSBolTU4nRC7I1dSxg/dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sjuRosIT; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B55C13F193
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1744017647;
	bh=7GZS6uPYj8uHFMPZTZNVxCqyKS9pg06/fJF5SvkoEvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=sjuRosITQU1Q5wYPeFd2Yfi0XwcnBAQAOjdT/2JJ6iuOYAQU39g8Ky2qWQyEKozXO
	 s4HsN30HCEMdEJ+GRkyvSXpx9tGZclgJsBHhf6qiLI+INq8S0riAzlHA/6dhngjjja
	 pGurOOC4UqyrySrfwa+sPiTO09g5ORbv8+gfOShlgUkzx2QR3VeuG6NGAmSyVv3vkQ
	 q+lR/mTFPc4771JHVOcQtYqkna/0x0wPvL3CnFjoaeH1hFek+p/PAlsqpFUhKvYZiI
	 +f3hJY7ovnvzHTBOJ2apz3NdiYlMH2YMCr3W13KO46ikv4nILA+cy/thRIQszM8I97
	 hqkXOZkLWBVvQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac737973c9bso317042066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 02:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744017647; x=1744622447;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GZS6uPYj8uHFMPZTZNVxCqyKS9pg06/fJF5SvkoEvI=;
        b=A34z2HBfVv+2o5QdN8I6oT+Egql4FEFqc1NNcB3ZDpHgw0tNY2rRvYZbhXLGFLFFtD
         wOk6ZHhqTJ87stpKBtjHsgyXVdqOmX8iMts/SaR20v0lgix6afdpxRebGZ+wH3IaU0X/
         S6J/gUd/aUXnZVvrVfz6IPBwmLQalWVHd6KP10rzwWnsJVrKhvxWB+kf1b4SZCa6rgvb
         CJt7phB629qZGddPgjNPeyFfxcWzVyLxQPb9OEJZfjWiZfi1ddSPKLlmae1Vl2nHbdQZ
         3n/Ru9zGQYrgXXWmgppxyChlFgDdUx0V5U8lxSDvrRg5LHOfHtiGWgzQYd1bU6P4lOiq
         eiIg==
X-Forwarded-Encrypted: i=1; AJvYcCWQT/8xDP3D+agIu+mfCJJg2R72t+s0kTb6dfqG/d1PhOG/lvjHx/f7iBn5iSrSeykvkdJPzxUgSt+IM+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5LKuAGgCc/D4AL0dOyGXEdscjmSO3Qd+P56hwT2l/ss+STwAr
	U5y904oSfqWWGgIOrmGOQbsh/lSXoUjhWiSYl9OXeJbSUqTg/gAIc+Q1R7DZeNJzrx6vz3BYnu9
	gl6huaQuuBn7ctrOtIV75bJQDAyRLm86g8VDrwRrdIxplGz90xmHg0e0bxqT+a+OZI5+S8oi+WC
	VZ3Q==
X-Gm-Gg: ASbGncsBDRJCvgDd6w7nC1yrVuMum1oivxXTRh2l4tdChJwi801HirMRHsHT6Oo5eAv
	613uuhXm+T19suI4LgVy9Vq9pJisx2fbQTSGOC5gPe/Te1iJKzPxokhB6ZUdRjYICj3jvEM4Ymf
	9FJrpeI5kHIayxoXCPpCeMkoTFVHNLca8aEP+h/FByQnRoMDpZhsWv/FghGaPrLsj2TQJao5KaL
	0SaFDJ+hnEPsgt17Tg6GnrFQ+42cgGh6Npo7lGiBvdSfsKT7DrIEeWAAHAZ3pdNV/oXSldwCU37
	rTLiHcb6ZWo01qN/NhKmz8BfEWg+Owylo4kh9mZ1RCGWkopiHYrwDMod
X-Received: by 2002:a17:907:7214:b0:ac6:b811:e65b with SMTP id a640c23a62f3a-ac7d1821920mr1055181866b.36.1744017647228;
        Mon, 07 Apr 2025 02:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5RKNwcDAkF0pEvh7xm6VWRcXnybWvXazgwz0pvnQ6TMVJtV3bBp4BF0HHU1KK4D5FiFb2pw==
X-Received: by 2002:a17:907:7214:b0:ac6:b811:e65b with SMTP id a640c23a62f3a-ac7d1821920mr1055178966b.36.1744017646855;
        Mon, 07 Apr 2025 02:20:46 -0700 (PDT)
Received: from gollum (151-243-191-194.pool.dsl-net.ch. [194.191.243.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c5c5sm709420866b.29.2025.04.07.02.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:20:46 -0700 (PDT)
Date: Mon, 7 Apr 2025 11:20:43 +0200
From: Juerg Haefliger <juerg.haefliger@canonical.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: x1e80100-hp-omnibook-x14: Create
 and include a dtsi
Message-ID: <20250407112044.35fe4d8a@gollum>
In-Reply-To: <e326a1e8-5f2e-4b1d-bb72-64f1e32038fa@kernel.org>
References: <20250404090108.3333211-1-juerg.haefliger@canonical.com>
	<20250404090108.3333211-2-juerg.haefliger@canonical.com>
	<e326a1e8-5f2e-4b1d-bb72-64f1e32038fa@kernel.org>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2GAB8FRdlhzjw/4_=O1iMN1";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/2GAB8FRdlhzjw/4_=O1iMN1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Apr 2025 14:51:54 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 04/04/2025 11:01, Juerg Haefliger wrote:
> > Create a dtsi for the HP OmniBook so it can be reused for the HP EliteB=
ook
> > which seems to be the same HW.
> >=20
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > ---
> >  .../dts/qcom/x1e80100-hp-omnibook-x14.dts     | 1554 +---------------
> >  .../dts/qcom/x1e80100-hp-omnibook-x14.dtsi    | 1557 +++++++++++++++++
> >  2 files changed, 1558 insertions(+), 1553 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.d=
tsi =20
>=20
> Very difficult to review. This should have been rename. You are not
> using b4, so you can tweak -M/-B/-C parameters.

Not sure what that means, but OK :-)


>=20
>=20
> I also do not understand what the DTSI represents. The DTSI files should
> be some sort of common hardware, design, product. Are you sure these
> devices share the design?

Yes, pretty much.

OmniBook:  mainboard 8CBE, version 17.39
EliteBook: mainboard 8CBE, version 17.40

HWinfo from Windows looks identical. DSDT are identical except that the
EliteBook has two additional nodes \_SB_.GPU0.PBRT.RBF5 and
\_SB_.GPU0.PBRT.RBF6. Not sure what those are, maybe due to different BIOS
versions?

Using the current OmniBook dtb works with my EliteBook.

...Juerg


>=20
> Best regards,
> Krzysztof


--Sig_/2GAB8FRdlhzjw/4_=O1iMN1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmfzmOwACgkQD9OLCQum
QreiCxAAmjf9riTwqTB0eq0J5fIEHqYnd6ITtyuOHiWmS57uWKOl/R7354LDEcmm
aYUVLLoOxrPUUBBPsxQg65EF3PumDBGwNEt9m3MH3yAnRZAg8IG0XddBNx+5+Y4F
Uoz8K6kAkE7BV1jxUPlZPg9wopC0Gmk/OPVm2OnXYxyIyfdv9lrVhR9mfkQhIKho
eqgIxqAnjPXvYPpZQ0fhdw/smHpsYXnWhuCvVi9befgEIHqCQPzZXwhkCFojzEes
1dhqZY2zFL2hyL+dio4GzY+tASuik1gY/liOM081MqPfxkq5wDQWfwJEc6Kfrhm8
IXcM0KWNkWtqiRw5QNSxxLnJgsXem72BdE3mld7gzgM0F8fsZ8I0MeDGxWOV6Gr8
FMDDORlla4+/SrDLkyYxvuW7eHY1+UMGIRM1smhdjd9Oj74su8MV3kpp1hHJqLrE
Adjrb/5P/+PWvncwqLabYt1P04BawL4WE586i78HJPCnb+6PpBffqLsGGem5tuzF
/K5EuvwPTN/1tKHYjTVArG39N3RDkQ0Toik/i9M6ODwKK8+GCT0COYH7kc5bS9Mt
/22XuVH7u15Et2VuWysC9Z/ee/0xKotz0SA3WFbpH6igdRLdDwyX7fL2yiU802Oj
cNOXgCJwETZxlQSSVwDjs728jfyMJii4K+o9EcbtxDKRMMgtD5M=
=nyGV
-----END PGP SIGNATURE-----

--Sig_/2GAB8FRdlhzjw/4_=O1iMN1--

