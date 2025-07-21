Return-Path: <linux-kernel+bounces-738835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5823B0BDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF893B997E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE6284694;
	Mon, 21 Jul 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqw0Vu6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B4280014;
	Mon, 21 Jul 2025 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083744; cv=none; b=sPZJy4ohdL9Ej9d9a51cRHF5yhXTX9weHD0Kco6qPRm+AnslhHACFcgqWfoL+ax18GNFYs7ILg+CL4e52HGAIqwI5tjEIFeRICqxFA5FVxJH7jzK+0a+aehGv6HwV1VodwqUKWT5okxTXRITFAVa/Txxlzs/k/hMRujNf7hupcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083744; c=relaxed/simple;
	bh=XYtXJcSx59acBjNpYrTcaOZ+McBebEu8GwQdfjrYlxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKfxmpEO6X0BLxNIzcXGLYeeGPuPpagCuwNA43eY4m73UaKU8kRF+XRXp51/GPVgEUSXAc8Z3bY3zBRdVxb5lXkP/7V2rZYP6pbQXaGYPtvWL5R2GeOe2OqbdlRTw0dqCteZYbNOJcEMprVSx5yFDE88TdDYMIk06unbILwhM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqw0Vu6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E87C4CEED;
	Mon, 21 Jul 2025 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753083744;
	bh=XYtXJcSx59acBjNpYrTcaOZ+McBebEu8GwQdfjrYlxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqw0Vu6cS5IaBiWbim5p6hULKDwdbtHJ26JLb4fSYufdL1D0VYixws+yPTzF8Fhne
	 eg6YXEPS6EnKMjn4OeT0TDyP7oCF7oqeGz9DcklGt5n36uc1mFN/f5NXo6ihTmacFl
	 zJlB5duUWRDI9Uohc6JfFlPqqpsLR2bw0qc8YJULxmJ/3O6IcaqlvsmJKDdhWcD9d9
	 Vhwtzfh9sU6u8oOaTG2rdUZQQdwTMeNIrkx2cbLktSVpHxrQclCbSzkTlWsGrtM1IR
	 DgUUI1dx065lxFQtYNnOIoWejKjCMuTfDhog7oC8XKb+Jyz3nGmcLmLA+pbJ4ZT6Lm
	 WXxj8IOMIXSLg==
Date: Mon, 21 Jul 2025 09:42:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] Documentation: devicetree: Add binding for NVIDIA
 GB200-UT3.0b platform
Message-ID: <20250721-auspicious-uptight-parrot-b1e19f@kuoka>
References: <20250718231118.3330855-1-donalds@nvidia.com>
 <20250718231118.3330855-2-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250718231118.3330855-2-donalds@nvidia.com>

On Fri, Jul 18, 2025 at 04:11:17PM -0700, Donald Shannon wrote:
> This is an Aspeed AST2600 based unit testing platform for GB200.
> UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
> differences, additional gpio expanders, and voltage regulator gating
> some devices.
> 
> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

With above two:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof


