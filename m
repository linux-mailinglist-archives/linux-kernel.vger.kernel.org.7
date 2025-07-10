Return-Path: <linux-kernel+bounces-725361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF34AFFE10
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C347B1C4119B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7129C33C;
	Thu, 10 Jul 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gptBhNBp"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B701298CBE;
	Thu, 10 Jul 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139649; cv=none; b=lIcYyJ5v80oJB7mlRX9qgVZGDDJcHdhPnOBwG867q8tDRLQ5Xy2FNYkrQGbdAjV015X5RgYD4t3zrPRlOAt6h3UCw+JuAhWq1wxEHpWJKZUpXFl65xg0O+DP826UwgqpfeKyFVIQOheRpfduHqqyjGh/UWHK17mrMRW4zpFvko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139649; c=relaxed/simple;
	bh=nwRcNBiLq7/VyGtNA22O9nBdqvdgeyNCKT8SriXFI3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD+KeyxoiJE5PL8kdUgIz90nJAyogFiog4fx+Bl+e0v56o2jB9rCoWNh+nNtubV9NTIC/Wn0YPoXBSMZRhNhEN9HU1HgwjqA3PtIPlNCQFFR99pheHey1hf7v3QFsCxrxij+cB5GKffEw6Bg6QqdKieYfNlP3wqDXnsA04es3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gptBhNBp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=B9sgA9KEUZfto5gbFbrYuGKWO4F6LlXYQzl0p1sXfYE=; b=gptBhNBpJmVaIz2i3RyQA2Sdqm
	9z1dt1+GlDuecoh6aea9a7nL1mYX3QoxzV8KXqPlkcKXoW4egYxqX9+YlxXlKMBUZstSZW3cyRex4
	V0VtuWnFFLeixCFe7rI7VAdS5JR9s2U7awT+SSiWkzgqRAq7+y1ByBOmdirwoMXbHd4IdfQIw5UAU
	D51JQwC6QqPwIAJL4Alz4bsr2b45qDvqPSBCDlZf34lqwRXkvJpXGy8+E9mnlnZpG0I23Bb5OEqI6
	Hc/ROxtmwJyS9urc1zTNPFBvtlgwNPgUbrYXDU1anyKt0E04X5uwCgo0tJcdWV+Yft63g5w1+L1MO
	H2DWl64w==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZnYo-0003fo-5H; Thu, 10 Jul 2025 11:27:22 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ROCK 4D DT additions: regulators, usb, rfkill
Date: Thu, 10 Jul 2025 11:27:15 +0200
Message-ID: <175213962001.1887379.15984995159169129964.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250630-rock4d-reg-usb-wifi-v1-0-1057f412d98c@collabora.com>
References: <20250630-rock4d-reg-usb-wifi-v1-0-1057f412d98c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 30 Jun 2025 17:36:32 +0200, Nicolas Frattaroli wrote:
> Turns out the ROCK 4D DT in mainline right now is neither accurate nor
> complete.
> 
> These changes should quell the fires a little, since at least we now get
> two additional working USB ports, plus the Wi-Fi chip shows up (even if
> it doesn't have a driver right now).
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: adjust dcin regulator on ROCK 4D
      commit: fc276de7b63efc92f301d5b78d5000c1715c4313
[2/3] arm64: dts: rockchip: complete USB nodes on ROCK 4D
      commit: 37e557333b66f036a5638035765219531327025c
[3/3] arm64: dts: rockchip: theoretically enable Wi-Fi on ROCK 4D
      commit: 0e72c9aba2029f66dd92ad5f2cb68c44e1d910de

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

