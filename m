Return-Path: <linux-kernel+bounces-836156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04195BA8E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A783A48E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB272FBDEB;
	Mon, 29 Sep 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cS0yyOL7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65458C8CE;
	Mon, 29 Sep 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142008; cv=none; b=sxJq5PQ03107ACQC7qpu8u1w+Jiyn0e1AR42s7pwjK7Xpjpzo3hfdjr18QZKQN2loaaKG3Hhxq8EiY6XmktcJbip4hUv92XJGXR+i4Ena3/fK7IQ41dNE2ClCA9Iuaf4W6boF9Y8BqMAS/r/s/K0zeHUvY57XyG7Pezi4lGaQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142008; c=relaxed/simple;
	bh=HIOAcxzqk55E0UVOj9UZ1f0kcT0/PcCMi9TDvhhcoUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJDprE+/Hqqa1houw618e5QIrwyHKt+uLs84RRdW4TKd7CjW1gH1MkKb8OI7pDsEEQZhU6sS6066u/Gu8LeGpIbfzQBhqaofzU4PCY/VY/+gy6KF1paA+hyb8Ic43VGCOZ0rs+fnra/WyA1T8BkwmyTSOzkB3G+4Lat4/LU0vSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cS0yyOL7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759142004;
	bh=HIOAcxzqk55E0UVOj9UZ1f0kcT0/PcCMi9TDvhhcoUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cS0yyOL7GhFMZIpk4UJcx0VBEulvL0UePHWvnXOZWEGGxlqdzx6YwKr2SI48nD2Wl
	 aRYmwa3g9m9fBXKRoqLkwszIzj0obEEhkz7J7P5oOKM4sx5W7Kc122dX8+6csYGSPd
	 RsxcfHBxd3LvWQrm86qby4p2ofpsOltwT9FP1cUla1SPmjbMvMo8JMk0ZFXpNaImFi
	 SvagiSkK+ADctIiIyVBlsnVWVUtn4vX2tPyNij3n38XXckIzt+bLu4ubqy0TLUEWxw
	 8MEcG1E/9Za2MaqGUKtVfreMwR7G6vD4dlNXQ6F9/qm/EizfWClb/pHyYS7hete89l
	 g78h82wbmJTcQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F43B17E07EE;
	Mon, 29 Sep 2025 12:33:24 +0200 (CEST)
Message-ID: <c35ccf0d-0102-4365-9b89-b1c2f126d21e@collabora.com>
Date: Mon, 29 Sep 2025 12:33:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox:
 add mtk vcp-mbox document
To: Jjian Zhou <jjian.zhou@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250926090505.26267-1-jjian.zhou@mediatek.com>
 <20250926090505.26267-2-jjian.zhou@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250926090505.26267-2-jjian.zhou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/09/25 11:04, Jjian Zhou ha scritto:
> The MTK VCP mailbox enables the SoC to communicate with the VCP by passing
> messages through 64 32-bit wide registers. It has 32 interrupt vectors in
> either direction for signalling purposes.
> 
> This adds a binding for Mediatek VCP mailbox.
> 
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



