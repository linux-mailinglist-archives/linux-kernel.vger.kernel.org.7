Return-Path: <linux-kernel+bounces-804077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B95B46986
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C0E18924C0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7372C11ED;
	Sat,  6 Sep 2025 06:50:06 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6427B325
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757141405; cv=none; b=Go83qszgh8pIBN4cxKZmwf0frWB3n+cT/daOWzOPLOUJKMg1CPPMd4eHuy6piyCDJ9FC7TCj0UaaHhRS0ZgxHo0H8Fm7a3WOlCV7zFY9//V2KbxJyucB8bxEEeBI/xByhjgQyL1IBVPfdr8CBdfD7TQPCwWJP5WER2xbO89VZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757141405; c=relaxed/simple;
	bh=EZU3KTl6IPNKUrbj5DDCEcWk5vBANwmZEzz/pD7YdZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0w+vyrGbJUY/FHT8kQafeb97RyRCzaCO+gV/ZDWlaAt0ML6P7U+vnf9ij1DlvCbY8r0Y0/I2Opl4nr2CHGBp9T+0pUdlJQ+Kw0iXHehk3faNOaJ1sgBrmzkSuW7UXPstXe8VZEHZl1HWfJSF033Mm4HbHr9HZFf7Q9weys+Oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxidGV2btoplcHAA--.15470S3;
	Sat, 06 Sep 2025 14:49:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDx_8OQ2btoJZuBAA--.17141S4;
	Sat, 06 Sep 2025 14:49:56 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v3 2/2] LoongArch: Remove clockevents shutdown call on offlining
Date: Sat,  6 Sep 2025 14:49:52 +0800
Message-Id: <20250906064952.3749122-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250906064952.3749122-1-maobibo@loongson.cn>
References: <20250906064952.3749122-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8OQ2btoJZuBAA--.17141S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/time.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index f3092f2de8b5..6fb92cc1a4c9 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -112,8 +112,6 @@ static int arch_timer_starting(unsigned int cpu)
 
 static int arch_timer_dying(unsigned int cpu)
 {
-	constant_set_state_shutdown(this_cpu_ptr(&constant_clockevent_device));
-
 	/* Clear Timer Interrupt */
 	write_csr_tintclear(CSR_TINTCLR_TI);
 
-- 
2.39.3


