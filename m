Return-Path: <linux-kernel+bounces-899513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3CC57FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3DA3A9BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490F2C3259;
	Thu, 13 Nov 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7EMGnON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5A22173F;
	Thu, 13 Nov 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044378; cv=none; b=oTgEuR+1ILT1ssHnPtFx5NImeKgHM0xSiJ+2t6BZozSrG5a/1hXF2IgTJAw9VXR3Lt61ZwMoihr24L4yKjMWZswRNXtujuatZuETKAzsY51eHYDQL2YcLnt/MGBbVsniNcJgHhEcxD9342HwrjdEPwyH+oRQQ8iUkYHTJqbOWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044378; c=relaxed/simple;
	bh=xmZRA0a6BaSii6E5t+n80ATlHPoVnfCRxNBRzli8wis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=duQoOsgwnWBkxlzRa04nGEBGbMttsDvaJZH79uK/4nM0Kkz7xwo1DOrJ2rD4ZfU5xG2h3c3QopxM7vJdxfFCyb833XTnf6kN6Xssjl90WlJmHVUef/ooMvBCabkWgY8cfFYk1Yl0yFeul/tAyEC/TjLMXIuSgNan6UrrwAor8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7EMGnON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C407FC4CEF7;
	Thu, 13 Nov 2025 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763044377;
	bh=xmZRA0a6BaSii6E5t+n80ATlHPoVnfCRxNBRzli8wis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u7EMGnONe5/v2qw2Pg0dtkzqqthyFX2jM7ugcjGvUulylpSaNmdKK5IB4LvtH3nbr
	 ZFJV/RqRI1OxNb29WwMRl0zHp+UbfD3qZS24tBsqXAOKS4Fw0WR2kv4loZjVqOAFv5
	 mZ6jYyJyjY7cWEsrI/mPw5ZRFy+9vE7PwzYbHhUQ3CcLCmieoHt3+2++XYM/ZFC/oS
	 G2UBdvPHQZvWfa8NWBWfUjsqiz9yZoqRI9EK8hFcB0t1NKniuS70FBUrQy0LHQ1bQu
	 ij44/ZA9CWRuKm7ZSpeuBG27ceAJ64ME6NYY3XYltTd9PCurz+BApMq2HS1SYVmiwt
	 HwSx5H3adZfaQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 linaro-s32@linaro.org, NXP S32 Linux Team <s32@nxp.com>
In-Reply-To: <aQdHmrchkmOr34r3@stanley.mountain>
References: <aQdHmrchkmOr34r3@stanley.mountain>
Subject: Re: (subset) [PATCH v2] mfd: syscon: return -EPROBE_DEFER if the
 syscon is not found
Message-Id: <176304437551.1512159.5052271810982165086.b4-ty@kernel.org>
Date: Thu, 13 Nov 2025 14:32:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Sun, 02 Nov 2025 14:59:22 +0300, Dan Carpenter wrote:
> These days we can register syscons with of_syscon_register_regmap() so
> when we can't find the syscon that probably means it hasn't been
> registered yet.  Return -EPROBE_DEFER so the driver will try probing
> again.
> 
> 

Applied, thanks!

[1/1] mfd: syscon: return -EPROBE_DEFER if the syscon is not found
      commit: b73d5593bfde6bf570d55bcff3576e35cdf4ec9a

--
Lee Jones [李琼斯]


