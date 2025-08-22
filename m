Return-Path: <linux-kernel+bounces-782028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D62FB319E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D457BA4324
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1332FC037;
	Fri, 22 Aug 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUU75Hmf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD952FE57D;
	Fri, 22 Aug 2025 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869989; cv=none; b=WJegwgIF5Yq67GmtKzAVfVFheA7WAxprIBP16slGDXYO2HCk4iHB9KzoNa34fq0Tcul7eMQrADFUVdTp2/UPICkdOy+0Y1AXkC/61osE0yvRSfVRSqJJwtp+/pP0pUMhy7rQ070egMB5Kv9VgkJE6jDyY6vLgFp5wECho5Yb2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869989; c=relaxed/simple;
	bh=6lls2PNqv82LA24JN17rWOxhT+KBp/xw1JLS07INPPU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Vy9dKpLesp4MKPiLHp6YntVO+GuaShS7o0r+5/FoVuwxPCOYzjfIP/dvatTnl0OmlWDsPFZW3XIO6p3dk314djpabR8sVxJlFbSP4Qq5XsV4erqU6BcftMfPLnDcfAnBdVWd9tfU0O55CKGp5iTxKlDLEHYvPazUpp5qoPPYvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUU75Hmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C458C113CF;
	Fri, 22 Aug 2025 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869988;
	bh=6lls2PNqv82LA24JN17rWOxhT+KBp/xw1JLS07INPPU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=hUU75Hmf/NOkMXHK7mzYKoStE7q2Eza75mREBzEjUfXfoP3AIklheGU0FjV2eHAEY
	 UPq585Ft6/G4Xhv52F43ySLRyr38rI0KBLlBaUMNk2FiDzXXNkD2g4iL4W0e2KPCXw
	 NSZIY+cZKT8qdyeCmwhpdFMh3eXcH9b/XruFvadtJ+B6GO0asik1ftd517tzTqM64a
	 tYI/beKAXzv9c9Ek2kVq/2iC6Cn/ktdAbHTJ5uQLO44Sn34QsAff1zbIb51LvaGucQ
	 Z0hdip00uq0aogFSKCplh8qU/MD891lGqh1NN6a25ZK/HHllQQvtRQHefJB2BlsPSA
	 hz1e7uW29jRTA==
Date: Fri, 22 Aug 2025 08:39:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>
In-Reply-To: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
References: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
Message-Id: <175586978615.3467242.392732396361998421.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Revise Meta(Facebook) Harma BMC(AST2600)


On Fri, 22 Aug 2025 14:14:50 +0800, Peter Yin wrote:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
> 
> commit-id: 2236141ed3d6f31f53147c26208dafef6051ae43
> 
> v1 -> v2
>   - Patch 0002 - add power-12v-memory-good
> 
> v1
>   - Patch 0001 - add power monitor support
>   - Patch 0002 - revise gpio name
> 
> Peter Yin (2):
>   ARM: dts: aspeed: harma: add power monitor support
>   ARM: dts: aspeed: harma: revise gpio name
> 
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 27 ++++++++++++-------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.17-rc1-14-g326d25198112 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250822061454.2610386-1-peteryin.openbmc@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']






