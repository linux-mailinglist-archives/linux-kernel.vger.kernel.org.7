Return-Path: <linux-kernel+bounces-783087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE88B32937
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67D817E072
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794FA25BEF2;
	Sat, 23 Aug 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yjODS2TT"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126391448D5;
	Sat, 23 Aug 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959809; cv=none; b=ghTXX+mQIcQ9C90k/5CSQBMqOEWGyHxKPIswDM/oLeV/+hsc16Y6iaEvWCvSe1qvZfd7PDRvKUHxTaaT730NgIlAr9f29h1pA8gBa6Ua5ISw3f8+ZLUo0C8GEi4t4usNDlTkKlQTXNbUT3XfXOV2y2oO7ZS7f1k6P7tKV8EhhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959809; c=relaxed/simple;
	bh=b4szslA7ZyoDYxRL5lU3Ry83YPf61pXDu12N9fYlNnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXPT1VqhHKnGW6l8b7W3g0Cs17zdau/J4l0KH3/MzK+IceayQ1fqFSdhpf7JFzUsNafFhjcVBhnQUqCnoMTluOvA85zUyYZ/w2ce2XQ9nkVzIHTLcoY9LFoPE63qNgR+mBPyfXFO/XfLJL25Wy7M8jMA6B9tfrT4yPueN5Rllog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yjODS2TT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=b4szslA7ZyoDYxRL5lU3Ry83YPf61pXDu12N9fYlNnU=; b=yjODS2TTZXqlklgLHaiMWcDNiQ
	3h58mSclKn2EB8t/kPEwPboVfbiLiaNI1DsvIUWrQeJF8TIO935nUGCdEnaQXc80l6y43X1q7klkO
	Hl1DVJ7H/bH6d7s0Mp9YI921h58yRV08oisb7YhIZER4JwC/dbjT8q+73mIGtUJUZkVmVHWjJoCiR
	/rRszLMs/LBnxb6Loqq9EqqL7/QtBXWnEgVt9Y6n6zD/Pxg/FC8pcV5L2C4Jk19z92D/4l7Q79fvG
	Sx9rVGFZ9g28SI9pnX77Fnx7edcRqwxO3W+jKsbziQ24WfQgHVQF2DKYoA3QwwX7p9N5/MOROvwnJ
	V7MRdiCw==;
Received: from i53875b90.versanet.de ([83.135.91.144] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uppMF-0000aK-Bv; Sat, 23 Aug 2025 16:36:39 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: dmitry.baryshkov@oss.qualcomm.com, Andy Yan <andyshrk@163.com>
Cc: hjc@rock-chips.com, mripard@kernel.org, naoki@radxa.com,
 stephen@radxa.com, cristian.ciocaltea@collabora.com,
 neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
 yubing.zhang@rock-chips.com, krzk+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org, sebastian.reichel@collabora.com,
 Andy Yan <andy.yan@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v7 03/10] drm/rockchip: Add RK3588 DPTX output support
Date: Sat, 23 Aug 2025 16:36:38 +0200
Message-ID: <3723317.0YcMNavOfZ@diego>
In-Reply-To: <20250822063959.692098-4-andyshrk@163.com>
References:
 <20250822063959.692098-1-andyshrk@163.com>
 <20250822063959.692098-4-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 22. August 2025, 08:39:47 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
>=20
> Add driver extension for Synopsys DesignWare DPTX IP used
> on Rockchip RK3588 SoC.
>=20
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Acked-by: Dmitry Baryshkov <lumag@kernel.org>
> Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



