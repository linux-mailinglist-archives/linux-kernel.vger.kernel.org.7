Return-Path: <linux-kernel+bounces-804075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5580B46987
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F02A3A6527
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC272C08D7;
	Sat,  6 Sep 2025 06:50:05 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9521858D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757141405; cv=none; b=niIKW7Rgz4ij/0BO+y3JGjqwUVNGV3r8JSlHO8Mcu5oAt/FgAjA+hXDe2JO3jy9wD5CKbtc/mzugzl4jbAi/cyzNdSoDBpJby1iGG12oeHITXwnkW528eh5IUn6Ob3kDCymoJLjaOaNnROEbqkA+uc6OUU+txEx7QOhFq39emi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757141405; c=relaxed/simple;
	bh=UCRLucaNhId2pgdiywK4KCFjudm+oB4DdliKmX6mP7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BOdzxWksRQjMrME4CpAjZiymxrkfKlDx3ADWRPrIQFFhnq7WE+lJJNm/ZntBCuh2NQpJlYI8qWbxF55x67SrImLNNzXz9sfq+BvVGi7KKa4MH+OBwRXgTVTfNlrELPbS2aQDukdzyrXZKdX7kKLo2q69/sKt/lDELy9vAPqOmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxbb+R2btonlcHAA--.14630S3;
	Sat, 06 Sep 2025 14:49:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDx_8OQ2btoJZuBAA--.17141S2;
	Sat, 06 Sep 2025 14:49:52 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v3 0/2] Remove unreasonable detached state set in tick_shutdown()
Date: Sat,  6 Sep 2025 14:49:50 +0800
Message-Id: <20250906064952.3749122-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8OQ2btoJZuBAA--.17141S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Function clockevents_switch_state() will check whether it has already
switched to specified state, do nothing if it has.

In function tick_shutdown(), it will set detached state at first and
call clockevents_switch_state() in clockevents_exchange_device(). The
function clockevents_switch_state() will do nothing since it is already
detached state. So the tick timer device will not be shutdown when CPU
is offline.

Function tick_shutdown() did this because it was originally invoked
on a life CPU and not on the outgoing CPU. Now this function is called
on the outgoing CPU, the hardware device can be accessed.

Here remove state set before calling clockevents_exchange_device(),
its state will be set in function clockevents_switch_state() if it
succeeds to do so.
---
  v2 ... v3:
  1. Remove parameter cpu in function tick_shutdown() since it is called
     on the outgoing CPU.
  2. Modify stale comments about tick_shutdown().

  v1 ... v2:
  1. Add Fixes tag in patch 1 since those commits removed shutdown calls
     made from drivers that assumed the timer core would do so.

  2. Remove clockevents shutdown call on LoongArch cpu offline
---
Bibo Mao (2):
  tick: Remove unreasonable detached state set in tick_shutdown()
  LoongArch: Remove clockevents shutdown call on offlining

 arch/loongarch/kernel/time.c |  2 --
 kernel/time/clockevents.c    |  2 +-
 kernel/time/tick-common.c    | 16 +++++-----------
 kernel/time/tick-internal.h  |  2 +-
 4 files changed, 7 insertions(+), 15 deletions(-)


base-commit: d1d10cea0895264cc3769e4d9719baa94f4b250b
-- 
2.39.3


