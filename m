Return-Path: <linux-kernel+bounces-751659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1426FB16C03
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD51685E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168424DD1E;
	Thu, 31 Jul 2025 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQW6NgNh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0524110F;
	Thu, 31 Jul 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943048; cv=none; b=un8Dfa1s9N+n5NOGfjdIBS9U7g/bIq4Y9O0UgNwls6icfjhdBHi6mtY2OdANXebmtIzOrdSIkh1xRaTl7LEsvRVejvEFO0bIzVotHnqtVkmhT+3JQojsEHrmxBiw5ucrsTkkQPkc6UrJja7L8hTUnjfZ1ykgTdToW+rK7BM0KK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943048; c=relaxed/simple;
	bh=ldKjGy5/MweIQYFpjRdDIpMIYFgA7mqRRvAmNTNR7ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDSpPHy/l82VLHzVSP/O+osM64RY5ksYtRy41PSiK4e0fm15oaRyfCB08W3dUXVyyeJiHs7REw97Oo2ynM5JjZlCyYCKGqPfgyE6xY4cWOXkG1g+n+xrTVZd92zFEUCKu3C8lO4EQ3obY6qqxH1Oh12ZUUUOtveMTWb/72N0UAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQW6NgNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81B0C4CEEF;
	Thu, 31 Jul 2025 06:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753943048;
	bh=ldKjGy5/MweIQYFpjRdDIpMIYFgA7mqRRvAmNTNR7ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQW6NgNh8/KBqdAl+OPdF8WYOy+BR67VHnHWVhgsbrwNoOwqRq0PtkGg4+b3muqNG
	 r4OIeuqk7DrTYufm4m5XuqBQgyJIiSAIh/3dYz7A4df59Csh9JTts+7KGPJimWYCyu
	 vK/gHHF2ypPWO1BlExsgdukI8XWuImhfAS4QHLaeUbiVe3myP05aAORCikQK/Iy1oH
	 Br8TiWJezaY5EFvW2vRNE9Or0OjujM/g5r2w2tOjN9ptAreIALpaAOuGXiP3X8GFkC
	 wo04p9TB2hOI0AZNywe/dEu2xMiKn0MXnhe0je2fVEbnvFROcA+xiAQr9pOrInCI/L
	 v2dnAFN9E0Mcg==
Date: Thu, 31 Jul 2025 08:24:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: jeff_chang@richtek.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] regulator: dt-bindings: Add Richtek RT5133 Support
Message-ID: <20250731-visionary-interesting-marmot-3fbb7e@kuoka>
References: <20250731031701.2832994-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250731031701.2832994-1-jeff_chang@richtek.com>

On Thu, Jul 31, 2025 at 11:15:31AM +0800, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
> 
> Add bindings for Richtek RT5133 IC Controlled PMIC
> 
> Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


