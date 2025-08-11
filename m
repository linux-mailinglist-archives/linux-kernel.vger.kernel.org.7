Return-Path: <linux-kernel+bounces-761994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE0B200DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B65817664A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD942DC326;
	Mon, 11 Aug 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="s7UJ8GDO"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A22DAFAE;
	Mon, 11 Aug 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898748; cv=none; b=rUzRXE9HSbmG8NEOx0p+vbypXooSFecicSmj2uXMBuBFJVhDrVIDoTpNP3+G3NNNSPWLkAbhpODxQV1SRhPHlZM20snQPZiWkke/AJYcnoNG/0LkEBgy/DeFOTfYs5k0hbdLGkueiny7nFM2gwIUyZTO4YK55SW73wFhWNAv41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898748; c=relaxed/simple;
	bh=eOnqZ5FPOke3pD+Y4u7ZYLzXVwvQY5qoFAJ6MKzjels=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFBjwxp2vhh3PTHzDJ99Ymf702p2V1BFBWuYlGgkRqyDZFBinlP//hbuaRt+bO8wXjAIXv2cvwpYpgkQg/aKSDsX9M37PG374so9mKWLJ07XG0os+7TVIS2FK4U3vC1uHX90k8u9ZLODHyphbPc2Y5WGm+KJFr2loYicZYn37qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=s7UJ8GDO; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=qe2Uiqklm0XdQU3ppK07d6zd7UkELYQebN6R6LnbmaY=; b=s7UJ8GDO2Nro8PG7wP48KSllY8
	626sRDJXNvHdKXZwXmm51nDDbFg9oG2s66kpk/SGt87LWGGU6CBY5sDHxH65vD6HPzOw4607NLJGz
	vJgYcG/ekDpMcXZ2gjHBh9TVM8GVeEsqrArwNEtbrOgrR57FEujyiQdOwpYy6LT0jJA8937eB02W9
	yUChZTmotqNEGZG46BjRRVNG6PTIy/zCvPvhRBPnYpoM5IaqUW+bO+DCxK+WeShGoZHzqAXvcV3+z
	xUz40IL2xYfy4tnbhDWYuWUuavNyePIHN9MTKr/ouzQMyA/u7QgnkCKX5QHpaNair4uwiG8BrzcmR
	pdank1qg==;
Received: from i53875a0c.versanet.de ([83.135.90.12] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulNKK-0007Ro-Dt; Mon, 11 Aug 2025 09:52:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] arm64: dts: rockchip: disable display subsystem for Radxa E52C
Date: Mon, 11 Aug 2025 09:52:00 +0200
Message-ID: <175489870461.808197.2395932631261103539.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250810100020.445053-1-amadeus@jmu.edu.cn>
References: <20250810100020.445053-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 10 Aug 2025 18:00:18 +0800, Chukun Pan wrote:
> The Radxa E52C SBC do not have HDMI output, so disable
> the display subsystem.
> 
> 

Applied, thanks!

[2/3] arm64: dts: rockchip: mark eeprom as read-only for Radxa E52C
      commit: f18c9e79bbe65627805fff6aac3ea96b6b55b53d
[3/3] arm64: dts: rockchip: improve LED config for for Radxa E52C
      commit: 6f36b1fdb80dd1fdd24742af4ca435f76f73dfe9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

