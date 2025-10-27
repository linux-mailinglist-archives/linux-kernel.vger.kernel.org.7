Return-Path: <linux-kernel+bounces-871340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5EC0CF92
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7E93A85A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8AA2F360B;
	Mon, 27 Oct 2025 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cUlf6EhE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159B28468D;
	Mon, 27 Oct 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561167; cv=none; b=kCU/csHgTZyD52xT+mXK9J7X+7szhCBRKiVWmmmV5hqxuDAl4M7H58B3LeM2GED0UsfeSXIp+tnP94Lc3fIc5fUsgFOPBhwpivg3Xavysd9xRrfaLm1b4H+jErjrsCQmOHveg3YGWAUMRQPqjQjGCT8iVb6AoGgIv0WC+oU1x4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561167; c=relaxed/simple;
	bh=gdPtlidxvZyz9Nniqj8cOl/Lyejm3Rd2LqnFZSPG48s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mqYpD+1rz47mBfotot32qOQTNwggDMEVs+B2zX+qEawi+qKYWt/Uguoe92S8RCWKTsDOdGfj1jfEgcoQEW6LjColotYE0VkFxWVgZsqtwWCra8ehh2+8zxKosqFK/xW4oo2vgK0amTExQ236nw5ALTDlUh6BDaPq6hjCHYKxpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cUlf6EhE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761561163;
	bh=gdPtlidxvZyz9Nniqj8cOl/Lyejm3Rd2LqnFZSPG48s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cUlf6EhEat9DXL6eCcIQBXLfnTrbkhtVPUlrEbdKDS3mX2uMhnTvNvuCBBNuC9rlq
	 5GwWRJpB8swlbSLHkGXo2e3HqO3BhKOcpBCih/LI+7s3oiKOPSKQyHUujySB4M77Lg
	 bY5esmAt6vT0gJrViChJ2NsafwzIgsFhmlw2B3AQVjvhOflqhspcP0RyDPxKda3Teb
	 dJCnoZsNtn1Nkb1YN3DAHhcwn484OOVE8NwSSNN8E3bKHPbljmIo+iCG2pS/Co2MGB
	 Ea3PYrsuN3P8S3OlWy4SKFRVZU1CquMnQ+ARZbXbhdLMk1saig+n5DAISDR0vX4OLD
	 SlrkzlyepE36g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8B58817E1276;
	Mon, 27 Oct 2025 11:32:42 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
References: <20251021-mt8365-enable-gpu-v2-0-17e05cff2c86@collabora.com>
Subject: Re: (subset) [PATCH v2 0/3] Add Mali GPU support for Mediatek
 MT8365 SoC
Message-Id: <176156116250.18248.16538083521320273627.b4-ty@collabora.com>
Date: Mon, 27 Oct 2025 11:32:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Tue, 21 Oct 2025 09:30:50 +0200, Louis-Alexis Eyraud wrote:
> This patchset adds the support of the ARM Mali G52 MC1 GPU (Bifrost),
> integrated to the Mediatek MT8365 SoC, and its enablement to the
> Mediatek Genio 350-EVK board.
> 
> I've tested this patchset on a Mediatek Genio 350-EVK board,
> with a kernel based on linux-next (tag: next-20251021).
> 
> [...]

Applied to v6.18-next/dts64, thanks!

[2/3] arm64: dts: mediatek: mt8365: Add GPU support
      commit: 499af66b8f421a1f1612ff84c81a47ca569654b8
[3/3] arm64: dts: mediatek: mt8365-evk: Enable GPU support
      commit: c8dd72788f52d3fde091c0d6249c45b9467b69f6

Cheers,
Angelo



