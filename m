Return-Path: <linux-kernel+bounces-768480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400CB2617E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB4A1881EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F02F39B5;
	Thu, 14 Aug 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="r2nCGCuy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20200287241
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164795; cv=none; b=OC3FkH89DM9rOfmPSu6AlNG8dssKbe8ebhqmfAM/XoG6ZHWza3ncZMTJSpMCytVs+vY0Yg3/4zhfnh7vvjYi+oKk+wGV8veHXeGWKKQYAhZNJB/W3KB5sN0HvZWLQWrKDqT+ioNozwxCnDd67FQ20OQTouZ2exAy9RnKDTc4eCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164795; c=relaxed/simple;
	bh=eVtyipk3Q1uSjXEYVMgQCVhmsYKNueJ4i+Ilgnbq2DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axtn0iFkYBYxllmB2fYQGodg84dwaV678fNuCo9TZrAPQFPG8BDehdygf+L1l/Nq5ZW8+LX+qIgpl7pdV2UxvvuYPRBCOeXrweODj50oSQrn0pctzZxfvbeiJpkYqFPRFCIwgaA33tT5b8O7LCPJ3ro33IzY8AqMQqJBa7Tbib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=r2nCGCuy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=05/vse8ASg1P0/ndE2WSZb4gOfA6W4MnqPW426TsnGA=; b=r2nCGCuyVC/DLCAypokD2yGjuf
	uoMbh4ejTqfrC1NXM7+9nH4NcB6kP7qhVOza6dAii9HF3fygtAt3YYOwmbs7nXgvGsRK4AOoYXlle
	SGxyG+07r6Uev6efb2C/vcujg22EIaaqDrhO7y44v8CSLwTNlr8SvcH9E9gWtJvWEAw+vp8kt6XDk
	TpQX2Cuh8sac73oJJAliw2ls97feDEq+cEct2y4B36jHSgqOfkk8kpxcB26GAY7b38HgUwuqGH1ki
	ilcjyr93XUHOYPJNdokZslNyLI/Hf8Rdua39dFoeoZg1T0zcCIIb48dHgLtZPeGo+erQ1RV1RBuxZ
	CixnDSCA==;
Received: from i53875b38.versanet.de ([83.135.91.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1umUXD-0002c8-8Z; Thu, 14 Aug 2025 11:46:11 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rudi Heitbaum <rudi@heitbaum.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] drm/rockchip: cdn-dp: select bridge for cdp-dp
Date: Thu, 14 Aug 2025 11:46:07 +0200
Message-ID: <175516475519.1500001.13265929847217022418.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <aJrlUzV1u4i65NRe@8eba3d7b3083>
References: <aJrlUzV1u4i65NRe@8eba3d7b3083>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 12 Aug 2025 06:55:15 +0000, Rudi Heitbaum wrote:
> Select drm bridge connector when building cdp-dp.
> This was missed in previous commit causing build failure.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: select bridge for cdp-dp
      commit: ea177a1b1efc6e42e73ee4a17581842cd254e006

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

