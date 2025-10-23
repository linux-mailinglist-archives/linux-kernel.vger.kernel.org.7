Return-Path: <linux-kernel+bounces-866303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F6BFF6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FA1893546
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C94C2BE620;
	Thu, 23 Oct 2025 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xtr/5YZl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7329DB61
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202575; cv=none; b=nxWAUudFhyrYIlsu7iO+ow6DpYq6qmAB/rxLHYHYP92gDstFG6+r+obnBwRlNqvTNzhSDe2nGrrRuz2udF8dPH8dWxFIIltLpfFAbA58dXqm8/eK/JrYynC7UdDrnVurLRWzHz0bEQaBUb3V+O/g8DFLEaOCNA2P4YQ/icjg/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202575; c=relaxed/simple;
	bh=aGbadfXdorcMPnmwNXVNWcPnkf3aCIvQIT89nWPARCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFafjb9GQqeyH8Fx7ptkLpTLwXT2qaZAiRLgTlg62A6ByP8shA6lY4qnUFRsyXjrl3jVL8TxN/KsIDhw7ZRKt6mPhO4RXFyJK7Wf3W5aTvcFWcaMtLN47Mfz1NM9tzycK5w595U4fx/WWAKPvPWEaUan2601P0z9/lrKnvciVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xtr/5YZl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=aGbadfXdorcMPnmwNXVNWcPnkf3aCIvQIT89nWPARCE=; b=xtr/5YZlHNoxBEPSRG93Jpb/9z
	/pNZd5Xgf1O4YmC64aLItyQI3crzt54lkDeYg2xBWhUDcyy6t/Qq/ZLObRj8pVhTTpUcsLlyT6ZMf
	zjvMUEy0Nn59qkLFt0f7B468C4xVfQy/K3QPwAdHsxBmtbsBHsWl2FcbfVB4R/ZC6+otj4nln3+KZ
	PbKZLuWBui8eSn2yXXuDMnaCRYa1HA23PSzg0q7rPzDNyIbn9GwSmA5r1FXk2SuqP1GBl8i1TZ2B4
	eHze05UMkDQWRgBA2v0w3mbpnyKdgARzG0YVHoH5B4+Hkx7avsZUJ18JvFVIdFL25T49EoYhufKgP
	ahCsokVA==;
Received: from i53875a07.versanet.de ([83.135.90.7] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBpEv-0001An-Ui; Thu, 23 Oct 2025 08:56:02 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] drm/rockchip: Set VOP for the DRM DMA device
Date: Thu, 23 Oct 2025 08:56:00 +0200
Message-ID: <3705026.LM0AJKV5NW@phil>
In-Reply-To: <20251022161948.199731-1-dmitry.osipenko@collabora.com>
References: <20251022161948.199731-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Dmitry,

Am Mittwoch, 22. Oktober 2025, 18:19:48 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Dmitry Osipenko:
> Use VOP for DMA operations performed by DRM core. Rockchip DRM driver
> is backed by a virtual device that isn't IOMMU-capable, while VOP is the
> actual display controller device backed by IOMMU. Fixes "swiotlb buffer
> is full" warning messages originated from GEM prime code paths.
>=20
> Note, that backporting is non-trivial as this depends on 143ec8d3f9396
> ("drm/prime: Support dedicated DMA device for dma-buf imports"), which
> landed in v6.16 and 421be3ee36a4 ("drm/rockchip: Refactor IOMMU
> initialisation"), which landed in v5.19.
>=20
> Reported-by: Daniel Stone <daniels@collabora.com>
> Fixes: 2048e3286f34 ("drm: rockchip: Add basic drm driver")
> Cc: stable@vger.kernel.org # v6.16+
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

just a process remark for now. This v1 so it definitly shouldn't come
with any Reviewed-by-s pre-applied, because this should happen in public.

It's not a huge issue here, because I do trust the people involved (you,
Sebastian, Daniel) and the change is small enough, but please for future
changes, let Review happen on the list, not on private channels.


Will look at the change itself when back home.


Thanks
Heiko



