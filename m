Return-Path: <linux-kernel+bounces-792959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF04B3CAEE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E68582D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435BA27E048;
	Sat, 30 Aug 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mfFmsgrh"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA51EF38C;
	Sat, 30 Aug 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558696; cv=none; b=ARzMtHP+r1cWhFGieTSB93B3g8HHaLWpjIg+6cOUYugTl9UL3ZJP6siJCkUhDtzWfAytIE3wAyMGPTPjsONuAKwzJD7Ku5AABzFAsntDp8oNS4cuG41E4PnJm8JhjMcvayhPLurHwIp/ZZeridd90QrtATddrhLfbiojFBUuWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558696; c=relaxed/simple;
	bh=lbhuyCowFfmugkSutgbSgHx/EsZxi/HZi6ocgxt6mSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=On2PRcBXaXEpUhk90X7Xr6Kw7qEsSuxRynTiP93/ZfQjhYbd4JIUkFiPzFmYSvLL4+HlkVVQ+lPm1/odTACCnFZBCK3pnC623l9HYm+Wy7G24noTzwMkxBGnwV0nEL+oLbH41hLSqKwnb6DupCFcsiUXyj4QMp0SaCyqpxLLd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mfFmsgrh; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=4Wkx0s3ceZ1hfkSo00gMyByhOeGtiM2HLNss7D9J4VA=; b=mfFmsgrhnBXM4d8ogI54ClxhmP
	X41S+1H45/Ofk+JkQmMAd81GQzUvwRjx6RNYm8UpCSr0UPnONryAY9sbv78Ht/0/40ED7UoZdcHK/
	r7OiFfVlQPRekl5KdaU9+kvRh4KYyr7+RO/aJTYR5i/gq7Fau/dcvsdNsSZ4mJ6T5iGtrWoUFN8aD
	gYAm8ftVr8qLFvFSnbQ8o6o+xUVQtB7OWWzwUXRRTY8QNJsNDy4OVGEfclHpBjjKT8jZuFLD1t6U5
	rN4dEMaLJj6wFKYLa8jIckrG4wFX0CDbXknjGOB7XlsGPoFMVnRJ46ThK1Wamc+7y/mqCpmhw9ovv
	vNbrgqPw==;
Received: from [77.241.232.9] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usL9f-0007bC-2I; Sat, 30 Aug 2025 14:58:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christian Hewitt <christianshewitt@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add SPDIF audio to Beelink A1
Date: Sat, 30 Aug 2025 14:57:52 +0200
Message-ID: <175655867260.3578496.8687681480867378728.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250828164300.3829488-1-christianshewitt@gmail.com>
References: <20250828164300.3829488-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Aug 2025 16:43:00 +0000, Christian Hewitt wrote:
> Add the required nodes to enable SPDIF audio output on
> the Beelink A1 set-top-box.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add SPDIF audio to Beelink A1
      commit: 8a449a728cce86183f93a3d1812c94509359719c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

