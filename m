Return-Path: <linux-kernel+bounces-749252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E0B14BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904D4189DE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D628982A;
	Tue, 29 Jul 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RR03ngIk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFB288C2B;
	Tue, 29 Jul 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783956; cv=none; b=YE09xnN63jVW9IqG7HhS3bsN06Pq//7Xc1nEzHWy0D7h3nN5yYf9+Oub0ySJiSLLY6FN9y+smNPj4lgp2IMSFItLk6Qnu/9oMu3DHwF7iPk8+tWIjq0SoCFZAA6hsgeQgkQmBfntgFiZ1jfRK38j4A90XXOHctT4Nj9Wyqqspkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783956; c=relaxed/simple;
	bh=l45JpMbEyFD0Shr+CnJlAga+Yxcov8Uu2dF6QgMPcvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtSHIzbu41D7v5b0+h/EtZLp137MOjuT3f2bA50UgpbAR8P05f/5Xzahd2xKgIVx4wtpiz2I6LVky01cBXUVN4KVLJpyPp27/O0Arq/G0dcrym9R7McRI/Id9+odU0Hrwi6bF7VXoH3Kmw+izbqDKAd1HcMui3DYGcWQ3f8YL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RR03ngIk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753783952;
	bh=l45JpMbEyFD0Shr+CnJlAga+Yxcov8Uu2dF6QgMPcvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RR03ngIkNg0zObH7QhMizyOvNCD8gjxDB6nGi9aMo82Jbfpmwha+dshtuxV2p/43d
	 oTWrjKEgidakvx4EqhVJWSnr99iTKVkSJSD5kXx2mmSeGLhRdzxOxZNBG1dmYRjce4
	 /bKh+00VAMX1NNFiRqsbxew4J6BuV76ICrUAXLrzzStBvVvP0oy+BDFtOJZfkeGWqs
	 LnNjhPmrU/4LJYNb4o1LtnM8IBvTvMxTxWTARmghgTuS/OY+jeFFW+h+m3K/ULrBGi
	 AUe52ZeZJ+ylhegHJpA4rJ0XoYD3jfIN4RmzVGOAB8Ssw8XDwksVDxlmxRmLyVhxW5
	 58Htzm0Wv+ikw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 088F617E15D4;
	Tue, 29 Jul 2025 12:12:30 +0200 (CEST)
Message-ID: <b4280c72-1f49-458f-88ad-35bde791151d@collabora.com>
Date: Tue, 29 Jul 2025 12:12:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: arm64: mediatek: add mt8395-evk-ufs
 board
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250729093506.273337-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250729093506.273337-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/07/25 11:34, Macpaul Lin ha scritto:
> Add a compatible string for the MediaTek mt8395-evk-ufs board.
> This board is the origin Genio 1200 EVK already mounted two main storages,
> one is eMMC, and the other is UFS. The system automatically prioritizes
> between eMMC and UFS via BROM detection, so user could not use both storage
> types simultaneously. As a result, mt8395-evk-ufs must be treated as a
> separate board.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



