Return-Path: <linux-kernel+bounces-836191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79ACBA8F71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2BD7A8D13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D82FF678;
	Mon, 29 Sep 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="PNc7scS5"
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB92E7F08
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143839; cv=none; b=N6zlBWi2L6LBNr4jcdqJaeE3PNYe4MU8GFNFjXpKollDw90aOPDap+GqbbCKUidOjGtBALZHFVn9GfnwQHAMyAt9MCNuJm2KuoxQQScpfG6TWkHPAHruGeUl9YJYDk4ecqUHcG8c5gVe4XYWngsIwgmrL95GVHc67m7j3NbFH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143839; c=relaxed/simple;
	bh=TB2ojBmFdLXWhz3A0+LHXGjRZwD/Waix2LwkkiZcqX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gs+DCqIyOgQGF8gjGTLVkEiFjvJnfiOoNm2siBROVr0FVJxJhuvp5+0WlSGCNL5/BDp5yd5AZ185LkO2SzvI04tvKkHxXS9yEwvZOsBtkC5otVZFwg9jMWo388V4TirBP5JrK8qxenIYmjudMm8XpppIaz4+V6woZirmXvf1kRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=PNc7scS5; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1759143828;
	bh=ZvEBTnEXFJrSlq0riPNJukO5A9usPAiDKlI/3/S1AaM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PNc7scS52qQbl/UOjLqxufmHV3BP2XE/sKKjbQ5WjoQVMbirztL+zUxOpPfKtml61
	 jwobiXqVvZdA0MXVVQxI6WuaHOs62wWnlsujoZvEc3NlkLJtexfzYxs6kP378t5srA
	 YgSsBFRboHYhtRCnpZqJIipEWReYsusXXhAeQSY1/FQY0HdKbcbH9dJe+NrmC1Py0V
	 oexx6NeQsSDOStdZzIjT28n73kE/h6v2qgupDP5SU2XEFTCjK0DMKLWYaWSxrLVs1S
	 /2DpxCv7Sh9YjFb+5ZTx9oiU2msRrGTkd9/IliHow4Xnm44xqGXGNc6QaWdxwNrwQQ
	 2UJ+o2hm4XMcQ==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 84A825A16AB;
	Mon, 29 Sep 2025 14:03:48 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id 61A435A1771;
	Mon, 29 Sep 2025 14:03:47 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Mon, 29 Sep
 2025 14:03:46 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, William Hubbs
	<w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, Kirk Reiser
	<kirk@reisers.ca>, <speakup@linux-speakup.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] speakup: keyhelp: guard letter_offsets possible out-of-range indexing
Date: Mon, 29 Sep 2025 14:03:45 +0300
Message-ID: <20250929110346.2674287-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/29/2025 10:45:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196663 [Sep 29 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 67 0.3.67
 f6b3a124585516de4e61e2bf9df040d8947a2fd5
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: zhigulin-p.avp.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:7.1.1,5.0.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/29/2025 10:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/29/2025 10:14:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/29 07:44:00 #27864461
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

help_init() builds letter_offsets[] by using the first byte of each
function name as an index via `(start & 31) - 1`. If function_names are
overridden from sysfs (root) with a name starting outside [a–z], the
index underflows or exceeds the array, leading to OOB write.

Function names can be overridden with the following commands as root:

    modprobe speakup_soft
    echo "0 _bad" > /sys/accessibility/speakup/i18n/function_names
    # then press Insert+2 on /dev/tty

This fix checks the first letter in help_init(), and if it is not in the
[a–z] range the function returns an error to the caller. Eventually this
error is propagated to drivers/accessibility/speakup/main.c:2217, which
causes a bleep sound.

Fixes: c6e3fd22cd53 ("Staging: add speakup to the staging directory")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
v2: Use a proper commit in the 'Fixes' trailer. Remove the redundant
NULL check in help_init() and make it return void as
Samuel Thibault <samuel.thibault@ens-lyon.org> suggested during
review.

 drivers/accessibility/speakup/keyhelp.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/accessibility/speakup/keyhelp.c b/drivers/accessibility/speakup/keyhelp.c
index 822ceac83068..e632c53d6246 100644
--- a/drivers/accessibility/speakup/keyhelp.c
+++ b/drivers/accessibility/speakup/keyhelp.c
@@ -8,6 +8,7 @@
  */

 #include <linux/keyboard.h>
+#include <linux/ctype.h>
 #include "spk_priv.h"
 #include "speakup.h"

@@ -111,7 +112,7 @@ static void say_key(int key)
 			     spk_msg_get(MSG_KEYNAMES_START + (key - 1)));
 }

-static int help_init(void)
+static void help_init(void)
 {
 	char start = SPACE;
 	int i;
@@ -120,13 +121,19 @@ static int help_init(void)
 	state_tbl = spk_our_keys[0] + SHIFT_TBL_SIZE + 2;
 	for (i = 0; i < num_funcs; i++) {
 		char *cur_funcname = spk_msg_get(MSG_FUNCNAMES_START + i);
+		char first_letter;

-		if (start == *cur_funcname)
+		first_letter = tolower(*cur_funcname);
+
+		/* Accept only 'a'..'z' to index letter_offsets[] safely */
+		if (first_letter < 'a' || first_letter > 'z')
+			continue;
+
+		if (start == first_letter)
 			continue;
-		start = *cur_funcname;
+		start = first_letter;
 		letter_offsets[(start & 31) - 1] = i;
 	}
-	return 0;
 }

 int spk_handle_help(struct vc_data *vc, u_char type, u_char ch, u_short key)
@@ -144,7 +151,7 @@ int spk_handle_help(struct vc_data *vc, u_char type, u_char ch, u_short key)
 			synth_printf("%s\n", spk_msg_get(MSG_LEAVING_HELP));
 			return 1;
 		}
-		ch |= 32; /* lower case */
+		ch = tolower(ch);
 		if (ch < 'a' || ch > 'z')
 			return -1;
 		if (letter_offsets[ch - 'a'] == -1) {
--
2.43.0


