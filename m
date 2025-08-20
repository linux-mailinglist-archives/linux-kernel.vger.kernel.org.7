Return-Path: <linux-kernel+bounces-778424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEECB2E580
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F045AA1D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384328315A;
	Wed, 20 Aug 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMO/A7aH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECC17A314;
	Wed, 20 Aug 2025 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716962; cv=none; b=q/xsn+tkYpoFhnhmlupbP563s4taEzteGVtmdVoIMGqvd0XWsGubaeagtw967H6/MPjfG4efRm3H/FWImLDXe7T58VjZdKIu1iEx48QMqcg96CjBFithjC//YPGN95LujtTUfeC+6ZNRkiStN8mRTGzuBzn4YFRJMA5p1+uJP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716962; c=relaxed/simple;
	bh=QApGMDIX6Oj5p80GmS3mkapVrvJtEATwOMN/ejypAzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDeCWk8gz+XTSzIZB3hBNCBmXPqIdRCW3QxAqVXzxE3pWXMHq744ut5mdgEwBovStNGJGE9Y0mMxPlMCrSaN4Z4SQNhjToX0XusHHF+PfepVUxk8zQhMGSZ0KDpScylMFts+QPvUl3565x40ZPHSSFzjdGZV/GByf/ZroBVkHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMO/A7aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CE2C4CEE7;
	Wed, 20 Aug 2025 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716961;
	bh=QApGMDIX6Oj5p80GmS3mkapVrvJtEATwOMN/ejypAzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMO/A7aHQeBqF2MDvumZjS4atHCyocjn0dxcWaVVrr4owdSOGg/cxhEqkSGvU+LaY
	 WyZpUR0UpGtOqATDz7Everx1X0EJHFu7zkrXD0jTdJwFvNiHFEE5RvG/frZH4fggjp
	 //cW7FpGe0b0W9aKlCtjdkCDHZxPJY7bxfUg0G9JlMFln5npl6BJD8A9b+JXGd2Tt1
	 CJ/SmZVbNRPGjIexEbCiO8cAM++PDsE3Qop0RDlP1XwGtE5HJEw3mjRiqm9XvzJMqv
	 Z5c/aDFatfpqZoQyb1aQlWBwiYmRYuzPuhua1S5RG8uVyf4EmjTEZFs/jYTBrLKhpb
	 5z6cjMy6houFQ==
Date: Wed, 20 Aug 2025 14:09:20 -0500
From: Rob Herring <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: apple: t600x: Comple WiFi properties
Message-ID: <20250820190920.GB538860-robh@kernel.org>
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
 <20250813-apple-dt-sync-6-17-v1-2-209f15d10aa0@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-apple-dt-sync-6-17-v1-2-209f15d10aa0@jannau.net>

On Wed, Aug 13, 2025 at 11:53:34AM +0200, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>

What does 'Comple' in the subject mean?

> 
> Add compatible and antenna-sku properties to the shared node and
> brcm,board-type property to individuall board device trees.
> module and antenna properties
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm64/boot/dts/apple/t6000-j314s.dts      | 4 ++++
>  arch/arm64/boot/dts/apple/t6000-j316s.dts      | 4 ++++
>  arch/arm64/boot/dts/apple/t6001-j314c.dts      | 4 ++++
>  arch/arm64/boot/dts/apple/t6001-j316c.dts      | 4 ++++
>  arch/arm64/boot/dts/apple/t6001-j375c.dts      | 4 ++++
>  arch/arm64/boot/dts/apple/t6002-j375d.dts      | 4 ++++
>  arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 2 ++
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 2 ++
>  8 files changed, 28 insertions(+)

