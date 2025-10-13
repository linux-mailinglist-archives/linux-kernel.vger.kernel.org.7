Return-Path: <linux-kernel+bounces-850236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE330BD2518
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8743AAA47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F42FE075;
	Mon, 13 Oct 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gpre5uhb"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214B2FE052;
	Mon, 13 Oct 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348115; cv=none; b=Wp0iOHbY4S1CWjd6jcb3AEnKFON5161MMle6c+0rWOPS26iPCO7dgxjnJXVkc9hUMV7ka5FoQNZ6AsrwrstMhxGMgx9nwfKGoybUIrpQ0/TH5S4G92Eq8iSlW00htLewjxuNUp9mJruuXs802B3s8Lwk/7U3tbNS/baGqw2ndOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348115; c=relaxed/simple;
	bh=or8xQ1iruJtdfX8SleEUWuob1OR6uOc2dB1flwoE3mE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pNpjcE7gDbZ01f7jZVnvAZbVJb9LbgOYrOCSrszRcAISeJ/aihr9tYL/CdOZSmMIAfYp7PFJnSCGqyV7jchmjypeRXI4Zfd6fytvXnKtM7FAee6HzhKT6koFZbXF6U3A/lgryZqCU6D0+pP/QojtcUl5uhiT7blp+ZhuHBcqe0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gpre5uhb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760348111;
	bh=or8xQ1iruJtdfX8SleEUWuob1OR6uOc2dB1flwoE3mE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Gpre5uhbDneJfSx3JZt6GYGvpLzkerLjnbCmIq2hgFeyKqezmwBOxw/bJLD7/enfF
	 32ugXIYdpl1eKijQH1wbj3pCPNfiNgZ0zZhhtfsvkU4iHYVds2mO4xpRtm3YppQ/Fn
	 /hzRp5U+Li3LF5LwxfMZ4AhXl1SgVtVFuZOtcDQG7pXXu2O6YZZa2IM7Qd2UEFmTbs
	 KqjTnGuHWKxfPUyHXimdKf+a6LGUYxJNhHdRp6NVMBx3/k5/tNaW54Vknak7Rd4dl9
	 SixC75OkU/mCJEcK/iPNrtdmrTkwRDm8+jK5Gx5iwrGZ+Dn74zrqaRIFgz6+XIMpgD
	 Mg8w4plkgkp9w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7DCE017E12C8;
	Mon, 13 Oct 2025 11:35:11 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <40004650c99c09ff540d8e2028a1393f4a70a6b4.1758369130.git.daniel@makrotopia.org>
References: <40004650c99c09ff540d8e2028a1393f4a70a6b4.1758369130.git.daniel@makrotopia.org>
Subject: Re: [PATCH v2 1/4] arm64: dts: mediatek: mt7622: add 'soc-uuid'
 cell to efuse
Message-Id: <176034811146.21265.15506279212407234181.b4-ty@collabora.com>
Date: Mon, 13 Oct 2025 11:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 20 Sep 2025 12:56:42 +0100, Daniel Golle wrote:
> The efuse of the MediaTek MT7622 contains an 8-byte unique identifier.
> Add a 'soc-uuid' cell covering those 8 bytes to the nvmem defininition
> of the efuse to allow easy access from userspace, eg. to generate a
> persistent random MAC address on boards like the BananaPi R64 which
> doesn't have any factory-assigned addresses.
> 
> 
> [...]

Applied to v6.18-next/dts64, thanks!

[1/4] arm64: dts: mediatek: mt7622: add 'soc-uuid' cell to efuse
      commit: 79fb9654a2eeea8e973f6d329ccf68221703ec59
[2/4] arm64: dts: mediatek: mt7986a: add 'soc-uuid' cell to efuse
      commit: 18d0f98a17757c4030c0af046dfd864c8108738a
[3/4] arm64: dts: mediatek: mt7981b: add 'soc-uuid' cell to efuse
      commit: d261557f7ad37fad44e3c07e76e63a60abcf8bc3
[4/4] arm64: dts: mediatek: mt7988a: add 'soc-uuid' cell to efuse
      commit: 6bb220964d608b133a81ac2ff15177a32617ac77

Cheers,
Angelo



