Return-Path: <linux-kernel+bounces-842810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C47BBDAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB14E3B839A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F792264C9;
	Mon,  6 Oct 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kZQHbgFE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91CF220F37;
	Mon,  6 Oct 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745999; cv=none; b=FURWQB0sQsT1s7x+/yWzxYc2k6dNgPTmmxSFqvrNNxzXSFa56I78BzB8Yw1z8S/1VGSUEUUp7Bz6H3jubgeC+ouI9aSfGVxUSnDcd8frknYodCdCdY4ifVl6KdaUUQdBarFU1MgqRywMlWOps+PenzQ5qtRqA9375gKbUUxuNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745999; c=relaxed/simple;
	bh=FGngKFGUOoQ67NlKMtIhMKfRHDJUydjDXUVwZnGvaXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ce4VqZUS9WRq/OwVI9tHHM4fqIP2zsDw501jhgzhDoMeYy0mnuxPUWRSoeJGTcM8ANL7yEGp2vb7f3VHofo/C/KIjjNw2mJt3ZrVJeMyItXHBFx0nY67f4dURhslXxGkA4IO8wLsrgt7L6FJnDLfmtQ1rRvNOenFh2SApUVVbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kZQHbgFE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759745996;
	bh=FGngKFGUOoQ67NlKMtIhMKfRHDJUydjDXUVwZnGvaXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kZQHbgFEVkqzqny8xB1KGVW+PH0YijNBjcE5e/BG2gLnrJwsAbtVTFxphRzMbryFJ
	 BqpJ9mDYcX46oFqbPoitbFPWL8KYRytLQ21LSOgY0t9h8Hww4ElKdfbNyDt65icNaO
	 xWWy9DGhjKnoV5GxnD3QBlfu1lzTqKNFoeJqJBPp806DegVfMZPCJroc/fQHYbGtCq
	 Mf699NiE0gIytJMSE6ZAICcdvlexlf/H251cE7N3PbNS0fT27oB1mu6N+FUQWeI3dV
	 5IMnatuhl62PG4GmRoc98tuaMHDUQZds/PMtwV8Z6NMg1zkGZSQs3onk0qM78Lfoze
	 knPNyxmoN4elA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A34A17E038B;
	Mon,  6 Oct 2025 12:19:55 +0200 (CEST)
Message-ID: <e03fb71c-5d50-40c6-b6f8-965319f472c9@collabora.com>
Date: Mon, 6 Oct 2025 12:19:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: fix device use-after-free on unbind
To: Johan Hovold <johan@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>,
 Ma Ke <make24@iscas.ac.cn>, Sjoerd Simons <sjoerd@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251006093937.27869-1-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251006093937.27869-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/10/25 11:39, Johan Hovold ha scritto:
> A recent change fixed device reference leaks when looking up drm
> platform device driver data during bind() but failed to remove a partial
> fix which had been added by commit 80805b62ea5b ("drm/mediatek: Fix
> kobject put for component sub-drivers").
> 
> This results in a reference imbalance on component bind() failures and
> on unbind() which could lead to a user-after-free.
> 
> Make sure to only drop the references after retrieving the driver data
> by effectively reverting the previous partial fix.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Fixes: 1f403699c40f ("drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv")
> Reported-by: Sjoerd Simons <sjoerd@collabora.com>
> Link: https://lore.kernel.org/r/20251003-mtk-drm-refcount-v1-1-3b3f2813b0db@collabora.com
> Cc: stable@vger.kernel.org
> Cc: Ma Ke <make24@iscas.ac.cn>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Heh, nice!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



