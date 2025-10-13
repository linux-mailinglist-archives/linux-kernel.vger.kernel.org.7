Return-Path: <linux-kernel+bounces-850238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500BBD2521
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443DE3A4107
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3B12FDC59;
	Mon, 13 Oct 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dv3pEdxu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97972FD7D3;
	Mon, 13 Oct 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348165; cv=none; b=MRrhsGVPiUoL0V4kRvZad/spd4E8AJtiKcqklKFI8LCZTNqsYQxbrKdetRDU4GoWNd98mdPyInkFzb76aEVMsopCriAHTR7z7HoghkZEVAHGgomsXgoo/UIIULeaY3XQEMCdITKTAMCyGxR6+xBV5mzCgueshiHmYyP7HTbkhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348165; c=relaxed/simple;
	bh=k2yftSbq+5d+v9hZZrUZktEn1hoBtyA2dFQC4cr/uzE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DoEqa239EGe5iG+PTpwMp0rzbVm4rXd6cAggOlrP7K+T47mQImTrhwz2dWtbxzDQf8xxJMmTRuvmcurAf71hKAhWtvs86eALACpaxAzlIAvlDj7naJSlq1dbz3vXFRq192oHCOyeJ/uR5EKQVq102hAvU2WpTaXaP/Fp4aKXYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dv3pEdxu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760348162;
	bh=k2yftSbq+5d+v9hZZrUZktEn1hoBtyA2dFQC4cr/uzE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dv3pEdxu2vwyeVkQ3uYW/Xkgw6f4rVrXZ2/e5titZmBsPGB0wfX1Abc2SzgXQqXPE
	 VZ3ayJqC4O40Ec+4hATCsL/fsZtxxw8qniZdfbpR64KvAMslE+sAIadjsqQ2IGkUqB
	 vgex6Ydq27I3RGhkkYmIG3cNRtnd7E/euA9/cQ8UmBDlri5QyiYfcYbb5sMk9FzTmw
	 v4jvMjpeVoJ32fCqlY0SZu4qzkfopOcmT2kdMqFxmRFLwSAy+2obbRv3C2nQoCIHa9
	 NRNSs4PvfvyuZ1APkUU1xiGJRqfgju01vwTdNGI0ZAKInBKBaU1JF0pg8UMZo5Guzm
	 kaztYa9qVaieQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6621E17E048E;
	Mon, 13 Oct 2025 11:36:01 +0200 (CEST)
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
Message-Id: <176034816136.21517.14207599704800072414.b4-ty@collabora.com>
Date: Mon, 13 Oct 2025 11:36:01 +0200
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

Applied to v6.18-next/defconfig, thanks!

[4/4] arm64: defconfig: Enable UFS support for MediaTek Genio 1200 EVK UFS board
      commit: b59a508c1f5fdb3fdc690edebe815d59b04491d0

Cheers,
Angelo



