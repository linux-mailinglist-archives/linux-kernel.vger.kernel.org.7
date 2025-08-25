Return-Path: <linux-kernel+bounces-784937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D8B343A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE418914DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6A2F0C73;
	Mon, 25 Aug 2025 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QkKS3Urm"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442971F869E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131955; cv=none; b=bnwuiqAyGDXVbdDLQBxI+QJoBFi8WXzDNgk4/Y9w63Pi0dZwisWBAcz9ZB+0G5UiFayTxmyMbKjNM3pjY6+GL6h3aeIGR5Zmm1SDWZHKv+72Fq+LEW2znxC0slf9zm1k8daUGngAPUHd2ynGfyxn8fuEJy9bhzK1QPLa0ECqf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131955; c=relaxed/simple;
	bh=aa+clsjb86Yw77XTrkq6JqKULQ6u+ZqExkRbb2dCClI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Dblmu7c5Rw7WI9dEYEaBzTdWPn/seKDaBPq33OJf886DuUUB6lhBlZRvc/2WEOwaK7IYRSpSpRgss9rFiHO/qxc+mlcXq7z2xlQYvHM0psJ2Inpl4XbBOux3jOfr5a3WOFXWG7ypf1drRK3PWUg6pU926dT97IKtJ4nd1KjC56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QkKS3Urm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250825142551euoutp0188c5f2486650c30834ac11e6f94c3759~fCLSOaB0l1749117491euoutp01j
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:25:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250825142551euoutp0188c5f2486650c30834ac11e6f94c3759~fCLSOaB0l1749117491euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756131951;
	bh=g3XJAjkAnzmoOp83cZ+/QTzl+YqbNa+8BJauT66leBE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QkKS3UrmhpcD7fFMVhrCCHevrHqDbSbdEKM13h/uKfWCrmqZ3csjBPCt9AVs+COOU
	 hLaE25Hoq8Zbdv/Jkxv++kPM6aadXAV3AKIbABOE5NFNsgQbkY5DF5XXJR87Tdm4Ts
	 6UUUIC8MYdbf3A3F9UqM3ITrTU660NbrslIYHcGE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250825142550eucas1p2a783ce9d7b9c9b3cc276a567c09d53bd~fCLRke9wg0835608356eucas1p2s;
	Mon, 25 Aug 2025 14:25:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250825142548eusmtip19c6a58beda39ce7e243556a6f67cfe22~fCLP0ynBY2717327173eusmtip1-;
	Mon, 25 Aug 2025 14:25:48 +0000 (GMT)
Message-ID: <a9ae1238-e95d-46d8-9bc4-0ef5ec7c34bb@samsung.com>
Date: Mon, 25 Aug 2025 16:25:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v1 0/4] Apply DP helper APIs to do link train
To: Damon Ding <damon.ding@rock-chips.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org,
	andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250824084529.3317985-1-damon.ding@rock-chips.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250825142550eucas1p2a783ce9d7b9c9b3cc276a567c09d53bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250824084543eucas1p10fcc1e6656f3cc3909d457ae9e0199f2
X-EPHeader: CA
X-CMS-RootMailID: 20250824084543eucas1p10fcc1e6656f3cc3909d457ae9e0199f2
References: <CGME20250824084543eucas1p10fcc1e6656f3cc3909d457ae9e0199f2@eucas1p1.samsung.com>
	<20250824084529.3317985-1-damon.ding@rock-chips.com>

On 24.08.2025 10:45, Damon Ding wrote:
> Use the existing DP helper APIs instead of repeated self-defined
> interfaces with the same functions. It can help make codes more
> concise.
>
> Damon Ding (4):
>    drm/bridge: analogix_dp: Apply DP helper API
>      drm_dp_dpcd_read_link_status()
>    drm/bridge: analogix_dp: Apply DP helper API
>      drm_dp_clock_recovery_ok()
>    drm/bridge: analogix_dp: Apply DP helper API drm_dp_channel_eq_ok()
>    drm/bridge: analogix_dp: Apply DP helper APIs to get adjusted voltages
>      and pre-emphasises
>
>   .../drm/bridge/analogix/analogix_dp_core.c    | 123 +++---------------
>   1 file changed, 18 insertions(+), 105 deletions(-)

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


