Return-Path: <linux-kernel+bounces-823492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B967B86A55
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDB2564F14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28622D29DF;
	Thu, 18 Sep 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYVU55zs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D492571BE;
	Thu, 18 Sep 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222955; cv=none; b=quHJ7L5AWOVAuh464Oaj5EwOCrPbkhBI2jFWm8E+FwOTpGcyqf5PtzKVVtPFbOqXrTCBTGbphyRVu3iGagCc9w0wp5ipUddkKvFhWOBC3N//JJ0jlvzOKAfvKpxRqQMPNELW2G9wd7d2ejV+38uBO9cMe3ey7bq+BsjZF8ZltpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222955; c=relaxed/simple;
	bh=MdXdHMNG/Jg1OzCMhQMXRrx24VoocLdYQOqhwxpuULE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgjxDZ9KmEzQsAGLGpZAn5qQcj3GBiTWVUApj5XUdqADXJ58TYGYbjZLaYDgJRq+myqlcEtxtskS5koOp4TMFvLTDSlQTKcEP/RyI3qSsIBK2OzbL7ct4F2y3sq7S7M73q1ABMyEoaD21+xjQqp9wHNrDjElR9nDewVHSvjx/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYVU55zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9411CC4CEE7;
	Thu, 18 Sep 2025 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758222953;
	bh=MdXdHMNG/Jg1OzCMhQMXRrx24VoocLdYQOqhwxpuULE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYVU55zs4hkC0IeLxrSCXai8GQ+OH0tC/ZBFvqF2f4G5dJq7OjO+PTKHdZnQdy0h5
	 60FBeFjV4pxaEerauQNCoRGb21SUvTPOp8pvrOK8Uf+GRVjDppC16C60+vWipo2QGP
	 w9zHdN9+YtfAxctXIVs3WSBsF9SzRtW4jQqLPWuO0WZnWxksvPSo8Lgn3Wfc7eOGFw
	 ilbmP8c1QQy9JYTDcwOksZkB0hHpFyDbqoyeSqE4TN0ixlP8mwke+AqC1yTKag7y1n
	 L4NNHvel6qjqdx5fek6neWyO6AWz82ZZMT2LgUQfEA6qiLmucrGZ3XT2j9OGXs7JAH
	 KxuGhcSMTn0Mg==
From: Sven Peter <sven@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/6] arm64: Add initial device trees for Apple M2 Pro/Max/Ultra devices
Date: Thu, 18 Sep 2025 21:15:36 +0200
Message-Id: <175822291278.28444.14875676651074123815.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
References: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 21:38:43 +0200, Janne Grunau wrote:
> This series adds device trees for Apple's M2 Pro, Max and Ultra based
> devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
> follow design of the t600x family so copy the structure of SoC *.dtsi
> files.
> 
> t6020 is a cut-down version of t6021, so the former just includes the
> latter and disables the missing bits.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (asahi-soc/for-next), thanks!

[1/6] dt-bindings: arm: apple: Add t6020x compatibles
      https://github.com/AsahiLinux/linux/commit/28f94ed138c3
[2/6] arm64: dts: apple: Add ethernet0 alias for J375 template
      https://github.com/AsahiLinux/linux/commit/6313115c55f4
[3/6] arm64: dts: apple: Add initial t6020/t6021/t6022 DTs
      https://github.com/AsahiLinux/linux/commit/a8f20eb60788
[4/6] arm64: dts: apple: Add J414 and J416 Macbook Pro device trees
      https://github.com/AsahiLinux/linux/commit/44a952585b4b
[5/6] arm64: dts: apple: Add J474s, J475c and J475d device trees
      https://github.com/AsahiLinux/linux/commit/9da45d978ccb
[6/6] arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra, 2023) device tree
      https://github.com/AsahiLinux/linux/commit/637f7d2c731f

Best regards,
-- 
Sven Peter <sven@kernel.org>


