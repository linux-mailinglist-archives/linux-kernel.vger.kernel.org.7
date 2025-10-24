Return-Path: <linux-kernel+bounces-869608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12285C084F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F3D189BA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A530DD30;
	Fri, 24 Oct 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCNob755"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC42C15B5;
	Fri, 24 Oct 2025 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348433; cv=none; b=WDT3lwPJRoY/WpS3JGIGTkFFRln9mJ2ibohoG/MjNiOZG3fETCrK+9RNLOND/EIynY8OXBzHv0k8Q3YKrqOqnL5R1N1uhXqyx+loglGo7+2E3gPDNJbnvl/G0djE+9EQ1+raR7dSqmFmG83Doqt2cAuPd4rjKsg+ae7uKECHtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348433; c=relaxed/simple;
	bh=OFvHkLPz4bKUtkFNMhDATNtcRR/qinkOJZvHKA6qyyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvpcnYpvqz/quilA8KRaBaUzQ7KtAlqqaxSBVGq7TjpERrJMCDzDXjR/ZXJaTuSt29jlyMVU341ak6HIIvBVVTpTYSKIC099bjEbx2DjBKruDr800WrHdoOIYFY6mTnvqIhXDk5g/O+SLp4RgFCn58wUY3wXXk3K9ImjdhtdywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCNob755; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C7FC4CEF1;
	Fri, 24 Oct 2025 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761348429;
	bh=OFvHkLPz4bKUtkFNMhDATNtcRR/qinkOJZvHKA6qyyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCNob755tR7T4PMeWuuU/Et0abf4xgIRj/UI7dcUa0TxDyV0uyCkekhV/2IiNHC7N
	 6v5Z8gNGiC+JqJDcTtDgHH3XH2u08uXGSM/HN8gTS6+V/li8eKLBXi7z9g63nTY1WV
	 5uD9hJW5+RNH7myNjFr3/0RhJEXD6YTRbLd5n7+GxAaL2sHxVmDig6m+ddEF3dQ0YM
	 +zDRAV3O3BizrVpnARh38Otmsky1ozf+mp1sYGnGatVx3ManfgBlSjHE3y5KdHiEuo
	 3G51WFmUInvkRtdT6HHaG8ZaeGNyo/Qf2bRTxOUwe6cCxeXLLiigRnqp+CnihBlmbX
	 u2l4zEg7qd/YA==
Date: Fri, 24 Oct 2025 18:27:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] docs: dt-bindings: Extend the ordering list with a blank
 newline before status
Message-ID: <176134842548.3018332.8202750045192740209.robh@kernel.org>
References: <20251023-docs-dt-newline-v1-1-1bf5e0040c0b@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-docs-dt-newline-v1-1-1bf5e0040c0b@ixit.cz>


On Thu, 23 Oct 2025 20:00:02 +0200, David Heidelberg wrote:
> For better readability, it is recommended to insert a newline before the
> 'status' property. Adjust the examples accordingly.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/dts-coding-style.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks!


