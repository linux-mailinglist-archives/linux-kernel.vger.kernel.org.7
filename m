Return-Path: <linux-kernel+bounces-823493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56DB86A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7BFB482DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65BF2D0C8F;
	Thu, 18 Sep 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLCmFbFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941327FB3E;
	Thu, 18 Sep 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222970; cv=none; b=kKQNWecehG5rMqUarglbsYa6KHk3fm2bbdXmmTJdoI/yZbOe7LEIRm46mNBxoXs5eZzaaKqPz39EeEgMBYoJeXjQbNTtereee7jrdDmuQE/wnFd+XaBeMyJrHVPBTgYbXOfw526aJCV74rAG+DYJ4/WPkGU/g4U3Ur1RjJ+7RT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222970; c=relaxed/simple;
	bh=KjDn6sHmv2zJSG8U1crdiaXSz9YTXqPKu6icdPo2s30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjorQc/sBswGsXUTCkpox5Lc7LUtjgLAww3nJJBJ6L43uFBzAp03IFeRViBUF9jrOxgbEB/wP1kGx0OesbW7+1pG61OlYmsOxNoEzz/gwJBuReon69s/NNKRor9yccPSUWCFfsFomhmZyhEfhNHfOhL2ytSzxuGrmL4LqXu8OSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLCmFbFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16981C4CEE7;
	Thu, 18 Sep 2025 19:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758222969;
	bh=KjDn6sHmv2zJSG8U1crdiaXSz9YTXqPKu6icdPo2s30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLCmFbFgOB16yHVUmpDid8KyJanGo+jSn4CL1c+SGxXbJK3Fv7XKbe5Uyu3WxUuru
	 MDVtzh6VYbrNpkkJeeVkPWv0C47MrlxpIyCGDKypNjPMLn9sNmH1NwlmhD/taagqqd
	 gmgCOuagY9ejxFmzemfErqQ/Xs7ijJ+Apl0vN4K90uPNG6nwMHKb1hLpVA7gwndNQW
	 sgwfLX4jzMcO9wyZ8ZWL2anuS5ztOf2AGh74nboaAD5mSI9PQRGyPOfnNrg7mQWIIa
	 3NN7gkuRl93CTFS3w1wfYIbcA6k2UMrwO8PsYeiLaHhzRI9KsoMEYGbrjCDREFPxaF
	 cRjVKu/1OGEBQ==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] SPMI dt-bindings and nodes for Apple A11 and T2 SoCs
Date: Thu, 18 Sep 2025 21:15:37 +0200
Message-Id: <175822291282.28444.12268120049385663263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
References: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 09:52:23 +0800, Nick Chan wrote:
> This series adds dt-bindings and nodes for Apple A11 and T2 SoCs,
> and the existing driver appears to be compatible. Drivers for the attached
> Dialog DA2422 and DA2449 PMICs will be in a future patch series.
> 
> The dt-binding patch depends on other spmi dt-binding patches that are
> already applied in apple-soc/drivers-6.18, so it is best for it to be
> applied through there.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (asahi-soc/for-next), thanks!

[1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
      https://github.com/AsahiLinux/linux/commit/4b167146ec05
[2/3] arm64: dts: apple: t8012: Add SPMI node
      https://github.com/AsahiLinux/linux/commit/8f6e6934e33e
[3/3] arm64: dts: apple: t8015: Add SPMI node
      https://github.com/AsahiLinux/linux/commit/70fa521f4d55

Best regards,
-- 
Sven Peter <sven@kernel.org>


