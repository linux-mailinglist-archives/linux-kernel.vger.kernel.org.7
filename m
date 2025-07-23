Return-Path: <linux-kernel+bounces-741847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13598B0E9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0844D1C86C78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A11219A9B;
	Wed, 23 Jul 2025 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfm/xn3h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B779210F4A;
	Wed, 23 Jul 2025 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245689; cv=none; b=Waz8+PfsZSUn6mGsODo5dyakylCIB1nmDDtCv0nEb79mXXB3/3erj/5AYAHsvAlASEKvgV8H8QRmP+norhbsMlNcXVHiYnAlbeBVaksQ7MfxGxshJp8q6yea7v2ce6TR8u9gOYs/Z4wy66Ldt6lZgDkbzozhJeav1BEen6NvQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245689; c=relaxed/simple;
	bh=wwIY2xZCBjZZJz2L/BRVUGlcwY9EU7yshxeruIN26XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI96DVoq10dyA9eoWw1FuFsna0fBcnMa7QiOT7qu7YqxCzeRJrtHa2zXjqMflCNXuiuYxBm2XfCCYh4vUTCOVUs/8rxY6u2FAXMVxRm8nPNxyhdfHjbUwxAmEU3STQMfcRtce/huu02rpbnEu1P+uaTsp2KUkeNCNtKUx2QD1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfm/xn3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B89C4CEE7;
	Wed, 23 Jul 2025 04:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245689;
	bh=wwIY2xZCBjZZJz2L/BRVUGlcwY9EU7yshxeruIN26XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tfm/xn3hdAnkKPGn1yixfoAD3w2ta11qQNWO1UQMR9fQxllwA9CizXX4AyPUpNLvB
	 CqYGcUdfZvt19Xrm60Y3PIIFlIwzJxVF9r9QP3lyyjtReoFcu34oVe1wUb1wklpHI7
	 cRz98aBanVXpNA5PSR4H6RMSJ+SUWmBrOP7G6wOXr/qlEyYy6JbvCL7qiDhpTwjIL3
	 /1cfQbmOvflo8j1d/vjauTXjotxqp1LBhITvewsoh4rW+qsfW/Y3u9S+XM0oO99WJX
	 NBMTCnUb2QWjozmJLY38VgrzhStaraq7cREWOeJIJBSqMRkdiWuzRolv5b+F/DWCwt
	 PFLSd+90PCVZw==
Date: Tue, 22 Jul 2025 23:41:28 -0500
From: Rob Herring <robh@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK
 for SSPA
Message-ID: <20250723044128.GA1207874-robh@kernel.org>
References: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
 <20250722-k1-clk-i2s-v2-2-2f8edfe3dab4@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-k1-clk-i2s-v2-2-2f8edfe3dab4@linux.spacemit.com>

On Tue, Jul 22, 2025 at 03:36:31PM +0800, Troy Mitchell wrote:
> This patch adds macro definitions: SSPAx_I2S_BCLK,
> to introduce a dummy gate for i2s_bclk.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  include/dt-bindings/clock/spacemit,k1-syscon.h | 114 +++++++++++++------------
>  1 file changed, 58 insertions(+), 56 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
> index 35968ae98246609c889eb4a7d08b4ff7360de53b..6914ccf5be45a1071d5b6eac354cacb67888e00c 100644
> --- a/include/dt-bindings/clock/spacemit,k1-syscon.h
> +++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
> @@ -123,62 +123,64 @@
>  #define CLK_TIMERS2		41
>  #define CLK_AIB			42
>  #define CLK_ONEWIRE		43
> -#define CLK_SSPA0		44
> -#define CLK_SSPA1		45

> +#define CLK_SSPA0		46
> +#define CLK_SSPA1		47

Uh, no. You can't re-number things. This is an ABI and you just broke 
it.

Rob

