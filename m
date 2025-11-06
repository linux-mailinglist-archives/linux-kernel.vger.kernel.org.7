Return-Path: <linux-kernel+bounces-887811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A2C39242
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC59B189F148
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE72D8773;
	Thu,  6 Nov 2025 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AI1ZSuwy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cIpy55ph"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B54E2D876B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405733; cv=none; b=cJwYVdKzXzZM614L5XWaX+Qk+bD54xiGy5P3jxNSph/kEFz8rgR8Z1NK+us/UHCdka50OgkHB773vpP52ezVbcVizFRatAEUQ0Q3FyvwqSBLQsShcKd8qSuuPhjZppFAQbmOPQ4C6wZa7t9dE3QzmOQAlo+m6x4kA+u8BmWFsoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405733; c=relaxed/simple;
	bh=Y8+KA6Hq/h9cqVjom36SFqyO02HmM6mSYiJPIDmdd4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nN4pcRKBGHd1pTSvO7APrFVn6ufADD2GxJfSxmRZC42hQc8Y/SCocGXWyra+xrEe01PCjZGwRH6ox0wtiztjaG+3v78au/bbL/d+z6vKgX0JKuekJxr6PRn21xrx5yBENV/X3ZAR6Tcd//Jtn9uiRqMgmYrBukZPokB7ChTXx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AI1ZSuwy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cIpy55ph; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A655ZR63217421
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 05:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ujaoRN0R9JC
	yofw9Ts/yVME10jsyMAe6gDSjtEx7EKQ=; b=AI1ZSuwyCsB/CYf8Z9MoEWTkTlh
	J6zFBGk1mODC6ILBPsc7Rr5w/h9IWEABoIEv3a/XcDA71ou8b4Ovph6h6ieWY7S0
	lXqePUkeTUzuvR6TKHT2L2qTdSnweKMesqnk+aY7qyowsnJzQ1yCL8O7IpXYDMs/
	AJf27D9wQArXIHrnZl8Hpa0RwWTXyuJjukzRGIGPjBJlbW9YsXCmzGcw07/WRX2i
	19EtDc1MuupA/nzo+KN6amf1R3eA4jQaivK33cwfxBuhjL8noHsMa4GI4R803UW4
	um8B54x8WCrANTqhvmt6ZmKkstvPjaWRB/ZUXDtV9UoaCm/iI5fjpVx32pA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8n7pg0a3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:08:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7af85c822c7so586233b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762405730; x=1763010530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujaoRN0R9JCyofw9Ts/yVME10jsyMAe6gDSjtEx7EKQ=;
        b=cIpy55phJL2lyorlOk4raviiCPLN9SYo7iNP8RhAfWPbTlv96ujDVwX/fr3jXYlUbj
         vphQEvfhiiGkMXBf4P9liuzXmMXlbNCRo9TURsxGVpjd0zkia1Wfckl6/B6kyutEGWig
         C0CfgPbWA09pFEYCxC+8pFOWTKNQibR0HPAH9dNLk4tPBpe5Xue5SwC718LxQmjsu5+h
         1ujT96OGmmQJxrDJeKb47jf7oLPmya5e5/m6lKEuX0b+tlu98oIZ4XgjuQD4mK0OY7nt
         eYDDDOYGhrEqKDJZpLa45Ny/Ls9xA/1MX5J8RiNr2Tsb74Bpd480X/+kCoLCcWz/c5rJ
         fYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762405730; x=1763010530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujaoRN0R9JCyofw9Ts/yVME10jsyMAe6gDSjtEx7EKQ=;
        b=JPtWyJO8HC39ZD9TvCQEKa1vAZ7HbbAt8QbRbZdEP4Zc5gAMXXavaaqUwqKuNjbQlR
         +c+vlSd9hBWV+v8U0yfizJVHNn4fgMYZsk4SJoTwebaoCezj1kADdKYp/FL94HF5d/Cw
         XlvUYWcIMJAQXB6jZ9NEduuWOM6HFoywhhnVwr4dz1ymYrt+8xUOSoEc0I0tDPyVlqwc
         PPDgC5oqGnhs3IXyEfNXqayluvabYuV2QZIrCVGmhYGyGgt46wYBYFQdAVTjCnWjLxbj
         IG8AaWOChHZrRLwGIs9rt7XkHtRLqLd4+Ggsg9L34sCYlkVhmMfRK+PefsaweCw517oB
         1J9A==
X-Forwarded-Encrypted: i=1; AJvYcCUM2XxPFmRSp30BN/Fa5LW5nEz/KWR2weGaJJMg9kqb4+nJVohrOlsAqfxd3YMNaQXMNrrj0/cLHpMkzDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1vzjo2KjY0VP7TwQTu9sVwbyk45vOAiICk+LMhmdvUo9E/sOC
	L8yBMo9RBc7NQNC5bwb/1TxQEUftiZOv8HEZaWC9Qj3We4H+W7QtwcHdTBzfDUOJ3MA/M2SvzUl
	MjXYL3/j6t2LG4jCQ+bBx4g+lO8MAH3HCLlOpMf7/Vk8iWY9pW9+QHA+bVa3uN4DLUTs=
X-Gm-Gg: ASbGncuWgsB4YR5/0D9JH6w2ZrJ6kM3kgrZUp9x0rdeT3Ya8oPF9dfVhM2KM60F0gWa
	j8Awieukd48E8pQaNRvlzjv8JX7f6u9hhUWH0WR5jtPQPnJsiDZlbsFaSg3jE+PqklQk+xHXEml
	l9cHUpWPOrRiDle/hv+U3Rq7bvdbcYUQjiG0qfoc9C7iqPJYR81538+9e762bjtN91iyHM8+39W
	cRI4zJJ7Z3WPhxCwcFzMoTUAsBK9daoixN1d1+G5Ru2klhVJzTfCTkG7npAVaabCTbcyr2ABAmq
	AjAE0OJL+oLs9+yBvGze4qP8ZIX/bF36g0gEhT0c0yGxfCOURZfsU7cV1Uhky7znVrQgJw34vrD
	WwGw3TSOy8V5C4TRxDNqT1jkBi/UKHmw=
X-Received: by 2002:a05:6a00:2d22:b0:77f:2f7c:b709 with SMTP id d2e1a72fcca58-7ae1cc5f5e8mr7330935b3a.5.1762405730150;
        Wed, 05 Nov 2025 21:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcvDhrmBVPROt+wlrWa8IJlto8+biiFvtqHVaANPX8XnmNXEXYFFqELu1OvtY/577w190x3g==
X-Received: by 2002:a05:6a00:2d22:b0:77f:2f7c:b709 with SMTP id d2e1a72fcca58-7ae1cc5f5e8mr7330892b3a.5.1762405729612;
        Wed, 05 Nov 2025 21:08:49 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7fd5238csm1185862b3a.17.2025.11.05.21.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 21:08:49 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v2 2/3] misc: fastrpc: Update context ID mask for polling mode support
Date: Thu,  6 Nov 2025 10:38:38 +0530
Message-Id: <20251106050839.3091707-3-ekansh.gupta@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ct97GGwYZUP-MnYPvdaUdeq822m-K88s
X-Proofpoint-GUID: ct97GGwYZUP-MnYPvdaUdeq822m-K88s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAzOCBTYWx0ZWRfX3CXYbZnxzNsT
 b5fFAJodUt/zrjPXncZ4poga7pw6Q6yc+5ed4wm42l6hE48h0egqR0AorvJP+Af1qBeTI54RozP
 21HsIejiWYuQAQTuScIzWIfxlRqwhoiLM76+VWLLSgCFvjr3o1ivYeIyuj55nPK48cWnhbBxsbg
 G273um9ULbPWfasb5vNlJe+lIkqHY9AFHvSZ/7QIiKNZMkHHp/Jdf/+aoYR62nwqdLUnFzZgmHZ
 N2WO31XVcU92OWtlwgxIMgCb/vJuPyofQa3waTQf6RtazoVnCK4uGBc4mkftPytqfDqfCy0x/h3
 WU/fBnVhsZP1ujigLCpkhn/gVjTRBBle108QdR2JChu5q5nNeITLKJyJccOKRqF6+5VSCNWc0jL
 qHsTnpn9Eljbhlc1gFnvk6Z0pu4yjg==
X-Authority-Analysis: v=2.4 cv=ErnfbCcA c=1 sm=1 tr=0 ts=690c2d62 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=eMrONWwZx6N8dQ6zNQwA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060038

Current FastRPC message context uses a 12-bit mask where the upper
8 bits are context ID from idr_alloc_cyclic and the lower 4 bits
represent PD type. This design works for normal FastRPC calls but
doesn't work as expected for polling mode. To enable polling mode
support from DSP(DSP writes to poll memory), DSP expects a 16-bit
context where the upper 8 bits are context ID, the lower 4 bits are
PD type and the 5th bit from the end denotes async mode(not yet
upstreamed). If this bit is set, DSP disables polling. With the
current design, odd context IDs set this bit, causing DSP to skip
poll memory updates. Update the context mask to ensure a hole
which won't get populated, ensuring polling mode works as expected.
This is not a bug and the change is added to support polling mode.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 679cd8997a00..ccba3b6dfdfa 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -37,7 +37,8 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
-#define FASTRPC_CTXID_MASK (0xFF0)
+#define FASTRPC_CTXID_MASK (0xFF00)
+#define FASTRPC_CTXID_POS (8)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
@@ -489,7 +490,7 @@ static void fastrpc_context_free(struct kref *ref)
 		fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
+	idr_remove(&cctx->ctx_idr, ctx->ctxid >> FASTRPC_CTXID_POS);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kfree(ctx->maps);
@@ -625,7 +626,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 		spin_unlock_irqrestore(&cctx->lock, flags);
 		goto err_idr;
 	}
-	ctx->ctxid = ret << 4;
+	ctx->ctxid = ret << FASTRPC_CTXID_POS;
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kref_init(&ctx->refcount);
@@ -2451,7 +2452,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
+	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> FASTRPC_CTXID_POS);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
-- 
2.34.1


