Return-Path: <linux-kernel+bounces-730759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39702B0496E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B997F18945ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DAF27876E;
	Mon, 14 Jul 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNo29eRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2424169E;
	Mon, 14 Jul 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528159; cv=none; b=QLJ8cMipdQ1iNFV80SeY+i1c/1YLXP4PhYUXAsll4FDeOKLevJwZn29J3uLQd+qM5tdBKwDpxjQz90/wsCO05CaMq+NJEcwKfidNF6oGd/UPwzu2CRckgsjg49xSF7XOUYUeUChMxG4DO23DbZ5X/jW1aUD9snfxgvxsPm0+RqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528159; c=relaxed/simple;
	bh=C2GzKnGt2FdcoiOL1j1VPM7AnoQqPtb1m1M19Z+dm1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueiwN7dpq/Jjsfbfbl8HNa3fONganzLsYdQMzzRUNIUbgXBjuuSM/aJ2J2/bTb5vXfdtfW/1DS6pxHZ+G/4L2Y1rhMAcTI+dvT0ZKK67tfQvAv4f57jsbyBf/ex7hT62h6YYJwAMeRlsappAbo73bllSW6FRWjxRE4pdkHd5nTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNo29eRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A52C4CEED;
	Mon, 14 Jul 2025 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752528159;
	bh=C2GzKnGt2FdcoiOL1j1VPM7AnoQqPtb1m1M19Z+dm1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNo29eRfMJY8hYrOrajDWs60uJSttqfGBuKsVf9jwQ2X4nqLYHf+y+G/cKlEv6K7D
	 IH82lnf1TyjRfvr6Fb3233+e0zNCFFrzqLm/ONuY6NEPWECO7hBIsfm3ZfEtDZuYcv
	 gzrOm7u9EdYvqMbObgxv7rw5qxu5PqVr1lDv27SC/VKVryOupntazNxIPHNttw9lHy
	 WijbV3fqRU70hUBdgHe73Rb6ZEafG+0j24Yvl13qkuJRo6Pnc561Dn4Q3WlUW9tSyd
	 JIZ/95FmEr90HdEqplYk15F0IAJPNCiknQg5TBEg2hfhHRqEE0vAmn8e4Oea/hwrnI
	 dQhmgmYbixZ+g==
Date: Mon, 14 Jul 2025 16:22:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] docs: dt: submitting-patches: Avoid 'YAML' in the
 subject and add an example
Message-ID: <175252814379.3190089.3499993933519513496.robh@kernel.org>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
 <20250713-dt-bindings-docs-v2-1-672c898054ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-dt-bindings-docs-v2-1-672c898054ae@linaro.org>


On Sun, 13 Jul 2025 14:46:36 +0200, Krzysztof Kozlowski wrote:
> Patches adding new device bindings should avoid 'YAML' keyword in the
> subject, because all bindings are supposed to be in DT schema format,
> which uses YAML.  The DT schema is welcomed only in case of patches
> doing conversion.  Effectively people get confused that subject should
> not contain anything else than device name after the prefix, so add two
> recommended examples.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Rephrase - use YAML instead of schema, add another example for
>    conversion.
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Applied, thanks!


