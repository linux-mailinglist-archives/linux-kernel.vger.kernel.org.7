Return-Path: <linux-kernel+bounces-862407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8ABF5330
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE74ED9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490E3019A1;
	Tue, 21 Oct 2025 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOXwbUxU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16DB301032
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034529; cv=none; b=Vxs+VKQeFTftmK3NjyYv811rM1WBl13ONROlt2be0anpzKU+1+XZUiaXdP1kV2diHjSo4qEZw2GxQkCqPS/jqv9KpdZDj0RO5AMdobaNvtR6RDDk5pi9fu2Tclxmhc5KZBkVU61v41n6holxTx2NX3QJ1BZJIdyiVoBBd+CBGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034529; c=relaxed/simple;
	bh=PH/yYzPiF38Ts+PU81615VMJ5fPpJO05sQsrfNqz2SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h6JNFLXFTdby6CsUNcGMTmiJeCSMTWOCTjS3RqhKdUwnnTjnj0QjbSpe4W6WslVC5QSlXjJCLGY4qHtP1xmR87odTG/0L2r1F6NVikdfSM0NYgEvIzIvWIDcwM3MycTEZQSNNBSsYECtViz+PZkOQkTiAIavrqIVdrvHqtmkFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOXwbUxU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8EP4h032755
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Juw2EmxApd8NApmkUfGKED
	HjRrZ6lqgtmTTa5riScos=; b=MOXwbUxUMk2AC+VAxbLM+Vfe8Wutx9PSc8V9Kv
	qUPWNBxojM9gs05z62i8F4Q0L4rhMUCB9OKdit34I00hWZUCU8Fsze/aMEfhUi/2
	bzo0hNFPF4teFapBprnOH6nkDxq9KfjTJCzmfTkdUDlYxJrIPRE5MVgdDRPqDYa7
	iFmcthj4Dsf917QgoDifVt3TQibNAkq9T9C8YebxvCSoxcU9Q084FzhRE6NipPnO
	BD84SN13YPStxK4Uab4ribE43kTC/BxqeRus1DYIICmBl3NPWhNAFZWF5DjosxaN
	bWBWmMd/rB/SgPTQ+tXK6aX6v254JcvTFsYiOxdzCG8NAZqA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w591r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:15:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6cd4d3a441so66771a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761034526; x=1761639326;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Juw2EmxApd8NApmkUfGKEDHjRrZ6lqgtmTTa5riScos=;
        b=J20IQ1jvp4DC92ZN3EaFRtF0X/70EnjyGcCrd9vbHsTkzDWFz3bYB1EqM9iC2Q1O26
         cJYFK0bV26brOI29adn2EH1BSSZtBER8+N2F8okzRIqi2ipyCgG7WC8/uloIrz8Nn1yN
         37zN6/BO/0955+J+L6dxajwyqg97j08elv9rfKmI8M029eb7gvTKhobJ8NnuBvqk4GSB
         W10FtZj7kyKFG9ulwDan5xf00fo4fa/126NcmZSikT4k+57/aKDCF5Y24Q5THWt7K+8z
         MKkp0scSUmqIxVxSogOafKVTwHeDJClYedyqRwbU29F4RIk5vLxGOhLxceXnt3nqLRV4
         m5eg==
X-Forwarded-Encrypted: i=1; AJvYcCXzRmA2vfq5kmgS9VcE7mdXOITufeTkaSqhBOBDb+sD2dOTH0WOHk0qE3i7Bg1sGVif+AosOQ6uYFDKm5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRK3IRnVFZa46swAw563q+crEtjRXrzT9M+SfJ8TK+d1A7qLQ
	4xyjOqxTGugE5vNw0TwDEgegfDKBgZuISRG/K9YOzk8h8vwRB0JZKDc6wDXEn2YKjds+0qoJUSd
	+Bc8mP0aAuP/KJNlxiQVW8fH/WThzBjbyABsIZi241yIXVUv0JXrDZymIqfP+ZH9HdsY=
X-Gm-Gg: ASbGncuHL/phqsJbMgYEXAeRSNcUzicnDx0RP0tiNg7nqUvvM5FbbgItO++SJAjUTsp
	q05eXdHk2LbHa61qKXAFB9ajSAzx51zd9ie8KVjAN9HYizhTHi06e7gpuuDEq52X8Aq2LvXiitO
	XeWZVyKcyCDzkQxbeE+QNYO3Vgqbq2DvHAXBYEJP2zEAHfooKZ3ZnvqYWPoNAFB6U2LMoFw7/9s
	0nZdoBPYVT17X3flJnmXDtBmrKGb02TURXtFCBdbArMDPNfaCTHbWlB05VoP2keZ1U459CIq8HH
	twpMBCm+8TrQUggy9oD6BrcO7jqC99juFYI2xJCZQW75+Mb2CU4iLYRFpe6zojWh7sUHPq/lITI
	46w0IBUWyxcQrHGsCKThA9OTrxgFgqgUhKHaI0mJdcwRJmt41Boc1yXRXpJezoEjZ4wQ8aMDp0Q
	==
X-Received: by 2002:a05:6a20:7486:b0:243:fe1e:2f95 with SMTP id adf61e73a8af0-33495c0e1cdmr30861208637.6.1761034526113;
        Tue, 21 Oct 2025 01:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUnVtE1kcR/waPYu1P5iqYPCnOVM4lKkg8WadrGpewX/U4oXJcwvTuCkipv6O+65Hv86sZvw==
X-Received: by 2002:a05:6a20:7486:b0:243:fe1e:2f95 with SMTP id adf61e73a8af0-33495c0e1cdmr30861178637.6.1761034525684;
        Tue, 21 Oct 2025 01:15:25 -0700 (PDT)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76676c01sm9675447a12.16.2025.10.21.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:15:25 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 16:15:10 +0800
Subject: [PATCH v2] media: qcom: iris: Add sanity check for stop streaming
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-iris_add_sanity_check-v2-1-476b3107a8ef@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAA1B92gC/y2NQQ7CIBREr9L8tRBAEHXlPUzTIEX7oy3Kr9Wm6
 d2ljZuZvElmZgIKCQPBsZgghQEJY5dBbQrwjetugWGdGZRQRgolGSakytV1Ra7Dfqx8E/ydbbU
 T9mCsNhcJuftM4YrfdfdcZm6Q+pjG9WaQS/pflDths1uu99owyT7500W+2CkS8dfbPXxsW54Fy
 nmef/FQhbGyAAAA
X-Change-ID: 20251021-iris_add_sanity_check-34a0795745b1
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com, Wangao Wang <wangao.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761034522; l=1875;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=PH/yYzPiF38Ts+PU81615VMJ5fPpJO05sQsrfNqz2SE=;
 b=E1An26hqVbJv/w9q8H6qt5nQ2VnBcjUwUJ/C20Ko6UpOEtyGnYI9ylCYV7/mGlyR/Y5UPrZ+1
 REklUfEByD6BIHQ+Vu+W2bnKuJL/BvvB4Dmk5V/P4M79+T2bY5+zh8w
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-ORIG-GUID: OCIxZvnk0baX5g6CFVV00QrVXODOm1qp
X-Proofpoint-GUID: OCIxZvnk0baX5g6CFVV00QrVXODOm1qp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfXx8T8Kbglc/By
 Eh9G3h6pRwv41U8qXm1yR+MvnJsNZ3dQHCBh0og4f2mBXI4ZHUmp6cnXqJaW61VwChlXr+1yMEn
 /hjaJ6G5dWBJeLPOmYoY5xIEaV7ssTBrErbTEI0/zbgYfePDlCg4XjpAD7okknlLx+nDdBXt+dA
 r0D5EMK7atR6Sm6KtVPNBifpj+zBhs6tntvPNnNKZL/BZ/drecUajsf3rQp/pnmD4YWOn3ieI2x
 uhIuWAP2spIWvgCrkP9sM1SRB/4ik7fuNsvCX2K4fzEaQyOqYAwyih5xVyZG/NRIur4KQNN2Elh
 2PHvpM3k3QB9ynz7E9QNmjgN5bVCbqKI8cZ1D/5Sf/E1LN2nTH7uzrglhD3tHc4BXZ3lZMTJfEb
 0XvuB11/imVcBXz9F2lNA3wk8xafAw==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f7411f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cYsYxGlOpVVTreCKc7QA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

Add sanity check in iris_vb2_stop_streaming. If inst->state is
already IRIS_INST_ERROR, we should skip the stream_off operation
because it would still send packets to the firmware.

In iris_vdec_kill_session, inst->state is set to IRIS_INST_ERROR
and session_close is executed, which will kfree(inst_hfi_gen2->packet).
If stop_streaming is called afterward, it will cause a crash.

Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
Changes in v2:
- Remove redundant ret assignment in ERROR state.
- Perform error handling according to the value of ret.
- Link to v1: https://lore.kernel.org/r/20251016072517.4845-1-wangao.wang@oss.qualcomm.com
---
 drivers/media/platform/qcom/iris/iris_vb2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
index 139b821f7952feb33b21a7045aef9e8a4782aa3c..db8768d8a8f61c9ceb04e423d0a769d35114e20e 100644
--- a/drivers/media/platform/qcom/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/iris/iris_vb2.c
@@ -231,6 +231,8 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 		return;
 
 	mutex_lock(&inst->lock);
+	if (inst->state == IRIS_INST_ERROR)
+		goto exit;
 
 	if (!V4L2_TYPE_IS_OUTPUT(q->type) &&
 	    !V4L2_TYPE_IS_CAPTURE(q->type))
@@ -241,10 +243,10 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 		goto exit;
 
 exit:
-	iris_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
-	if (ret)
+	if (ret) {
+		iris_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
 		iris_inst_change_state(inst, IRIS_INST_ERROR);
-
+	}
 	mutex_unlock(&inst->lock);
 }
 

---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251021-iris_add_sanity_check-34a0795745b1

Best regards,
-- 
Wangao Wang <wangao.wang@oss.qualcomm.com>


