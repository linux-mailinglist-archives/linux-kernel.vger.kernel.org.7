Return-Path: <linux-kernel+bounces-779105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE0B2EF2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5115E2476
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE14027C162;
	Thu, 21 Aug 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZEfGI3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5027CB35;
	Thu, 21 Aug 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760371; cv=none; b=Aj0y5UHIhrsJyp1JOOqa2NqTS1murMjODSeirmELsR9T9pFQPnAhun+r5YDxlImNR8dBSdk8N3gNsAGiqkUaVIbZ4jTt+qt3FJz77tHTSBhub28HxD5BUQmjeGB7xMA4n/nMlHX60JQEp/ENZKcQiQFjYrggbCzzBt423HjbLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760371; c=relaxed/simple;
	bh=FWxGFvQTaapdzLI5+1ZbNCfPnYXpL37LgOOTiok+nck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN+i7i46RinCVhLmXgjOHB1McBBiOXuau5jFmm2DvjuV+A5IcoXSctgKlSbNocEKeuQ8yGQJFSITcdtNFMCFCBQZUJNP9wp7c3lfUwdw7IgpqQdvJEh+DOzxzOCTiAZbcvVLUu020h0yjGhjRS9sLGY3cv833QjvbVs1/TYnzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZEfGI3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAC0C4CEED;
	Thu, 21 Aug 2025 07:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755760370;
	bh=FWxGFvQTaapdzLI5+1ZbNCfPnYXpL37LgOOTiok+nck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZEfGI3pJKC9x4yDuPEq68uBSePJeLjOV2zeQcPAYB5XSTyIwmUlLRJ9XCCHlZuUN
	 VKYCEtB0SgE/aD5TiJjZEq2/xBepqr+TuppMesuM54MKLrjAEktHTdbDFVm+0CL6Hf
	 iMVrraKV0wkBlcCHqcUg9Ewm/AnLzlKxQ+hnmbmLyDofbTQ9LWX3MIqcdl2aOfNngY
	 gW7BdGcMS9sT3y2i7+QzSQ/8Uj0A7bJYTiu4odA6EqfbcirtmdIDEJ2UBWsxOiaEDh
	 loGtM9wvwiiKqJgDcaKLantSxlmluUD3S085Kl5hitaXbBBm0OdEbRGg4m5N70VVf1
	 duo1x7hp/wZ+g==
Date: Thu, 21 Aug 2025 09:12:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marc Olberding <molberding@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: Add Nvidia's mgx4u BMC
Message-ID: <20250821-bouncy-robin-of-witchcraft-0bef2a@kuoka>
References: <20250820-mgx4u_devicetree-v2-0-ccd2831b29ac@nvidia.com>
 <20250820-mgx4u_devicetree-v2-1-ccd2831b29ac@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820-mgx4u_devicetree-v2-1-ccd2831b29ac@nvidia.com>

On Wed, Aug 20, 2025 at 06:32:51PM -0700, Marc Olberding wrote:
> Adds a compatible string for Nvidia's mgx4u BMC board.
> 
> Signed-off-by: Marc Olberding <molberding@nvidia.com>

And that's it? Why patches from nvidia repeat the same mistakes over and
over?

Best regards,
Krzysztof


