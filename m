Return-Path: <linux-kernel+bounces-725284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD4AFFCE9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539A71C86A58
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD753291C11;
	Thu, 10 Jul 2025 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpUhlpaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2B290DBB;
	Thu, 10 Jul 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137663; cv=none; b=nfTwZokrTdoyK31b153+LUvTo43vlkMHhdwZvj1rueyfgYJxdUxiBrss3U4Ff4+Lc0ZtU9fmO05pBMvJfkcL1Or9ch7blzyBEAhV3t4TGpwT9CY4uy5xcieERDXWjjdv7LrTt/1EKVHAPl1ZTsJa54uFvAmJTbQSpunjgX6KDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137663; c=relaxed/simple;
	bh=EjUzA2JuHZbrcdIUc8oh0BWkdNOAqsv/Xix52ydC7b4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OSad3zsBj27EcuNUldqugm6ht2xF4IFkoF8pb2bCMK9WWnzempxFGwMq/9hULs2QlqWoGlXuN/iNCUQBxUbyYyzupYFjo2nPP1N5WDKpY6eMR/XtQ1QnU2W3bR3ihxHm1/YrAIRO3XvbpTbAbDVPxUo/7snZdjv4eWW1nWYNiLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpUhlpaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F14C4CEF8;
	Thu, 10 Jul 2025 08:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752137662;
	bh=EjUzA2JuHZbrcdIUc8oh0BWkdNOAqsv/Xix52ydC7b4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YpUhlpaPxI3/ftOuwSjld66/8g1woL5g0sbycmL2p7EgKoRCdhnBMk9Mo/KxNdmLD
	 WNSJnH8TvKfSQ3bwnBxqujCIiJmaKX32ISmFlXTJVAm/CTytbYg7/Q+ThYK6WGGeZt
	 DgZ2tteMJigTOT81nYj7fEEgfmGEvGkgGqVc378qNwWhnlJLaIyAb84bd0+66yWSgy
	 afd2FNXLko98/vbHGH+eQ9bvdTfW/opCfNXTq6WHB4H4LOGle+qugSQslX2asMpux2
	 fTvhEXyqGRZ5MMcMn1fjD3x3WzAzF7g5srXogyxHk7PzvoLNT6dcd/sQ1E7zLdMUVZ
	 BHAzabvLhRZIw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, 
 Chris Morgan <macroalpha82@gmail.com>, 
 Vasily Khoruzhick <anarsoul@gmail.com>
In-Reply-To: <20250701163652.252010-1-wens@kernel.org>
References: <20250701163652.252010-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v2] mfd: axp20x: set explicit ID for regulator
 cell if no IRQ line is present
Message-Id: <175213766092.1425808.13168630875938700813.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 09:54:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Wed, 02 Jul 2025 00:36:52 +0800, Chen-Yu Tsai wrote:
> Originally an explicit ID for the AXP313/AXP323 regulator was set to
> avoid a conflict with the primary AXP717 PMIC on Allwinner A523 family
> boards.
> 
> This didn't entirely work since on some or all of these boards, the
> interrupt line on this secondary PMIC was left unconnected, and thus
> the driver would fall back to the generic "no interrupt; only regulators"
> case, which didn't have the explicit ID set, thus undoing the intended
> fix.
> 
> [...]

Applied, thanks!

[1/1] mfd: axp20x: set explicit ID for regulator cell if no IRQ line is present
      commit: c6c68f08d524ab76cc3cf6449a8cb235b8c3fc06

--
Lee Jones [李琼斯]


