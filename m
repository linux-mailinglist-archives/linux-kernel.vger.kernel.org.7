Return-Path: <linux-kernel+bounces-765294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97818B22DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0A37A7845
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244E2FFDC0;
	Tue, 12 Aug 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsA/mEHm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33692FAC01
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016917; cv=none; b=eQ4AoUuUnaQerpiyGBGHs8XX6dQleSa7JBqiHvqxz92s1tLP9glzAlhQDuqMgaETyR0L/Bqwak379JPLrQCYXblM0+sTMBoXaPyVnjwxg7ENAzWlaHMnAhoQ064KI4WYfl/pE4KpuEhqkVA7tlmh/SvQMU6wMptwzvd4tNww8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016917; c=relaxed/simple;
	bh=qylFsF0HkvEqH5od8S1haU8m9Yen1Xq7TJ1PYMkZias=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J89HawbX60wEmp4pXjMqCOT2BwWTcGSwgc2dEhkbOaF//OKz4H9CQa7h8FNmIjVjTn6WOO/pcsODytER9Tt91F4iRf+UuyHm/GznLezDRKV6Rwn6wx1m64I24+u7YDBPZf2zOCdV5c8APBsdtYZwWKTZnB5KltaRsjCv79N7E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsA/mEHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C953EC4CEF8;
	Tue, 12 Aug 2025 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016916;
	bh=qylFsF0HkvEqH5od8S1haU8m9Yen1Xq7TJ1PYMkZias=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EsA/mEHmCN10Kazb1TmB4OujmNIqjyo9ou7fbL6gpyghMgeQbNn6UY0w1lJWikO/9
	 IrkN8VHSFQYroUiu8bXSmnPX/YZbx9N7nHEa31yq0dBeHh6pj6GpcL8PY3VryKwMkY
	 45IgdIQA8S/q+W2zwMCj8kBbGE6rjxU0wbElH2gIBQ0W1vNLsVjl6wJ3XEcjK/2Ajj
	 bzLYDo5SUqHIT5ga7OEVia6GC6935zfdLh/uEyux7qeM5VNbO84dw+UHJRUY5HNfBz
	 /jlTgdPLSTscyikEtks38OHjPoYksQXk+9WSmn+v+FOJD/dIRw4/CO+h9zOgKqf77J
	 +EAc6qmda75fA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250723072324.2246498-1-jonas@kwiboo.se>
References: <20250723072324.2246498-1-jonas@kwiboo.se>
Subject: Re: [PATCH] phy: rockchip: naneng-combphy: Enable U3 OTG port for
 RK3568
Message-Id: <175501691338.633310.6315313120573301384.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 22:11:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 23 Jul 2025 07:23:22 +0000, Jonas Karlman wrote:
> The boot firmware may disable the U3 port early during boot and leave it
> up to the controller or PHY driver to re-enable U3 when needed.
> 
> The Rockchip USBDP PHY driver currently does this for RK3576 and RK3588,
> something the Rockchip Naneng Combo PHY driver never does for RK3568.
> This may result in USB 3.0 ports being limited to only using USB 2.0 or
> in special cases not working at all on RK3568.
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: naneng-combphy: Enable U3 OTG port for RK3568
      commit: 4e346666edcc0506d8f0e581de4280b85b0d3e98

Best regards,
-- 
~Vinod



