Return-Path: <linux-kernel+bounces-828194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B0AB94277
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C8441220
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAAB236437;
	Tue, 23 Sep 2025 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WCr1Vp/Z"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D26AD24
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599441; cv=none; b=OgyYwZ2ud31ED6QRSe3yddp57e8B3wKup3jQhuutWb8ZvDMehY7ZWJbFFOUAKfLM91fSmN5PS2qKE7YAukZNClm1HvF8GgKtve3h/xfwd86lR800/VtK+TH3N0WaVt9YYaa2reZnGT/1YDekTA02sGZ+pauHiFEkxf7CSnmzNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599441; c=relaxed/simple;
	bh=zYjfYu/UNyagZEz8NxVgnaI3Lb4coPtcxYLUhr8bS3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFMWVmmn66N/INpCIz6N0VLcBpQc2sr5JPWwV75r/nmaivHrENAFx/OzZ/MFILdbXzLm9LZ/IKbU/4q4n18nhCzTjwegFRLjRp8G55qIBQ3h+sZsJNmXK6Uf5fpDLBQkEJ9nw5l51U3Vkgivu29yF0zViwua+tWK9paUpykx+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WCr1Vp/Z; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758599430; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WL6+OcHWTMgKHuaivRlMnnLbtbjl+x9y2TqhTItfus8=;
	b=WCr1Vp/ZNkm1dETp50U06TZvT0zcpLtHdRypdZirvY6r9hAKCVR4bKuDe3Ra+S22F35XUq6HSALE9xdHznxql+60QspOe5GpFNcPl/IAmlLPw27dlWp5W+1dg05ywE/wDpMQV434uWMwV/e8lDFFOUOFlIkVS//xL1PkPHcGOH0=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WodT9v5_1758599425 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 11:50:30 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: catalin.marinas@arm.com
Cc: will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] arm64: cpufeature: Remove duplicate asm/mmu.h header
Date: Tue, 23 Sep 2025 11:50:23 +0800
Message-ID: <20250923035023.3166679-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./arch/arm64/kernel/cpufeature.c: asm/mmu.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25461
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/arm64/kernel/cpufeature.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4e8021a96993..164605da920a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -86,7 +86,6 @@
 #include <asm/kvm_host.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
-#include <asm/mmu.h>
 #include <asm/mte.h>
 #include <asm/hypervisor.h>
 #include <asm/processor.h>
-- 
2.43.5


