Return-Path: <linux-kernel+bounces-797862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753A8B41661
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB5F7AC491
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2D2D9EE4;
	Wed,  3 Sep 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aOf5SlQ2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D412D6406;
	Wed,  3 Sep 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884418; cv=none; b=qMpUzqTT38rx5d9h5CKqZ+gGBONzh9adCuJg2xAUIuK3p3hPfIILtASWgJxkzrnxoWGGDqLkQUkop16Hg4AAcdQmsjvjnYRckNmdWzK23tDpGYICTVmORKWwXRBTKegDiJU0KsL2g72HCYizKS1jrLvLltDqVLiwLjpBthR/EbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884418; c=relaxed/simple;
	bh=Q9zDv/05HGKmdmHN91IffHDr9UQiyp9EqlXfNfBvWFo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iY0feSZ5rcFkFa0pQ+jo01fOqVySRqjbAkurWuS5M+KT99q6aG8Y4lSqS/gBD1lWsVSTSPjDAF5/8Sk8JByMuvEOuAAZLQOaqOw6PaxXqcGcwvn6UB6SIDfLa9bT18iUYNV/Ox8dURBGse2hWsJDtj90qKKt2MOUPjHfM+jEg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aOf5SlQ2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756884414;
	bh=B73c6gIij7Gu6gmBOylUKaG4gwTrC9yCJueKMpwDFZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aOf5SlQ264YuDbugUNcQnp9ITm3FW+fR1OtXcY1vH+C8DTn/fQhqFiVfVuG/VSx1n
	 FUsH3jFxrM5/Tk1/pjhY0nOxGio7ty8X4zjqrtcXcI50WjlCUI974zKe78nq+XSMjr
	 yvvWiugSF6MH80RvUzwN2eb2IA4yHehGaJFAhZf+IyvYp+bah0DjAO0W0Nbahb3YCh
	 FwsO7r0EVtwUX9RQabtQGcuqbKnyRuXg1z/SSjgne2RQRtARyNACsVaH09xGat8Cj/
	 oob4cNBE3JHUgxTug5nCvUwWyPoZOlm1ZmlIhbC0bchowqB+Zy+1wvE/kEouCgXjE0
	 T86W4x/Ni5NDQ==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0ED656445D;
	Wed,  3 Sep 2025 15:26:53 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250829211318.1335862-1-robh@kernel.org>
References: <20250829211318.1335862-1-robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Drop "sdhci" compatibles
Message-Id: <175688441391.934266.14858945902852809199.b4-ty@codeconstruct.com.au>
Date: Wed, 03 Sep 2025 16:56:53 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 29 Aug 2025 16:13:17 -0500, Rob Herring (Arm) wrote:
> The "sdhci" compatible is not documented nor very useful on its own given
> the various features and quirks of SDHCI implementations.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


