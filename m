Return-Path: <linux-kernel+bounces-810224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436F5B5176E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBA35E01BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182EF31E112;
	Wed, 10 Sep 2025 12:57:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385431CA4C;
	Wed, 10 Sep 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509025; cv=none; b=p8QKKaLDPtVI7XcutQOtyICwiAlqZdxxHhIunOO4lJEpKBfoz+gVuWY/NBWsAU7pk6lRGGxGYM8a9fNb4HKC3VAOhE2C0A6iHYmiGSNzK27mZ4XiPtaqGuY2HWfymEbfAGe5avwaOyJ4ZA58wHWnavoD+oapbtnJknDAHazD2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509025; c=relaxed/simple;
	bh=qUZIaEMOpAAX5nB+LWnvw1yBKa2r99u5B5jZB+7HDLg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pbqr1Sa4dY+UpRNpjJgGxEF7/+Mg3eDwl+wCaQgSNxw6x/nZzN2M7UzkW/tYeBaGJL2YCV2HL6eP1BUicUdxWE0OFjaoizn2aaTLQ3iqJgRCzZblk2J5UqJW109VBuTJxL2eQdFRFgpYR15KTRumR7dL30tcSOuoXWC0Y71O06w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA3AC4CEF0;
	Wed, 10 Sep 2025 12:57:05 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 2A4245FA46;
	Wed, 10 Sep 2025 20:57:02 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sunxi@lists.linux.dev, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250909-frown-wrinkle-f16df243a970@spud>
References: <20250909-frown-wrinkle-f16df243a970@spud>
Subject: Re: [PATCH v1] riscv: dts: allwinner: rename devterm i2c-gpio node
 to comply with binding
Message-Id: <175750902214.2590389.9826563009120753959.b4-ty@csie.org>
Date: Wed, 10 Sep 2025 20:57:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 09 Sep 2025 20:58:17 +0100, Conor Dooley wrote:
> The i2c controller binding does not permit permit the node name to
> contain "gpio", resulting in two warnings:
> 
> i2c-gpio-0 (i2c-gpio): $nodename:0: 'i2c-gpio-0' does not match '^i2c(@.+|-[a-z0-9]+)?$'
> i2c-gpio-0 (i2c-gpio): Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'adc@54' were unexpected)
> 
> Drop it to satisfy dtbs_check.
> 
> [...]

Applied to sunxi/fixes-for-6.17 in local tree, thanks!

[1/1] riscv: dts: allwinner: rename devterm i2c-gpio node to comply with binding
      commit: a5d7a8ab4b21747173a2f8f0ebf71d72692793c3

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


