Return-Path: <linux-kernel+bounces-765421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010ABB233EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A46F3B1976
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034DC2FE582;
	Tue, 12 Aug 2025 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="XNhSR2c6"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D501DF27F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023353; cv=none; b=knisMeA1zLB2oys0mQMTs5WSF4QKNAXHWPOpm8bnXJFlz99WBsB/u71Vs4o6WXcZn2LKgpVCvWW7VoJoKCEMbTKv9KhX1yagx04kWf78FQAlyhLWeev9e8c1mYkVoUBcRPE5jgPkBsUSGv+AyhvxXqQ1Ui1BST0LvBbeb6qCMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023353; c=relaxed/simple;
	bh=oD6Wql+dJ0XPC8CVTqZrZY4+wUUsRzpVgpViRU0wRb0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ApPs3w2PPPLRLtTR+p3jOm2euUx5HiS3A1rglsUrPPyzkKzkRDALJzSfxE7L7n2aEjnyGDYx6aluH88oSMB5iYoI2LdDGCSBGtnqjvLMSccC3oDRN6QnoWllMhUgAqN/renAYcdhLxPZIT7nB4u2FhAb+Z86vi45/mLO1jj7J3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=XNhSR2c6; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755023335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dpt2q1VVawx7RN3DHXgKomnidZFs0KWZ5Y4PeN/MWV8=;
	b=XNhSR2c6W5vbltKeZ64FCBmBbLFbku0Fv+4E0E+qN/OhvaO8m5hvk7zJxeYa8n403i8XWB
	X2npk6mQILoQQcl8PffQjcNzQev2Pysg9gEEml3fgjge2SN2rvIbKIQhDF5Ca+vWwm7GqT
	5Vu0BBf1n2kA/5c7qsfuwo6MdXFi/+X2E66L264EaNacskzXeYNoVBeJ622AIubk9eoztp
	xy5OEceRLk75dV9b4S3QHK8DRSeVLLZiS39A3LXR71DP2kHJxGBJRV/YaCCiQxuZEWvnYO
	JF/VU1W0jmmwENfUiErOF4TEHm/liX9rE9KtqSQg2G6nWhNTKC3kIYuGa3Vknw==
Content-Type: multipart/signed;
 boundary=617e8f59b1ff50d429dd9df48218ad6990c7a2b892c3d1eddd6a2f382fbe;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 12 Aug 2025 20:28:43 +0200
Message-Id: <DC0NUGDTCUYD.QT1BLJEGXYFG@cknow.org>
Cc: "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>, "Detlev Casanova"
 <detlev.casanova@collabora.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Alex Bee" <knaerzche@gmail.com>, "Nicolas Dufresne"
 <nicolas.dufresne@collabora.com>, "linux-media@vger.kernel.org"
 <linux-media@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] media: rkvdec: Add HEVC backend
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Jonas Karlman" <jonas@kwiboo.se>
References: <20250810212454.3237486-1-jonas@kwiboo.se>
 <DC0FTXJNW0KB.3I8DLNHJVL21O@cknow.org>
 <64d551d7-924a-48af-96ca-224fa94543d8@kwiboo.se>
In-Reply-To: <64d551d7-924a-48af-96ca-224fa94543d8@kwiboo.se>
X-Migadu-Flow: FLOW_OUT

--617e8f59b1ff50d429dd9df48218ad6990c7a2b892c3d1eddd6a2f382fbe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Jonas,

On Tue Aug 12, 2025 at 7:11 PM CEST, Jonas Karlman wrote:
> On 8/12/2025 2:11 PM, Diederik de Haas wrote:
>> On Sun Aug 10, 2025 at 11:24 PM CEST, Jonas Karlman wrote:
>>> This series add a HEVC backend to the Rockchip Video Decoder driver.
>>>
>>> With the dependent H.264 High 10 and 4:2:2 profile support series
>>> finally merged there is finally time to send a v2 with minor changes an=
d
>>> a suggested code style fix of this series. v1 of this series has been
>>> fully functional up until recent unstaging of the rkvdec driver.
>>>
>>> Patch 1 add the new HEVC backend.
>>> Patch 2-3 add variants support to the driver.
>>> Patch 4 add support for a rk3288 variant.
>>> Patch 5 add a rk3328 variant to work around hw quirks.
>>> Patch 6-7 add device tree node for rk3288.
>>=20
>> It looks like I had a previous version of linuxtv-rkvdec-hevc-v2 branch
>> locally and that also had this commit:
>> - media: rkvdec: Keep decoder clocks gated
>>=20
>> Is that one no longer needed/useful/etc ?
>
> I do not think it is, could possible be to keep power consumption at
> minimum while decoding. Some parts enable auto gating and then we
> disable it when decoding is complete. With auto-suspend the entire block
> is disabled anyway so this probably did not make any noticeable
> difference and could instead introduce new possible issues.

Makes sense, thanks.
=20
>> And 'chewitt' also had a commit to fix 8/10-bit selection:
>> https://github.com/chewitt/linux/commit/4b93b05d2ca608bc23f1d52bcc32df92=
6d435c7c
>> "WIP: media: rkvdec: fix 8-bit/10-bit format selection"
>>=20
>> I haven't tried that one (yet), but did  try an other variant with
>> changing the ordering in rkvdec_hevc_decoded_fmts but that didn't work
>> in my tests. (Can ofc be PEBKAC)
>
> The format selection in kernel for this series should be correct,
> however to ensure 10-bit works you need following for ffmpeg-v4l2request
> to select and use 10-bit pixel formats:
>
> libdrm 2.4.104+ (NV15) / 2.4.118+ (NV20)
> - 10-bit drm formats, ffmpeg v4l2request test with a #ifdef
>
> linux headers v6.16-rc1+ (NV15/NV20)
> - 10-bit v4l2 pix fmt, ffmpeg v4l2request test with a #ifdef
>
> FFmpeg v4l2request will not negotiate use of 10-bit formats without
> DRM_FORMAT_NV15/NV20 and V4L2_PIX_FMT_NV15/NV20 defined when ffmpeg was
> compiled.
>
> That would be the most likely issue if only 8-bit formats is working.

Thanks so much for the detailed explanation with which I can check where
my stack wasn't doing what I hoped it would :-)

>> Would that be useful? I do/did have consistent problems with playing
>> 10-bit encoded video files.
>
> Looking quickly at the 'fix 8/10-bit selection' commit the issue is that
> rkvdec_hevc_get_image_fmt() was incomplete to begin with. The
> rkvdec_hevc_get_image_fmt() in this series has been correct since v1.

Thanks :)

Cheers,
  Diederik

--617e8f59b1ff50d429dd9df48218ad6990c7a2b892c3d1eddd6a2f382fbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaJuH3gAKCRDXblvOeH7b
bvUTAQDzWJwxbYcSqq4djUea9n1kNb8PO3n1pspIxNcYxUolOAEApwmwMbrefnCW
t0RHEpbTOmEqnCD4VF5oaIZ5BmWQbgM=
=QdkM
-----END PGP SIGNATURE-----

--617e8f59b1ff50d429dd9df48218ad6990c7a2b892c3d1eddd6a2f382fbe--

