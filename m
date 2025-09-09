Return-Path: <linux-kernel+bounces-807488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81049B4A509
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597DE179397
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B42522BA;
	Tue,  9 Sep 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pyAO/z+B"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D814A4DB;
	Tue,  9 Sep 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405991; cv=none; b=eeuM1x2Mh2iYemvvMX5efBssrQiqZnbU5ekE0mhxYbT/UySN1wmthjVSjHYdgGUjlFSCxMIuOq3SVnJd4DTSRlwfoS44bwMl64heSOEyemHd7QAWtmXogOCJibcYfF9OcssYji7ymI8JjZOG07tB612ZlxurpQ3p6zeccIFd2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405991; c=relaxed/simple;
	bh=c9HI6QHEnx4SZmGcYwto+EmPcdziqlGyEZf+Cvq1mkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QesZ12RBa6KeCHpV9LMSx0TqZCUIII0RNMCXDmC/Ip3tBaj2vQdgApnhL9SsjTc/7h/LPAxBYXPTMdTrAwQTf/NyfowioiEirOc2APEJa332kSgrg0fSw+SIBZ9gavVY9VFodH9FtpJmyWcVYRAcR+RFVvojhAJp+h9S4jtNrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pyAO/z+B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757405987;
	bh=c9HI6QHEnx4SZmGcYwto+EmPcdziqlGyEZf+Cvq1mkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pyAO/z+B9A0tdgO4emayr/NiYrJcJRQI4Dod2Ftt632RBsne1+oB5UP0IO8AsehjS
	 mjWQYW/240W8yhsF+j0KS50iFDENcV2W56CpyFAlr2mZPDQzVJAlKGEAyFpQt7NTfy
	 IqrZvV8UWvSyBPo7yi254UJVb99vk9vd5KEVTDtLhwbAr2xvVZDh7C4++egbt2p65a
	 X7azCkGgLWyHKtL1w4JDL6TrBgGClw1FODsVbcRBPceqaHAYjNoZ351SK9gFyFxfhw
	 Vbw5e7Ncj70IfJoCjceCBnksZRJ0IdeM5qkB4Hucr3Hto1gSYYnefCHTIxK50Ci1iX
	 V1ExwHuuLAXSQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B7B117E0100;
	Tue,  9 Sep 2025 10:19:47 +0200 (CEST)
Message-ID: <2dcd7668-5928-4376-b4de-e38302dda3a5@collabora.com>
Date: Tue, 9 Sep 2025 10:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] dt-bindings: arm: mediatek: Add
 grinn,genio-510-sbc
To: Mateusz Koza <mateusz.koza@grinn-global.com>, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com, andrew@lunn.ch,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250908130620.2309399-1-mateusz.koza@grinn-global.com>
 <20250908130620.2309399-5-mateusz.koza@grinn-global.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250908130620.2309399-5-mateusz.koza@grinn-global.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/09/25 15:05, Mateusz Koza ha scritto:
> Add device tree bindings support for the Grinn GenioSBC-510, a
> single-board computer based on the MediaTek Genio 510 SoC.
> 
> More details about the hardware:
> - https://grinn-global.com/products/grinn-geniosom-510
> - https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



