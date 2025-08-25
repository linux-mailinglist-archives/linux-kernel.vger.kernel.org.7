Return-Path: <linux-kernel+bounces-785627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A73B34EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B3A1A8661D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291C92BEC44;
	Mon, 25 Aug 2025 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot/zAgHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4F29B233;
	Mon, 25 Aug 2025 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159536; cv=none; b=eCKSGlAwTfXl9BvbGGgJ77Oa+5TRyQvxMGvsBG9xA9c5kOkLZE4AIv9MWLw/KGZlADKo8hgHe1nqL8y8QVT3yO3IduvO6jZSL+kqb5mEXCew74ARN/zrh4B5p7CADJVxBr9qo7+XIrDSapS39C/4tHSQZasuvWKGzG/XyEEn1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159536; c=relaxed/simple;
	bh=9YkXdwlB5GBjp7h+4WxzI00sHRdEZGGpDcn2QNLkTvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqFgjxVm0Ugqb83tTOrbqzEWMEmMuii9XJ8aouPfN9WmWpGFuFNmvgh0DK7fEG1OxFS43vLiW9AxskazL5lnezHaKaUVShcQX5sh2/alyPKbu7ELiKb37OHH4k1khuQgTeaXJbwzsOhbHiyjNaNV3Zy7SPzomu8nSEaZS4ju1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot/zAgHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3303EC4CEED;
	Mon, 25 Aug 2025 22:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159536;
	bh=9YkXdwlB5GBjp7h+4WxzI00sHRdEZGGpDcn2QNLkTvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ot/zAgHS5LlhOJdqyYklnsyF6dAc2C0UdY9bxCJ3bHtKyvDXvrN6yD0Qupmz0JmGd
	 /bewWPPDAIMoBqzA111jbQEjYRgalWlvUkE1uFQRWlML60FLf7THi0hmnI7UTQ57N2
	 Y4UDFdlY8kBgqkJf7iXZ7Knt0/9HBJDovHITZRWEaPfnnOGeqVlhRZ4XtEQ2CBw6Cq
	 yPD4wEaJ+vqS7EtI2zXH+NMT8V2U8kmoMV/aVTc86xvBOm8qWGMWauUVLhBt/Z58Yh
	 VbiEy64l3UVLLJcq07ztjmYfVdlBu7FcGRnt2lAjI0uLZRJ7WtqYyeKxAZF579xRYj
	 qFkFhvUh6DcSA==
From: Yixun Lan <dlan@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Elder <elder@riscstar.com>,
	Haylen Chu <heylenay@4d2.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH v5 0/2] clk: spacemit: fix sspax_clk
Date: Tue, 26 Aug 2025 06:05:28 +0800
Message-ID: <175615931445.19771.17415403956670708422.b4-ty@gentoo.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811-k1-clk-i2s-v5-0-ebadd06e1e91@linux.spacemit.com>
References: <20250811-k1-clk-i2s-v5-0-ebadd06e1e91@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Yixun Lan <dlan@gentoo.org>


On Mon, 11 Aug 2025 21:40:32 +0800, Troy Mitchell wrote:
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
> [...]

Thanks, Applied to SpacemiT's SoC tree at "k1/clk-for-6.18" branch

[1/2] dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK for SSPA
      https://github.com/spacemit-com/linux/commit/7d50d9bf1cd00d6bab0abf3b01d5d261aa6a2b04
[2/2] clk: spacemit: fix sspax_clk
      https://github.com/spacemit-com/linux/commit/c536e00d58dc8db3e1e430a8e6830bc22d2a38e3

Best regards,
-- 
Yixun Lan


