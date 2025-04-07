Return-Path: <linux-kernel+bounces-592803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63231A7F17C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 01:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3390A189A5D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0222A1E9;
	Mon,  7 Apr 2025 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sParGlAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A021C9E0;
	Mon,  7 Apr 2025 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069760; cv=none; b=fwhSuwaKgAynMx+FZPKSfs3qv3hOa8XEuKD2SQ6/7bwwb3ynfrYgrDsa60urIPrqTvnZblt/STGlYr0ODsAEKObZFm2BUdGUL8wf5LBtTggYWVhvfQVV3St2sY5gWExe6+GcuWdGwvum2h3o4/Lbs/z3HII/LQ/A8gcjn0lgcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069760; c=relaxed/simple;
	bh=lhBh96Tt0XBn5MJW07XyKOmhZaJEZITuhyymLnJBTJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO1egsjxgF1325Snq0ndBtrYKvkeGiSrU6evC3Boz4ZQiOfucnBMEn/r2sToeEWdJWsA2MNa2F3EHHD0QcO66p/4NkwpsXb6KO0tP3Sezi1r2ppsIv9L2f8Y3lIaavHcInKyRY0PqeaEm6d2zqlL8SCOkXSD03/TRJ7P7T5p34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sParGlAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E47C4CEDD;
	Mon,  7 Apr 2025 23:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744069760;
	bh=lhBh96Tt0XBn5MJW07XyKOmhZaJEZITuhyymLnJBTJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sParGlAFQzCtCuQnpKwZdM5tSc0mAmGI7xfISckeWvjLvM/A1wTtcKK9r5DpLfym9
	 SsLQH9oIqNIsro+CMAKRAIRtH2jIWljFkIaFSgw9ox6NV3jWmHMJgiavsCytyHDx3J
	 HkmK80dNQzbzm8HyBa78evrqZA5eh/8BSRA3u4gIDL5gOU5STNd/zXsGGGHVI4MEod
	 +7scuDYMctNpW4CjPdYhCR5+Pd9El9uk2NxNkq4cSDKZZ4qM3/WXM8BovWe8J2hVhH
	 /BTCsoabt/3CIRlQqwnwD1m+ROuC3sVfLWZ1pTa2IIgBvqtGfzKd1yyJ/B8fgLeKCK
	 B+J8dhsuyfodQ==
Date: Mon, 7 Apr 2025 18:49:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH RESEND v1 1/1] dt-bindings: interrupt-controller:
 fsl,irqsteer: Add i.MX94 support
Message-ID: <174406975830.179803.11954380681060629156.robh@kernel.org>
References: <20250407151552.2779343-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407151552.2779343-1-Frank.Li@nxp.com>


On Mon, 07 Apr 2025 11:15:52 -0400, Frank Li wrote:
> Add compatible string "fsl,imx94-irqsteer" for the i.MX94 chip, which is
> backward compatible with "fsl,imx-irqsteer".
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> RESEND: collect Conor's ack tag
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


