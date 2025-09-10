Return-Path: <linux-kernel+bounces-810106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB0DB515F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7C23B97AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E130C371;
	Wed, 10 Sep 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L96dwETf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF4221271;
	Wed, 10 Sep 2025 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504425; cv=none; b=BLf534wvtaArTVrDGDwnKMMVRqilSx6kP8+Qtde0dpZvnBPdoOIEMcQ2dcJzR6ZDdX6P4XwKHtPa/dMacBCz4zU6AH5873lPwS5YKcO20S8hojEnyPAkbRvCaUFfB1N4GZSkHdTZEVcPj0wxW3MpIJ+VY2RIlWM2m+/kRsv0DGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504425; c=relaxed/simple;
	bh=yG+NMaxzNA8zIaIVLj6jr5NYBeJjfeuertNdU0usCsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBeJd7hevvIKZLiNo53uoG2bt5NUa76nqO1wWkAxXq+mQv2fojxBGTyaCE0+FZNqa8XYvoXiSWaNYKkoBLa1Huwn5llLvWyuPIhFM3OPt9VKakNyWTv4MMq9445CP4Ncu2XGZudXI3RWH+CO6ypWNc0ybD2sBOt4nTbK2moQU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L96dwETf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D63C4CEF0;
	Wed, 10 Sep 2025 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757504425;
	bh=yG+NMaxzNA8zIaIVLj6jr5NYBeJjfeuertNdU0usCsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L96dwETf4nJsRVmr4Mqv5w9o4oKpkrzyrMRkuxfKJV4O6QI+si1/rbdIwOWXOEXy2
	 DEYNQytfbt/pGdsZK/F6tpTKlhSoIZ34X16X5jHDa7nI9fW5ywdsIsg+MtGfNRSiGp
	 OnZedxxr9+hFCewsLCqA45nRhn34uvWoJ7yzBDdF83+Ql0+2xbkpvBwLLo1BWnMUEw
	 MKmGkt7njWkEUMo0lFZSfA7ggcAkmrTluTqSSu6nGYfcwumxvyNhUS7y9ILwUMDZtN
	 EZ0zlxK+dFJdHXPDONsdlhs4OqcObKvFrwkAdLZ62KxwQR5JsRLC9F9RBYXR1L9fTH
	 JaYlyXetTsRyA==
Date: Wed, 10 Sep 2025 13:40:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	tudor.ambarus@linaro.org, mmkurbanov@salutedevices.com, Takahiro.Kuwano@infineon.com, 
	pratyush@kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add
 enable-randomizer-otp property
Message-ID: <20250910-godlike-berserk-sambar-cd25f7@kuoka>
References: <20250910030301.1368372-1-linchengming884@gmail.com>
 <20250910030301.1368372-2-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910030301.1368372-2-linchengming884@gmail.com>

On Wed, Sep 10, 2025 at 11:02:59AM +0800, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> Add a new boolean property "enable-randomizer-otp" to enable the
> randomizer feature on supported SPI-NAND devices.

What is randomizer feature? Subject, commit msg, description - none of
them explain me that. Is this some standard for NAND? Why is this a
common property?

So many questions and zero explanations in the commit msg. Instead you
just wrote what we see in the diff - that's completely redundant.

Best regards,
Krzysztof


