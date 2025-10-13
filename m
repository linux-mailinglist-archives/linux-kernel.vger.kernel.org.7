Return-Path: <linux-kernel+bounces-850235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E245BD250F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0427A189A04A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4962FE05B;
	Mon, 13 Oct 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VGuG/2vt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DB2FE04B;
	Mon, 13 Oct 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348114; cv=none; b=Xpbos1LYs7CFxlLLkSLygPzCyvEpmInVa6vEPImSKjdQpS+WUZ2TOKJbN4OM7uMM2kxWpKoryjy68K6zVk+HXuIjNZNMmkzli1PnFabHh7h6xinoK08o1JKeKNkVO3Ngd8wEKlg7JaJcjLKlYgr6FQ/Q/oUg8Gdis4MLRj3xesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348114; c=relaxed/simple;
	bh=/uX2/dDKPfRSFG3Yo/E2dlJAxS2biKzxOGx2S692NdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F93N1QgqO+88LYmzwL/mgRVs5Vxlh/6vbarVrkJXOdVRG1M99DoYXnTfISIah3WPXcjTWqh7cdqqYI26cXLvR0TFbCzemkZb5ND/7s7GfiQOlqIe0v5DrV0QrAAKfCEv7rH4Hw7u2UoUicF2Hk8MsxJod9HyIarN6/HSOLmOFVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VGuG/2vt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760348110;
	bh=/uX2/dDKPfRSFG3Yo/E2dlJAxS2biKzxOGx2S692NdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VGuG/2vtpqzkbIxgSnRfIJED9bpAg/YFGpui5UCzIH0INIQZtIu+GM4xSrKDrECPW
	 1oxFBFtgmnCr7e8XOWlyfh7Bf/x5SvEaOlMnJmXeG0TxdnKMZ2PbNHRNXzUcsNqoPq
	 cpEuFXG/49nzKz2IXnutJuR3t/ow80qlaEImSe6gP/HosmLQ0vd1qaEE063lCSrXJC
	 DNb4/J0N+IFBvzuCa6sX8iBQTYtGR5Ep2zbQEJUZB9veNq7dsf1P8sD1ALZXaOhAJJ
	 RfAZy2tbouWqD1NSwC6AjVEseqm6ewKhPptdi1iOH6mj13a4W5cV0o+e+VMtWoA8V2
	 JZXDcCPVNa+mQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4669C17E048E;
	Mon, 13 Oct 2025 11:35:10 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250918121751.229554-1-macpaul.lin@mediatek.com>
References: <20250918121751.229554-1-macpaul.lin@mediatek.com>
Subject: Re: (subset) [PATCH v4 1/4] dt-bindings: arm64: mediatek: add
 mt8395-evk-ufs board
Message-Id: <176034811022.21265.14554901190334591981.b4-ty@collabora.com>
Date: Mon, 13 Oct 2025 11:35:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 18 Sep 2025 20:17:47 +0800, Macpaul Lin wrote:
> Add a compatible string for the MediaTek mt8395-evk-ufs board.
> This board is the origin Genio 1200 EVK already mounted two main storages,
> one is eMMC, and the other is UFS. The system automatically prioritizes
> between eMMC and UFS via BROM detection, so user could not use both storage
> types simultaneously. As a result, mt8395-evk-ufs must be treated as a
> separate board.
> 
> [...]

Applied to v6.18-next/dts64, thanks!

[1/4] dt-bindings: arm64: mediatek: add mt8395-evk-ufs board
      commit: 3d37117ab43ff57577b922c53ef12260956a9330
[2/4] arm64: dts: mediatek: mt8395-genio-1200-evk: Move common parts to dtsi
      commit: 6af8936fd74f1e4f8fd0087443111bb0348ef931
[3/4] arm64: dts: mediatek: add device-tree for Genio 1200 EVK UFS board
      commit: e6bd92bb204757a7b1f4b4dc263a82b3985fadd3

Cheers,
Angelo



