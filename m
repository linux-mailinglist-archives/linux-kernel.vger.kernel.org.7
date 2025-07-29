Return-Path: <linux-kernel+bounces-749251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF92B14BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86B4189D523
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4E289346;
	Tue, 29 Jul 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="puh+mggR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AB288521;
	Tue, 29 Jul 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783954; cv=none; b=avfWIfyRXdBE6B7I91ZWwNQGxAe1EEt8Cu/TXQ/pV9NaKpWAIClJify9vRJa6egHhtRrj38Fil+FAY9SebMVcuG7Bgu3Q5VxjDBGFYFrcK/SWftT8DsCyGWuHhZQbuayzpApbLWVml7ZZavGT6rpl9jdEGb5nowvcQDG0sul0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783954; c=relaxed/simple;
	bh=N6BzpzMJ9nqQW+m6yOXFimAfKZGre87KRZn59AZZOJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr5ZbZjGm5ZHWEJAQZF0QO6TX0fgpGzrl0KCfGO6agktpMc4QINE79RVGvPHH2bkRK8tEt7H+2efnNicKLGDOwkWRx6gDP6qOLYJQFDCZ56YrF/iRJmQWGm56igV5xD5WSzk7PmHUAR33c90qb+mS2HH9jeHAVUFNzyKrduMKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=puh+mggR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753783950;
	bh=N6BzpzMJ9nqQW+m6yOXFimAfKZGre87KRZn59AZZOJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=puh+mggRobH5gbOmcv6zTsN/jEfIcFo6nTxIal4dV6u7CaUC7kl4n6+JecCJwrZ9e
	 JJDRykhI+7xLfHlhmpsezufPIGeabAkwbWRZmlFA55gQDTvX6zECTpiLfGnbQ6tdCA
	 hmamDWYoazYoYbrp07Rj8lNHpriDdx/Cqkh0QVBdWcTWDIWCqQJDBNCm2AMrOiXZcE
	 w/5gH2KI+Dis1M7JBgBPef4pOzfU83g8dvfiOdC878ak2BuhdiT7h2XSLnfKekEDIa
	 lLYrMB1A4SyYKUoFztYJXdOQD48ZptNKi3U0Z//N7pH2idKDqSusbUn8/OckdYmrsC
	 nG4Ip5pAxyR2Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C8F5A17E130E;
	Tue, 29 Jul 2025 12:12:29 +0200 (CEST)
Message-ID: <571bf870-f619-49c6-ac31-baf3abcbe9b3@collabora.com>
Date: Tue, 29 Jul 2025 12:12:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] arm64: dts: mediatek: mt8395-genio-1200-evk: Move
 common parts to dtsi
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
 <20250729093506.273337-2-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250729093506.273337-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/07/25 11:34, Macpaul Lin ha scritto:
> In preparation for introducing the Genio 1200 EVK UFS board support, split
> mt8395-genio-1200-evk.dts file in two to create mt8395-genio-common.dtsi
> file, containing common definitions for both boards.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



