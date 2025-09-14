Return-Path: <linux-kernel+bounces-815738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D8DB56A96
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707E718967AB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9157E2DCF69;
	Sun, 14 Sep 2025 16:29:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C62D9ECA;
	Sun, 14 Sep 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757867390; cv=none; b=ZEiyOLiRdazQ5af54DwVscIbVg9OULi+JtwYZc1kFw2/U2xvHzoFMpHkQXmTdBZoC9FurO2fF7/+8cwZfoTJBppD7wghID2Ls7lXuGOC2N0efNa+IzZkuZre/np8WTc+JtvDMAho8VKSLskM3Z8JS5SCg0XmUuxR4oHLeuuZa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757867390; c=relaxed/simple;
	bh=fPi2yfsdOCyrL76vv2gaQr/VzWriuVD7TXnruZBK414=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oxgJbPgia/hCjvXbxRcscw9lGLjrlzAQ/tqVJfTaVD3rq4SAlKXb81O09w6w82zu3leGO2YAC3yheK4YY620tduW8TsVzvBtjNpsvK7mWM+x9g1dJZQwBy1oPJes/8GCtKeOWODrDvp023FfRpA1xPVAY9vVFT1PeGy6NzZZDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C050C4CEF1;
	Sun, 14 Sep 2025 16:29:49 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 1CF4D5F846;
	Mon, 15 Sep 2025 00:29:47 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250913101600.3932762-1-wens@kernel.org>
References: <20250913101600.3932762-1-wens@kernel.org>
Subject: Re: [PATCH] arm64: dts: sun55i: a523: Assign standard clock rates
 to PRCM bus clocks
Message-Id: <175786738705.280883.1529731611819017307.b4-ty@csie.org>
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

On Sat, 13 Sep 2025 18:16:00 +0800, Chen-Yu Tsai wrote:
> At least in the initial version of U-boot support landed upstream, the
> PRCM bus clocks were not configured, and left at their reset default 24
> MHz clock rate. This is quite slow for the peripherals on them.
> 
> The recommended rates from the manual are:
> 
> - AHBS: 200 MHz
> - APBS0: 100 MHz
> - APBS1: 24 MHz
> 
> [...]

Applied to sunxi/dt-for-6.18 in local tree, thanks!

[1/1] arm64: dts: sun55i: a523: Assign standard clock rates to PRCM bus clocks
      commit: e6fad4960fc67b7225255b10b080765b451a7bc7

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


