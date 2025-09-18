Return-Path: <linux-kernel+bounces-823618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C693B8704A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4235169D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A752F7ABE;
	Thu, 18 Sep 2025 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QLhSWJje"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B52ECE9C;
	Thu, 18 Sep 2025 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229791; cv=none; b=NRRpXLzgPHeXABajGaGC1XL7JHXoSi9ReIJxOKJqshGv/9XtcGCGzh2pWXHx6tusktUqNYr44TBYlQ8HF0cu9Aq47jL4eTai7oD24CbRkvpV6+M1MqgQ/vKrt7xc2uYgCCfc55Mi+D6seTALc0eGpKc0Xio1OiRNw8boOchY+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229791; c=relaxed/simple;
	bh=kBbAyny083029RjWM31lR4biwDWc2+sw3XUsd2KPmq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+8pPI/Se9CX2BwEEnXivsPexiNeuGH6qyKt2GAmN7DrMXADS7yaROxNufygrS8npjrY2ytpCqpfBktW5+A5Vgfdc2uMkNi4s/VpfMPytyP9At72z8y0bs9q5zr4adqItbrIoLVXGu0d1ts9dcN/um0xMSgHV0ynXWDtuWttQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QLhSWJje; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=vAMRs3EbyF1XGGaTsvBP13Ccnhqr+M87FnxfkVVVsrA=; b=QLhSWJje2q9bkKWYMbzv52HhN/
	HzUnlzdWtIoi9KQ029azp70hbVLwXAAWVJU/uZrJjzWubno8jmUIWtkwFoBPVi1it05SAXye3V+sn
	yk8nvO6Jm4bA2/FZaKZ1wCfo4t4EcDkprstmO41PNmplxUMJsODEP4CqGcXSSWn964HpzSsDRrtTm
	W/sJQM+Ga864a09zmETnkFZFAsNG4ShZnSNy5eaP879sKfo8odepzClivCapClBmjpdU585Bdh1lk
	jtNJj5Lm1suw0vBtVueLDTcWDFQxdZSHnj4pqw9GBzzTJZn6sh5BCK5AVkn0oEcUKYo2VpUHyMMuk
	m/d6GhFQ==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzLsj-0003SC-5k; Thu, 18 Sep 2025 23:09:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kaison Deng <dkx@t-chip.com.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Wayne Chou <zxf@t-chip.com.cn>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add support for Firefly ROC-RK3588-RT
Date: Thu, 18 Sep 2025 23:09:20 +0200
Message-ID: <175822973680.1568500.8881843891628390459.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757902513.git.dkx@t-chip.com.cn>
References: <cover.1757902513.git.dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 15 Sep 2025 10:22:03 +0800, Kaison Deng wrote:
> This series add support for Firefly ROC-RK3588-RT.
> 
> Info of device can be found at:
> https://en.t-firefly.com/product/industry/rocrk3588rt
> 
> Changes in v3:
> - Change rgmii-rxid phy-mode to rgmii-id
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add Firefly ROC-RK3588-RT
      commit: 0bb8d67611b59740f47ad57658a8d2986c43f8c1
[2/2] arm64: dts: rockchip: Add devicetree for the ROC-RK3588-RT
      commit: 93781211e9ad9578787355147c2f28b7289a8ec6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

