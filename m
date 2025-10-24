Return-Path: <linux-kernel+bounces-869600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344DDC08477
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73D23A7093
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74DE30DD13;
	Fri, 24 Oct 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMc8uwQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAE303A38;
	Fri, 24 Oct 2025 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347517; cv=none; b=iqaOrbgmgYGYQ8L0QpVzqv9WvkoEOIPTy/kvs3jOm5lL9aacq4cANUzBjESHTAuOn7HnkQSgEnqo9Cb85a2EHVofHbu2CA/5KA87jl1KJXPC5ksUIM2eZaEY09Xr96Ws7r3/sfYBHn/RqsNwwZTgPPNc6ayhqxeRuAYDDR3/bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347517; c=relaxed/simple;
	bh=F1LhiwGp0x3wM8SAKbj7UnEIjjud2a8/8+rDH/aYbsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO2DdkVCUrQuIAyOv2Vu72XvKZyy0vuc9hqzEbxWiBBnZDukWHEoV9vQx4vsXRCUSuAACC+vgiU44LRnllXP3LpcT4J7X9zlBVp/PxaHu2VzEKpPYAGwDmq4ma82JSctdh4keFexsWYNkcfOwlBXRVFGBxNnYYMgElqOa8zHGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMc8uwQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E58C4CEF1;
	Fri, 24 Oct 2025 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761347516;
	bh=F1LhiwGp0x3wM8SAKbj7UnEIjjud2a8/8+rDH/aYbsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMc8uwQa2ZrwjDbFF6Ktnl5l6b3YVFOifLfJacDlgvv45EyGN3Y6vPdMmdK2BrXsK
	 TiBckurBINKotx8ovqoOOPI0fnqJVuVhO8YOdPW8TSaySjdDMzuWxcuc7wNk/kVPsA
	 5N/yiuZvGf9TKL4dFHeNX0PtjsF+lZKSi+uU0JkK5LwpUGassFriVhIqO8Sp42MLdR
	 X03nJP9dqgLarDzc4Mh3tXRP3Eb7pU2YqiYW+ig73LkP9XGIhABgXfL9+6rWojAguE
	 OwAL6gnIeuecSfwRAT3vMeZjGTVJE5/x/RjVcBdJNTSV2vOjIDb8Xk7ILwlgo/qJdu
	 mbg0SpRIpe76w==
Date: Fri, 24 Oct 2025 18:11:54 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	Kevin Chen <kevin_chen@aspeedtech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller:
 aspeed,ast2700: Add support for INTC hierarchy
Message-ID: <20251024231154.GA2962687-robh@kernel.org>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
 <20251022135101.GA3349934-robh@kernel.org>
 <TY2PPF5CB9A1BE674594566C13B8D8B2984F2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE674594566C13B8D8B2984F2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Thu, Oct 23, 2025 at 06:57:01AM +0000, Ryan Chen wrote:
> Hello Rob.
> 	Thank you for your detailed review and comments.
> 
> > Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: aspeed,ast2700:
> > Add support for INTC hierarchy
> > 
> > On Wed, Oct 22, 2025 at 02:55:05PM +0800, Ryan Chen wrote:
> > > AST2700 contains two-level interrupt controllers (INTC0 and INTC1),
> > > each with its own register space and handling different sets of
> > > peripherals.
> > 
> > This is a mess!
> > 
> > How does this relate to the existing "aspeed,ast2700-intc-ic"? Its schema has a
> > block diagram of connections which I can understand. This does not.
> > 
> > The use of child nodes here is questionable. A variable number of interrupt
> > banks is not a reason to have child nodes. I'm only guessing that's what's
> > happening here because you haven't explained it.
> 
> Let me clarify the hardware structure and the purpose of these bindings.
> 
> The AST2700 SoC includes two top-level interrupt controller modules,
> INTC0 and INTC1. (aspeed,ast2700-intc0, aspeed,ast2700-intc1)
> Each of them provides routing selection and register protection
> features.
> Within each INTCx block, there are multiple sub-blocks called
> intc-ic, each handling multi-interrupt sources.
> ("aspeed,ast2700-intc0-ic", "aspeed,ast2700-intc1-ic")
> 
> Cascading occurs between the child banks:
> Level 1 : intc0-ic have multi-interrupts connect to GIC (root)
> Level 2 : multi Intc1-ic# connect to intc0-ic
> The parent intc0/1 nodes expose register regions for routing and
> protection control, serving as containers for their intc-ic children.

Being a 2nd vs. 3rd level interrupt controller is not a reason for 
different compatibles. The programming model is obviously the same for 
both as you essentially have 0 driver changes. Having N banks of 32 
interrupts vs. 1 bank of 32 interrupts is not a reason to have multiple 
intcN-ic nodes. That is a very common difference between instances of 
the same interrupt controller such as the GIC.

What you need to do is simply extend your driver to support N banks of 
32 interrupts. That's what almost every other irqchip driver with more 
than 32 interrupts does. If you are lucky, then the offset to each 
bank's registers is just hwirq/32 * <bank stride> and the number of 
banks can be calculated from the length of 'reg'. If you are not 
lucky, then you could put 1 'reg' entry for each bank.

AFAICT, the existing binding in aspeed,ast2700-intc.yaml should work for 
you.

> 
> The following simplified diagram shows the hierarchy:
> 
> 
>                                  +----------+       +----------+
>                                  |  intc0   |       |  intc1   |
> - - - - - - - - - - - - - - - - -+---- -----+- -  - +------ - -+
>   +-----------------------+      |          |       |          |
>   | +-------+ +---------+ |      |          |       |          |
>   | |       | |         | |      |          |       |          |
>   | |  PSP  +-+ GIC     | |      |          |       |          |
>   | |       | |         | |      |          |       |          |
>   | +-------+ |         | |      |          |       |          |
>   |           |         | |      +----------+       |          |
>   |           | 192~201 <-|------+          <-------+ intc1-ic |
>   |           +---------+ |      |          |       |          |
>   +-----------------------+      | intc0-ic <-------+ intc1-ic |
>                                  |          |       |          |
>                                  | 			<-------+ intc1-ic |
>                                  +----------+		  .....

You already match on intc0 and handle 32 interrupts. Now you are adding 
intc0-ic to match on and handling the same 32 interrupts?

Rob

