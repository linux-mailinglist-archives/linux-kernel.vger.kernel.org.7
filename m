Return-Path: <linux-kernel+bounces-725365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD5AFFE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53186174990
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5982C17A1;
	Thu, 10 Jul 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1i6ohUuS"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28F2BE626;
	Thu, 10 Jul 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139652; cv=none; b=DTGeOGORzuJGw0jC0hv47JQMKgKC2tRpSMmQ/gLqbs9yE6p0QC2dtUkTF+dOr9jEhT5vmGw/KXtLbtIPItZx5qwLZ7mWvu2j33f1elTgtoukqtJTu8sAYG6c+FG2CsUlXsa1qgMcEOUakF24yew/SKoZBgtn3HiaEusARIHQxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139652; c=relaxed/simple;
	bh=I9haYi3jsGOAZI9QzQ81Gg2dbC39MpG8x+Yrcbybt1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKLLyldx2IVkZRB5CqA5dOEvRwQSkqBs1Aq4TEWqFC1s/t01FQ/3qotI2Bz3VviavZ12wr8Tx+gKsriom/L8ZuLbnaiT6saxwsehdSt0TyPjFGVO7eqkd16hB1aJxoR7grPVtJmUoyvcb/t56b/J+bN8Q+W5gCsIoxLIh0PB/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1i6ohUuS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=LEApVhEKro4cIy4i7/jFiHyzpWKgeh4lGRXILH8B27o=; b=1i6ohUuSQGLB1RQDLcQ8aX7slN
	rCtl4HE1Jmt8moItY8qE6sUXz3ZL7qkzuIK5rpm2alSvSjWRYxE/zlYcJCo0JM1t5W4LNJXa6pRzE
	7FYMkO5jeh22avOq5zmtkk1cFjLT/nqkaTcUY4XxHWUm/fTexFMkx97fUnT3HbL4eieamno6JUARX
	ZWlM9AKxrsvhn+JRz0CFWJelYWuev1CKNvyGWjF4+JPxZ3hdwjE3AaDmg9nHDC6wP62clKFreocWU
	8c20PytHV4arBvD/eqNTPL0mlgklxzuexFr6SSVA8O7dnL34XGlMSuDct78uB7AIUaomY5w16PJJH
	j2t4UO5Q==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZnYn-0003fo-DT; Thu, 10 Jul 2025 11:27:21 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Stephen Chen <stephen@radxa.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: Add UFS support on the ROCK 4D
Date: Thu, 10 Jul 2025 11:27:13 +0200
Message-ID: <175213961996.1887379.8837261670064168471.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708155010.401446-1-detlev.casanova@collabora.com>
References: <20250708155010.401446-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 08 Jul 2025 11:50:10 -0400, Detlev Casanova wrote:
> This device supports removable UFS chips, add support for it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add UFS support on the ROCK 4D
      commit: 00abee2b18342d6c2f6f37225682fa7ca0d33142

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

