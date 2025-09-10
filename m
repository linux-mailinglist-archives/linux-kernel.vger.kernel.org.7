Return-Path: <linux-kernel+bounces-810557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB41B51C60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CC61C882DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8995424A06B;
	Wed, 10 Sep 2025 15:46:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703F32C33A;
	Wed, 10 Sep 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519197; cv=none; b=NbJ6JZNMT6hfH3NOTFj83h11lcnrj3G+V+qy5/z9PpZ3A6oKdze8dcdgA3uGF4nYDyi+flhB3cFOGKevLAWCs7O+ZLOpl2+6979uurGk29blogWDwOY30voktmXhSvnqPzejubWhAjvlCYrW/Cv5XpETNcO3r9kqQlEE62VTrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519197; c=relaxed/simple;
	bh=Mi4K0CZQ6jU43YkCgUBT1n3qh/s1QE9jw4W0g6FulO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D116wMd3XeasPdD0nRNNPF2aIrVvzzPGoTlE7Tm0yCV2BT2iJ+XUg09IEQqbFcZk03gnMCiib/nTEzDz13GMu2PVV/gbO/aZTcR1TsOBCHY99qGtGkeaNSjXgIdIQZx3uR/9o43o3wCFWBCl8NUdu1Xqr+e3Z8GxH5K8/j0dgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53624C4CEF0;
	Wed, 10 Sep 2025 15:46:36 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id BCD525F752;
	Wed, 10 Sep 2025 23:46:33 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250830170901.1996227-1-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
Subject: Re: (subset) [PATCH 0/8] arm64: allwinner: a523: Enable MCU PRCM
 and NPU
Message-Id: <175751919374.2641871.13986088170214893044.b4-ty@csie.org>
Date: Wed, 10 Sep 2025 23:46:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 31 Aug 2025 01:08:53 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi folks,
> 
> This series adds support for the MCU PRCM and the NPU.
> 
> The MCU PRCM is a Power, Reset & Clock Management block that has some
> clock and reset controls for the MCU, DSP and some peripherals that the
> MCU could use.
> 
> [...]

Applied to sunxi/clk-fixes-for-6.17 in local tree, thanks!

[3/8] clk: sunxi-ng: mp: Fix dual-divider clock rate readback
      commit: 25fbbaf515acd13399589bd5ee6de5f35740cef2

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


