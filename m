Return-Path: <linux-kernel+bounces-798830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A3CB42390
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63B834E1C47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97430FC33;
	Wed,  3 Sep 2025 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="s65R17bR"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093E2FB617
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909548; cv=none; b=HLI+yP+xZYEF3sWTF89/M/S/2pXmf1RMBRCl2JtOPj3yhDJ394R0wvPoopFaUZLhZoR1CcB/Uek9Lyke7d89l/Xg7ms/Piv49aSCj+Ttf0B9+/KHjCsDC3A0iTrETRU6Ptnx4dnXu71KhcMqCvIRu+yzdfMmvhHDGh8415FCtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909548; c=relaxed/simple;
	bh=dnPKUf1tRxvkBGYpB6SRXfAi+F5vNbqKi4NNlW6M/lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQtfROiFwkUTI03c14HhKHUKtpmwnUjYHTLRSHKVAXxbgUQUTmIhUa6Jv5cgMoZipZSNHE1gJpVReYJUewcPm6po5weItMz7b5/1hzU9HCEcmALBJtKAiGe5Q86ztymPf3qKQKtQTE1fmbksvEroCx+aCLJN6omkr/cm3P9KV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=s65R17bR; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id E18F0101C6DE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:55:41 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in E18F0101C6DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1756909541; bh=dnPKUf1tRxvkBGYpB6SRXfAi+F5vNbqKi4NNlW6M/lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s65R17bREvcU/wi7cz8gguueAJrZqzejqFXrbUUhtirS1AdooEsuzlAx9+NIr25oO
	 suqHdAy0/FzFQuraeZjtSIlKoFkfeCsbUf6UwXOQMwrnzY5qabMhFQwsL179fPB/TG
	 mLDgaXKgFo8m1UOkL13MQygNzjZnbzRw4iWEUOsU=
Received: (qmail 31915 invoked by uid 510); 3 Sep 2025 19:55:41 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.258572 secs; 03 Sep 2025 19:55:41 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 3 Sep 2025 19:55:38 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 063553414E2;
	Wed,  3 Sep 2025 19:55:38 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id A39901E8143E;
	Wed,  3 Sep 2025 19:55:37 +0530 (IST)
Date: Wed, 3 Sep 2025 19:55:32 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org
Cc: skhan@linuxfoundation.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH 1/7] rtc: m41t93: add device tree support
Message-ID: <18ee1fef01b9f09c250f29207ec02f22b55b935d.1756908788.git.akhilesh@ee.iitb.ac.in>
References: <cover.1756908788.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756908788.git.akhilesh@ee.iitb.ac.in>

Add device tree support for m41t93 rtc by adding of_match_table.
Define compatible string - "st,m41t93" which can be used to instantiate
this rtc device via DT node.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/rtc/rtc-m41t93.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
index 9444cb5f5190..4e803ff0ce49 100644
--- a/drivers/rtc/rtc-m41t93.c
+++ b/drivers/rtc/rtc-m41t93.c
@@ -191,9 +191,16 @@ static int m41t93_probe(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id m41t93_dt_match[] = {
+	{ .compatible = "st,m41t93" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, m41t93_dt_match);
+
 static struct spi_driver m41t93_driver = {
 	.driver = {
 		.name	= "rtc-m41t93",
+		.of_match_table = m41t93_dt_match,
 	},
 	.probe	= m41t93_probe,
 };
-- 
2.34.1


