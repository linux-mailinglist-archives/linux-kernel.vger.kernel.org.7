Return-Path: <linux-kernel+bounces-731707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDCB05878
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AEF3A712F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D92D839E;
	Tue, 15 Jul 2025 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mrZIiswg"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBB24167B;
	Tue, 15 Jul 2025 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577744; cv=none; b=KWk3GIdGZ50HLVngrSpabEdlgDPTAykBwqwno8+nrW78AlnHb/erM9ddjnnoWjfIdwQ6wZ/M24YeVhFFgeuYKA3WigkXn2Kh3gRLY3Y58IzYFtXDCdPdV5dzKWTx2YJbSeHa/lnIcy/nw/5i6cxgBja+cTSdrIuwPnBSLY2ZUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577744; c=relaxed/simple;
	bh=Puq8gEhINsFq5wCvso9CbbNwmF8lopI0G3VaauPP3es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2FZKz5Qd5TNqNCgng7cQz2tuxKohKLHuupwWVr1XbOdyUNdFgZlHUt7g2+yrlzLmKf5O+a1UeBANd7XE8NMePpMSnOeZUj07oEU+4HMEvekU1MuxY6I4emMppB8JRinSmXcMREtxPyc1EzA8sekD17nYIDlSMpBHjkDMPRuTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mrZIiswg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=PECLFrwCRzXjctoZGg6pPonND+ApxV55wwv45R2Kk/E=; b=mrZIiswgEdrJK23nhmmNdl07gy
	LsxjH9aVBouzhKSC8PyL1SOxB2E6TKrs4YO+0CN810+5EsMSt7hcFyu7Tje26slFox1ez8ln9IaEb
	53jyV2r3wS/kVlzopZF5bBBq7+Btxwi1Risvy3V1EpQxCnq/BBDQs+OKhF+QjjE9fs8r3L38OtJUJ
	BlZL1o8W1qBCS2VaWKgFZNpvbK0Q/9fXw0td+ZyPOsfKFN3gvWZwn20Q3mzXBslwPNSXJZc430hWC
	+lMHe0d7IKKH5NRqZNp1UNBFfU6vSBb7Ryr66dA/E+E7f/xryAGHomJO7cSsZ5+fFdA3ESo+0wjD6
	BvXzMc+w==;
Received: from [194.95.143.137] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubdWq-0000O7-KR; Tue, 15 Jul 2025 13:08:56 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add rtc0 alias for NanoPi R5S + R5C
Date: Tue, 15 Jul 2025 13:08:44 +0200
Message-ID: <175257771275.2527819.17809492107036436712.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250713161723.270963-1-didi.debian@cknow.org>
References: <20250713161723.270963-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 13 Jul 2025 18:16:36 +0200, Diederik de Haas wrote:
> The RTC_HCTOSYS_DEVICE module defaults to rtc0 and should (highly)
> preferable be assigned to a battery backed RTC module as it is used to
> (re)initialize the system clock.
> 
> The R5S and R5C have a connector for a RTC battery which is used by
> HYM8563 RTC. Both devices also have another RTC from the rk809 PMIC.
> To make sure the HYM8563 is always assigned rtc0, add an alias for it.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add rtc0 alias for NanoPi R5S + R5C
      commit: a2df3aead3e023857330a803c664ee97a7bd9b97

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

