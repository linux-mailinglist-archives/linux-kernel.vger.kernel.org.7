Return-Path: <linux-kernel+bounces-772485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 166A9B29343
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA497189F078
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B536B23F40F;
	Sun, 17 Aug 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="hc531iyA"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2D22422A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755437101; cv=none; b=PJBzaO+VCRtbP7OtOIizeh3u1lX/xqh+l5q4lZ8vq1gabdwKuHI2SfLJRSU7DeS56UuSPHFoi30irvch7Np7baKCGpRmT80otDgjFpembqiFkXIf/Ze4EsCCrfRRKbR3dGdWEcunMX1zs6Nava1fvCY3YgmP0SLw4Ye8Ulh56T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755437101; c=relaxed/simple;
	bh=OROuJNJzQ2BgsKW/9oNSaV+l41kA9cdebrwy10ypnvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi80k+pY1nCFDKFHC+M+0LRv/JZTJ9lmPjt/mKm341rtrpLEj+eQqfgXxyKlgWAWRrDYMMRRLUY/i98sR16q9hRYdD1fx321NVnRqJ/eqRog9G1NY0+LRFdAIvIF5r4+wpWHtZvj3hY0uhUlKNHm6X9tH8ji4UhtydRju8bpCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=hc531iyA; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id A3E59104C1CD
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 18:54:56 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in A3E59104C1CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755437096; bh=OROuJNJzQ2BgsKW/9oNSaV+l41kA9cdebrwy10ypnvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hc531iyAqoGoJXaFXtfQ86xW6pvfpQNSrfTVHeW2w0LVfv8qoBJtsZOL0NZGQimGV
	 FT0StPqvEJSTDpGUwRucZSYt/KHqJmZTqp3OGqI+KRd+vFzwpAJFWouT68wTl/6Wzt
	 7Wfd3ssW7mPiEvjW5VTOWdYN/wFtCQQ7e9skaGpQ=
Received: (qmail 3911 invoked by uid 510); 17 Aug 2025 18:54:56 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 0.648672 secs; 17 Aug 2025 18:54:56 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 17 Aug 2025 18:54:55 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 59F4C36003D;
	Sun, 17 Aug 2025 18:54:55 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 069261E812BE;
	Sun, 17 Aug 2025 18:54:55 +0530 (IST)
Date: Sun, 17 Aug 2025 18:54:49 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, sj@kernel.org, dakr@kernel.org,
	mic@digikod.net, masahiroy@kernel.org, corbet@lwn.net,
	clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: [PATCH 2/2] samples: Kconfig: Add help for CONFIG_SAMPLE_TIMER
Message-ID: <70135ca4b145d3812c4e715e3f7e608e855ac4d0.1755436239.git.akhilesh@ee.iitb.ac.in>
References: <cover.1755436239.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755436239.git.akhilesh@ee.iitb.ac.in>

Add help text in samples Kconfig for CONFIG_SAMPLE_TIMER to help user
selecting this configuration.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 samples/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 6e072a5f1ed8..84ce196c2eb8 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -183,6 +183,9 @@ config SAMPLE_SECCOMP
 config SAMPLE_TIMER
 	bool "Timer sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build sample programs to demostrate timers.
+	  Currenlty supports High Precision Event Timer (HPET) sample.
 
 config SAMPLE_TSM_MR
 	tristate "TSM measurement sample"
-- 
2.34.1


