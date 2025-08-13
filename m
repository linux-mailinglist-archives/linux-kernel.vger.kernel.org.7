Return-Path: <linux-kernel+bounces-765999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE9B24103
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F592A68C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE122D1F68;
	Wed, 13 Aug 2025 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCmHefOK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139BC2D191C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065053; cv=none; b=CtnJlUX7kF17vjHaZ4M9+LJpTBdJfOt7wSvfzYz/Pvv2Vn2ENamCRNtdWfBwzH/wh5BeljIm2IpvkgtRDactEmtTB7pTGaiV+yYaCRS4+ErvZaotKnopVBcqkRgCqy233cKS+JJc7iHSXMFr0kgKTXjvK5FG62AnAWtBTmlvIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065053; c=relaxed/simple;
	bh=RREeFH4FApT8BsWG6hYwTdwXNy+z8q66uH2RuunAKOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUL7r1qGL9lHfLL8EgOa0fg+NjfkxcjP9HlL7poRb6jv/S47Z4BrQiiNCuLafAvJnzPQhvNcqMiQou8/7DmthUbFo8rqGtktWL3YzwvZc5ovd381WSpkV5465UAo6b749htpk+XqlkvRkKs0C5YWnN/3ncm+DKxDUZifqQ4U3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCmHefOK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso9999693a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755065050; x=1755669850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMyd1M5LZgFUuwfgUjsWaWr5cxJRx+F31yZrIJB0d8c=;
        b=JCmHefOKy0QDEGm8BANws+TFSWJsmAbigmpu6j8rVbxANrwWKZuC1tRvKsFTvI//wg
         uViYZwZ51QTkpYnfqcTvkt4iC6sY9q9txBNcpo0GsQ4h7jcQly48/NhiVSsUqK9wiwlf
         WF5u3Z5qv9X3OBv6xFIH/4tVXI+o9FCHDTjJ65KvNnaWX6rn0sI3k2jCcxPGZIUnNL41
         wLEf+1dfVFUpQd/DG93itBAx+c+WvwlEdtXVjTOPDkXrTRKj+s1S6cqbO/n0Gvg5RQlN
         ADrUkSayyFznfA/6xiY9N4+CT2D1bWj51gOezPk8BqMTkQ5TJwvkz2SrbdCOAMZaYVNs
         8LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755065050; x=1755669850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMyd1M5LZgFUuwfgUjsWaWr5cxJRx+F31yZrIJB0d8c=;
        b=TsgI4iOoPQLzRYoZ5CdVGDqsaY51SjopN+Qztlo3XHCp+fqlFEvMhsLHi166UOaumR
         Xg18AoAQulYfsy6GGfl4jJqktQScsnN9qIOmasEDOXsXIVZqd0Sjb7ZinDpBZxcCWHcx
         sRL0UpoiI5zpufHs69gERkskk7AqhsVDP9AYWUudvZYXqsofpKbdvbq3e8YQpIxNk0+m
         8p1Xt8LZbDeXixbNplJVeEupfmQ3ZHQM1pCV2erf6gPoEiTPU0a26Pr//8lsfoIxUpn2
         Tole99YlJgYseUKcbyNBGJOfxiwvS5fFPTErleOtgK6fGNsEjPjpK8HrRm2h//g71OJf
         JKoA==
X-Gm-Message-State: AOJu0Yw6y5r8LvvDOGHMTNgqBOwtcId8TL0lAmuTM0/jyMIlZrZDPje3
	d9BTe2YGrQu+/QoV4SOtEcgUlcZptmZnoNR4/VJYOhjvIbXAqBs+eoVp/2jZPwbGKpwq1cxFvvd
	0Oy+J8UI=
X-Gm-Gg: ASbGncsAB7Vi2TFiMoTng8oPM4C4reboLdAbREg1RGpC4OlXS14tm+U4ZeTGQtTNgEl
	qxhnzmvCSbJGFPIbYYpsAMmd0mg2xUZH1GvziHomfEnoFSoTmkmZnPflZycVhccne7cOp2hIwkc
	4iRLTdjpTdtWCs/KifpeZONRw/y5ftXnhjc5j27aVi4HPTzDP5AsWKncn1LTfVZlp0WwLWS52GR
	DE3CJSrX29gIIQZvn5Om3JeufiffJCA6dM2sTJcV9dR8fQ1Dfu4gc9AMKRR0P45dME3zSlvJKLF
	nZe6J9B+I6qGEVr5uXVjtL9aCjq0a10WfbqNqD+9Uk8mXz6npAljFHaGOSE5P6y1mMdxrBwPU0l
	pqoYUn9TJUAGoEIyOOy9VGaTg0waWITJGJz/rPlUavTZhYXftE1dDaX91uANiqDMkCzl3GGp85Y
	w=
X-Google-Smtp-Source: AGHT+IGl+zk2kZ7dGtXoXvUAogPksLb/KD4WUBLmDCFuz3Yjsb2gUsdZ4PxNJjaVjkahgiQaR0qEBw==
X-Received: by 2002:a05:6402:2753:b0:615:38e6:b739 with SMTP id 4fb4d7f45d1cf-6186bb8e5damr1297264a12.10.1755065049472;
        Tue, 12 Aug 2025 23:04:09 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm21498679a12.25.2025.08.12.23.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:04:08 -0700 (PDT)
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
Subject: [PATCH v11 9/9] optee: smc abi: dynamic protected memory allocation
Date: Wed, 13 Aug 2025 08:02:58 +0200
Message-ID: <20250813060339.2977604-10-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813060339.2977604-1-jens.wiklander@linaro.org>
References: <20250813060339.2977604-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support in the OP-TEE backend driver for dynamic protected memory
allocation using the SMC ABI.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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


