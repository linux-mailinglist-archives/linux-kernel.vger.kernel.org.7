Return-Path: <linux-kernel+bounces-804595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA058B47A41
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B284200E81
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DB322370D;
	Sun,  7 Sep 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzrah6sL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30A41C8606;
	Sun,  7 Sep 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238483; cv=none; b=UUNiKCYC2tAL+veFEsSEH4XgeUnGjmY8jdyGMIXBPBbMpQXGA8rGli+TCk3Zg0h1Ank4E6bTlDtEjoMy9PTGopqrbvsjgdwD4iM/8vufzAigWSMa1wmvJXhK1ZyEDET6muoLA5eoGAvOB7Xk57C7N2s82sH515A2pgz48kflWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238483; c=relaxed/simple;
	bh=AJo8tXGXBCNKvK0egKRIWYrjkAvNXBOqYMH+m5aqxhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNXoUr3YFi3ygWWIiiz2WEbAueIfa91ZC/IzHlUqQY1dZWU4X0j31PUXcGmCvsvve3q+6Pwzba1WLqtx7tICnK2o/JUa/qqxA8dI8g80Htyd9+++RPhcNeWZZvI5Xp5XPSN6G9QK53jMvMnBP59vsT5smmtmGVOzEk5Pjx3BD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzrah6sL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAA6C4CEF0;
	Sun,  7 Sep 2025 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757238483;
	bh=AJo8tXGXBCNKvK0egKRIWYrjkAvNXBOqYMH+m5aqxhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzrah6sL4dBECdyKDsnszqo0PaNZdQiYxoWj0K7Wf7zdo/p1VhDkr5tndUsPlJVF+
	 19jHoOnTOtJnq3Rptr/t4aY9YK/ZpaBFFQxdvzNWDDvkH4PVNds+G6IUD1B1xfsPTK
	 +LdMrbVMLVMAXkKhUVMCGedmfvdK0dLJEEUJAkRXukQ6Fvi0X0WjWHwbWHvvMoXJuQ
	 v8u/XF9btaC+f1E9olbhVWDwFQW2+tX6qa2CKYyo95uBr3sIG+0C6aLWkJamarNRup
	 xuCCz1cx/RinMvvmEVXyR/uTqjJOp4cDUVXkoR99bOhrYAT0NdaheoBc0RRoHppuyN
	 3wYgKxDiKDX4Q==
Date: Sun, 7 Sep 2025 11:47:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 20/22] arm64: dts: apple: t8103: Add Apple Type-C PHY
 and dwc3 nodes
Message-ID: <20250907-zippy-auburn-koel-d6da32@kuoka>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-20-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-20-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:33PM +0000, Sven Peter wrote:
> Add all nodes and connections required to make USB3 work on M1-based
> Apple machines.
> 
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  arch/arm64/boot/dts/apple/t8103-j274.dts  |  12 +++
>  arch/arm64/boot/dts/apple/t8103-j293.dts  |  12 +++
>  arch/arm64/boot/dts/apple/t8103-j313.dts  |  12 +++
>  arch/arm64/boot/dts/apple/t8103-j456.dts  |  12 +++
>  arch/arm64/boot/dts/apple/t8103-j457.dts  |  12 +++
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 137 ++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi      | 105 +++++++++++++++++++++++
>  7 files changed, 302 insertions(+)

Please do not combine DTS patches in patchsets for Greg (e.g. USB). Greg
expressed that many times, that he takes all or nothing, and DTS cannot
go via driver branches/trees.

Best regards,
Krzysztof


