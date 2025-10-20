Return-Path: <linux-kernel+bounces-861214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCABF2157
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5131818C01B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE6264612;
	Mon, 20 Oct 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bRn64KPi"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A71E1DE5;
	Mon, 20 Oct 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973912; cv=none; b=dbaKBLrVjY+7VZwTY2Ju3AERvjxpTXjsoUpwng2ahEArnTMtw/j2lI9oAi7D5aXAfaEsiEDy5cpAS90FNxpLgW1H0x0wudEs9uO/9IJpnwh7EhJCSdkWPjtC6zjGPR4DAnSlpYz1QAv6rBIXeREdfaaDhI1nmhPKHW0snqmBRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973912; c=relaxed/simple;
	bh=mVTKu/jJ5UZwRggSgWWcaWaPX805fKAyQU7f/+FPJnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9wcCT+FOfpIK9kjL0cMJzjV+isCaqVl5k8AlWbImbYRRAi1psVQjxqBKHP+k3XaoXSMTgsg+BPU6M+n1SQSEt93qInhkIASkjF5wXfSerBArWdeXrP5c1A7BTLY5mfx4jLOxY6teqr94lffuvDOBHTYAhNxHDDYIfAcEfoqgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bRn64KPi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=CqOPWe4rfsEXq/Axf6YfN7t0vCSfPE7s8YtPOxax4AI=; b=bRn64KPiWoQCVOWet6ScvQRY9l
	lD4nAkaGrSMWPtzDY5TPGUVSaH+dG6EG48t6Ose6jhmC+sXSmnsBLtz5PqNGAQWqRtmB1p6B+sSUh
	wB4PXg/iGxxAV0Hf24/DWtqBxjsj4U3763uMJFtsgVErGbQxtt/kI5FLe9RxRtX/CmEuIHhzC2zJ3
	yIF6LMYioHHVf7FmOaA3LdKLFTLj5nkQ69HmjKGPQFdYq/Dy9GT/5HB1OuDoFVFekj9NPdxHiKRof
	1V2PrHpTzYht81R4sGXIRryfvMcjyCKNr1M0xX3ZmARsRVM4dZ9ToYbrYWmoziVbqGu/ElenlNEox
	BVN370cg==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vArka-0002qD-Cy; Mon, 20 Oct 2025 17:24:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jbx6244@gmail.com,
	andrew@lunn.ch,
	Liangbin Lian <jjm2473@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
Date: Mon, 20 Oct 2025 17:24:42 +0200
Message-ID: <176097387773.44471.5625428430704805786.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251014051226.64255-1-jjm2473@gmail.com>
References: <20251014051226.64255-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Oct 2025 13:12:23 +0800, Liangbin Lian wrote:
> LinkEase EasePi R1 [1] is a high-performance mini router.
> 
> Specification:
> - Rockchip RK3568
> - 2GB/4GB LPDDR4 RAM
> - 16GB on-board eMMC
> - 1x M.2 key for 2280 NVMe (PCIe 3.0)
> - 1x USB 3.0 Type-A
> - 1x USB 2.0 Type-C (for USB flashing)
> - 2x 1000 Base-T (native, RTL8211F)
> - 2x 2500 Base-T (PCIe, RTL8125B)
> - 1x HDMI 2.0 Output
> - 12v DC Jack
> - 1x Power key connected to PMIC
> - 2x LEDs (one static power supplied, one GPIO controlled)
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: vendor-prefixes: Document LinkEase
      commit: 9e38dc1abce6fb776d4b6731ccc64ad25e525d39
[2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
      commit: fc3cd4021eeecb9adbe030b8cf32587126775d8e
[3/3] arm64: dts: rockchip: add LinkEase EasePi R1
      commit: deaefeaf3df433d50935b9a85076041040f06d74

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

