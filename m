Return-Path: <linux-kernel+bounces-819790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6396B7D811
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B092A3B78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78351D5ACE;
	Wed, 17 Sep 2025 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XFiZ6dWq"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D222AD3D;
	Wed, 17 Sep 2025 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069425; cv=none; b=XmO7jv75zYBjmC0TlJhU3gK107REjKCvPz+msV5QKsg7T799t/1v1NyYXapLwyeo45cRPSKJxDVRTtAQJ42Q0IR1ONyEMujcmn55OGeDXaRAqBfAoB+svaoaQ6ZFuW6/m2u1P1YUWzK2fflBS4zDhtYZGxHhQ9Sm6jL1hQH5uzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069425; c=relaxed/simple;
	bh=y9HtUDLzWQ/46Yo0XzxIJpiCJTzZge1vdLuhcHd89C0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gU3Pte5UEZiBRuWX4HQSvI+mIDr1V4qdnZuNIm8FSpIlp6O5CSLIAK7o/+g7x/nXRCu4NdvmZ6r3hw6KxK1JhlzGz2vOftO8sXGqCDyl0iN4MO+4IpsPsquMO+sc6HI589pixHTXjWHA7o+NCnzfjhjkKal8WB5y/fL3JM1k91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XFiZ6dWq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758069414;
	bh=2aQQfGbAOvDVkwEgS59kc/rR3ZeQC8NQMOe0HdHu520=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XFiZ6dWqlEq5JjXJDc3jTkzqlLjsXOYeOEaYvqx3w+QWmoF02AibYhO/0qogfCNoA
	 6Cw8Hgj15YSEAeqDI+FNe1jTCivXry3hZqLkFLRKe67f794gwcj+kqahWzefuFRmXZ
	 VbzTWtHHL1k9NEf4dA0n4guxa6IZ6qQlojXlRKLUioC+GWSKANFEZ0gkGKnjxiRmql
	 7II0uBU+85pghCodofZ0T0srNeTCav74b6daG1tWJNFl8I30RCnLa2mc5CXgsOl29a
	 qH3Jwa3gqfmPQDK2kR5PQ/eS1AQdbeWTM4i2PEVwNtTImtr1qoEhQilX7o4+BAeCjX
	 23gXItncK/V9Q==
Received: from [127.0.1.1] (unknown [120.20.76.56])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 09EDF6F070;
	Wed, 17 Sep 2025 08:36:50 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Leo Wang <leo.jt.wang@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com
In-Reply-To: <20250915-leo-dts-add-shunt-resistor-v1-1-d65389148a3d@gmail.com>
References: <20250915-leo-dts-add-shunt-resistor-v1-1-d65389148a3d@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: clemente: add
 shunt-resistor-micro-ohms for LM5066i
Message-Id: <175806941070.498785.13666236370278646492.b4-ty@codeconstruct.com.au>
Date: Wed, 17 Sep 2025 10:06:50 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 15 Sep 2025 17:47:23 +0800, Leo Wang wrote:
> Add the 'shunt-resistor-micro-ohms' property to the LM5066i power
> monitors on I2C1 for the Meta Clemente BMC board. This accurately
> describes the hardware and is required for proper power monitoring.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


