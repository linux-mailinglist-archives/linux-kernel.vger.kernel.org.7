Return-Path: <linux-kernel+bounces-749250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38427B14BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBBE189B89B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62B4288C2E;
	Tue, 29 Jul 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WxgIlYtv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404E236A9C;
	Tue, 29 Jul 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783953; cv=none; b=m1cJ3rJTM/7iiJcm7x7ahV9BfXhShv7XoWUrHocwKApGAFEmctF5hcU61CcdX42Pkfcu8ldIaRaWUJYy1Uac3lXH0C1cCEElM1EdMVyWCO3ojVt7ifmei+lxKgQ+kuUjeJ+uWRWaRKKEC10mcb7YPbXbdnNUBcFqbUyufBeEnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783953; c=relaxed/simple;
	bh=8x7EzBU5/xt9EXl6eItG8ii6bz9gq6WiYBXMtsDNvvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL+b8NEU9kXgazTJYyFNugBx/aIrDhNkocLiWTojTNzPdUjilxTj0spF6oJ5ZVeEZHbG01DfzBgxoJh7ddaVcqtaGBtyDjOiRIz4lnwtWDOsIHcycqHyB57WzipVPaCCRudaDnuWhZytHMiiqPvGFtDdc56Ocju4BGn76d+nbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WxgIlYtv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753783949;
	bh=8x7EzBU5/xt9EXl6eItG8ii6bz9gq6WiYBXMtsDNvvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WxgIlYtvUGuS0Htfhh33Igv7d740kTERjyFwu/K7elKgMIc56SfNahF71V2z3io2T
	 +yT9a5AN5RuPuo4yUiS9Ny3jgR9whKixJyH1XYeuQ1Y6sw1oWa93OUq4qKyIdrCqgX
	 1mPXjDsVbYcOPf/9tMm7mWbgaj3ythIpw5DzG+XIueNZNsk4y02gis1OVaiHsZ3JCH
	 Cpu65rA1INAVXulckVhVm4TsDfyBDaxSbN4wv4WciWLs4pPrunF87QhDnFCBxee/IQ
	 lKPyDfs33SRrgq2Lbp6i8Nx2Z/Mtj9UbigMjOI6e/1q2te5eSormXr0ouQSYBqxhCJ
	 CfwPCXwXhrDLw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A608517E1293;
	Tue, 29 Jul 2025 12:12:28 +0200 (CEST)
Message-ID: <66551820-45d2-433c-b837-3a0ace37c528@collabora.com>
Date: Tue, 29 Jul 2025 12:12:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: mediatek: add device-tree for Genio
 1200 EVK UFS board
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
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250729093506.273337-1-macpaul.lin@mediatek.com>
 <20250729093506.273337-3-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250729093506.273337-3-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/07/25 11:35, Macpaul Lin ha scritto:
> Add a basic device-tree (mt8395-genio-1200-evk-ufs.dts) in order to be able
> to use UFS storage as the main storage on Genio 1200 EVK board.
> 
> This board is the origin Genio 1200 EVK already mounted two main storages,
> one is eMMC, and the other is UFS. The system automatically prioritizes
> between eMMC and UFS via BROM detection, so user could not use both storage
> types simultaneously. As a result, mt8395-evk-ufs must be treated as a
> separate board.
> 
> It use mt8395-genio-common.dtsi file to use common definitions.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



