Return-Path: <linux-kernel+bounces-606080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D03A8AA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 23:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A5E189EBBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BCC25D1FF;
	Tue, 15 Apr 2025 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8GdjGKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDF2571B5;
	Tue, 15 Apr 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753711; cv=none; b=shoE/zm1MZHu7Qnp4imkw8Puvjlc+s/vYg0y/CftFF4L7nrIcj6xCiZgvVjtUdroqHVTdFePTGn8mjlZIiAFxa2qq0UOQFEDgEOieSdgGmaOcQi+aKRd4T9GEbk3uXBmkPITnJMa0adXtMF5fZfRWBFNIdt8qvAeo1a4EmU5FoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753711; c=relaxed/simple;
	bh=vg2ZoJT5wdMRs33As6ZuOrUTti2euO5Vt02+P+ipmcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnoHuzUzXT0CMaUMhi43SfYKPncTH1ph5xhT8RnQQ3bymUGk9iTP81yrtGfa4hTo9HmlSU6/5aFVA2Y9+Gzlqz/KHhQI3hBJyOXhI6snRnGF1eu+8eWpV0y7PAcaWurAlgHIv9RmxLZ/GE+rAbq9+jY53cssfkMtThUd4e+gbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8GdjGKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054FEC4CEE7;
	Tue, 15 Apr 2025 21:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753711;
	bh=vg2ZoJT5wdMRs33As6ZuOrUTti2euO5Vt02+P+ipmcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8GdjGKy8ZSA0v7ioClITQo+70LyAyHE/hPTUr8sUTgN0bPi2N7vlhH+bIRaebdM+
	 Jkcpyk/6LQxuNwAUg/H3kcmA7IeObDR59ofbmWtYndD1lNJ/owWppsmf+iazMcV87d
	 9+94WNGfkfdwxJSFHXuVxnfQRSvLTtNds+FDN6MYe9QzeiMGsfwE9NexLVXB1o1I7a
	 UmIzyk0tb8bTd/2ulx/YXRI5eJF9tvuo96vAXJScQ84q5CL0EZu3qU8tHdgAn/Q4zw
	 1KD4Kp5ORxBqLkLApkDgWCkJ6zJSDtpnjkfWetB2tUTVWn49YocEFH5KUDeBjI/NKX
	 DzlnsJ6e1Ia0A==
Date: Tue, 15 Apr 2025 16:48:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-tegra@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: Document Pegatron
 Chagall fuel gauge
Message-ID: <174475370881.885498.12340209522588997087.robh@kernel.org>
References: <20250413111033.11408-1-clamor95@gmail.com>
 <20250413111033.11408-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413111033.11408-3-clamor95@gmail.com>


On Sun, 13 Apr 2025 14:10:31 +0300, Svyatoslav Ryhel wrote:
> Add binding for Pegatron Chagall tablets battery monitor.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../power/supply/pegatron,chagall-ec.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


