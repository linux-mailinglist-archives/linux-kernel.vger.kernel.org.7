Return-Path: <linux-kernel+bounces-722117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0C7AFD585
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF599567CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA202E613E;
	Tue,  8 Jul 2025 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Fn6XetXe"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6122126E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996143; cv=none; b=Y+ci662AqJHm8Tya/iJjHGNpwc3j54t6Neryw027Usv6C78Vv0zP/0XtpcJ0lm3wQLSRUQJCHMuHSXaUNLakChWvtP6/eyaeztToxRXpVy1hDnN2icxHa9/1qfSHBsx+7ls+sRkiwwDDuWxhqLqIAZ6PNprEPJNjcB2TbYGMwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996143; c=relaxed/simple;
	bh=glE/p4V/LIn+h2/Mv6gcZPBjpwjc4JhtzaZHQR/VPRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDmzvqAej5LLk/IGKMX/7DQd+6IhvX/jIInZP/o89YZc8udQ952l+aihyk9zJZ4PVa/vr2nOSADwfYh0njTjJpr4jdgHqL1fREcnVkxLU1jmvPUN68OaZuYhEUuBl4MEEs5+klpFEawph+NSzW2K8vBIm+yzLWxbdszLV+ZU2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Fn6XetXe; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=9oWcLDoMCvEUhMjZGQXzq2GF59iQ6vNkEPntVHdOxp0=; b=Fn6XetXezplB/+ZprpRXlEgAQZ
	nU11Mdm+85LKQ8BPMBLxR7FCz5e6J0ZQzyqgV/rMzR37kVeZhp60UoKISwtDFQDOETctFYomjW9Gj
	qq1tGPXq7uhOxsWa8cKz6qLFLZzEtU1Yr69OVebDLdzvj6jG0arArRVwprsC4MDUebdrmfwVUfM4d
	mZQ4cqmxjamPmPmK8yEAtjF6RpDu/wWcNzVMuEWi66Und3UBG9y5ebiBiWTdOiAhHMuEugrxWJe4k
	/nilHLwDGmm9zkJh4f6adFhb43ANEspLMRXp6txQ+qLW456qseWnN/fRRSKvgtDwcRqbxg4z5rPBS
	GPQR5VJQ==;
Received: from i53875a8d.versanet.de ([83.135.90.141] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZCE4-0005cC-TX; Tue, 08 Jul 2025 19:35:28 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	hjc@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	daniel@fooishbar.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568
Date: Tue,  8 Jul 2025 19:35:12 +0200
Message-ID: <175199006061.1731917.645367019907326857.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421102156.424480-1-andyshrk@163.com>
References: <20250421102156.424480-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 21 Apr 2025 18:21:54 +0800, Andy Yan wrote:
> The all video ports of rk3568/rk3588 share the same OVL_LAYER_SEL
> and OVL_PORT_SEL registers, and the configuration of these two registers
> can be set to take effect when the vsync signal arrives at a certain Video
> Port.
> 
> If two threads for two display output choose to update these two registers
> simultaneously to meet their own plane adjustment requirements(change plane
> zpos or switch plane from one crtc to another), then no matter which Video
> Port'svsync signal we choose to follow for these two registers, the display
> output of the other Video Port will be abnormal.
> This is because the configuration of this Video Port does not take
> effect at the right time (its configuration should take effect when its
> VSYNC signal arrives).
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: vop2: Fix the update of LAYER/PORT select registers when there are multi display output on rk3588/rk3568
      commit: 3e89a8c6835476aa782da80585dee9ddae651eea

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

