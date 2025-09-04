Return-Path: <linux-kernel+bounces-800113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61DB4338B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCB27B50BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602029B764;
	Thu,  4 Sep 2025 07:17:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22F6299AB4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970262; cv=none; b=G6NMkXkV/QMB3nlsbuiCyZ/5Slr7HfvSAeLgBGr5iZdUKtHoiXWHySlxxexRDYb4AvzCs836BJ8KnppW+b2woDAndoBvRFyecsjGM+Puu3K6Y9iuiTKeaFv352q4cymksBraKbCQ86xiyz2J4RGAnH64+wOwx32dOLN4pZfK4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970262; c=relaxed/simple;
	bh=18nNQkpO76odAuOhYO6DFGmsxO9+r8Zf1pzFzS+E3WA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dpjfc8ECeZdT+MeFEv9cNyxUAkOO7oGGmLdnNnwQ54t/PegZgt9tajqlAnxEog7i39hhr1DKaD5GIDI6XiwbzLsBgeQwImil5+jBWaUZwf1DPIW6OIZsutoclnLauKeKpl5oe8epJlVWIbz8s3q/wf76I66/3U9MuX2n6mobo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx1tANPbloSY8GAA--.13766S3;
	Thu, 04 Sep 2025 15:17:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDx_8MNPbloS2h9AA--.2519S2;
	Thu, 04 Sep 2025 15:17:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 0/2] Remove unreasonable detached state set in tick_shutdown()
Date: Thu,  4 Sep 2025 15:17:30 +0800
Message-Id: <20250904071732.3513694-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8MNPbloS2h9AA--.2519S2
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

Here remove state set before calling clockevents_exchange_device(),
its state will be set in function clockevents_switch_state() if it
succeeds to do so.

---
  v1 ... v2:
  1. Add Fixes tag in patch 1 since those commits removed shutdown calls
     made from drivers that assumed the timer core would do so.

  2. Remove clockevents shutdown call on LoongArch cpu offline
---
Bibo Mao (2):
  tick: Remove unreasonable detached state set in tick_shutdown()
  LoongArch: Remove clockevents shutdown call on offlining

 arch/loongarch/kernel/time.c | 2 --
 kernel/time/tick-common.c    | 5 -----
 2 files changed, 7 deletions(-)


base-commit: b9a10f876409bf3768178f4aded199e193ddbe33
-- 
2.39.3


