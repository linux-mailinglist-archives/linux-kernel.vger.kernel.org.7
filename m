Return-Path: <linux-kernel+bounces-731659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0489EB057D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4731C234B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B82417D1;
	Tue, 15 Jul 2025 10:30:15 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965D23ABAF;
	Tue, 15 Jul 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575415; cv=none; b=meEnSMb5ivXCNdkPp/RcgFUWSjjdJoLekLFfmogZaGPu0CUfXOqJarSWZgtpqpS8zeRd5gk9zvo33YB++SQ6uQkghc1kSWF98mBHElcEnLfo2sSyns+Zvw+D2wQ9/zltEUmRK7B5cXFCLto4qizccv9JcXt28sMDFP6KQ6uabU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575415; c=relaxed/simple;
	bh=8Vd8POKs3Sp/OX61qit7SX6WXDD/xYLrFG1hcSUXUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paaPzVaCAzcV1hviEImGIgrvhN0xkg3y7IJ9vaBUUwpGJr2/qMD5PkcObkEFcBIEU/3UnpzCgCPr19iXJNsTGUzznuIvmdZGLvczIpK04LT05xAl1Mkd+Tal4ead18baq0zMxBnwKywDpxEhlYyTTyap0zRBHwmQW7IC/NjsEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8CB11340CE7;
	Tue, 15 Jul 2025 10:30:12 +0000 (UTC)
Date: Tue, 15 Jul 2025 18:30:06 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	palmer@dabbelt.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: dts: spacemit: Add initial support for
 OrangePi RV2
Message-ID: <20250715103006-GYA540303@gentoo>
References: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>

Hi Hendrik,

On 20:32 Fri 11 Jul     , Hendrik Hamerlinck wrote:
> This patchset adds initial device tree support for the OrangePi RV2 board.
> 
> The OrangePi RV2 [1] is marketed as using the Ky X1 SoC.
> However, after research and testing, it is in fact identical to the 
> SpacemiT K1 [2]. My proof:
> 
> - Similar integration in the Banana Pi kernel tree [3], which uses the 
>   OrangePi RV2 and identifies it as the SpacemiT K1.
> - Comparison of the device tree code showing a match to the OrangePi RV2 
>   Linux tree [4].
> - Locally tested the OrangePi RV2 with the SpacemiT K1 device tree, 
>   confirming it boots and operates correctly.
> 
> Patch #1 documents the compatible string for the OrangePi RV2, and 
> patch #2 adds its minimal device tree. This enables booting to a serial
> console with UART output and blinking a LED, similar to other K1-based 
> boards such as the Banana Pi BPI-F3 or the Milk-V Jupiter.
> 

The patch overall looks good, but I wouldn't pick it for this cycle,
as I've already sent out the PR [5], so let's target at v6.18 merge window
(Please remind me or respin a new version once v6.17-rc1 tagged)

Link: https://lore.kernel.org/spacemit/20250715014214-GYA540030@gentoo/ [5]

-- 
Yixun Lan (dlan)

