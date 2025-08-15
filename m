Return-Path: <linux-kernel+bounces-770684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E11B27DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1662B1D05D18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF12FE584;
	Fri, 15 Aug 2025 10:01:29 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E912FCBE2;
	Fri, 15 Aug 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252089; cv=none; b=GsW8uZwwYtcylLkBZQPIUhsQj3FjzkcUIH2mE4ZYnOjrsrC0GTGy2ChSPnHAr2yuafV0SddblgjxJRlCsRUsyfGLGkexcqKhiwioHvdXaRC3sSr60MLaNv25t0AQRhP9wMIt60gV4pDpipQcl/fMdz51NWQXAh18/4WJjGFahkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252089; c=relaxed/simple;
	bh=hJ0omirrcdCvBfSAvT36DFAi2zbKGO64uxdw3nQO9sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lp5jphcs7yzuYvneGKEluPn2MZMgOxzRTH/k0RAVMrOxl1XeOUzf8xGm9PB/rMBqKepKl4PVV6z6Gk6wQPCxtvHxHqqeMa5NwjBWp7Mmsxl0sMJbIo3q2s/pHbGfIAJm8fbDmM16/UbcXFOpFeiNTLTo4msOBKOs0fyq0YZkq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f81529f9;
	Fri, 15 Aug 2025 18:01:15 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: naoki@radxa.com
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
Date: Fri, 15 Aug 2025 18:01:10 +0800
Message-Id: <20250815100110.1302357-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <058E04574291144B+66620590-b680-44b9-92c5-7dc4c43080e7@radxa.com>
References: <058E04574291144B+66620590-b680-44b9-92c5-7dc4c43080e7@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98ad2d2bef03a2kunmff7e9ce61e6136
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSh5NVkxKH01MSE1OGkgZSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

Hi,

> "label" is deprecated. "color" and "function" should be enough to 
> explain what they are.
>
> (Personally, I prefer LED_FUNCTION_STATUS to LED_FUNCTION_HEARTBEAT)

BTW, will there be versions of Radxa E24C and Radxa E54C with
onboard eMMC? It seems that they are all onboard SPI instead
of eMMC. If there is no onboard eMMC version, we can remove
the sdhci node in dts.

Thanks,
Chukun

--
2.25.1



