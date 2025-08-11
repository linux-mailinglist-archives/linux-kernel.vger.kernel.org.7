Return-Path: <linux-kernel+bounces-761938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F39B2002D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BD83A27DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F62D9493;
	Mon, 11 Aug 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="kWvXntYy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4F3FE7;
	Mon, 11 Aug 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896779; cv=none; b=IjwFhOyAL5I3Aa0ybT678IV9sNN/TQEGeiGgPMDAaPtRhroaG5gwk2jmzQeLuQCJ0NjqBHNUh+1tovP5j8xC8J3Ftz/daWj71p5+VXP3lD0Qho274jxyD9pUtYP4miXIWeVLZHLPks6OWDfFSWLn3Kunl1u0pK8Va/PQ6EnRELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896779; c=relaxed/simple;
	bh=zkb/rSuCpqQhzGZFk68MecxNwLP71qQupr3vuJOoK78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhVdKuoiCaRohzwi+2CU3sxxBwjNEOKGPvMjhxaBqG25K8KkrfOSrMEJ1amHaDUsXlDAFLwKp4CHtpWG9sTWKAWBVN56rBZumL8TOzK27qjZQcewTt9hihIfbkNmivKZl9ifV5EsUvbGrI0sbZrmHSRirOS5tj5Rk+dWmGJNhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kWvXntYy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=yCTYvc2Ip+c053RNHSzHAiqexa5hAOSQh9k+/5us8HA=; b=kWvXntYyVQgVlSgXMcsvAiBFlp
	oUv3Ki1sAVUHXt3aWhyc8oFH7PHGRuxgcaZZwdlt+maZD7unEa5JVlDKMfuaagGkRbfuL6OxKWRk7
	W0PwK0ZBVu0gp8Dq+Y7+o+XYE5UpAHTkm60/KSNVi/FtU1CFMWPpVbpGk3AhtpaWSp4l+Gnm34xvd
	e0LcNY38YtA+47Nod4ePky3lwTCXHhbW0D+D/qrng4jXkwxtLuj1z5Yid6X4lAY2Z3cV/iVAEGeTi
	bwHeylJ0KhbIj0oH9gcQ0RtLjSW8npttDDXWgCdmTB/KU7PXnQcWE/Un2d+8Y2mrnFaekSXdEb2vh
	+y1gWBpQ==;
Received: from i53875a0c.versanet.de ([83.135.90.12] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulMoc-0007Ef-PO; Mon, 11 Aug 2025 09:19:30 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 damon.ding@rock-chips.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH v2 2/2] arm64: dts: rockchip: add RK3588 DP carrier from Theobroma
 Systems
Date: Mon, 11 Aug 2025 09:19:29 +0200
Message-ID: <10574731.0AQdONaE2F@diego>
In-Reply-To: <0582b7bc-e5b2-4b5e-821e-8d2c4301579f@cherry.de>
References:
 <20250723190904.37792-1-heiko@sntech.de>
 <20250723190904.37792-3-heiko@sntech.de>
 <0582b7bc-e5b2-4b5e-821e-8d2c4301579f@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 25. Juli 2025, 14:29:12 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Quentin Schulz:
> Hi Heiko,
>=20
> On 7/23/25 9:09 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > The DisplayPort carrier is a very simple baseboard only providing seria=
l,
> > ethernet and a displayport output.
> >=20
> > But its main functionality is that it routes the Analogix eDP controller
> > to this DisplayPort output, which allows to test that controller simply
> > by hooking it up to a suitable monitor.
> >=20
> > The Analogix-DP controller supports eDP 1.3 and DP 1.2, so can drive
> > both eDP displays as well as full DP monitors. It does not support DP+
> > so passive DP-to-HDMI adapters won't work.
> >=20
>=20
> I tested this on master (2942242dde896) + v2 of the eDP driver as listed=
=20
> in the cover letter, or with v3 of the eDP driver +=20
> 48f05c3b4b701ae7687fd44d462c88b7ac67e952 and in both cases I have weird=20
> behaviors.
>=20
> First, `reboot` is stuck for a very long time before actually rebooting.=
=20
> I think you have a stacktrace when you tried yourself, I don't so cannot=
=20
> send one.

I tracked this down last week. The hang is easily reproduceable and the
fault of the PCIe SMMU. See
  https://lore.kernel.org/all/4400329.mogB4TqSGs@diego/
for the full detail.

TL;DR is, SMMU without users (and thus clocks/power-domains/or whatever)
hangs on reboot.


> Also, I tested on two different DP displays, one has a green tint, the=20
> other one purple. When trying out other resolutions with modetest, the=20
> kernel would often crash (no trace, just nothing on console, SSH dead).=20
> Note that the same HW setup with downstream kernel from=20
> https://git.theobroma-systems.com/tiger-linux.git/log/?h=3Dlinux-6.1-stan=
=2Drkr3.2-tiger=20
> works just fine. I would assume this has nothing to do with this Device=20
> Tree patch here but rather the eDP patches missing some bits maybe?
>=20
> @Damon do you have some idea?
>=20
> The display with green tint is a Iiyama ProLite XU2294HSU and the one=20
> with the purple tint is a Dell P2319H if that helps.
>=20
> modetest output: https://paste.debian.net/1387797/.
> modetest output with downstream kernel: https://paste.debian.net/1387798/
>=20
> The Device Tree looks good to me otherwise.
>=20
> Cheers,
> Quentin
>=20





