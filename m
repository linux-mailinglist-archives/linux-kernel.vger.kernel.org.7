Return-Path: <linux-kernel+bounces-675043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62BCACF854
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 21:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54977189D39D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8C27BF99;
	Thu,  5 Jun 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="FXcqnj/Z"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7B5FEE6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152998; cv=none; b=a3m59vl5RdNx15TbCPKDeKChabYpnloz040FBmHn6P8UkMsYYq6CmMGvkU5fiWMOU0+uFhB75K3OgNAsg1N7vzayvMCioEW206VfmjsSXf+MKRsWxReojt2jbM8l5UsiEC/BaBU08rwh5Rbgb4uLxkTDorncaX0Z2ullgdZ8b9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152998; c=relaxed/simple;
	bh=ReVnwpCkjYaOtt27KO0F8tOngaoZCV7oCA1ODZd970I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sHUaL07EWc+rm9BtMDCEB9xbR2wYTu1C2hwmbin5V+TaYNWyoZJDjwOf/TZSH8BjOBMOvATQHf39xHrUEJER7DWbhTp10NR1Vnwc7Yuyd9tF1B34h7fFCGIQ1+kHCBx6PkjQx509N5UhQtu3Umd6tSo916R6vAbTAb/31Hr+9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=FXcqnj/Z; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1749152990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJqiZsO00UW1qzZCC8pTl4Bce7VgLFymF1yeTS4Wo1I=;
	b=FXcqnj/ZkLVgqnSXA/9FCtL8/d/zbvT/uL/nRPY4ksTM7NoH+k7HOrLyiUHdrSN448BJEs
	tzm80CoUd+7YJYNYcP8LDfYzXJxnSMktTXGW8Kwp7IkGVirCjElBjFaIWD3fy73G8ASCEz
	bi0vCwHbcMFzgtcrYfkulfJnzWs97Ya8EuOeG6Ynh3tmJNSyiwTaxVCoyWVnZc6Ltkq/Ln
	feYAgiGpA0nhzBqo0uSjz9JfldpzkKqhRG/grezN5hoBijkcaPwIcYAMd6yHiDXQRnXaF0
	n8r1ngQ5EzjutOWkyYl5Y7qlhheNe2HsVJPVZo1oMz/kOAwit7pbWLMIJbCNsw==
Content-Type: multipart/signed;
 boundary=3cdd52bd73029a86b1db18a8ebe587a89be50fded87b2fd99a67d4267211;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 05 Jun 2025 21:49:40 +0200
Message-Id: <DAEUZDXQ1QT8.1YMVDZVR29GJM@cknow.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>, <kernel@collabora.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] PM / devfreq: rockchip-dfi: add support for LPDDR5
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>, "Chanwoo Choi"
 <cw00.choi@samsung.com>, "MyungJoo Ham" <myungjoo.ham@samsung.com>,
 "Kyungmin Park" <kyungmin.park@samsung.com>, "Heiko Stuebner"
 <heiko@sntech.de>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "Sebastian Reichel"
 <sebastian.reichel@collabora.com>
References: <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com> <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com> <DADLSAEF1YPO.V0CQK084KFFO@cknow.org> <4244538.aeNJFYEL58@workhorse>
In-Reply-To: <4244538.aeNJFYEL58@workhorse>
X-Migadu-Flow: FLOW_OUT

--3cdd52bd73029a86b1db18a8ebe587a89be50fded87b2fd99a67d4267211
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Jun 5, 2025 at 5:14 PM CEST, Nicolas Frattaroli wrote:
> On Wednesday, 4 June 2025 10:24:33 Central European Summer Time Diederik =
de Haas wrote:
>> On Fri May 30, 2025 at 3:38 PM CEST, Nicolas Frattaroli wrote:
>> > [...]
>> > +	case ROCKCHIP_DDRTYPE_LPDDR5:
>> > +		ddrmon_ver =3D readl_relaxed(dfi->regs);
>> > +		if (ddrmon_ver < 0x40) {
>> > +			*ctrl =3D DDRMON_CTRL_LPDDR5 | dfi->lp5_bank_mode;
>> > +			*mask |=3D DDRMON_CTRL_LP5_BANK_MODE_MASK;
>> > +			break;
>> > +		}
>> > +
>> > +		/*
>> > +		 * As it is unknown whether the unpleasant special case
>> > +		 * behaviour used by the vendor kernel is needed for any
>> > +		 * shipping hardware, ask users to report if they have
>> > +		 * some of that hardware.
>> > +		 */
>> > +		dev_err(&dfi->edev->dev,
>> > +			"unsupported DDRMON version 0x%04X, please let linux-rockchip know=
!\n",
>> > +			ddrmon_ver);
>> > +		return -EOPNOTSUPP;
>>=20
>> I'm guessing you mean the linux-rockchip mailing list here? If so, I
>> think it's better to make that explicit as 'Joe User' who may run into
>> this issue may not be aware of that mailing list. The 'linux' and
>> 'rockchip' name combo is used in quite a few places.
>
> I agree it's ambiguous, the message as it is right now is the way it is
> because we're not allowed to linebreak user-facing messages for grep-
> ability and I also don't want to exceed 100 lines of width (though this
> is the one case where we're allowed to).
>
> I suppose I should just replace it with the e-mail address of the list.
> That should be clear enough and this error message also won't end up in
> random boot logs strewn across the internet if it really is just some
> engineering sample hardware or similar that's affected.

I understand the issue. Maybe this discussion itself will help make it
appear high enough in the search results to fix the ambiguity ;-)
I'll leave it up to you if or how to change anything (or not).

Cheers,
  Diederik

>> > +	default:
>> > +		dev_err(&dfi->edev->dev, "unsupported memory type 0x%X\n",
>> > +			dfi->ddr_type);
>> > +		return -EOPNOTSUPP;
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +
>> >  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>> >  {
>> >  	void __iomem *dfi_regs =3D dfi->regs;
>> >  	int i, ret =3D 0;
>> > +	u32 ctrl;
>> > +	u32 ctrl_mask;
>> > =20
>> >  	mutex_lock(&dfi->mutex);
>> > =20
>> > @@ -136,8 +186,11 @@ static int rockchip_dfi_enable(struct rockchip_df=
i *dfi)
>> > <snip>
>>=20


--3cdd52bd73029a86b1db18a8ebe587a89be50fded87b2fd99a67d4267211
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaEH01wAKCRDXblvOeH7b
bjekAQDt2eVvkNGS0Du340umiQKSvaFxizTMOEIkxgx5fjC8KwD+I8OVx9ygu1iV
eOdkqV5mvuHIC90hcPFQOQTfuRHH9QU=
=SP89
-----END PGP SIGNATURE-----

--3cdd52bd73029a86b1db18a8ebe587a89be50fded87b2fd99a67d4267211--

