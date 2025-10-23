Return-Path: <linux-kernel+bounces-866888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 670DFC00F38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86837506024
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D430F535;
	Thu, 23 Oct 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBZCTjHu"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9730F80C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220886; cv=none; b=Lp6oKtmnx8SF07dyBAP1XacgYABBt4GMC/flYZI9OhEJFI0AzESLHbNQYgTknldnlnLBEHwOuNM3ClP17jamIRXIYL/sR23b/ziWdt+3r/UZ81jiMxMPLjo8gOjOZcnIAi8yR6BQJT96Y9wNKewvM0QkzOLdA1lqtRjMbQZqRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220886; c=relaxed/simple;
	bh=Zotq3fevEEaXcuU8hejkE5kYpZkAzx5WWlia8hMMBWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+T6GbAl5EWg+iGqBZyQi4xjTEa24BGPhUgbO3fHs/y4NYOqEbJk/8vK2onlfNlQ1CZpjIeyL2DWeFGSwv1Xds6nInjORjs2pFcXoaqOLJ4utlFX6g/KisQBZ05MEac4iYqqjeTBWvsh/QkZo8KqCFvg/UK4vmkf6HwVcsGXviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBZCTjHu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471b80b994bso10071575e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761220881; x=1761825681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj+uhrCJRmw1vEgTPdOyAa9Y57LutVzk+TCy+Su0xUk=;
        b=EBZCTjHuYEwsgJRT9UCqFPsl6DeOQs2oZl3fk7/6pUvicQmI9DHqyIiBldJNzvjI7n
         tmtjMgj1beQ1h0V7oWlttJ97ZFvAhpwb+KCo5bjZmanyY+CKs1J2OH8wul0E7kx9kGdd
         OA65yGruHKpH9xgfwHGpgsSeQDWcl0qUFb3ONUeIJb7ol5/I5MPGct5mBTeUEgXk/CNw
         mKk/IAZTse6GZszEpU8EVVEVTCqpGc0kdHUhpd1Wyqh4S8JGg+Ro/67bdWbQbaUhhbNe
         Oag9LidA6r1Gvn458AL5+w3I0r+Qcyv0KWRBEHtYEQRaeYdMdpRS/Wq6cJ44IlAGCOLP
         kMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220881; x=1761825681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj+uhrCJRmw1vEgTPdOyAa9Y57LutVzk+TCy+Su0xUk=;
        b=o5d6l0cj799hDm42EQYwn4/vYxgUCOXuDtvblDez5fhPMjVDDYInM8W7ddzHCMz+ta
         pHOXnmQ6RDF5IHDwLW4MAkKyJkPmGQLKUHJp8qpCvaDMr9wN7rcWiBZgRAV9+NPeSx1h
         zwcWdMfdBMYlgtzfwQxYsiXsgJ9Ngq5rykEJ1yuPmOWhatmdadJfz8+niMTPiN723JHp
         q9I0H+Tqy5rBY1TZ+uR0NimTu8WpKgxju4XW8wko45lqV6se2p27vzd3uKixzuNUv/yJ
         ObxI/iTUVWBnmYph/AXrbVU3OPTW5yiSp840Nj1lhA3J4XnXeOLRt10O4DH6OMy/jSco
         259Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDqZcxK7ad6a/2kzQI++g6V+91aC8YEAU+q1NN1qNGl87iSVmZ8s4xbrHzrLa6dd7xDNFIMO3/LmF1u40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMafkykaSBxI/4iXqkfSvf1KikQ3qNouh+EdffmcWX2/YyisZ3
	8Js27/d5P2oCXx0d0YjluCgmjtAhAjacfoJclTwzMkPd34LYTJ3CTE5A
X-Gm-Gg: ASbGncvfcVrAQRro9B+kir+I8ZF4TWSa4OJG/KZgHtfWwVoRxL2ZuPfkBAR0nFRQzA0
	K6NCY95HgSMq0HWPObrKezil4klws5iJMyCaFeM9lFFUtbTEgukllKLzJ0f8Yb11XdUr+CxERqq
	3B5P9WQ7u8UDG4d2gtcLaLh42LSNMg5SAgGTQJA3QZ/6m4XqDAMMLQDq+MlQ6riE4BJc7z1RmQZ
	7Yu7G8kefcLN6SK6Ws5LmXd/6LehnEvNhqaUkoO17r4R4GxCr6G69iZ1vkmIg9JIgT2EBwhUbgP
	DBcHIT3275G9c3Vh3/RCk75C1IpqljT41q12cBElqxpfIuzbdFGg1DHGYgo6t8DKinSIOU4tDbc
	1l0UQkBo1HfAqKeBSnloQ35vZBqETn8L8q9iIWuH5eI+g/77QKU4xFN7RD9BgAr/iH3bwwxBA9O
	vQUmlE
X-Google-Smtp-Source: AGHT+IEAwBT5oX5Ux4d4Xzd53uHX6f335aO5mjfogtAT2bZBhloBaRh03Cpwn/YtNrO9Oeox9rjkYw==
X-Received: by 2002:a05:600c:820b:b0:46e:6d5f:f59 with SMTP id 5b1f17b1804b1-47117878465mr182388585e9.4.1761220880791;
        Thu, 23 Oct 2025 05:01:20 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c43900e1sm109604435e9.17.2025.10.23.05.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:01:20 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v9 1/3] i2c: pcf8584: Move 'ret' variable inside for loop, goto out if ret < 0.
Date: Thu, 23 Oct 2025 15:00:41 +0300
Message-ID: <20251023120043.8661-2-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023120043.8661-1-chiru.cezar.89@gmail.com>
References: <20251023120043.8661-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require spaces around '=' and '<'. Add spaces around binary operators.
Enforce error fixing based on checkpatch.pl output on file.
Move 'ret' variable inside for loop. Then check if (ret < 0) goto out. This
improves usage of ret variable.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 41a81d37e880..06b9fd355bff 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -183,7 +183,7 @@ static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	int wrcount, status, timeout;

-	for (wrcount=0; wrcount<count; ++wrcount) {
+	for (wrcount = 0; wrcount < count; ++wrcount) {
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
@@ -272,7 +272,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *pmsg;
 	int i;
-	int ret=0, timeout, status;
+	int timeout, status;

 	if (adap->xfer_begin)
 		adap->xfer_begin(adap->data);
@@ -284,9 +284,10 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		goto out;
 	}

-	for (i = 0;ret >= 0 && i < num; i++) {
-		pmsg = &msgs[i];
+	for (i = 0; i < num; i++) {
+		int ret;

+		pmsg = &msgs[i];
 		ret = pcf_doAddress(adap, pmsg);

 		/* Send START */
@@ -321,6 +322,9 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
 					    (i + 1 == num));
 		}
+
+		if (ret < 0)
+			goto out;
 	}

 out:
--
2.43.0


