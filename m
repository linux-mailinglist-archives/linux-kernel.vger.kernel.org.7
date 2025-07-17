Return-Path: <linux-kernel+bounces-735141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B77B08B56
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E840E3A8EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102C2D2387;
	Thu, 17 Jul 2025 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGyRQlIq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC07262E;
	Thu, 17 Jul 2025 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749515; cv=none; b=Mfba6Y+LgJd0oRatda6sUGxs0tf473/ZCQOLfeciWMtKh/NiumCsKUjqpWbPOXuwHw+HUqAgJ2AjjNum3REoHVEhnnOD/AmsZPxN4jskVBsSr98yfYcH24kyNe/PFOTJerLq0d7LWpECfnVek+R62n35MpogOWJUX9UajXd4a24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749515; c=relaxed/simple;
	bh=DT+Earz9rC7xYt/ttAxGNNrU5KKhtK3XYQdn4AthEMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY5Pf2w34slEgz3/gjHM2YGAoRQueHw2QDS7e4sY1By8z90tJi8vCzCy1ZSdfU/1KQaXoL4Xn0gam0xTy20KkOJqn+PUtPAGdjrJHEU4SaZ7aRYZmMOGekJbkjQc9I9j9VQbrFI3vc6PWLCR99Nc3traR4z6koc2eTcx/yCZRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGyRQlIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B627C4CEE3;
	Thu, 17 Jul 2025 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752749513;
	bh=DT+Earz9rC7xYt/ttAxGNNrU5KKhtK3XYQdn4AthEMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGyRQlIqhP3hPfloIGyIj7fQgWt+g8OKazY2UZhq3eiwCL59NnTIvZa64BTvQJD6q
	 4m8o2ayoNYwcZuXpkhHhYG2c8QZDBAqdvusT9F2D1iClvo6g/+GqyiUkPaWT745P1C
	 b+rjSpsLWIUQAvQaPuuSFAR0nRexrhBEkwAD6Kw3/3VMq2BYTkP/4kogBqd5D6y5HG
	 GDgiSuxLkwXqb/b37oiwWk7UJ/OL6WG++5lbWSzpLJ/fr/+1W1If8+0csevdBFFHt5
	 IfHl17k/+RcdfugMi5jxic8sdb+5wAVpffIQWy4MXpv3EQdvWkRH0oTMO6WQ6X+KMG
	 dsaV/O/n0eiOw==
Date: Thu, 17 Jul 2025 12:51:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, jassisinghbrar@gmail.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cix-kernel-upstream@cixtech.com, maz@kernel.org, sudeep.holla@arm.com, kajetan.puchalski@arm.com, 
	eballetb@redhat.com, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v10 9/9] MAINTAINERS: Add CIX SoC maintainer entry
Message-ID: <20250717-subtle-brave-seal-7cef2a@kuoka>
References: <20250717072209.176807-1-peter.chen@cixtech.com>
 <20250717072209.176807-10-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717072209.176807-10-peter.chen@cixtech.com>

On Thu, Jul 17, 2025 at 03:22:09PM +0800, Peter Chen wrote:
> Using this entry as the maintainers information for CIX SoCs.
> 
> Acked-by: Fugang Duan <fugang.duan@cixtech.com>
> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> ---
> Changes for v9:
> - Add mailbox driver information
> 
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


