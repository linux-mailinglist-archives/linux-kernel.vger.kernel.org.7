Return-Path: <linux-kernel+bounces-739776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0BB0CAC5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF763BA8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54245221277;
	Mon, 21 Jul 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="fgrNnZVu"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B7221F12
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124389; cv=none; b=KRQ7uG6M27W3Kzb42PbvOTZYjHh8MRTSFDsj+XoSgrx3o6AxNMw7oZnFISI1/SbxP5KMKOa/B8v2LXjssCkCw33OZ863oPEc22HRT1sjfrjeriJRR8zBPupUXqJw2yea4LGTA3RkGmBtkHpymvHHvDLS4gF6//6qpC4db6zU+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124389; c=relaxed/simple;
	bh=HGLwuU4D+TUfqsZVVo04GFZdHAqGvPqWRxCyM/vPrtk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vm30ibE+ECHXMWiZBw+14X85M01uKNB5XB0D8Bf6lL53OMJogsHyGkqBofTg/36UD9TBxXs0sC/YHaPNgmtBiZ3agE2CRLHlOrV2Gmif3lQCQBztU3iWNjkz3RTW9mmiI9s41+q9XJv+EvagoS7evPe6Tf/rsOkN79SLpDJC2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=fgrNnZVu; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 8073B104CBB8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:29:34 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 8073B104CBB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753124374; bh=HGLwuU4D+TUfqsZVVo04GFZdHAqGvPqWRxCyM/vPrtk=;
	h=Date:From:To:Cc:Subject:From;
	b=fgrNnZVuxHtNXvQhEzFgZbSMESSpacQkPL5pPuuKDddyUMZ3qThYSKgeHDbwQLgXC
	 f450tK2nYV4C0VXVNK+LGdmMVFctzHDdoIzdZruGdFwODVi8Z6rVODSAJ4yPwWoxcU
	 Qp4k5G3hCkj9vNvRm3vx6DO7UKMDYnf+BmB5HnRY=
Received: (qmail 12007 invoked by uid 510); 22 Jul 2025 00:29:34 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.105765 secs; 22 Jul 2025 00:29:34 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 22 Jul 2025 00:29:30 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 390F036003B;
	Tue, 22 Jul 2025 00:29:29 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id CA8801E812C1;
	Tue, 22 Jul 2025 00:29:28 +0530 (IST)
Date: Tue, 22 Jul 2025 00:29:23 +0530
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
Subject: [PATCH] clk: spacemit: fix error handling in
 ccu_pll_set_rate/_round_rate
Message-ID: <aH6OC1aV6IcQnoSC@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Initialize best_entry pointer with NULL in ccu_pll_lookup_best_rate()
to avoid returning garbage value when function fails to assign it
a valid rate entry. Avoid passing invalid rate entry reference to
ccu_pll_update_param by adding appropriate error handling in
ccu_pll_set_rate and ccu_pll_round_rate.
Address the effects of uninitialized pointer as reported
by smatch and coverity static code analysis tools.

Addresses-Coverity-ID: 1649164
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202505111057.ejK2J56K-lkp@intel.com/
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/clk/spacemit/ccu_pll.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
index 4427dcfbbb97..3fc6a30f98b7 100644
--- a/drivers/clk/spacemit/ccu_pll.c
+++ b/drivers/clk/spacemit/ccu_pll.c
@@ -21,7 +21,7 @@ static const struct ccu_pll_rate_tbl *ccu_pll_lookup_best_rate(struct ccu_pll *p
 							       unsigned long rate)
 {
 	struct ccu_pll_config *config = &pll->config;
-	const struct ccu_pll_rate_tbl *best_entry;
+	const struct ccu_pll_rate_tbl *best_entry = NULL;
 	unsigned long best_delta = ULONG_MAX;
 	int i;
 
@@ -107,6 +107,10 @@ static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	const struct ccu_pll_rate_tbl *entry;
 
 	entry = ccu_pll_lookup_best_rate(pll, rate);
+
+	if (!entry)
+		return -EINVAL;
+
 	ccu_pll_update_param(pll, entry);
 
 	return 0;
@@ -129,8 +133,11 @@ static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long *prate)
 {
 	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_pll_lookup_best_rate(pll, rate);
 
-	return ccu_pll_lookup_best_rate(pll, rate)->rate;
+	return entry ? entry->rate : 0;
 }
 
 static int ccu_pll_init(struct clk_hw *hw)
-- 
2.34.1


