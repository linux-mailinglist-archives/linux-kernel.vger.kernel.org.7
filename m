Return-Path: <linux-kernel+bounces-778297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF1B2E3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323C65A2050
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69124341641;
	Wed, 20 Aug 2025 17:21:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB3229B2A;
	Wed, 20 Aug 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710462; cv=none; b=dzJ6tKFOMyZxzunwrqWA12CrtSEHZ96WlQDC/sp15mUk9CqSFH4qUui9Lww6EDBRI1G4q8YZN0Ei8qSChf99UYkAmZpvksNO8t/zzYWt0/d4IRta/NTIGs2UDcq45xNsckMw43AxGw6ObgxPE9jFb5tp62rooKzZZ+UHBE+UKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710462; c=relaxed/simple;
	bh=3HY7sPQWyV1AN9wQMNgO5V+MbRz+19ixWZ9iH0LhF9k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VS/IxWVV56ULtWuJKOqvZAzm4ewqgHR/khZ3bTJzsdkeskZ5AIMQSG/TOVAbf00ihq1cAqw8YvghTW3U/ISnr4BYaRwDRUsPbVwqEIUpF+HjzQB1mGuoZSf0yKgmPzFNTx6Ww6l4l6RFWfLtaFkQQcCw53NyYe4GlubXOJzx1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAA8C116D0;
	Wed, 20 Aug 2025 17:21:01 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 84FE95F870;
	Thu, 21 Aug 2025 01:20:58 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250819131752.86948-2-krzysztof.kozlowski@linaro.org>
References: <20250819131752.86948-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: allwinner: Minor whitespace cleanup
Message-Id: <175571045852.1650076.3818185651081371250.b4-ty@csie.org>
Date: Thu, 21 Aug 2025 01:20:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 19 Aug 2025 15:17:53 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '=' or '{'
> characters.
> 
> 

Applied to sunxi/fixes-for-6.17 in local tree, thanks!

[1/1] ARM: dts: allwinner: Minor whitespace cleanup
      commit: 06ea48beece831a8447758e5432ad1cd60765363

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


