Return-Path: <linux-kernel+bounces-730762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBFB0497B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656524E14C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489B26A0B3;
	Mon, 14 Jul 2025 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMPWmWTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E54226A08D;
	Mon, 14 Jul 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528181; cv=none; b=UntJ9YCUHEFQzut1RcUMrZ4ovaI1zHnxGaYxAb9vsBru9bHtCbObxhRZn6NbzQgwDGfXxfCFcdPPMQJHQfnCAn9Zur9cApQuYmPmqKHzhWt+BbQmH16itYcuqJWIudMEVtCKRYH7lM5mST7fo6/94mtNEUlqAKmPQE/6QteF1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528181; c=relaxed/simple;
	bh=mgiZ7qs7iYC1Wb8wOszlKtmDOCHXn9LckypJocRtVaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dndF2Lo58Cbn71tx8uZJYfs+r9h4bDUt1HdKFGWwPJv5J95QThIiiHt2QcKkb0VSOhZ4HmtdbPkjawn2yR8glHn/HxKR/H4UhPl4qmfS658DL4rhgaiaOsZ8VFrnTl43eGeFew4P/buYl1J9wv2Bd4QSOB/KI+G9PtMTaCH8Pk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMPWmWTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58179C4CEF9;
	Mon, 14 Jul 2025 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752528181;
	bh=mgiZ7qs7iYC1Wb8wOszlKtmDOCHXn9LckypJocRtVaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMPWmWTUP4EEAytHwyAetN4ilbRHN3waECG++nAqSsnfYlOMl7RmrwtevzEciFvBp
	 s/Eglu4beSNIhst5XGLy8AqLvvToHMVJYvApexjypzQZcaw+zh7DVyKg5dI0weoRyH
	 PweLj3j2NiLMs7HrzhbxVQ6a9nr2XV0b2wuDrYExqsFNON6J26Z9Iusrjs+Iir2Ka1
	 rSifzp91QfvBckr2mSEmlm7v17fPEaHtD4ecUTyukYaP1tgZ9lDFQdY+xOE/wva7Xe
	 mk/J+7BjLI6Ajovf+sQxNxKsN1UTOA1Npkx6GY8iih2Bd6X1joK63wcpKxvXjI7wxm
	 fGkwuxSGcBb9w==
Date: Mon, 14 Jul 2025 16:23:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] docs: dt: writing-schema: Document preferred
 order of properties
Message-ID: <175252818014.3191414.16275568250551384847.robh@kernel.org>
References: <20250713-dt-bindings-docs-v2-0-672c898054ae@linaro.org>
 <20250713-dt-bindings-docs-v2-4-672c898054ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-dt-bindings-docs-v2-4-672c898054ae@linaro.org>


On Sun, 13 Jul 2025 14:46:39 +0200, Krzysztof Kozlowski wrote:
> Document established Devicetree bindings maintainers review practice:
> using DTS coding style property order in both 'properties' and
> 'required' secions.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!


