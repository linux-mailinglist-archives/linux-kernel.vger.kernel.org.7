Return-Path: <linux-kernel+bounces-854089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7045BDD83D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C30E19C2734
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8B318129;
	Wed, 15 Oct 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k/Utm4TI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5E3168EB;
	Wed, 15 Oct 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518205; cv=none; b=U/usj85RMvzHrzomTO+O5PC7woU+sYxgwtoGFqaNe1bDPinRyOTFStI1Qj2fU91wBvUde0bIxIohgfZ2+Ps3iwKcprId+COMOAs3fQVJul0sG8035v4NT4A+UdSieo9Pxmt9P+1PCINdLV5sOsY0fAKvSMnBLgk8l1l+5cPXVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518205; c=relaxed/simple;
	bh=yn1ks2heKSsmo2MZYoR1wSCC8e1kYOiFpMfzPzh3yvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRp1CDoF9I/Y5c9aobqFa/8loGYbDHU3tA9iVxPU4nzsKei2pWQUqubvUhUkHlyvHSWXC48hxvO0CCm9kdJa03qWG+lXFejPcIGPXI+pb8msbSkTHZt6hBckNIIGuwjs8y0GtpG2Hva7dIaeJsHnErmu7+pjcvUVmT/6/1I7yCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k/Utm4TI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760518186;
	bh=yn1ks2heKSsmo2MZYoR1wSCC8e1kYOiFpMfzPzh3yvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k/Utm4TIUGQilymOrYxwYFmumpX0wlq0j2Vmek7or8K31CrN3cIQ464L5pyi9oQbS
	 lU48rixwN1Li8KFbsoYUFNNaw3QQYAhuHuaRKTKFSYxJ7+Aeqqaxc52BqakDjVQbTL
	 SCOyzQF86gv0p/R9rkokMAPscHloc9xCFNBYlEJ/YjA7OdvEkPCCN8XbdZerpgfAJZ
	 R/YRIjRF8zKXnafPZSaJxyXB8GjAOO01Pe+4U1TiJnwnvnSGQEWY7Sc8CB3Fe9DXCj
	 I9SXSiqNPWuZBF7CSkjLwh25wlzVnOycwAgNOruw8PTnYgyNbg8gvuGqEHjtVnJjx4
	 IaZ099ntgZGug==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DEE7617E12EB;
	Wed, 15 Oct 2025 10:49:45 +0200 (CEST)
Message-ID: <707832a4-47b9-4c31-851c-07d129cada12@collabora.com>
Date: Wed, 15 Oct 2025 10:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iommu/mediatek: mt8189: Add APU IOMMUs support
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
 <20251015032509.5057-4-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015032509.5057-4-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/10/25 05:24, Zhengnan Chen ha scritto:
> Add support for mt8189 APU IOMMUs.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



