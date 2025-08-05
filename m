Return-Path: <linux-kernel+bounces-757086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A21B1BD80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E2D18980A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1E29DB95;
	Tue,  5 Aug 2025 23:46:37 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED0422D4F2;
	Tue,  5 Aug 2025 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437596; cv=none; b=hDsyEQO9WRY+ciq/7x35ZAHQz1MyNXLkLren5oDYhIymhSIqJH6v/KVYXd+3sx+R067yVgrn7XToyBQKBu/STT1CQPEBN8YNTB15A6Us0bP8Yh3UcjNn1vArfsOt9Lu56SDgxj9osWSacAfd0bpULG3KP/UP9WCD3qqWtJIg2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437596; c=relaxed/simple;
	bh=w4z6xFQYkr2sNj97KT129xjharVtY+vWjsTy7fHWazI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3GGEfRwTldfs78CQD5SJPFXgMD9JMF7tVobtHDDsbuUKzNZ1mdI2mNwLdwwfROhE2RuFJTmGK704tJ8Q29gpHlqtM1qaPQB6WEBADeqGAqcZo+4U+2AXwkhTF0esp1ZzcPWk5yc1OeLJygbQiEqm1n+A7NA5j60JQNPh//mzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 7517F34072E;
	Tue, 05 Aug 2025 23:46:34 +0000 (UTC)
Date: Wed, 6 Aug 2025 07:46:30 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Alex Elder <elder@riscstar.com>,
	Haylen Chu <heylenay@4d2.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH v4 0/2] clk: spacemit: fix sspax_clk
Message-ID: <20250805234630-GYC937575@gentoo>
References: <20250805-k1-clk-i2s-v4-0-038181284dd4@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805-k1-clk-i2s-v4-0-038181284dd4@linux.spacemit.com>

Hi Troy,

On 21:01 Tue 05 Aug     , Troy Mitchell wrote:
> In the SpacemiT public document, when the FNCLKSEL field of
> the APBC_SSPAX_CLK_RST register is 7 (3'b111),
> which is a reserved value. And BIT3 of the same register is
> a reserved bit.
> 
> But the documentation is incorrect. In reality, the value 7 (3'b111)
> of FNCLKSEL is not reserved. Instead, it indicates that i2s_bclk is
> selected as the parent clock. Similarly, bit 3 is not reserved either.
> When FNCLKSEL is set to 7, bit 3 determines whether i2s_bclk is actually
> enabled as the parent clock.
> 
> In all other cases (i.e., when FNCLKSEL is not 7), bit 3 has no effect.
> 
> Importantly, whenever FNCLKSEL is set to 7, bit 3 must also be set to 1,
> otherwise the selection of i2s_bclk becomes invalid.
> 
> Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Fixes tag get lost when applying this series, please move to patch [2/2]
or apply to both of the two patches? (I think it doesn't hurt)

also, please rebase this series once 6.17-rc1 tagged as currently patch [1/2]
can't be applied cleanly

> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> I sent with a wrong email so resend.
> ---
> Changes in v4:
>   - add comments
>   - add tags
>   - Link to v3: https://lore.kernel.org/r/20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com
> 
> Changes in v3:
>   - Fixing ABI-breaking behavior
>   - Modify commit msgs
>   - Link to v2: https://lore.kernel.org/r/20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com
> 
> Changes in v2:
>   - Use virtual gate instead of new function for sspa
>   - Add Suggested-by tag: Yao Zi
>   - Add Fixes tag
>   - Link to v1: https://lore.kernel.org/all/20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com/
> 
> ---
> Troy Mitchell (2):
>       dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for SSPA
>       clk: spacemit: fix sspax_clk
> 
>  drivers/clk/spacemit/ccu-k1.c                  | 29 ++++++++++++++++++++++----
>  include/dt-bindings/clock/spacemit,k1-syscon.h |  2 ++
>  2 files changed, 27 insertions(+), 4 deletions(-)
> ---
> base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
> change-id: 20250717-k1-clk-i2s-e4272f1f915b
> 
> Best regards,
> -- 
> Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 
> 

-- 
Yixun Lan (dlan)

