Return-Path: <linux-kernel+bounces-865160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D7BFC6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8777A6619A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14DA346E4C;
	Wed, 22 Oct 2025 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XtJc3VQ4"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EEF338904
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141107; cv=none; b=NKsmIGSOMyxxHz0cCYuOlH+GPKdEqZdCj2CW4K1/HvqCtolBRD1KXO8ye61n/7UH0XyW1cSA8G/ePpJgpl745Cnqzt8KNcn6XaZgTEea9kpTQL2eeD2AXiPOdKqMQr94yZVxgrICuMGid0IRQkh6ATPMeR16OnjJgGyTsCA3/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141107; c=relaxed/simple;
	bh=ahY8cqJej6WQifsWXROQdHcvhwcArd92M4vlAfVPn9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2DPzx0ROcY1KD65ov4I4XjTIxVnj8tj5vIsBpBZ6VH7r2Jk4TKG6GVRrMtHRNvDWtiqtdd+1UcoROVWa+Ivjgw+eh6Ep0pKqL7h23ZP9h071qOr8Q85tlCiJotc2N8H1kF+X0O2atUPKCNNpGrjMc/C9SfIv8sIupAFZYiZGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XtJc3VQ4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4711810948aso48886615e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761141104; x=1761745904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vpqXmEuFVERfrJK4S9HS5UBFe3EstmRsCR0kjyhhN4=;
        b=XtJc3VQ4buam0PEAiMSzB9Od4MuIHNt6op4X3JX/uV9O1MIyCyLw6qw3a2fN7Yn/6t
         t6cvgwCmXQ4qSZDqLTVusuNEHW3ajViBu0TRQIeH+x55FqmOnYhi5/3VJxUvNvL/K1gZ
         RtoKPD4/vUDCdc5uDuSWOp4PcPlfqRZCSxvw7XjY2Fcm5AAM6nncj9uzWiyUO9YRY2hN
         txbSgqALt4gJmB/No2NwnLMOvG+iM7DrGZzFYe/eX71NKgZKMZ2eNO/m58Ze93U8RefY
         ot6PeGSRJ6ggFt9eroqW6OdkAxNAi4ZHFFL4lMVFKe1IYfW6Sy9yB7JeZG2kBEXrXyrW
         wFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141104; x=1761745904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vpqXmEuFVERfrJK4S9HS5UBFe3EstmRsCR0kjyhhN4=;
        b=FZIH00GJxhv4QJOJeOef15UuH8NJZTUFVdR1Ss+6CJZ2f6oqx1IDF8dAnHYQlnptzD
         Cwp1oGYo5yuc8uJI+qDipsJVRDUGRG/uCCyOdwvcybLnzLpJxqDyGPWBp+zsHMVzAx8P
         Fujmnj6ht9e/Cx5/GYB1RGDZAfz/PDWYR30xmBuKQZW3RzlgcxskKlBDj6ZvGkTQtAUm
         aU9Tt5YrYx7qw9HN6FWEmYJ78stfGKZ8DnOqwoPgAsVOpxIePT1JQtQQsxouUzfTkUTS
         nDJcl2HGHunP+jBcxs1qBTlX7gY7h9r5xxcrX6vBgFkEjljKPWuyOXfsk+WH4d1Zxkyr
         mMbw==
X-Forwarded-Encrypted: i=1; AJvYcCXyhvE7Vyq9uEcgNVja8LTRh0KU0iLYl0zZWj6cwUuLQZjEhTC4HyuzEg5IoUj+j8ntfoRo8amQlwOJseM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFJF0Np/NJoChlYhQ4D7e22212bBxrDC5jOyDwJkLcJFXfAsH
	gpDrUoSQo65PzLyiUqgXwNtRurjSNM6yxm57E4YR6AL7v+Fhsn92qaL3q45FsgYN3qE=
X-Gm-Gg: ASbGncvNftHdBVKkoHrni+kCZry2uNvXsiYdEvlpS/kzwRiWOpC0yc6Ro6X0cmw7J1E
	YvkSQnP4r15XKGlvOjCMFYPCoepvxo9fXTczCHJaXXLmaOc+KkN3VBX+KDdGu4wAVxTl8cS545A
	bV+ZD/aevyCOEZElZiOzUtqGxASqcr7A3A8lR71Mt9CqZxmFzTB7OMEDKanmLjJGSkXwUmUMF46
	8solAMmDIuoQA7DND81jptPruDfMOjD0AnWjtuN6UvZm70/4m9lvSDK/S8WFSnqo47f5pQis0Dk
	70mFzGVdBz5X5NSWYdSQTQk7UPrLA1mHqOGySEq6NEH6LYnsB1qGRJS3QGcc9KkNw/lJH3gE/rQ
	mwKJ/4dHlsqe1cN1DU2Y34hbkgcihVq/ZQb+dyUFNKk2+EdlJHNl9K3bqstkF9/o8rBDgeQtW79
	jWYoTkz0srzwldlWg=
X-Google-Smtp-Source: AGHT+IHPzaVKrOun27QTyu8Z61wqMO2ufTRuV5m0h9jH3Uupa5Quc6C1+Oatewc83oC8toYDcSpSSQ==
X-Received: by 2002:a05:600c:548a:b0:46f:b42e:edce with SMTP id 5b1f17b1804b1-47117925db7mr141311515e9.39.1761141104344;
        Wed, 22 Oct 2025 06:51:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c2c9dasm38474625e9.4.2025.10.22.06.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:51:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:51:31 +0200
Subject: [PATCH v2 1/2] clk: davinci: psc: drop unused reset lookup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-da850-reset-lookup-v2-1-c80f03831f63@linaro.org>
References: <20251022-da850-reset-lookup-v2-0-c80f03831f63@linaro.org>
In-Reply-To: <20251022-da850-reset-lookup-v2-0-c80f03831f63@linaro.org>
To: David Lechner <david@lechnology.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=BEFSWjFwHX6uExLjBneDWL7iOS7pXsOG61qh122CNKk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+OFsK51ACOD/ph6HTgR/PWuteV0sKOsHzuDZJ
 rVM/PUWeC2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPjhbAAKCRARpy6gFHHX
 cp9qEADhDRVM3pxdk4GAGxN3WTBZRNwRovTMGBVfOIQyAY9cUZZ2Q2RrdObgHEvHzennf4cg358
 YtbRKs7E+NQMSevYJ02nXw/T2RMsySJZLFGmaNkvnLYNzE3xtRf1jmkWyhh1/T/SwKvjqGwCcgw
 XC4jUs8+qzUw9iuTUHyEtgEjtJ8kaG5i8IcPKAYOtrb+P+5H0kFMcpSPSzezYv0tpFGnXWoV2Nv
 a08L/ORJmUolVJpYfz3SMm68LoPKaMAA7kiF0yxG/zOCQ/QFsnLEbIC/IyionhnUGOonHWA1wPH
 NxhhlsVmUo0zQ8fFJuv4hZFz2Bv5mJuX0aBjS//X5D5zTbciEQEGv2maGIPnME5ZMUZEaOe4s65
 8/3wj4lHdnw3+4iJur2DPGLVdJpu31uRY6YMulT8+97TjELp+0HFAD3cVyYsvO2XKy6McfP13Tl
 itYf1fCdWkW93PMjqWKWFvdy/a/S/x9QUiHTFCLjpDSnVGe5+oSspfTtlqsm4d2EBUIXUdcwhK1
 EXjhzXpEKzTVclshLayBYmYFbZxip+thF24vYZEdncfgWoBAGM+gGuyZb3XZfGuejx/a5G/RG3T
 MQVRAGaWPjzquG7LjJzGxHo9iFbuFwmQkJt4YzxrfzgoE+IH8iv5rpLnLVzP/lhcMjCbMqrDj3E
 yLdYS1av28GX5Uw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We no longer support any non-DT DaVinci boards so there are no more
users of legacy reset lookup.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/clk/davinci/psc-da850.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index 5a18bca464cdaf3a0f3573cf9d70b79ca591cf28..94081ab1e68872d978e4cb162d8f9101de656d3a 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/reset-controller.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/init.h>
@@ -66,14 +65,8 @@ LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
 				"fck",	"ecap.1",
 				"fck",	"ecap.2");
 
-static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
-	RESET_LOOKUP("da850-psc0", 15, "davinci-rproc.0", NULL),
-};
-
 static int da850_psc0_init(struct device *dev, void __iomem *base)
 {
-	reset_controller_add_lookup(da850_psc0_reset_lookup_table,
-				    ARRAY_SIZE(da850_psc0_reset_lookup_table));
 	return davinci_psc_register_clocks(dev, da850_psc0_info, 16, base);
 }
 

-- 
2.48.1


