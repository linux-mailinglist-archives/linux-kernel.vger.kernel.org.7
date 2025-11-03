Return-Path: <linux-kernel+bounces-882521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 234EAC2AA68
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 053B14E504B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B22E2851;
	Mon,  3 Nov 2025 08:55:11 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FF2253A1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160110; cv=none; b=bw/YgRqiCxNQSMvEA8kxpnRGZH/Dqg5n4tcBT9Ul92AYRRITCQwe2CW2o3j4w0YeyYJ5+GSufW9MwPQa31ZTvRXCWxkRKaQIxCl1foel6Nd3bwwoC2B9UYOT+XFdZ7JTnytIxECNur/XHebD/9wYKWhNOWi+jDMA3h8Mv4iNIh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160110; c=relaxed/simple;
	bh=DswA1willBQzbF6hAF3QyQvRhGbnRQbotxR22cAl3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CaLTyvpvRW5H1XPqJFsJXZQzdq9ZV0XCyXPLSToNA9TMuZhWJE7n7kJHnBmMfz8az7x8T3k9ayeCg58troRF2RyiOhDyBKj640ySwWPN2paUuOGsW6NKODgX3l4TSqrwanYu114ADx883vYNbwRybenKd11ULBE/xtyjg2jCdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee469086d28cd3-21d74;
	Mon, 03 Nov 2025 16:51:53 +0800 (CST)
X-RM-TRANSID:2ee469086d28cd3-21d74
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100149 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee569086d25130-ca7e8;
	Mon, 03 Nov 2025 16:51:52 +0800 (CST)
X-RM-TRANSID:2ee569086d25130-ca7e8
From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
To: reddybalavignesh9979@gmail.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] selftest/alsa: correct grammar in conf_get_bool error string
Date: Mon,  3 Nov 2025 16:51:46 +0800
Message-ID: <20251103085147.2276-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The phrase "an bool" is grammatically incorrect; it should be
"a bool".

Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index 5b7c83fe87b3..317212078e36 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -448,7 +448,7 @@ int conf_get_bool(snd_config_t *root, const char *key1, const char *key2, int de
 		ksft_exit_fail_msg("key '%s'.'%s' search error: %s\n", key1, key2, snd_strerror(ret));
 	ret = snd_config_get_bool(cfg);
 	if (ret < 0)
-		ksft_exit_fail_msg("key '%s'.'%s' is not an bool\n", key1, key2);
+		ksft_exit_fail_msg("key '%s'.'%s' is not a bool\n", key1, key2);
 	return !!ret;
 }
 
-- 
2.50.1.windows.1




