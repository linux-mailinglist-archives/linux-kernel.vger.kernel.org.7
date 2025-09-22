Return-Path: <linux-kernel+bounces-826600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C83B8EE44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8F87AB2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318512ECE86;
	Mon, 22 Sep 2025 03:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="f3KyClUV"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB93C01;
	Mon, 22 Sep 2025 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758513380; cv=none; b=roM5U6uemcZtOMZjoOt17NXBS20RK0N4RP2nSVL1UiEMt8QMZ96xLeqrHWkBi56htwwCQS71LjlwjhdB9g39HYfpjfzxAuEIK0myiDLM2E6wkk6UvDTzqY+cFy4DTHPC7M1Z8eeMxnd+3eKJpV9qVMzhMhcZcezh30BIXKbPGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758513380; c=relaxed/simple;
	bh=/8Ox722Ja33t+pSAH0BdoPpXXOK9JIvS0e1iSxPH+2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lNY7x32L2ySiOOPmFNGoIz+G5aDdy9tYUc89O1Olp5D1/NYTv78et9K76u5sn+bjBcD9ukUyO6gHEoaUaAuPyVmBfNwNegIWcFu4l35hQXaVmIUUMPTMVKxYk04uPoKyWBrmIfPD5jB9zp07WId/D/KdEKgTB+hAaAT6V71KwDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=f3KyClUV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758513377;
	bh=/8Ox722Ja33t+pSAH0BdoPpXXOK9JIvS0e1iSxPH+2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f3KyClUVemVid8xs++Nhat2YRNO7D5f4kt1hwz8Rc6Ms1bXQogfg9TTw8ze+AvW56
	 kqurv4wI877YS8ci56AR5EK1Iv5W+tlyd+UOgd/GwQzHeEPMrsfkWgCzFaZ28Skg4D
	 66gFra4qV3kNFgQ1ySPiL5rUrpiBEcbjEChPGf6gVmoIIy6DrrwmO/GHoCzA2iVyMM
	 GhCl3ulhiPmAF9NcJtQg7CKvoVkuhdDCiw+rqyII3hXMh4hY9Xy2J5uTzlB0zu3CMK
	 uGDJHclryKpGdsZPrAQf339YRdF4dDwkzwN4O0JEwg9ZIKkwU3iZJJAwlXNNBJ3t4u
	 qyRE7HDROx09w==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A13DD64731;
	Mon, 22 Sep 2025 11:56:16 +0800 (AWST)
Message-ID: <0fc79e55e5fc0f8a43586ac3f90599b8f2a6c817.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Stefan Schaeckeler	
 <sschaeck@cisco.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 13:26:15 +0930
In-Reply-To: <20250919195326.2079446-1-robh@kernel.org>
References: <20250919195326.2079446-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 14:53 -0500, Rob Herring (Arm) wrote:
> Convert the ASpeed SDRAM EDAC binding to DT schema. It's a
> straight-forward conversion.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks Rob.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

