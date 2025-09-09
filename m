Return-Path: <linux-kernel+bounces-807489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04A8B4A515
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BA13B945F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C50254846;
	Tue,  9 Sep 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MonSk/cT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A64323E35B;
	Tue,  9 Sep 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405992; cv=none; b=BlZ7yGSSDZD8G4QmpSw3uHkZbxy3dlxNO7DkyYar4ByxBOHOc7vK/N9jz0eGGRP2tctxmwY3hv0KTWRxEXyCZW0AIQaXRg39zi2KIcpynKK5snRbqGbw10X5fxQ/aTskPhT2EEfMlGezPEpd8EYpzo0RkmvsiX+SCxww+uzXizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405992; c=relaxed/simple;
	bh=ib10Ikrck1ITj/Qwrm0G604sOfeD+hWgdObHTi7gHMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTO1w7i4AWkbC6ZApn/m511+MIWpB3Yw/05H9SJjbshuhZW3s7HFpIiNT2n/x9CDMZypXlUi5iQexF+TRLLgHwkD/AZbr+4R0Glaoo2N6J6kI9dArDeIqitEgoFqqb2zki+8F94DCu3HQlDBi3KIPb4NIMiSW2t++pZecKEb4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MonSk/cT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757405988;
	bh=ib10Ikrck1ITj/Qwrm0G604sOfeD+hWgdObHTi7gHMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MonSk/cTG9nqqUyR1rBPxC8jCTrqOuYiG6IfFPameaebVNAh/5proMiievuNWlrUk
	 Xi5YZwEkY/SLR1YGCc0T1NKM19mU903KCMHyc84mnLd5t9e0RnpoyZQDaX7qYlbhTz
	 285TPvhc3PKZ3bjE1TiexqU3DJo5MY7Fhn00fsjSR9dbWWOX1Q9a62sDqhDsm9LL6K
	 0JySlBCxAGZG/CUtKpPoy8yKULtqveaBvTIHR/e6BiiguS18IHAGsmOWUFDdzIg9My
	 fOhQQYGX6/vVxjTpO02oygarybATQ2dFKX+Vu4C/zic5iwKEfIguHcHJC+M8yv6NeN
	 vOTYy89QqNEOQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F419C17E0FAD;
	Tue,  9 Sep 2025 10:19:47 +0200 (CEST)
Message-ID: <75015c6a-f054-4d13-b8fa-183c512fa52e@collabora.com>
Date: Tue, 9 Sep 2025 10:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: mediatek: Add
 grinn,genio-700-sbc
To: Mateusz Koza <mateusz.koza@grinn-global.com>, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com, andrew@lunn.ch,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250908130620.2309399-1-mateusz.koza@grinn-global.com>
 <20250908130620.2309399-3-mateusz.koza@grinn-global.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250908130620.2309399-3-mateusz.koza@grinn-global.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/09/25 15:05, Mateusz Koza ha scritto:
> Add device tree bindings support for the Grinn GenioSBC-700, a
> single-board computer based on the MediaTek Genio 700 SoC.
> 
> More details about the hardware:
> - https://grinn-global.com/products/grinn-geniosom-700
> - https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



