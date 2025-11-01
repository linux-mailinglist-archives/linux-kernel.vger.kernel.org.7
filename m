Return-Path: <linux-kernel+bounces-881304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE7FC27F52
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 699524ECD17
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A22F60C1;
	Sat,  1 Nov 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x22h1lm5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5A2C0307
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003634; cv=none; b=lCJ+n13+CArE5DKgtHOmKaDYtMZduUHsYEe0g9CEvSuDLyA7rO97wJhiI18oTxUPmXNEjvx0ZoHVtxAMEAbSM+fNQXDVg2/C+nlErCjmHzYosYMSJNDbpIsNpqHOor3NzdxVXmLMbceyPv5XwyNaT/h5L5d4cc/0ScexqHGPu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003634; c=relaxed/simple;
	bh=rprqeoJfwBpFW+gsXZSt/F8Jo8zBJ8y+vgAA/x/wPfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sM+5/8L9K8gb1g26BLzZWs6CyCzHIWPY7dT6NnBWakHeo0g6kHid56uUCznM5ldaOfq2jz6+mHKYdwngBtLdcUMiEjCXcSJ8pRvQJngNIZFFLMbhWhITG1qHb5S0w9wXcbrgdQK8mYxdfh89YUWcYWfJtd4oxp5cDR39uzCt6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x22h1lm5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso20547045e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003631; x=1762608431; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+EqGbBXvqXSCm047SOrrdUeNNQRu1BHO6Ywcm/gq0o=;
        b=x22h1lm5DK0LitEr4Owa7rw3LCi8ZLIK8d7/sM5Tfqy7I0jDq1crUIwPwAFO/VRntp
         1agobuX1KTagALULNM8fiU4xXwyw01sZS9WgTwFKyzOwX1BTRDQCMHvHHqnkoUY3hXY/
         UbRjAsILpWfXybMo6I+eQbCj4EBeCsOjd9BS92EwmRfYtjXGxyGlJqAU3e5lUMzn3LCE
         LshQcXH/dUcVUJYz7QPc5Tsr8/nqEkXJXRtWPnG3I3aOy2BiAmKFqsZGnjkUCRkzHosP
         f8aSrOgNldTSRN5o+H1OqNQz74iXpbBpLO1Cwvqk1+fpRIp8GplsbXz+enEyLQXE/P9e
         XOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003631; x=1762608431;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+EqGbBXvqXSCm047SOrrdUeNNQRu1BHO6Ywcm/gq0o=;
        b=CAiUTRw4Qvoq2E5WpUYoWNmwVkNPBtX12XKMYFFmaZJ8MBLr/cmLsK9BEuzhLHTuSp
         u2V+EeoJ19msOlXjegk1ZlKKYoxCS3sZhZB/IVrDWtPmnylIJmaCwDRMwKfRyUAjtnxf
         Bw52h6KOZpfZXG3l7T8mT6dpibABHXlkFtXESoIE5uTl4JixlfxYzO4XGOVsotD/jFuA
         NJRQNBfZ+2rqFjYnCLgAC1oBAQhJybsAAB7WQV8HrawF2y5d6yfgTjAgtzSAti+UI19k
         Xbm2Xm21oaW2+GlxSMDDmjAJZuq7XVlCT06XY6+EChZyaEv6t69VUmVXj0U4Nh6qFawt
         tZVg==
X-Forwarded-Encrypted: i=1; AJvYcCUPAepCfaHEpMiiWUeVQlvOlEtnRfGhlUrsq2dCI9lnWVOpaRrwXUkQ702rMstTupAtGbrPe5gqP9IxhLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qdFSRRBm1eaYlxtkbfM8Iggqzynat8yoPo3AETBYm9R0xw7g
	7WUdaE1PpYhAjoStftOmUIR/6oURSKG/pi06F0VAnsq731SsaA6LE5Aezn1ugv1PIVE=
X-Gm-Gg: ASbGncugCha5Tua3DWEtOOIwLRCjVxT9qemzoKtz3WPkF+lHbreWDhTGPpwsL6E73nh
	HVUfn7JvcKYzSSZaAGoxB0Ejyle7ORE5eShhsAxfuQigOdSQE5L7NZDoXSd1u6bGamV+n/dQJMP
	4hfmf6izHFTU68sQFf6dwzG0+52IMY7KSW7+TKVuPHnCgxxBOuvCpUrXYkzhTFGRS0UPN5BgL09
	aGPjxLw3fOubfjdXdQ5ZFR+LwqkHJIo+h3LT04rtSYQA0rnsKpUTwc6YyeWWHEACEkyakV5Hpnf
	MBHQO1xZPBTiwvxnL/g6xV47oPycd4FF/6vSlgZnTMK+t/ZXG1RRHq78TQ8IOVl6UU1/aVHmQMJ
	pdsyIQCmCYCL4XUGGXHGwlmNVO/KsGKmeWKH60BbJSjseBa1Pw7Sc/gMWlZsBuK7gq1GMLjt50u
	mAZkebRQ==
X-Google-Smtp-Source: AGHT+IFdb7/zkRruK0oXQCY8hr8gJ7/w3OO6SCISIKc7LTj9giiBqFQHOldEq9+NA09bcOurjb6I3w==
X-Received: by 2002:a05:600c:3146:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-477307af7e0mr52252055e9.10.1762003631249;
        Sat, 01 Nov 2025 06:27:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c55dc6fsm47729965e9.14.2025.11.01.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:27:10 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:27:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in
 probe
Message-ID: <aQYKqxD6qCQwFCye@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_regmap_field_alloc() function never returns NULL, it returns
error pointers.  Update the error checking to match.

Fixes: 58128aa88867 ("reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index eea56687cd0a..4ecb9acb2641 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -158,8 +158,8 @@ static int rzg2l_usbphy_ctrl_pwrrdy_init(struct device *dev)
 	field.msb = __fls(args[1]);
 
 	pwrrdy = devm_regmap_field_alloc(dev, regmap, field);
-	if (!pwrrdy)
-		return -ENOMEM;
+	if (IS_ERR(pwrrdy))
+		return PTR_ERR(pwrrdy);
 
 	rzg2l_usbphy_ctrl_set_pwrrdy(pwrrdy, true);
 
-- 
2.51.0


