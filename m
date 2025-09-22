Return-Path: <linux-kernel+bounces-826765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373AB8F495
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8773AE2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936852F5302;
	Mon, 22 Sep 2025 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdgKRW2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D52F2908;
	Mon, 22 Sep 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525922; cv=none; b=Oyrc3cqv3v1kC/gcyvev3gI/pg0FVgwh85BlVHQ/q3BjAXYz9kSAGXhNe0RYWsj4WtqlP74Vtz3HRmGGLKRoeQ1uppVdPQCRRE+jQo5SBaCHbgo/mQ7+8vwE93+iVKup+GqZUPbBt15A/2tBxCEzE8p4HU0oU9H7sMTuk2Eakd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525922; c=relaxed/simple;
	bh=bNTfL5I1HrJwgg3RyucnAg9Ny8UlD82CDsINuJPuY4A=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=ZYRUjgyZdOVLjZyXxO24UsTpj1EXoU3TmRLCJWiWVkvdGk5rAgt7vKNzOEzEq92vnT0Bk8cfcu8fLO/FLPll38y2pKVKBCtaXsDAT09cgKT1eGEDzxjWu4wONoSyDSIruAApwlS8/dGTF+AZimd6a7IyLKBsrALv8IaVuvC1WBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdgKRW2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C390C4CEF0;
	Mon, 22 Sep 2025 07:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758525920;
	bh=bNTfL5I1HrJwgg3RyucnAg9Ny8UlD82CDsINuJPuY4A=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=SdgKRW2IVYV/lYDUogSBPykH4MHszba5CItDyw9gRgpyMnwwTCxXa3jZ3HtZvXwXe
	 /vKehzFEdN7eV6vYCwpmA6iWDc4YEZEsdMiW3k2xZ3UVNHVbjnH5OHUWa44z0DWpuW
	 pZ9iqV3JNI6BYDfrk6it6Wo8b8QkJDziYWCXCvS/OcqgUgAxaXqY4ugZ5ofQ2YrJil
	 ItSxi9QAZtemn4QyX/RdQVo+rZ76fvXBCkLsTeq9ZwwyR0jSOAfvPKZf5UHQI9ZFLt
	 7nAHrZbq1yZyaISv/tndXRg24jCZp1jeWaNy7nUrTMEl5SW4blj/8QTb4mk2y8Rzh9
	 FoVqGJH6uOovQ==
Content-Type: multipart/signed;
 boundary=c997b55b19e805b8d77f671d41ea0560a0177cf2f91277c718c4bd2d2ff8;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 22 Sep 2025 09:25:16 +0200
Message-Id: <DCZ5ETIF2Z99.39M5HLYLNMX44@kernel.org>
Cc: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <detheridge@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: <rs@ti.com>, <afd@ti.com>, <conor+dt@kernel.org>,
 <frank.binns@imgtec.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
 <matt.coster@imgtec.com>, <nm@ti.com>, <robh@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p: Fix memory ranges for GPU
X-Mailer: aerc 0.16.0
References: <20250919193341.707660-2-rs@ti.com>
In-Reply-To: <20250919193341.707660-2-rs@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--c997b55b19e805b8d77f671d41ea0560a0177cf2f91277c718c4bd2d2ff8
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> Update the memory region listed in the k3-am62p.dtsi for the BXS-4-64
> GPU to match the Main Memory Map described in the TRM [1].
>
> [1] https://www.ti.com/lit/ug/spruj83b/spruj83b.pdf
>
> Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>
> Requirement for the following series:
> https://lore.kernel.org/all/20250915143440.2362812-1-mwalle@kernel.org/

On a am62p. am67a/j722s works fine.

>  arch/arm64/boot/dts/ti/k3-am62p.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/t=
i/k3-am62p.dtsi
> index 75a15c368c11..dd24c40c7965 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> @@ -59,7 +59,7 @@ cbass_main: bus@f0000 {
>  			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripher=
al window */
>  			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
>  			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second periphe=
ral window */
> -			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
> +			 <0x00 0x0fd80000 0x00 0x0fd80000 0x00 0x00080000>, /* GPU */
>  			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripher=
al window */
>  			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
>  			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */

Given the fact that the GPU node is in the shared
k3-am62p-j722s-common-main.dtsi:

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

--c997b55b19e805b8d77f671d41ea0560a0177cf2f91277c718c4bd2d2ff8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaND53RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jFAgF+PRlVCLYRS7Z0WBq8MkC/8ZmN0RukErWq
OLIEtPIP2HDzCjlfuNJy65XicaYdlNNRAYCLD6F0UYmahHelXHb5Ogh9DeW75zXx
CKsxLOTz+GKkE4PClxcfbsUQWqVCAqtqs04=
=4KGH
-----END PGP SIGNATURE-----

--c997b55b19e805b8d77f671d41ea0560a0177cf2f91277c718c4bd2d2ff8--

