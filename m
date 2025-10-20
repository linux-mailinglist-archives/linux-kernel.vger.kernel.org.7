Return-Path: <linux-kernel+bounces-860668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC0BF0A97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D8F94F19C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B902580D7;
	Mon, 20 Oct 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OagfJiof"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44F24EF76;
	Mon, 20 Oct 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957377; cv=none; b=QFAnHvkg+anjvysy5iQuYtJ9I1HAi6fi9rMh/6sQNZdFyZtyJdevGmCpnFwjXFe3WG7O9kxv2oHsdO3TlmETRxeviArUZXLQRPUh9h6WdtJ+3wIAVvZRlI3alzme9qDa10VgMYUxcMqAiawD5HxEJVQu4IumH+EJ+mSAuRAbJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957377; c=relaxed/simple;
	bh=HN+/K46I16uTlwdkKLoi/UZIpe644y9JEvtjWeYfm5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/vMEwEaEnuYPs2yrYDoBY3qcaDkr8l/0N+mBtsyUBoxzO6wO+DTsov7giV8ZSN8M2rCv3ggsnm4p4GawtFczKL5t3DKNXDrvBLPVhlAkmOU7KG49u22ImHUYshIEQXUHTDiW0F5MI37CG/OUcTZDjtZNzsJa4Jg3w9qtYeWjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OagfJiof; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760957373;
	bh=HN+/K46I16uTlwdkKLoi/UZIpe644y9JEvtjWeYfm5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OagfJiofzKVnRI8TJuHUmHK2AlfCvQ7EOLhzX1e1zDpTGw7C9T6qiPpXZbjbqjVqx
	 3iiMiue3mp/D5U5clj/414GfKQRVnDHfLEa9NIfnX6Q3BSB6SPm8e3pXCPEgw9rl44
	 4xl6a85YhX4gyKWlY+XIUjzlsAQ7gZYQTVTcAcoCs2cFxcrtE2O1StylFHkQCWeZr2
	 OeYq23fVNYIZdZcnGuYtjPLM/ff9LN49lqQP+Ytva32ItQA0dx4rIImjwQ+D2x/1LW
	 wl247IYVaBsbIIvg6sPHZ0+woSj32YTeqqhGNrMriSse73OsafHDukUuHTr6NA+Dgx
	 CBS3t+Y9AjypA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 43E6117E108C;
	Mon, 20 Oct 2025 12:49:33 +0200 (CEST)
Message-ID: <71a04ef6-780b-4247-ab1c-c5bbbc24bf25@collabora.com>
Date: Mon, 20 Oct 2025 12:49:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/13] dt-bindings: soc: mediatek: add mutex yaml for
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
 <20251020074211.8942-10-xiandong.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020074211.8942-10-xiandong.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 09:40, Xiandong Wang ha scritto:
> Add compatible string to support mutex for MT8189.
> 
> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


