Return-Path: <linux-kernel+bounces-857328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E525BE6871
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C94F5572
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF0622128D;
	Fri, 17 Oct 2025 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ka4i6dPR"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D523EA9B;
	Fri, 17 Oct 2025 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681095; cv=none; b=odakIQ60Z7nNFxnbgXPJy/TL/7FuWRIAjGNBei5ME7FfejeNxrCp/Ho5+ExAoSEnYQiEuFyUp7D0EK0WKYK3ee1cbieW0bICQooYAJUjuzb1fyk9PtGcS24K7uzuWNzmSg4BO9CsRLNQNG5EbYzY3gQ5G3cDRnWvGLsVm6Ltnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681095; c=relaxed/simple;
	bh=hbpIrA9xw2Yzg0P72gT2O5zClo/BjHJ2wgQFfKh528I=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ivC31wEkbHtiv2SPv8Syxjx1uj8LMMfbpNlrP9xVylXulTcNPDSy/N31YkjrVrqqpTij7mWQKsL+ku6dgGMLxfNGhAY8fCZcs8l3JeD408BETUadl1ofdnRZBCHlXTYnnTzgqlntanlSFq94vELcL4hOfdUNzI08IsTKBmoEB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ka4i6dPR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760681091;
	bh=aSPqFe3S0bFVfaza5qOmb8ksimgWhn1Shr3aJzL1jL4=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=ka4i6dPRHxsCXqsyxlL789vXXBplQXn+rQsOZupQaXGVhS2VfvbN5EspJsCrA96ce
	 N3B+5bHeblJ8q5T9XYzhouTFLvxPrm4RLuCTtaNzWtN9t7BJMlZpOROBHFgGFgyGFI
	 bMRSmXhF2HxrkiTY2lW5RxBuJI3ZLbJDd9CMXUmTNr2+LeRayr92hbPmkMtMUOdTS9
	 IVbG0COzvRSjOrytIZH5gwSwWkKs9Zuh8NvAScfaXQZkQuyQeDfgg2MwnsUYyY32YT
	 wlb5i3QnWHsFJnpw08f36blNsbgcTvPJAYU9AsnsLfmTlcSFMgTyHNggw8eUiSuiBB
	 YAhZ1F6+qrhfg==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E73C8766F5;
	Fri, 17 Oct 2025 14:04:50 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, Guenter Roeck <linux@roeck-us.net>, 
 Tao Ren <taoren@meta.com>, rentao.bupt@gmail.com
In-Reply-To: <20251015204840.80070-1-rentao.bupt@gmail.com>
References: <20251015204840.80070-1-rentao.bupt@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: fuji-data64: Enable mac3 controller
Message-Id: <176068109091.239120.10783664740576101312.b4-ty@codeconstruct.com.au>
Date: Fri, 17 Oct 2025 16:34:50 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cfd50

On Wed, 15 Oct 2025 13:48:37 -0700, rentao.bupt@gmail.com wrote:
> "mac3" controller was removed from the initial version of fuji-data64
> dts because the rgmii setting is incorrect, but dropping mac3 leads to
> regression in the existing fuji platform, because fuji.dts simply
> includes fuji-data64.dts.
> 
> This patch adds mac3 back to fuji-data64.dts to fix the fuji regression,
> and rgmii settings need to be fixed later.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


