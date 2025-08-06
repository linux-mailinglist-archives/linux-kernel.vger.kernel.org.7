Return-Path: <linux-kernel+bounces-757135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525FB1BE23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EF8625E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D613B293;
	Wed,  6 Aug 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TZ81NPG0"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1512E36EC;
	Wed,  6 Aug 2025 01:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442393; cv=none; b=irviiiKNJCK6tXNipm+6f/NJqyqWzRRz3LMMBWEZGzBSiWCMLlSiaizMjAAfX15hCU8yKvDBljLU+JCt9zU1NqbDDoXEad6z5RSVRIYlgACfTM9l1fql9noD7Y9/QVidLnr/ohv8KtRXUHChgDK5eg497q6eobWLl2oFXaKHqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442393; c=relaxed/simple;
	bh=gwF7z9u/rohQmNKBibMXPTIelepRwIhG4IPSRFG28Iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HTysFDyUBBtmRjQNY2AKAzC1fGcxTgtESNhyg0+Rtc04n24tuND0lcFXWNEp8uKg1bJ4M8ja2Q0WN/fvq5YvlUt4Yu079F6Jqa0wXUn8E2rLg9ET1SRfVHlpW94xnZ1YoQsz7cGqn+FvYmoo8hdyDda8lH1vjp7ZMYKtLwRByoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TZ81NPG0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754442382;
	bh=gJIT0RKIFHGb2UNWgeL4YzLrs92/FLX3uGi5Yvs8A6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TZ81NPG0Tpthj1GIOe4bGS2Jubcfz/OZCd47fs81p3MHlpHRx/JE1InaYGm1VNmOk
	 eegoZnSabX9UsZBc5kuxapDFz38wPr2kJfNLamgqMfqaKGt9KBOM3d2zV2xQJyPvbH
	 RcgE0jDa5P6hZTKSC762wBbswZAcGQr8R7iyf/uIF1qA5VFEJlMytsYQnRMuquWltS
	 MsooPpG02HSaArN3UPkzb16C464yxUmRG92PbOAQrrKI6UZ60k0uHV50kfPsphAoWj
	 uKxxH8XDDXSROrQApO09PBPyG1UTiK5scUtVKJnisHowTMYQrzGg/7kWXkIswrJZoQ
	 PFRrzAFd7f2Ig==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3982D67B49;
	Wed,  6 Aug 2025 09:06:21 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Tan Siewert <tan@siewert.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250803151822.68080-1-tan@siewert.io>
References: <20250803151822.68080-1-tan@siewert.io>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Convert remaining ASRock systems
 to NVMEM layout syntax
Message-Id: <175444238112.266976.6701389016981871511.b4-ty@codeconstruct.com.au>
Date: Wed, 06 Aug 2025 10:36:21 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 03 Aug 2025 17:18:16 +0200, Tan Siewert wrote:
> While investigating an issue with an ASRock Rack platform, I noticed
> that most of the ASPEED device trees using NVMEM cells to populate
> MAC addresses still rely on a deprecated NVMEM binding syntax.
> As a result, the MAC addresses are not populated from the
> device tree/NVMEM cells properly, and an address from "the chip" is
> being used instead.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


