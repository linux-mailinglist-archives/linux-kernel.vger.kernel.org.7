Return-Path: <linux-kernel+bounces-737700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95336B0AF8C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36798188FE33
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5175221F01;
	Sat, 19 Jul 2025 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="K+UoZQOX"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548623535F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923694; cv=none; b=C+u7H8r9O0Tan8rYIJloNVQqMxNS50+zuGRK73qzyK/tTEJz1edT9I22wi8mpnCSRFPK10shDZIY0JpP9A/c4mWQCW3FFWb6j/ZqAu5W0cZSi8ggeOVf9BWDh+Pg1yzqllOxjR78+LgwUwDqhrHR3zW+vwLt0spYfp5GIqNSDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923694; c=relaxed/simple;
	bh=+0kK/Y15aF1bpxFAxKzHM/pKrf3ofsKUM/hU9dOfhbo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mBW00Jv/soNAUNhONnNUK1sP3sxFIY+odXbjm+r4i6NWptt0tNNkKkSUVbv0dy8wn0RYr1sv7gn26DfjsN4OClCvPrM6ZSB5uIxLgql0T9WkAe41blWup9j6DrDlsO6uEx7jMjCSUipjPIaZebjf0rAEeLHbE4vy0TtE+RDzAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=K+UoZQOX; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 72989104C1EF
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 16:44:38 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 72989104C1EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1752923678; bh=+0kK/Y15aF1bpxFAxKzHM/pKrf3ofsKUM/hU9dOfhbo=;
	h=Date:From:To:Cc:Subject:From;
	b=K+UoZQOX3D6eH1OVq4E+TiIhdmB3havFN6P0wdgt239niSqV5a36XhpLCMzVdLpiw
	 7HUsRlJnfIJ1nn6FpSypYYC32sZnBkbcVOOfMUU6mUsxKCS4CC2I+rMApznQcB495v
	 b5DFUGiZyXq92yPX0aTwEyi4xB0gfeytvTEmTdHg=
Received: (qmail 27692 invoked by uid 510); 19 Jul 2025 16:44:38 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.975814 secs; 19 Jul 2025 16:44:38 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 19 Jul 2025 16:44:34 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id E50AB3414FB;
	Sat, 19 Jul 2025 16:44:33 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id BFD481E81340;
	Sat, 19 Jul 2025 16:44:33 +0530 (IST)
Date: Sat, 19 Jul 2025 16:44:27 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: zajec5@gmail.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
	tsbogend@alpha.franken.de, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] drivers: firmware: bcm47xx_sprom: fix spelling
Message-ID: <aHt+Ey5AQ0dsCuB4@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix spelling in bcm47xx_sprom.c as follows,
specififc --> specific

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/firmware/broadcom/bcm47xx_sprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_sprom.c b/drivers/firmware/broadcom/bcm47xx_sprom.c
index 14fbcd11657c..fdcd3a07abcd 100644
--- a/drivers/firmware/broadcom/bcm47xx_sprom.c
+++ b/drivers/firmware/broadcom/bcm47xx_sprom.c
@@ -404,7 +404,7 @@ static void bcm47xx_sprom_fill_auto(struct ssb_sprom *sprom,
 	ENTRY(0x00000700, u8, pre, "noiselvl5gua1", noiselvl5gua[1], 0, fb);
 	ENTRY(0x00000700, u8, pre, "noiselvl5gua2", noiselvl5gua[2], 0, fb);
 }
-#undef ENTRY /* It's specififc, uses local variable, don't use it (again). */
+#undef ENTRY /* It's specific, uses local variable, don't use it (again). */
 
 static void bcm47xx_fill_sprom_path_r4589(struct ssb_sprom *sprom,
 					  const char *prefix, bool fallback)
-- 
2.34.1


