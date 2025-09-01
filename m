Return-Path: <linux-kernel+bounces-794374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4CB3E0C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE531895775
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768AC310640;
	Mon,  1 Sep 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Wdj/akT7"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9330FF3C;
	Mon,  1 Sep 2025 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724384; cv=none; b=FbhCEit9Yyr7+5ezwpHuuMZdoAN5AM8s9qFYbVRNrJHjkrE/jUaCUGY8W6mOA080qs/BRLPcoZB0QxpwcGykzRB2m79Ya+mbaQ0mSEv9AOyAvoaLeu1XrJNplxea29Q+HjxTO4oJ1VwRRj2R2hgMqYAwNifbTNWDRJi8T3cM2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724384; c=relaxed/simple;
	bh=zm2XsysSupnqJlQcXhyrbwN3sg8083PkRHkm7tRbhag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJB42Bx6j31AyEnz7XiRlnQseMIWoGFKxMNs3WE2mfw1YVJq0JwV3IWAp7eytSbdSSM9jLT7oCPNX03Mqu9oWMmn+ak/S38yixj940zxg1GIzY+ypDgBhuoTnKgwe9kEpZ5ciNMSyj8qoB3iZoZMNysvRHUKn+vKb3hEOsoWutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Wdj/akT7; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=kJ1mUoG3fV3WXVXEgWYXPGDH6zt9YlBv5QtbpRwYCsY=; b=Wdj/akT7fKwJp5F02KcuG2r+k4
	O0joSQsiYLQSZ7IJ3D+Vc++OH8Eoy15JN+21KfldeCJew+tuoYo53N7WqCGsBwUB+dw6pAO4huQ+N
	/wSj/MhmHFHEbSOtE6G0twgQvUP3/jVV4CP1g9gxigcTG3yZFfjQz/YE5HmjMKI7f0U/WGSFC2E6t
	4W85Ls3UhdsJuFsQuBqkCNrFpA06FCD3T2urfvQTxx/v8ZjQvOuNW5MK9KUqYRKVUYbE6pSOI5e0q
	b4jQHAVSrZJ4D6U/Z5nALMW/pX3tFGeTYcTrz4rVrg+9by1pGN8EPD+Q73t7nABGXOQwGK7q6EmTy
	EdAIrIJQ==;
Received: from i53875a2d.versanet.de ([83.135.90.45] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ut2G4-0001WA-0G; Mon, 01 Sep 2025 12:59:32 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix USB on RADXA ROCK 5T
Date: Mon,  1 Sep 2025 12:59:28 +0200
Message-ID: <175672432552.3612134.7877143457779148852.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825-rock5t-usb-fix-v1-1-de71954a1bb5@collabora.com>
References: <20250825-rock5t-usb-fix-v1-1-de71954a1bb5@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Aug 2025 09:27:08 +0200, Nicolas Frattaroli wrote:
> The RADXA ROCK 5T board uses the same GPIO pin for controlling the USB
> host port regulator. This control pin was mistakenly left out of the
> ROCK 5T device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: fix USB on RADXA ROCK 5T
      commit: 63ddc0a75b3b071f04f4bc277b2510eb06d21648

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

