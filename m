Return-Path: <linux-kernel+bounces-863012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF45BF6CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18505417B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69F0337BB1;
	Tue, 21 Oct 2025 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8hSe5eE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C5335BCC;
	Tue, 21 Oct 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053466; cv=none; b=s0CrwKaxdA5Nx35AC4bihnpNmxmLeSUFqwOUlW/NsW6hzRtdY+ukWbfOpbvb4iJeWhblOSUNXO06qkkYBoP7XF7vZ7GEAfia9KROxltJpSu6iMKmAqSep65Q69V2JLUWDAKd2J/uYICF9y7FJM1RgBL9SLGN1MMP/06PGRJGQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053466; c=relaxed/simple;
	bh=EVEIgzylw5RGVggezBSR1+kz2XbEuZuqnwmtpd0lQes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huktZOyErHbz++xmR1yg6uVErl3gQI9Z0EJws3MdY9k601xuOVmE/JC05HKT4BP5gzJ2ZKAqgeifYO2jZxXKBr1n1KaqOZsbDqICPAtIOZyBoqWatGq34wYKlAKOT8uXbs7d5ieH6oDnWjQSuF2GU8O6qSoo4Rp3VB0411zj/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8hSe5eE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99BEC4CEF1;
	Tue, 21 Oct 2025 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053465;
	bh=EVEIgzylw5RGVggezBSR1+kz2XbEuZuqnwmtpd0lQes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8hSe5eEssCv4zfaeiI0S1y+lqdicSy1tgJB2MH4XmG2YkjydKzH4o9I6oB/1qp7F
	 e4C7U1PH26rFad9hEVzQFsE9qmDYu3MkJRl6W0zbq4zU2kDRkAiQNaZNPaLFKemEwG
	 lgF6G0JLUkslxtM7pg4nCpaFN6F8FT1lFxOom67CwJpbXmxgmPri5b5i7Fz8aCPmXU
	 mecM5tVLLRJ4jtRaGKBIuhw7WjW3NA1zw/HgifG2vj08cUdEgoPpvCLBy14z7+ZL3x
	 NY8xuncsH2cbAcQSVAJ/ywxFzpmJMKziKyBS9D5jssgrCSXSt18gkwHomZMJwhrHYk
	 rzlqozVSD5xRA==
Date: Tue, 21 Oct 2025 08:31:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Steve Twiss <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH 1/1] dt-bindings: mfd: dlg,da9063: allow wakeup-source
 property
Message-ID: <176105346341.18749.2102779375239624179.robh@kernel.org>
References: <20251014184114.2353199-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014184114.2353199-1-Frank.Li@nxp.com>


On Tue, 14 Oct 2025 14:41:14 -0400, Frank Li wrote:
> Allow wakeup-source property to below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: pmic@58 (dlg,da9063): onkey: 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


