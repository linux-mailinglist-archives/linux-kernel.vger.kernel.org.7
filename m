Return-Path: <linux-kernel+bounces-789936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03889B39CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CCE3BCF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8A30FC20;
	Thu, 28 Aug 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uCgKNvwH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824C14A4DB;
	Thu, 28 Aug 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383551; cv=none; b=dB0b1opLYyvKyhJQwWXq5zFj9UtgqUlTtinPY+19OeYhBDJumox7bEUAnZLfpYIQsecCJC7FiXSxFxsHgCKX8rWsE8pH8P1OVhppXOLD4a1hHNnoN7LEGY3s3ovdXGlyOq5DqvJrqNja6/cz5Kwc9kR7Hlov3SVLyCG7C4awt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383551; c=relaxed/simple;
	bh=ccpa80jN/iMnUOp1zdyvmwWqvlXwzc3tg8RBfAhf8iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VigoTyKDON4xcGNWkYuN98YwObPuF2UMXqfNyalki5Xxa9WmyfKaSvmDeJbKB0IWSufM7Tthf4Iebvum00XhUK3vk7e57HO1JkkT8+2wCh9Og2JDiCTPh8r5KzDBRwsfPnGch4UAa6rf7aCfZrMTKF7CQs4PMzFtyjakEMejmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uCgKNvwH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=gRhjEBrevYYfktmYdx+YKcry9xJxHMto6KG5iP6elAE=; b=uCgKNvwHN4Qm9UCbBdv+J4UNw8
	ncy3IW3c63C2jS60Brsl3Ew8ECK6sFq1KxS0SBwam+tzQu+R11/NrUFUAbi+V6e/GSgIGWCevOFtc
	KiO4xdtiWcayAN+5IGdiO2cO9/Z5bs8JDuqn9Jycf2aWrzQlbeXyRQQvIR9MxIzlr6uqQTt+j6NH2
	EmNuI39YK4f1yfzA54Puy52LikT4a7gAaUEWyjsHIQChJCSN01GUsqAQNeclaxLJj0jMIpDFMxzAZ
	W5ea7x2H+niHckX61ns3OCw7/4sN2wxVfM3Y+oZj6M2/10UD5H9hEsIL6ykk6JnZJhmYD/ikuFDxu
	Jf4DvZoA==;
Received: from [185.205.242.134] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urbai-0007hz-0a; Thu, 28 Aug 2025 14:18:56 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andy Yan <andyshrk@163.com>, hjc@rock-chips.com, naoki@radxa.com,
 stephen@radxa.com, cristian.ciocaltea@collabora.com,
 neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
 yubing.zhang@rock-chips.com, krzk+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org, sebastian.reichel@collabora.com,
 Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
Date: Thu, 28 Aug 2025 14:18:55 +0200
Message-ID: <6614832.V25eIC5XRa@phil>
In-Reply-To: <20250828-tangible-wakeful-coati-ec27d1@houat>
References:
 <20250822063959.692098-1-andyshrk@163.com>
 <d040da3e-501f-45d8-bcbb-95fa77e94a59@suse.de>
 <20250828-tangible-wakeful-coati-ec27d1@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 28. August 2025, 10:05:28 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Maxime Ripard:
> On Thu, Aug 28, 2025 at 09:50:34AM +0200, Thomas Zimmermann wrote:
> > Hi
> >=20
> > Am 28.08.25 um 00:24 schrieb Dmitry Baryshkov:
> > > On Fri, Aug 22, 2025 at 02:39:44PM +0800, Andy Yan wrote:
> > > > From: Andy Yan <andy.yan@rock-chips.com>
> > > >=20
> > > >=20
> > > > There are two DW DPTX based DisplayPort Controller on rk3588 which
> > > > are compliant with the DisplayPort Specification Version 1.4 with
> > > > the following features:
> > > >=20
> > > > * DisplayPort 1.4a
> > > > * Main Link: 1/2/4 lanes
> > > > * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> > > > * AUX channel 1Mbps
> > > > * Single Stream Transport(SST)
> > > > * Multistream Transport (MST)
> > > > * Type-C support (alternate mode)
> > > > * HDCP 2.2, HDCP 1.3
> > > > * Supports up to 8/10 bits per color component
> > > > * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> > > > * Pixel clock up to 594MHz
> > > > * I2S, SPDIF audio interface
> > > >=20
> > > > The current version of this patch series only supports basic displa=
y outputs.
> > > > I conducted tests with DP0 in 1080p and 4K@60 YCbCr4:2:0 modes; the=
 ALT/Type-C
> > > > mode was tested on Rock 5B, DP1 was tested on Rock 5 ITX by Stephen=
 and Piotr.
> > > > HDCP and audio features remain unimplemented.
> > > > For RK3588, it's only support SST, while in the upcoming RK3576, it=
 can support
> > > > MST output.
> > > >=20
> > > [skipped changelog]
> > >=20
> > > > Andy Yan (10):
> > > >    dt-bindings: display: rockchip: Add schema for RK3588 DPTX Contr=
oller
> > > >    drm/bridge: synopsys: Add DW DPTX Controller support library
> > > >    drm/rockchip: Add RK3588 DPTX output support
> > > >    MAINTAINERS: Add entry for DW DPTX Controller bridge
> > > I tried pushing patches 1-4, but got the following error:
> > >=20
> > > dim: ERROR: 5a68dcf5837a ("MAINTAINERS: Add entry for DW DPTX Control=
ler bridge"): Mandatory Maintainer Acked-by missing., aborting
> > >=20
> > > I'm not sure how to handle MAINTAINERS changes (or whether it's fine =
for
> > > me or not), so I will probably push patches 1-3 in a few days, if nob=
ody
> > > beats me (or unless somebody points out a correct process for
> > > MAINTAINERS changes).
> >=20
> > That warning has been added recently to make sure that patches do not g=
et in
> > without sufficient review. It's overly pedantic, though.
>=20
> It's not "overly pedantic", it follows the contribution rules. I'd argue
> that, if anything, we've been overly tolerant with that kind of
> practices.
>=20
> We do have a bug with handling MAINTAINERS changes at the moment. But
> everything else shouldn't be ignored: either patch MAINTAINERS to
> reflect the actual contribution path, or get the maintainers Ack.

$ scripts/get_maintainer.pl MAINTAINERS
linux-kernel@vger.kernel.org (open list)

MAINTAINERS does not have a maintainer though, to Ack a patch changing it



