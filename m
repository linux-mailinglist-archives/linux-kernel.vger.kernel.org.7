Return-Path: <linux-kernel+bounces-730309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D3B042B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8061894EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7082F259C83;
	Mon, 14 Jul 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QFEuyuOr"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492288C11
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505754; cv=none; b=VrOJczOXfC/3QmoJu2k9O0ZgQi6u+T3XcfXxk5TWbeBEenbgUbj5VuRzRRw5h+jNadURIs/8iB/SU7LTNh6zbKEXZ7fribzwKY53q/gKHiQtZRq8Ii4mbRCIuW/T+6wRpE2VRbSmvrinKIjhd4mMVzSJmC944Fj0UNGyL7ShkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505754; c=relaxed/simple;
	bh=6rooYuiWszTrlZTlV3eZ8Xmg44nxdz37lK5VJJrlM8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNIyhF/UGuVTFeN/EaKh+HITEOiKgXzuGAsdPMyMeZEr58e0bQzxBWUPIf/2xCIJDDSdSojisrE58ERpCkAv3FUnzmIvg25ynMa2PjD2GKM8BfuSuJRoeqj49dYisRiWzVUxeHT66KM5cmlwdFZkHWXcq5xpcGqbX3U10rIfrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QFEuyuOr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MO/GFqgIz7AdPvjjhkE5dewHSOwJ1svG8yj0j7LFimU=; b=QFEuyuOrACawpU+/f0Tnh7yfLG
	EgSElknPA5oLZJXaIgdAwkMBVff/BXn8IBcNKpbPgseKARlNkaaOK4IfDQCIVFu/Y9wTExiOSYfWH
	hCBiFzl+9cuK5NKxZwnsyXswGTzxlYfY3S67ssXqUpFUVSuaO6R4DBSAsiMnketHWWdO/qwYGN7KD
	orPJ73pCI3c85ybT0nuSaQhAdycQYvHSOX2ZNbmApE9ezt1LxvH8TzOzNsX6Uq5OVlM64eLUAHVRM
	zZAW8nor9xYXJ44uMfZZI2ivHfY2IBg4ynE+yO6a8ZILk6qLfJyfou7XYUaPlcC+WZx2NzbHdDXDq
	YT6LV0nQ==;
Received: from i53875a13.versanet.de ([83.135.90.19] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubKng-0000lL-Vb; Mon, 14 Jul 2025 17:09:05 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Kochetkov <al.kochet@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] ARM: rockchip: fix kernel hang during smp initialization
Date: Mon, 14 Jul 2025 17:08:55 +0200
Message-ID: <175250559795.2450518.6205508340787184365.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250703140453.1273027-1-al.kochet@gmail.com>
References: <20250703140453.1273027-1-al.kochet@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 03 Jul 2025 17:04:53 +0300, Alexander Kochetkov wrote:
> In order to bring up secondary CPUs main CPU write trampoline
> code to SRAM. The trampoline code is written while secondary
> CPUs are powered on (at least that true for RK3188 CPU).
> Sometimes that leads to kernel hang. Probably because secondary
> CPU execute trampoline code while kernel doesn't expect.
> 
> The patch moves SRAM initialization step to the point where all
> secondary CPUs are powered down.
> 
> [...]

Applied, thanks!

Gave this a spin on rk3066 + rk3188 + (not-A9) rk3288.
Both the affected SoCs as well as the rk3288 booted fine.


[1/1] ARM: rockchip: fix kernel hang during smp initialization
      commit: 7cdb433bb44cdc87dc5260cdf15bf03cc1cd1814

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

