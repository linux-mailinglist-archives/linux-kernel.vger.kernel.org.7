Return-Path: <linux-kernel+bounces-813641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2677BB5489A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49FB3ABD45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D1C2DF130;
	Fri, 12 Sep 2025 10:02:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13122DE6F2;
	Fri, 12 Sep 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671349; cv=none; b=d6Ecjfo0KMCLZHjtxbZlFZelgpqNdSly8iCpiupsyXZ8S7Gb5CygkCBTeC4ayfXzgNR/LvB/MkpriWGxZsuB3/mUIuLV0JyXmFrAc5aHSblwMBtoJGtWQt0DME0TBLPueZF5Uza8bXq2EeE9lw3ECRkoRBF6FI1nIBFjYb1PYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671349; c=relaxed/simple;
	bh=9fd4moaFirXIgIXD/PREJNEJShmx3iq+ajpwK/yIZeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBH8oZ69FhEDz41Q4/g9B3LPqdiv2Ew++2glhBUj4eVwvDOU1kzQyB7WSRGYuKsWxGpM1tnatgC8A1MMlgol8dhuAlyTHOPdD2rOEiWIntOypqzJFx+v1lyLBgulujFZN8R+Ysd1pnqOvH53GOrfGrbYkioUsAhBKXUB8H7PdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A59116A3;
	Fri, 12 Sep 2025 03:02:18 -0700 (PDT)
Received: from donnerap (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FED53F66E;
	Fri, 12 Sep 2025 03:02:25 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:02:22 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "J. =?UTF-8?B?TmV1c2Now6RmZXI=?= via B4 Relay"
 <devnull+j.ne.posteo.net@kernel.org>
Cc: j.ne@posteo.net, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Initial Amediatech X96Q support based on Allwinner
 H313
Message-ID: <20250912110222.5e4153ec@donnerap>
In-Reply-To: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Sep 2025 01:52:08 +0200
J. Neusch=C3=A4fer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrote:

Hi,

> This patchset adds an initial devicetree for the X96Q set-top box.
> WiFi, Ethernet, and HDMI depend on drivers that are currently not
> available in mainline Linux, and I didn't enable them in the devicetree.
> The builtin infrared receiver produces IRQs when a nearby remote sends
> events, but I have not checked whether the events are decoded correctly.

You can either do a simple "cat /dev/input/event<x>", then check whether
keypresses generate (unreadable) output, or you use the "evtest" tool to
decode some information:
https://cgit.freedesktop.org/evtest/

But I guess if you see interrupts consistent with remote keypresses, it's
a good enough indication it should work.

Cheers,
Andre

>=20
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
> ---
> J. Neusch=C3=A4fer (2):
>       dt-bindings: arm: sunxi: Add Amediatech X96Q
>       arm64: dts: allwinner: h313: Add Amediatech X96Q
>=20
>  Documentation/devicetree/bindings/arm/sunxi.yaml   |   5 +
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts | 235 +++++++++++++++=
++++++
>  3 files changed, 241 insertions(+)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250911-x96q-57e63380804e
>=20
> Best regards,


