Return-Path: <linux-kernel+bounces-758827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3820B1D449
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91C87A4E14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617E18FC92;
	Thu,  7 Aug 2025 08:30:12 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF662550CD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555412; cv=none; b=o1NjybFwEbtsNGHaEZblJ1TBszAiW4SXTqk1VAd5AaPke91NwF0G+po2ZamQss4E/4ni5mjWybAyWGxI33J3QEeHZ+IMeprHrTp738DF8t7Vmm0wDNDeEKBRs44A0ev/3orYPJjIHYgH8spsp7WMe0OGPREX8AK4hFJG6do6pnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555412; c=relaxed/simple;
	bh=Wft0/HyCZHrPXVEU9DhDMn4C7w8/vYtl2OR6qDCg4xQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=noyXCxbHUKhFtPRPCYNwbTHo2bRooKX8isu0nVW/a6Vwd81dljzGg+SuhGDJJ6kmUQ3853hMCeADN+GVd3mabi6WAfuVxGrWm4px657gan7f+DMMz8oUu5FObKJzo3PH0aiQ+8GebPmcGMAyR9gJhs3bSlxOcNNAbkNP7MVgCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4byL233TYxz8Xs7B;
	Thu, 07 Aug 2025 16:30:03 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 5778Tjin025695;
	Thu, 7 Aug 2025 16:29:45 +0800 (+08)
	(envelope-from zhou.lu1@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 7 Aug 2025 16:29:47 +0800 (CST)
Date: Thu, 7 Aug 2025 16:29:47 +0800 (CST)
X-Zmail-TransId: 2af9689463fbffffffffa6e-8b821
X-Mailer: Zmail v1.0
Message-ID: <202508071629474197f5yUjdjCHVE_fhh--5_c@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhou.lu1@zte.com.cn>
To: <mason@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBNYWtlIHNjaGJlbmNoIHdvcmsgZm9yIHJpc2N2NjQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5778Tjin025695
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhou.lu1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 07 Aug 2025 16:30:03 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6894640B.000/4byL233TYxz8Xs7B

From: zhoulu <zhou.lu1@zte.com.cn>
Add nop macro for riscv64

Signed-off-by: zhoulu <zhou.lu1@zte.com.cn>
---
schbench.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/schbench.c b/schbench.c
index acdb172..c8f9e56 100644
--- a/schbench.c
+++ b/schbench.c
@@ -1134,6 +1134,8 @@ unsigned long long read_sched_delay(pid_t tid)
#define nop __asm__ __volatile__("yield" ::: "memory")
#elif defined(__powerpc64__)
#define nop __asm__ __volatile__("nop": : :"memory")
+#elif defined(__riscv)
+#define nop __asm__ __volatile__("nop": : :"memory")
#else
#error Unsupported architecture
#endif
--
2.27.0

