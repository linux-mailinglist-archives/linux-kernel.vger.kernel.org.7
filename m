Return-Path: <linux-kernel+bounces-731086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F97B04EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE211AA352B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB262D0C92;
	Tue, 15 Jul 2025 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7PuSuWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051006FBF;
	Tue, 15 Jul 2025 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549940; cv=none; b=K4TxC7HQWorBIts1JaoKjjxENVjgJbkLWuCZ3ZdH44EC8rOsdAZPLZrXQ1Dako3dSddSw2Ls4P30stuM/lJ3N5Sdlgcqse1MD6ZNbj2QiYkELZDs7ODaLUP0AhYARNkLfq03G/hsZ9ALJbmsTIOXCLwR2I5jrR0T80UwiHC0O/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549940; c=relaxed/simple;
	bh=lrzxwWtwZkNCjGp2yhM/QISkZjt3HFGiOPAd5Hqt0KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhbnCdX10xbDMhHbZ3i91xR4X2wipzrBhdDI+5ngDYGmLrTGOYjDkpIBLOI5qaI+79TSuECFCEmAr5KMBeimiKXQq/IYc1AA6DIUEnw456FNUut/RQCJqY8FEq85bWYlY0/tPRKJmc6c6Ecwae/BqPnZi01F0vJ/a8ETlY6xa5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7PuSuWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42430C4CEED;
	Tue, 15 Jul 2025 03:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752549937;
	bh=lrzxwWtwZkNCjGp2yhM/QISkZjt3HFGiOPAd5Hqt0KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7PuSuWTWcQFMmtXjLrtDpl0Wtf8yAEkG/+jxgWUPWVdfVewQhkYPINJWaZeJnGkL
	 IJlfTX36KVei4CWgJEPFO5NdUlNSSP9L4bxSUpEIlXmmXPH+jkdfMPSArdC16a+eAp
	 xMWYqKLUl7L41VtuTvD92OsktDQQ86qlL6DPGm9ZJgMV7z9SfynC3u0TN+T1VuDrLX
	 bcyUk2yIwJAODrgjDSTwm3g8Wn6LJRVHZxJItRhHOkLTVeyXax+rUuvV0PxZNXXi9W
	 Q6/BhBB2bP17M9NSWxohunwAX8SzzQs6Jbes5g5c1676g6CoFP5Xf2ubOwMagP7cBf
	 eD3V9ig8YRrTg==
Date: Mon, 14 Jul 2025 22:25:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: palmer@dabbelt.com, spacemit@lists.linux.dev, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, alex@ghiti.fr, dlan@gentoo.org,
	skhan@linuxfoundation.org, devicetree@vger.kernel.org,
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, conor+dt@kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add OrangePi RV2 board
Message-ID: <175254993587.4165390.1905297422239367623.robh@kernel.org>
References: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
 <20250711183245.256683-2-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711183245.256683-2-hendrik.hamerlinck@hammernet.be>


On Fri, 11 Jul 2025 20:32:44 +0200, Hendrik Hamerlinck wrote:
> Document the compatible string for the OrangePi RV2 board [1], which
> is marketed as using the Ky X1 SoC but is in fact identical to
> the SpacemiT K1 SoC [2].
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> ---
>  Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


