Return-Path: <linux-kernel+bounces-762565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FA1B2087B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749C3189937C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747CB2D374A;
	Mon, 11 Aug 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="sfYKCNVE"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66326AE4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914388; cv=none; b=lZGkjtzYfMj+DNCEnLR3EhKgruJko4kurA9i+ZuKsxVaquAk0i46UFqcv+QpTZkmqESe6mNN+wbnBGx6jAm4bvojIxhCR8VGAgB49vUvcQ2OtnOS2JYp4VYVcfZp3mo3gRhGvvnMizcmN5VfLRHnEzAGzm9kx+gu+BjdqeeMKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914388; c=relaxed/simple;
	bh=vy1TiHFzMihHofGuhUHPAugI0HDLQ07AGmn7vIJUx00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RYOLrZkPnAoqQQ6+vMGsZuz7oTmAGTeMVUD4Bo8jqPGuw0Z49RPLb9Ak1ay3p+aFr1+nwZC4CyNw6pw1OiNWokr/5CLEQ61GmIDAbYcRLCQA3PjJs/C97ViiMRsc2vfM7IcYlhF/IlPDmuyxbu6pCdSFirrnbyorkwXTTm1RX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=sfYKCNVE; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 5BDA6100906E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:43:03 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 5BDA6100906E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754914383; bh=vy1TiHFzMihHofGuhUHPAugI0HDLQ07AGmn7vIJUx00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sfYKCNVEV54LiTvFDMlRXtuJ5bUPxuNIb6eIyq84lmb6hnKxTbh5b12dtoA4WcHiN
	 C5Jm7ZQV6MKtuofAqKtV+TWga8naPM2tVW5/JcSuDDwXsaPoBaQEKNU72ou71GdER2
	 xf8SYm+7nuTPwYCSRApo6ProIl7kR/lo6snKBUmg=
Received: (qmail 9798 invoked by uid 510); 11 Aug 2025 17:43:03 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.30062 secs; 11 Aug 2025 17:43:03 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 11 Aug 2025 17:42:59 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 7E96836003E;
	Mon, 11 Aug 2025 17:42:59 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id C70941E8135B;
	Mon, 11 Aug 2025 17:42:58 +0530 (IST)
Date: Mon, 11 Aug 2025 17:42:53 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, gmonaco@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH v2] include/linux/rv.h: remove redundant include file
Message-ID: <aJneRbHGlNFg7lr9@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnc17BSsDOnfNwg@bhairav-test.ee.iitb.ac.in>

Remove redundant include <linux/types.h> to clean up the code.
Move all unique include files inside CONFIG_RV as they are only needed
when CONFIG_RV is enabled. Arrange include files alphabetically.

Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor") [1]
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202507312017.oyD08TL5-lkp@intel.com/
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 include/linux/rv.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 14410a42faef..9520aab34bcb 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,16 +7,14 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
 
-#include <linux/types.h>
-#include <linux/list.h>
-
 #define MAX_DA_NAME_LEN			32
 #define MAX_DA_RETRY_RACING_EVENTS	3
 
 #ifdef CONFIG_RV
+#include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/list.h>
 #include <linux/types.h>
-#include <linux/array_size.h>
 
 /*
  * Deterministic automaton per-object variables.
-- 
2.34.1


