Return-Path: <linux-kernel+bounces-783464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8FB32DE9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C261895641
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 07:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEB254854;
	Sun, 24 Aug 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wOMk7j5g"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61E24EAA7;
	Sun, 24 Aug 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019288; cv=none; b=CWipBwCx7iGEQTgwd+fr+50u8PWrEMKjNbfcQCAePpK+DCmieTyJoEpBNyESmjMc2Le9PAYRXrce1kAEoozUYwhmEjQW4Ds2plyU5HPsPpGL4HnG3R2/Ey2dmKEaAj5bwFfI66WyegmdooX4I0rHWJBmxSwYT0dkZyru3PcTtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019288; c=relaxed/simple;
	bh=DeY+v9dAJk+9rdlzjjzIUnzuF8nuQwzEt/TBbGMMlwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1fQrZy5gFm2Sig17r5tD0EuyqJTZJiSA77AOgcMSTouKjZZoI+Jh1lkBRQcPMTe9tKPx0w90plLX4NOGuEbWJkvB/AKkjKbpccag4Ep1AC+4KYa4rakxf605MG9AYPN2AA4Ahb+hVDm9drSFLy7dn9veMHPbvkxqEegbQIfOoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wOMk7j5g; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=fhs3hXc2N1i8i+aeYyxkNxdwP44WZuEKF8sSvnZTP4Q=; b=wOMk7j5gS72n5mZDY1q9JceRRy
	ASZKPH10REBLyM0d5rrAOStr5P7Fn2eVONJGBIMFSWpv5qXgik3kt4IWCyuSuKfE0uzqbWrtaresQ
	H0Nhs6g66YNIaqe40B9tNpZU8usMhlUoO+3Pjw2NHCyKwHaYJfZS3qBEFWDM0X7wQKlpe0oJH7EXv
	7t8uUPGf4U1T0N2AxNcEM1cXk5pAiZqLxyi99CK/9MimGFhCQftpR/NxJGXdcDe+E7kCfRUuyZKPe
	CVFh822XgaZhmGPr1tSm1hOfLN+SWJkTnnxxFdcZUlG0pFWOt2hET68oCHMU4jSbEjL2508JPNpJv
	EIJl4nMQ==;
Received: from [212.111.254.164] (helo=phil.aerolan.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq4pa-0002Oo-Fc; Sun, 24 Aug 2025 09:07:58 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] rockchip: Add power controller support for RK3528
Date: Sun, 24 Aug 2025 09:07:49 +0200
Message-ID: <175601920179.3425909.10553643582177045898.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250821211843.3051349-1-jonas@kwiboo.se>
References: <20250821211843.3051349-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Aug 2025 21:18:40 +0000, Jonas Karlman wrote:
> The Rockchip RK3528 support multiple power domains, one PD_GPU that can
> fully be powered down, and other that can be idle requested.
> 
> Vendor kernel flag all power domains on RK3528 as always-on, this takes
> a different route and instead tries to describe all devices power-domain
> in the device tree, even for controllers with unsupported runtime status.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable more power domains for RK3528
      commit: 178879625f0f10ff708728087d91a5fe79990ce2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

