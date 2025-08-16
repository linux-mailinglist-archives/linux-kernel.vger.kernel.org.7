Return-Path: <linux-kernel+bounces-772298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9F8B290FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 01:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA11C5A60C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 23:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A670246BA5;
	Sat, 16 Aug 2025 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmQ/pG7+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9827453;
	Sat, 16 Aug 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755387642; cv=none; b=d9LrUNkeAuUpgnSoU9uNyb+/5tHzK0B6BawjzjbAjcr8c5Iyf1t+tSXEG4ZAjfGzS0X4uI8QssTPvTYpgC94l5yJkduYtq4VVaXVvb62Uc3Hoc9iG+vcXdb/kWAcVUuykso8gNcq+2xKNVKe1QPRst/7u6VyDYkAdsKmALq8l4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755387642; c=relaxed/simple;
	bh=ckJymq/i3D1MkEmQ6AWtMEkQD94nmnHooah8eYxorOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTPunJS5PubwRrM5OaZh/J5hA3Bd99zecMbOhsyVSmmbM4xKW6d7TkdT5n2MwzDxHBGu80HTsWi5p42bi+ROSqj654ml0v2h1PwLGQn0Ibi9JVXxxQNlsp6DaXg3wzJomOpESt45jQmWolOzdt1VzdkwEGjNxMaDVVz8slA8fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmQ/pG7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBE0C4CEEF;
	Sat, 16 Aug 2025 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755387641;
	bh=ckJymq/i3D1MkEmQ6AWtMEkQD94nmnHooah8eYxorOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmQ/pG7+7LZIToInyHvBssDG18YQizWD5E/PtLWtCnTesyY1d7b0sciHOQQ+j0HJP
	 hm1y8VU79OZ9kQGzVLW9vE/ZZzPghl5Go5Vlj034273Rsi0y1ClwqRg12fHDEuZAVy
	 x+eekyH5Wvox9Z2t0XC+Gte53ulwVatFwFfIuodIC1ofVPjLgPGTrEGoE7lBVansfW
	 KUM8Pvwvj6rmmb0gTpt0Q8NduKR1hC5KUv3kY8rs1CWwtsX62rIF4S/USd9R1Ax6/c
	 GELmSwFTb702jIdUJPEKd1/UP1Iw4tFWbX2vsNbFGDRIx/SUnoZkyr2OSKGRApMFFB
	 EpR13QJmMYPoA==
Date: Sat, 16 Aug 2025 16:40:39 -0700
From: Drew Fustini <fustini@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Initial thermal management for Lichee Pi 4A board
Message-ID: <aKEW99MyMU58GCwb@x1>
References: <20250816093209.2600355-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816093209.2600355-1-uwu@icenowy.me>

On Sat, Aug 16, 2025 at 05:32:06PM +0800, Icenowy Zheng wrote:
> The SoM+Dock design of Lichee Pi 4A is quite bad at dissipating heat, so
> active cooling is quite important for it.
> 
> This patchset tries to do some initial active cooling for it, by
> utilizing software PWM to drive the fan.
> 
> Ths 1st patch adds PVT temperature coefficients, as seen in the SoC
> manual and BSP 6.6 kernel device trees.
> 
> The 2nd patch adds thermal zone information for the 2 thermal sensors in
> the PVT block.
> 
> The 3rd patch adds soft PWM + PWM fan, and makes the fan an active
> cooling device of the CPU thermal zone. 
> 
> Icenowy Zheng (3):
>   riscv: dts: thead: th1520: add coefficients to the PVT node
>   riscv: dts: thead: th1520: add initial thermal zones
>   riscv: dts: thead: th1520: add soft PWM fan for Lichee Pi 4A
> 
>  .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 53 +++++++++++++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi         | 29 ++++++++++
>  2 files changed, 82 insertions(+)
> 
> -- 
> 2.50.1
> 

I just tested this on top of:
[PATCH v3 0/4] clk: thead: Changes to TH1520 clock driver for disp
[PATCH v2 0/2] clk: thead: th1520-ap: allow gate cascade and fix padctrl0

The fan is spinning when system boots at expected. That is nice that
GPIO can be used until the PWM controller driver is ready. hwmon0 shows
both temp inputs holding steady at 43.3 C and 44.4 C.

Thanks,
Drew


