Return-Path: <linux-kernel+bounces-854088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79625BDD82E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3EB44FCFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00503319842;
	Wed, 15 Oct 2025 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mUcMJMjH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1843168FC;
	Wed, 15 Oct 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518201; cv=none; b=oG+jr12p9+Jg1ikGQwAppaOsNP4pvOAygrEIxUxV8aAjbezBQEr1E2MRDjBZ0Yo11eG11+bu7yuBDsKS2cJJx4BoAtQimL6Tdbf6bn6hZz4pmusMfHTgyDilSaFjqSsecFSuykPPExuJISwioDzq72K0L4eg7wXyo40168qATu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518201; c=relaxed/simple;
	bh=aY30yly+tkGS5zXJbvh222ZSEsOj5+wwP+oIx+nOBkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsmvmGDAshINTHxlm00GJz3mhI6E66TcqiqXMs0+6WLakiMYS+QawOUuwzUkS15CiHbjEo5KW66f+Po4JNt8SwMg01GtI6pQjx3M+azvTKCWn8emAIyiBZ2/Zxk5gjCG2Pc00BIRc699SdwoD/erVKsF42f15ufMx2fcfmjdGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mUcMJMjH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760518185;
	bh=aY30yly+tkGS5zXJbvh222ZSEsOj5+wwP+oIx+nOBkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mUcMJMjHnh8vPmqIwcdjv9Haez39K5TYaXl8GcMFsaBBsEYH8WuRynYM/p8EvYxd7
	 NHPM5KV4wYcclgdz3WNdEw+5PaBLB4ml3dYvl7HscnuEBHeNUjvf28M5m0LF82YSj5
	 vCrJ8frGibMcq/2unfu080LiEYRQGSR6U3zezEOv4xrNDWTgAlSrdDhRVK1eUFtxU6
	 1bgAYK66jJHsWKWBNr+QRDVA9NZW1VJSX89TPlLADKVPnF6tQocVCqTuVFLSGLEtaQ
	 v9I1GVIVq9s05il89RcDgDMGJ4we2xQ9XrhUH8ijtud/E4gksojfgYBe1B1Unj5GWG
	 Pw+5omfi4wKDQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E4C1717E12C8;
	Wed, 15 Oct 2025 10:49:44 +0200 (CEST)
Message-ID: <4614fe06-061f-462b-8e89-de2c5ff49880@collabora.com>
Date: Wed, 15 Oct 2025 10:49:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iommu/mediatek: mt8189: Add MM IOMMUs support
To: Zhengnan Chen <zhengnan.chen@mediatek.com>, Yong Wu
 <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251015032509.5057-1-zhengnan.chen@mediatek.com>
 <20251015032509.5057-6-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015032509.5057-6-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/10/25 05:24, Zhengnan Chen ha scritto:
> Add support for mt8189 MM IOMMUs.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



