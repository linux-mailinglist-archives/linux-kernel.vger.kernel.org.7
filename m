Return-Path: <linux-kernel+bounces-834640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A061EBA527A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD89322685
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6527703A;
	Fri, 26 Sep 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="BnE9cY9Y";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="F1iKsv5p"
Received: from mailhub11-fb.kaspersky-labs.com (mailhub11-fb.kaspersky-labs.com [81.19.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F448834
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.104.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920669; cv=none; b=iBYFCtqFosLcY1nvqlCD92sIMnScWfCOeko31a3VHMH5J/COOp0LJO9nG8itMZXmr6YBubylNPk7l7iI86mJ7WwCWpveqM9LLUQ6W6K0YD78q3stWa93KQ0gp2MwIbVOaXB6/nQ96aamgLv6e1uuXR5iARio1FgPONF4KgAKvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920669; c=relaxed/simple;
	bh=1vidAVltG/8YSPfWuy3MvmtUyAq1zVNdjok6cI6xuNE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qEE6t0ewWjyJQJ0d49F8Be7PaHSeAOvbvX+EITJtQ+O/zkE2cq2uuR+ORIfVK/4QvXQ+oFC7yo9Y4bYRrx3qGxiE0BIQNrb+e9VuzcdaYoT23b0oMDJxRmLhOJ7GJXhy+RYPeV9WBBFo+YjFo30O71wived3flt8yPSjrXgQTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=BnE9cY9Y; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=F1iKsv5p; arc=none smtp.client-ip=81.19.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1758920334;
	bh=rUqclJcLicKjxtPJ9COCQMcfmWgorZyY6uwV+tu84Ow=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=BnE9cY9Y/UUnRQfEh/JqFWzehd8gW4LBdMCTuSLYjh+l4rMNKloqQNAqz/8XlJozi
	 AGDvhafe1U8BFLdKCgPZLhR3XbYDfYjR6p0sVvQ/+seYOv6dx+gm+XykAT91WYW5v2
	 Gz4TmBJ0STHHdzdcEQJC9CkzCzqQ6iRN3bmGCg4CnQrC29/XudQcet7tsEECCEIjG2
	 IQBF1XrKJUP47aJ3xqygqhar/yDWYSQcgYoNubwGtgWdT55RhdAoBSi9unGFDE/93Q
	 iimcRKGw7p8D+ZDJNG0aHKQHasQlZiRPh7bRq6WgIti0KahoCwjzG9tdy9MvXrPT91
	 SON27BCJ0cRdQ==
Received: from mailhub11-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTP id ACA37E86208
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:58:54 +0300 (MSK)
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx13.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTPS id 74705E81A49
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:58:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1758920326;
	bh=rUqclJcLicKjxtPJ9COCQMcfmWgorZyY6uwV+tu84Ow=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=F1iKsv5pjznGTnsHRDnZNda0F1hTASyv+Dftk0kbuvCPiQuExADmWKWY96aLV9waB
	 FsteNwwDlad6woCKQdGfo1m0hqt8w4j/9Sxiho+oVdpFORLrVRYEAzkwiR8JQinw7I
	 KRmsVdrBNEO+o2R2moSXs24m2w/NWu/fTGNU2l10/2CXAmB6v9YDLSnapfPSEnl8+O
	 hBatveZOkF/Zc/vWM+sgVkzra64q4KhxxuA7nT/yMXiwgOpXN7yf3l2AwdpfDtgb9m
	 N0D3pXBnVCJkZ27kOK/Zsy8pI/U3hdWXBzVWxIDFOCg5rF9copenLZhKHFQgOz9hsJ
	 EqLjg01aCdryw==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id 491A73E264F;
	Fri, 26 Sep 2025 23:58:46 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 3F21F3E25D9;
	Fri, 26 Sep 2025 23:58:45 +0300 (MSK)
Received: from HQMAILSRV2.avp.ru (10.64.57.52) by HQMAILSRV3.avp.ru
 (10.64.57.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 23:58:44 +0300
Received: from HQMAILSRV2.avp.ru ([fe80::c3ea:4064:6675:4f29]) by
 HQMAILSRV2.avp.ru ([fe80::c3ea:4064:6675:4f29%10]) with mapi id
 15.02.1748.036; Fri, 26 Sep 2025 23:58:44 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: "w.d.hubbs@gmail.com" <w.d.hubbs@gmail.com>
CC: "chris@the-brannons.com" <chris@the-brannons.com>, "kirk@reisers.ca"
	<kirk@reisers.ca>, "samuel.thibault@ens-lyon.org"
	<samuel.thibault@ens-lyon.org>, "speakup@linux-speakup.org"
	<speakup@linux-speakup.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH] speakup: keyhelp: guard letter_offsets possible out-of-range
 indexing
Thread-Topic: [PATCH] speakup: keyhelp: guard letter_offsets possible
 out-of-range indexing
Thread-Index: AQHcLyhYVUw36WpDP066SFHvggEbbQ==
Date: Fri, 26 Sep 2025 20:58:44 +0000
Message-ID: <e6dc3bce87084fca83b0a0aa99d9ce96@kaspersky.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-kse-serverinfo: HQMAILSRV3.avp.ru, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 9/26/2025 5:58:00 PM
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/26 17:32:00 #27858547
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

From 40a3c73f21311521a510f2df4883296482707302 Mon Sep 17 00:00:00 2001
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>, Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Cc: lvc-project@linuxtesting.org
Date: Fri, 26 Sep 2025 23:17:03 +0300
Subject: [PATCH] speakup: keyhelp: guard letter_offsets possible out-of-ran=
ge
 indexing

help_init() builds letter_offsets[] by using the first byte of each
function name as an index via `(start & 31) - 1`. If function_names are
overridden from sysfs (root) with a name starting outside [a=96z], the
index underflows or exceeds the array, leading to OOB write.

Function names can be overridden with the following commands as root:

    modprobe speakup_soft
    echo "0 _bad" > /sys/accessibility/speakup/i18n/function_names
    # then press Insert+2 on /dev/tty

This fix checks the first letter in help_init(), and if it is not in the
[a=96z] range the function returns an error to the caller. Eventually this
error is propagated to drivers/accessibility/speakup/main.c:2217, which
causes a bleep sound.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a4efe6fd5dea ("staging: speakup: (coding style) Add spaces around op=
erands (checkpatch checks)")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 drivers/accessibility/speakup/keyhelp.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/accessibility/speakup/keyhelp.c b/drivers/accessibilit=
y/speakup/keyhelp.c
index 822ceac83068..df60a8b15a2f 100644
--- a/drivers/accessibility/speakup/keyhelp.c
+++ b/drivers/accessibility/speakup/keyhelp.c
@@ -8,6 +8,7 @@
  */

 #include <linux/keyboard.h>
+#include <linux/ctype.h>
 #include "spk_priv.h"
 #include "speakup.h"

@@ -120,10 +121,20 @@ static int help_init(void)
 	state_tbl =3D spk_our_keys[0] + SHIFT_TBL_SIZE + 2;
 	for (i =3D 0; i < num_funcs; i++) {
 		char *cur_funcname =3D spk_msg_get(MSG_FUNCNAMES_START + i);
+		char first_letter;

-		if (start =3D=3D *cur_funcname)
+		if (!cur_funcname)
+			return -1;
+
+		first_letter =3D tolower(*cur_funcname);
+
+		/* Accept only 'a'..'z' to index letter_offsets[] safely */
+		if (first_letter < 'a' || first_letter > 'z')
+			return -1;
+
+		if (start =3D=3D first_letter)
 			continue;
-		start =3D *cur_funcname;
+		start =3D first_letter;
 		letter_offsets[(start & 31) - 1] =3D i;
 	}
 	return 0;
@@ -137,14 +148,15 @@ int spk_handle_help(struct vc_data *vc, u_char type, =
u_char ch, u_short key)
 	u_short *p_keys, val;

 	if (letter_offsets[0] =3D=3D -1)
-		help_init();
+		if (help_init())
+			return -1;
 	if (type =3D=3D KT_LATIN) {
 		if (ch =3D=3D SPACE) {
 			spk_special_handler =3D NULL;
 			synth_printf("%s\n", spk_msg_get(MSG_LEAVING_HELP));
 			return 1;
 		}
-		ch |=3D 32; /* lower case */
+		ch =3D tolower(ch);
 		if (ch < 'a' || ch > 'z')
 			return -1;
 		if (letter_offsets[ch - 'a'] =3D=3D -1) {
--
2.43.0


