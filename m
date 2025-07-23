Return-Path: <linux-kernel+bounces-741872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3B7B0EA12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12001C87DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0BC248F5A;
	Wed, 23 Jul 2025 05:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="MOafYYOw"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B0F238166
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753248622; cv=none; b=s20n1vNe0JXT+jcuOzAS5VGtEnXOKBd/xo5K1w/uQBy63CjgWs/PYxs62Ms+g7HgqxvGSHbPwNarqMpkEPYwKHmfQu9BSe/Y2rxlr9o60dHb/H/Gf8s7EoAysdZzWeWvEYMB/2JoqrNHLaS52+VSZXM/J/D2+27YZgTeSImIGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753248622; c=relaxed/simple;
	bh=o4QgzqTBBnUc7wLsm/2kW3soQ4NatWqYiTC9EV+Uq+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l4HV5ud0CKX8poYiPosfqYfAQa8JTCf0hL11ds5qwTsUFrwC+6tBZXAJaF21vsojv6ZbL54k6XSH9a4tPfR8nvoJI9GVpNtDF/++jk/XzPP5vDvBqabKkleg0kAUQVY7ycsjZTdPFhDy6XztiK20Y9P9AvuAsnTq/ZGNF9qAX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=MOafYYOw; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 85AF71080236
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:00:07 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 85AF71080236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753248607; bh=o4QgzqTBBnUc7wLsm/2kW3soQ4NatWqYiTC9EV+Uq+s=;
	h=Date:From:To:Cc:Subject:From;
	b=MOafYYOw79qQucX81r9LQF+Ec7ynt3g2Rvw8/cSySiFSLdCZnK3ABHUdK6MYDVMIf
	 UxUX7wqJUeWlnjb7dOlcT0z37ix1nb+WYk0cpPJnZXWoel/SfKjTJQVCKUFnYgJ8Gp
	 Fki1krcxRssbRgjvEbrXQtikJ4P1ezR/LlvSarbA=
Received: (qmail 6639 invoked by uid 510); 23 Jul 2025 11:00:07 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.901731 secs; 23 Jul 2025 11:00:07 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 23 Jul 2025 11:00:03 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 323A134151D;
	Wed, 23 Jul 2025 11:00:02 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 0CE721E81366;
	Wed, 23 Jul 2025 11:00:02 +0530 (IST)
Date: Wed, 23 Jul 2025 10:59:56 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: mturquette@baylibre.com, sboyd@kernel.org, dlan@gentoo.org,
	heylenay@4d2.org, elder@riscstar.com, inochiama@outlook.com,
	akhilesh@ee.iitb.ac.in, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heylenay@outlook.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	unicornxdotw@foxmail.com, jszhang@kernel.org,
	zhangmeng.kevin@linux.spacemit.com, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] clk: spacemit: ccu_pll: fix error return value in
 recalc_rate callback
Message-ID: <aIBzVClNQOBrjIFG@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Return 0 instead of -EINVAL if function ccu_pll_recalc_rate() fails to
get correct rate entry. Follow .recalc_rate callback documentation
as mentioned in include/linux/clk-provider.h for error return value.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Reviewed-by: Haylen Chu <heylenay@4d2.org>
Reviewed-by: Alex Elder <elder@riscstar.com>
---
v1 --> v2: 
  - Add missing Fixes: tag
  - Carry forward Reviewed-by tags
---
 drivers/clk/spacemit/ccu_pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
index 4427dcfbbb97..45f540073a65 100644
--- a/drivers/clk/spacemit/ccu_pll.c
+++ b/drivers/clk/spacemit/ccu_pll.c
@@ -122,7 +122,7 @@ static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
 
 	WARN_ON_ONCE(!entry);
 
-	return entry ? entry->rate : -EINVAL;
+	return entry ? entry->rate : 0;
 }
 
 static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.34.1


