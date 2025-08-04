Return-Path: <linux-kernel+bounces-755693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD56B1AA7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A48F3BBCC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E223E347;
	Mon,  4 Aug 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+YzSNwr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1823B638
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343805; cv=none; b=L9z507ZRhIJydN2v7dtm0mkM7RGVh1j0fIuPrtsNgz6jAgKw5e3M5wrUJx02mDdla+Vb2pI8J2+B746C9Za+EgM957MtLhsRuCB96NYCgtnH+9OXfwZ2QAOCtC5l3ILDTcQxW21dpVABJChZGvC6/tM/uQAca4Rr5EqhwZbB/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343805; c=relaxed/simple;
	bh=MHO/qp+UAkFUDV1KW+FRY1st72hVPxPQhofJO3khj6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw7e8eSDz67yBxQLk6eAhvRs0/XCiOPNyYBly2+5IqeEDLFn/k8rLPMiCpj//Dbz0Nm7GMEV/c2jGuSFpKm0Mdq7A1nJcAVPatlofxpyQglJ5h7hZAXsa2q00RsBxK2S+2Z47zHoeWfJvhCT3iJ6K6sppkIRwPpiug4yOguLNxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+YzSNwr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574GDD3O001390
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 21:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nwBcV4Oemt5
	w740AAje6mIColtrmwRWXKq31FSAZZI4=; b=J+YzSNwrVx5QkBv3++Hw3EluqR1
	qWxOSWwL9oqpkBTSOLSuhyMAVAiSqYlze1z29tUONI+9grkO9n9vVIy5wHLNaPBL
	cFx7xN3QSwN4nJDjBppse3DrOLfn0S8lKBpceSQwJI/9V0n3dd1PG56TgfT5KDe4
	7j1uHhvQB2VcvcYeBzo8KrlbxFvdJDUqcObF1s2WHWiOOUkDTvkcvTou4uHWx39R
	uuMpxbt4YId8LIROoJSwDiaEQDxrFnA0bKserOJ2WggiK3MHIau8jX2OYumKmPDN
	gOV8f30JLwQYwAov1Rl9rAYQZgkSDFErp1j4acnbHX56KAvOuzDdgg3jxEQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjpkws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 21:43:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fd8f85dd2so37793945ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754343803; x=1754948603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwBcV4Oemt5w740AAje6mIColtrmwRWXKq31FSAZZI4=;
        b=s6Hxtk7m9/o3mwYnhFqfep5JLF9mvVy+GL+k2PbxacSkF4xedQKiNthXDKoylIpPYT
         KyzUNAXoDylqxCBL9Qbd9ot17gJOrI2q6TY/l/lwkHTuX0MhBh7U/TRkLA1QVWCzksNz
         WiCQe2fHrPdvVjwdqmWTD1NgPJh+oL6sJUSU3I971/2xWDTO1jCva2VYohOUAyogbOqK
         0lYfbtRVmB8UYX4FS48SGLdnAELaeDibewUiHMJpxwPoYR5fLjRbNaQvUXFhgaOTC4ZC
         uYyugCPADcaApwy2XN4GHmFcUNd/t6EXnXx0CJGqypFKlcj1MuvybToUxmNHNKX8mCKI
         nhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYPo/lLSnqfPeQr7ad/ecL/SFGa/CAzZqOJTUh084u/LLR2lZlwerYZvutbjdS7rcgAtfNSuua370Mifo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIaCyy4adMAsbhTj7q+9dmKc+yrovh3IfAfNUfv+CxGjSZKIn
	SlbhK6DHVINlxV6lXOukJedFGE99pKgPVEeXosdlmEyY1hyRwvR9QpuIMwGmPlm2fTK4GuFZ6HD
	VBbhOJcvxrYev+4WZlgzXwpWZffYnJqcZhrbkjR9Pm4Xr5EUo1jiXyennaHi4VR4HbbY=
X-Gm-Gg: ASbGncv0QMK3cFF4oHvR6xUqoSjODXgMfr4wiu+GjE0BeCrH4UJ1bG0fHSql3Fxefvf
	bBU/Tv7jUY45yhyG14KUGYYKny917vdGT6vnDSWbrYYmYdwoBsOTLwL7MqMvQVmdiFasZ9LPR6m
	Xie1MRAYfcwNlVxga0F/KRkF+StdZZqJdTs66nJA5mmZ+kCEW0Mv7AmGBshhC+U3xvGdgqNTAFS
	scL7Hj93eha/W1P1nouLsiYdoB2ROB5N83KoGj2SbElSQ8rOBQ46H+AasIBUbYRzKgJv7r/5dBi
	8V/HFZYgqVD9UogYPhBMnEzNiqiS8hLsK67bE2lyOU0DaI93s7Q=
X-Received: by 2002:a17:902:e0d2:b0:240:49e8:1d3c with SMTP id d9443c01a7336-24246fef44cmr85653325ad.35.1754343802675;
        Mon, 04 Aug 2025 14:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6a9/8RPndKLMzz5ytDiVTCVnElsJWsamSeHzO2/TAvn6vk7dklmlUiRe8K/yjPhIcb3dkYg==
X-Received: by 2002:a17:902:e0d2:b0:240:49e8:1d3c with SMTP id d9443c01a7336-24246fef44cmr85653175ad.35.1754343802269;
        Mon, 04 Aug 2025 14:43:22 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5fbdsm116628865ad.27.2025.08.04.14.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:43:21 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND 2/2] drm/msm: Handle in-place remaps
Date: Mon,  4 Aug 2025 14:43:16 -0700
Message-ID: <20250804214317.658704-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804214317.658704-1-robin.clark@oss.qualcomm.com>
References: <20250804214317.658704-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=6891297b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=kCfvZJGldO2mi53t-5YA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: qj-KIEStNK0wEgJdjxRDDdtBPHvYXwUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEzMSBTYWx0ZWRfX9Bfz8Zi8lCiA
 lI+gqQuQXH/uc52rP0FwPzEH/JbbBbkV0BCqovgSm+hcnSElHsluaTL4XW+R4apydmPiAPX187O
 12cJs0RMgTLsBfwZEjUiFGQ1+q+uaPO2PUZgXclQYop0Dis8fyuqdC1q99KYrnZxxUPk/S9+1YA
 2luimD2w2+Wupw2mGa7b/aaTsIozz6v1N/UsUe65KZH9kBSeUwgdSv3XAC19Ejw23IdMkxLaEKr
 cvNx78PoHJkBrvFu240RiC0yRIcEwCJZrZHbjhnV2xquqBNfzEvg3V1d8p7RQ739xXjZ0Txa+Yy
 F/jKyNGMCbnFosvcWxY2IE+xBwPC2e1tgtPGt8dVAkW6ASRkRwajiSJyPpsMUTZdHxguc+l3nFx
 8hM4FkWBn1iM6zUqdo7gAlQsceef+6Wq6dO4tKhNKpIAda10g8q4aloitIarcMd4ILVf727n
X-Proofpoint-GUID: qj-KIEStNK0wEgJdjxRDDdtBPHvYXwUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_09,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040131

Handle the special case of a MAP op simply updating the va flags by
detecting the special case, and skip pgtable updates.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index dc54c693b28d..d4b1cfb3aa03 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -519,9 +519,10 @@ msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *arg)
 }
 
 static int
-msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
+msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *_arg)
 {
-	struct msm_vm_bind_job *job = ((struct op_arg *)arg)->job;
+	struct op_arg *arg = _arg;
+	struct msm_vm_bind_job *job = arg->job;
 	struct drm_gpuvm *vm = job->vm;
 	struct drm_gpuva *orig_vma = op->remap.unmap->va;
 	struct drm_gpuva *prev_vma = NULL, *next_vma = NULL;
@@ -529,6 +530,18 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 	bool mapped = to_msm_vma(orig_vma)->mapped;
 	unsigned flags;
 
+	/* Special case for in-place updates: */
+	if (op->remap.unmap->keep && arg->flags &&
+	    op->remap.next && !op->remap.prev &&
+	    (orig_vma->gem.obj == op->remap.next->gem.obj) &&
+	    (orig_vma->gem.offset == op->remap.next->gem.offset) &&
+	    (orig_vma->va.addr == op->remap.next->va.addr) &&
+	    (orig_vma->va.range == op->remap.next->va.range)) {
+		/* Only flags are changing, so update that in-place: */
+		unsigned orig_flags = orig_vma->flags & (DRM_GPUVA_USERBITS - 1);
+		orig_vma->flags |= orig_flags | arg->flags;
+	}
+
 	vm_dbg("orig_vma: %p:%p:%p: %016llx %016llx", vm, orig_vma,
 	       orig_vma->gem.obj, orig_vma->va.addr, orig_vma->va.range);
 
-- 
2.50.1


