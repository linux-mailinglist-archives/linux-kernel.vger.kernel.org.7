Return-Path: <linux-kernel+bounces-753703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866BB186AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F18A82B81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F82328150A;
	Fri,  1 Aug 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZNua/2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5FE42065;
	Fri,  1 Aug 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069303; cv=none; b=TfbsF8PHRZFy55oKCnMnf20QLJZg4cHHVKC/yDe822PsaVwNWhFgx2IhvL0tLifnPp9USvtZdB/LdpBhHars7mnAFehCk5xe+tZcjxAlx2QsNZ7qe52Cqw7GOhSCAB+yDR1+az0I5Di41dI7MNkTHiB4tisFdfCWWd5lp4AfzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069303; c=relaxed/simple;
	bh=Hw1MV3oclXxapTMMH7EOZwKLaNES+dV1oG87CCkwVTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acmudNsKedFEoLzJjEMLmhVKXYCGYIklW3X1ZK7Or+zBwgXJo3MXJA31DBD4K+HIi5niR7gXmIqrjKBps4oZNLq3ugFjX2x++kltjtmskRy9CPNygKYRzSa3eTOazKEOkMOCqKjg002SYLxvlaEU+TN7+pRhGlD43HJ5HbM0qMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZNua/2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B6C4CEE7;
	Fri,  1 Aug 2025 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754069302;
	bh=Hw1MV3oclXxapTMMH7EOZwKLaNES+dV1oG87CCkwVTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZNua/2SbzwcTMoQr8Rk/2gn3Vpnvc8gVJ/P3eGtwrBhIxMBoSEUtbah6/q2JTk+Z
	 eUOwcoEENsK/CeHNVAXEop7YPru0d4IMJP6VC13XZc4jZu4v58EHXJcUTdaY6wFpCH
	 C50kwD+180UzsuIrKwyQ7ttUU2EBZgvPojm1ushfRW/xJiUhmRvOocNevpbeFwxP41
	 xmbFq8B+nb+wauuegjGlxTiCWe2z09wORH0Ir4vNrH4ggMWcKB1KfjDjaNvB4ivPo6
	 sf1A5Ya6T0EtCRE6FO/owW3EgyaErvxKTZyYRDxuAMeuc1dEx9+N33drBiQ3W9VNj2
	 uR+/1MIvAq8JA==
Date: Fri, 1 Aug 2025 12:28:21 -0500
From: Rob Herring <robh@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: kernel@collabora.com, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ikjoon Jang <ikjn@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Julien Massot <jmassot@collabora.com>,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 5/9] dt-bindings: sound: Convert MT8183 DA7219 sound card
 bindings to YAML
Message-ID: <20250801172821.GA3111733-robh@kernel.org>
References: <20250801-mtk-dtb-warnings-v1-0-6ba4e432427b@collabora.com>
 <20250801-mtk-dtb-warnings-v1-5-6ba4e432427b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-mtk-dtb-warnings-v1-5-6ba4e432427b@collabora.com>

On Fri, Aug 01, 2025 at 01:18:07PM +0200, Julien Massot wrote:
> Convert the Device Tree binding for MT8183-based boards using the
> DA7219 headset codec and optional MAX98357, RT1015 or RT1015P speaker
> amplifiers from the legacy .txt format to YAML schema.
> 
> This improves binding validation and removes DT schema warnings
> for boards using these audio components.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
>  .../bindings/sound/mt8183-da7219-max98357.txt      | 21 ----------
>  .../devicetree/bindings/sound/mt8183-da7219.yaml   | 49 ++++++++++++++++++++++

mediatek,mt8183_da7219.yaml

>  2 files changed, 49 insertions(+), 21 deletions(-)

