Return-Path: <linux-kernel+bounces-783569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 107A9B32F1F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFFF1B234EF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71501279791;
	Sun, 24 Aug 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vQOOiaOO"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932927935A;
	Sun, 24 Aug 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756032900; cv=none; b=P0cTHfC9FFgbfQmrG4z6EO5E2Q7u3UFwh8UuTJNoKNt2IrJW8sI2GWKEtzkpSvpQwGRGEUPg6cSvmgDlzb0A7lFu1DfOsQiIAsyZlT1CqOC1+5zAlFfu8ji9xeEhIRXf5SK97lgTB0742rtAPBIiZMyhaH+QCOWact0gtWdL0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756032900; c=relaxed/simple;
	bh=EahMqwm7aWWG0jpuYgybMPEOTK3iYg2ADpXAo375HTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8PW+/9bdKUa+D0qNYKDvVU2AxdBM5xqJIc8Tt76MRkU2VFwu/l/d6+959lm55MM4NjRk4mB4Y9YqV21vFHBIvUO+OXnZ0r0OJbCfK54YTITmm6FNe13Kg3X4amuslSVOtefDYaxuBp1uihvX3XxPR0slfSn/uOEF5CxOqgVc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vQOOiaOO; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=XOem+vEqJqafrAcs6wtW5hQ5ZvnSbrk7rrVOvmTnaJI=; b=vQOOiaOOwb83O/FrOxf9jbGkcH
	hyXvtIz0JqlFrz6zasOL3PlJqtBdjLo0pzpJdDNpTOfx2OynNMbR8s0jmtdhC0MuH/Sc8pv57P0ED
	8gIK2RYYvo4s/zuU89ZtgCol7AJQyETm9cTbczc7r0Qe3MyeDq4P88pdeu6rbDIHT3rpVvRJD1a+P
	SM5kuK327VabKqVCEA/CpHOc++3BGbgNMh9/ADeVZSLCEJZ/jkfuyM5QO8fTP0esaNNGN6obP7saa
	ieqbcPzW94cc4pb85cytUE4/ZZXM8W06uAD7PZA1wlvaze6x1OLoJCyYpUpWzI9WWqyeZ+yjSCmUh
	z7Mh+wDQ==;
Received: from [62.245.128.201] (helo=phil.wifi.munich-airport.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq8N6-0005H4-73; Sun, 24 Aug 2025 12:54:48 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: Add HINLINK H66K/H68K
Date: Sun, 24 Aug 2025 12:54:40 +0200
Message-ID: <175603280227.3445205.12980590537074643035.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818100009.170202-1-amadeus@jmu.edu.cn>
References: <20250818100009.170202-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Aug 2025 18:00:05 +0800, Chukun Pan wrote:
> The HINLINK H66K and H68K are development boards with the Rockchip
> RK3568 SoC. These boards are all SoM plus expansion board structures.
> 
> Both boards can be booted from eMMC or SD-card using the
> U-Boot 2025.07 generic-rk3568 target.
> 
> The SoM board has CPU, RAM, eMMC and RK809 PMIC.
> There is no schematic for this part.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: vendor-prefixes: Add HINLINK
      commit: 7d11b8c260ea68ce8f420ad467b04b21ea34b011
[2/4] dt-bindings: arm: rockchip: Add HINLINK H66K / H68K
      commit: 4bef07b79ab1ef7d963eaa2c37948030e418d538
[3/4] arm64: dts: rockchip: Add HINLINK H68K
      commit: 86a504b82f8d0e34f99ab9607712e7942c919fa3
[4/4] arm64: dts: rockchip: Add HINLINK H66K
      commit: bb9ef44f05c9558d58e3c9da141e93af1aa11c1f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

