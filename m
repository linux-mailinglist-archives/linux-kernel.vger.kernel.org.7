Return-Path: <linux-kernel+bounces-772483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DA2B29341
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10520196484E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99522422A;
	Sun, 17 Aug 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="oE5dVwGs"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A6156C79
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755437050; cv=none; b=Te0QMrHRf4+wWWs8lpNMs7MDo2uUTEcY8Ax7czUma0LKn+4KPyvNUCxBtBQTZV3v4EDV2ZMtZonUYibovu7bU5/85zsX+FQSg3rFUyCJ0R6nnGzrWz7ENkdVxkL5lVo2RtBGczV8QTP9q/shRZyYYt/ErD1R2cHRxLWlFHgIgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755437050; c=relaxed/simple;
	bh=dwI2EqS3uxPuQNUeInCEVXykKpigJ889rm6XcPxiuKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jz+cct3up/4r7k0DBpAC7c9ka0J2sRE3QhI94yYn/uoIbwbYOFNqEu+JTia1thnhwomT+ULDoKvqZPDERnE8/wV2wW3guwZEZwjb72iCx+UICMdL4SxBGdH+WsA1HwPM/d51EGDxcXE94VbWfumtBKNOlTSlLO73PiqirW1oLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=oE5dVwGs; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 78D5D104C1C8
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 18:53:59 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 78D5D104C1C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755437039; bh=dwI2EqS3uxPuQNUeInCEVXykKpigJ889rm6XcPxiuKA=;
	h=Date:From:To:Cc:Subject:From;
	b=oE5dVwGscTBNQqqRGDp8BnhKbsGxSO0tLOYwAnvqqQGt0eeqokT2CAGe5/RJQCnra
	 +nxK7A+Xyr8SAQbnKoa97Tpn9yZDFm7qUYZVwkSwphcuHQBlVXRLSALhu5wjTEI7nv
	 sX0Mixcq8tn8j77Cjb+NHwTGX1p4Z9t9ZNNod6to=
Received: (qmail 9956 invoked by uid 510); 17 Aug 2025 18:53:59 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.283592 secs; 17 Aug 2025 18:53:59 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 17 Aug 2025 18:53:56 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 864F13414E8;
	Sun, 17 Aug 2025 18:53:55 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 4B6A91E812BE;
	Sun, 17 Aug 2025 18:53:55 +0530 (IST)
Date: Sun, 17 Aug 2025 18:53:49 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, sj@kernel.org, dakr@kernel.org,
	mic@digikod.net, masahiroy@kernel.org, corbet@lwn.net,
	clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: [PATCH 0/2] samples: timers: hpet_example: Improve user experience
Message-ID: <cover.1755436239.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all, 
  This patch series improves user experience for
samples/timers/hpet_example

PATCH 1/2 --> Add support to print help text if user does not provide
required arguments.

PATCH 2/2  --> add help text in timers Kconfig

Testing: 
I have tested the changes on x86 with hpet device as follows. 

1. Build the sample program 
$ gcc hpet_example.c -o hpet_example

2. Run hpet program with no args

$ ./hpet_example
-hpet: requires command
Format: hpet_example <command> </dev/device_name>
Supported commands:
        open-close
        info
        poll
        fasync

Example: $ ./hpet_example info /dev/hpet

3. Run and verify hpet commands on /dev/hpet

$ sudo ./hpet_example info /dev/hpet
-hpet: executing info
hpet_info: hi_irqfreq 0x0 hi_flags 0x10 hi_hpet 0 hi_timer 0


Akhilesh Patil (2):
  samples: timers: hpet_example: Improve argument parsing
  samples: Kconfig: Add help for CONFIG_SAMPLE_TIMER

 samples/Kconfig               |  3 +++
 samples/timers/hpet_example.c | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.34.1


