Return-Path: <linux-kernel+bounces-775872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09822B2C5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11624189109A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5CC33CE9B;
	Tue, 19 Aug 2025 13:40:43 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E213043D5;
	Tue, 19 Aug 2025 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610843; cv=none; b=ZTzbbvWGzBer7Xs9Elfw1eAjG62bI5XzGqtmzGe2TXwAy30H1mRiT+4lgnHTU0hfxpqazKByte7sB5IaDP2ualPyGsKU3A+bUCmFhtlxF8InPeYbbq+T/F+RlClu9y0cXFcTxErlihRV/3FEw4WyBIeCftZC9SWIXqjdljWcMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610843; c=relaxed/simple;
	bh=6an/Kcsi6M1wumDWm+Pv3+jE5OpPF5mN6RZA3iyrbNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhP0l4Xck18jQUFN+p1EZnlJxL22jQmy36Y5hnSL8Cu2KVSoQq+IznlMS+akLQtwBCBzjiWXJtRKQfu5tmK8HJhO78xDobU4ETKKEYiiCSqygfaUxrF/TEC2YWX/iFyujMruJuGjGMrWQ0ZifWOxnR4x+wa8no81kP+h7Ehlfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.154])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fe378d9e;
	Tue, 19 Aug 2025 21:40:35 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: naoki@radxa.com
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: remove vcc_3v3_pmu regulator for Radxa E52C
Date: Tue, 19 Aug 2025 21:40:28 +0800
Message-Id: <20250819134028.634780-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <BCD8E43E564BC334+1e45d36f-edc7-4c3c-90c9-7b0f2a52360f@radxa.com>
References: <BCD8E43E564BC334+1e45d36f-edc7-4c3c-90c9-7b0f2a52360f@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98c28f6a7403a2kunmf38edd85400152
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQkkdVhgaHkweQ0IaGkpLHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKTk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

Hi,

> How about the following instead?
>
> @@ -538,7 +538,7 @@ regulator-state-mem {
> 				};
> 			};
>
> -			vcc_3v3_s3: dcdc-reg8 {
> +			vcc_3v3_pmu: vcc_3v3_s3: dcdc-reg8 {
> 				regulator-name = "vcc_3v3_s3";
> 				regulator-always-on;
> 				regulator-boot-on;

On rk356x, the Flash chip is usually powered by VCCIO_FLASH, which
is also connected through a 0 ohm resistor, so I didn't write like
this. e.g. https://github.com/torvalds/linux/commit/a706a593cb19

Thanks,
Chukun

--
2.25.1



