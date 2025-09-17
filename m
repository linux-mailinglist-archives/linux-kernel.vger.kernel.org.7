Return-Path: <linux-kernel+bounces-820743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF1B7EC99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561FD7AC7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776A3090EC;
	Wed, 17 Sep 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RfG/9ifM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1332FBDFD;
	Wed, 17 Sep 2025 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113757; cv=none; b=Ji5lcFJmCLJCFPIF+b0SC1abSgkt1hRqt4JVY02trId8OqXGpz77io4W2+9hDJbbcPGONg1wesPYqVU5F7Spg4Lchbt8cW5Y4cpji69Pm9C5IfsHE84F89aSywcUia3tkGF2b/VFOC1/Tx9Dlx1BROjUBp6Hy/1eAY2GMXdT7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113757; c=relaxed/simple;
	bh=iM1Ge96MSy9d5GIEcr9i2KqaPvJKQbrBss9JVjoE4n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxI6rZIM9ADiaBZ5nYf1b4XIWUTgAtP3IVDLwqNcj9reVu9uaOUKBpCl+U1aw4fvve1XovcrWeKxBqZd9esAkTwZCCt0qi9GTh8wcjWyRCZcITQtLOhu6p6RMo60Z2Rg/Ypq0WigO+wBBz5cTMWKF3eSNFeLaRKuKecN/j6ovRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RfG/9ifM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758113754;
	bh=iM1Ge96MSy9d5GIEcr9i2KqaPvJKQbrBss9JVjoE4n8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RfG/9ifMvBEGFEIC+XN9CijgdpmIfuqmstTEZ4/8BemAIF1WmT9Cxhglj8HWkARE1
	 /olCpzXlNG9855fxB+akysWcMeTTptfnKkO7p9P3N+6GBv7dPBFKWJJO8DvzMfmksj
	 O5vxUdHM/roQO07ztvBHVGVpyaDAHP3+9EPj+tbJa308CC40txRguesvpLgADE+eU4
	 MVF8/TW86xlpH2pgkrxj7rkjWpbGYaoc72ogUVdQqrHKB4uqShZUn0qMnx6zRd8AD3
	 z1Txld4j0es2zYZ6dIN7zWwiqpptBhjBE6wfYuOig2O3c4CTnggeGFJRPAV5iGjh7r
	 PVn8bULGZsLmA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A9B4317E0C21;
	Wed, 17 Sep 2025 14:55:53 +0200 (CEST)
Message-ID: <1ec8f9f5-fd61-47ff-b9c3-437fba7f17f4@collabora.com>
Date: Wed, 17 Sep 2025 14:55:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
To: Friday Yang <friday.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250917120724.8650-1-friday.yang@mediatek.com>
 <20250917120724.8650-3-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250917120724.8650-3-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 14:07, Friday Yang ha scritto:
> To prevent handling glitch signals during MTCMOS on/off transitions,
> SMI requires clamp and reset operations. Parse the reset settings for
> SMI LARBs and the clamp settings for the SMI Sub-Common. Register
> genpd callback for the SMI LARBs located in image, camera and IPE
> subsystems, and apply reset and clamp operations within the callback.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



