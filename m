Return-Path: <linux-kernel+bounces-816105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE9B56F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A62189A3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC70271473;
	Mon, 15 Sep 2025 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bPIeS0xz"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324891F2361;
	Mon, 15 Sep 2025 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757911910; cv=none; b=JLbzmQzBwJkipAf9ysZ/FBY60C9LP+FEZ+JmapLi9vq6QBI/UdRnKn67Sm4SeGiO5cyP3PF01zeNglTiwaqDacpR8L3D8K2fnX0J9OhCCVTeUfb3s+vH9PpKWKY9+j7EZ381Hp9fpgplmvjkvTHsseCHEZ08P4FGh7jEKBzvH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757911910; c=relaxed/simple;
	bh=BVMHhWMWW+z0ftn6nPGu/42b6y9+COcMk+xOQhhhwi8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C6qSBeltqWMf0eSi6VaT7jLhK1ymhVZjM5Lc/l2jyn8geLIa/86wb0zY37R/rzvbKLK+aQYqBdT/1lROyKnk7Nv6E+ZdVEfqfwrKFxEKXeRzWYS/Hd/9Tq6iEFIqlGBoAUgSV2xfcs4QPL5KDP7KQYXCun39RF3FBDz4vj6VBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bPIeS0xz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757911906;
	bh=BVMHhWMWW+z0ftn6nPGu/42b6y9+COcMk+xOQhhhwi8=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=bPIeS0xzB0UGuxDe0qaUYJe5B5ngK9Udw24LmmQDg3olfuibtVqhZDjmR9qPA1uf5
	 6e/O9R4ScNXSvFcagUEcZe+d7VQdQzTqPt9tV57OY6qmcojbUL7dyzzWqsYs9X6nEb
	 zFJA74uy8JM1C6BI3Db36OuzJhwQGSXsT1c9pu/VatP36fASJG7DVKcTYKTktn0xvW
	 vaSv+YmdXDAxdaHgfOWkRLRLD6b3PVLImsj4dOB+x53AMp73yDie/sla6ENAmChbQl
	 e4h7RfL6ZqZsOlwxxoQsSJmW2NtlUhxr7UCJa/pMYIbhEFfIB82iZiquTdQ8ffuc8O
	 5a3yTSkIEy7rw==
Received: from [IPv6:2405:6e00:2430:fb15:b2b4:1872:3690:c682] (unknown [120.20.190.44])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 398DE64CF0;
	Mon, 15 Sep 2025 12:51:42 +0800 (AWST)
Message-ID: <67f2276e99640bcbded80560e8b8d2922b731e81.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rebecca Cran <rebecca@bsdio.com>, Krzysztof Kozlowski <krzk@kernel.org>,
  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 15 Sep 2025 14:21:42 +0930
In-Reply-To: <04b0799e-b0a3-4dbc-98f3-239869c79305@bsdio.com>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
	 <20250911051009.4044609-3-rebecca@bsdio.com>
	 <1e4c65c6-4745-45e2-9e20-9d2e69ae2ea4@kernel.org>
	 <04b0799e-b0a3-4dbc-98f3-239869c79305@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rebecca,

On Fri, 2025-09-12 at 17:37 -0600, Rebecca Cran wrote:
> On 9/11/25 00:29, Krzysztof Kozlowski wrote:
> > Never tested.
> >=20
> > It does not look like you tested the DTS against bindings. Please run
> > `make dtbs_check W=3D1` (see
> > Documentation/devicetree/bindings/writing-schema.rst or
> > https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-s=
ources-with-the-devicetree-schema/
> > for instructions).
>=20
>=20
> Am I doing something wrong, or are a certain number of validation issues=
=20
> expected?

I expect you're not doing anything wrong there. There are a number of
historical warnings from the ASPEED DTSIs. However, generally, the
policy is as documented here:

https://docs.kernel.org/process/maintainer-soc.html#validating-devicetree-f=
ile

>=20
> For example, I'm seeing these - most of which are from aspeed-g5.dtsi,=
=20
> not my dts file:
>=20

*snip*

I'm okay with taking new ast2[456]00 devicetrees that don't introduce
any new warnings of their own. However, given you're contributing a new
devicetree, it would be super helpful if you could look at removing one
or two of the warnings from the DTSI while you're at it, as this
improves the utility of the checking tools for everyone.

Cheers,

Andrew

