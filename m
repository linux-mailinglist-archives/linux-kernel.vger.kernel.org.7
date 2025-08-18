Return-Path: <linux-kernel+bounces-773549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DECB2A1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6715B560684
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525B257458;
	Mon, 18 Aug 2025 12:26:03 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE604320386;
	Mon, 18 Aug 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519963; cv=none; b=GtmwADnVZ9LQBwMRIy72bwwjuUAecFZnrVhqDKNOe8Re63GA/Um1Az2Xs04mWMsXuAkA0rRLpLdedR18iDOSa3pCDY09p5L73BC7H+2AO0ZLdWrOazRy4zQdbFdbITtdW8+bfOPfrzsc8nv24krRpeCP9Z1F3ctDElU0HAQqnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519963; c=relaxed/simple;
	bh=3D7XiQsF2LRwxTsIiluc2rRY4xp6KZq2KqBz61kwKhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0nPG/DacHVaZQV7Ptxbw1QMS+wUYjH7Nf2a2i/31SIk16GYI0VWCA5vKtSXjpN8BvIIyDe2vSEhjth27zVT14ausFPV4Y0mULPb1VC7PA5/1ONAmW3ePq7sJkpxZWF/C2lG3C/sipJJedsEuGmz9+7Eh8pFkfK94p64Mx2CxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [180.158.240.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 84414340DB0;
	Mon, 18 Aug 2025 12:25:54 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	palmer@dabbelt.com,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: Yixun Lan <dlan@gentoo.org>,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] riscv: dts: spacemit: Add initial support for OrangePi RV2
Date: Mon, 18 Aug 2025 20:25:36 +0800
Message-ID: <175551987874.16484.811796950493073575.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813092240.180333-1-hendrik.hamerlinck@hammernet.be>
References: <20250813092240.180333-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Aug 2025 11:22:38 +0200, Hendrik Hamerlinck wrote:
> This patchset adds initial device tree support for the OrangePi RV2 board.
> 
> The OrangePi RV2 [1] is described as using the Ky X1 SoC. Based on research
> and testing, it appears to be identical or very closely related to the
> SpacemiT K1 SoC [2], as suggested by the following:
> 
> - Similar integration in the Banana Pi kernel tree [3], which uses the
>   OrangePi RV2 and identifies it as the SpacemiT K1.
> - Comparison of the device tree code showing a match to the OrangePi RV2
>   Linux tree [4].
> - Locally tested the OrangePi RV2 with the SpacemiT K1 device tree,
>   confirming it boots and operates correctly.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: riscv: spacemit: Add OrangePi RV2 board
      https://github.com/spacemit-com/linux/commit/f10512e2c44e6ee3242314d43102acab7340e2d3
[2/2] riscv: dts: spacemit: Add OrangePi RV2 board device tree
      https://github.com/spacemit-com/linux/commit/bab8dea259100a99e047fd11a48940b229d30031

Best regards,
-- 
Yixun Lan


