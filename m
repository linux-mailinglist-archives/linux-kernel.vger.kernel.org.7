Return-Path: <linux-kernel+bounces-731710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A9B0587D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E4A3ADAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B72DC359;
	Tue, 15 Jul 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="h9DBQ7aO"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70C2D9EF1;
	Tue, 15 Jul 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577749; cv=none; b=TiY/MQcstPx0VI3wmQW4SezwvfS/eQok2oOO8ayUUOmaNlWyECxR9xae5cDqES6Rw6HYNHj3wgii/piFrYTUMVM7GClQzUSVAQSfpW2hM//uUrZUHpi7suvH4yYg+mVc+9O9H0YGkkwLP2uaKx+LZbPKTph14fGU+qfjriO2qoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577749; c=relaxed/simple;
	bh=A0j2k7xe0Pon/uwqCN71XM+oFjb1gY8I0QhCoJwA5Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBXX4fpM6+RSK1fa5IVFhSbFebgD595KqJi9FMjgrv/5h7JKICroxJXvkWo/2EqJJk9HPaI6SXPBIvColxjAV1013KbzTdjRLyyU3VKQQ5T5eMEplOc/XDv0wRaPDnm0yv+foPuXb6wdmBlKEJKJ5wNvP6Y90KWiJ22MNZXIbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=h9DBQ7aO; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=QnlcDQSgxotW+7K4kTxA5VIGj1my/BzqpFvR5bTVwoA=; b=h9DBQ7aOxJ0Cyo+S2iKcJBJcJ8
	M08lAAXa4gM7XGZIt0zLj/bMblsJx+U/4d7KmPeGF8T1CjIk6gjPXlM72gPBF+uHAmG6Jo3i/HiWI
	iNwZZaWyQ5gOrHKCOG6WuRBpdePzCqWCdxgNR7dum8rKjhdizwovCUOq3Vu8sBDcSAqtDOWtGNWQV
	HFV/AEGQd+bPAPQm4nEPW8DPQlVc3+RQQJtZJPqST3tflizqdsMKHe9YLZy9C2TrbHgxMhwxMySf+
	L4nmEEiBzjxicbClSzl+kjjxTAHrbqXyYnhlRfvzzyqLc+QHMjJWUhDIyl4STINfO8gzJt7V/tfPJ
	bHAhqIKg==;
Received: from [194.95.143.137] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubdWr-0000O7-FZ; Tue, 15 Jul 2025 13:08:57 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix UART DMA support for RK3528
Date: Tue, 15 Jul 2025 13:08:47 +0200
Message-ID: <175257771277.2527819.763975053553493383.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709210831.3170458-1-jonas@kwiboo.se>
References: <20250709210831.3170458-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Jul 2025 21:08:28 +0000, Jonas Karlman wrote:
> Trying to use UART2 DMA for Bluetooth on ArmSoM Sige1 result in tx
> timeout when using dma-names = "tx", "rx" as required by the dt-binding:
> 
>   Bluetooth: hci0: command 0x0c03 tx timeout
>   Bluetooth: hci0: BCM: Reset failed (-110)
> 
> Change the dmas order to fix UART DMA support on RK3528.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix UART DMA support for RK3528
      commit: ae019f0bdfbef3e0671e7b954321e92fc24c7e54

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

