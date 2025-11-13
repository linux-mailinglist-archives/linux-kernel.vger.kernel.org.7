Return-Path: <linux-kernel+bounces-898765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A26ADC55F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E963D34E79E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FF323411;
	Thu, 13 Nov 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b19Jqa1R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UtM12bCB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81D322C97
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016087; cv=none; b=lOfKyq5E8O1tNO2Dnjt79xcEQshAjSThXpqGm4Fwmwf48bsZ/ovhSijJAux+lyV0Ex5N2HAMgfPkQLNshXiNJei8nQMbR/TS06Qv5F8mJFxfd4giqi6nCRI/R5bulEM7EIMyaHV4gqVHYGVmWleKhakl4dHyeHb8VMm/BaLuCXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016087; c=relaxed/simple;
	bh=Y8+KA6Hq/h9cqVjom36SFqyO02HmM6mSYiJPIDmdd4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFyHpGX5qCVFlLg4jxTOLXIzIgmNLC7G1M412g+sO+4GEaA3PCVAKeCEF5FN2R3lUys6vGAAPAOFy6X5OpKnRQRnvv4vwWACgiqWGLioFXsLdHm4r9wwZUqXSuwsNkOgbbj0QDy47hNkvoxj7nwXvGHBQRRPOi6thxfniql6cq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b19Jqa1R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UtM12bCB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11Css2909642
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ujaoRN0R9JC
	yofw9Ts/yVME10jsyMAe6gDSjtEx7EKQ=; b=b19Jqa1RFOd3yfv6XD5V16zf4bs
	uapARixP4ZzMXe/yNqIXrRPgUJgfqz7l+HNWyC08kT5Ogx7SCOY70q9/rSF8kyT8
	IDFR5HWFkB7af8EMfzDEpwFqx2kWp7zlZwHmQNKxTH0SQsKqJiL6eZZCnnd2ONQH
	3/p5X/Ab4Zq1LrQIUp9WiT8TzinZgQLv4I/ViBBhPQjn1UBSp9t5eleAM0LWDqeB
	yu2mlGqF7z819Ff5lEaONP7APGQVd8RRWkuLLAQcQ3OhFnUjiwvtETCHoYNzcV25
	a2EtkFnptBUd8cWnP3cCM3zPrW1QplADmHy1R88uy5CGvOzL6L1I4cLSh5A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acygm9xm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:41:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471737e673so767010a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763016083; x=1763620883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujaoRN0R9JCyofw9Ts/yVME10jsyMAe6gDSjtEx7EKQ=;
        b=UtM12bCBOrJ2vIMdf0qgHxws110l9NURALDdK5eP2h9hGzEap0WGN9RxQb2IBCfbXm
         +fD+JqRANlInGwoLPbyNqOFjTSm/DbLefmBPlJBsTFyzhAb9Y2w0TKbSEuvObRvaN6c+
         +P0+EjA4Q+jyEcf1VeBxbfZjKVZPTsFYl6td6+8Et59QcHLGpvZBgAz9wheBLsCYXuZT
         RECa3i1UhZ5qiG6txBAt564fGvl0UhujppMRpSv89cvd/MKg3R2OrE9nim00imX4GB+0
         AY/1wt9WfxYnTvYxE6U9zvh37fnlwIyRPDOaetCNGP2nfTL81M/MMeu9zf8CqVj3SKuR
         dTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763016083; x=1763620883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujaoRN0R9JCyofw9Ts/yVME10jsyMAe6gDSjtEx7EKQ=;
        b=bWWDKh5KVKD3/lKf9ySswoz+DsKv0AbZqpYQzmLOqDaAR2K3cBHDvNzcU5VDLNgFnx
         9YsdnYqBJZWALnQuZQUlZNDox2nkg08aEoZzYPS10UZXdKUZJINrRPhEbGUv62nSuuKb
         lJrSZhbrpuajJq0PN+WqKTiCciDmnkOKEaontIXvt8NzB0TnxloVeYTCu8QShKCwD73g
         4YU/SYiiIUjSZz+Eg71DORnQfuR75phm+I4bqKjyeTWkuY/sitnqMQP65G2XsfeAAIGL
         gwbJDOduRCL3Ilo/V0ed7d4o2Ws85YkLaHPQ5TyfQGPazq5eznvAbyjSc7YvyJIZVyen
         G5EA==
X-Forwarded-Encrypted: i=1; AJvYcCUD3KSa3Tk9a6ktjQKIu4QkggSa0VkfhBE5T278CylF5mpVXknJ7GZ4h/RPsikbwnu6CUfgH6+0VJbXxgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynyWnHipEIr/SrtiYEKUUVfiHP1owE1VAR0wG+AnEn+fAKM7y5
	g8L5qsSDb17Tc+9kOMqx01Dxof6kM7ADz+YCp4m3GRZeHJuDu/2BSYXQjE1GPE0s60aKG32NHam
	iWy25x2VHUEUYkTVnGpK2alDAD5b+Sdhwsc/+pQ7umeErh7zKLsWeAArdDFr2HOuodhw=
X-Gm-Gg: ASbGnctZeIgaQAImcDajAUImCvI8/pSbqJZkIYwFtu+1ZV0I29ayBdSN4cIQX1DkAM7
	VOhjJuAy1Fd+ytfCCswHL+8+BH5Y1/YLVAi5f0WET1SsxxKXFKHO6PGcMfGZGWIXVZ3I9Mwmvrd
	DILoO6y7qwnmQpRRMPyl/NvtirjTGS3aCkAl6pne6s92lx1424q3NyTgmVIsM7FlGxOITO60T2P
	gfW4zgs1yuC73IYJeI46URz+jtFQEkJE/XrAYKJpNZhRMbVkDznIA4/46MbFRi9Jwyeb62ROJtT
	u2rrINz2sQB1rtM+1TbWfnYTKJjTBK+vEXbUbyh2d8vSj1uPE59Z2D1FE1WBoC5uSclwZ+Cbzku
	i0p7rxa4BrM/W5ZWETtXBsJo6S3Rxsd8=
X-Received: by 2002:a05:6a20:3943:b0:342:a7cd:9211 with SMTP id adf61e73a8af0-3590b21850dmr8009708637.34.1763016082769;
        Wed, 12 Nov 2025 22:41:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF1omhOWcFP3UCNbVCU4ks3UAajf4M3m+Zx0IeTs1GLXY9LvW5xB6kXqRPzKlUs8Flbvshwg==
X-Received: by 2002:a05:6a20:3943:b0:342:a7cd:9211 with SMTP id adf61e73a8af0-3590b21850dmr8009670637.34.1763016082300;
        Wed, 12 Nov 2025 22:41:22 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db25bfbsm1138419a12.1.2025.11.12.22.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:41:21 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v3 2/3] misc: fastrpc: Update context ID mask for polling mode support
Date: Thu, 13 Nov 2025 12:11:10 +0530
Message-Id: <20251113064111.2426325-3-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113064111.2426325-1-ekansh.gupta@oss.qualcomm.com>
References: <20251113064111.2426325-1-ekansh.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5shCb5a4Ilifr0-mBoHqw-sQD783zW0U
X-Authority-Analysis: v=2.4 cv=E/fAZKdl c=1 sm=1 tr=0 ts=69157d94 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=eMrONWwZx6N8dQ6zNQwA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 5shCb5a4Ilifr0-mBoHqw-sQD783zW0U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA0NSBTYWx0ZWRfX6p+ldmROdYjA
 +/2MbPk8WEbzXHYD59z263QFNkKH73pgt9zP+04dUGpfgRl5Fp96u1s1Zd7P/5b2Bkm2nC0Onz8
 KpgS7haKfepwPhjIw4aiBk1HRHq7DrxoUT2wTSIiWjosIZGiZ2VrdSRY9hsn2tIFfbMJoAEpprM
 R3dg0z3nZXg3hJexBV3nEtinYdCz8K0JZwxmVyruQ6ibgUjHeNoBtgItcYkW7kv67GCVwggFGB7
 na7g/YDnMDVhDjKkZ0UbN+Yq8//WMWKCV21Nr8PNpTqv7AzeQ+Ztnt0F1zMpVtRbxAMQT33TTjM
 KLapziD5SBsGmtDmKhs4Tr+V2pJOayJN/oiBYDLNXTBMbmNDIJdI+rlPBq4eko1nYeSvVjFPQ//
 NZsgK2weR6c99niTCV+7PGtKx2+CDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130045

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


