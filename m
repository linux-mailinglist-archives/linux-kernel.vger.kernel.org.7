Return-Path: <linux-kernel+bounces-870520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42885C0B07E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BC18349060
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822742EF66A;
	Sun, 26 Oct 2025 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="Xu7AezbX"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A5253950
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761504295; cv=none; b=mUUdzv4rOZX4NkPrT8orJC2zwa1zHvAQYKmuAnpy2+DBSS/0MIz9rENzE7n4845QEOPVtr5GMPj+jYjrdBQOfsxAm3Y5UOp4+j7JZBD/EqjPDIkSoJwzOx1vX0J1FpHhQaqNmT42J4jV3bQlnWiSMUm3AJjGkQlfZi49vWFfQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761504295; c=relaxed/simple;
	bh=+y8KHncls3OAOqDaFkj5gilK4idEaoPHp5VamyBZOns=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gvUKTFdJio0HXTz2GZK95yY3RDC5DBPSc/minWkUSQIOLKSt4LwUtLgY+8MTKPsQ8btTrmQvl+zUMSNG6OkVWvpr+Ig9bpNCOpgXLMI327kSX69iDv39LWw0WTB9XuhS9+K7fTmU5iy/8MT/95Y2iSrsnIyLJX9mHsMIMjPBotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=Xu7AezbX; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1761504290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XoP33HamohJnYpgEMOOVXkOdMXK2Wj7iOxwWmiRyjA=;
	b=Xu7AezbXj9uqu7+8ZLk5xs1budthm6Tf5t9XogPUBoroeIZZR1h/G+9rdfNJ8Xig4w28K7
	gPD0TnSaKwr90otHjpM6vEpYkhJy1vI8qx6gkVfrEgpiJc4LItyLMgZkP2tcRHROsqLx8u
	LY95EHxK2aJnHc7Fqr36DzEspOnO3QV+cY0tVkC+DWK/NNXHUSpfAVm5cemsgu1JGp67Zb
	dgfEN2OBKCNW6Afk3pK0kcTOiI5KOtrjS7waaQnZWHYHQrdVZchK2EA5Q8I4ZlzUR4yPG1
	ltUHntWkA8gv38x4oGWo5AwdxHnBCt4CR4iVOeIhpsnyvHjUhcz5vkz08vJRbQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Oct 2025 19:44:34 +0100
Message-Id: <DDSH5G4FVB5F.BK0F7WNGG6S@cknow-tech.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Dragan Simic" <dsimic@manjaro.org>, "Diederik de Haas"
 <diederik@cknow-tech.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Johan Jonker" <jbx6244@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix vccio4-supply on
 rk3566-pinetab2
References: <20251026172608.108956-1-diederik@cknow-tech.com>
 <e2caefd1-9668-0404-598f-98b26375525c@manjaro.org>
In-Reply-To: <e2caefd1-9668-0404-598f-98b26375525c@manjaro.org>
X-Migadu-Flow: FLOW_OUT

Hi,

On Sun Oct 26, 2025 at 6:36 PM CET, Dragan Simic wrote:
> On Sunday, October 26, 2025 18:25 CET, Diederik de Haas <diederik@cknow-t=
ech.com> wrote:
>> Page 13 of the PineTab2 v2 schematic dd 20230417 shows VCCIO4's power
>> source is VCCIO_WL. Page 19 shows that VCCIO_WL is connected to
>> VCCA1V8_PMU, so fix the PineTab2 dtsi to reflect that.
>>=20
>> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
>
> Thanks for this patch.  As already discussed in private, this is
> correct and safe to do, because both supplies are designated as
> always-on, so please feel free to include:
>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Thanks :-)

> Though, I think this cleanup should also be propagated into the
> stable kernels.  Right now this patch doesn't actually introduce
> any functional changes, but maybe in the future there will be
> some related driver or DT changes or improvements that may end up
> relying on DT correction such as this one.

Fair point. Dunno if b4 picks this up automatically ...

Fixes: 1b7e19448f8f ("arm64: dts: rockchip: Add devicetree for Pine64 PineT=
ab2")

Cheers,
  Diederik

>> ---
>>  arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3566-pinetab2.dtsi
>> index d0e38412d56a..08bf40de17ea 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
>> @@ -789,7 +789,7 @@ &pmu_io_domains {
>>  	vccio1-supply =3D <&vccio_acodec>;
>>  	vccio2-supply =3D <&vcc_1v8>;
>>  	vccio3-supply =3D <&vccio_sd>;
>> -	vccio4-supply =3D <&vcc_1v8>;
>> +	vccio4-supply =3D <&vcca1v8_pmu>;
>>  	vccio5-supply =3D <&vcc_1v8>;
>>  	vccio6-supply =3D <&vcc1v8_dvp>;
>>  	vccio7-supply =3D <&vcc_3v3>;


