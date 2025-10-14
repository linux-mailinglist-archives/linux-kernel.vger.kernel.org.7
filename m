Return-Path: <linux-kernel+bounces-853201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF4BDAE72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 474D3356AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD930DD33;
	Tue, 14 Oct 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eNcuQ3dV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DECA307492;
	Tue, 14 Oct 2025 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465229; cv=none; b=XjVq5nARHpp+ms+itjqDF4fSHZ77QWkud8tpJAX3UbB/Ra0JbnZaoNfyKYcnx8hMlPUxdKhOUbvwGr3Y6SgUu1WRC4K7mmagKucEujeSbqEZcYon//hG+kT9qek1BESZdXdXDwz6tfexqqq5XfjOOCLsTPkPHEDsT2EGJHPGWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465229; c=relaxed/simple;
	bh=eyY3SB2+S2K3KTsLpER3RLBMdd33gY+y/X0SgDTX1qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4p1igv+WYWJyyV72if6Kya8d/pYAHt5opQFZvGa52uaikr8T8ykVWuluobOxxeiQMA1y0Va022R3tZGJaechBP1uQxt0Fyi9JY0mY0SIhJjDgBd9b3Cw3/slMcbSJXP7y0LtCi1/DuIhhC/z1pv5I/vmzm1j/uuHKQAMJgYd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eNcuQ3dV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=CEXyXBBaXpCS7J1Z4/qWotkSCrY52rSuaqy/4kQ0zPU=; b=eNcuQ3dVnxDdMObV2J40Meg4ab
	mGbHUApTr1jA8BqJ+l8IjAO38gVMNivRQIk+2C6VEngc2ARy1TQqt0EPkooPdlW0m8OvO1+DXok4J
	15LUBGpr0e2f8QxgnOZHnGDGDh3VEC+WT49mAV9xYTfvL2Koo4WwWaPoP2y1FrsgjMFK4BJ5FJNFB
	Xalc3BHSeN579v4lpDADus2RJXMo8YMgQEGnNeg2ouN5YQlg35PGrLNrPX8I0o7AGo9bjQ0Ejmksb
	5eZd8e10jaar3zYoyuoczDX975n4XOwor//rNKzCGrb7Y371ZWXE3tmuSboNrx3Fae7Ew6NWF1bT2
	C3rFjz2Q==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8jQA-0001Gj-E2; Tue, 14 Oct 2025 20:06:50 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Diederik de Haas <didi.debian@cknow.org>,
	Tianling Shen <cnsztl@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi R76S
Date: Tue, 14 Oct 2025 20:06:34 +0200
Message-ID: <176046473176.1662867.13956713040601600613.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250927092311.789946-1-cnsztl@gmail.com>
References: <20250927092311.789946-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 27 Sep 2025 17:23:09 +0800, Tianling Shen wrote:
> The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
> device with two 2.5G, designed and developed by FriendlyElec.
> 
> Add devicetree binding documentation for the FriendlyElec NanoPi R76S
> board.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi R76S
      commit: 75e700fa357876bc4f501f585c2cc335acc8c237
[2/2] arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R76S
      commit: 7fee88882704a5ed7657f467ecb44e39b20f42aa

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

