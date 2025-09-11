Return-Path: <linux-kernel+bounces-812209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF42B53483
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9451CC0AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364C3451B3;
	Thu, 11 Sep 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lg+RDWVY"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A46343D79
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598666; cv=none; b=q1qruP6zlQtjcXSuLofwYWxsJh1Kv/Ff/0P6T6i7uC2rmM6cZ/jCUVeEJsA6BMqYSkph8Xwou5ggU/O/K7TMvsQvsFLB0Notavu4QAGr03ml3K17ngzIzjpz4Rwm5yiEbaZZXMiTzFOw9pEZ4mVJww13trig3++RtbfXebrsi2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598666; c=relaxed/simple;
	bh=4ZNRIraxOBMzfn+Ru1PC7uaIfHrTQ+8/5VMDk1s40M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZbLaI4UxKF0gfP/Zr1e08TvHqU8loLqie3UFgJLlnbSd/+Iz74qT5iZmrzAwaKtpyM/P1ZvLEv7Q8yE8eshgtK2XI7oejI7UsmP+EXVVnCeuqMoFpaDK6GjkKZ4B9nOMESn0+TjB2UhYKWHt8bIJkbW+lmzAJ4zFovrD+GxnkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lg+RDWVY; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6045eb3848eso430765d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757598663; x=1758203463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YC/jPvTDCH7V0MdE5QEYPuycikAgoYKWyE534nDYx4M=;
        b=lg+RDWVYY9euTBFYnW5Qvy36AVDUgGacZv2IuU15hdNsHYrhD1tCErhGlFo0RBXpGO
         O/HIXCFCKqNxb2SpvM16AIt2diXMOXSq4Zm/z4Zs0gLaNGr2kKOVVNpHjCaMJcgArXd7
         BAdFny6BCWQXxwEJY6y3JINTwTSwp8fXIqW7PGNmZxlzo+JVCzgufaoImwUxBiM3QR/w
         2OsN7emaaIiM108EDnNEJT19s+nThIKk4N6DhO4gVXHreA2p/k2oKpxsIISeZ4NjFYnQ
         zR/7Au2xBip7/Zg35firgYtfrdkKNUHBeWWhHt4667IyiG6nTVEaHgXYFgvxVw2wsnUH
         C/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598663; x=1758203463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YC/jPvTDCH7V0MdE5QEYPuycikAgoYKWyE534nDYx4M=;
        b=jJsrEjyHOgrNbtZH3wlejpSz/XenHOXKOLG6QEo1N688B6NtPY9wI9b8K0B4gJ5M2q
         KbS+8V0Klp+IYzdgzx8E9uGljuouX7LRWcz5zwl9nlcFlqOOz5znW0bY/em3Z1eCvJek
         UGYkaH3cTE2afYUZYibyxuRkMNL5gi8057KTnMGWfqJTzFrQOKRVzuLgS5pGiVgT81fn
         LNYgEH2TH7hoWTpPaV1LAseGz7ZDCC0yGEuETMbzLGXn44E8eZ8mytgF25LBdNgDC22u
         XAW2HcW953S8dqFTJPP+AO/+fbNlh9ptZOi+uuX7bJ/G0qaRuFC/AGbVzf/69A542z5Z
         DTzg==
X-Gm-Message-State: AOJu0YxM5/YBEdc8nM+B78TiWjqJdE42NgSHE0Vp1FOftKJ8q8u1FtHa
	qyEYK+1epFpQTB+OrHCqHLFdYB+QAU+aCT+OOZqQknLBubBzoe2V6W/sw2AwPHW+zhVGJ4oyiga
	oOj7PtyWKug==
X-Gm-Gg: ASbGncu/fW57mZNsefNCFErxNWlKLumcT//xy9BezphajdHfsfNSXtkUBZxXg25YudI
	RtjEgriTvJDlzK4V6aPjA7JN4mitjYp1mBPCCRzSunPXNzyDDVflG0ZjnILUDFbKSj1bXPHK7Al
	KMxGw6Lpg0feH0FxHXVrWYhMMwniQ1ozCm4B9g7dBSUpuVlMSh0mHJoKSdGGgwhXFMAGmLtfghH
	Hdo++Uue56DDYV0dNseJSuCQFUdj2dwKM4vKVmKgzeSsfxlW18yWZxbbFHqdRbF4pO00vbitROc
	Y3M52mh2JRKV6waW/BaiiOtZUuoPqytCyvWLLKdpZOWLpa5MNUYQl8D/YlinVzLmPQEk3vFHG/f
	lESn82dz70DJIpQnpVV3HuOsF7wn7LJ08n9kPgpr2/JqH5fI/m4tQO7rtKCjirIxu5rGpOqzHKV
	c=
X-Google-Smtp-Source: AGHT+IHZBm0VWF5Q2HiB0+9X7Vnwcu0dm3iI+l+WvOP7Jt3IX2w3wk8CNJ5VHY3b6oDMOP/vs9Jw5w==
X-Received: by 2002:a53:b3c8:0:b0:5fb:957d:d74f with SMTP id 956f58d0204a3-6102163daa0mr12706114d50.3.1757598662617;
        Thu, 11 Sep 2025 06:51:02 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7623434csm3526257b3.11.2025.09.11.06.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:51:01 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Rouven Czerwinski <rouven.czerwinski@linaro.org>,
	robin.murphy@arm.com,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v12 9/9] optee: smc abi: dynamic protected memory allocation
Date: Thu, 11 Sep 2025 15:49:50 +0200
Message-ID: <20250911135007.1275833-10-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911135007.1275833-1-jens.wiklander@linaro.org>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support in the OP-TEE backend driver for dynamic protected memory
allocation using the SMC ABI.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/smc_abi.c | 78 +++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b4c007ed3b94..0be663fcd52b 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -965,6 +965,70 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	return rc;
 }
 
+static int optee_smc_lend_protmem(struct optee *optee, struct tee_shm *protmem,
+				  u32 *mem_attrs, unsigned int ma_count,
+				  u32 use_case)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg = optee_get_msg_arg(optee->ctx, 2, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_LEND_PROTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_VALUE_INPUT;
+	msg_arg->params[0].u.value.a = use_case;
+	msg_arg->params[1].attr = OPTEE_MSG_ATTR_TYPE_TMEM_INPUT;
+	msg_arg->params[1].u.tmem.buf_ptr = protmem->paddr;
+	msg_arg->params[1].u.tmem.size = protmem->size;
+	msg_arg->params[1].u.tmem.shm_ref = (u_long)protmem;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	protmem->sec_world_id = (u_long)protmem;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
+static int optee_smc_reclaim_protmem(struct optee *optee,
+				     struct tee_shm *protmem)
+{
+	struct optee_shm_arg_entry *entry;
+	struct optee_msg_arg *msg_arg;
+	struct tee_shm *shm;
+	u_int offs;
+	int rc;
+
+	msg_arg = optee_get_msg_arg(optee->ctx, 1, &entry, &shm, &offs);
+	if (IS_ERR(msg_arg))
+		return PTR_ERR(msg_arg);
+
+	msg_arg->cmd = OPTEE_MSG_CMD_RECLAIM_PROTMEM;
+	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
+	msg_arg->params[0].u.rmem.shm_ref = (u_long)protmem;
+
+	rc = optee->ops->do_call_with_arg(optee->ctx, shm, offs, false);
+	if (rc)
+		goto out;
+	if (msg_arg->ret != TEEC_SUCCESS)
+		rc = -EINVAL;
+
+out:
+	optee_free_msg_arg(optee->ctx, entry, offs);
+	return rc;
+}
+
 /*
  * 5. Asynchronous notification
  */
@@ -1216,6 +1280,8 @@ static const struct optee_ops optee_ops = {
 	.do_call_with_arg = optee_smc_do_call_with_arg,
 	.to_msg_param = optee_to_msg_param,
 	.from_msg_param = optee_from_msg_param,
+	.lend_protmem = optee_smc_lend_protmem,
+	.reclaim_protmem = optee_smc_reclaim_protmem,
 };
 
 static int enable_async_notif(optee_invoke_fn *invoke_fn)
@@ -1627,14 +1693,20 @@ static struct tee_protmem_pool *static_protmem_pool_init(struct optee *optee)
 
 static int optee_protmem_pool_init(struct optee *optee)
 {
+	bool protm = optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM;
+	bool dyn_protm = optee->smc.sec_caps &
+			 OPTEE_SMC_SEC_CAP_DYNAMIC_PROTMEM;
 	enum tee_dma_heap_id heap_id = TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
 	struct tee_protmem_pool *pool = ERR_PTR(-EINVAL);
-	int rc;
+	int rc = -EINVAL;
 
-	if (!(optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_PROTMEM))
+	if (!protm && !dyn_protm)
 		return 0;
 
-	pool = static_protmem_pool_init(optee);
+	if (protm)
+		pool = static_protmem_pool_init(optee);
+	if (dyn_protm && IS_ERR(pool))
+		pool = optee_protmem_alloc_dyn_pool(optee, heap_id);
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
 
-- 
2.43.0


