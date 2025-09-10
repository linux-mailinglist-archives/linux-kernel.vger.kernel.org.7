Return-Path: <linux-kernel+bounces-809251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A95B50A98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622C04E6B78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54E2225760;
	Wed, 10 Sep 2025 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GNfUxdvE"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67827224AFA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469578; cv=none; b=jnuawD4YzpUk5fTfg7UGutUnp22rjyTkgw2kwAESzncKfCVC7tr89LZiwZi3iJ9OEJ9nGD39KwoFPOwHKdPOdNQGrAM9KDubwfgThx+77I0jyRaSvasza+1phd/Cb45bkCqfGkwKD4ylns1DzoERrJ0csvOeFt0onyTyTIM5OeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469578; c=relaxed/simple;
	bh=eWW5f2UcZzlbQe5XSAzAS5PyzDhhi4LY7mxDHExKlVA=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=DE4Xi1Z26tP9alhfeIm/rKeafU9/rfaHqugD/xyPJL7+WmzF4gwZMQqEYYhpaX52avcefYvAWzUQ2DH2IgFvLcz5rdPrfn7+ktoKF5C7fmhD70tWWKEyIkYhekdrwhkUIxjVKtPMMMiV/+P+eLd6p+aUmG+cDCt53X+ftZHlJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GNfUxdvE; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757469263; bh=9nQMQerLehG9FQEhBGEdRePggt2lPTLGqDaDNYRlCKU=;
	h=From:To:Subject:Date;
	b=GNfUxdvE7/+QWgHiClWq/2PG9qwCNRhWKnAq9gDl4fvfBM5TyNSp9LkPo8S2jXFGT
	 TSdlxigphVANcGiWwnkeAhJ+zRO0Weifi7n7RF23SDIFmveXlsKOmTGKO8DeLDHwyU
	 A5LTFSkq57W2mb9ACMW0VngrXuajxrhUbKNd+UoA=
Received: from localhost.localdomain ([2408:8411:2492:7e81:ab2:ed63:ee9c:f36e])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id C00B16EC; Wed, 10 Sep 2025 09:48:00 +0800
X-QQ-mid: xmsmtpt1757468880t1hl4uaoy
Message-ID: <tencent_9F7BD0CB08BE82E158610B7568B3EBD96B09@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJaw15E0ut52TKfRqtnQNKhFTrZHZojOH4XeyntjTAQigDELlbFZ
	 rQY8BOrgnjtBQRvafcBm3zrJiG/gjOYRcXa+zzQNTQM/NiUEcAqdUj/5f4XrZ6Eev1TCfylDHvM2
	 2tNcAh8b0LSLq4xCaJJ3NRS3bxQRRaOnKua182eK7ijAo+UnB0ihoC+PVjRi/O66+VNpo7MgkufZ
	 RZaWG+cTATuaRo933zexcUie9TrS3EneLK+vPaWeBu0rTzfVWSu4howPxr9O3IgT96mt11kSP+wp
	 N3qknE3kffWwzqqC1jtIcuXuzhBCsqguYOO6R4eOBItSMm8g/6Pz/1MmUQ0lMZgCEhwN2ns02BJr
	 f2q1gBRVhdRHQpcW77hWt113c9if8slgF8aX6vPvDtL2aB03fYH5InywaoJs+1coJvSbFUrDzUJ6
	 /jaURFYHjrT9s5P11FewN6p7MQ+sJNRoLrpPcJM7SAoXGcTPDGUTpv01MVMasDjPzVEz68czjNoT
	 KkQLee0ITGcAaUa3QvKxzcpoKYTImr9GEM3IQhycKfCWkEDm4RB6OoLax82gJqR0A7GmcKgRRDQR
	 KJgEbbZh9bh/8bqi+fM28Trgtws2bYEQK/MhqNnvkCMcXa4RxN9SHaynNuKlmoNqHF7+2B+cznoM
	 DGXetMH8zNcTy8z520nNYwo2l4p6QiPjvx7bjJKEEXj9nhhNqfgyvB4zhhui0DowV5rQ18zLyHD6
	 l/HFdC7EFoHgxcNQJy9T5wdXniiBBE/b+P7VDp3z54sTQ+wcybhrYY0Vn64bnVd+BEUM6PAOaEff
	 328to+6h5kMaZ1w3Wn3RR1SalVtyxi11qAc9sooIKMkx+HXRqkImq4Wr9NkXjFWHEnl6svuihI9J
	 jqEuHy3HHv7M7QgmQfmamJRYlICA/qSyF9nv8n8BD7lxwK73McJse6U9uWaCgjTZ9T5D8ZLSiO7G
	 iZBWfpFJK6Zk5Ka9KckDXBqKi19AjvgvZsK/+dJDSqv6gBI/ulZEWpwb87CRctNzQUNrcZXba2o6
	 IA1W6RQc+XpRe1rlV7Cz1UeKSCIN8=
X-QQ-XMRINFO: NhdyCYpGN2QZqWzjAb9u7a0=
From: Enlin Mu <2277901360@qq.com>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	enlinmu@gmail.com,
	enlin.mu@unisoc.com,
	enlin.mu@outlook.com
Subject: [PATCH] clocksource: delete unnecessary comments
Date: Wed, 10 Sep 2025 09:47:59 +0800
X-OQ-MSGID: <20250910014759.8223-1-2277901360@qq.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Enlin Mu <enlin.mu@unisoc.com>

The new format is as follows:
  clocksource: jiffies mask:0xfff max_cycles:0xffff,max_idle_ns: 7645000 ns

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 0aef0e349e49..c70880376ec6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1218,7 +1218,7 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
 
 	clocksource_update_max_deferment(cs);
 
-	pr_info("%s: mask: 0x%llx max_cycles: 0x%llx, max_idle_ns: %lld ns\n",
+	pr_info("%s mask: 0x%llx max_cycles: 0x%llx, max_idle_ns: %lld ns\n",
 		cs->name, cs->mask, cs->max_cycles, cs->max_idle_ns);
 }
 EXPORT_SYMBOL_GPL(__clocksource_update_freq_scale);
-- 
2.39.5


