Return-Path: <linux-kernel+bounces-722252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7C3AFD6F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264973AC754
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D52BE020;
	Tue,  8 Jul 2025 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTB+2IAv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFD192B96;
	Tue,  8 Jul 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002107; cv=none; b=hVMpt8W9LiRuU8vnc/lgJXM6qkTv+D5CnHvcK1PO/JsAKHj6DeWgGGdtaDVNeXbj4s6fn+29EdtPp0gSDhpLMa8wYLw6WaLVJLbA0ffSsaI0uH0sGg6ONHdSX762xftXz6fRXtHlS71ndJAWr2ICEcZeQAtoaNBx6AXkthOmPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002107; c=relaxed/simple;
	bh=cJo0ClR08IfKauOZNR3xdx0vHFfRrWGD2IodR7U7RMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJFUdRf9Ic1J+xU6XGR9mkgFc3jQV8RKoxP61XgMJhonle7vQYnzYtjgyouH6yBmvyaRetPeBgMupORgIbCCJ5SlqWCksIcd19PR5QaLD0qG76zJYjz55dC+/lKphblBx18AhplVc/G2JR2inPo4MsakaS3mIjT3+UtR22LdV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTB+2IAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14527C4CEED;
	Tue,  8 Jul 2025 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752002107;
	bh=cJo0ClR08IfKauOZNR3xdx0vHFfRrWGD2IodR7U7RMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTB+2IAv3gqSnscZTUZCTG4YUK0nM5b9TuJw8yhEAgEc7X7TdSEebsVldsyfc8E3O
	 3mZR+MU5PII+bDJqoBQGu6zRrKc7ZCRO3qPCSojqEMynaTVB1tlyEWElOBhYhsjAKL
	 0aNzzMQVH1cI/ojOfOoKOTJhW1gvcMQHmbCdStu0YYJvKzB/IMkScpLqW+01A8Py4y
	 gS++MqXtSLDWcw4flCIHrkFjujPPAguDNmoExkgNxfKWDCiJ/Bob48xHiK6agAV3It
	 juyB3jkUfoSM9dvbLcj2F5kj0OYuEcXujH8aLVftdiF8MS/poefmUNRaN4N/NFirAP
	 b5Oh5sFvH0Peg==
Date: Tue, 8 Jul 2025 14:15:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: imx: Add SCU controlled display
 pixel link nodes
Message-ID: <175200210525.766987.8733375148465639696.robh@kernel.org>
References: <20250707-imx-scu-dc-pixel-link-v1-1-25b85d636c2a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-imx-scu-dc-pixel-link-v1-1-25b85d636c2a@nxp.com>


On Mon, 07 Jul 2025 10:26:00 +0800, Liu Ying wrote:
> Document SCU controlled i.MX8qm/qxp display pixel link child nodes.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,scu.yaml        | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


