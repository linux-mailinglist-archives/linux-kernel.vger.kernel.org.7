Return-Path: <linux-kernel+bounces-886907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD0C36CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025E7646587
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C2320A00;
	Wed,  5 Nov 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IX5UN3AF"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0153446A1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359586; cv=none; b=p5aode+H1V7dplOvCp6gaR0iC5KrrShenEAZdONI3Ad7lwIlSzF9/JSwVQvLYKGFgLBgHkSzy23T8m1zI2EO4e0ozo0/Flhwzd/CLyXrQ/s/cjfydGxIXNHpaAmdfqlrDCmO3S1HCSmT6pU6pieEiFh70fwY7tRA4U+bPiEjjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359586; c=relaxed/simple;
	bh=HQz5SnnVBBmIr9NFy4bOMWNIthX6lBxyXHlG+m12DvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZ4ImP86SerBUASmILPu3UYKitwrWlqGcQuTVDQWMLo+aUP7JFoM5/7lF+6C431dTJfyUmD/nobfa9GmOHiQAfPYuQ4Gi2Tm8VKzHj5oBvBxC+5uvjau9w05qN/NukBbZUjqmP2KOfYpiGYjuQSDyBuk7/ha0TxxRad7MqY5/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IX5UN3AF; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762359582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vQHE6vE7vCyQo0ohgxZYSqnQcVATDtIwkrBLkp2T8As=;
	b=IX5UN3AFK+J0MfvH2INvbIQRjzd+2GO36Uk+V4M02bci6pMGL2PVOGAsjVdsLmV1zjqecH
	HVv811YMR2iX7eCnYdlSXKWAr2olgQglhFPf3BLshvW8DumHWxVIGZPcHip2ygV3Zsjdb1
	XLNfuxwozk4fEDXq/zNT99muMG19/jc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: therm: Use str_yes_no helper in w1_slave_show
Date: Wed,  5 Nov 2025 17:18:56 +0100
Message-ID: <20251105161900.43042-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace hard-coded strings with the str_yes_no() helper function. This
unifies the output and helps the linker with deduplication, which can
result in a smaller binary.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/w1/slaves/w1_therm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9ccedb3264fb..0b54ab7f237e 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/hwmon.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/jiffies.h>
 
 #include <linux/w1.h>
@@ -1609,7 +1610,7 @@ static ssize_t w1_slave_show(struct device *device,
 	for (i = 0; i < 9; ++i)
 		c -= snprintf(buf + PAGE_SIZE - c, c, "%02x ", info.rom[i]);
 	c -= snprintf(buf + PAGE_SIZE - c, c, ": crc=%02x %s\n",
-		      info.crc, (info.verdict) ? "YES" : "NO");
+		      info.crc, str_yes_no(info.verdict));
 
 	if (info.verdict)
 		memcpy(family_data, info.rom, sizeof(info.rom));
-- 
2.51.1


