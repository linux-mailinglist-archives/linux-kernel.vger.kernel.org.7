Return-Path: <linux-kernel+bounces-862254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB2BF4C83
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 366DE4EEDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8E23ABA1;
	Tue, 21 Oct 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="pwf2c2Xm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F71A9F88
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029989; cv=none; b=eXk/NONHJvkC3HBsL9lD0GhnQgBz+W2UwfOWIhbkLO4DL7+jzV0tkJ1lkTf+Q9CczwyPU2sZIDZ/02Lmtkc/7p7RZZdPvZS0iXLP6v6MJ6q2IxnBIzs7WAxxBKncI8Ql2aTtvTwvRxiGucbxVheMZA/Q2ypxshphojJP/Gxhrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029989; c=relaxed/simple;
	bh=ziMJcpdMvWzpOIkVgcs/Y4GZjwBeHZf64KIf3u8U0Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOAghg9f5mh3pj1a4s0zOLAHJRCAaq5w2X5T3prt8e98ZnjZdHFjZVXBVGPg71GBUrxPJDBmgizNfbdWytKIb8g8FgZBF7XDWiDHbloDFX90vcfa3f/U1fDw4Q94DEO5CWaLWLuvO8DbPE4xAamM5vYkuUwUc6mVYUtz+p7g9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=pwf2c2Xm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=GDcK8E3M5R8B2VvEQJW+iEfSUDxX2Oq3t5ONK/ap61Q=; b=pwf2c2XmLc1x9Iteap7pq75l+l
	XMKItSA/Vz+pZ05mkpOVOVin98sEmrDl8VIhpjsjaCzCqts3AClXE0Jvu7j0kBc50J44V2ziAcIXi
	QREg7tt8/FJEWg3SwTKVCZA+tUTs+MLi6vs+rAU4crv2tiVW3tE9JKkl7RSiKpieBQof97eUW4ZHf
	dmPLnSvHqd2K/aIHHF4642k3IZVD2a8a9UTifLCtOxFwpJGL24YE5u9xNYIOjaQjTT2jTwY+jqZts
	WgkcACXigHyS2JUvFr2WYlLDwYwahAxnAfJh5eurQHINPhjST6XZ2ubYup6qd3o6r2w/8IJGp0pO3
	ugUfCO3A==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB6LS-0000ZO-J5; Tue, 21 Oct 2025 08:59:46 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix indentation on rk3399 haikou demo dtso
Date: Tue, 21 Oct 2025 08:59:45 +0200
Message-ID: <176102998080.81864.1578466787311951738.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251020091139.3652738-1-heiko@sntech.de>
References: <20251020091139.3652738-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 20 Oct 2025 11:11:39 +0200, Heiko Stuebner wrote:
> The regulator-cam-dovdd-1v8 uses spaces for indentation, where it should
> use tabs. Fix this.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix indentation on rk3399 haikou demo dtso
      commit: 26f0f122f92f2e8c384c08a05956417bfb5f6fbe

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

