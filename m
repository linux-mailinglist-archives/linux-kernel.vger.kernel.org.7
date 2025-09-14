Return-Path: <linux-kernel+bounces-815740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1967DB56A95
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A574F4E04CA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE82DCF6C;
	Sun, 14 Sep 2025 16:29:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B12DA743;
	Sun, 14 Sep 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757867390; cv=none; b=KWJTBfT2tQHf1PXME6lA3/bcfEDOrDb3fTxr2MAdDb596wMp1wqs6APxLZamfPZIL8YkoyCTxzDlLhtsz9Td8fwyDMSWOy3H1Bh7Dl7vu2121T2pTTnRzrnwFam3pFJd3gLHkARys/lyEQ5Y65MuSEwQ+9zmzGX0yfvdlmThHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757867390; c=relaxed/simple;
	bh=YyH1Uahwdyyl4mm2zVGY0J8U8B3cqxrkCachjuFnnb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rGhPQJRhAVdIcb75u/aUehjMbWMk19YUaPqlwpeFjQQxPNipTAREKr+YzCx+eRuDBVG3uP9ZXEsjQJAD1SpEdliOJkU8zx5Sg2M0SgeNEqFJWXVtxTunqYh5E2B77dyQpLkHkLQRwkoDW17arHvlpnFb6Uol0DpQ2uhioAdWLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4606C4CEFB;
	Sun, 14 Sep 2025 16:29:49 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 33F675FDF8;
	Mon, 15 Sep 2025 00:29:47 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250913173511.4064176-1-wens@kernel.org>
References: <20250913173511.4064176-1-wens@kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: sun55i: Complete AXP717A
 sub-functions
Message-Id: <175786738720.280883.7937974112078886568.b4-ty@csie.org>
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

On Sun, 14 Sep 2025 01:35:11 +0800, Chen-Yu Tsai wrote:
> When the AXP717A PMIC is missing nodes for the sub-functions, the kernel
> complains about not found nodes.
> 
> Add all the remaining nodes corresponding to the defined functions for
> the dev boards, which have publicly available schematics to base this
> change on. The battery charger on all of them are disabled. Also add
> an "iio-hwmon" node to express some of the ADC channels as hwmon
> sensors.
> 
> [...]

Applied to sunxi/dt-for-6.18 in local tree, thanks!

[1/1] arm64: dts: allwinner: sun55i: Complete AXP717A sub-functions
      commit: cca07ac2b5f7838b8ff612b53b9f82ac8cb58312

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


