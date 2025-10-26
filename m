Return-Path: <linux-kernel+bounces-870487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0527C0AF1A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5277C3B3347
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C3245012;
	Sun, 26 Oct 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YtCaKF0s"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6B1E570D;
	Sun, 26 Oct 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500189; cv=none; b=NsaLyPk+t9iKicnjUawtdmDlI9/GDv7CW6WXoOqbO2MpwdqgkcbHYb6D0xiW6sY0em+p5rcKKtqLLCBVC7kP20N8P186gNPB5ZSnwNjjJ3yj/8M2KmVXIvS1oRYbvT/uGRyTj3IukvtRm6M6C1WdKnUHeERPbws6f7XYyToAfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500189; c=relaxed/simple;
	bh=8hSqaZyyrUqAAlmbbLe3Y0H/3L6PJrJSV8xMkVxZ3vs=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=FdIickIUGbZlwmpSkcGeoZBBDsz/vfMq3jHZ/kiRtqzM7rEKetThPKMNbMr+4Mx22p/sEe5UI5xN66cs598XHkLixVPskTT0Acolsp6ocu9R3qFD8nduCZv0OHzkjCqARNJOx3DP9N0cQlPHsKa6Kspmv7iBkwuCX9hDkew0jTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YtCaKF0s; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 31B2940D20;
	Sun, 26 Oct 2025 18:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1761500178; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VE3zWNd8hyEKKt0aCbf0h+Pe6DuWRN17pEEkLFG58ko=;
	b=YtCaKF0sba269jXpys5kvrSjKhG607xG769thtCRBdZvKbQdg0oJpjALMKO426aPKh5idW
	9uQvEPSV2ppc49hQx6komclTXMKHoRtS09OsrSDpj4YJbzurP6/YLrYwDFpmKVAJgXezpl
	XgJjdakMca22HMHH8sJWPhhxmKVKQQwfC2Ctq9Q/pxCdMWEJzK3IPvjqB3uo+PM/rJ0PH5
	6VTppTB3ggk2xCvwo+pCOAbojoufQ5XwMEkhSHrSszjgVDzSbd3tUeGvGIP+9qxHKwFs8e
	DZ4AsMSKs1gbHmWH1Rnylg0g37CZCII2h5fRd//joHzmbJkTjRBXwPEx8tSRwQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <20251026172608.108956-1-diederik@cknow-tech.com>
Content-Type: text/plain; charset="utf-8"
References: <20251026172608.108956-1-diederik@cknow-tech.com>
Date: Sun, 26 Oct 2025 18:36:15 +0100
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Johan Jonker" <jbx6244@gmail.com>
To: "Diederik de Haas" <diederik@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e2caefd1-9668-0404-598f-98b26375525c@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= Fix vccio4-supply on rk3566-pinetab2
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Diederik,

On Sunday, October 26, 2025 18:25 CET, Diederik de Haas <diederik@cknow=
-tech.com> wrote:
> Page 13 of the PineTab2 v2 schematic dd 20230417 shows VCCIO4's power
> source is VCCIO=5FWL. Page 19 shows that VCCIO=5FWL is connected to
> VCCA1V8=5FPMU, so fix the PineTab2 dtsi to reflect that.
>=20
> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>

Thanks for this patch.  As already discussed in private, this is
correct and safe to do, because both supplies are designated as
always-on, so please feel free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Though, I think this cleanup should also be propagated into the
stable kernels.  Right now this patch doesn't actually introduce
any functional changes, but maybe in the future there will be
some related driver or DT changes or improvements that may end up
relying on DT correction such as this one.

> ---
>  arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch=
/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> index d0e38412d56a..08bf40de17ea 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> @@ -789,7 +789,7 @@ &pmu=5Fio=5Fdomains {
>  	vccio1-supply =3D <&vccio=5Facodec>;
>  	vccio2-supply =3D <&vcc=5F1v8>;
>  	vccio3-supply =3D <&vccio=5Fsd>;
> -	vccio4-supply =3D <&vcc=5F1v8>;
> +	vccio4-supply =3D <&vcca1v8=5Fpmu>;
>  	vccio5-supply =3D <&vcc=5F1v8>;
>  	vccio6-supply =3D <&vcc1v8=5Fdvp>;
>  	vccio7-supply =3D <&vcc=5F3v3>;


