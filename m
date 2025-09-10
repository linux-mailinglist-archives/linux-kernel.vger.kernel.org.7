Return-Path: <linux-kernel+bounces-810560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C770FB51C63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A833563D25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE67327A26;
	Wed, 10 Sep 2025 15:48:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D924A06B;
	Wed, 10 Sep 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519301; cv=none; b=bM0NGlXUWeJjWpRsZvVUWuq/3fJwbfIrNIy/ORoh7AIYrlRZ2nzOVaCeKjjW7rAqvJoTPJ2Mj5RDi/TfAONkvFcOG7FSvgOSN9+GvmOuFbAz0sfBwgve0HFHLUaUb4kfuIHYeWEiGrmGkhzA0uCwnB/TZSCLnBQS0c4SjcBm9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519301; c=relaxed/simple;
	bh=VyU3XDWJ7w7Pm5zDjpHjmO9CjS68YuYex9FSm0Za+mQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=exSVAe6Z/TRat51rxisS387VrhjO7iEXI0fUbWmQpUHWDLyHPomSPbFXXH9j1Row1JLfGiQzJP755ZV3kwbMHPu8tGGK5hHSiJ5t3n0UL0J3IJkW50lrK6HilEY+GwxaAdCOjP4rVZZAfceVPkcwrtoPr5oDcuevBy42uE7c8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34208C4CEEB;
	Wed, 10 Sep 2025 15:48:20 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id ED7645F752;
	Wed, 10 Sep 2025 23:48:17 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250830170901.1996227-1-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
Subject: Re: (subset) [PATCH 0/8] arm64: allwinner: a523: Enable MCU PRCM
 and NPU
Message-Id: <175751929795.2643345.10671677254490584515.b4-ty@csie.org>
Date: Wed, 10 Sep 2025 23:48:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 31 Aug 2025 01:08:53 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi folks,
> 
> This series adds support for the MCU PRCM and the NPU.
> 
> The MCU PRCM is a Power, Reset & Clock Management block that has some
> clock and reset controls for the MCU, DSP and some peripherals that the
> MCU could use.
> 
> [...]

Applied to sunxi/clk-for-6.18 in local tree, thanks!

[4/8] clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU module clock
      commit: 1ec8e9ba1f663d6ca5e71ab9f5e919c338075ff0

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


