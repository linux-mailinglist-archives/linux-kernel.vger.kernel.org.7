Return-Path: <linux-kernel+bounces-883790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B2C2E6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945A23B414D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821892FFF89;
	Mon,  3 Nov 2025 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KPyCYAeV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75687238C1B;
	Mon,  3 Nov 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213254; cv=none; b=uRZrMjcUY5JHqfF9JvJQLRWsSmCXIsLo0h8vVvWDzsOWqa+4adlvCLA+I1BOjGlMqeYE5RoDfuU2GNSKP6wbrh9KjneWpchYBh86XiiGGNG59tGdvOzjquwED+D00Aa4bbQKvbKo7RrBGQm9AeBMKQnNN7PVqFrw10BfW5ubRuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213254; c=relaxed/simple;
	bh=en/cGc9+iFJY0XbRLN8FYi6R8rxFeDBw26Vl+JuWT+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPmqsMptDE6JrHl9aNfuAhWHdUJXf95RMEVttNG5Wws1MtSdN8R+VETtrrTvlWw72gXVsvCa1c9DwMvtFXTZdkpTXrgdgFdqoQBPJwQVigIm1wnMUrVUNYMOoV7sKR9Na+i7oqugFphNH46LzPw5PRu/xLEFiBh3rLwoZnWkTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KPyCYAeV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=nnTxcLtAJLOyvzCsx/4DTYpkHdNUlvMGiWTN+Hezun8=; b=KPyCYAeVmfoep9n41L0AGgJGaM
	XvaxQOkbNiD9V697sJ5hE1497bWlQIMsTrkkTofAPJPQUbSCva++vC5Vab16OwY/ZGC655m7fNIMw
	FipeHPqEkt+0+bm60TJV5CuXtrO+RqdAUq/+ACg4vIJbHtFBTpDAt9SQUZEY3aaVTdHbun+iGxHXY
	COMeEQ/Hasn90dqPAzUxUvAttTc4XQF5f26MKSZLrokuxbCmrVUHYLxmAlxUokib+dZa97TL+V5Zo
	M8BmA/9Oz9/4G5OAExqzEydWncs0PQRDHgbH2heLQsQwrn4GkVLA9sxiK8exrPIpZ7t5dg/yYErnK
	KCeXv58w==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG4AJ-0007rE-Gl; Tue, 04 Nov 2025 00:40:47 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: [PATCH 0/2] Drop RK3568's variant of the CLK_NR_CLKS constant
Date: Tue,  4 Nov 2025 00:40:30 +0100
Message-ID: <20251103234032.413563-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This drops the use of the CLK_NR_CLKS constant from the rk3568 clock
driver and after that, drops the constant from the binding that should
not have been part of it in the first place.

Heiko Stuebner (2):
  clk: rockchip: rk3568: Drop CLK_NR_CLKS usage
  dt-bindings: clock: rk3568: Drop CLK_NR_CLKS define

 drivers/clk/rockchip/clk-rk3568.c      | 5 ++++-
 include/dt-bindings/clock/rk3568-cru.h | 2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.47.2


