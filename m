Return-Path: <linux-kernel+bounces-738682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F05B0BBE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BB818985DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69513217666;
	Mon, 21 Jul 2025 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZjEIv7Cr"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C607A94A;
	Mon, 21 Jul 2025 04:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753072997; cv=none; b=M6tODy5+nn9uGxxRpFw664SD6Rdx2TlfCaCrpsUWjhMQ16sVhamskV11h2S3wfpcf5WeMGfSzDGQ1lhlcRZV6tlA0eREcBzT/V1e8RauvBDKEJfu029ZFUD2PKmuVIRCBIRfiQ6XvouCR+MFyXrvFidVvcOQ9c41WXLpdEhZ42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753072997; c=relaxed/simple;
	bh=0i6A+1XrUf7QuLm0dwWvx3CrPiEU9TCYzB6OwtDo6No=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qkYqCIDC84mTCb+ZxBCIOAGEQ3tFUTpM5K+2ZQZm7E5XPcu3cEAc02QmEfe5bszjMzZTrvGOK7mMqvcmtPe8+658Qmr6Gh/eZ9L10cTzKOqc4AdJ8wf6EzGRaStTixVdRPEIcJOorOtFlr/OkpjV5hWBkRcK0Iq7A69aaBiE9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZjEIv7Cr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753072993;
	bh=fRdZNGifouDmJ2uwnu+wXzxgWMn3TwrYZoV6l/awc38=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=ZjEIv7CrUvICkPHfVi3mYNahmjzC4Wru3WGkmnpvIhw1qDmCJIPFJbktFZ+KF1Bnm
	 ApWf11mPuAUJl0QIBFz9RZP1mtuSBMZWSbGAnGOAy+PywCLMVWH3wmWRLuYGG0ZVMc
	 c4X2nTwIdcop3wpwYCGkIm2vygDZAtqbEQFoUpaEM+xsQ+NHlJ2Oalg+l9slv/2USr
	 o21MRklJZZWNt7FU1B6rQ+nFgN4CNj/SHpmniWJ1krEYWR6finfZLQMm7/0FS2RNNe
	 8vhlotz25soUYPGIrhnhskCb1jtF5stVPeCtA719RqihCmL1dodwKzJCWyAzBiaHCV
	 TZlu5k6Ia3imQ==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4D0F7640A2;
	Mon, 21 Jul 2025 12:43:12 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
 Benjamin Fair <benjaminfair@google.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250717142301.92548-2-krzysztof.kozlowski@linaro.org>
References: <20250717142301.92548-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: nuvoton: Use generic "ethernet" as node name
Message-Id: <175307299219.1632952.11825980822005039610.b4-ty@codeconstruct.com.au>
Date: Mon, 21 Jul 2025 14:13:12 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 17 Jul 2025 16:23:02 +0200, Krzysztof Kozlowski wrote:
> Common name for Ethernet controllers is "ethernet", not "eth", also
> recommended by Devicetree specification in "Generic Names
> Recommendation".  Verified lack of impact using dtx_diff.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


