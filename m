Return-Path: <linux-kernel+bounces-884245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823EEC2FBAA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAA83AFE61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A293112C4;
	Tue,  4 Nov 2025 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="M0DKv6WG"
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413E30FC2A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242952; cv=none; b=mkk6yO2MQJ3CIrfRC2CcvFOeyazha3qgEH58NJoOLr9lIt+p08Nxnj+WyAAl3lbEV154BZI9LFSKpRzd4WIEMnQ0N2p+at96tVGeEKjueEIICfjXFEL6ExtpEd+sLRiJzg3En0PfZANJIQnfanKmAgTnVy5JLEuVvY6mSxo+VpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242952; c=relaxed/simple;
	bh=6WnXT9HQaHJrS9j1P9POUxpQdXqRdks5mqiWPYe/60I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EltDN7bTurbJ5cAMJOkTZVyxVoLaTxdRKLQgR3WIfqTCrlFR4NFhCgFePB853hfuKn32vwiLNk7WZ92prbLJm93ZVdVfj+6iU09mR9Mu+xxs3XBoZJno3w4vrQTH4AyLp33GpAWlTbKdiq+uGJ4Bp3N4v/HciJFqCjFIqiVZfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=M0DKv6WG; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TUtKpYDIHuKRFyrLUMsfR7FjJX4crrKYSXgptWij7qo=;
	b=M0DKv6WGTzPX1EkgHOmhX1DzI0XAzT54raZYRJee3MH/syyLn+W1+g9BnucvYimGZjtiE2nHH
	ovureVHhfPs7MNPmDI3YpJJ8+jTCnQJmbXo88Tn+PVlNG/85H2bl00UAW3Ryx/Zzyqvx+1aTRSC
	5kvXGpSSal7dvLaQQOurgcY=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d111b0rcPz1cySR;
	Tue,  4 Nov 2025 15:54:11 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id 0829F1A016C;
	Tue,  4 Nov 2025 15:55:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 15:55:45 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <beata.michalska@arm.com>,
	<ptsm@linux.microsoft.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
CC: <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>
Subject: [PATCH 0/3] arm64: topology: Improve cpuinfo_avg_freq for ARM64
Date: Tue, 4 Nov 2025 15:55:41 +0800
Message-ID: <20251104075544.3243606-1-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500012.china.huawei.com (7.202.194.97)

This series addresses several issues in CPU avgfreq reporting:

Patch 1:
- Implements direct frequency calculation using AMU counters:
  freq = (core_cycles_delta * timer_freq) / (const_cycles_delta 
  * HZ_PER_KHZ)
- Eliminates precision loss from SCHED_CAPACITY_SHIFT bit-shifting

Patch 2:
- Resolves unreliable cpuinfo_avg_freq behavior during idle periods
- Replaces invalid returns with governor's current frequency as fallback
  value when all CPUs in policy are idle

Patch 3:
- Removes redundant housekeeping_cpu() check

Bowen Yu (3):
  arm64: topology: Improve AMU-based frequency calculation
  arm64: topology: Use current freq in governor for idle cpus in
    cpuinfo_avg_freq
  arm64: topology: Remove redundant housekeeping_cpu() checks in
    arch_freq_get_on_cpu

 arch/arm64/kernel/topology.c | 40 +++++++++++++++---------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

-- 
2.33.0


