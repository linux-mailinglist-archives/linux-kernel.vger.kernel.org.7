Return-Path: <linux-kernel+bounces-861184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86CBF200E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9117A4F63E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105821019E;
	Mon, 20 Oct 2025 15:08:25 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B9856B81
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972905; cv=none; b=s1vN+Klbrbb2BVmVBe9B6eM5a/Uov3mDG3UGFXRPufbRelKtgdov4LhGxGd71QLcflncMGODp7Dcv3DgSA0KFaFbFzTKsms0d5pn84n2DaoyWp5irR7ivyTGK5MerLSEOqv1igcLW2pxGKavxxEOYWZxCO9qgWO3yor/kCbxPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972905; c=relaxed/simple;
	bh=DUDhXEUkIDNhEApJPCEvtqchrJ7NVlFrEAFm+wlN8JU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pL7ujLA0145cy4SJKM59yuQHyXIbkzrPH9Q+pAfJvVbfVLMHYHNuwtNyi9Y2/DvWoeCFOUJQiIuSs0FGBLi97D2WmS6C7mqYz8KpTbWWxmpHZ+gI7zcKA4NY5HAyr5VVebwtwz0RTUhP4ZTlGZWL+3gGyFZrQSj7alfwhx0nsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cqyxk3J1ZzB9K4g;
	Mon, 20 Oct 2025 22:49:30 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Mon, 20 Oct 2025 22:51:40 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>,
	<chenjialong@xfusion.com>, <yuxiating@xfusion.com>
Subject: [PATCH v2 0/2] arm64: spectre: Fix hard lockup and cleanup mitigation messages
Date: Mon, 20 Oct 2025 22:51:15 +0800
Message-ID: <20251020145118.1306-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20250918064907.1832-1-shechenglong@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
Reply-To: <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03045.xfusion.com (10.32.131.99) To
 wuxpheds03048.xfusion.com (10.32.143.30)

This v2 series addresses your comments: 
- Fixed the message to use "command-line" consistently 
- Created spectre_print_disabled_mitigations() function to handle all spectre mitigation messages 
- Added a separate patch to remove the CONFIG_MITIGATE_SPECTRE_BHB option

The series includes two patches:

Patch 1: "fix hard lockup triggered by printk calls within scheduling context" 
- Moves printk calls from scheduler context to setup_system_capabilities() 
- Prevents hard lockups by avoiding printk in unsafe contexts 
- Consolidates spectre mitigation status reporting

Patch 2: "Remove the print when the CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY Kconfig option is disabled" 
- Removes the obsolete CONFIG_MITIGATE_SPECTRE_BHB Kconfig option 
- Cleans up the spectre mitigation code as suggested

shechenglong (2):
  arm64: spectre: fix hard lockup triggered by printk calls within scheduling context
  arm64: spectre: Remove the print when the CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY Kconfig option is disabled

arch/arm64/include/asm/spectre.h |  2 ++
arch/arm64/kernel/cpufeature.c   |  7 ++++++-
arch/arm64/kernel/proton-pack.c  | 28 ++++++++++++++--------------
3 files changed, 22 insertions(+), 17 deletions(-)
In-Reply-To: 20250918064907.1832-1-shechenglong@xfusion.com



