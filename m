Return-Path: <linux-kernel+bounces-751664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED295B16C10
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111D9189247D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EEF25A2AA;
	Thu, 31 Jul 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhlDBpgd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64224DD1E;
	Thu, 31 Jul 2025 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943360; cv=none; b=f7sY0M8hqo+Is4IpDX29dPTcba6d7KdSRNQ1VrwMMG7pG/fg1lwebbrDI9pkn12+BvuxYuCEaP1pTnrYChgJw/wwjtmOFHhuxHBAfXqQDiZe5NTc9V8aklwtY+RegU9LihuiAB+m0rlLTqTOR3bhD20EggvGARXrF+qOuCuQ99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943360; c=relaxed/simple;
	bh=SUKQ3tdhFRg3l3nEEpjuotLBa7D/88G9SQjQiNRhh5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkN+u/aQNSjDyH0Tcjd9UP6y0pLBuw94pKWhbCYzU9ZsQuoYAImtQGk2y6HECU8niMy3IZYATLLKEJqKmw0QaKc8dHBMTvhOgC6oMHO96Mw7syvE/stCauQdNeUOCh/c1asHmZjHr3UX9vw1VCL6Z+mvSk5HiaMvaF294oHVxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhlDBpgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2382C4CEEF;
	Thu, 31 Jul 2025 06:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753943357;
	bh=SUKQ3tdhFRg3l3nEEpjuotLBa7D/88G9SQjQiNRhh5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhlDBpgdpEiOHEsEbguanlvXXIeEfhOYmq2dsND2dRMNWgVa2vvZDQspCSo0DRSvH
	 PjOqaIXynbmg5N/fVOEmA1Ovjs/op5MYvzCWdJNSthWAd+lk+RSSJAGfXCGFliuTdJ
	 6T78Ls2VPezQaPEznVxvroIkNWQerWQHASlBmGbPyVMVfffbBdh+wWC4sAqcHF6l3e
	 pQB5WCGUoh7qDaGLn6x75itcrcv6dr7Z9j/LLG5Q/Jz3OlHy+ePCSsYwIdFFR1+90e
	 2RjdYQnf+92dUfozgIPm98e9uCiQHmzhCR0/3ntw2oswYrlLbW7ZZEKYsreL2XL1/9
	 pPZnYVOTm3uSA==
Date: Thu, 31 Jul 2025 08:29:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: cy_huang@richtek.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Richtek RT9756
 smart cap divider charger
Message-ID: <20250731-placid-proficient-waxbill-0d58ff@kuoka>
References: <cover.1753940508.git.cy_huang@richtek.com>
 <6e986ea01a3dd104f700f5cc49578a9403c9676b.1753940508.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e986ea01a3dd104f700f5cc49578a9403c9676b.1753940508.git.cy_huang@richtek.com>

On Thu, Jul 31, 2025 at 01:48:16PM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add the document for Richtek RT9756 smart cap divider charger.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> V2
> - Add reference to 'power-supply.yaml'
> - Remove 'wakeup-source' from required property list
> - Use 'unevaluatedProperties' to replace 'additionalProperties'
> ---
>  .../bindings/power/supply/richtek,rt9756.yaml | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9756.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


