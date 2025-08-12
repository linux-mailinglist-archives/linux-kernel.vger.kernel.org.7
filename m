Return-Path: <linux-kernel+bounces-764716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA71B22671
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C413BA1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588842EFD85;
	Tue, 12 Aug 2025 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="GWG+XfFZ"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167E2EF656
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000747; cv=none; b=tiI1s7lmIxXRgmvYz42haagngcUFAyQFfmy5A9W/1QURNnMyiL5hQvIKF4yxvcQgh0j8T1Voy+pSYyKsC6uSiMiysL4QVWmBt1NgAY+FsRs1ALavFm1lbe6bCHRjkTcgYH9a3J9SxDk0zSbXZbS53oIBxy/jXlwO4iBUiohT4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000747; c=relaxed/simple;
	bh=lTFMuIsIiVGrB+qx7GRFSZvlsXysj2NYfX6z01P1fFk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=U29NNpO/rBR3uq7/IOAUmJfQipJTHdQcKbM5g06fqeFniochcDRK25wCbz/hiyhfv8nL2siuBagzSLNbXI65XzpEpZSBWLbzK85IOhPNBUbqdb/PGbzTVWlwWQv3HT6oskf6C+O+NaeJUQWlaLFBqvtNDQqOBoyVcrtuseyQvFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=GWG+XfFZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1755000733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scirrqqI4lOboEI3/AWvPAjONsAeNM4rjx3UmgFrhBA=;
	b=GWG+XfFZJGWUBXR2DfX9RM0RidgE3PuHgnxhkGyBvKors9KleZT7/IFPmBWTCyAYyO1h7Z
	tFXdiAm9r0QWnc1NIsiCMGGvSlmXhznINjn0zezrvbNJsZfL1/xQBcNDPtZlFryDOBZrt6
	XNGW7qqjaYw44iIX1jduDbF/B+CMkLl9RrjYQXpIC3bbgDQA4ihegz1XfJ7BvLhEfMgT4O
	fH7O7CjZDiklMuprfB+uvjJYxaPBONP/Si4D8AXmDl+JPzIk7LqLf0oMEgULu9Nsula/L1
	Nkt4akKX5hcwlK0S9arlLblv1EpoVuzUPkuHNSWPdaZDQ+0pok8FCMpwfe04Tg==
Content-Type: multipart/signed;
 boundary=6590abcb8affc04b8dd77226ffd5bce0d727acb00dbbc61bdd0f9c164e53;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 12 Aug 2025 14:11:53 +0200
Message-Id: <DC0FTXJNW0KB.3I8DLNHJVL21O@cknow.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Jonas Karlman" <jonas@kwiboo.se>, "Ezequiel Garcia"
 <ezequiel@vanguardiasur.com.ar>, "Detlev Casanova"
 <detlev.casanova@collabora.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>
Cc: "Alex Bee" <knaerzche@gmail.com>, "Nicolas Dufresne"
 <nicolas.dufresne@collabora.com>, "Sebastian Fricke"
 <sebastian.fricke@collabora.com>, <linux-media@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] media: rkvdec: Add HEVC backend
References: <20250810212454.3237486-1-jonas@kwiboo.se>
In-Reply-To: <20250810212454.3237486-1-jonas@kwiboo.se>
X-Migadu-Flow: FLOW_OUT

--6590abcb8affc04b8dd77226ffd5bce0d727acb00dbbc61bdd0f9c164e53
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Jonas,

On Sun Aug 10, 2025 at 11:24 PM CEST, Jonas Karlman wrote:
> This series add a HEVC backend to the Rockchip Video Decoder driver.
>
> With the dependent H.264 High 10 and 4:2:2 profile support series
> finally merged there is finally time to send a v2 with minor changes and
> a suggested code style fix of this series. v1 of this series has been
> fully functional up until recent unstaging of the rkvdec driver.
>
> A version of this HEVC backend has been in use by the LibreELEC distro
> for the past 5+ years [1]. It was initially created based on a copy of
> the H264 backend, unstable HEVC uAPI controls and a cabac table + scaling
> matrix functions shamelessly copied 1:1 from the Rockchip mpp library.
>
> It has since then been extended to use the stable HEVC uAPI controls and
> improved opon e.g. to include support for rk3288 and fix decoding issues
> by Alex Bee and Nicolas Dufresne.
>
> The version submitted in this series is based on the code currently used
> by the LibreELEC distro, excluding hard/soft reset, and with cabac table
> and scaling matrix functions picked from Sebastian Fricke prior series
> to add a HEVC backend [2].
>
> Big thanks to Alex Bee, Nicolas Dufresne and Sebastian Fricke for making
> this series possible!
>
> Patch 1 add the new HEVC backend.
> Patch 2-3 add variants support to the driver.
> Patch 4 add support for a rk3288 variant.
> Patch 5 add a rk3328 variant to work around hw quirks.
> Patch 6-7 add device tree node for rk3288.

It looks like I had a previous version of linuxtv-rkvdec-hevc-v2 branch
locally and that also had this commit:
- media: rkvdec: Keep decoder clocks gated

Is that one no longer needed/useful/etc ?

And 'chewitt' also had a commit to fix 8/10-bit selection:
https://github.com/chewitt/linux/commit/4b93b05d2ca608bc23f1d52bcc32df926d4=
35c7c
"WIP: media: rkvdec: fix 8-bit/10-bit format selection"

I haven't tried that one (yet), but did  try an other variant with
changing the ordering in rkvdec_hevc_decoded_fmts but that didn't work
in my tests. (Can ofc be PEBKAC)

Would that be useful? I do/did have consistent problems with playing
10-bit encoded video files.

> This was tested on a ROCK Pi 4 (RK3399) and Rock64 (RK3328):
> <snip>
>
> Please note that there is a known issue with concurrent decoding,
> decoding errors in one decode session may affect a separate session.
> The only known mitigation to this is to pause decoding for some time
> and/or do a full HW reset, something to handle in future series.

Or would that be (potential) material for a future series as well?

Cheers,
  Diederik
>
> <snip>
>
> Alex Bee (4):
>   media: rkvdec: Add variants support
>   media: rkvdec: Add RK3288 variant
>   media: rkvdec: Disable QoS for HEVC and VP9 on RK3328
>   ARM: dts: rockchip: Add vdec node for RK3288
>
> Jonas Karlman (3):
>   media: rkvdec: Add HEVC backend
>   media: rkvdec: Implement capability filtering
>   media: dt-bindings: rockchip,vdec: Add RK3288 compatible
>
>  .../bindings/media/rockchip,vdec.yaml         |    1 +
>  arch/arm/boot/dts/rockchip/rk3288.dtsi        |   17 +-
>  .../media/platform/rockchip/rkvdec/Makefile   |    2 +-
>  .../rockchip/rkvdec/rkvdec-hevc-data.c        | 1848 +++++++++++++++++
>  .../platform/rockchip/rkvdec/rkvdec-hevc.c    |  826 ++++++++
>  .../platform/rockchip/rkvdec/rkvdec-regs.h    |    4 +
>  .../platform/rockchip/rkvdec/rkvdec-vp9.c     |   10 +
>  .../media/platform/rockchip/rkvdec/rkvdec.c   |  184 +-
>  .../media/platform/rockchip/rkvdec/rkvdec.h   |   15 +
>  9 files changed, 2886 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-da=
ta.c
>  create mode 100644 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c


--6590abcb8affc04b8dd77226ffd5bce0d727acb00dbbc61bdd0f9c164e53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaJsvjAAKCRDXblvOeH7b
bhf6AP0cQaPbNeNKgdBGzdSYqHMMSX3Ix/IZm7QpHlM11Q7PWgEAw2HCwp3ojWFd
ALwV+Z8FasxZfkOfjYJmcHhJyZdW3gk=
=zJRQ
-----END PGP SIGNATURE-----

--6590abcb8affc04b8dd77226ffd5bce0d727acb00dbbc61bdd0f9c164e53--

