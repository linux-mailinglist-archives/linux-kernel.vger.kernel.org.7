Return-Path: <linux-kernel+bounces-758677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7796B1D27E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645B518C74C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132B22127D;
	Thu,  7 Aug 2025 06:30:58 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202464438B;
	Thu,  7 Aug 2025 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754548258; cv=none; b=VL+SsHL1abiH/PWuL17YeO8PG281rQek3xhXa1+N/IwPGHeUURBoaQ/hDG1Tfi6JSRaNiUIxpj+CNf1MRAr2CsWo7snlcmb/37mkzMhfATIU8u9ptvrYjchZ2zENat3X4Tj5c4aa6BBPbT4xIjwvDBN1zRrBL4vZH4fe9WEKb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754548258; c=relaxed/simple;
	bh=o4Ha1FVFN2uUU+67c9KnfECEJZ9OCvPmJ/d97dfxDMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GpWmPssdTdvY4MZ7rWvLVnkijLWKDX0ESfTbgozWEUCFT6O4wBX2Nzwh7Tn5kHUHYDfi6sT21pY04Jd2lmnkaUUqVFMyeCFj+rqUp3IygV6ZRg3xLKkLJmOKtvzR1yixsdTmcdrWMGZDh1r3an3Vdo4ZtfKYDWfeEcc8DqumrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.212.7])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1e971c1a0;
	Thu, 7 Aug 2025 14:30:44 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: ziyao@disroot.org
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	neil.armstrong@linaro.org,
	shresthprasad7@gmail.com,
	vkoul@kernel.org
Subject: Re: [PATCH v5 5/6] phy: rockchip: naneng-combphy: Add RK3528 support
Date: Thu,  7 Aug 2025 14:30:36 +0800
Message-Id: <20250807063036.480766-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728102947.38984-7-ziyao@disroot.org>
References: <20250728102947.38984-7-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98833990b803a2kunm2e2160d534958b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS09DVh0dSRhNTU1NTE9IQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVMWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQ
	Y+

Hi,

> Rockchip RK3528 integrates one naneng-combphy that is able to operate in
> PCIe and USB3 mode. The control logic is similar to previous variants of
> naneng-combphy but the register layout is apperantly different from the
> RK3568 one.

Is this a typo? apperantly -> apparently

Thanks,
Chukun

--
2.25.1



