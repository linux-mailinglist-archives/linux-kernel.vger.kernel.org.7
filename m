Return-Path: <linux-kernel+bounces-871238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD4C0CB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF7194F1B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB792F1FDF;
	Mon, 27 Oct 2025 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PjSOtokh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F22DEA64
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557800; cv=none; b=TRKkP6olithPyGsjJTmHFAPmnMGuXPTGlJNi7hmvU7mvilLoCfri98WA+s18zQpVZLSb4zn1JVnJHRVgd3zYinDNnCTHfaK4hICCI2BIBOLJsXRr3OvlqLgGQaSZyN/OpB017qOh/mbkuWt4Km42CHhKc2gKfc1Yyg7SyeSzbWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557800; c=relaxed/simple;
	bh=Khj94kjwzlJbqlD/zjORwwhcFLyw8gdkdROyQ3iMPHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oZIYByAyp6xv6rQHx3oFbIKtGmFfNostvdpj3jI9HMMTcl1iET5+6iOdmWFpuqo3ZHrcGiV/DambDM9+DW9siYB5QhCE6rjWZS9RLlt97+YN1lJX0tun+qiVCHU/0TjE2VOLkGakiQ9oMBih5SzhMLJ6bMWCiejRwlEBpbXcJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PjSOtokh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8ojIt1030730
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ENIfG/XFqoejrJF6odTVWj
	Lh+6lA05rZTNqAr24kEaE=; b=PjSOtokhFThbRN/QDQg7iwJBEFe3XUJxANEpot
	RHPVSPyXEqfcU6YbBCKhZ+VRVSZxYwJ0vIwUpJWGLbP/OYCIAfRBaIFr5rZbLlLN
	3T9Je1LLosHZINgCmvUx89vE1IDYH1uMT1jQw43Ofrmvh+PDkurFK0KtCuR54Ehr
	eBfUxuLAvNM/Tsncm4LO1hMjJWmHaXW7KdzM63+Rfhqky3tlStSthXsaf/j4QKk0
	gBWxb630Nj4jQTFPFAEqxLLbdvGimYKJxLYoURxYI2uB7vVwpsx6hw8O+76EimJR
	9H6Fo8sve9QaHA8qidmHRnfIPoG1e2STImZ7Qi1PSfnSV8Lg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4wc2gb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:36:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a27ade1e73so2962729b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557797; x=1762162597;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENIfG/XFqoejrJF6odTVWjLh+6lA05rZTNqAr24kEaE=;
        b=L/QQl7eyPYJAzL0WjN1qZ7WCUPaAxEQOD3BzdBdmDV4OP0wks73EpVKSrbXj/6Enhz
         /pEUinBc4zb5tuBseZNoecUllrMQfdQg7Nak0fMgutOPLR23TKrU5TtXNk4whJ4PpokV
         Q36BnO6uUaHpa5CYmqwextbUTEjecWv6sFszq84E5KiBfbwgpqoP+xeNqIcAKzrITPy2
         P35mQgRF+qrRe2h6AGe1MCB8ZJ3tepu5arBxKO9ZqBigGrclGjLa7bhG3/dj3RxglKaK
         SvWULljKOg/D2+1YwJx05c60qMMfGohCoUJGcon8CaYnESmWXKQiE/FMOgG1U79UJxYw
         6DRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/9yMDQpmCJDbe7DVomzA/3EwrooY5Hyb50Ra6MoeXxb3FXTLGp+79dgO3F3bJl0SwqosDwHMJWw6IHdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEejcKKM9A8Z2+iReXzRnTUpHZauKe89nAgNRqB1qP+k2e/jSk
	EgzRCBzl06M7EwQUtPHKPq9TqrCkFdVrUxRmWc3Wt3Yop/sDqMZZveFYjOwvxFLpQ2jSPay6KqV
	KKTEw8sPCVTuzVbzU2naKmUZ7ErMjzeVnI/UUE0qK+j98cJaLjuv6x/1XTshhAjlPUdo=
X-Gm-Gg: ASbGnctHIzoKyVNRHIdW4iVfNVIisPfocLIAyAQ2zOgr3/pTQOfYNYGhTKY66fHHlod
	8pfYvZsQTL65m4iHgsCJ+pwyhPYG6jrAcgH8rrsro5h6EG968+Bzophfhl5jgVRipWrlg290AAy
	PChJGIlMD43mg1xdk7sgUXIQ96Hn+Ne2LDRbU8S+f3anytue2Opyj8j/XVzw38X6fYxid8KFAQt
	ed7XIjeO+4pOBkrAAvBallCbxNGDOssAi3H9RjD2/prTeGe3cRqdNpx8iC3qDMoqbktxFlbgLxL
	ZXExYT7WmJ8Io3FcBKQCHTrvRN3Y4CPRHdsnmQ4Ba+PNGBMvtT67dUZ8+rwrzwi9yoJ2tWYZ3Xt
	55nIQczBv+edoIIb4V/OpSo6KpTNTrLqqSeX6wj3EGupb2VMVIxdn9pH5YADhoZLyOdn6h+ULDU
	RdAw==
X-Received: by 2002:a05:6a00:2d06:b0:781:2272:b704 with SMTP id d2e1a72fcca58-7a286765aacmr12626241b3a.5.1761557796997;
        Mon, 27 Oct 2025 02:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAFiQ7WbyW6vRWAA69khlgDmMsnnZ+1kMFCE67svLShDKNyqE5vG5rLgQQdpOVFLPl4sbfLQ==
X-Received: by 2002:a05:6a00:2d06:b0:781:2272:b704 with SMTP id d2e1a72fcca58-7a286765aacmr12626204b3a.5.1761557796479;
        Mon, 27 Oct 2025 02:36:36 -0700 (PDT)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414032c71sm7605282b3a.25.2025.10.27.02.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:36:35 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 17:35:59 +0800
Subject: [PATCH v3] media: qcom: iris: Add sanity check for stop streaming
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-iris_add_sanity_check-v3-1-232ad24d75d3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAP48/2gC/3WOQQ7CIBREr2JYCwEKpbryHsY0lFL7oy0KFW2a3
 l3auHChmz+Zn8ybmVCwHmxA+82EvI0QwPXJZNsNMq3uzxZDnTzilEtGOcPgIZS6rsugexjG0rT
 WXHAmNFU7qYSsGErZm7cNvFbu8ZR8C2FwflxrIlu+HyLLqUqqiCiExAw/U6d2ZJGDC4HcH/pqX
 NeRdNBCivwr/XdP5IklVF5ljCpd2OYHbJ7nN3rYFUf/AAAA
X-Change-ID: 20251021-iris_add_sanity_check-34a0795745b1
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Wangao Wang <wangao.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761557793; l=2209;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=Khj94kjwzlJbqlD/zjORwwhcFLyw8gdkdROyQ3iMPHY=;
 b=em0DoN2wg7lN7Dz4uWGbJvHlky/OUnrEB9kke3FX3k0obk747wBvdC9HCvU1M4/vPLf34iz2N
 xdxLVxAuJcSB657fkuwBfzxVYa28c1JQSvxcB5YZVwkS8qMtNI3WHNh
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-ORIG-GUID: DZNZkHB3lX58_pb9KXfQbw5VdOfSTbuW
X-Proofpoint-GUID: DZNZkHB3lX58_pb9KXfQbw5VdOfSTbuW
X-Authority-Analysis: v=2.4 cv=NobcssdJ c=1 sm=1 tr=0 ts=68ff3d26 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ypO2gLpQ1gAfsPQhGccA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA4OCBTYWx0ZWRfX0Dq232hKhZsg
 By68VLbK/rEGwkzw7s4IVb+QeNsSC1gxrHGCe595tUJEaKDj7GWjpVOPynUFUAFff+GC2s8GvK1
 mvj36GVBU1zLdRr8vzTzq9oaeGaNb8R1/LCwxIICLtJEg2YDB5H+er47CKjwDAORWzv+KAXQcaD
 UA6LIqq7LU+BmRqTn8Mc+ZroO7+YVVH4uZLWbcVeONmA99OmKbugQ7AO79JIktvQ9f4JlDcp0TD
 377NQ5U+OfylSLez9f+71MxmTHr4UFzPlD7QPNQ/1SiQk+CVsUwZuVaXe5ORtXN1onTxuQXHPTp
 82M0BgiUrmzVFqhemtuMPeqU7Ik3PUG+jMzDE8/AscSAI4A9N8OkOwlSkG/mU1wVveyZoeg6GjG
 Bh1uvlM+Jcb0Sq5iSx2R/QImzYUXmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270088

Add sanity check in iris_vb2_stop_streaming. If inst->state is
already IRIS_INST_ERROR, we should skip the stream_off operation
because it would still send packets to the firmware.

In iris_kill_session, inst->state is set to IRIS_INST_ERROR and
session_close is executed, which will kfree(inst_hfi_gen2->packet).
If stop_streaming is called afterward, it will cause a crash.

Fixes: 11712ce70f8e5 ("media: iris: implement vb2 streaming ops")

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
Changes in v3:
- Add Fixes tag.
- Link to v2: https://lore.kernel.org/r/20251021-iris_add_sanity_check-v2-1-476b3107a8ef@oss.qualcomm.com

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


