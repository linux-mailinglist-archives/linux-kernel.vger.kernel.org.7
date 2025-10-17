Return-Path: <linux-kernel+bounces-858797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A28BEBDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C946B400B84
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C22D63F2;
	Fri, 17 Oct 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HottCExb"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440A2D4B4B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738077; cv=none; b=T/QqAG1vPjW4L26tGbebdjEAtLpFDryO1VwxYn9z33DBbLEQoccHTwx84fFEI96aInANfmSKbxtlAxUQNIE6D1XyfvOoPaCqz5jSMyNwh2HNqO67+auyEnzgalF0YKDZgoO22c1LEXsEoOmpZ1qZEYnD7ogJ74cRzjTXCMmL0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738077; c=relaxed/simple;
	bh=lW4XdgBJOkcKN/TlZ0Lz63xafWJeKH0niPy2qfrrr8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=S7wU+yPuYdqWCt7tvwC2y/J1C8LfG15o714+iamsP1WDeyye3XFXKpJNes6kNTV/Sl7mZMw/BAhlIsGphwxEycFW7n8k59xeULAdm81FWIaXewxoL6GwH6oX0+V0C01Oh32PyJWEeJVbln1NiHfjYvZR4R0/bcK9YkYuV9LRHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HottCExb; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251017215432euoutp02d3bb650123918c476af72b38fbbf8bf6~vZfK95lIt1234712347euoutp02B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251017215432euoutp02d3bb650123918c476af72b38fbbf8bf6~vZfK95lIt1234712347euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760738072;
	bh=jzEO/zPLg7NCIuCZzzVK31d4JnKeturuamPvGa+Aw8M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=HottCExb7WH/k3NuUr32KvIr/0FKgE4W1EbAp4ht0FiPEOJu5zN+ROJYKsG5iaTqW
	 cZgzLz9ylYTQYeNr9WvrRw5SrGdrrosIThVTizTGrjVFB9eCPoGUdLHQneibyhlFFe
	 CzX/86+owYWqnbArulMwNmjCGz45kNQW/e6Scuqw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251017215431eucas1p1b2ace58bb3692056b3e04ff381e03405~vZfJnfVOr1307813078eucas1p1K;
	Fri, 17 Oct 2025 21:54:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251017215430eusmtip165b2f3a99d3141ec3b598b5b325d1826~vZfIlYaL30972209722eusmtip1u;
	Fri, 17 Oct 2025 21:54:29 +0000 (GMT)
Message-ID: <a2b72d27-9207-42e9-835a-5d55c419d96e@samsung.com>
Date: Fri, 17 Oct 2025 23:54:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 0/3] drm/display: bridge_connector: get/put the
 stored bridges: fix NULL pointer regression
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Naresh Kamboju
	<naresh.kamboju@linaro.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
	Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
	<jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251017215431eucas1p1b2ace58bb3692056b3e04ff381e03405
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251017162527eucas1p164f6590949b2149a16c670b7991051cf
X-EPHeader: CA
X-CMS-RootMailID: 20251017162527eucas1p164f6590949b2149a16c670b7991051cf
References: <CGME20251017162527eucas1p164f6590949b2149a16c670b7991051cf@eucas1p1.samsung.com>
	<20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>

On 17.10.2025 18:15, Luca Ceresoli wrote:
> A patch of mine recently merged in drm-misc-next [1] has a NULL pointer
> deref regression (reported here [2] and here [3]). Being in lack of a quick
> fix, I sent a revert proposal [4].
>
> The revert proposal has no answers currenty, and in the meanwhile I have a
> patch that implements the original idea but without the same bug. So here's
> a v2 series with:
>
>   - the same revert patch
>   - the original patch but rewritten without the same bug (and even simpler)
>
> Also the re-written patch is now split in two for clarity because it was
> doing two somewhat different things.
>
> [1] https://lore.kernel.org/all/20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com/
> [2] https://lore.kernel.org/lkml/336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.com/
> [3] https://lore.kernel.org/lkml/CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=Ae5pCW+eU41Bu=D7th2g@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com/
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Works fine on all boards in my test lab.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Changes in v2:
> - No changes to the revert patch
> - Added the (corrected) patch introducing the same feature as the original
>    buggy patch, and also split it in two fir clarity
> - Link to v1: https://lore.kernel.org/r/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com
>
> ---
> Luca Ceresoli (3):
>        Revert "drm/display: bridge_connector: get/put the stored bridges"
>        drm/display: bridge_connector: get/put the stored bridges
>        drm/display: bridge_connector: get/put the panel_bridge
>
>   drivers/gpu/drm/display/drm_bridge_connector.c | 92 +++++++++++---------------
>   1 file changed, 39 insertions(+), 53 deletions(-)
> ---
> base-commit: 84a0a3f014cda68ff10b8517d09e9f0c1cd942a2
> change-id: 20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-9a429ddb48e2
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


