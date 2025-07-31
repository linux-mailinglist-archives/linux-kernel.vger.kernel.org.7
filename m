Return-Path: <linux-kernel+bounces-751561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42347B16AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D38F16B587
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034392405F9;
	Thu, 31 Jul 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HED3WeGH"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707523D284;
	Thu, 31 Jul 2025 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753932730; cv=none; b=R5IHb+xL0Xlw4p0hMNpI/wVpj4YLg2mWPAj/SX/nzj7k9HqkgiDpoYuWslvwgnId36gLrOxU2U9jiBas8LRaByu/v6Jc/1iVZv8MDOCXovZPlNudHNtgvgckm9t3jft36+vv4+4Ftsvyadogzs2GmqZOwu3/BEA+msR5Gk+ore0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753932730; c=relaxed/simple;
	bh=qNO6rBvM8Plk03a/j9NMkpD7uwP09UnFPrT5Sf/gRQg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bqGNcbuCLlTe2bbPXmsAFyv8GIgtjz7jz7ZFnJZ54nmV2t1RYCQdQ/XCAGXY64NbbDxzvl4KHH4vJODLWu5yDqcKaAcu0aNP5xbaowsbZc10e0b+DrPzMP/xXao/FQD4ZnKboe8KEroYdzd/T79ZF6qcW0ZM8ZiSv6MhmTeE52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HED3WeGH; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753932726;
	bh=quiVJQfgnApnKSx34eCN3/yRSyocJqA7hv+N5gRbILQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=HED3WeGHV0Udep18IegiMfm6WyZlqxMnpgN54EKUnt8wMgVd8M0P+zL0YU6xOr1lO
	 QmRpXuJL5BNJ4pgcIoRvFv5u6B6FR8zIjKg7jFqkngbo77xRRVHegq8daiCUNuT9pb
	 3zA/k9KJVq6oeEgE55h+3wpLuwI6MyzLNKmPLhQX/eGppaQ9LSX1rFv5R/EFj+NP2e
	 VWy7+O6U/GcDfhS8/E46pba3iH2HuLmRAFoQcAA2Ztn3cazv800rajqNjABIh/dgOL
	 F/sL5gT+Db9YVVfXP1nkufrPIdBh5i6IKvji58x2S+X456962TN3pQaLf5bcuSwof6
	 b1a3QTn9Ct97w==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0D10F69374;
	Thu, 31 Jul 2025 11:32:04 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>, 
 rentao.bupt@gmail.com
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Subject: Re: [PATCH v4 00/13] ARM: dts: aspeed: Add Meta Darwin dts
Message-Id: <175393272444.1011263.10036967590309258484.b4-ty@codeconstruct.com.au>
Date: Thu, 31 Jul 2025 13:02:04 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 27 Jul 2025 22:56:02 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> The patch series introduces the initial device tree for Meta/Facebook
> Darwin AST2600 BMC.
> 
> Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
> ast2600-facebook-netbmc-common.dtsi.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


