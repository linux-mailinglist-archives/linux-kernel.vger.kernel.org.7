Return-Path: <linux-kernel+bounces-854091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95765BDD840
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7033B2BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0232F318125;
	Wed, 15 Oct 2025 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jxwy1LCo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624783191C4;
	Wed, 15 Oct 2025 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518229; cv=none; b=TeME+7AV/cPsfw9H5oEHGl/MT+chaJbuLTLCaRtlbwxBw6/20L/CU9gbg+q0YIovFcyZNATwJcYKGnVvtdk60wzItepVreXcg+jd1bs0mDA06wQiTC/LD4J5R48kgeS8q4dsNJDkmEF4JEqWej71XXwxu6VkhF3j8NWktqKkUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518229; c=relaxed/simple;
	bh=t29c9PtetIvlXp2obnw6JXqlK2zmWW7fIGiXSexeMgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9L58RPNkpILyPZthfmCeI2Y3lTvHsoeyYGrygeZS3rvbuulfyHxbTc4NVtWJBTUBM9Cgftb+O0Oe0X7jhgDZwI36G/1KSmN3T3yWSM787MdGs9mLPwGN6d3VLhpzISJyw6X7aYVNdcgR089n+Imqi2YAn5iGWGRgAFayjJ+i94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jxwy1LCo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760518216;
	bh=t29c9PtetIvlXp2obnw6JXqlK2zmWW7fIGiXSexeMgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jxwy1LCorlVU2G/siyVim5FEcPV20rrZ4gDiPM0fjx7FIGoPL5hJraFldsbvEg1cH
	 mXse3vmeNjq80z22fd/dBmYnkjBQb5NTWnxxcYlP81egBwJmRoclO7SvBf3vVmzgNK
	 ysr+PspBw5Jf6l5FcgdjeVXNpQFR3CJhhoe5Z0R0HxYPLg8qid8zlsf/+IT5RXg4Zz
	 gGZBGS/mBdUrBRBW2kNyWA6c22wH2m++sHip2qds5qB5YliYRfEb1UTvoKFv/T4fkh
	 7ACa7+rASft6rMcdD/QMHOizCGIz+fPiwUsYBESUdGvRUfqy3PtoQys6ca34quIk0w
	 u1pA1Gb54kbnA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 05B2217E12C8;
	Wed, 15 Oct 2025 10:50:15 +0200 (CEST)
Message-ID: <0848e13c-8eaa-4a26-88f8-a1b7e5da4d10@collabora.com>
Date: Wed, 15 Oct 2025 10:50:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iommu/mediatek: mt8189: Add INFRA IOMMUs support
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
 <20251015032509.5057-5-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015032509.5057-5-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/10/25 05:24, Zhengnan Chen ha scritto:
> Add support for mt8189 INFRA IOMMUs.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



