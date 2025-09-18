Return-Path: <linux-kernel+bounces-815896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E43BB56C66
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25641175D49
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6365E22D7A5;
	Sun, 14 Sep 2025 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sTyV6vcQ"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325112DEA75;
	Sun, 14 Sep 2025 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757884658; cv=none; b=TdfHfSfhGVFH62RKnyMsWdfQJjyc0VAVbj00Vrcq7frKzNK8hPSyy3rPYrt1q+uNCcYIapzUYR82+8wztkZdDZjnq9QfPY/uGexztbouFQ/Y45rUlj1wrH1VqfCH8Gfvqj5mLWrxz3sfrnyMwchfPfy3i+s74/Wt/LL4eIOqH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757884658; c=relaxed/simple;
	bh=eS4EkHT9wQ8dbFeDRO9liwQC9Uky0mZDAzalZEYEZJc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R//NucCrqz/ngWdtW6RyM+VWC2+ZqnwCvhFV4wXq29YHL55Ikeo0JXJEKDzLLhNdsfyrYXqMR3ZivSqPKpR/8H6Q4pTeneGTuXSIAfg/vqRAl0Kqw5Yoo0qF7CW+Jn9a5hJ9bDZnKQOFN7tAudwWHfBToZ2VbtU0vxJWGP0Mz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sTyV6vcQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AC3964E40BD1;
	Sun, 14 Sep 2025 21:17:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 830106063F;
	Sun, 14 Sep 2025 21:17:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91E20102F2A7F;
	Sun, 14 Sep 2025 23:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757884655;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=bwgYGLVw4FvwSrXLDhUaGBwyd0Ch8i1Emb7X+v26uqM=;
	b=sTyV6vcQ7aNeiJCqjTT936B7vdGy4WQNWApnGTKPcAvq33b9pTGYDOqPtLP3F7MkcqtcJm
	hE9fG1ocfnFKfXQMG76eqQrKMNORE+t9YvpCu7MBm++2HSX2heXFqKt5095bCKjTfgsB9m
	umbnvx+lcyASn7p1fied5B3bziruG6oPy/ZKOKwXVtKsxHW9eyZD+fD7zc0cywVyjIuhSt
	bleGV4f3Zj5nlNDMtT9nXCQEsYX6dT+zWr4oACeugEFWcr2lAoD/b5vvJdjtx/IsZn4G2/
	Pmpb0Kn9Suq/uVoVJYVOIcrVZt935hd+Q1AE+xQ/fdK4l0zU9keEDeKNATbZhw==
Date: Sun, 14 Sep 2025 23:17:34 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] rtc: s3c: Drop unused defines
Message-ID: <175788449952.388732.603913346670882108.b4-ty@bootlin.com>
References: <20250830130024.142815-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830130024.142815-4-krzysztof.kozlowski@linaro.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 30 Aug 2025 15:00:25 +0200, Krzysztof Kozlowski wrote:
> Drop defines for S3C2416 and S3C2443 SoCs which are not used anywhere.
> 
> 

Applied, thanks!

[1/3] rtc: s3c: Drop unused defines
      https://git.kernel.org/abelloni/c/06625ab00682
[2/3] rtc: s3c: Drop support for S3C2410
      https://git.kernel.org/abelloni/c/1e41547c2041
[3/3] dt-bindings: rtc: s3c: Drop S3C2410
      https://git.kernel.org/abelloni/c/063544dad4a7

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

