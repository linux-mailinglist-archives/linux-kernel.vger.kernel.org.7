Return-Path: <linux-kernel+bounces-793823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E99B3D8D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD8C176DA8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798B91FF7C8;
	Mon,  1 Sep 2025 05:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZiN7Cms"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6223E346
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704831; cv=none; b=JEwtjNVG27Zhdthlby1a1jxYmkbawBv1s8CR1dl75GK5IuHERQ6t3NKPnzQJtEKip5U+qjZUKyGATEXqa1ItmUdqbcA6cD6XY+t1R2TfxvB2x0BuSwLNttiHK/6dNL2OMsNSYXt+SdvuhNKVJQ4NqWbf/aD8MMZf3QDCTqdehvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704831; c=relaxed/simple;
	bh=CHpZnKI6qslmG/UOZhdyGWbwJA0vzEsxMasjuRgvRYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g12mPbserr+5cskDlu0KqdatfcHOQVE9iUOUpab8JMgYWdjsHKJ1Y/vfK9k2WovB+vcd7xzqtc8knbfCFRyImHwSFSV+KTM+IbWl2WRkjEf+z/2U6pwXUS8mzMrxscmaQkxMPgkpPX0IIeeJpC0u6+a1JO+Psqhh8XoZLSa5Ulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZiN7Cms; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VMFYUA012638
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 05:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6QnJVy3Cx4b
	AD5xl3mAoxpjrmiuwQjGEsSGBJTQmYE4=; b=CZiN7CmsX7PhiXDYfT40wqWPS2W
	SbWY0MVQy7Mg/xC5A6n5gvTn1Jwximf0Nyl9g0Cex9flHkrVc8U/gkJhiaLhccjt
	EQQ+KIVal5gnrPB6CCz7Ct+hDRAekoqtkm/mjQWvu4X9e821Ikvl/2AIOOggONbU
	iovEsW2CGZ3Eu8D0n28K+WYigW63ho9X2WLw933wvGPTmHXCHfzOTcycCnsIuGA/
	vvhftmRFgB2DE52ppuvqHOhC8JexTXzaCl7n6MNeNUWc7Rf9h3c3CD3OKwAI8ILC
	N1MPtIncjMPW6xpbips60hdFID2tetNABw0TZf+eKVMYYpnBFgc9yxh509g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjbd4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:33:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2490768ee5fso22704355ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756704828; x=1757309628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QnJVy3Cx4bAD5xl3mAoxpjrmiuwQjGEsSGBJTQmYE4=;
        b=Ks7hR2FVGQ7CG4l5PxFK+rvt+nd2V/mu159MIxMEHwP7amC9tBpCIYAHPt33LrD8zu
         89dbx4S1+oiE9kaZtLvL169rZ4Bb33ZGq0xDeZNAYvo8uXb8yB5/yUIdb0vVbeAa8dAn
         y89p2PIB/DENKJIQFErLqDKUb5ACF5DvJMxck57SJ1X0sjxY6M5H1DzvBa8ObOP16l1J
         2HgU4jIPhu7KlVIDuzB58hPFVIDpNKvYewOeVYs7tqE7X/mRQ0lT7nT8xA0zQW+T/z29
         fa1wKL5yjGl4qSWdHJCBe8zdjk7QaTCBZFTVuYNJFJCtPh4x88unl2VCjryUB5l7PcIc
         9AmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF7k4ouA+87sGu6kZkSvqeb9B7GJ/6B7rihJmAxBgBVVchV1eN2x6Cxwyj4VeRL1mA7oj3oc90OD2+zkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBC+HLqor1TNTaqkyQh+7Sm6c2ybPhblc35ZpuWgYF09rsifMm
	Aa0I2c3s202YYBK0zY0XGBYdYSVhCEOYqJeib6Mf+WyAEV1ytWMFWdbqDSVAtkf0GAGC2EnRr9c
	8AjFKgbFavqlCnYDOb/jFhfaNdaRkp675q4fqrQXdHhdifj9ODtZ4851F7FUyWDZnDo4=
X-Gm-Gg: ASbGncuAHMhXbewhiVAGvTXdmOt0sg4I8Q6VN9vD9F2GY5IenJsOYjrj5Y/S34LUYee
	5WBV/nrZsvrxE60upCN80Oh9f9I/meS2NEMcKSI4TWkLGTdNI6KA6FAXQ45PTZJC4/lh67YHTuZ
	Duz4Q2m9N+RR3G9hW5h5fbo6BwdWNrb79FqWR69RY+2tUJKMqBgRuwodXagfA/yUzSPNQBJOFhM
	sCw0jFNYslZqSvR36m39NKLG2bkZs+4ozXZLHA0v6XmIYPHVEkzVj5ydJR4dg2u8m7/ZDnU79uQ
	kQZU9ym1wyOlIhbtMRFPWr3AyZ5O5ikXEbFOi/ZsbNcO54wiCy509FmVmx2uvss1/HOBh7Fd
X-Received: by 2002:a17:903:2283:b0:246:c826:bd16 with SMTP id d9443c01a7336-249449045afmr97734085ad.23.1756704827702;
        Sun, 31 Aug 2025 22:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESGSlNcSMvh9kqymldfMZ4baXLjakGcjQQ0lY5ahmqYDQGtoEdo10KCkOeIjeZPCdZ3RAj/g==
X-Received: by 2002:a17:903:2283:b0:246:c826:bd16 with SMTP id d9443c01a7336-249449045afmr97733735ad.23.1756704827231;
        Sun, 31 Aug 2025 22:33:47 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906589986sm90575215ad.111.2025.08.31.22.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 22:33:46 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v1 2/3] misc: fastrpc: Update context ID mask for polling mode support
Date: Mon,  1 Sep 2025 11:03:35 +0530
Message-Id: <20250901053336.3939595-3-ekansh.gupta@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b5303d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eMrONWwZx6N8dQ6zNQwA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 6uzano7CMt0XBS5RhCgSYVZ2yfar4Uvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX+14php5moqKf
 sw9zzsT7es/hS/vziv4aZAIzkiBBMQYxZ8eE+WwHFEqF6E0fPr5M1IR4K6+G0PxKIfA3Qy0B0on
 TnUo1y5H0vdaoSGVp71aIsjfuyJinKyNKoX+9YnO2a+bhRuE/MxUiLsValvZU08vXqLo+aCWPm6
 sqCnRe0K0K7b7zTjBsnxx2VKjeF+wR6qDWdMRW0Re17fqhQ34sVm/h11CDH4sGshggl55/u77sn
 L8DzhUF+oHbExMujKVCU4iK1Ps1Yi73WoqJxFiXRQ3fsa+n23UYHp2j3jbFgScpNdBCegOttlqE
 03638iXjttb7hYqQQyyiFQfEbZknTX0wz3fOVbE5a1re/Jov5jBnjrtPpaa1kqzIclW90G5Q4Zp
 0E8q6WI7
X-Proofpoint-ORIG-GUID: 6uzano7CMt0XBS5RhCgSYVZ2yfar4Uvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Current fastrpc message context uses a 12-bit mask where the upper
8 bits are context ID from idr_alloc_cyclic and the lower 4 bits
represent PD type. This design works for normal fastrpc calls but
doesn't work as expected for polling mode. To enable polling mode
support from DSP(DSP writes to poll memory), DSP expects a 16-bit
context where the upper 8 bits are context ID, the lower 4 bits are
PD type and the 5th bit from the end denotes async mode(not yet
upstreamed). If this bit is set, DSP disables polling. With the
current design, odd context IDs set this bit, causing DSP to skip
poll memory updates. Update the context mask to ensure a hole
which won't get populated, ensuring polling mode works as expected.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 0991ac487192..57e118de6e4a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -37,7 +37,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
-#define FASTRPC_CTXID_MASK (0xFF0)
+#define FASTRPC_CTXID_MASK (0xFF00)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
@@ -487,7 +487,7 @@ static void fastrpc_context_free(struct kref *ref)
 		fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
+	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 8);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kfree(ctx->maps);
@@ -623,7 +623,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 		spin_unlock_irqrestore(&cctx->lock, flags);
 		goto err_idr;
 	}
-	ctx->ctxid = ret << 4;
+	ctx->ctxid = ret << 8;
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	kref_init(&ctx->refcount);
@@ -2449,7 +2449,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
-	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
+	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 8);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
-- 
2.34.1


