Return-Path: <linux-kernel+bounces-760981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8568B1F293
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12E958148F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 06:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408C1FC109;
	Sat,  9 Aug 2025 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="qU8NdC0O"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6871C4A13
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754721402; cv=none; b=aysEVgY2Jg9jao4bHZWER56gKb+Tj2MSAoHrutM58k8gR3rmtDPCj7S0Hd8C1wKCgpvE5dgvuwzX9jg0S3FYsKf2ICcB694cqUeA5fPpl0X8L/2rfMIVpMZ/ujGYzL7DsjVqEaStOzVzT+rsP+XaPaQN83B1lpCYPsSJkkqdI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754721402; c=relaxed/simple;
	bh=Ho91ac16/KHECqo1eDShFW3v/Gslza3laABM8iHK2Po=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IHfOEn1Ph4NDj78bLhLqMMzMBwgEJp+WEODqfig4nAr6APOFw1CL1jr80KjnH1tSbN5fXcNMjOUnXUZDDTr3vaQeFkRcmwVJrGD7UOX3k568PywbyLCqZ8Fjah58nECVND276LC9OG0oUXMHDJVfO54ViODuxLPEok20xftkWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=qU8NdC0O; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 26ED2104CBC3
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 12:06:29 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 26ED2104CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754721389; bh=Ho91ac16/KHECqo1eDShFW3v/Gslza3laABM8iHK2Po=;
	h=Date:From:To:Cc:Subject:From;
	b=qU8NdC0OI9MrhiDLmeH41uW2hPx+Yq7tx9R9RnoctTbmdtuUaWnggCzGIhzkqoKYv
	 PBR+g38/67WXGY8I1zEsSdZkZs0dqSsBc4NLSR3sh5YLP6U9Ajh+FLQjVEQVK7tseH
	 +lFWL0A55T5U59WL/dmmYKywRLEQ8WTyN+er2FGM=
Received: (qmail 9486 invoked by uid 510); 9 Aug 2025 12:06:29 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.44074 secs; 09 Aug 2025 12:06:29 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 9 Aug 2025 12:06:24 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 32EC6341555;
	Sat,  9 Aug 2025 12:06:24 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 00C0D1E813ED;
	Sat,  9 Aug 2025 12:06:23 +0530 (IST)
Date: Sat, 9 Aug 2025 12:06:18 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, gmonaco@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] include/linux/rv.h: remove redundant include file
Message-ID: <aJbsYkON4V4iFPFG@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove redundant include <linux/types.h> to clean up the code.
Fix this redundancy introduced by commit [1].

Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor") [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202507312017.oyD08TL5-lkp@intel.com/
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 include/linux/rv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 14410a42faef..8b968b8ed77b 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -15,7 +15,6 @@
 
 #ifdef CONFIG_RV
 #include <linux/bitops.h>
-#include <linux/types.h>
 #include <linux/array_size.h>
 
 /*
-- 
2.34.1


