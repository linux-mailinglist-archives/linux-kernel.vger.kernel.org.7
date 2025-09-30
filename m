Return-Path: <linux-kernel+bounces-837657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB15BACD8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30F23A77BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314262F5A11;
	Tue, 30 Sep 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbfAOzad"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB126059E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235561; cv=none; b=Adnl26999z73nqyfjpDD/wt5BM3BmwEj3Cc2AAe+V1r2LxjiYIg8LICzK4NVVvXO2cSBxfCvXCJuLzPrEluk764Br9Ylhz4bM7jWzr62HMTZdaN1tdm/aFyvxo0VZDqs0mLGsXHtaD+CWcex8joTwSu2WuviJ1l5uWCV7UQiqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235561; c=relaxed/simple;
	bh=YCihytYoFEPvc+LW3TD22q+/WXxZuDSV1H6/KH+fhMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bi9tqnI5vbU2fwwZBYZxLXp+idbKjwAsqbHvmPq8IMXo0B2TKermxUa7Nb48xoZGaST+6lTQSAYvCRiDwFAsnSa5rvALjhOZWSPZRVk96+TJHhZIhuS+Mj6XcZ4WvjX+9TdI7lxFO1sLuk3mqvtzHJrOImmmutM9I3CnWTzPGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TbfAOzad; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso43954045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235558; x=1759840358; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oo5sOp/6AYH4FHUPQLIVvo5r8GtAmL8I6jk/YzlSnfk=;
        b=TbfAOzad01ZGUUEA5Puh2vae6b3Knm7lZVFTy/q3yOFnUfokFrxjLTW+wHr3lKTXXj
         eHhvvyy601PkwxuBjSCGn7op/FmGXHg7gexZmf0fTafo/1CmQ/su8CXYUxqzgsAo0T2T
         m4mRgGknjA/FGhzASGqk/cslGBPjozhvqwZPPIU2o6o7PzUCGjwY2vX4KghbP3maBVvC
         Lso7BziW28iqmzAl1dBJRuFUjWaUGbEziYyif6KkCAi/93ACF+alCRqCh/2x/X1c4Vqx
         FqYvzMS4EBg2iMTqvQ9Fc5b8MfSxhHj8FpVmgxwAvVpwQc3jvir07Qm9MeBVEmWfzwiM
         yD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235558; x=1759840358;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oo5sOp/6AYH4FHUPQLIVvo5r8GtAmL8I6jk/YzlSnfk=;
        b=RxkWQR0IPdEQnNOl6FOb3ldG9nl3XWcZTmURhWL368ajS0TOMj5W2BVgaeav1P5Mfr
         fHKDxOTXooofDCdxP48Vp9ruC6YK1DEWd9UXyKYySO7vQbk+405oQvGZnYrwMNFinrIY
         0U0HSJYf6Ps05nQcm7FVrcF37g4z2ohGi85FrvN37CYHASP1W/nLCgGcHZX5Co8y5yfb
         9pXz9UHVtI0rrzKQbTbi3V72IGVGR293fWnVbz5XzBSv0FEAy0Fmc1ZgY/AEh6LSvoTJ
         hVkhKJGHuWI2zUR4b0uQ9S7UDfOwKfbWbM3inDzPhiHJTo6Z2lH4tEhovOHwW4Wk8wih
         wfbw==
X-Forwarded-Encrypted: i=1; AJvYcCUBoOA1ZCDNIXMecFqFBtDrhXhsKIt3CHaNK36PC/+wDYEdEXgCB4XGvNdz8ZyJrvaEge0LazFP/xmQI0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkcsNvlwvaAXP7giRY2R6H45u9G7KtQR21Yzk4cfvZIAIBCTtq
	pEKN9tUBBlfBYMgsI1CPxtxVV00zViaetJ3Q/08EZtw4UPvAs6VzTPOtJ1hwsuzQJEU=
X-Gm-Gg: ASbGncsBVp7Lo72hKSxeumhrIIs2nxsi9Lmk2FSTuIdjTMu9Qi3yTXKHdix3elvr94r
	5fWcHVCqDlXD5E+uv+WJH0RIbC+zrXACBoMoaQOzWvl1dKRi5roxhslN/2uL5wKLxdjrAhrKZj8
	ASMBgYw9gW4YzIB8HcjOB0srffgw2usQCYFUyD0+av8+DEIOfQ/y5qelY+Vv4upICWYZmoEs1CO
	wZdFn0f2BpZScRSU90ddEHrUOxJCtahA9RdoQ+m1Kh78HBBD/akC14TBDPtm2HhFOS4xzTUZs7D
	4XeuJoXwS+mqszg5EcyoGHlzDQ6X1aTtjsek1MysCmLXy5ixGMDR8Wj4/s/uo0LSQodr4cg+E++
	gXg3oyF6TDWZhPPePvlfEzbDhzAXBFKSd6t2PKKcJ8dAeYDssTLXpS9G25KSW5cc=
X-Google-Smtp-Source: AGHT+IGtnuuyKdDtHZCb3YIUp4ExKAmej4+wqFfGXxKG2xkl3FbcmieoXV3KE7JoIKB5oOnwCudRlw==
X-Received: by 2002:a05:600c:154d:b0:46e:4581:6634 with SMTP id 5b1f17b1804b1-46e458166eamr108608805e9.29.1759235558058;
        Tue, 30 Sep 2025 05:32:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e5707c1e7sm54805665e9.21.2025.09.30.05.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:32:37 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:32:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 resend] mtdchar: fix integer overflow in read/write ioctls
Message-ID: <aNvN4kfJ2ROB353Q@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The "req.start" and "req.len" variables are u64 values that come from the
user at the start of the function.  We mask away the high 32 bits of
"req.len" so that's capped at U32_MAX but the "req.start" variable can go
up to U64_MAX which means that the addition can still integer overflow.

Use check_add_overflow() to fix this bug.

Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: fix the tags.
RESEND: I sent this last year but it wasn't applied.
https://lore.kernel.org/all/Z1ax3K3-zSJExPNV@stanley.mountain/

 drivers/mtd/mtdchar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 8dc4f5c493fc..335c702633ff 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -599,6 +599,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 	uint8_t *datbuf = NULL, *oobbuf = NULL;
 	size_t datbuf_len, oobbuf_len;
 	int ret = 0;
+	u64 end;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -618,7 +619,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 	req.len &= 0xffffffff;
 	req.ooblen &= 0xffffffff;
 
-	if (req.start + req.len > mtd->size)
+	if (check_add_overflow(req.start, req.len, &end) || end > mtd->size)
 		return -EINVAL;
 
 	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
@@ -698,6 +699,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 	size_t datbuf_len, oobbuf_len;
 	size_t orig_len, orig_ooblen;
 	int ret = 0;
+	u64 end;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -724,7 +726,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 	req.len &= 0xffffffff;
 	req.ooblen &= 0xffffffff;
 
-	if (req.start + req.len > mtd->size) {
+	if (check_add_overflow(req.start, req.len, &end) || end > mtd->size) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.45.2


