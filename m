Return-Path: <linux-kernel+bounces-827844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39354B93401
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8278440360
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768292641F9;
	Mon, 22 Sep 2025 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxBdiC86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F722DA0B;
	Mon, 22 Sep 2025 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573588; cv=none; b=YheQt8WksaDLncOk/qa2kpqJGJPaQRacpEBnfx3ene7jpbbddDgZV2CxQ35bs2Euc+UIrvwKxAVQ5Rpwp0iWyt7lxXsim1u4A9BsE++/CTycj0Dl9HX5nlor/xsT/qquLVJD7FJq/L+X21dImz3C8Llm9tNuQbEpr7sJq4HXlJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573588; c=relaxed/simple;
	bh=OX8R40WQ5HfJwHkclKJ5GlUpDaTEdb1/b83kLRNMddQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrkNj6CEXuFlyb65QPNwHbbsy1b74hcjc9bstnBsEuyjXM+hdt5ZJwHDunmZ0pRiZcJxGGfBQt3CBpW+ZnQhfEcOBDZOu0JpGYU/Ad8YKs8yPRczk5GCfd0XJ8pmaHKNivSukC2sjnHjPxGMVAtuM4uTbwtKpOU1XNk3sZgGpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxBdiC86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F755C4CEF5;
	Mon, 22 Sep 2025 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758573587;
	bh=OX8R40WQ5HfJwHkclKJ5GlUpDaTEdb1/b83kLRNMddQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxBdiC86CBjW6F12t+dS9d/oWdtxt0F/+pYhSyLBw9Lw3InOrxNJJ63RJvfFJKjOs
	 lVenwO48aeOBY1qPv+N9bG+GSYaTAOChabkmC8Y71W2t/DG9FjHiIuznG7eKsL8/XN
	 c1XAQyic4lA+k+XrJqI400TLwrPCdSJaLlhacTr2R3Eq9nYQZWUz8w+RBHBk2cEGJj
	 p8KquiYW7Ry6AwG0EG677kae11rFKhehA419PnEkdKYz6Jz1pMT8m7l8J4LXPioNn7
	 RTmqPFaPp+f66Rw+TzcBGFjbDEW2/nqwBHUBzmbrKGC8nkHoGINRoTBYxQGZJYsd1l
	 jPPhHqjEPnwVg==
Date: Mon, 22 Sep 2025 15:39:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Maxime Ripard <mripard@kernel.org>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Simona Vetter <simona@ffwll.ch>, Han Gao <rabenda.cn@gmail.com>,
	linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
	Yao Zi <ziyao@disroot.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>, devicetree@vger.kernel.org,
	Fu Wei <wefu@redhat.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: vendor-prefixes: add verisilicon
Message-ID: <175857358584.1289867.6423910030658494918.robh@kernel.org>
References: <20250921083446.790374-1-uwu@icenowy.me>
 <20250921083446.790374-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921083446.790374-2-uwu@icenowy.me>


On Sun, 21 Sep 2025 16:34:39 +0800, Icenowy Zheng wrote:
> VeriSilicon is a Silicon IP vendor, which is the current owner of
> Vivante series video-related IPs and Hantro series video codec IPs.
> 
> Add a vendor prefix for this company.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
> No changes in v2.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


