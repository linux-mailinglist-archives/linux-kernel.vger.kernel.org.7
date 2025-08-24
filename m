Return-Path: <linux-kernel+bounces-783462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E2B32DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F75200EC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 07:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61CF2472A3;
	Sun, 24 Aug 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="e3Ni8Yv3"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E72239E7D;
	Sun, 24 Aug 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019285; cv=none; b=NeO1bfHTih4uL8U9e1VMNhYnMjH+qpILrfFwxmlLQH5u+I8ZNk+mRJINJ+NnZQFJ5IM9jWjaU8zMuQ8EJPhVJYF6EbaQ0yMkGrfCPSiT9bkH5zmWSAsT62VHWi6a1TnY2luA6DC71QNPNr1VwGXiiRJgdiJ5Vy2phmwYBmuP6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019285; c=relaxed/simple;
	bh=Go2pnMX2vbfCzxEU4LjuMckRSvbYxq+rc4TPUu3ZDPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akffsWWBnU3q9OU4UY8g4PL5q/X7LxloM82arvoVbgvfV4Mk494n5lJ1mIfnfmQVsOzvyw29a3GiujegSYHEhv3l1Lg3kZHZfXq7cXMB0t6bSEuMkY/YvpojiuI/NW02AtCMHd1YnApfxkgpWjrvhbO8prc+ny3Jl+caFu9l60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=e3Ni8Yv3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=mLxvtDPBJ+DI+btoXw57zzh/p/fTjyv4BupQFMuDEV4=; b=e3Ni8Yv3hNX8eh4IH1lsbkCSMZ
	bHTqkY19CememDhYRbGc5/XuF2F7v0q8fsMIG2m9nprnKc1CvvvsM91iTeNAUYWgQSDB0v8gHKHQJ
	TwWyUkOmPVHm1/TNwPMpUadUojJGscKVxmmenhS+N95fYE9C/CnqJSxGwraUPJiDk3Q93s7r3kRWV
	/vRWeOUf1edWZdIhxr0goumI4mhf3S35ZHn35dK58fVgqq+hpVMr0VFPljWD8LgXanpr/mdPJfwrd
	T+rUt63iBSnFMUoav1No9cryAMYIOj3eEKv22cy+edwB1n+n8vQKqy7/a6J/pECgFZnVASxGkYtPQ
	/EZGkLXQ==;
Received: from [212.111.254.164] (helo=phil.aerolan.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq4pb-0002Oo-7b; Sun, 24 Aug 2025 09:07:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ondrej Jirman <megi@xff.cz>,
	Maud Spierings <maud_spierings@hotmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: rockchip: Improvements for rk3588-orangepi-5 and friends
Date: Sun, 24 Aug 2025 09:07:52 +0200
Message-ID: <175601920177.3425909.16087071890772074538.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
References: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 23 Aug 2025 14:43:49 +0200, Maud Spierings wrote:
> Fix the headphone detection logic on the orangepi 5 plus.
> Enable the HDMI receiver on the orangepi 5 plus.
> Enable the NPU on all orangepi 5 boards.
> 
> 

Applied, thanks!

[1/3] arm64: dts: rockchip: Fix the headphone detection on the orangepi 5 plus
      commit: 8976583832579fe7e450034d6143d74d9f8c8608
[2/3] arm64: dts: rockchip: Enable HDMI receiver on orangepi 5 plus
      commit: ccc7f16ea2e33366f7b7005daad81e316f8cb6e4
[3/3] arm64: dts: rockchip: Enable the NPU on the orangepi 5 boards
      commit: 3dc7ba3548acbfb657614db4ca70d9878bdfca23

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

