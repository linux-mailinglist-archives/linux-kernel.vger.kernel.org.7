Return-Path: <linux-kernel+bounces-739782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB654B0CAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE64C1AA7D82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5787226D0A;
	Mon, 21 Jul 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="w106IHoh"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B85A95C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124847; cv=none; b=fNVv1qbMeH4FsvvusFD+DhixxZdBRTmhEwDq8Uo67OQbPYE0ui8sUvg4AcfE3QxHhoo/BZLmXp/t/JlrZu5yTP6Eq7X1L6grnIfbx1ALq5Wp2vRRp1+z8Bzpe1MEud73xrtdpU8Lg7h7BR2F2Ja1vDPxwzVfS1EcxjtuH1kf9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124847; c=relaxed/simple;
	bh=NXP5NHVsGpWELSbR40KFa7hFqpvwth6rjNEAGSXfBtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZjxL7drfLjjaAaA2jejzvbEA2KoNmzeD1+h5IHk+/RfKMnOygoV4uG3QB9NyECnCM98HmUrGPRdsoWiZYnF22W3NoZ9yWS7qp8Q6bCxMlIzTk186NGhYw5QOdV1w2+/zM8CFdorqpF3XDLLmDb4IxKQ4rLNWJ0BVSU/wLvveDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=w106IHoh; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 8A1B4104CBC8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:37:22 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 8A1B4104CBC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753124842; bh=NXP5NHVsGpWELSbR40KFa7hFqpvwth6rjNEAGSXfBtM=;
	h=Date:From:To:Cc:Subject:From;
	b=w106IHohuBxNDHiEe/p3uAP47adKaV2YYoEEHn46UDIubPNk92jqAJWg9JTfDLavx
	 2oGR6ifvSO4SOqn1WlFqk4pGeStmY50Twyf7P1Mv0y3nDiDHs96dQNvtjqA95PsA6L
	 phc2yE+1UoKXJBGzxCfrjaa7YkMizh8u5CUyq0uA=
Received: (qmail 3119 invoked by uid 510); 22 Jul 2025 00:37:22 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(-0.5/7.0):. Processed in 4.222403 secs; 22 Jul 2025 00:37:22 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 22 Jul 2025 00:37:18 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id C9E2C3414E0;
	Tue, 22 Jul 2025 00:37:16 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 7C7431E812C1;
	Tue, 22 Jul 2025 00:37:16 +0530 (IST)
Date: Tue, 22 Jul 2025 00:37:10 +0530
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
Subject: [PATCH] clk: spacemit: ccu_pll: fix error return value in
 recalc_rate callback
Message-ID: <aH6P3lChCXhi3pe4@bhairav-test.ee.iitb.ac.in>
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


