Return-Path: <linux-kernel+bounces-773112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B123B29B92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6ED7AF2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C9287274;
	Mon, 18 Aug 2025 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DamOTWIh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35F2264B3;
	Mon, 18 Aug 2025 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504226; cv=none; b=jBJ3C4uSU/oBBMorPVfBuG1OAaoGwOIAER5UMWW4/Qe25iJd1XxgojHFrm/c9voi0lImCseIhTFrqxGvPO+NiUe0WVcv+I30CRj3UhC6UqBqZzB1bvyXcFnDIGNF5KtEYk+Mfyzt8n3fnqg8ECCSaDKmltIUtl20XACJ0Uf4cys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504226; c=relaxed/simple;
	bh=s8akamFWkaYLHQvvIkfhnZf5s912DgZeRF9icXGK82A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmHxbr39jBAP3XWAwbBHPoD/o2dVs9ZuO5bu5J3S4ICkg3XvPipA+y68jOTz28p+WUAxWq6lxH5znpZaOqbeDmt1AluBAzR3KhZtuBvqE311cazQaRrEjkyUNQ4PBUCoKGa/TGj3m9+p5QY+HH67oCWyiYzTCF740xyWSdBLsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DamOTWIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F85FC4CEEB;
	Mon, 18 Aug 2025 08:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755504225;
	bh=s8akamFWkaYLHQvvIkfhnZf5s912DgZeRF9icXGK82A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DamOTWIhpaCdewSeQJLxkxwc45sSIMmCfq5i6kBHI99ROqvMtVbTi1yMG7bo9Y1CC
	 6seu2/hu4uKhm/2tpd0cj/pdWOtFmgXKkZOCiUi5dHsShvb04aYxo4qvQq9CDK+K1p
	 JlLDA/k8y0e5AM8SK1mHCygt/uDXZ1hPtQOW9xUXR3kC1vnevLk8oLNLhNmIZx++Rp
	 rDFi2xALvXpQa2j9IFfAHrvP9i/5yGwkn9nmvwCY/l12HJySudINMu6uQmb5wgop5R
	 l4ZTt9sP/Ndzu/DLou98uJr6+MxyT9/6LCau35wd+e/opYj80IowQJtaPh9iDhXzz1
	 JpO2zZRSMKAWg==
Date: Mon, 18 Aug 2025 10:03:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ciprian Costea <dan.carpenter@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ciprian Costea <ciprianmarian.costea@nxp.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linaro-s32@linaro.org, NXP S32 Linux Team <s32@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
Message-ID: <20250818-merry-tentacled-saluki-3c7b6e@kuoka>
References: <cover.1755341000.git.dan.carpenter@linaro.org>
 <7d0e025ed3fdc9e545f1d0b84f6a1cbb9dfb4e91.1755341000.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d0e025ed3fdc9e545f1d0b84f6a1cbb9dfb4e91.1755341000.git.dan.carpenter@linaro.org>

On Sat, Aug 16, 2025 at 01:47:03PM +0300, Ciprian Costea wrote:
> Add bindings to expose the On Chip One-Time Programmable Controller
> (OCOTP) for the NXP s32g chipset.  There are three versions of this
> chip but they're compatible so we can fall back to the nxp,s32g2-ocotp
> compatible.
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Also, completely messed From field. I wonder how did you create it...

If you wanted to take ownership, then it is:

git commit --amend --reset-author --signoff


Best regards,
Krzysztof


