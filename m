Return-Path: <linux-kernel+bounces-727156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0380B015CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E338647A37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84601FE470;
	Fri, 11 Jul 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBKBFQ0O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38B10E9;
	Fri, 11 Jul 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222087; cv=none; b=GCgcfGx0ic71HPGyWIOvtfxhVqX+p3HqdpgjUnncH53S9HPCX8q4hdiSuz1kbiWxsqnZfH7HtHs4NHQPQZcwmzlBhVxJ+Db3u8UJ2GuLY0yD4aByvGLeCCSl6r6CCqdx+C0FCAgrUugG6CIi+qiGrkHn3JTnqC4m7Vn2/cwCAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222087; c=relaxed/simple;
	bh=/sUXyiwiYSWcLO2lEUxoAOTkqT9mf6i244gGAm0GuOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsLVPbqp6ORGjni9Iirdjr4f/7YTv3oXDprl4TS1vw5PDfBziDfGuHXR9ye/O88BZS0yotylR3kTbhv9cp7+/zRb8EbDRQr13fx+P/ngob4N2iHF5ic/xLRXDaTG4wVvuszADICU+oT55teNnaEKOU/B7w9lNmBQoeXwFX5u0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBKBFQ0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C8FC4CEED;
	Fri, 11 Jul 2025 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222086;
	bh=/sUXyiwiYSWcLO2lEUxoAOTkqT9mf6i244gGAm0GuOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBKBFQ0O0IBd1VD3BMGK89KHQaZFU7loMWAQZVgWCjEtePTF1zqEG5GyLvZ7w/rdM
	 6McYNpSZc15knvzVXnTEwJ2PhCan7SgAraQs1EEzBTansZ4y8vSETi0sXdkV1KswXx
	 JElQTVp1VqYwJ/7uVTQ1mqGNElUQoB3LU5lSu8ztOxWaaeSrZChbMaO74mD8YiAIVN
	 y4GybxkjZN824QQBW6DtqcA3VzYQ3nyWgqDiLTH8nZ7rhnX/QIuldIzCfIfExfaFE0
	 WzLltSut1mUbzDbbjgV8JOnJ6PdtYKB2k0HMskoYMq6pitoaswirdLoptgzdvamdE/
	 fLTsmBDelvw/g==
Date: Fri, 11 Jul 2025 10:21:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: arm: rockchip: Add ArmSoM Sige1
Message-ID: <20250711-silky-arcane-coot-acfeb1@krzk-bin>
References: <20250710202958.3717181-1-jonas@kwiboo.se>
 <20250710202958.3717181-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710202958.3717181-4-jonas@kwiboo.se>

On Thu, Jul 10, 2025 at 08:29:42PM +0000, Jonas Karlman wrote:
> The Sige1 is a single board computer developed by ArmSoM, based on the
> Rockchip RK3528A SoC.
> 
> Add devicetree binding documentation for the ArmSoM Sige1 board.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


