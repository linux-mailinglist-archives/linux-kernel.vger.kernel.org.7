Return-Path: <linux-kernel+bounces-754230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AC6B19023
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F48189B735
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47B1FE474;
	Sat,  2 Aug 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Cnpyzw0E";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="mVDq2Sb+"
Received: from e3i331.smtp2go.com (e3i331.smtp2go.com [158.120.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE11E89C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754170382; cv=none; b=S8hJ3g3183oRYX27KdGV/Mudvd8EguimdYyeulX5a1jttoxngRvxgNThsnvYn+FrMU6jKRodc6Pbx6kF/FPJwFfb4+ECGEAxPjK9qFfxOA8oQ6pQsQBoPIUle6rSAPwjAhphCLC8yqGcs05cjhuOe1E3aPWksGs37wWFVYzuhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754170382; c=relaxed/simple;
	bh=GLhv/T2dtFQ3GlTlK7o9Bmk4Du5gnHqSjrhT57Tn/uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOJax/JOJV5l1h1L0QgKKtXpu1e3SJDkQsOUT8rB26yl9yWrBwKtnNGdywwDVk6TtUTyJ/NEh2aQf6GUzziQ89k5mFm64yfn+mTr91mB5aISc9KUT1DzYLc924p1v01i7q4p5yxyRzXD8FYxnQ2WdB1zinDPsV+Vnan/2wP8RK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Cnpyzw0E; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=mVDq2Sb+; arc=none smtp.client-ip=158.120.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1754170372; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=AcX9VcErMWRg0sR1MbexnWdLJ0Tu14req403gJypbmc=;
 b=Cnpyzw0ERrnF9L/z5xrWiPFXABbT3msdz2D0fGqQnVPYbkfeQG1geddr2PguAPXQrrrw8
 fFauOYaybKVN+pDYuQdq5QqQpD60wXaMQV7zL7tD3Bft/cKVdx3XrE3w9EdEtdzx52gU5ym
 fFLLpcebo537ngbaBUvGT8cL7CyDeNCDrNjlYLEsWmirdCc1ViNH7/MYR1NhMW624P/VF/7
 X/y6WSrpQyRQX1uT+YijcCmUqwToS15MNkjaHPPNyWrMoZejJqm1SiaNwXEWo9F0pp9ONE3
 OoEuqgH78CiIaq4aMUb+N6cu8GO5Z3aMt9TE1y3923QeVFAcGXFVjirdW7GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1754170372; h=from : subject :
 to : message-id : date;
 bh=AcX9VcErMWRg0sR1MbexnWdLJ0Tu14req403gJypbmc=;
 b=mVDq2Sb+RZ2OpwN+Oz19g63CFSHPBipjwenvwpS8jjX+g36XMbSn1x3YsZXfPOh/2wBcs
 cu0iXIMm5Lb7a5qZ7FIHEKyxmFDGsx4VHlfpA1/RNqESq4iYNu+YNSxZeJJ76RRAABD0nAB
 GudoREzhhyo27/wZ9C4d4h18D05r4t6xldM37LNTiMmIJPtNZQGDYe/CFkSSXnIbEkKJAdj
 zRwGh376yWbilA7LF3DPMc3xgceyppkXbelQH8SQkEZWAPRnbB43/dKRgqDDzyBpAGjzxIB
 q4FudtQD6GG2aVrUZyT9gcm5dINpiFS+0VQOM9xZw82cfiFtBAgf168oJMPA==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uiJqP-FnQW0hPvggj-NCpg;
	Sat, 02 Aug 2025 21:32:46 +0000
From: edip@medip.dev
To: dmitry.torokhov@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>
Subject: [PATCH 1/2] Input: Add key event code for Fn + P
Date: Sun,  3 Aug 2025 00:21:50 +0300
Message-ID: <20250802212149.16707-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sMNE8L0U3Q
X-smtpcorp-track: pl_EmhEiMkJ_.jWXWn_ZZUgdS.niTljA7LzA0

From: Edip Hazuri <edip@medip.dev>

Newer Victus (and probably newer omen) laptops contains a "Fn + P"
Shortcut. This is intended to use with Omen Gaming Hub, Which is
changing the performance profile when this shortcut triggered. This
shortcut is shown on performance control page, see [1]

Currently there is no key definition to handle this. So add a KEY_FN_P
keycode define to be able to use this shortcut.

[1]: https://jpcdn.it/img/adadf6c927ffeb75afd8038f95db400a.png

Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 drivers/hid/hid-debug.c                | 2 +-
 include/uapi/linux/input-event-codes.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 4424c0512ba..2bcf7b24801 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3342,7 +3342,7 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_FN_1] = "Fn+1",			[KEY_FN_2] = "Fn+2",
 	[KEY_FN_B] = "Fn+B",			[KEY_FN_D] = "Fn+D",
 	[KEY_FN_E] = "Fn+E",			[KEY_FN_F] = "Fn+F",
-	[KEY_FN_S] = "Fn+S",
+	[KEY_FN_S] = "Fn+S",			[KEY_FN_P] = "Fn+P",
 	[KEY_FN_F1] = "Fn+F1",			[KEY_FN_F2] = "Fn+F2",
 	[KEY_FN_F3] = "Fn+F3",			[KEY_FN_F4] = "Fn+F4",
 	[KEY_FN_F5] = "Fn+F5",			[KEY_FN_F6] = "Fn+F6",
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 3b2524e4b66..2fc79b32425 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -548,6 +548,7 @@
 #define KEY_FN_S		0x1e3
 #define KEY_FN_B		0x1e4
 #define KEY_FN_RIGHT_SHIFT	0x1e5
+#define KEY_FN_P		0x1e6
 
 #define KEY_BRL_DOT1		0x1f1
 #define KEY_BRL_DOT2		0x1f2
-- 
2.50.1


