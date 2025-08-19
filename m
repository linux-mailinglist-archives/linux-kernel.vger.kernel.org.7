Return-Path: <linux-kernel+bounces-775828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B6B2C56F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C2EA02AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110842EB840;
	Tue, 19 Aug 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b28gXOmJ"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA220343204
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609497; cv=none; b=LnDoo4TkqScwd8X64B28snrHzZ0e2JD1tgNR49I61Ddz23OJ/epcbyZI0+aJY98jRGs8ulRpN/vQ6VZ6RiBT49fPvanFL9Nhn/jKT73eBYh16ZCgyRnIbFd6bFOoB00xDwhay4AANjb7QxR4lMAr/ns6alymiI6mLPsvleigM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609497; c=relaxed/simple;
	bh=haelXDwMy02Pwc8ZA2q/PxzyUxHWHwhLuI5ijIySm2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ZReXa79LEydtsw7kosVAM3dULf5J1b7Clo8FvbeWNjFqClDJwan06A70ojW6nRygiVt9BsFTY2RYKXI/8bSHyeOsH4oCMKuEZT0zY7mW1X0/GwuJO8+eXYEfqofQl7H/U0jhymJ08UvAuj+ppZUcrWCq0qb6mQvScPZUlam73A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b28gXOmJ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250819131814euoutp012e3078d07000df89dc75aee9f3892bc8~dLYibiI6E2012120121euoutp01T
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:18:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250819131814euoutp012e3078d07000df89dc75aee9f3892bc8~dLYibiI6E2012120121euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755609494;
	bh=haelXDwMy02Pwc8ZA2q/PxzyUxHWHwhLuI5ijIySm2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b28gXOmJv53Ukifr2jI0aPiN+kMb9HQZdc90+xIpGWsCXMjzXCs2BhEZzlqeWCbEe
	 XNIxLDdM7+bmLvwFirdlYVt922QudW1edmFOYmAXkyD3uaUur4O+Q/SNp8+NZrmsew
	 6FWIkB/NKoNcUv+wqS/Dz0JkHhZdn8oXOWJ/oSfs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250819131814eucas1p2c57ccc084cf6736fed01a8a5c0b35fab~dLYiBBqeM2800428004eucas1p2h;
	Tue, 19 Aug 2025 13:18:14 +0000 (GMT)
Received: from AMDC4515.digital.local (unknown [106.120.51.28]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250819131813eusmtip1ef1102cfde54eb4bafb4302017462cbe~dLYhNgGmp2290322903eusmtip1f;
	Tue, 19 Aug 2025 13:18:13 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux.amoon@gmail.com
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org,
	justinstitt@google.com, krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	llvm@lists.linux.dev, lukasz.luba@arm.com, m.majewski2@samsung.com,
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	rafael@kernel.org, rui.zhang@intel.com
Subject: Re: [PATCH v7 7/7] thermal/drivers/exynos: Refactor IRQ clear logic
 using SoC-specific config
Date: Tue, 19 Aug 2025 15:18:03 +0200
Message-ID: <20250819131803.23296-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813131007.343402-8-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250819131814eucas1p2c57ccc084cf6736fed01a8a5c0b35fab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250819131814eucas1p2c57ccc084cf6736fed01a8a5c0b35fab
X-EPHeader: CA
X-CMS-RootMailID: 20250819131814eucas1p2c57ccc084cf6736fed01a8a5c0b35fab
References: <20250813131007.343402-8-linux.amoon@gmail.com>
	<CGME20250819131814eucas1p2c57ccc084cf6736fed01a8a5c0b35fab@eucas1p2.samsung.com>

> A unified
> exynos4210_tmu_clear_irqs() implementation now replaces the previous
> reliance on SoC-specific functions and hardcoded register mappings.

Well, right now we actually add exynos{4412,5420,5433}_tmu_clear_irqs :)
But those are quite similar except irq_map values, so maybe they can be
unified into one?

Kind regards,
Mateusz Majewski

