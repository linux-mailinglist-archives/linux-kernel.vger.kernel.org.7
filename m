Return-Path: <linux-kernel+bounces-783567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80CB32F15
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D30E4E0253
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FB2275B1F;
	Sun, 24 Aug 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2H64JTKw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B7519C556;
	Sun, 24 Aug 2025 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756032895; cv=none; b=nX3z7h5p69Ow9ZdZiA3V0qx8WcEm5POAQggxdoaMonZkvl0w/2QhxKGikee0YadRIwLAfbgZ6aX8ZGry24Vq7YkWldxMLfaV3Gy/zG1DLb1JINsj5B9cLZPHhvGx48hLNZglNF0pRiBN07X5HlwGV2/t2hpQYqRS9CfxoOw8QNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756032895; c=relaxed/simple;
	bh=8LqOA8MnesF+S2InfxHsiLci/yGRQ3Em9gTTwusWicI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYd9Bt6fsb8V6PGykP9apgX/rNLMeifuZP4FXXOx7qMS+LBHNCEuKrRNLo2P8J5Lvw0hnzarTVpFEwYdOJP/davi0YQxaFsE3WtsB6+IFyUOksWIGItN9jjDx/srzc4V/3y13vHD6kWh0tR8zVkpEWtHLpT8tWFBVeQSFeeyH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2H64JTKw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=+uU9wpzyjFB7VA323aJSgGvIlksG/HNr+9V5PmNJ//0=; b=2H64JTKwWpwl5hM3JrLmGzynzr
	vpsbTea4fR8mGpEFnQyOTh6x7EF1i/5FaDT8UUsFBcn1Y9y2X1flqHA7RcTs1MMRVQF6MnLavuu2I
	sj3MIRmE1G5vdTHO1drrC8lVRz3ZA+5hb59S3dhLQWW2J7zeBtswFvYlOXgg8s0gGWuTi7Jntobc2
	P7OivoDJAdt7kqhN15SdRdvwzV6+DEGCZ507hAJW/U4RtPnyHPDjA/OuQIduBQsfR/uLGoNkD3XDm
	NX8Irpp/OQnKVVxm2Q0D/MBnP6JULhY4nBxI01acRTVkXkscMES2fkWQPiGikO/MPkZqJm6FYWAAb
	rGOg5w0A==;
Received: from [62.245.128.201] (helo=phil.wifi.munich-airport.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq8N7-0005H4-GZ; Sun, 24 Aug 2025 12:54:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: Enable RK3576 watchdog
Date: Sun, 24 Aug 2025 12:54:45 +0200
Message-ID: <175603280226.3445205.13621939469481331344.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818-rk3576-watchdog-v1-1-28f82e01029c@kernel.org>
References: <20250818-rk3576-watchdog-v1-1-28f82e01029c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Aug 2025 19:18:40 +0200, Sebastian Reichel wrote:
> The RK3576 watchdog does not need any board specific resources, so
> let's enable it by default just like we do for RK3588.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable RK3576 watchdog
      commit: 9c059700fee595142676a9bbaff6e40e3fcd9cbb

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

