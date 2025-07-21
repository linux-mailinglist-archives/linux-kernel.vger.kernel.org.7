Return-Path: <linux-kernel+bounces-738999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B80B0C072
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3F93BF691
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C55228C2A0;
	Mon, 21 Jul 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFbUl/kx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5C28C014;
	Mon, 21 Jul 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090754; cv=none; b=N1f+YLbUcCAf/QcYW3F4BFWnMu/5JS59cWzy8G4cyp3BdAgcDZOALAS2lvhNPYcND6Sx+6JCpQBR51URsp+nudyQbw+dY/Y7efKEgMMeal1+HWBJmf0lPzp4PoaswTZDKRaAXXQBhb+qYSy6AAAqftf5rxBd0qamSCJjzB9nd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090754; c=relaxed/simple;
	bh=WiX27AOv2yJA6I29GkVHqgcg0Ip92T/WuBgZC4cMNIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIrInHQUYOornqXoR1+s2SSvzO9Xn32lIqpM3G9F9WiHaXAtIY8fD85bAyFY/eKBKVWld5zM7RGBWH/S4tPEjPocrkrewyyEjZm1TSf6L4N0iIfzfCtKRqJ5ja8+8BU2oCwhSinhZB21zAlwc8113ebjRu21nViGb82fEo8ebtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFbUl/kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3524C4CEED;
	Mon, 21 Jul 2025 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753090754;
	bh=WiX27AOv2yJA6I29GkVHqgcg0Ip92T/WuBgZC4cMNIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFbUl/kxNIxSfbroWuxmNrYXHBY6cbd043RehTih0N6YlDU8z3nYFZFxnx5alRma/
	 rdrzMnQwtP7aWh6aD6zYFFWtbx/Da4IivlgGYFPIM4ysKMw4VmSncqcl7S2YuNRLPQ
	 2ZUwVutqJHVVaACubFZ3bD9+MGvRKHcSVhH+3hFEp8ANiPgGVI2lorsyuzGu1qfpJ+
	 DMOpwuMWVNEo8uzFSiyJybSduIIElsHdardzTAkUv38BzfPqxeD9/HxA69nc378rhz
	 YT75eeq+35mW8Fh+uVcpogyuBvBxiuhByWJgfemwexQ7QwBGvtqa8sPzkXckJtylZl
	 Us6PNM5B12+qQ==
Date: Mon, 21 Jul 2025 11:39:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: imx8mq-usb: Drop ref for
 fsl,phy-pcs-tx-deemph-3p5db-attenuation-db
Message-ID: <20250721-imported-quaint-crayfish-d4e44b@kuoka>
References: <20250721065424.4192351-1-peng.fan@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721065424.4192351-1-peng.fan@nxp.com>

On Mon, Jul 21, 2025 at 02:54:24PM +0800, Peng Fan wrote:
> Address the device tree check warning: "phy@4c1f0040 (fsl,imx95-usb-phy):
> fsl,phy-pcs-tx-deemph-3p5db-attenuation-db: 17 is not of type 'array'"
> 
> And dt_binding_check reports:
> properties:fsl,phy-pcs-tx-deemph-3p5db-attenuation-db: '$ref' should not be
> valid under {'const': '$ref'}
> hint: Standard unit suffix properties don't need a type $ref
> 

I already sent it, since I did the change in dtschema...

https://lore.kernel.org/linux-devicetree/20250627-dt-bindings-db-v1-2-d5c7072acbee@linaro.org/

Best regards,
Krzysztof


