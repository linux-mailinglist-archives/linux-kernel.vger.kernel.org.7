Return-Path: <linux-kernel+bounces-790072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE34B39F05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E0A16B03D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3445313520;
	Thu, 28 Aug 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MjSRELgm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA93148CA;
	Thu, 28 Aug 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387840; cv=none; b=Qmzq9RLb02ShJ9hTiG77tbNGVw7nJLA2xLgqTH6d4JENn6fo2ToRM+EalaZMtqeKmJKKfGkTABXp0JFnyulKPOq92x2M2j0DQCasNvADUx34OIpuhMYFLLvgjwPciYPir06HG1D8Ao0T9XHX2BiHaXSuSgva2Ht5KbmIws6H/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387840; c=relaxed/simple;
	bh=AfRAFXYQXOOXK7c2bgzef4GLBPYNZos/W83ehQ2VF6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgmu1suhYmrW80y4nVaTjfb84k43kb0U7GTRKbsKDcSLLPJEHyhGwbNLFZQvWw7WzTd8JTiRTdd9/S+1pCUlBrQj5keNizfD8B3pbJavAjaWoGM2D+uFl0uISbK4ybSnYF8pmQVducej4drEsFjxkaqASw4x2HXou9NX7fd2kXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MjSRELgm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=85legAFamZkGWcJVGBEbj3Ci4erJikI5OAxiXQSDocE=; b=MjSRELgmrGIxeWFYBilE6LIvRe
	hTXdchlJ7Z/o9a60hwZkjCo9zAh6N9eY941lpFPkKZzFQxR4+BuWB09cSNPquacZcF1CMAwb0KDwV
	iPinv1lS4X0WJPSfG1QmqK40JzFvgV9NpQBgjoGi0kCaSgapeeVEpdWNhcuUZBghNJoZBElVtMPdm
	MXUwOOXPzI6B6X7gRSCuxAgKB26prGIzTgZZElMhKVdX4ibptubxoBFOw5uIEfYSif1jztQ22o0lT
	84vJS0hfRiNtg0H63s3HNqRERcezXVbnx94754KUP/k6desPKt41QEPMaC2yaIYyo7aGB+fQ4XMoq
	o+sIwJYg==;
Received: from [185.205.242.134] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urchz-0004qj-7U; Thu, 28 Aug 2025 15:30:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>,
	Peter Robinson <pbrobinson@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Add vcc-supply to SPI flash on Pinephone Pro
Date: Thu, 28 Aug 2025 15:30:27 +0200
Message-ID: <175638782389.3533599.13962706538099315140.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827143501.1646163-1-pbrobinson@gmail.com>
References: <20250827143501.1646163-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 27 Aug 2025 15:34:58 +0100, Peter Robinson wrote:
> As documented in the PinephonePro-Schematic-V1.0-20211127.pdf,
> page 11, the SPI Flash's VCC pin is connected to VCC_1V8 power
> source. This fixes the following warning:
> 
>   spi-nor spi1.0: supply vcc not found, using dummy regulator
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add vcc-supply to SPI flash on Pinephone Pro
      commit: 497aa80ec7ee145b3606e7434d57091974d78598

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

