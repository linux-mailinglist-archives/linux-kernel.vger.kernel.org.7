Return-Path: <linux-kernel+bounces-783568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209CFB32F1C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80494827AD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65376277C8D;
	Sun, 24 Aug 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yiWES5cv"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D0274B35;
	Sun, 24 Aug 2025 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756032896; cv=none; b=ROBiOelboDqulPSetcj1HXCbRnYs4GHdZTfWBlE/MmxqiMrbp9FwuFypvbsJAFD452e4Svhp9vqQEaHFO6JMI4ol0XpK9f+8LeZXGKddVtw0PtTjSszHNmzmyiYTvmcGrN0jMlIK+26SslEJsbUj9bAbCzMAXi4hqU8cXZwl4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756032896; c=relaxed/simple;
	bh=7YDUk9EoYeyQRtU9gK5qrA5farqoO6SLN6WL/ma07uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1LTJKvUez2maEBuI4E3mB6MsxnyPcZnTa96Hf0VIjjmmIIMAb3VFDxKWH9VmNjngO8F3KL1xmy03qHudYnS2VG8ndgJKXaRIuqmnsG2HKUmqHPwugkY0WltecQIprjLD8a3AZt3KRRUitovP1wqrTbTvtEVP2wyIfjnfVNX+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yiWES5cv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=AHk9QZwIfgCBwU2eb0C//VJ5U26Wg7VRyTm2PCeEHYU=; b=yiWES5cv1GPzuII/nMhMmVXco8
	SzsQsaBD/Oowg0JdSACibN1wV8sXEjfcYoLjN6pU3Qmbvf6fhdHyirLRXSPxlUeJOal+XmqtN8mFO
	bRVNt3GNwbZiW4Mfatb8lJLGCuBhq5lfrRETo/XFVo4dnbvw3eeuVNAOSdmOf8JR0zr6IDTd04SY4
	UwPhiYlpGBTd6fBTVely5aCDi6fTZ7nh1E8CbfqqflcOJYlmvyP/HcnKfm+McOiWIU6x4dH3F4duv
	Y/QTUx+NFEhbGSOfLvzlFB+sk2l0eReQn8uzxEImHsEpw4cA9Pk67HJSAGM2I0VSiGEsVBfd5zfKz
	fnqmZDgg==;
Received: from [62.245.128.201] (helo=phil.wifi.munich-airport.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq8N7-0005H4-0b; Sun, 24 Aug 2025 12:54:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hsun Lai <i@chainsx.cn>,
	Alex Bee <knaerzche@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	stable+noautosel@kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: rockchip: Fix wifi interrupts flag on Sakura Pi RK3308B
Date: Sun, 24 Aug 2025 12:54:43 +0200
Message-ID: <175603280229.3445205.18144135063810636432.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818090445.28112-3-krzysztof.kozlowski@linaro.org>
References: <20250818090445.28112-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Aug 2025 11:04:46 +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.
> 
> Correct the interrupt flags, assuming the author of the code wanted same
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_HIGH  => IRQ_TYPE_LEVEL_HIGH
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: Fix Bluetooth interrupts flag on Neardi LBA3368
      commit: c9f986a54d4031a9b9dff1eb616b0796aa28c730

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

