Return-Path: <linux-kernel+bounces-869442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9DC07E35
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2267E4E2454
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF80286D53;
	Fri, 24 Oct 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="SsLORBQ/"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A8283FDF;
	Fri, 24 Oct 2025 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333663; cv=none; b=uovSLM7ixqHz4HnA1hB7/ZKZdI5qofsOh3idsK68Wdhgav9/g2uyKtwTG14PNh7fZ+0vLBYSiQo08EwGjVXG6onRmHKYggLc4yg9BUj2BcOzT9yOg66ooYtf258XN4lnoBcYIMP6AdxWXAvKeIp1e/fBeBWvw9d2qSKzPzcQEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333663; c=relaxed/simple;
	bh=pRkUpCozJ6pjtnaQXGNpsXEpWmwEZ64uoby4q5T7+R4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oKLKvL0EtW61J2iWt8IGTACxQl8QTkwYdTJ4sgmomU0ImwY3SikPxHrRQMYObZhHcocse2Dk6K9/gx52MRSF9rksyKUwaa54MbcizQZY0WnqaFh8gaf6EJXBP+Z74dVy4eLsCg9sb1kXCn/gAAErrPofTF6iM9Duw1x4p5BpyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=SsLORBQ/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1761333658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCS3u+p5/mBX/+ng03ATa6a8JxRz1+ui4UK+ezTN610=;
	b=SsLORBQ//u6ocJ1PZbfaCSFlOEa1lQEQISN/T6O5M8v5zAaO8wNToSmTGA8ITDWaGKCn+h
	q5bH5cBBlrinNwDIo6go56m9JI/JdcNHj5ZVFTxIaihBCyoZBXDdGpur+ZyheGWtVZWum7
	/FvAlHrmPVvM7blAbflY76Ig7XXIl0z5/d7WTIoh+xEt4ND+JKbbGYVZj81sfxzVToGFzW
	9rkwwVLEkSPiZpsC9ioZ0bghwtPBeXVU8LOgBpHCLPpl4PMVw5kWNuv4m9dBytuct258YW
	cXKx2G/zhKG/1dO7QBuyLcl50TEzPN+SxJ9eYv+NLdwTO3Aabo+eyXgYRpRX+w==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Oct 2025 21:20:45 +0200
Message-Id: <DDQSO2HR1BFU.2JONNHRBR0LR5@cknow-tech.com>
Cc: "Heiko Stuebner" <heiko@sntech.de>, "Shawn Lin"
 <shawn.lin@rock-chips.com>, "Kever Yang" <kever.yang@rock-chips.com>,
 "Chukun Pan" <amadeus@jmu.edu.cn>, "Alexander Shiyan"
 <eagle.alexander923@gmail.com>, <kernel@collabora.com>, "Dragan Simic"
 <dsimic@manjaro.org>, "Rob Herring" <robh@kernel.org>, "Sebastian Reichel"
 <sebastian.reichel@collabora.com>, <linux-rockchip@lists.infradead.org>,
 <devicetree@vger.kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Damon
 Ding" <damon.ding@rock-chips.com>, "Chris Morgan"
 <macromorgan@hotmail.com>, <linux-arm-kernel@lists.infradead.org>, "Patrick
 Wildt" <patrick@blueri.se>, "Alexey Charkov" <alchark@gmail.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Tomeu Vizoso" <tomeu@tomeuvizoso.net>
Subject: Re: [PATCH v3 0/2] arm64: dts: rockchip: Add vdpu 381 and 383 nodes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Detlev Casanova" <detlev.casanova@collabora.com>,
 <linux-kernel@vger.kernel.org>
References: <20251020212009.8852-1-detlev.casanova@collabora.com>
In-Reply-To: <20251020212009.8852-1-detlev.casanova@collabora.com>
X-Migadu-Flow: FLOW_OUT

Hi Detlev,

On Mon Oct 20, 2025 at 11:20 PM CEST, Detlev Casanova wrote:
> Add the nodes for vdpu 381 and 383, respectively RK3588 and RK3576.
> To keep compatibility with older variants, the reg ranges order is not
> in register order so that the function reg range is kept first.

This is a great comment, which I'd have preferred to have seen in the
commit messages themselves.

Especially since I'm getting DTB validation warnings:

  DTC [C] arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb
arch/arm64/boot/dts/rockchip/rk3576.dtsi:1292.30-1314.5: Warning (simple_bu=
s_reg):
/soc/video-codec@27b00000: simple-bus unit address format error, expected "=
27b00100"
  DTC [C] arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dtb
arch/arm64/boot/dts/rockchip/rk3576.dtsi:1292.30-1314.5: Warning (simple_bu=
s_reg):
/soc/video-codec@27b00000: simple-bus unit address format error, expected "=
27b00100"


For some reason I'm not getting that for rk3588, which I need to
investigate further. Technically, I ran my DTB validation script on your
'add-vdpu381-and-383-to-rkvdec-v3-on-next' branch, but I don't see how
that would/could change the outcome.

My validation script does essentially this:
``make CHECK_DTBS=3Dy W=3D1 $(get_my_dtbs)``

('get_my_dtbs' returns a list of dtb files I want to check)

So it looks like the DTB validation tool is not happy that the
reg ranges are not sorted in 'proper' order.

Note that the ``W=3D1`` is essential to see the warning, it does not show
up when ``W=3D0`` is used.
I'll leave it up to you and the maintainers to judge whether this is
problematic or not, but wanted to mention it.

Cheers,
  Diederik

> Also adds the corresponding iommu nodes.
>
> Note that on RK3588, both cores are added as it represents the hardware,
> but the driver, later will only register the first one.
>
> Regards,
> Detlev.
>
> Changes since v2:
>  - Set the correct IRQ number for the second rk3588 core
>
> Changes since v1:
>  - Set node name to match first reg range
>
> Detlev Casanova (2):
>   arm64: dts: rockchip: Add the vdpu381 Video Decoders on RK3588
>   arm64: dts: rockchip: Add the vdpu383 Video Decoder on rk3576
>
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 36 +++++++++
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 74 +++++++++++++++++++
>  2 files changed, 110 insertions(+)


