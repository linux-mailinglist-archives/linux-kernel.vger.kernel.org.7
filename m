Return-Path: <linux-kernel+bounces-815739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19716B56A94
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEC517B39F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916F82DCF6A;
	Sun, 14 Sep 2025 16:29:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263472D9EF3;
	Sun, 14 Sep 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757867390; cv=none; b=Sw1XK6iMHq5q8um/3QeBWEUq9lNi54eReplmqtimmwjoLGK527hVR7z1j3HLXmMz4i9KmrGkpdrYfLjT8x+gNAokGKB67G7qWxptmaFIVAGZTRUpUCOsQCwlPJpO1h+suzyLJkMcyMxvCNLX0Wa2oJdCHhHavPE+kqGC37DsggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757867390; c=relaxed/simple;
	bh=mZD/bFCu6t2r9aNMbFnqym/HZvECftNyi+dZ52WyBK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q4KrR4KUrckjWrX5L004m98wAOo94Nkrdv9ZR5wL7IxSUomxzPBOr/hIqIPmz9LgzeB2RMUJH9vD90zW4h6FxFKUnvheDieQc0AO28KOvle8mOIbI/SZ76I031T4ktLb/MLhVrMc9aklWZRjYj6vu2hIdptq6aoPUP5K39yVTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2FBC4CEF0;
	Sun, 14 Sep 2025 16:29:49 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 2DD115FCBF;
	Mon, 15 Sep 2025 00:29:47 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250913102450.3935943-1-wens@kernel.org>
References: <20250913102450.3935943-1-wens@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: allwinner: a527: cubie-a5e: Drop
 external 32.768 KHz crystal
Message-Id: <175786738718.280883.11594143436051438631.b4-ty@csie.org>
Date: Mon, 15 Sep 2025 00:29:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sat, 13 Sep 2025 18:24:48 +0800, Chen-Yu Tsai wrote:
> The Radxa Cubie A5E has empty pads for a 32.768 KHz crystal, but it is
> left unpopulated, as per the schematics and seen on board images. A dead
> give away is the RTC's LOSC auto switch register showing the external
> OSC to be abnormal.
> 
> Drop the external crystal from the device tree. It was not referenced
> anyway.
> 
> [...]

Applied to sunxi/dt-for-6.18 in local tree, thanks!

[1/3] arm64: dts: allwinner: a527: cubie-a5e: Drop external 32.768 KHz crystal
      commit: 9f01e1e14e71defefcb4d6823b8476a15f3cf04a
[2/3] arm64: dts: allwinner: t527: avaota-a1: hook up external 32k crystal
      commit: 3d5e1ba00af8dd34ae1e573c2c07e00b5ec65267
[3/3] arm64: dts: allwinner: t527: orangepi-4a: hook up external 32k crystal
      commit: bd1ce7ef6aef4ee7349eb3124166e712693650ce

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


