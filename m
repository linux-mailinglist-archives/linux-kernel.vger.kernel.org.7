Return-Path: <linux-kernel+bounces-804277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4124EB46FD8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39A73BAB37
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFD2F1FF5;
	Sat,  6 Sep 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="F6w2aN5I"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BD2F1FD5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757167100; cv=none; b=RNlSJ9Uu/1WoDtC5ooS8E1mo1pfEnDwtPqkJ+gYErJQFyCr09o0sRpzZ2Maor6Zbz8qlT8LMqRj/02P7euB+m6IGk58QLcpTIzzMnJMYB2Lp/cpmcVyFUfVvNVici1caZKjRD3YC+rA6v+4Hf8OAj+q5uj3a6DHXeocLUdN28mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757167100; c=relaxed/simple;
	bh=EaZnNw6mPYoDqOyuo6IqF3m0V6XYT663XFf3xX/yYGM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=poAFSvvYqGuxhhBAGHKKI/05LAHAaVrv9goxgtc4I10/Oij+AbYc1C8JmQxiLxOp6r6v/m20xuRQsPIVqoYg54I0NPyDkFmmhPwcIid0WWyDxj59varhAulRsNLyf81uJXc4RpYdnG6NejFppdDCROVdBGJBX//aC9PE/sb1UGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=F6w2aN5I; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1757167085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XL9HIJO3UGo5wyNjZG9W2dDyTd3zOWpByElnpm1c1Y=;
	b=F6w2aN5IOUHo91/K1jt/wOXJfr/PMEdWIGwoITPTiw+jwqaCSgnBV9BQs6GyT7xLKcUuI7
	yZGYXtSNBSFs62GiylNXChPHb6MWLG5KDSTsR6G5iWCfd0X5JGptu9qJ5ped+2wgKTgdZc
	pysWSw0Nad9+HUTNutrywXHTEZy9MLEkyEsxuPWTxRQyQQUibV5pNyEReqaodtOo2HkOP9
	1DmU/D8elEgK28LaxIt6XKh8gg8erTYt2Vp9wqXBQxt7CfowyKVjtApaBvwKAS5x4ysJ8v
	fNupDxM6iHIR3RrCUO4rk6JJMknJfXLU+k4O3fwpJxwiSKxhkNnRs5++6nG1Mw==
Content-Type: multipart/signed;
 boundary=7bb96b1748a067e53456e99e209bf191ed42469d49852d8d3d12a1592bb7;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 06 Sep 2025 15:57:55 +0200
Message-Id: <DCLRQQH0F49Q.2OUP59P4VV91O@cknow.org>
Cc: <heiko@sntech.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: rk3368: add CLK_I2S_8CH_PRE
 and CLK_I2S_8CH_FRAC
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?=E6=9D=8E=E7=BB=B4=E8=B1=AA?= <cn.liweihao@gmail.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>
References: <20250905132328.9859-1-cn.liweihao@gmail.com>
 <20250905132328.9859-3-cn.liweihao@gmail.com>
 <707aad1d-fcdb-4c66-8d96-41cf1a1b02ce@kernel.org>
 <CAPEOAkRTVtKBsmiGTbKOCar0oNS-C3dRXqdpuowroRPH1bFS7g@mail.gmail.com>
 <58b638c8-b27e-49a6-b79e-f078135c575b@kernel.org>
 <CAPEOAkSpEzVtUqyUJQbDmbmPOjORnAfuehhvo1qqZgAAeY=ZVA@mail.gmail.com>
In-Reply-To: <CAPEOAkSpEzVtUqyUJQbDmbmPOjORnAfuehhvo1qqZgAAeY=ZVA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

--7bb96b1748a067e53456e99e209bf191ed42469d49852d8d3d12a1592bb7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Sep 6, 2025 at 3:34 PM CEST, =E6=9D=8E=E7=BB=B4=E8=B1=AA wrote:
> Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=886=
=E6=97=A5=E5=91=A8=E5=85=AD 15:21=E5=86=99=E9=81=93=EF=BC=9A
>> On 06/09/2025 03:34, =E6=9D=8E=E7=BB=B4=E8=B1=AA wrote:
>> > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=88=
5=E6=97=A5=E5=91=A8=E4=BA=94 22:13=E5=86=99=E9=81=93=EF=BC=9A
>> >> On 05/09/2025 15:23, WeiHao Li wrote:
>> >>> We need a clock id to assign clock parent when use i2s 8ch as audio
>> >>> device, CLK_I2S_8CH_FRAC should be CLK_I2S_8CH_PRE parent so we can =
get
>> >>> frequency we want.
>> >>>
>> >>> Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
>> >>> ---
>> >>>  include/dt-bindings/clock/rk3368-cru.h | 3 +++
>> >>>  1 file changed, 3 insertions(+)
>> >>>
>> >>> diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bin=
dings/clock/rk3368-cru.h
>> >>> index b951e29069..795e721957 100644
>> >>> --- a/include/dt-bindings/clock/rk3368-cru.h
>> >>> +++ b/include/dt-bindings/clock/rk3368-cru.h
>> >>> @@ -183,6 +183,9 @@
>> >>>  #define HCLK_BUS             477
>> >>>  #define HCLK_PERI            478
>> >>>
>> >>> +#define CLK_I2S_8CH_PRE              500
>> >>
>> >> 479
>> >>
>> >>> +#define CLK_I2S_8CH_FRAC     501
>> >>
>> >> 480, no?
>> >>
>> >
>> > Neither of these clocks belong to the previous grouping in terms of
>> > type, so I chose to start with a new integer id here.
>>
>> I don't know what is "previous grouping" here, but IDs are abstract and
>> are incremented by 1.
>
> In the current kernel code, the RK3368 clock IDs are categorized by
> SCLK, ACLK, PCLK, and HCLK.

Maybe this helps understanding the discrepancy:

Starting with the rk3588 series, clock IDs are in the 'clock' binding
dir and named "rockchip,rk<SoC-id>-cru.h" and are numbered sequentially
with no gaps. And the reset IDs are in the 'reset' binding dir with the
same filename pattern.

With older SoC series, including rk3568*, both the clock and reset IDs
are in "clock/rk<SoC-id>-cru.h" where they are NOT sequentially
numbered and thus jumps in the numbering is not out of place there.

HTH,
  Diederik

*) I have a local commit which moves the reset IDs to
"reset/rockchip,rk3568-cru.h", but I don't know how to do/fix the
numbering, so I never submitted it.

--7bb96b1748a067e53456e99e209bf191ed42469d49852d8d3d12a1592bb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaLw95gAKCRDXblvOeH7b
bvNkAP99WIABmRv9YSzmveKgHvYKLFoQLUV0tMVC03ofrDorHQEA2TFlad1NNFB5
V10lG7EyfJsr5FC/E6J50SW4/JODEQs=
=GF08
-----END PGP SIGNATURE-----

--7bb96b1748a067e53456e99e209bf191ed42469d49852d8d3d12a1592bb7--

