Return-Path: <linux-kernel+bounces-887812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90016C3924B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8F73BAFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CE92D876B;
	Thu,  6 Nov 2025 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z9hKH8Ti";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AP2D9nNC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59142D94A4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405736; cv=none; b=ZDKhBZn6YTsCyZAF9BfBmkTq9ZjRcNWp5kT3AT1aBqj52AK2wt1laWt/Vc6GWcgouYB1I+M2ikBrV1BpCbd5vxLpbcOylXg692mjB/xHA9oLD0sCe05JXL/QyHFotzt7R7glylJqsVxkvZQn8KEZMcTqQY0e/d1iGJe4TeAGE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405736; c=relaxed/simple;
	bh=oy+K6ekPn6Jv6VXcs3v3ti0u6RkSGf6yS+Ce36zFuwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tadaYJZW56ZsGutVJCESH0f0O5+obXP/NjwIkgIYZku7Nb38Bs7klUKoxjK9cWmxYms9+asTD2TL3ezswsNehMfIMgCApZyVY0NAhiOKiQt8NpGw8QNZH+PyMa4Mr+Aze5q+mcf/I5tHWYcczFBnPIIiQ35+M3ag4KckNwX7XQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z9hKH8Ti; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AP2D9nNC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KFAZA1657014
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 05:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+RE3hZYUs1r
	vlduAgjzrIfTd74BQra1K1AtJtAWfdgk=; b=Z9hKH8TitA0NqrIxfavU18pjFyx
	+HzDvM/zOeHljPwtzeVzflBv6ngQGW/TYn7vT2ZnxsJMnj2ZseKkXEfdUrgB48ut
	WuDBLf5T0bndSH7pgR8huOCY/SfBMQOitzmFseu8VhJFGcXQkXV+1A7/d3o5c5h9
	+zOMP9vH7/vGiuxhNgv3m++GUZdJV7ZbxSlVYaWAYdOSZGwRPG7c4dcvBhaUhGvj
	22h6tQP+xubSa/mrC86UUND5InEtvTHILSV/B/Jv9ok+9Z2TZgFZuMBQAlSjtl/C
	p+XA6Cv+zylmGwH63OBLDDYRUlG1aC6g1690CovdE3jtN+tWK3U8bz2/WBg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8831adwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:08:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so108820a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762405733; x=1763010533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RE3hZYUs1rvlduAgjzrIfTd74BQra1K1AtJtAWfdgk=;
        b=AP2D9nNCJNp/yGMfVxcwQE8zdTtfM3ATnTor2MCANGVkw5k4etvHEt2A1b7YUIeNIA
         DmvRmFWDyWpfd1l7WEh19JMPkwlkVoVrrsEZ95zLFSDiv9PZuJdFLZBtjz5qpkkN53n1
         eE9otKIFGJXTrHFNBh5vkipmtjwuywNUZnWOTd5eBOJWhvDBnUlgwqMsPV5G8XlSPExk
         Ei02FAvbQhwq4X9/q6u+gu8pqH1zCYxy89rxJmNVb0iy1xMeNgo4fRXBRoB2nhuKaKBP
         pZqfkdKrhF0Fx5dbSggYLpD6zYOQyM1yAilHfNMJDe1FinCAMIZpKkmKozvwbIb4gO0U
         +CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762405733; x=1763010533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RE3hZYUs1rvlduAgjzrIfTd74BQra1K1AtJtAWfdgk=;
        b=iar1SIL5LEXi/DgfbZctaC3X2ZvhmvH/Ce3rdptUf+EKfGoYsJCryIHSHBxnAuKMwK
         wyROaTVQgGbB7Ur/RdbijGxURgFxGQfS8a2ylPR1QU6zs2Sd7Esg8nBttyMkyLKDjOuf
         cX5gzqZzFpfyZLFBJ8HYNFFo2f0FMEWG5uGk7RtOZtf0DH/xIefqrVxUC4ScoBZ+Bfzw
         2ZpOuZN5ovjehqRYHSpjIHcLKDSEk/K625yNu6P40HJjTYX7XZIJVNzRzdCmCvKjEpE2
         /GCDY/BWEol4MUK1eN1MICmo/yjcwrQDOgRjhprdR13j8avdhWwq376ymvlwahRqIzdJ
         ug9w==
X-Forwarded-Encrypted: i=1; AJvYcCVbgM2McCD/nEZkS60CazyKQlhKogTCYt3Ef6p2u5+rJraO6Ttq95y7XIDqZhnFDXLBQBIoYsG8AUQDH4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHayYqC+MvUB815Jl2DiXl/c2E0ohVrWLSpqGDveiunYwAHzF
	FycEWMp5Tnu3kswpkjBGFuVV1o5RoarPGHNfzfZC0M9uMSQqnb7QqbXFAIkPhTyRbXIRbGkbsR1
	1hniHMchLep2uiZhgWYtn+HewszorkGkqFOIjRap7ajCIJQWxgpKq+Zpz8dr7j22fY1w=
X-Gm-Gg: ASbGnctCDLAUmJEkFhIhW0o3W+FWCyPm6bDa3I7uwhTq+OCtAY6C7Vld24uVyyV8tTE
	bQQ422g+hSbR3Gm+o7M5e/bJy+ag0nRc5HVbcPsqOxHYR+WYZDorTLuKD38zTHxFMyp1YJWfhs/
	QPtNrTASrO9oLL2vv0ri8b4klW6MokjRL4XF8Xf6ADaSXtjQIwWCSve09yOFa/xrUryYMtf4lHg
	0Q2lCS4YX9I4Lcg4xbpE2YsIfZrgDWtwcNOkQpMmudpeYWOz4yFwQn6CljJM19S4+LCHrgNMHcf
	v5G1G0ta8k5LHt2FOZY+3ENVAHJbzXLyFdFcJog/TGQJ6Nqgf6LHztFU/DKqzp1Z1a74K5zOeBI
	PSKNMvtN4IcD8y8rVQy7RPfIdtavsS/o=
X-Received: by 2002:a17:90b:4a81:b0:341:8b42:309e with SMTP id 98e67ed59e1d1-341a6e05f1emr6654251a91.31.1762405733212;
        Wed, 05 Nov 2025 21:08:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9BLTBuIpf6OX+6TZe3Qc6Ptfo4VSG2q3rM8rq+hGH7GasRpAb1jgAO7HR8w8VZIT3/b4xHA==
X-Received: by 2002:a17:90b:4a81:b0:341:8b42:309e with SMTP id 98e67ed59e1d1-341a6e05f1emr6654224a91.31.1762405732701;
        Wed, 05 Nov 2025 21:08:52 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd5238csm1185862b3a.17.2025.11.05.21.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 21:08:52 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v2 3/3] misc: fastrpc: Add polling mode support for fastRPC driver
Date: Thu,  6 Nov 2025 10:38:39 +0530
Message-Id: <20251106050839.3091707-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106050839.3091707-1-ekansh.gupta@oss.qualcomm.com>
References: <20251106050839.3091707-1-ekansh.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5EqwpbBtRVHhLMXhpKDL57inlg8dcSfw
X-Proofpoint-GUID: 5EqwpbBtRVHhLMXhpKDL57inlg8dcSfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAzOSBTYWx0ZWRfXximJiM1e9Cp4
 0gl+uttZSyIZIIBDV/mhQtQ3iEb4vi2fbytdJhNf0W8p4gtHf7VktcYCJuWXwmmfhaHDZa7JiJT
 tTIJbt9uyYL2Wt7loVGQdeqYPd57xXgYget5b0Af3XydxQYPSUqzQlwwptqBvVRf2S7cPbupncH
 JEfmO+09oIhxhhj40a10vF+tWCDt90HMDa8OPDtiStATQRlYvFvpAe3lo1uDXTcSs8k99sxPQ7I
 +TWoN+tq8RjIxM9yk1WbhM0BEOQNgXcHe9w7DhafFrPzTlyv1CNwBbhjN9BLJ9696Rc40Q/jKSw
 jc+nvlzlhSRKfRFEBMckL3yVZJBArF1IsHYSFcjTgyg3VoWdO1VKpwirX7MJS0W4/myXdEJz5Eg
 y3EpnSQWASNEL+vGFhfdf+kRV/MPcQ==
X-Authority-Analysis: v=2.4 cv=Mdhhep/f c=1 sm=1 tr=0 ts=690c2d66 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TEHdEMHTk_fMHrPBF0kA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060039

For any remote call to DSP, after sending an invocation message,
fastRPC driver waits for glink response and during this time the
CPU can go into low power modes. This adds latency to overall fastrpc
call as CPU wakeup and scheduling latencies are included. Add polling
mode support with which fastRPC driver will poll continuously on a
memory after sending a message to remote subsystem which will eliminate
CPU wakeup and scheduling latencies and reduce fastRPC overhead. Poll
mode can be enabled by user by making a remote_handle64_control request.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c      | 138 ++++++++++++++++++++++++++++++++++--
 include/uapi/misc/fastrpc.h |   9 +++
 2 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ccba3b6dfdfa..c3ba22f094a0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -22,6 +22,8 @@
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/compiler.h>
+#include <linux/iopoll.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -37,6 +39,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
+#define FASTRPC_MAX_STATIC_HANDLE (20)
 #define FASTRPC_CTXID_MASK (0xFF00)
 #define FASTRPC_CTXID_POS (8)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
@@ -106,6 +109,12 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
+/* Poll response number from remote processor for call completion */
+#define FASTRPC_POLL_RESPONSE (0xdecaf)
+
+/* Polling mode timeout limit */
+#define FASTRPC_POLL_MAX_TIMEOUT_US (10000)
+
 struct fastrpc_phy_page {
 	u64 addr;		/* physical address */
 	u64 size;		/* size of contiguous region */
@@ -236,8 +245,14 @@ struct fastrpc_invoke_ctx {
 	u32 sc;
 	u64 *fdlist;
 	u32 *crc;
+	/* Poll memory that DSP updates */
+	u32 *poll;
 	u64 ctxid;
 	u64 msg_sz;
+	/* work done status flag */
+	bool is_work_done;
+	/* process updates poll memory instead of glink response */
+	bool is_polled;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -301,6 +316,8 @@ struct fastrpc_user {
 	int client_id;
 	int pd;
 	bool is_secure_dev;
+	/* Flags poll mode state */
+	bool poll_mode;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -894,7 +911,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 		sizeof(struct fastrpc_invoke_buf) +
 		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
 		sizeof(u64) * FASTRPC_MAX_FDLIST +
-		sizeof(u32) * FASTRPC_MAX_CRCLIST;
+		sizeof(u32) * FASTRPC_MAX_CRCLIST +
+		sizeof(u32);
 
 	return size;
 }
@@ -990,6 +1008,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
 	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
+	ctx->poll = (u32 *)(ctx->fdlist + FASTRPC_MAX_FDLIST + FASTRPC_MAX_CRCLIST);
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1158,6 +1177,75 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 }
 
+static inline u32 fastrpc_poll_op(void *p)
+{
+	struct fastrpc_invoke_ctx *ctx = p;
+
+	dma_rmb();
+	return READ_ONCE(*ctx->poll);
+}
+
+static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx)
+{
+	u32 val;
+	int ret;
+
+	/*
+	 * Poll until DSP writes FASTRPC_POLL_RESPONSE into *ctx->poll
+	 * or until another path marks the work done.
+	 */
+	ret = read_poll_timeout_atomic(fastrpc_poll_op, val,
+				       (val == FASTRPC_POLL_RESPONSE) ||
+				       ctx->is_work_done, 1,
+				       FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);
+
+	if (!ret && val == FASTRPC_POLL_RESPONSE) {
+		ctx->is_work_done = true;
+		ctx->retval = 0;
+	}
+
+	if (ret == -ETIMEDOUT)
+		ret = -EIO;
+
+	return ret;
+}
+
+static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
+					    u32 kernel)
+{
+	int err = 0;
+
+	if (kernel) {
+		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
+			err = -ETIMEDOUT;
+	} else {
+		err = wait_for_completion_interruptible(&ctx->work);
+	}
+
+	return err;
+}
+
+static int fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
+				       u32 kernel)
+{
+	int err;
+
+	do {
+		if (ctx->is_polled) {
+			err = poll_for_remote_response(ctx);
+			/* If polling timed out, move to normal response mode */
+			if (err)
+				ctx->is_polled = false;
+		} else {
+			err = fastrpc_wait_for_response(ctx, kernel);
+			if (err)
+				return err;
+		}
+	} while (!ctx->is_work_done);
+
+	return err;
+}
+
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   u32 handle, u32 sc,
 				   struct fastrpc_invoke_args *args)
@@ -1193,16 +1281,25 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
-	if (kernel) {
-		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
-			err = -ETIMEDOUT;
-	} else {
-		err = wait_for_completion_interruptible(&ctx->work);
-	}
+	/*
+	 * Set message context as polled if the call is for a user PD
+	 * dynamic module and user has enabled poll mode.
+	 */
+	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd == USER_PD &&
+	    fl->poll_mode)
+		ctx->is_polled = true;
+
+	err = fastrpc_wait_for_completion(ctx, kernel);
 
 	if (err)
 		goto bail;
 
+	if (!ctx->is_work_done) {
+		err = -ETIMEDOUT;
+		dev_dbg(fl->sctx->dev, "Invalid workdone state for handle 0x%x, sc 0x%x\n",
+			handle, sc);
+		goto bail;
+	}
 	/* make sure that all memory writes by DSP are seen by CPU */
 	dma_rmb();
 	/* populate all the output buffers with results */
@@ -1780,6 +1877,29 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	return 0;
 }
 
+static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_ioctl_set_option opt = {0};
+	int i, err = 0;
+
+	if (copy_from_user(&opt, argp, sizeof(opt)))
+		return -EFAULT;
+
+	for (i = 0; i < ARRAY_SIZE(opt.reserved); i++) {
+		if (opt.reserved[i] != 0)
+			return -EINVAL;
+	}
+	if (opt.req != FASTRPC_POLL_MODE)
+		return -EINVAL;
+
+	if (opt.enable)
+		fl->poll_mode = true;
+	else
+		fl->poll_mode = false;
+
+	return 0;
+}
+
 static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_ioctl_capability cap = {0};
@@ -2134,6 +2254,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_MEM_UNMAP:
 		err = fastrpc_req_mem_unmap(fl, argp);
 		break;
+	case FASTRPC_IOCTL_SET_OPTION:
+		err = fastrpc_set_option(fl, argp);
+		break;
 	case FASTRPC_IOCTL_GET_DSP_INFO:
 		err = fastrpc_get_dsp_info(fl, argp);
 		break;
@@ -2465,6 +2588,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	ctx->retval = rsp->retval;
 	complete(&ctx->work);
+	ctx->is_work_done = true;
 
 	/*
 	 * The DMA buffer associated with the context cannot be freed in
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index c6e2925f47e6..6c1375ba0042 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -16,6 +16,7 @@
 #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
+#define FASTRPC_IOCTL_SET_OPTION	_IOWR('R', 12, struct fastrpc_ioctl_set_option)
 #define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
 
 /**
@@ -66,6 +67,8 @@ enum fastrpc_proc_attr {
 
 /* Fastrpc attribute for memory protection of buffers */
 #define FASTRPC_ATTR_SECUREMAP	(1)
+/* Set option request ID to enable poll mode */
+#define FASTRPC_POLL_MODE	(1)
 
 struct fastrpc_invoke_args {
 	__u64 ptr;
@@ -133,6 +136,12 @@ struct fastrpc_mem_unmap {
 	__s32 reserved[5];
 };
 
+struct fastrpc_ioctl_set_option {
+	__u32 req;		/* request id */
+	__u32 enable;	/* enable flag */
+	__s32 reserved[6];
+};
+
 struct fastrpc_ioctl_capability {
 	__u32 unused; /* deprecated, ignored by the kernel */
 	__u32 attribute_id;
-- 
2.34.1


