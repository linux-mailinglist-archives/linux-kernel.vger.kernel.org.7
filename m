Return-Path: <linux-kernel+bounces-738931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC10B0BF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC461882F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961D286D77;
	Mon, 21 Jul 2025 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="srBoqJth"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1321D5AA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087333; cv=none; b=QkeZfX+yxlVJyTjgfEDvL5jE8UgwcGQUi3jlcXQucdSBjbPyTZc0fCtPGq1JR1oWgDk6q3oIWu6DKjtkB+KL90/mv0Nb8ZocFeBAbXknSH4dBuFa+QoWnffZ3R+8s8+r+NTPPymSDJfLO288YxXFR5g0h833mAHZD4PKqyKowzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087333; c=relaxed/simple;
	bh=ZevB/rMVP54ox+E6HDKrtwc/AANXWoBgn1GicX1uA54=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GSR29laqkLt+Bhr6Q1ZvmHkKTxCIcp2/N8qhzWuaj8SN6NBlvhi+1VXmFd8yDNYBBA4QOsk5YOykQNz9Tmm6JO54/R/zjQzmRt/oKftaN1dNWOFajBVJ1WqfhKlppXMqFZnxfkcY+m2lhGPAtr9wppgnoeGzBEaum0EBWSPWwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=srBoqJth; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753087324; bh=AcFVl0DmeVyX5echR5dsroEfWYnxGHEEB9xPqwtw0yg=;
	h=From:To:Cc:Subject:Date;
	b=srBoqJth2bdAGnCP4W3ttxhKzVI3J1lspwKy/A0C5jDGhgBa0apkFPe5Ay6BBaP36
	 pZwmRn+UkxHRabxlvZiqjnX6fQSpA5LJ/qfvITvZXWbi+sSClc5vBcfSSCDCefSKOm
	 BYrNzFeqQ7RBJk7ZbqR6toYsoZ5EulxlrJWqNgpE=
Received: from archlinux ([36.111.64.84])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 1342CE9D; Mon, 21 Jul 2025 16:04:52 +0800
X-QQ-mid: xmsmtpt1753085092t3ifdpnra
Message-ID: <tencent_C3E0BD9B812C27A30FC49F1EA6A4B1352707@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5s6+987EKPHMvEptgw8q3033/ITRgZ+pZS0eKfB2lFFaqFyW5cL
	 v2o/icVHSm7+hybJVFFgOU2pado4ssK/tUcrFYqiRQcRLj6JC7pC+aJpAtOW7Tza2TVGS7zE2xCw
	 ctFjueWd9NjkchaW3f9Hr03ciKv9cl9FiPcOF+JtcPAIr5D5fKEC9rrP4OLLDCsQkBGLFbaT0Ff2
	 sG8QaLnerfu0mRHshmFQg112vSeShsvBCkbXjKdW2984CspNIAznxigzNEspTrQ9BNmMA5UwxaKE
	 NCu4GZsb6q05g8Zc3Td75XGdf8YZXceE39F7CTUhfMkQMjnYlcpMmgk9TCJkwalZ4XPaQmdfuVuc
	 NNEZ5Tu5rwLeo6oBJ8IRMts86COfe4w8E/zwWc1bkzOegbwM6t1lx+PIpok+yG/ONz4ziCniVW8v
	 n2CGdIEEaYpbH6FsVMF++UtPa54FxwUHsbsqCmBHQFpjcEp3ubherjc+ZLsZrPm/higgYdIqdkr8
	 tTGaVIZ02IF3GmwdgDfAwY8vqTk5zBJgBl7DT42XRya85yHzV9ZFYMqKg6Mtd0HeE/yqb4yE1ylD
	 OO1I7P+D6RKGngJwycz2hHNmjXi2Y8mM4nrl7PQPNNZg6k013aY636umtcWuz0FEV0ThiBXwp20W
	 SdDZQUxRopgO1btUoQKDiVvztBcRen9I+0V2cXbBpY8rhVIOdgVI2CZs/4bmBCHa7OvBx0aTtBgo
	 qQdKjC4SxB3hRKRjNIoAsomyDAJZdjuGun5y8WORonQXX0Oe5yp+S7kna8syAjeQoLhUdM6ljkdc
	 oqZFKkA9dv74bW4v2BB2S64JDaJ6hA/e6v9sn8GD12qQa3t41D+rgHUSYJ7/+IgLDExtUZ07aGMp
	 Y9jF/+nYVYbsTHWj2XoGpZQV/gkVZpXyiYtB/2n2oAuErjZiwSC3KJDexf0z8PylyuJJH0DOAS0f
	 7gzblkOwADqy2xlbQvS9kGEN+KmkecJ/eFoK/rl6KbMVGu3J6TgkKu3sNAYStm
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Feng Lee <379943137@qq.com>
To: tglx@linutronix.de,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Feng Lee <379943137@qq.com>
Subject: [PATCH] idle: remove useless code
Date: Mon, 21 Jul 2025 16:04:35 +0800
X-OQ-MSGID: <20250721080435.23573-1-379943137@qq.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

play_idle is no longer in use, so delete it

Signed-off-by: Feng Lee <379943137@qq.com>
---
 include/linux/cpu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 1fb143ee1ffa..b91b993f58ee 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -187,11 +187,6 @@ static inline void arch_cpu_finalize_init(void) { }
 
 void play_idle_precise(u64 duration_ns, u64 latency_ns);
 
-static inline void play_idle(unsigned long duration_us)
-{
-	play_idle_precise(duration_us * NSEC_PER_USEC, U64_MAX);
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 void cpuhp_report_idle_dead(void);
 #else
-- 
2.50.1


