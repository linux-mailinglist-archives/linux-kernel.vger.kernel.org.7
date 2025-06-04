Return-Path: <linux-kernel+bounces-672509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39857ACD055
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 01:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0BC188D263
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C0253359;
	Tue,  3 Jun 2025 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KTM4WEDp"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6F2528EF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748993921; cv=none; b=t4sIk0bBS3KgRQyFzompOYUN7f8Fx5ZpJGQeLuZ4144nFl4tHzzYzrdMphaF+o54Oa2pqakrCwpvL4J9QlCROofWFnzOuLC2rzK4jakWHm5WM9AT1Iuzx1/+B2fh/DB3cH+kTvgg+eaPakYDqGQEUDHQBZGmuBOoJqvWNGMLkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748993921; c=relaxed/simple;
	bh=GRKko8U6tkBwoDvqev25212EMIC0D1LUxb+uSFlHjvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uWxqHwfgCnoUZ22nB+MfyCLQZVa3/Rv5RPwB7Ve7fmZ15u/4/BLgPVkl9b/sZ/UD2l3rk+g64FyHaYLnyGDHL0o4aUpXch5pC9WS0+1VpH1pI+d44HGjcqgVt7Ip1DJCjPa7njGiaiN3aegJGePxh3YlOBd4bQ/IakqG47oWVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KTM4WEDp; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3da73df6b6bso18635205ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 16:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748993917; x=1749598717; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0RpgCFKdTj3IOKRqUkoQl1YyksTGBaXOZihTi8ctY=;
        b=KTM4WEDp1d4DHkOu92A6lL7h/GBr5zNy5dZ7BMk2MYTg+ip5aeLGTRcY6XgT5Iy+xx
         +uAA2thmT0uoHnNf3WrcliZN/ririxeGYhzprzlazkTRGT2UFFuONWR8GxtIax1AAS6P
         PSzSdGFOM8R4rg066jLU9ZD9OQLc/Ag6ew0ZQRolvZnItRC14GaVXNMVhopVdj+2eEQc
         TpksRpE0IPQi8iUcQLbVuOTWr8i68ip8SHJoaQCqM/LfXV536e232lyIjQWn6qmoneCu
         mzo0+6x/aCp8vKr+qZGf6/SDKmrZWg2QUsx7RZXVxUaDZTnzvvc4X+Uhw8gOEJ2WsRpr
         xL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748993917; x=1749598717;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/R0RpgCFKdTj3IOKRqUkoQl1YyksTGBaXOZihTi8ctY=;
        b=bOCSFqIhCLgMHuZlzxQILHJY0y2mgOZPEkwyCTEu6H1WVLmN6PMylIo5hLFe/RZ/Ax
         0Tczgd+ljmSTaY3z7G+UIdcd1PryGCMjF83mFVTzhHXRwKL0Opj5V9BTssEyVZea5he4
         arbk6Y2C41gBvWWH+XGMaWISsBqE8s3t08seximszLjYguwrQh9wcevvpMXTYFCXdyKK
         lOm9a7p0NQRwbr6nm9K3+nYciNq6rCbE4tsxOlWFLRLH5CJVnWe9rWhVXeC+FJO1kepx
         Ca3trPfXGhT93GO4CEfyI+xssgYZ5UDVs7ryRduw9/guoy2K8iewLiW5gpEOpVUHrQdI
         MSDg==
X-Forwarded-Encrypted: i=1; AJvYcCUOoIxL2EMS9zYsxM+1B0Q9Hh185JW9eRNhLG947ggddVeBpaQeZ2bWhiP2q6it5vFZBWwRVrX8wZROj/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVqZkWASxYkuJudxcr+CYf5mB9Mlvn8nYWrJGoOTj96IH4Ihi
	zftJDwORchCtmuCYQ1ZHFY49eJXf9TibgbK3Njx0QiBC13e8OSfxF16tx/GWO4H5BZB+mxudOOc
	yYL079q53dyo/eIWgzAcZttVfcrbsOgO4SO0x
X-Gm-Gg: ASbGncvkdQIQKfgknf27LX5KmlvILT7vHTIxs4H5JXZsSolURFxBepKJHAC8uLrQR3R
	8whQh7F/Na6goYfSoQIcqvJGgORZdPJqrFMBg4d51xgE4ozPXY1tKrMKPfKiQq0eA0yJo5dkaHr
	gosMChbISZh0tyyoK6awD6onURkMmXkTiBu2TRliLxoCxJdqnVGgjh+47Rl8NlVpzw5uF1wEYFh
	mNaWeT2Rx5A5hKN6UM/Uadpz2rN0ONAbXLvGNajJSyPzFNz8xah7eDuny9PtkT65NKOg+g5MeOU
	w5TFb8xqQ9KUaYB+4ycHIVVdnSrVEPyHm7ucB30xkp+FWw==
X-Google-Smtp-Source: AGHT+IE2Clg33E/8c+qwuR12THXL4yJ4NH4pmMoiTeWYcHOgHxUyzjy7wBBi6+80u6OaDk7frWPxrt/0AjAt
X-Received: by 2002:a05:6e02:3989:b0:3dc:7fa4:832 with SMTP id e9e14a558f8ab-3ddbee093d0mr9255995ab.9.1748993917492;
        Tue, 03 Jun 2025 16:38:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4fdd7e3ee09sm297542173.37.2025.06.03.16.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 16:38:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id ED38C3401B8;
	Tue,  3 Jun 2025 17:38:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id DBCA5E40EF7; Tue,  3 Jun 2025 17:38:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 03 Jun 2025 17:38:33 -0600
Subject: [PATCH] selftests: ublk: kublk: improve behavior on init failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAHiHP2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwNj3dKknOz4zLzMkvi0xMwc3SQTSwtLA1NDU8vUJCWgpoKi1LTMCrC
 B0bG1tQCSUc+VYAAAAA==
X-Change-ID: 20250603-ublk_init_fail-b498905159eb
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Some failure modes are handled poorly by kublk. For example, if ublk_drv
is built as a module but not currently loaded into the kernel, ./kublk
add ... just hangs forever. This happens because in this case (and a few
others), the worker process does not notify its parent (via a write to
the shared eventfd) that it has tried and failed to initialize, so the
parent hangs forever. Fix this by ensuring that we always notify the
parent process of any initialization failure, and have the parent print
a (not very descriptive) log line when this happens.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index a98e14e4c245965d817b93843ff9a4011291223b..e2d2042810d4bb472e48a0ed91317d2bdf6e2f2a 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1112,7 +1112,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	__u64 features;
 	const struct ublk_tgt_ops *ops;
 	struct ublksrv_ctrl_dev_info *info;
-	struct ublk_dev *dev;
+	struct ublk_dev *dev = NULL;
 	int dev_id = ctx->dev_id;
 	int ret, i;
 
@@ -1120,13 +1120,15 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	if (!ops) {
 		ublk_err("%s: no such tgt type, type %s\n",
 				__func__, tgt_type);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail;
 	}
 
 	if (nr_queues > UBLK_MAX_QUEUES || depth > UBLK_QUEUE_DEPTH) {
 		ublk_err("%s: invalid nr_queues or depth queues %u depth %u\n",
 				__func__, nr_queues, depth);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	/* default to 1:1 threads:queues if nthreads is unspecified */
@@ -1136,30 +1138,37 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	if (nthreads > UBLK_MAX_THREADS) {
 		ublk_err("%s: %u is too many threads (max %u)\n",
 				__func__, nthreads, UBLK_MAX_THREADS);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	if (nthreads != nr_queues && !ctx->per_io_tasks) {
 		ublk_err("%s: threads %u must be same as queues %u if "
 			"not using per_io_tasks\n",
 			__func__, nthreads, nr_queues);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	dev = ublk_ctrl_init();
 	if (!dev) {
 		ublk_err("%s: can't alloc dev id %d, type %s\n",
 				__func__, dev_id, tgt_type);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto fail;
 	}
 
 	/* kernel doesn't support get_features */
 	ret = ublk_ctrl_get_features(dev, &features);
-	if (ret < 0)
-		return -EINVAL;
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto fail;
+	}
 
-	if (!(features & UBLK_F_CMD_IOCTL_ENCODE))
-		return -ENOTSUP;
+	if (!(features & UBLK_F_CMD_IOCTL_ENCODE)) {
+		ret = -ENOTSUP;
+		goto fail;
+	}
 
 	info = &dev->dev_info;
 	info->dev_id = ctx->dev_id;
@@ -1200,7 +1209,8 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 fail:
 	if (ret < 0)
 		ublk_send_dev_event(ctx, dev, -1);
-	ublk_ctrl_deinit(dev);
+	if (dev)
+		ublk_ctrl_deinit(dev);
 	return ret;
 }
 
@@ -1262,6 +1272,8 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 		shmctl(ctx->_shmid, IPC_RMID, NULL);
 		/* wait for child and detach from it */
 		wait(NULL);
+		if (exit_code == EXIT_FAILURE)
+			ublk_err("%s: command failed\n", __func__);
 		exit(exit_code);
 	} else {
 		exit(EXIT_FAILURE);

---
base-commit: c09a8b00f850d3ca0af998bff1fac4a3f6d11768
change-id: 20250603-ublk_init_fail-b498905159eb

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


