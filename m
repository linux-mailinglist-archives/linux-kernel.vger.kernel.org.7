Return-Path: <linux-kernel+bounces-676860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900BEAD120E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 14:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D0C16A1B7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1220B80A;
	Sun,  8 Jun 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Smldvf+d"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F166205E3E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Jun 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749387232; cv=none; b=U5vTc4xKtXT7dv9Km6inxL07toZFGfgWBtOvjdT8pyrzEDwoMkmn0c0/v+X92Ks9qO941UXF2gBhjdld8DKIAtYAV/71RQ1kcuSnVKyIgDLJCqCZm/PnURNKyHnoIzaIeRRUtVU1dH/eREOJu8tJ7bxjvmNzqGgfBqQ1OIhKzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749387232; c=relaxed/simple;
	bh=H4BgjctgOYACRdIRyJSiLwJVWPXSqVjsWaVGGzBtHY8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CodJaIL17DUxJb3i53jbBLHxyFVf5R6MVLi959IMB3AwjQdl0RQ61mmjy7hhUBGNrafaTeZ8rf2xhhYeDJYfxfHTQ/lOIrP3SkuVVCzlgun2F1HhMzMpLQZNjetN9IBxT8zuYMjdRIFpE7kJQuV/hoC9fyV7oOxIDjUMBq/2ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Smldvf+d; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1749387226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UoAoTWaDhudNjz1U5V7+hAboAbqegZdb7n3FPRiJ6jE=;
	b=Smldvf+dIob+0gqgKw8jY2ot8r+9vfSeqg7sf8KdvWn7yjT33epEVpXDwfF+8IiBaKqXSo
	az8nsef6eVErRJrLAxG3nSTgXGlPXGRwF/STMDPTNK+XzDjpYNEnXWGgMCC8QAicS1GMQj
	hi01PNEt/KriG7HE0OK+HKPDjCD9cw5YG31tn34sdLwa/CA3XaZ5tzN20RrzXeJfn33hDl
	eU2gBVtllZ35s04rg9aZeTf0s4xFZtr//XWY3p27D6XeuTcscllloV2Vob1mS48npwz7pc
	ipMchx37YYFf4TK2KpNfUHLJhYo1Lhndi/lxIcVL0YVl6alCDzx5I9Qnz+XyNA==
Content-Type: multipart/signed;
 boundary=dd3c07efb9d99c286c094c5faf160fb096648f1e935abee08db29ed3060d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 08 Jun 2025 14:53:37 +0200
Message-Id: <DAH60H3HYG7M.3NFXBJ7576RH1@cknow.org>
Cc: "Piotr Zalewski" <pZ010001011111@proton.me>, <hjc@rock-chips.com>,
 <heiko@sntech.de>, <andy.yan@rock-chips.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, "Dang Huynh"
 <danct12@riseup.net>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH drm-misc-next] rockchip/drm: vop2: don't check
 color_mgmt_changed in atomic_enable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Andy Yan" <andyshrk@163.com>
References: <20241206192013.342692-3-pZ010001011111@proton.me>
 <DAEVDSTMWI1E.J454VZN0R9MA@cknow.org>
 <mArHDRo5bhIAjG8sDOR-kM7DsVdbXxxcC8hfuEEPfUWIdMwNnSUy8ZFoLis66DFSuIEq8TrnAxUGkyo5IUTGw3AG4k3vuVVz0fsoI27BAms=@proton.me> <DAH3S8O66J47.3NT18EJCXWKL9@cknow.org> <47773829.1fce.1974f732545.Coremail.andyshrk@163.com>
In-Reply-To: <47773829.1fce.1974f732545.Coremail.andyshrk@163.com>
X-Migadu-Flow: FLOW_OUT

--dd3c07efb9d99c286c094c5faf160fb096648f1e935abee08db29ed3060d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Andy,

On Sun Jun 8, 2025 at 2:10 PM CEST, Andy Yan wrote:
> At 2025-06-08 19:08:50, "Diederik de Haas" <didi.debian@cknow.org> wrote:
>>On Sat Jun 7, 2025 at 5:32 PM CEST, Piotr Zalewski wrote:
>>> On Thursday, June 5th, 2025 at 10:13 PM, Diederik de Haas <didi.debian@=
cknow.org> wrote:
>>>> Since kernel 6.14-rc1 I have the problem that visual output is no long=
er
>>>> shown on my PineTab2 and a `git bisect` pointed to this patch/commit
>>>> as the culprit. What is important to note is that `CONFIG_DRM=3Dm` see=
ms
>>>> to be required as the problem does not occur with `CONFIG_DRM=3Dy`.
>>>>=20
>>>> Near the end of my bisect session, something interesting occurred.
>>>> I was booted into a 'bad' kernel (ie no visual output) and when I
>>>> started to build my final kernel, I closed the lid of the PineTab2 whi=
ch
>>>> made it go into suspend. When my final kernel was built, I opened the
>>>> lid again, which made it resume, to transfer my final kernel to it.
>>>> And much to my surprise, I then did have visual output.
>>>> When I read the (below) commit message of the 'offending' commit, it m=
ay
>>>> not be such a surprise after all.
>>>>=20
>>>> I did try it on a Quartz64-B (also rk3566) and it did not have any iss=
ue
>>>> (output via HDMI).
>>>> I don't know what the cause for this issue is, hopefully you do.
>>>
>>> I tested and confirmed that this happens with drm=3Dm but also in my ca=
se=20
>>> it happened when drm=3Dy. After some testing I found out that at boot m=
odeset
>>
>>Interesting that it also happened with drm=3Dy.
>>As you're more knowledgeable then I am with this, maybe look through
>>https://lists.sr.ht/~diederik/pine64-discuss/<D9AM2OOLREO0.2JMAI42J06TW0@=
cknow.org>
>>
>>to see if you may spot something relevant?
>>
>>> happened twice and at short interval and since this patch allows for ga=
mma=20
>>> LUT update regardless of color_mgmt_changed state this makes DSP CTRL G=
AMMA=20
>>> LUT EN bit to be unset twice too. It seems that VOP does not like it. I=
=20
>>
>>Happy to see you found the cause :-)
>>Do you happen to know why it was unset twice? That sounds suboptimal.
>>But (IIUC) setting a bit to a value it already has causing issues,
>>sounds surprising as well.
>
> I have conducted tests on both rk3566-box-demo (with drm set to y) and rk=
3568-lubancat-2 (with drm set to m),=20
> but I was unable to reproduce this issue. Could you two please share your=
 kernel defconfig and the corresponding kernel startup logs?=20
> Additionally, both of my two boards tested with HDMI output. What kind of=
 display interface does your board use for output?

I wasn't able to reproduce this issue on my PINE64 Quartz-B (rk3566)=20
with HDMI output either, but the problem is present on a PineTab2 [1]
(also rk3566) which uses a MIPI DSI connection to the display panel.

Kernel config:
https://paste.sr.ht/~diederik/aa747ed170aa01cc759fbe1ffd9cebe8c887b10b

dmesg kernel 6.14-rc1:
https://paste.sr.ht/~diederik/733fbf8bb7f6aee8b68cf5a652157d445462c24a

dmesg kernel 6.14-rc1 with Piotr's patch:
https://paste.sr.ht/~diederik/db1af672cfb611acbfbdf35adb6f170e5c38febc

Both dmesg outputs contain a suspend-resume cycle.
I'm using a USB Wi-Fi adapter for the wireless connection.

[1] https://wiki.pine64.org/wiki/PineTab2

Happy to provide more info and/or do some tests.

Cheers,
  Diederik

>>> patched vop2_vp_dsp_lut_disable function so that dsp_ctrl is set only i=
f=20
>>> GAMMA LUT EN bit is set. I checked that this also does not break the ga=
mma=20
>>> lut functionality with emphasis on out-of/into suspend behavior.
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu=
/drm/rockchip/rockchip_drm_vop2.c
>>> index d0f5fea15e21..7ddf311b38c6 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>>> @@ -897,6 +897,9 @@ static void vop2_vp_dsp_lut_disable(struct vop2_vid=
eo_port *vp)
>>>  {
>>>  	u32 dsp_ctrl =3D vop2_vp_read(vp, RK3568_VP_DSP_CTRL);
>>> =20
>>> +	if ((dsp_ctrl & RK3568_VP_DSP_CTRL__DSP_LUT_EN) =3D=3D 0)
>>> +		return;
>>> +
>>>  	dsp_ctrl &=3D ~RK3568_VP_DSP_CTRL__DSP_LUT_EN;
>>>  	vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);
>>>  }
>>
>>I built a kernel with 6.14-rc1 + this patch and can confirm the screen
>>has output again :-)
>>
>>> I will wait with sending a patch because maybe Andy has something to ad=
d=20
>>> to this.
>>
>>Sounds like a plan. It could be that this issue surfaced an underlaying
>>issue and if so, fixing that would be even better.

--dd3c07efb9d99c286c094c5faf160fb096648f1e935abee08db29ed3060d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaEWH1AAKCRDXblvOeH7b
bhl7AQDIBrUguAnNscCeQXQtCZLqeiXP+l3DJm6F2Fj0mB1XQQD+OL05kGhhBoXv
BdqaHKsLNeSC2+SVVWtKTeiyRT6t9As=
=I/5o
-----END PGP SIGNATURE-----

--dd3c07efb9d99c286c094c5faf160fb096648f1e935abee08db29ed3060d--

