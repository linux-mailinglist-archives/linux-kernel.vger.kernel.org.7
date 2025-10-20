Return-Path: <linux-kernel+bounces-860667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D36BF0A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A17974F1B90
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4561FBEA2;
	Mon, 20 Oct 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kjZ+jMoI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7A2494F0;
	Mon, 20 Oct 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957375; cv=none; b=pnZFevczFfcd8JoeYTJobE4QOxdj8UpxR8cz5JJ35eUuvB31gCsDgUi9K/ufx9GirDhEuwI4+YGk6AzeM0w5b/JuRwPjmak8i27ko2PdNJA+5GS2CJ4DHNuwF1ufigknotA2OjmVVi7b7OMTtQfQUh7EbzZIBxk7s+EsChr7gRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957375; c=relaxed/simple;
	bh=f5NRPopbIABr/yUWGqy22uRXN9XPujqRZDh6gopa+Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pB6Y1K7jXIIKf3c5C/YFrPSNTYQC0nX5GGJ4NlyhKSyCV2y/tL337Y3TbsdQ/W5/BIw2IFahThEChtRi2DWkhQq1fBo1SUDQBdULSVqyaqhZAq2/8/rMt3ThyGJom3kFUDNrMfDWCI/y4IddPzrx2Y8QQampEu4NXgwahbSaDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kjZ+jMoI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760957371;
	bh=f5NRPopbIABr/yUWGqy22uRXN9XPujqRZDh6gopa+Z0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kjZ+jMoItKSMENuJPgHOULI6VlerddeI/0mwdoYHSgD1nPKueD8y6IzGkQc8lcWhl
	 rJwWDLouNiMC6fuCnxt3UTTs07Ifv5R3QwDzJljgnHNsUSyoVfRnvYCdNIFV3AfSK9
	 gSFx17+UQKU8hMAab7EHCTRGcs1BlSY1bqT8TO4o8EL/FU1+eCMy23/xDW0xHN4WKC
	 rP81tMKXwnGJ3jSv0zFLFBmp9UzG5mBWqHv65zI0jw85yxkrb4UVngAX/JAqxPyV9N
	 zXmVOgH3asNjzUgn++aQ1u11pK659XdhRCJUas+YM425WOSgYLKnwwTXfMjrf/0Lyi
	 hxqYF7Cin25Ng==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE99117E0FAD;
	Mon, 20 Oct 2025 12:49:30 +0200 (CEST)
Message-ID: <c55fc496-e297-4b11-88e6-c4b6fa27d8de@collabora.com>
Date: Mon, 20 Oct 2025 12:49:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/13] soc: mediatek: mutex: add mutex support for
 MT8189
To: Xiandong Wang <xiandong.wang@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251020074211.8942-1-xiandong.wang@mediatek.com>
 <20251020074211.8942-14-xiandong.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020074211.8942-14-xiandong.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 09:40, Xiandong Wang ha scritto:
> Add mutex support for the main and external displays in MT8189:
> - Introduce a new DVO1 output component for the new mutex
>    settings of MT8189.
> - Add a need_sof_mof flag to configure both SOF and MOD settings
>    for the output component.
> 
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


