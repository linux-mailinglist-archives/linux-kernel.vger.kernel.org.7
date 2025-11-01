Return-Path: <linux-kernel+bounces-881045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E13C274AB
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72C5421B3E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10B224893;
	Sat,  1 Nov 2025 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mlB/RF9h"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4351F2BA4
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957917; cv=none; b=EoZHw7w9XHcUd9c+y3sBaRUOLqlWx6oWdqvzalkoHmqkqnlh1aF4am6WAUYtG+h98KWMJFGnZzWMi1b4W5kqa/AhKIGOBvMzQBYAvhmW/kd00Pb8WuDZsNjOo4Zb2imWcRQAaJ/h+GC7IPmCR4933EwqrUi5X2Lk1HDLS8Qm9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957917; c=relaxed/simple;
	bh=mDI6feqcRrUy3mbxyhCEd5Um1z0QOl3NJhKDJNC32X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzN7iwzjWPe7APYleWQ1QtrLHYGTjjUbQA1xVVgRKHbh7LDBT8QfsNc+/xjypU2DbgYjJ4r/S2WJJYnh6rzAlobXk9JNlatw4qnbCUIchn++RDWgQpteid8Rk/fIIhfSMBvyfHIem+Ab6EWIRgKP6MD8TRD6FipaoDFxZORYWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mlB/RF9h; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 67D6B1A17CF;
	Sat,  1 Nov 2025 00:45:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 399C46070B;
	Sat,  1 Nov 2025 00:45:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EC141181ABB0;
	Sat,  1 Nov 2025 01:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761957912; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rIIYHDjHQ2HoARYwD0t1QwRU8DtbVqJRz4i7rCEVP80=;
	b=mlB/RF9hex6Fd8YTOfwqDaY2Ln39X2s8SYJANS9IdxYqP+VK/wlgJ+0bPXSYiHugTyFZJa
	E/jTajTFbzazNJNToal3Z1XtrYcv0IctnUAsI43NgdYw27H/Odt1p1RDc1MDO0nEx66C3L
	tdJi/P8SgZblYGkb0VGH9/Vvtvos2ER5U5JPLQmmD+5o/LLKxsYPwUI19HeqMkfuVNNUCS
	pEwSGRunbjDnRtD/w0ZNcFMP1h5bLIzNufpoyh+g+8/RIJGkTBWFS3sQHH0HnAkbDGzjD2
	M6NmTSStMS8wiPEPQ9LwHNtW3WFOX+lZAxVXVG6rOPBzWekRQvdsVBUMbTF/OA==
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Sat, 01 Nov 2025 01:45:06 +0100
Subject: [PATCH 04/11] rtc: renesas-rtca3: stop setting max_user_freq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-max_user_freq-v1-4-c9a274fd6883@bootlin.com>
References: <20251101-max_user_freq-v1-0-c9a274fd6883@bootlin.com>
In-Reply-To: <20251101-max_user_freq-v1-0-c9a274fd6883@bootlin.com>
To: Joshua Kinard <linux@kumba.dev>, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

max_user_freq has not been related to the hardware RTC since commit
6610e0893b8b ("RTC: Rework RTC code to use timerqueue for events"). Stop
setting it from individual driver to avoid confusing new contributors.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index ab816bdf0d77..a238ead6cf1a 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -772,7 +772,6 @@ static int rtca3_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->rtc_dev);
 
 	priv->rtc_dev->ops = &rtca3_ops;
-	priv->rtc_dev->max_user_freq = 256;
 	priv->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	priv->rtc_dev->range_max = RTC_TIMESTAMP_END_2099;
 

-- 
2.51.1


