Return-Path: <linux-kernel+bounces-809513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D65B50E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4BB3A5321
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E9304980;
	Wed, 10 Sep 2025 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Wm52vjo0"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF619D89E;
	Wed, 10 Sep 2025 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487306; cv=none; b=drMiR3W4tvKGH8jprxHRAnc6iE7X0QdPHxGdJpLKe4lFPn5jBmLQprrHz+U2P3QIuyIizxGpkLm0i21WOsL6lluG4vZMr3B4LP2FIVza3kQc5pyRkNvecbUpu6xwhsukJ3fKURpnV3YlJ4ORhIgWOMWTWWa2pBZUXN1KRwEJdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487306; c=relaxed/simple;
	bh=hBaHY4BNsxndwoSEevuLfbygxEfDcvCZduBgamhiLyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nS3wu6gausyuBi2cqmXv8RXQTyswf54Kyh3PGFmRYkg+TVhAPiJBEdcx237GBYzSnTmRaaFuL4OOZ/nNfegmBkJnWSnWkUbJA5CAxxtRqarDtFwmQWZ1I2frhC6ljOZ9roFcyljrK50C8JGztyX9/U7xY5tdvgHlzuuIRXPliPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Wm52vjo0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757487302;
	bh=oe3cxkXt/q2JPyVdIDXoHlk1IlmJAzFO2nNbBbqCMZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Wm52vjo0yGm9yLddJf8W6MO2tmsTQreghqcEGUTooX0HuiOyhYgcc1JAOegg9qIA4
	 ZKi4Hz2FywXjQfEbMuB68TvFcgR1u6hXWpa8DZMXLC+N6RJlW43Hu5hraj1Knqqn9l
	 y3fLQ4CESLbcdxW/4S6OhaLINhbpIa2NEncQQ4AfpfmKvYpMLRk+4re6sLuwTmBAiG
	 Ih2qA3w80tGIvp5WCexHdpkL0QzQg5BHcWifLTXW39ycRy/p8BNO7hMVzVL4T58MNH
	 vMR8nzf11pQXEqTlh3OlxaCHqufvWGzWu0zxqJ5YtbXabDpyo6+HyVWcW1JClAhFm/
	 t/ADaFTCPoBug==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7B3286443C;
	Wed, 10 Sep 2025 14:55:02 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250829211330.1336274-1-robh@kernel.org>
References: <20250829211330.1336274-1-robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Drop syscon "reg-io-width"
 properties
Message-Id: <175748730236.660876.7704019071552566777.b4-ty@codeconstruct.com.au>
Date: Wed, 10 Sep 2025 16:25:02 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 29 Aug 2025 16:13:29 -0500, Rob Herring (Arm) wrote:
> The default width is 4 bytes for "syscon" devices, so "reg-io-width" is
> redundant and can be dropped.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


