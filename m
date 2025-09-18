Return-Path: <linux-kernel+bounces-822641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8F4B8460E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A682D623A10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3F303A06;
	Thu, 18 Sep 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nXkpFoO6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98F27A900;
	Thu, 18 Sep 2025 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195461; cv=none; b=pdBpkt3/oozfOvK9XrM91EuOIAPBPud0EiETFXhmwYkz7h05SNUU6A/sexXO9mmAJqplFqHOJp9E0No9LHj0L1eihiOoHPtuCAdFT0oJB103OemWFTtg+09z/cVXrdkzffzHMVGch4DcJmuztO3wBWAwzlLjTOJq6Rhp2gz2N/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195461; c=relaxed/simple;
	bh=knOqDMmCuYGf36S0XJkfDDNgqTE1JBx5Dzln83jT4MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQr/D1dQ1raHQb3drI89bdFI/jzKpNWj+4kglOqeoAwTwEJSTpoLyXLgoAEPrdskGndnW08KZWhiEUP0YoNmozReldaIwlGqPHsHUUPNBdG+HxXdQVBKwZ34+GdCehjYelRZF9m6ock5yGZIu2BxYsKNklxSnCo7GelU/bZi4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nXkpFoO6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758195455;
	bh=knOqDMmCuYGf36S0XJkfDDNgqTE1JBx5Dzln83jT4MQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nXkpFoO6Jxar0bWX+EQ4QLJhk81Du0l8SBBjrEAJeXv5ryrQBJZA1hcimz0grfgiv
	 +AmxfEmFyu6tuCK/TrTRWdBrBfrb2dRQ1qEZpM+Sj7DCfl7h4XkzA1unZDFvb2rCu8
	 0nJN3Ce92B2MqSPDhU+Zjs+kRYH0gMO/h4lphzKexgfwo0BesSmtnmjEkB2SObR+No
	 wm83pKSOrLeLad7DUJsv/+rJOdOsmOmHCMqMgJiJxRw4gFo+8L2HWzg+bpnoeTjlyn
	 f28tlbN8VQqJCHQQKZU6U0g3sCQPb1JwBUvC4tQqPllmQAms/StwHsZ+SzJTtvdRyK
	 n5uEKA7R527lA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 512F617E00B0;
	Thu, 18 Sep 2025 13:37:35 +0200 (CEST)
Message-ID: <b32f4afd-5683-4eec-8da7-a21a9a4950c1@collabora.com>
Date: Thu, 18 Sep 2025 13:37:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] Add mt8196 SMMU support
To: Xueqi Zhang <xueqi.zhang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com,
 Ning li <ning.li@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/06/25 04:56, Xueqi Zhang ha scritto:
> This patchset add mt8196 SMMU support.
> 1. Mediatek SMMU interrupt is low level active rather than the
> standard edge. Process Mediatek SMMU wrapper interrupt and dump
> detailed information when a translation fault occurs.
> 2. In some projects, Mediatek also have EL2 driver, so put the pm
> operation in TFA(EL3), then all the kernel and EL2 could control
> the pm. Thus implement rpm get/put function which send smc call to
> TFA to get/put SMMU power.
> 
> Xueqi Zhang (8):
>    dt-bindings: iommu: mediatek: Add mt8196 support
>    iommu/arm-smmu-v3: Add SMMU implementation
>    iommu/arm-smmu-v3: Add implementation for MT8196 MM SMMU
>    iommu/arm-smmu-v3: Add implementation for MT8196 APU SMMU
>    iommu/arm-smmu-v3: Add IRQ handle for smmu impl
>    iommu/arm-smmu-v3: mediatek: Add wrapper handle for IRQ
>    iommu/arm-smmu-v3: Invoke rpm operation before accessing the hw
>    iommu/arm-smmu-v3: mediatek: Implement rpm get/put function
> 
>   .../bindings/iommu/arm,smmu-v3.yaml           |  24 +-
>   drivers/iommu/arm/Kconfig                     |   7 +
>   drivers/iommu/arm/arm-smmu-v3/Makefile        |   3 +-
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c  |  16 +
>   .../arm/arm-smmu-v3/arm-smmu-v3-mediatek.c    | 536 ++++++++++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  96 +++-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 +
>   7 files changed, 691 insertions(+), 5 deletions(-)
>   create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
>   create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
> 

Xueqi, any followup on this series?

All of the multimedia blocks (including display) become unusable without an IOMMU
on MT8196, MT6991 and newer.

Regards,
Angelo

