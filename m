Return-Path: <linux-kernel+bounces-756041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39672B1AF0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D3916D822
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED21C8632;
	Tue,  5 Aug 2025 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar9ji4xR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1A42A82;
	Tue,  5 Aug 2025 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377287; cv=none; b=g55mQkyI2d57GEm1cSnCYJ+WxAwfWlAh0VgCjesd1iIonEH7X1R+fItkDLnP/OAXQ0arhmNla156hRO2SGCU6OnqryNoQIFDa7dGn1A3XZWk24kPQs/H84CPB+gKCke424dxXE4VqNCNY52Lk8SwqIAHN+/I41hi4peNI5/MT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377287; c=relaxed/simple;
	bh=JC1N8+EDHFSvpQmSWYP4IQBCKd4LuqodETgoH4R7NJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEqyVJ39Zvn8y993Yxk1itvk605WuNr2rOlVzQBWfNXz5vPCkuMTvMHgFSb+BPgppXZmIdo/xHZq/32rzQveVw5UQ8LhaaH5+0qW3XVd/KeJQ88UwRVlD7mkQSmVMVrnlcfUGmeNUz7jePTg4C9tw9903mBJNS5hf/9MK/aKQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar9ji4xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CB2C4CEF4;
	Tue,  5 Aug 2025 07:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754377287;
	bh=JC1N8+EDHFSvpQmSWYP4IQBCKd4LuqodETgoH4R7NJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ar9ji4xRtlUqcDAwsHuBWUNlxjyu681opyVGK5UyqWJZhuLYNNNBsQ+/ZN2+elZLe
	 aZtUhbs2A8YMj77XDSJ3dV+0Ry61v9NCfdH+dlFAlcbXWkaPEOkBO4Ol5nR0TYqat5
	 MQORFDAutzwQv1tfuRxqGAAoG4j2dScNl8wFKgsuia2wG94uOmVckNYPsS32bfV8Nz
	 lV1zcYh2lV5c5Ns/T6AObeT7LwnDHO2y7qdXGvkNFsho5STMSi83UjUK/3+wFUOPCf
	 bmmLMB17PNGOUVoevocn+MaFmfgNcI2LYkAYRd5tNkyH9KF8GJAuuFKIST6frG0DRM
	 APQ1fABVfbDCw==
Date: Tue, 5 Aug 2025 09:01:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/7] dt-bindings: reset: imx8ulp: add SIM LPAV reset ID
 definitions
Message-ID: <20250805-efficient-amigurumi-kingfisher-ffdb56@kuoka>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
 <20250804155407.285353-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804155407.285353-2-laurentiumihalcea111@gmail.com>

On Mon, Aug 04, 2025 at 11:54:01AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add ID definitions for i.MX8ULP's SIM LPAV reset lines.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../dt-bindings/reset/imx8ulp-reset-sim-lpav.h   | 16 ++++++++++++++++

This belongs to the bindings patch.

Also, use proper filename - compatible.

Best regards,
Krzysztof


