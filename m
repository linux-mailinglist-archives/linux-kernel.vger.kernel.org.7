Return-Path: <linux-kernel+bounces-824074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4597CB880FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC7165A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35C2C21E2;
	Fri, 19 Sep 2025 06:51:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55252C0F66;
	Fri, 19 Sep 2025 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264686; cv=none; b=SFp092rD9Y/MmPtmzh31VQmgEyzpySOfxHsGIbN4AuQWoHaee1zxLwZ01W4UUiYzeZxMl+Ra7NVXkV9JAwEe343p8/FqG+j5lcGyfXnJECACRWKyqQdZDx6XEk9p0qohGRDciwMpDU+J/8jp9ZyGaUnwOhWUYbX8Q4eZ0Lx5/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264686; c=relaxed/simple;
	bh=JyaA7SWdOAK32ILA02wJCKxMWJVYqIfq5lBIyrG3uag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sDizGk6zSL1I1egm0aQk1y8UTY19CRq0k8YNXezU/bSX1FTsB3zaMJyOS4Oz8ElGL/4x7C4XqIxcoVszlwTOy7Mmp3j3wlK3gKCBKgMnhQ1MIhrYNP2IHuH0DghH6wQSIPzpYx1aLn1ega1vlnq8JnIrvITjXM0c/5FkSW2PubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B37C4CEF0;
	Fri, 19 Sep 2025 06:51:26 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 5DB455FC15;
	Fri, 19 Sep 2025 14:51:23 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250918-x96q-v2-0-51bd39928806@posteo.net>
References: <20250918-x96q-v2-0-51bd39928806@posteo.net>
Subject: Re: [PATCH v2 0/2] Initial Amediatech X96Q support based on
 Allwinner H313
Message-Id: <175826468333.1301600.756686435381088795.b4-ty@csie.org>
Date: Fri, 19 Sep 2025 14:51:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2

On Thu, 18 Sep 2025 12:58:42 +0200, J. Neuschäfer wrote:
> This patchset adds an initial devicetree for the X96Q set-top box.
> WiFi, Ethernet, and HDMI depend on drivers that are currently not
> available in mainline Linux, and I didn't even get the SDIO WiFi chip to
> enumerate, so I left these peripherals out of the in the devicetree.
> 
> The builtin infrared receiver produces IRQs when a nearby remote sends
> events, but they somehow don't end up in /dev/input/event0.
> 
> [...]

Applied to sunxi/dt-for-6.18 in local tree, thanks!

[1/2] dt-bindings: arm: sunxi: Add Amediatech X96Q
      commit: f9d3206506b4db2711eca0f6b3d9dc621cc1e650
[2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
      commit: 07c7f4f4e9504da240ef68adfd95a1150d3a6fd4

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


