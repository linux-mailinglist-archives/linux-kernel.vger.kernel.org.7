Return-Path: <linux-kernel+bounces-729513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B562CB037C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE107A40A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9623504D;
	Mon, 14 Jul 2025 07:21:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB722FAF4;
	Mon, 14 Jul 2025 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477689; cv=none; b=vFq/rV1MtPjYkibj6wP8NSOrl7US7rwtgd/AZA/DZAxNV6B7ZAzmMa+/qAkwrrZrRmjf0v7ismMC4poSEkAlwxQIouA5ASdXnhhG7OnK/hC09qF7kbeYjzOmdBXcJqX69lk1FNyUuGMKvN/oBL8wWbR6/NCF53yR7hoyyukaaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477689; c=relaxed/simple;
	bh=On3f5QmbIzahqfXf4oZ2CTb5bfYv68ngIqpktQBem4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WVkFtKt/DLmxJa1qDAdiYQrvW0pR6lSr7uPEIzQ9MBaCLw28K44Re0AGV9HxPZFsuE2/SIOxKUkafxcsFU5ubwsbQmSf9rlOpIdHcWEauuP+DxtOD8PUyarMs02wwf/+krBbYPZ7SwVQLbGgKNbEpHBJ2AMaaDHQKVsPZYrpYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B96C4CEED;
	Mon, 14 Jul 2025 07:21:29 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 57F2B5FB60;
	Mon, 14 Jul 2025 15:21:26 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Paul Kocialkowski <paulk@sys-base.io>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Icenowy Zheng <icenowy@aosc.xyz>, 
 Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20250704154008.3463257-1-paulk@sys-base.io>
References: <20250704154008.3463257-1-paulk@sys-base.io>
Subject: Re: [PATCH 1/2] clk: sunxi-ng: v3s: Fix de clock definition
Message-Id: <175247768623.1732129.17411169356635975497.b4-ty@csie.org>
Date: Mon, 14 Jul 2025 15:21:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 04 Jul 2025 17:40:07 +0200, Paul Kocialkowski wrote:
> The de clock is marked with CLK_SET_RATE_PARENT, which is really not
> necessary (as confirmed from experimentation) and significantly
> restricts flexibility for other clocks using the same parent.
> 
> In addition the source selection (parent) field is marked as using
> 2 bits, when it the documentation reports that it uses 3.
> 
> [...]

Applied to sunxi/clk-for-6.17 in local tree, thanks!

[1/2] clk: sunxi-ng: v3s: Fix de clock definition
      commit: e8ab346f9907a1a3aa2f0e5decf849925c06ae2e
[2/2] clk: sunxi-ng: v3s: Assign the de and tcon clocks to the video pll
      commit: ea879ce83d360aa13acd54cf6af913885b69ed44

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


