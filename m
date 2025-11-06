Return-Path: <linux-kernel+bounces-888876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2EFC3C24D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16621AA85CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1725343D80;
	Thu,  6 Nov 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LuMVblwO"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4F34167B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443906; cv=none; b=EjrroMCF9FvbBuw3N8qQQKeIyTHe9d0RhGBHrmracRipHAuqNQsyOridEOrqUNyWx5dSZB9PJdS7rrSTdjJ72H1JIVjHbAH2F1dd2qoMM/1sd6oHCqY4qKzUVtd83zAdzhIbaNcPtRBL17rv9/IGM4hVGriQrgRyQ5890segDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443906; c=relaxed/simple;
	bh=ZWq7Pm27cK1DpvY/EMDI4nfic014qXdOnMiOukcqk+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGA+T953TiDtilaYukZYxzdg4WfVSnCQ3kzPcxAY1tqc7Z1cKzgidjqrnGwGPzm89QJz2Yl0pfozn5GIjyDTbZQ9IwO+JjVdQQg8zwMTYXywoYkwFr/amCzo6Hc6IioTYe2CNkQ0OStni1YoMKHS3/TZlLp6Kp59XL7use4TED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LuMVblwO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso5669285e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762443903; x=1763048703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esEdcTh2LbyZ9Fgnuw95sR3yJENLiwNORj0la+mn6sE=;
        b=LuMVblwOk4/RnFDvvuzNd5ulo5Kp/fNm8Y8FrAVDofmfTdHYS0ebNnUdCjNi7nMDs/
         OBUQKKUdgDCI/eXAMWwdaPfMPn9DpqI0h1H3jtOMrAmy+9NJyV49xxcnWIiua977en7/
         sDOkqXuT6aAZ5J3XkyinBbrcQEzxSGsZPEGr6Xoip1/7cqvuFlXt6/XMh34K4FksKcEA
         MEsqKyZ8JCxgI+wEy6HXjXQhQLNMk8doMaUE6iVCHlA4MiqHjiuBINSSG9Bv02mysZMc
         dvYOBIv5cZg87g30dewNgojvm0CXgnhRtADQcqxUrapLNsdj7/MtjZQElmGwRbguQnml
         vVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443903; x=1763048703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esEdcTh2LbyZ9Fgnuw95sR3yJENLiwNORj0la+mn6sE=;
        b=rP/fv56AGTSKZLF1iLokAOyko6PmYr97teSlMppHtk7pgh0j1/unNuWDaw1VJ4rMQa
         1GxV7CE7h6GzlHi74N6/UApxFfYuXkjgQsGtfmpkA9wFVO1XwC83LKZqnW8bsmHI0h+R
         Hss355xkyr9hOKp0YIjI6neGDBBLg4XixpyqOIddn6K8N5O/WUvAMGHyIzznPi7HZmrD
         tSdPLMF774R0h+iB7zaId2zfm8YYQ8O1nHd39eI0e2scqZ35DBLsyJ4ORprElmNgNor7
         qJeNQYpZUfcJqtU/5gP+uhEv3jOYsPuOdalP4O6V8CScwrOinHZHc1TEb2J+9bKJM4z/
         RFQw==
X-Forwarded-Encrypted: i=1; AJvYcCWX0bjCD8HYvnpfgSgVq5ser0lCOPYrG3ldbsGTMj7zVKiV8yEQTK+h2MjtrHYNK+r5VIO7/ZEPsiasqOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWFs9H8a5rPAuNzp6VEUBiSrZEt11wWbImG4USO5Ys8baOkZK
	pNl7XJKbCcfm+OYRlGGU1xcKtyEZAo/cvLCl/BRnVU3jzvpIhW1/ALaTJz5esgB1yKo=
X-Gm-Gg: ASbGnctx67/2Jj27XWq4rFUx6PQH/qMkFh/JKtXBkrtFodd3VTkzNDAMCOIsSR79NFS
	5/FPmp7Kr6nvBo3HBQvPM2/XvpDGB6cj+y5CNoULwAkIXWVhlH9KCHMnZurliuRli4L1+jIbQ5C
	Vtba4zX5YvdJGRc/9XF5XYIIrTODADQuGgG6gcxAdSlpwaFioPFXL/bWd5FaCUbX9+OmXgGMB/Q
	/9ktH7N9I0HvU1EGCAPxyEcPndU9A0OHgSngks7Sw4YK6NP8h9t6mukqM6ynDxwDBU77E3oz5eA
	plVIbZt3ipED+PIXwafxnsW0XXoDvVzM0ldnU7YjJRz8VjpvET0izBg0eo8GX/EWS13trvgiShK
	jp2EQkzzFVR8GuzL9/r//+5ptaCikPS6vtU/0yxUUwsLfWLXVton6AxgeRWLy1MN+P8kp2wRCIr
	0/lVgZ
X-Google-Smtp-Source: AGHT+IEhmTqYfdZXcR34f8oucO4sNMzMcglUrQpy+XWcCDtrKQdVYJjqpPhuV6/BnBrxb3O3h50pRA==
X-Received: by 2002:a05:600c:46ce:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4775cd9c05emr66589085e9.3.1762443903419;
        Thu, 06 Nov 2025 07:45:03 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e66b1fsm20621705e9.1.2025.11.06.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:45:01 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 16:44:52 +0100
Subject: [PATCH 3/3] dmaengine: qcom: bam_dma: convert tasklet to a
 workqueue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org>
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
In-Reply-To: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3969;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=si4pCCUV8uwm3sY3u1lXmrBH/4Zfvei8bJceXOrOIWE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDMJ3UfxwOakrKsFNxGyj8BtSpDAPTF7NZNotr
 edMLaTHzJKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQzCdwAKCRARpy6gFHHX
 cqTAEAChjL6VcpPC0zJqB1yMKMOSrYLQog0rwwZiC1Oui8df2pl3D9j2p+GPRjhF93EMzGzkCof
 7DP7fiVmCT0Okz7U5KY8JVvN+VIPTUbzLTnF3GFMsvRjHV4GZ8aU9EUmmEHzi6raKf0ve+PY0Yn
 NBDj3uwtyFS4OgXhlierqbUjbPLCqzB0zR9e5jhNgS4jW9BkjnNt8Mm8jeEkFU4uHBRar0IUedc
 S8LoYwuVfdkzkRNsshO58gNkhVhn6UnkuCgwBmqwGTMtiS6gdiHfIVQznzvhuU+zCUWxGO9rLg3
 e2wpKh6HQNmJbcG2KqWCm5LYTWlWtC7wr+mPPDApuArqiVENpWCVkB3mY9t2u+fXgbv7rSnvQAm
 yBUy0xjkl8RHoDkCAfEKN+xiC6W34w+rNp9SzltMkhlGzLO38Pz9ZYMU5rSCM0IseTIiWnttscF
 dIJlPCS2EU6jugDEZZqfZwHg8oA1gaLVxoq3DvSjGERQVB+iu/MA4jApbT6+2hUGgqKo6AWVAjb
 00kGSDAkwEf7EarmDe9HFZ7seubicjCzCjeJz/CBoF6sl+KRezsMv/nhm1eZDv/2wWVxJZp2ZQ3
 XCu2NyXc5TLZTHpZ4Lq/axxkH+EZwA10AbhBwE7gPeUzv9tygCCB6c5en6tWGoYSp8HhNb6Cg4x
 H5jpNhLUBCKdX0A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There is nothing in the interrupt handling that requires us to run in
atomic context so convert the tasklet to a workqueue.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index bcd8de9a9a12621a36b49c31bff96f474468be06..40ad4179177fb7a074776db05b834da012f6a35f 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -42,6 +42,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"
@@ -397,8 +398,8 @@ struct bam_device {
 	struct clk *bamclk;
 	int irq;
 
-	/* dma start transaction tasklet */
-	struct tasklet_struct task;
+	/* dma start transaction workqueue */
+	struct work_struct work;
 };
 
 /**
@@ -869,7 +870,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
 			/*
 			 * if complete, process cookie. Otherwise
 			 * push back to front of desc_issued so that
-			 * it gets restarted by the tasklet
+			 * it gets restarted by the work queue.
 			 */
 			if (!async_desc->num_desc) {
 				vchan_cookie_complete(&async_desc->vd);
@@ -899,9 +900,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 
 	srcs |= process_channel_irqs(bdev);
 
-	/* kick off tasklet to start next dma transfer */
+	/* kick off the work queue to start next dma transfer */
 	if (srcs & P_IRQ)
-		tasklet_schedule(&bdev->task);
+		schedule_work(&bdev->work);
 
 	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
@@ -1097,14 +1098,14 @@ static void bam_start_dma(struct bam_chan *bchan)
 }
 
 /**
- * dma_tasklet - DMA IRQ tasklet
- * @t: tasklet argument (bam controller structure)
+ * bam_dma_work() - DMA interrupt work queue callback
+ * @work: work queue struct embedded in the BAM controller device struct
  *
  * Sets up next DMA operation and then processes all completed transactions
  */
-static void dma_tasklet(struct tasklet_struct *t)
+static void bam_dma_work(struct work_struct *work)
 {
-	struct bam_device *bdev = from_tasklet(bdev, t, task);
+	struct bam_device *bdev = from_work(bdev, work, work);
 	struct bam_chan *bchan;
 	unsigned int i;
 
@@ -1117,14 +1118,13 @@ static void dma_tasklet(struct tasklet_struct *t)
 		if (!list_empty(&bchan->vc.desc_issued) && !IS_BUSY(bchan))
 			bam_start_dma(bchan);
 	}
-
 }
 
 /**
  * bam_issue_pending - starts pending transactions
  * @chan: dma channel
  *
- * Calls tasklet directly which in turn starts any pending transactions
+ * Calls work queue directly which in turn starts any pending transactions
  */
 static void bam_issue_pending(struct dma_chan *chan)
 {
@@ -1292,14 +1292,14 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_clk;
 
-	tasklet_setup(&bdev->task, dma_tasklet);
+	INIT_WORK(&bdev->work, bam_dma_work);
 
 	bdev->channels = devm_kcalloc(bdev->dev, bdev->num_channels,
 				sizeof(*bdev->channels), GFP_KERNEL);
 
 	if (!bdev->channels) {
 		ret = -ENOMEM;
-		goto err_tasklet_kill;
+		goto err_workqueue_cancel;
 	}
 
 	/* allocate and initialize channels */
@@ -1364,8 +1364,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
-err_tasklet_kill:
-	tasklet_kill(&bdev->task);
+err_workqueue_cancel:
+	cancel_work_sync(&bdev->work);
 err_disable_clk:
 	clk_disable_unprepare(bdev->bamclk);
 
@@ -1399,7 +1399,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 			    bdev->channels[i].fifo_phys);
 	}
 
-	tasklet_kill(&bdev->task);
+	cancel_work_sync(&bdev->work);
 
 	clk_disable_unprepare(bdev->bamclk);
 }

-- 
2.51.0


