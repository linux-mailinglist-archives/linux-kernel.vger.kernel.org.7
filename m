Return-Path: <linux-kernel+bounces-725188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9EBAFFBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A531894A66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628028C03E;
	Thu, 10 Jul 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj73OZ6B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C228B513
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134888; cv=none; b=kmH1M5tvWNoZuyVkD58qpGPT4jHPyUPKSta3Y6ElDFMldqeXm4pWtKdiZ2AZFMssWlBc1xc1XkCEuINmkNY7iSeiASbU+0PiemHNLv0w/1QchetGLNvCA55kPjbRHmN0GA1d1B4Zw6ILE2yBIqnWVeBS9vmI2ZckyW4YmKn3khs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134888; c=relaxed/simple;
	bh=8a8/tL0yVuBQDUVRMcunwv9jC2nuJO3VEsfcfNKMzjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QGktSOGbIQR/SexnaVktw7XLJM7kb33HNXl+7H+d6L+XYFjrNYXLJR1Ten3PsIx34fUXjAICVQaAcQlPco9PiRI6wrekLTXpJuj1g8B1JZ+1BeR7Qx2P2Mnf68Ia206qIPcNING0jGhnEk0a0CES14okbxFQ+8E+L4E4GP56hJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj73OZ6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4A4C4CEE3;
	Thu, 10 Jul 2025 08:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134888;
	bh=8a8/tL0yVuBQDUVRMcunwv9jC2nuJO3VEsfcfNKMzjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gj73OZ6BR/5Javer5TAd9IeZnczg+3HpmJevef3Vpzv4bWgKLyyF5udEZI3f5Mnfn
	 tuqvvqM3EFnlO0KM7g3CI16TKFXw/rQ6cHhOyF2oqDHY3z/DjaadYXtxmKRK33/t5Q
	 u4Q0ILNN7LlChWknEDkh50DOaHmk9fYgXVPfKRmgNE5lt59sRUhlKSvvGGFbh7YpdQ
	 DhUVKb6wRNjJgoB88L/B04PnolpxTRMGSsQJ5sWanGy+qwvR1eSUSg0m8t6O11JJhq
	 6Y5kmqzcfwGqdSYbzOC5BZjf8I8uFCP6tyXzx9K+7ZvIE7rA9mdBAETW2Snf5sejKl
	 49V0EbctylaiA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, cy_huang@richtek.com
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 ChiaEn Wu <chiaen_wu@richtek.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <a6ab943f4660e39b8112ff58fa97af0507cd89e9.1752026324.git.cy_huang@richtek.com>
References: <a6ab943f4660e39b8112ff58fa97af0507cd89e9.1752026324.git.cy_huang@richtek.com>
Subject: Re: (subset) [PATCH] mfd: mt6370: Fix the interrupt naming typo
Message-Id: <175213488647.1399124.7897577665546128612.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 09:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Wed, 09 Jul 2025 10:00:48 +0800, cy_huang@richtek.com wrote:
> Modify the lowercase character to uppercase.
> 
> 

Applied, thanks!

[1/1] mfd: mt6370: Fix the interrupt naming typo
      commit: 08f69ce8aecef8ed4048818f985b4a8a87bc283b

--
Lee Jones [李琼斯]


