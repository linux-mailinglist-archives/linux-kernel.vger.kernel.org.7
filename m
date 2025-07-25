Return-Path: <linux-kernel+bounces-746482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D1B1273B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCAC7B607B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CCC25DB0A;
	Fri, 25 Jul 2025 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRMliVL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049741A8F;
	Fri, 25 Jul 2025 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485435; cv=none; b=DqoOGEN5ZaJ2yBfGPBKvRQTYBjl72JfBZkpRZSBceGZDXu1n+EeP3SyWMf3FgTfAA5YoX6FfkkxtFLbeE0zesglS99qlslMMoIe84L95+K/GgjkXEwNfG93hM/h9sIZy4Ua/sSpSG1G8QUEEm7YxWKz58yMM+PHAMVjPvhH96Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485435; c=relaxed/simple;
	bh=jTDlv225l+Z22g80MMs6mUF3nq5JBxkfcKud5Ugpcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9mWtE+isvGCkf5OesyeTYLegY6lthOoq6fUKGY6UISDuH2Rcmv0TnYQp/QVG1I66YBk3OY0ir0IGZ7VXRUshr/AIBNYwsOazg84ietaT575vG4cIyHTvQdc2EdAwOt1QYrc7BPmRwAfiF5o2EwLJXFovEo09v69X1d7BpEBOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRMliVL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD8C4CEE7;
	Fri, 25 Jul 2025 23:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485434;
	bh=jTDlv225l+Z22g80MMs6mUF3nq5JBxkfcKud5Ugpcgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRMliVL4BefxhvgzEQ4Sw5Ftsvef9FifXjW3dHIVchanAgC0TaSUGXs09lAJ/ZxKU
	 MuOZafP+PrZ6hr7PYXX1oTTs6PpMRaWHun425SRAsiQnVXP8TGRD88IR/6PFYffdYC
	 q4GascevS3D5+tDA3wk272EFlZlwOOzu56zCs+C7IcIv7A2f8AtGeTVJv+EKAplaaD
	 sKJ0/R/9qvHGi6PTz29fQALfl6SAE4K0hBe7LymGeaWO/+bB0re/Y670wcREbWI6/0
	 Qib7gnF3wfZpIA3aMFkET9bFD/64swky/MrQ/o4xbHV5LI64lXj+H8Aa2Iw3mzF8fz
	 DJH8ducIx+L1A==
Date: Fri, 25 Jul 2025 18:17:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Cedric Encarnacion <cedricjustine.encarnacion@analog.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Replace bouncing Alexandru Tachici
 emails
Message-ID: <175348543312.2014954.17919664878020331209.robh@kernel.org>
References: <20250724113735.59148-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724113735.59148-2-krzysztof.kozlowski@linaro.org>


On Thu, 24 Jul 2025 13:37:36 +0200, Krzysztof Kozlowski wrote:
> Emails to alexandru.tachici@analog.com bounce permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace him with Cedric Encarnacion from Analog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I don't know who from Analog should maintain these devices, so I chosen
> author from Analog of one of last commits.
> 
> Cedric Encarnacion, could you confirm that you are okay (or not) with this?
> ---
>  Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml | 2 +-
>  Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


