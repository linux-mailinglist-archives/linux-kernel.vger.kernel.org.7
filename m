Return-Path: <linux-kernel+bounces-722317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66DAFD7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3291C2052C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC42253A1;
	Tue,  8 Jul 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4N5WICr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384A224D7;
	Tue,  8 Jul 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005186; cv=none; b=C/k7mf6AiFMC9VfwEh0yDREbsqB/ZpsAxqeSbvq5SLv4MLnNQrMLdcwmMaaIICvg2uCqm4cJd+US4Ia2sfJ7mepNx8+PUCMKm9nS6D5F+mjxaUPLM5aPt4/NUEs5HdLMMIvb9CGet/wIe3EzZqToTyeydHQffyYzpByxvXKa0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005186; c=relaxed/simple;
	bh=HDLqHrKZ1e4Ds5mIXoKkXDCqyY7kRwjcE9DFq6MMAn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwgqHNYGXD6LjW0ug/Nw/iT1Ag/jrTJyYEgGKM7kmqIbNXEV7IiZQY6Lf8bnrm4fOkYOjkDWVlSMNXyskvpxkwCOmMt7wuNiS1em127sPqvzl17GK83/os87cV1zgD5bi34p0cidZ+s3Lsdet/mEWuWnHC/A7rP4uu7Ev32eSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4N5WICr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F494C4CEED;
	Tue,  8 Jul 2025 20:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752005186;
	bh=HDLqHrKZ1e4Ds5mIXoKkXDCqyY7kRwjcE9DFq6MMAn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4N5WICrmD6zSglt9NfiMB8vGGcYz+8jPoBYBSGZZASLbORLSJDj8OJzZUlOSSyBb
	 NG1/gudwdTanb53TJTrol3rriN3nGKwhu2X0yqBlblsbVq9M4a9gbcPO0XtTWmTqub
	 GXD517dKtNBixH3zqsm/juSs6ut5tOqKIYiRCHWr/sW04jEM2RvzW2GTYU80Iytfd2
	 7KmwiMseUVP4ROtQUU8T1c8SV40Fd/Tp7QUCkfHuS19gpuVpRddMT+DV+KQzAXRGLL
	 tBg0+9fBh6yXeipd7pnPO7Yoh/IFYEfwrl1a8iSoXs2UBTgzNOjqpY1d2pp5tId4MV
	 gQugYxuETyzwQ==
Date: Tue, 8 Jul 2025 15:06:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andy.yan@rock-chips.com, krzk+dt@kernel.org, hjc@rock-chips.com,
	linux-arm-kernel@lists.infradead.org, andyshrk@163.com,
	tzimmermann@suse.de, quic_jesszhan@quicinc.com,
	devicetree@vger.kernel.org, neil.armstrong@linaro.org,
	linux-rockchip@lists.infradead.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	nicolas.frattaroli@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
Subject: Re: [PATCH 07/13] dt-bindings: soc: rockchip: add rk3576 mipi dcphy
 syscon
Message-ID: <175200518482.886634.10939442043560095261.robh@kernel.org>
References: <20250707164906.1445288-1-heiko@sntech.de>
 <20250707164906.1445288-8-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707164906.1445288-8-heiko@sntech.de>


On Mon, 07 Jul 2025 18:49:00 +0200, Heiko Stuebner wrote:
> RK3576 CSI and DSI support requires the GRF for its DC-PHY.
> The "general register files" provide additional setting-bits
> outside the regular ip-block reg-space.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


