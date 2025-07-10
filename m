Return-Path: <linux-kernel+bounces-726617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E89B00F50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708F21CC0357
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CC2D0C73;
	Thu, 10 Jul 2025 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npFJ9pss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797B2BF019;
	Thu, 10 Jul 2025 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188981; cv=none; b=u+gFZfcUcOjcp1aGVy4ccb9QJrhOF6NFwXrGB7aUImfIh04t4hsZNecTRq0Sb6sMG48eZuDZHtAQgt+p2DVlMHXATdNJeWcO43+lmUSNS6e2Qw1CkLUjHwJZHykNMyFZKHPQdPuQQHnlK9HQW3HzixnOEZ1s+jTsvZiiXnGuO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188981; c=relaxed/simple;
	bh=xX1Y0DxEL0262QrqSMHrEjgZLmOO6gChgX6+avkZ/Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVlbplEKSNDV/AB24nBggs0S0z7n0kiyyP1bS/PahGocKtsBLsvBboy65QmuURsokc6TsWdtZBV9CRLWiR7mhptpuV8x2g1ejnthIifrHbNVqmqn9tVplkqAGtM6ECgeVCQ0A5agahWqLLglKQr3a0jwZS/2R92masjex6DEmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npFJ9pss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7CBC4CEE3;
	Thu, 10 Jul 2025 23:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752188981;
	bh=xX1Y0DxEL0262QrqSMHrEjgZLmOO6gChgX6+avkZ/Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npFJ9pss1Ak9vVLoGluAR2E594OevgHB6Dtu3eQAc6H/4R7Jur+PUJKlk5Z6W/iYM
	 ciAKP3hPk+/3Gzr+IWFE814C5cDSDBptvgrWjB1Sfjm5J0VCLUFLS2sQTHbCgyxwbu
	 ydhQACEtbz1CgV5nNe9anBHZbXNq8WDJxeT138L73EqtUUymDLTChix2M0FcU60Ug4
	 fiwphlsr6YMfveeJ7uHZ0Kab0vpH4FbKNVl4kCgoI51jU5t+mvZ7VQpF2yaiTRPiqZ
	 oMd3kc54s/dBARmQTe6aRTn9MkpGi3EWh8e6Z0ujFk2URctyIx+arEfq2B2iSKIznD
	 8+795ZEEvq5Dw==
Date: Thu, 10 Jul 2025 18:09:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
	devicetree@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: ti: Add bindings for Variscite
 VAR-SOM-AM62P
Message-ID: <175218897949.53397.7050209461596746496.robh@kernel.org>
References: <20250710162737.49679-1-stefano.radaelli21@gmail.com>
 <20250710162737.49679-2-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710162737.49679-2-stefano.radaelli21@gmail.com>


On Thu, 10 Jul 2025 18:27:26 +0200, Stefano Radaelli wrote:
> Add devicetree bindings for Variscite VAR-SOM-AM62P System on Module
> and its carrier boards.
> 
> Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> ---
> v3:
>  - Change compatible string to match existing mainline format
> v2:
>  - Add symphony carrier board compatible
> 
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


