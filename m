Return-Path: <linux-kernel+bounces-858495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B4BEAFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895847466DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF452EB87F;
	Fri, 17 Oct 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FRJWoxxi"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DB2F1FC0
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720508; cv=none; b=Of3UYy8LGV0YCxMa5YMNfCQal4CLPZNC8kYo0+qJgH5MrmW87/FIMJMgYSuya6wtbVg1CCXVC9/tmXKe1cJ2OuUdMYCiLK5eLDm7X2iBLo156y7rBjD/600GOLtx5GitPkGkSJwjZqbpk/cV4nIvgutEjxI1oBRLgxtJnWUExtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720508; c=relaxed/simple;
	bh=M/X66MrdqwJ0xx8LyEmRfcGpFypBx2+2f5OjufIkI/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upHfxXPRlnOAg5B4oSU6tYjiahdchrASmbnvjhS8mvJ1hX3ZMiSIo614mTNajie0f5++rZINiJpOmbbBkNDMet+TiwmaIK1Z1knfQlp97J+dXoftwpp5I8ARclX44roWKLNmIw1KKPqlIkaXMK9Uy1oLyLsNRaXzDTZJ2/IVsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FRJWoxxi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760720504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HtGxsl9KBwFYgKugQmeSF+1IJOEqfOMdHSXrp8PgR+4=;
	b=FRJWoxxitkB1z+sa6IBIxhccaiDSRS5wsT4lN2uwiMf2Q9x+KjLX9KOY3vmuCftIInAx9y
	noP/N7Oyt/y0hlW0vCfn2raIxIMfcKH+P1Blc3DW1+GLWz1CIii+BNfhE3qaCuXvhP4KDf
	tQEpCnuNzADofUGdMph5jJIHTCV5qe4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: therm: Replace deprecated strcpy with strscpy in alarms_store
Date: Fri, 17 Oct 2025 19:00:43 +0200
Message-ID: <20251017170047.114224-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated because it can overflow when the destination
buffer is not large enough for the source string. Replace it with
strscpy(), which avoids overflows and guarantees NUL-termination.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/w1/slaves/w1_therm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9ccedb3264fb..fcd7aab5b52d 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1849,7 +1849,7 @@ static ssize_t alarms_store(struct device *device,
 			__func__, -ENOMEM);
 		return size;
 	}
-	strcpy(p_args, buf);
+	strscpy(p_args, buf, size);
 
 	/* Split string using space char */
 	token = strsep(&p_args, " ");
-- 
2.51.0


