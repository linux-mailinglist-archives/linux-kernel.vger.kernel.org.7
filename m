Return-Path: <linux-kernel+bounces-793524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E86B3D4B4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 20:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338D81889824
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E2274646;
	Sun, 31 Aug 2025 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSEDxVVc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B3326E17D;
	Sun, 31 Aug 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756664978; cv=none; b=ZwcSJvqmtkN10DjNRnK6w8elT+Qyz3//am0fFyqX1LdSvHjjc4joTHRhugcjFglOLCgSCbXRjbxD/4gQl9pEEzv0uhYnMCBA8dXVlKEnOyKHe0ifA4kTLKNFnUKq9epdHCjPr8paeVg+ORoaU7hX5ziHpUNVbxFo/htamZsjYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756664978; c=relaxed/simple;
	bh=KjHhTkMJ/HyvpaGMX1/ZuMt5yAN5aupaBijM9djMns8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrgD18A43LMaJMvHhZ5edz8N3cxLg2v7jgCGt6N67lRwgoovaKz42RZHZWfMUNYM2+Aue6D7MYyLNSi48RoUHI23n8SucMOF/RFET7sbfj/GQxf8PyE8E2rowhR+i6SWC/35hahVx3uj0s5S0IbmA7UEb0E09i6XRMLzXEjuC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSEDxVVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92A1C4CEED;
	Sun, 31 Aug 2025 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756664977;
	bh=KjHhTkMJ/HyvpaGMX1/ZuMt5yAN5aupaBijM9djMns8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSEDxVVczmhv2xuAzK34rJ5E5uA+Xm1tulv+ccO7aaAOptE1pW0c8yGFnDxnfoqmR
	 im7cXuWUPhKPazxsUFcXgMKgjJFkyx1mREeNOan/R/gkC7wOb6Bf648aqlbaLDJb5h
	 UbIsnFB+qCh6awlRcCtrghGsQUYTXKVFz6ZvaM+J3h3IeqffyKqjE/D4IuSA+66Fg9
	 avdjLzqnpcABliDLLX1xAUSRl2PWit7bdXtdgG53AqHA5sH6GfLLIWgWrRKnB6q34a
	 i9CDmzRryyL1MZqdZqPokrtGlqAg83aPmJQAtfuCoV8AnC2sACOROSvZ4uXLn7ixKe
	 JdjAtoAhc6pcg==
From: Sven Peter <sven@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Hector Martin <marcan@marcan.st>,
	Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Apple device tree sync from downstream kernel
Date: Sun, 31 Aug 2025 20:29:28 +0200
Message-Id: <175666489772.4936.11580561887424147768.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net>
References: <20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 23 Aug 2025 11:49:43 +0200, Janne Grunau wrote:
> This series pulls changes from the downstream device trees which are
> supported in upstream kernel.
> Most importantly it fixes the PCIe description for a specific iMac model
> (iMac M1, 2 USB-C ports, 2021). This is worked around in the downstream
> kernel by not disabling the port. In preparation for submitting M2
> Pro/Max/Ultra devices trees I investigated the issue on the similarly
> affected M2 Pro Mac mini and fixed it this way.
> It completes the Wlan/BT device nodes for t600x based devices and adds
> the missing 15-inch Macbook Air (M2, 2023).
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (apple-soc/dt-6.18), thanks!

[1/5] arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
      https://github.com/AsahiLinux/linux/commit/6e08cdd604ed
[2/5] arm64: dts: apple: t600x: Add missing WiFi properties
      https://github.com/AsahiLinux/linux/commit/3050713d84f5
[3/5] arm64: dts: apple: t600x: Add bluetooth device nodes
      https://github.com/AsahiLinux/linux/commit/c34e2ec6a84e
[4/5] dt-bindings: arm: apple: Add t8112 j415 compatible
      https://github.com/AsahiLinux/linux/commit/efad8eaf6f2f
[5/5] arm64: dts: apple: Add devicetreee for t8112-j415
      https://github.com/AsahiLinux/linux/commit/273be31e5afd

Best regards,
-- 
Sven Peter <sven@kernel.org>


