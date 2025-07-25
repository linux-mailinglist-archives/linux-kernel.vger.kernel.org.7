Return-Path: <linux-kernel+bounces-745380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 136B4B11924
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C401CE1BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E02BD591;
	Fri, 25 Jul 2025 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2X567FR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92779BE65;
	Fri, 25 Jul 2025 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753428334; cv=none; b=HbdB7/higftGAOAI1H0N+PSB5L0h28u3g17fbXLTv57Dfw98SYljorpTylTmxBVi6qPep0qpxqlHiQCQnzM6I2sEHqI4tM7tM3+RiVn8dPHQqtECZKpvAaLMrz17aPjaHFBKypKBBy2rgPsOH2LdqSf8REHGgAhbLXB2hs91R1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753428334; c=relaxed/simple;
	bh=IL4k9lr5ymW8k6HPReFxSXkSHaWWIeN0cVaRGWIrO5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfwcRsMQAHcdQSzRWKMKkKjNbkkMFtEGvDXETKeIdLZ4KDzJr2Wx96ygCoO6/c+UnvpbNGYSOtV9Iv21nJnzR3j/AF/rJWueKCU+qYOEMRcDc2k5/KPQTk4TAIE94TI2H//WphQxyBflCfhtvFhAjHuUT573VHhdeFcW2omN5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2X567FR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F6C4CEE7;
	Fri, 25 Jul 2025 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753428334;
	bh=IL4k9lr5ymW8k6HPReFxSXkSHaWWIeN0cVaRGWIrO5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2X567FRYew7yuyLM5tpJUYu6A/LkeoSQoMcXNE2a+TzV8HzG2ytg4bZ8GbeJX32t
	 JKsfYdfAHOEMGQj14P4sv0DePfT2w6QCo6Kh33Y8TGPhFmMZmVDl1aYpNqtG5P/iku
	 uIYDZ8m83y2d0MjNET5ySyjCSysQ1uEmYRzqRjfpYjJP8RX+2k3mLuwvBI2zswDIyL
	 wFJOowj+jBUIw8xtv1Yr6hwcKPpEL7zbKlWCafgADWfo77fIvGSQm4o5nc/WTABOGH
	 LtvnZUx+4j1kRpbmoR2+jGOPXKOwjGNiNN1eqozMKEe+BLm4FjGMtQWHD3hz2hcI6T
	 vLhcjEn+DCDBA==
Date: Fri, 25 Jul 2025 09:25:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erik Beck <xunil@tahomasoft.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: rockchip: add
 LinkStar-H68k-1432v1
Message-ID: <20250725-nocturnal-messy-cicada-dbcc10@kuoka>
References: <20250724-linkstar-h68k-patchv3-v3-0-b9f87b7306e5@tahomasoft.com>
 <20250724-linkstar-h68k-patchv3-v3-1-b9f87b7306e5@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724-linkstar-h68k-patchv3-v3-1-b9f87b7306e5@tahomasoft.com>

On Thu, Jul 24, 2025 at 05:37:58PM -0400, Erik Beck wrote:
> This patch adds a section for the LinkStar-H68K-1432v1 board to
> dt-bindings.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Instead say for what hardware you are adding bindings.

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


