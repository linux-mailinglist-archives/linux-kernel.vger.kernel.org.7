Return-Path: <linux-kernel+bounces-772484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82FB29342
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB744E32A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EDA242D84;
	Sun, 17 Aug 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="YDEaX09C"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8261F4192
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755437074; cv=none; b=Y0wKwlfiX4BYaPTgZeT0SPT3H/2Z2KHUel1x5ak/C3/4NaQdcf9mkuvaeDlTzYWzS4Pn2dmKiBsucn6qqFklFaix8ifAnPkkgnvdrBCJiCpNS9EYgrnauAdn8GkL9RVWkc7acBQDi5czjwBmA8PLR1pKQ7lt37DOnSAp3BilQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755437074; c=relaxed/simple;
	bh=Ld701GxTfQlzcvRfa0960/I3LzjJHLC8+BXMrNyz/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE0isIQ1UqHpaGT3wyzT4e+f7rAddXvAcFSjwJt8z9RWPar7n/ZXzacj82LK4jyPI55YyCigZtaInnKWNVOx695XWSUqxHZ5/IZCDk0WX7afHLFuJHpLz1PRghxLZ7Rdd4oWUFEkfQtDSr+Tsgl44HKU1zh723gyp9qe0pAi5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=YDEaX09C; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 83976104CFE4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 18:54:28 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 83976104CFE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755437068; bh=Ld701GxTfQlzcvRfa0960/I3LzjJHLC8+BXMrNyz/Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDEaX09Cg+xsERTsiVRdR4k064jZOcTYAmNSdz0gmuY6492mufUVFNjHuiW11vyPb
	 QTwzp56OGDqOApGsTJdIli3/olc9tK90jQFuR5VlblliuxGMtFwkiDlkG4SiWCWLTq
	 Z+du1KoX34fd45gOEkw5+rq2Gw2l1+zdMTYfMxpo=
Received: (qmail 10074 invoked by uid 510); 17 Aug 2025 18:54:28 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.361896 secs; 17 Aug 2025 18:54:28 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 17 Aug 2025 18:54:25 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 886993414E8;
	Sun, 17 Aug 2025 18:54:24 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 4096C1E812BE;
	Sun, 17 Aug 2025 18:54:24 +0530 (IST)
Date: Sun, 17 Aug 2025 18:54:18 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, sj@kernel.org, dakr@kernel.org,
	mic@digikod.net, masahiroy@kernel.org, corbet@lwn.net,
	clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: [PATCH 1/2] samples: timers: hpet_example: Improve argument parsing
Message-ID: <9d7c4f95d6ab5ac9eed77026ab0abcc420587f91.1755436239.git.akhilesh@ee.iitb.ac.in>
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

Improve user experience by adding helper text while argument parsing.
Print format of the command line arguments for the program along
with example invocation and supported commands.
Define and use ARRAY_SIZE() macro to iterate over command array to
improve readability of the code.

Print as below upon incorrect invocation:
$ ./hpet_example

-hpet: requires command
Format: hpet_example <command> </dev/device_name>
Supported commands:
        open-close
        info
        poll
        fasync

Example: $ ./hpet_example info /dev/hpet

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 samples/timers/hpet_example.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/samples/timers/hpet_example.c b/samples/timers/hpet_example.c
index f1cb622f6ec0..59474c7be576 100644
--- a/samples/timers/hpet_example.c
+++ b/samples/timers/hpet_example.c
@@ -25,6 +25,8 @@ extern void hpet_read(int, const char **);
 #include <sys/poll.h>
 #include <sys/ioctl.h>
 
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof(x[0]))
+
 struct hpet_command {
 	char		*command;
 	void		(*func)(int argc, const char ** argv);
@@ -56,12 +58,17 @@ main(int argc, const char ** argv)
 	argv++;
 
 	if (!argc) {
-		fprintf(stderr, "-hpet: requires command\n");
+		fprintf(stderr, "-hpet: requires command\n"
+			"Format: hpet_example <command> </dev/device_name>\n");
+		fprintf(stderr, "Supported commands:\n");
+		for (i = 0; i < ARRAY_SIZE(hpet_command); i++)
+			fprintf(stderr, "\t%s\n", hpet_command[i].command);
+		fprintf(stderr, "\nExample: $ ./hpet_example info /dev/hpet\n");
 		return -1;
 	}
 
 
-	for (i = 0; i < (sizeof (hpet_command) / sizeof (hpet_command[0])); i++)
+	for (i = 0; i < ARRAY_SIZE(hpet_command); i++)
 		if (!strcmp(argv[0], hpet_command[i].command)) {
 			argc--;
 			argv++;
-- 
2.34.1


