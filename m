Return-Path: <linux-kernel+bounces-763321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDADB2132A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A4E3E31AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6C42D6E44;
	Mon, 11 Aug 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTE7tFWc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4EE2D481A;
	Mon, 11 Aug 2025 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933331; cv=none; b=LYfQQwcMw/+X7Qae0bLdMyFWPHf5BRBW4lAizEtaY9bvZtWejRggner8eX0o2aHwfmWZYO2tMFJejPg0kLnJt9NE7bal3rT5aXvWXkWD4KFsr0E+hAP930XtH/uAK3NwjX9nXRKodYBCRAHuNSkzgC3vkTVcr5uz2HJC1AvgJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933331; c=relaxed/simple;
	bh=9XSbHbfFnw3XIaRpvKnt/hioK7AaWjMpyvzXjCeNyEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th1Vlvzmlo/ztEtCRmBDsGZidCuSI1sleNkLQT2mZeUVEO6ys51X4r3u7KKxnOF2dLBX6QUEdERoKeQDEEAtLUY2USy5dtrVu4ZS1mNqBWpCuR0Jf6jEzl+c+L/HuyJTMCGfZatJnIyZt1YICQnpS0yM0vLuo6OamtKXa5VqiD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTE7tFWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BD8C4CEED;
	Mon, 11 Aug 2025 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754933330;
	bh=9XSbHbfFnw3XIaRpvKnt/hioK7AaWjMpyvzXjCeNyEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTE7tFWchqSfKGfWKXO+oLy2j2snSzC+gwd/SC7Zn2Cffnn18e1k3l9cXgXa/F86h
	 0cJFMZk4mJMXr0x15gQAo1zB6Im31tDgvtWVKCUh9Oon7vTw9+KqZzHRMX9LaTqfK7
	 rs9Dn2oqM0/hghOMcIDBEyQS/3WuUhccCs+XevhptWl8mkVCNnRIjYdPqnK1FrKe7H
	 Ydy8ple9K7VqfKWHQa48s692TrDWf+IbGp3ID2ulJmP9wt1KfuoEHFD58jkUvNrthp
	 22BT2SVhhpbmYVlODBpBcG/ctqMnx2IIYNVdwFoQ/+KiE/mSkdHIE5Cr6fvH/yLULB
	 AEVajkqahSRYA==
Date: Mon, 11 Aug 2025 12:28:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: powerpc: Drop duplicate fsl/mpic.txt
Message-ID: <175493332847.3843132.2055857937103048620.robh@kernel.org>
References: <20250807214432.4173273-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807214432.4173273-1-robh@kernel.org>


On Thu, 07 Aug 2025 16:44:30 -0500, Rob Herring (Arm) wrote:
> The chrp,open-pic binding schema already supports the "fsl,mpic"
> compatible. A couple of properties are missing, so add them and remove
> fsl/mpic.txt.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../interrupt-controller/chrp,open-pic.yaml   |  12 +
>  .../devicetree/bindings/powerpc/fsl/mpic.txt  | 231 ------------------
>  2 files changed, 12 insertions(+), 231 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
> 

Applied, thanks!


