Return-Path: <linux-kernel+bounces-793824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D61B3D8D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27B61899587
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBC22D793;
	Mon,  1 Sep 2025 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A30KZJ12"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435D2459E5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704835; cv=none; b=k714DqklTiLFawOznaNL53/pwj4nUsY1Azx/5UQoRru76iaxWIKTARU31eYDFj7VGNfbT59xTOF3KJFhG9Mgy5e2XSqIInXCtq+xY2WiVnduEH6sMwo5zboz8IBUlFLE2c5vNZnlDs5n77nFSTpEjYmOw+Lh5m/wwTvx2DQDjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704835; c=relaxed/simple;
	bh=6KFSeiSuBzuKsITck+2SsO78XsJpd/xEqNQODmg2eJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4TyB2g5HDtN9Z2W7fn5K56RfoNhpiwg9+o5Rhug9rwDzkEKz7DG4K/g6bYv5BasyQtuG9E2Df716r+P4vZXsmNSuEYWtUOZaISjH7s9cpIcjxHCNkdikzI6FOb9oMgPG6d64SVHYyD8DpYoxzoM+S6qK8/drMwZ9nN+v459Tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A30KZJ12; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VKw4Gk005313
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 05:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PJrhcPrDxtA
	aLTpVBo5ImLLvyFEL/Po5FpTP77TaIGs=; b=A30KZJ12n1dWhu6mLT9rw9wgQcK
	gfs9yon9+AtQtNpcldkE85XmjQ8n2KDpnD+JxcS9B7WCuKAkdP5ltQKOtB2LDFJc
	hNJnchzLUbdI7/ovBr3kkBIiVWqB+pRJg+MQesWf16741dNPhW5COpvLiW+2fUDL
	diawTtiWSA2qjPl+2DO97qblct/7mWf/xDK/+7I3d8ahV2jTWMVhoi5ZZDO7i1Dp
	0e/URbQQqewFL3+TogHhqgLAajku5HjBo4q6w2/LiCrKor9WJBwpK1rpSqAuNMZA
	wDEian1iPbnGu7zoNPrp0kXe3Z4LR1fmpd+CoMXCegnviJJIEnzQZ4VZW+g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuuc1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:33:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248942647c5so54971335ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756704831; x=1757309631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJrhcPrDxtAaLTpVBo5ImLLvyFEL/Po5FpTP77TaIGs=;
        b=E+phMI1OyCOOfMSHzMMSscecycaZ4+WkSTEteSr3b72dc9Pd6Lua44hxaIXrBHam+o
         AZ9cQTfJad18VbcD8UE8pdJ+N/sIwecn9S6LjuEqR486y+/+xomOC0sOgokXi28o/6DY
         UyrA65PfLrbrWeuDnfLJ6ihmFB2Fj6F5SkKjKVkPcrvmSofFf90ZVnuYgvAOXSKjSxke
         h5NnZucvvmhced0bI/TaHOf/opfVtpILeH66rA1/CHErXlgBRg+vOy2D0zKd/uYQmxqH
         xwlVqAsPtKNSBVDmJ19XD0bDAGLWUfOBai7Jg3we+qZgPjnShSwmPHKMRTJr8sRRU1hY
         8h4g==
X-Forwarded-Encrypted: i=1; AJvYcCULKXtBcWwt9MV0Tn93pJ2iBiZfYZf3gWwUnomsaAqg8w4w6kjMWLvMV5tclY9SPG8DluLgyUoNF6n38XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8iHJgVbqZZ+9s4kC6ud7PB8H5R18JJVC8iLjfiihIbnURK+k
	s1aF4ORmqHkV+itOMSfCxhXcrThjYg1Kwa6X3oFGlw17Bdauhp8rxm62YRboJfCG0WR50w3ga6u
	lfto7xIaRBvtZzh6OjHokdtrsNM56RSwIH4yeiz1n1bxVhEZT3h3PqVeaCuM9tNtqvAg=
X-Gm-Gg: ASbGnctPrswneABvkQlZE0JS5ze3lO69u+Sh31Y0I+cQwYnwqm44BOOjsgv0MTeEa5S
	6OclWYobzRD9Qg7wjIqK9B9bvHzZvFYMTTCxMC//GM7TBtJ+9iHNlPXOTtHVlizH1dMiBCjRDao
	k4DmllC0mllnOb2OgoeGvIcZT5ZoTKe8hx9tVqpWDwWZDAJdbYdvezzeDLEa6UzW0fSOjKPRWl9
	+OFf8xWZEPYL2OZZbigx75EZ90X3+JAFH41cSigWTmcV604tnknfJpXBpSx8a1bRZ9ppJvXtYFL
	RtLQzx9b5hacKbBX4TYkw5hncfowikZ16HNmU7FfXYhBUiHMY3E3TjAN2t87+5lJoInoey9S
X-Received: by 2002:a17:902:ef43:b0:24a:9342:ecc3 with SMTP id d9443c01a7336-24a9342eedbmr70826225ad.14.1756704830909;
        Sun, 31 Aug 2025 22:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhqpEk7q7A/DBRPo6CsBLfJOQqRNoGke7j4NG1VUXwsA9wGhUFFD0Jkvw/joCd7egv/h07Uw==
X-Received: by 2002:a17:902:ef43:b0:24a:9342:ecc3 with SMTP id d9443c01a7336-24a9342eedbmr70825845ad.14.1756704830377;
        Sun, 31 Aug 2025 22:33:50 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906589986sm90575215ad.111.2025.08.31.22.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 22:33:50 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v1 3/3] misc: fastrpc: Add polling mode support for fastRPC driver
Date: Mon,  1 Sep 2025 11:03:36 +0530
Message-Id: <20250901053336.3939595-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
References: <20250901053336.3939595-1-ekansh.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX1sU7AhueraWm
 SFKiVLKiDQqByf6MMnCNijpdoQYTgiox7FKk23ELvNqd70TnCc/dO0PwXnYsHfofb37SJVeC0fL
 zDxPesqAINe2m2tmU0gqfGSZrIQ+2JxtDzPUryGIJUlF9GsVk9dJ9yNxj/R6eBqTdqI0grtJU/w
 tFCM/BWV4nynYOrXeyZUoKGDUSDTO/evuDksqbblu9lkV3yn6+FfIlROUXO2re5z40mXzX5wplk
 7+Qr8gF3PbzK/ouM3UJjjRGZPZqZFXo6H2fN/+W34hS/oDQSQUBSGWHkET2CjQAT36d+Jgx2nG+
 t+gm4Dh1QyCbAz1GCYBmFISVpqbMX78lGRO+GTwWrbhU0tp4eFbkLgfWjwi/t1V38zF3Cn7zaCr
 OgkYLlS3
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b53040 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MwYQ-C_c_HC-XfEYhDkA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: YvvrNhjHsYTXQ4fLM_B6axnrhliU7rog
X-Proofpoint-GUID: YvvrNhjHsYTXQ4fLM_B6axnrhliU7rog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

For any remote call to DSP, after sending an invocation message,
fastRPC driver waits for glink response and during this time the
CPU can go into low power modes. This adds latency to overall fastrpc
call as CPU wakeup and scheduling latencies are included.  Adding a
polling mode support with which fastRPC driver will poll continuously
on a memory after sending a message to remote subsystem which will
eliminate CPU wakeup and scheduling latencies and reduce fastRPC
overhead.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 121 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 57e118de6e4a..939a3e3d29e2 100644
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
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
@@ -105,6 +108,20 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
+/* Poll response number from remote processor for call completion */
+#define FASTRPC_POLL_RESPONSE (0xdecaf)
+
+/* Polling mode timeout limit */
+#define FASTRPC_POLL_MAX_TIMEOUT_US (10000)
+
+/* Response types supported for RPC calls */
+enum fastrpc_response_flags {
+	/* normal job completion glink response */
+	NORMAL_RESPONSE = 0,
+	/* process updates poll memory instead of glink response */
+	POLL_MODE = 1,
+};
+
 struct fastrpc_phy_page {
 	u64 addr;		/* physical address */
 	u64 size;		/* size of contiguous region */
@@ -235,8 +252,14 @@ struct fastrpc_invoke_ctx {
 	u32 sc;
 	u64 *fdlist;
 	u32 *crc;
+	/* Poll memory that DSP updates */
+	u32 *poll;
 	u64 ctxid;
 	u64 msg_sz;
+	/* work done status flag */
+	bool is_work_done;
+	/* response flags from remote processor */
+	enum fastrpc_response_flags rsp_flags;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -891,7 +914,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 		sizeof(struct fastrpc_invoke_buf) +
 		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
 		sizeof(u64) * FASTRPC_MAX_FDLIST +
-		sizeof(u32) * FASTRPC_MAX_CRCLIST;
+		sizeof(u32) * FASTRPC_MAX_CRCLIST +
+		sizeof(u32);
 
 	return size;
 }
@@ -987,6 +1011,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
 	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
+	ctx->crc = (u32 *)(ctx->fdlist + FASTRPC_MAX_FDLIST);
+	ctx->poll = (u32 *)(ctx->crc + FASTRPC_MAX_CRCLIST);
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1155,6 +1181,83 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
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
+		switch (ctx->rsp_flags) {
+		case NORMAL_RESPONSE:
+			err = fastrpc_wait_for_response(ctx, kernel);
+			if (err || ctx->is_work_done)
+				return err;
+			break;
+		case POLL_MODE:
+			err = poll_for_remote_response(ctx);
+			/* If polling timed out, move to normal response mode */
+			if (err)
+				ctx->rsp_flags = NORMAL_RESPONSE;
+			break;
+		default:
+			err = -EBADR;
+			dev_dbg(ctx->fl->sctx->dev,
+				"unsupported response type:0x%x\n", ctx->rsp_flags);
+			break;
+		}
+	} while (!ctx->is_work_done);
+
+	return err;
+}
+
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   u32 handle, u32 sc,
 				   struct fastrpc_invoke_args *args)
@@ -1190,16 +1293,19 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
-	if (kernel) {
-		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
-			err = -ETIMEDOUT;
-	} else {
-		err = wait_for_completion_interruptible(&ctx->work);
-	}
+	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd == USER_PD)
+		ctx->rsp_flags = POLL_MODE;
 
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
@@ -2462,6 +2568,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	ctx->retval = rsp->retval;
 	complete(&ctx->work);
+	ctx->is_work_done = true;
 
 	/*
 	 * The DMA buffer associated with the context cannot be freed in
-- 
2.34.1


