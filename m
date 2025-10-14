Return-Path: <linux-kernel+bounces-853200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FE1BDAE81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A64FEC07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64F30DD15;
	Tue, 14 Oct 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="G0EeOtHG"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB330B522;
	Tue, 14 Oct 2025 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465227; cv=none; b=GveVLVaBnkJ+KfguTF0rIFzzTcp0eMFy3nlXGD+4SzG3tPeyfRyLzogkmIUFkPADiwNPDDjmClc6/60V1TmAj7OSFYhSUaFqgDqgssrB01mPiLeHzGyc1MwpfBujokSK4DlLD4nI8xe6afws4/XQMa8bArzm6Lzx81DEl2yAucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465227; c=relaxed/simple;
	bh=L48+UEPsQ+Ar3ptuAkPc+dZ1RECkjmmPruNZwLAXl0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1dDaZRUjv2UbhWtg4+BRRWhliIlbChmpoUvMTtvRcTdTGg0Y4WlJ2h8/iPYyqDBaTHsV1gZJMe2jyZT7g0tiLLynOMJvkjaljXVsOTrbOTSFPKewavtR5pa7Yy2CPu+UwxqvzePPCol2wpaxhHrzYLO05M1E9MUkgDzXg1Uc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=G0EeOtHG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=mbQ+ubn8SytYB/KuaCT22sbSFvRl1HpEA9kqmRcBXYc=; b=G0EeOtHG30OqAE8Lf/6S/q/BEQ
	cwv8Jm3glnxMBXgg/XtTcJaywJNip817h+Vnk6JZJ2LSDWgwoDRkv6eY9CDEI4QnDHFlK45dc3oKe
	jEs1XHkhQsGlG3Hot7xfFh/ZeSqVBNb7FEpi+r9QdDzolymCnoyRWX+/zOScB4xmfwl4k+bxsnRJU
	B7ToLcw67M1MGKBqZ2fGQiv30J+4okcwqGovj1/AkS8Qa6C0jF8Js+G/iWmSJ4/xV6qSsSJQI/RKM
	IjXplHkpU3dCtC4xSTWdzq9zS1dvmi73xl69Xt4Ni2VRC32NdY7V6LmbUUSMF00+Bqvn91gS1Frbz
	AuTLi56A==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8jQC-0001Gj-Qc; Tue, 14 Oct 2025 20:06:52 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v1] arm64: dts: rockchip: odroid-m1: Add pinctrl for I2S1 8ch TX path
Date: Tue, 14 Oct 2025 20:06:38 +0200
Message-ID: <176046473167.1662867.6844476664768210107.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251013152011.131118-1-linux.amoon@gmail.com>
References: <20251013152011.131118-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 13 Oct 2025 20:50:03 +0530, Anand Moon wrote:
> Enable proper pin multiplexing for the I2S1 8-channel transmit interface by
> adding the default pinctrl configuration which esures correct signal routing
> and avoids pinmux conflicts during audio playback.
> 
> Changes fix the error
> [  116.856643] [    T782] rockchip-pinctrl pinctrl: pin gpio1-10 already requested by affinity_hint; cannot claim for fe410000.i2s
> [  116.857567] [    T782] rockchip-pinctrl pinctrl: error -EINVAL: pin-42 (fe410000.i2s)
> [  116.857618] [    T782] rockchip-pinctrl pinctrl: error -EINVAL: could not request pin 42 (gpio1-10) from group i2s1m0-sdi1 on device rockchip-pinctrl
> [  116.857659] [    T782] rockchip-i2s-tdm fe410000.i2s: Error applying setting, reverse things back
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: odroid-m1: Add pinctrl for I2S1 8ch TX path
      commit: d425aef66e62221fa6bb0ccb94296df29e4cc107

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

