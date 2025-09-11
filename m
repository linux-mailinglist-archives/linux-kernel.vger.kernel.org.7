Return-Path: <linux-kernel+bounces-812680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89544B53B57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E34E21FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9493680B8;
	Thu, 11 Sep 2025 18:27:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632F1DA55;
	Thu, 11 Sep 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615234; cv=none; b=SHxIv68etJwWk71GttZJoLG+MgHNXS6XwXiHVRCUykPmjJZW7ArLZB3R7Q5pH1gXSDg69jnhk8pcr8UPTKSuFlMlogU9JEYglSk/WribNQQf2bA1BcyADhuN8vEhgsyry3AGlCNOkMgFLrxdggeKWm9uMRd2imOM8ChpYfzxeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615234; c=relaxed/simple;
	bh=RSp1HNE2IWulhQOUIZgeoidLxpcJnFsrnCZzAq87dsg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=baZLlFP+bbv02zQshwFDR/VS0P/8KHQvTTia9+tTrWordkgA4cEIP1oScBqBEo+rnsc4AnfEXYF4uz27bsYrTJZUSS6Sr7OyCg7+1U28KWyD5sb9H5KBrr4/vXUj1OMzULAK/41CY4av1Le/9vPKPgAW5LQm4NWidOphKmTd5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA234C4CEF0;
	Thu, 11 Sep 2025 18:27:12 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id A2B4F5F752;
	Fri, 12 Sep 2025 02:27:10 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250909170947.2221611-1-wens@kernel.org>
References: <20250909170947.2221611-1-wens@kernel.org>
Subject: Re: [PATCH] clk: sunxi-ng: sun6i-rtc: Add A523 specifics
Message-Id: <175761523064.3162090.15869713865549110289.b4-ty@csie.org>
Date: Fri, 12 Sep 2025 02:27:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 10 Sep 2025 01:09:47 +0800, Chen-Yu Tsai wrote:
> The A523's RTC block is backward compatible with the R329's, but it also
> has a calibration function for its internal oscillator, which would
> allow it to provide a clock rate closer to the desired 32.768 KHz. This
> is useful on the Radxa Cubie A5E, which does not have an external 32.768
> KHz crystal.
> 
> Add new compatible-specific data for it.
> 
> [...]

Applied to sunxi/clk-for-6.18 in local tree, thanks!

[1/1] clk: sunxi-ng: sun6i-rtc: Add A523 specifics
      commit: 7aa8781f379c32c31bd78f1408a31765b2297c43

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


