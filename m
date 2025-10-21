Return-Path: <linux-kernel+bounces-862086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDB4BF4660
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2B04EB054
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04EA262FEC;
	Tue, 21 Oct 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="UoTwRGn+"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E9221275;
	Tue, 21 Oct 2025 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015012; cv=none; b=YWspUQBhmx6EnbtFv6F46QgGqd+Awul3je9tMoXOqi4X1JKy8PcC1WdgUSQ7rDbS6WPJ567aNyqhZKcIpy7bfBYZtRisBXWo9bau7NgEKM9Ht6aietagODHAYB8tzcDcG1jOYlcVheDphn2NFhQ4tqcLuONT2kjsK+1edG23Cpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015012; c=relaxed/simple;
	bh=nhNdircZuLH3WnRSMnhGprZ/QhVVDQhhTz+6q9e+fkk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=qIXk3W11j9vG+bhp81fDMRvKpz2YGdM8FO7Ir7nYELq3Hu6j/OuL38oTWgagPI2HLLLIyqrn7mzZoI9CpBOAKcQlBDOtS35Pl0MJOybUlPcYj560NUixz+RUP6Mdj2HER6Z5EUOmdKa05phHLUJi1B5wOjGBodogk6fJ+v3vCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=UoTwRGn+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1761014996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVzODfmk6H1SoQuvDEeFLaGz/W/MVo+M1LBQXK4SPTk=;
	b=UoTwRGn+sP6zXjeZ2ck4HhCVJrJqJ7WBFDD7a0zPnLfDoRN2TG3196DmPQKhLksTala5xG
	FEdfbvfIURGDDlMroJAl1JTHgdjginNfkCAvHQro71/mIIt3KGJrWMfrTg/v5nEchDOfm+
	KwI/NAHfEeEemwojp81ViysN3hmUTKekIRfwpT5KdXedbIpaOTns18K5ALywmVdg6mmq7+
	j1egp/yaadtUyYAtR5kE0s58Jdx945OSj6Uj20k250o/jHT9BceLDT4J+u60fiXHdshmxn
	xp/zDrjh23r5BHN3tzbJotImssnG3MSj9M84nvLhb7SzEsP3tjWu/WQp+LueHw==
Date: Tue, 21 Oct 2025 02:49:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Paul Sajna" <sajattack@postmarketos.org>
Message-ID: <789a2ffa637842215084a39eeee94993a315ccbe@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Define guard pages within the
 rmtfs region
To: david@ixit.cz, "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, "David
 Heidelberg" <david@ixit.cz>
In-Reply-To: <20251020-sdm845-use-guard-pages-v1-1-64d714f8bd73@ixit.cz>
References: <20251020-sdm845-use-guard-pages-v1-1-64d714f8bd73@ixit.cz>
X-Migadu-Flow: FLOW_OUT

October 20, 2025 at 9:12 PM, "David Heidelberg via B4 Relay" <devnull+dav=
id.ixit.cz@kernel.org mailto:devnull+david.ixit.cz@kernel.org?to=3D%22Dav=
id%20Heidelberg%20via%20B4%20Relay%22%20%3Cdevnull%2Bdavid.ixit.cz%40kern=
el.org%3E > wrote:


>=20
>=20From: David Heidelberg <david@ixit.cz>
>=20
>=20Use qcom,use-guard-pages property instead of polluting device-tree wi=
th
> lower and upper rmtfs guard nodes.
>=20
>=20No functional change intended.
>=20
>=20cosmetic: set name the node rmtfs-region.
>=20
>=20Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Tested on OnePlus 6T.
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 17 +++--------------
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 18 +++----------=
-----
>  2 files changed, 6 insertions(+), 29 deletions(-)
>=20
>=20diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/ar=
m64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 99dafc6716e76..83b98bad19dd2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -99,26 +99,15 @@ memory@9d400000 {
>  no-map;
>  };
>=20=20
>=20- /* rmtfs lower guard */
> - memory@f0800000 {
> - reg =3D <0 0xf0800000 0 0x1000>;
> - no-map;
> - };
> -
> - rmtfs_mem: memory@f0801000 {
> + rmtfs_mem: rmtfs-region@f0800000 {
>  compatible =3D "qcom,rmtfs-mem";
> - reg =3D <0 0xf0801000 0 0x200000>;
> + reg =3D <0 0xf0800000 0 0x202000>;
> + qcom,use-guard-pages;
>  no-map;
>=20=20
>=20 qcom,client-id =3D <1>;
>  qcom,vmid =3D <QCOM_SCM_VMID_MSS_MSA>;
>  };
> -
> - /* rmtfs upper guard */
> - memory@f0a01000 {
> - reg =3D <0 0xf0a01000 0 0x1000>;
> - no-map;
> - };
>  };
>=20=20
>=20 gpio-keys {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch=
/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index dcfffb271fcf3..61d63003fa371 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -75,32 +75,20 @@ key-vol-up {
>  };
>=20=20
>=20 reserved-memory {
> - /*
> - * The rmtfs_mem needs to be guarded due to "XPU limitations"
> - * it is otherwise possible for an allocation adjacent to the
> - * rmtfs_mem region to trigger an XPU violation, causing a crash.
> - */
> - rmtfs_lower_guard: rmtfs-lower-guard@f5b00000 {
> - no-map;
> - reg =3D <0 0xf5b00000 0 0x1000>;
> - };
>  /*
>  * The rmtfs memory region in downstream is 'dynamically allocated'
>  * but given the same address every time. Hard code it as this address =
is
>  * where the modem firmware expects it to be.
>  */
> - rmtfs_mem: rmtfs-mem@f5b01000 {
> + rmtfs_mem: rmtfs-region@f5b00000 {
>  compatible =3D "qcom,rmtfs-mem";
> - reg =3D <0 0xf5b01000 0 0x200000>;
> + reg =3D <0 0xf5b00000 0 0x202000>;
> + qcom,use-guard-pages;
>  no-map;
>=20=20
>=20 qcom,client-id =3D <1>;
>  qcom,vmid =3D <QCOM_SCM_VMID_MSS_MSA>;
>  };
> - rmtfs_upper_guard: rmtfs-upper-guard@f5d01000 {
> - no-map;
> - reg =3D <0 0xf5d01000 0 0x1000>;
> - };
>=20=20
>=20 /*
>  * It seems like reserving the old rmtfs_mem region is also needed to p=
revent
>=20
>=20---
> base-commit: 606da5bb165594c052ee11de79bf05bc38bc1aa6
> change-id: 20251020-sdm845-use-guard-pages-9c2b2fa0b71e
>=20
>=20Best regards,
> --=20
>=20David Heidelberg <david@ixit.cz>
>

I tried something similar before and didn't have much luck with it. I'll =
test your patch when I have time.

