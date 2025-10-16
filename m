Return-Path: <linux-kernel+bounces-855666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DEBE1EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C21A3A493F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4292C2F1FD1;
	Thu, 16 Oct 2025 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTYxcLiX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AB2E1F08
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599530; cv=none; b=CMNLYD9fXMjN5dxd6dGf1tq47F8cbFrkeyjq7aMTxWPbT4SZQ/5J+APRy0vqZDOJ37CN9voqCuZhTvfDyFZoPyjbKSgXFp8q2mvTT7mj+3ChnOxCxLr+MRMjbZDYwa5bP3e1AHes6efF6QO5CIClds1KFOR+GRPnxS8+IzdbmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599530; c=relaxed/simple;
	bh=UL1DxIhLTDNdEMRngw5CUum4btc2pYG9yp7myJlu1xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RshBsuxmZOPU7egR6uCo75QaewN9J8mwG7itX4j+vqf+v7D3WOvIFyb21qJN44PegQJPE510w7rUl7FP8VITK8QLXWBmzyyQtFcMW/IRnZf+FaLsleOktVBIjHSoD5SoR9LAOpm1Qs85hXfzQsm45oIFzppR95cRC8m/6zEItXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTYxcLiX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7H4bc005092
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PYLX8mTWQSyaQ2t9hxMxmjQVF4OOp3VkZF2
	bVL4kQk4=; b=cTYxcLiXmgVfohQr2jgxpETSOxsQb4atb7aq8BmMeFHdDHB12Bv
	7oHURSVfikjORwLj5vGtwxQV0PLra3knbcjZEOW2o7/Rx8po+lhoaEAo8RAJ9mIE
	lEE/AHHbUn4itY5lZmFvyLbir64XNI+bdvsjfUn0nf6M5XTlnWYpSRzvddPDWJTY
	w9nQqLf0RWWVWjEMbPZQ8qFYteN5oi/ClLF9bbXVao5qpag7Kfo/rkM9saWHFZWE
	UEX6qCT0iVePJwOlC+/BAOLzjXtKXveg5VpeTO/taMCvmtTlhmIY8RA4zXiZB1R9
	dpbX+5H+vdknUkdVzQMjsE4wrnwzSoS2nVQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg78dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:25:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so135346a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760599527; x=1761204327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYLX8mTWQSyaQ2t9hxMxmjQVF4OOp3VkZF2bVL4kQk4=;
        b=oJ3wug8J+F0ESOCTOpq8PhHddx0aXo/XRWS6/A10vLnhtq9D+kncHNTGWZq+NwFon5
         JWzoIBp5zQlK3uJy+hamkRAfGaxqkSIcgROsSsGsxERzfly1wAvo/CQ/4FyiHz83EKrs
         MdQkOM5hL+lNtUycp8psmqJky4xwA7GwvCB7Mhww00HUplrnPpQSP0rCyuqRMiPHEI2p
         o2EBdYGgYeCMiMlfvbJkRe1iJNDEGj7J+1ASXPfDNBY3INXhKBUseH6oc/XkeK2QaOhm
         bXx/OOAe4WB50GUjxg5HLGUni5ZqS8VqxNYGCVqKM7rgiMHQ2FqhUyAM9pVspNssYaKK
         ruFg==
X-Forwarded-Encrypted: i=1; AJvYcCUdE+wBqcfpytOXXAN264s36lBATzZP6iPbFFUyxzH6n7zOGO0YGmchHeBQQ/97x5zTBttaTq6PtSjZmdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNV8OvVuaLxl0qr6Yu9KmH6oeAgNYjCDaLg5maIJVyXyfzyf3H
	Y4YxAyVyfUNfCrOHpGbbd5j95WifkihpLTEvrK4em7ibVwxWiTPHxGKIu6BTArjhcBidLIAj5JS
	1aMq09ncTG6CLojVaRmAtFsv+Bc1rka4l3i/k822g2YeqJA/U38NboJS6Qd5M2wdJhg1oN9H9hu
	Q=
X-Gm-Gg: ASbGncv5dfOO3SD0+pfnFrsII8r7+4IAfHeDtLYrTi2BbwRj/HprKgF2Bs61KXsTezg
	mf1F8VK+0n7Men4pFvVZzXHvus7g7tRVC3uKg2d6Ns6ngIyvJGKHaOKS+lhTHL4G2ndA9615Pbh
	1q72BoEsnDjB3IJX/5p99IrYqwHuKDZrZm66wwGyICy0TI8+XAEFY5yFH4P6LAlQG+PLfiza3sS
	de8Zn6krjX3tK7GSAV5BSjUZ4gxJDHOAbhfk/IKjbW4P9HxZidU6HH2G/YJWk9kdjPEzwICpTV5
	Lh82oA4vH6/EXlf4sj8NjBsYJqnDGmRoRZokulQewstBan0erPKWBVnJDnSTa+C6h4I6Ndr7RNR
	OF2pR+gzto3cqX8ZSU8U+2Im0OzX5vk3EBJ/Upu7zGxXPCHbsgxE+2wf23i4oCSZYO515Vw==
X-Received: by 2002:a17:90a:e7c4:b0:33b:8b82:98cc with SMTP id 98e67ed59e1d1-33b8b829c10mr12376899a91.14.1760599527395;
        Thu, 16 Oct 2025 00:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8EKOUJ8xGsupmOiisrAsUTMSki73ipiDYPVq89pIraBuMMaoKj84FJrrdjz62zznsHQL1Vw==
X-Received: by 2002:a17:90a:e7c4:b0:33b:8b82:98cc with SMTP id 98e67ed59e1d1-33b8b829c10mr12376874a91.14.1760599526961;
        Thu, 16 Oct 2025 00:25:26 -0700 (PDT)
Received: from WANGAOW-LAB01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb663f591sm725450a91.21.2025.10.16.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:25:26 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
To: vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        abhinav.kumar@linux.dev, bod@kernel.org, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com, Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: [PATCH v1] media: qcom: iris: Add sanity check for stop streaming
Date: Thu, 16 Oct 2025 15:25:17 +0800
Message-ID: <20251016072517.4845-1-wangao.wang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX+MpLpisdMzZA
 YPG3j/Su3sd9RGH0jEeAUi5VnJwcJ+TSinh11rv99lhIxDrkjeGu9wtFdXVQk5CFEfaKXHSn5eg
 OUVyeBiYkoqZVMQmho6tfweZLxMuJugruRzjD7WdeR2LuBByOnO9aMPBEGcAPfwD4CPzclyTt+p
 tzfR/pCO26ranOoDY5SH9sF+Ex7p/9v4qlBX12iRrlDjzokrJQdWRGafCl7Xo9ZMtoHTz056HDb
 CDqVn7kjomfOjOb4bZfiXgpT9wFmpiwCJZ17r37RqXMG6fnCddyTzU94l0OTdNEqmpR91khU3a5
 QOAbznlqEHvm3QzafqCYXPIxOwXNbI4eWQ+5mLY3wE12hKkSwChRI23TqYykat/YWyJ3KVpJ2qn
 IILh6VlM7ak7mptv5LNVdsoisTL6ig==
X-Proofpoint-GUID: JrlZp8vF05jmRSJ7hCnIVw3jWww5zK04
X-Proofpoint-ORIG-GUID: JrlZp8vF05jmRSJ7hCnIVw3jWww5zK04
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68f09de8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=cYsYxGlOpVVTreCKc7QA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

Add sanity check in iris_vb2_stop_streaming. If inst->state is
already IRIS_INST_ERROR, we should skip the stream_off operation
because it would still send packets to the firmware.

In iris_vdec_kill_session, inst->state is set to IRIS_INST_ERROR
and session_close is executed, which will kfree(inst_hfi_gen2->packet).
If stop_streaming is called afterward, it will cause a crash.

Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vb2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
index 139b821f7952..c1647fb4f0cc 100644
--- a/drivers/media/platform/qcom/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/iris/iris_vb2.c
@@ -231,16 +231,20 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 		return;
 
 	mutex_lock(&inst->lock);
+	if (inst->state == IRIS_INST_ERROR) {
+		ret = -EBUSY;
+		goto error;
+	}
 
 	if (!V4L2_TYPE_IS_OUTPUT(q->type) &&
 	    !V4L2_TYPE_IS_CAPTURE(q->type))
-		goto exit;
+		goto error;
 
 	ret = iris_session_streamoff(inst, q->type);
 	if (ret)
-		goto exit;
+		goto error;
 
-exit:
+error:
 	iris_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
 	if (ret)
 		iris_inst_change_state(inst, IRIS_INST_ERROR);
-- 
2.43.0


