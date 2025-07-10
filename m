Return-Path: <linux-kernel+bounces-725367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C7BAFFE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA5543E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45262D3A70;
	Thu, 10 Jul 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2CKFRSu0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A042D130C;
	Thu, 10 Jul 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139657; cv=none; b=RAQgc7w6Mc+r8wT82nS7S8B+tZlS/jsokZASHR3h0XOFEpfZIBH6lEtG2+Osg6hl9fFcFGbUW0aCbmfFZjcwxA9RgykBxevgWlB02w1GOeMj3GRKyni/SPWuso0nbc1hQTRkmw8wnsQvctvwbYJQxPAGFtyNb/wHLWCH++NdF/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139657; c=relaxed/simple;
	bh=/ZLJcwShyR0UNJjWxzrA2qfWgMgVLz6IGN0xsy8PQlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kog800+jov3cni/XxWWndlTnj9YyT1twW1EklTMWvRuId/WJvRZNQahpQGEyH9OdaTUSJ+KEtQHHjsT9rZjpVCMYc01EAwD6MOU+iD6cJur9JGvD/VnSWGg2XhW9Upxmg6X0v2nR8p6Qvok+coXLysTEr7TQgcG+UtN0lrsCNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2CKFRSu0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=pQpm6dtBzU/F8AceyiLgn+Hz9N7iQXKzE8ZIvBelGik=; b=2CKFRSu0GzQRHXUr9+xU8MpduU
	LAYdGhy+1ryBZXMsgkghkUedsp1FFJqEEGsErsPc175ncTWS8V+cnqM0H/aklkyIQClYzEv5DqSFu
	sRcH0nyc8jHhjjXzWkIan/ei0c+9MM1nEbACBMm6TknxQOXW/bC3E6CDCWoPO7179zJmprHVlzopb
	/XduZjD9hdm+LRIKozpcHyjS2y9YnFJqRwntZ7gtJb4gqyzxcKOgwu9UU7iZ8Ry621/aG/Qpo5mVK
	OdGhUUU4pFWyl+kyHPPD7hhovFoCC6dijP+lyqlMlFpoNspV/CUiF0IYEAyQtapWYzVbitgkjU0ZE
	FugU+b5Q==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZnYn-0003fo-27; Thu, 10 Jul 2025 11:27:21 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	conor+dt@kernel.org,
	didi.debian@cknow.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable mipi dsi on rk3568-evb1-v10
Date: Thu, 10 Jul 2025 11:27:12 +0200
Message-ID: <175213961999.1887379.12088810918862744126.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250706113831.330799-1-andyshrk@163.com>
References: <20250706113831.330799-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 06 Jul 2025 19:38:24 +0800, Andy Yan wrote:
> Enable the w552793baa 1080x1920 dsi panel on rk3568 evb1.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable mipi dsi on rk3568-evb1-v10
      commit: 06b29cb849bc0437edd68373a1e8152f0bcd30e7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

