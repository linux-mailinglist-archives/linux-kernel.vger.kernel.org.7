Return-Path: <linux-kernel+bounces-762394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4FEB205F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECA32A018D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66E6245019;
	Mon, 11 Aug 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzXvTaVS"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A3239E82
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909033; cv=none; b=OiRqhR6e/OBv9KrNYcNm4oY8ShuRgrf2JsYX/x8WNOjAxyAdxwQxavHsuYbbcAxIwxi1M0z/f4RGkwVvtnismDkr90e26UCPnScv73wvM4JqDN9F/owLBqvyRM7n4v2+M891PeXUfsoP6nWm/4LQsKpq2gScBBapmROrF2eFwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909033; c=relaxed/simple;
	bh=jjqXaXgDKY6odzDCw+MVbdVk4B3G+zBmo7YkF3nHZYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V2dgC+TyKv6xIlSscVx3+3QdTlZ0Ks83A6lVfXzxmg+9YzF7/f4clvgIKXb5W+FVsZ2vb8kNFDwqZ1FaxauUrij6WjvPPQaoumyU/i15pFiLxfmnBHnmPQEQn89Yue/ac2yVps8oFcdGl24njTu75AykXn5Oc01RL7Exv/kzDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OzXvTaVS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78294a233so3636132f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754909029; x=1755513829; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOPcfPUvQvOcfMF7KghzUxDLwNBuyBOE7Sg8u+9nTqY=;
        b=OzXvTaVSAnT0WLWTeZiXo3UgTbx6h9GqUjYAD9zSO4yudh5fnd4Vu9Bjn/TpHvSSjT
         oAmtUx0TK3rA/5Cqo5EsIOKupOhwALxrsQEsH9wQHVLNWpd1O7C/qip3SaXsGxUa7Jt3
         DmjY1uDQmHcqcWvUV6/Qi7AIBwrpyMS2wstAckYllWeRCh4y9j1ILBUuxIHax5aYtXIy
         PxkiwH4C1cqWb99eg63GiUr0NBJv2eKk4qwYXyrYdb00OnEX+bQ93HntDJR/e0a5o5e/
         0DoOTXqmBSPDrVBWgcDovchdL5amKOm6NGYg2QARnhw8O2qFOOrHad2P91CO+8Snlep7
         5WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909029; x=1755513829;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOPcfPUvQvOcfMF7KghzUxDLwNBuyBOE7Sg8u+9nTqY=;
        b=tnLDiXuviTlkUkINepKiTCYpgucHYrTrFJAQ23tBYXF3f1mHhqeD7aoc93oHeL+ZCn
         dVUYsnAZEVb1OFLsJTqgMVuqLorDb7oKQ++xSfMyOTkW5NbcXooE9GluHHGEI8l3VXB4
         yHyHTjOoAKJsWh+ZG0fNgoIWwUqFAYLhiJmLf9PRuOCEoibxjteJ3gbbi/74HV/832E5
         UVH4CmqinO+i/edgcsjcb+LSn6aiM2v57K0ORmbPxuhPLV4KbqBN+WeX0ZpycUhH4Hv4
         C8cedqpLV/YP0pWJuvxaW53uHNDOvib46KowGUlvHS/vj3bnAQSv79pcM/H7DC5Q3sbu
         naSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU9aXVpzCgI+D2OC+ZvYSXgYmkMAeybD4Xbt7n40/YyivQDI8CVuprZWgWzuTXlSlM2LQr4c8HILkoQBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRXUaoP6Bw34k/3R7D3ENykH8UYMTkZLRZkvZHGMObh0XcjCM
	1jvsVr1/mXYlSCnpSfxkbplXei7rBD2XShW5LvHq8Ij2FR8wvbWrCb2MQ4pI5u1JUso=
X-Gm-Gg: ASbGncvJuoNXZoQU18pPGEtbx471B61mAZ0xrz/CX75i/ziWxTnKiA6su00osyzGzlu
	X4ETFIAqw/qeBH/XN6jXwSamuLK3m4P/NzNMI9JlrpaWsK0/XKqYwXn3tkKJ7ldp2WqG5Sj/TbN
	Ef3d460dmKoS6bAr7fZ16PBKzR5FEF7uQuANzY7EMG4uLJRbKgtYCNvT5lGRLqb5Zzg+5hyf2XF
	CLba1PntCcI5ipy1vw8BiHowYDAK3wl9eUlGLX068O28/WiZvAlRuH0Cy5YyvaD9tDTd5ROBgNK
	sB1mLP0lBkCuX+xyf6yF/QfNjxcnXBfJkwg5VAWgGamaFPITxjELrejGnmGStX/JUuQ4xwZzal+
	LLBW3VKRfS8Joctv+4Vz+htLaYo/mNhyP
X-Google-Smtp-Source: AGHT+IG0ravrynpY15kze3mYxWIzwLW/5/aen3QDh1FeTgm/ACIuqbr2R1w9fseNZY6MZKwA1ZpxfQ==
X-Received: by 2002:a05:6000:1ac7:b0:3b7:6d95:56d2 with SMTP id ffacd0b85a97d-3b900b449b0mr8903590f8f.7.1754909028830;
        Mon, 11 Aug 2025 03:43:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459dcb86d6asm299844695e9.5.2025.08.11.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:43:44 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:43:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix double free in idxd_setup_wqs()
Message-ID: <aJnJW3iYTDDCj9sk@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The clean up in idxd_setup_wqs() has had a couple bugs because the error
handling is a bit subtle.  It's simpler to just re-write it in a cleaner
way.  The issues here are:

1) If "idxd->max_wqs" is <= 0 then we call put_device(conf_dev) when
   "conf_dev" hasn't been initialized.
2) If kzalloc_node() fails then again "conf_dev" is invalid.  It's
   either uninitialized or it points to the "conf_dev" from the
   previous iteration so it leads to a double free.

It's better to free partial loop iterations within the loop and then
the unwinding at the end can handle whole loop iterations.  I also
renamed the labels to describe what the goto does and not where the goto
was located.

Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
Reported-by: Colin Ian King <colin.i.king@gmail.com>
Closes: https://lore.kernel.org/all/20250811095836.1642093-1-colin.i.king@gmail.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/idxd/init.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 35bdefd3728b..dda01a4398e1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -189,27 +189,30 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
 		rc = -ENOMEM;
-		goto err_bitmap;
+		goto err_free_wqs;
 	}

 	for (i = 0; i < idxd->max_wqs; i++) {
 		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
 		if (!wq) {
 			rc = -ENOMEM;
-			goto err;
+			goto err_unwind;
 		}

 		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
 		conf_dev = wq_confdev(wq);
 		wq->id = i;
 		wq->idxd = idxd;
-		device_initialize(wq_confdev(wq));
+		device_initialize(conf_dev);
 		conf_dev->parent = idxd_confdev(idxd);
 		conf_dev->bus = &dsa_bus_type;
 		conf_dev->type = &idxd_wq_device_type;
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
-		if (rc < 0)
-			goto err;
+		if (rc < 0) {
+			put_device(conf_dev);
+			kfree(wq);
+			goto err_unwind;
+		}

 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
@@ -220,15 +223,20 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
+			put_device(conf_dev);
+			kfree(wq);
 			rc = -ENOMEM;
-			goto err;
+			goto err_unwind;
 		}

 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
+				kfree(wq->wqcfg);
+				put_device(conf_dev);
+				kfree(wq);
 				rc = -ENOMEM;
-				goto err_opcap_bmap;
+				goto err_unwind;
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
@@ -239,13 +247,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)

 	return 0;

-err_opcap_bmap:
-	kfree(wq->wqcfg);
-
-err:
-	put_device(conf_dev);
-	kfree(wq);
-
+err_unwind:
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
 		if (idxd->hw.wq_cap.op_config)
@@ -254,11 +256,10 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
 		kfree(wq);
-
 	}
 	bitmap_free(idxd->wq_enable_map);

-err_bitmap:
+err_free_wqs:
 	kfree(idxd->wqs);

 	return rc;
--
2.47.2

