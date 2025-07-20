Return-Path: <linux-kernel+bounces-738473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED95B0B8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244D117A139
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607327462;
	Sun, 20 Jul 2025 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIE5+0nR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D57262F;
	Sun, 20 Jul 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050694; cv=none; b=L/CStjcEk8WzINhO6OHR82SoSZMtfDJq3bTq+BDBoPCwQ+wMNQlKaAg9u/Om09d4tYYlzMcC0OGX98btnmEXXOmtNIjNjsCJiA1EgIe9fuSWQ/dJZ/3Y5/ao/P3Sh0fHEfv+rXRnGGtlxl0Zkl8Tjq7wOIqUA+HZXSkYpNjlVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050694; c=relaxed/simple;
	bh=50iTg/SAsC7EhohLsSHiAG2N4JR8waxyUPKg3blf/d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot2Iikn9ajD+oZeOLIbexaCK31jlcA/SUu+Ln/6Xh+xKCf8q3LpfXMmJAmqDVhaUw3Cj36QrRE6g86OoKG1nS7hAQpLOREV/5YT1OnUb9KMkQtZrYQT5bbhuiOFKdlaPmQ9R2u+S/Y945b8HjPGq37Api5YDoyGrl1d+VxS6jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIE5+0nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F18C4CEE7;
	Sun, 20 Jul 2025 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050693;
	bh=50iTg/SAsC7EhohLsSHiAG2N4JR8waxyUPKg3blf/d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIE5+0nREUkQvqWy8homaCWmQE3s2zz3WH1Eb3qCG40Otsm5ZTRc+5AnFpKULX9+e
	 osNJPXQPubkkRHKCnZgbuIokYe8dDlP1T+oxRrM2z7zgNEesM/U8vbzfEGmJNDNuyc
	 wlhomREK1io+vaSYHWf3CXnB0uCF27zLVZybUeINF2/2nQWiozYDKuiIyHw2KpueHg
	 SzacHO6cfAAmRofkLE/kQ4HxeI9LMTBD356TeKYA0QxQG2+bFRhsjOGt9kCPUO5Fg5
	 gr2Amws4KLywEFZGTpzV2agGaspvIJ/0euQ5arTjjSH7q8vPuVt0QYOmbVf6g6KtNq
	 ticKY/n0+zv5A==
Date: Sun, 20 Jul 2025 17:31:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: add video clock indices for
 Amlogic S4 SoC
Message-ID: <175305069251.2909158.8930383532423770218.robh@kernel.org>
References: <20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com>
 <20250715-add_video_clk-v1-1-40e7f633f361@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-add_video_clk-v1-1-40e7f633f361@amlogic.com>


On Tue, 15 Jul 2025 20:51:38 +0800, Chuan Liu wrote:
> Add indices for video encoder, demodulator and CVBS clocks.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


