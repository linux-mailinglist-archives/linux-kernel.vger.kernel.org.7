Return-Path: <linux-kernel+bounces-865950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B0BFE668
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1971A044E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DD304964;
	Wed, 22 Oct 2025 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJWQ2Lh5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF22FF660
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171660; cv=none; b=tNpytHsdm7Dw9J4b4VHa7pKboArrep5i2VzVqM+HbLAMyAHpQQqT7jPUREdp/Ea94YwwXedBZGKhAGVy0XMsiRRh3ItgCRYeeH7toN0vpDtoga+Mct2QOTs2AXwkxkEOwZcrFhVsSr5MrZw4l0ZRukgHdGfrUuWcZnwiRFWbhkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171660; c=relaxed/simple;
	bh=WqqdxK3KDsMpE/e1giw4h0keHjdtqH8gBSJ9aZrVbOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0v6X2g60sqigr/A+sbBbqG9RDK/kJdvT1YPqzP8yi67F9/ePvBWeChjkIaHEAsYSzjMEexDoz8Bs69O9+M628oS81XXiBE6PS1oq6OG6R8adh5JvQuQ7JgY6u/tGQA8Kfn0DbYZAMVXyB6taeeR3gvSm31uVZTQrc4FA/IbwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJWQ2Lh5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIeoia028831
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=i0mvZxV1MDsJnYmRbT9+6JtzjrypiHsWcbX
	y/fmUaPY=; b=oJWQ2Lh5VafWunD4Unv+UfZakS3vkrcf0DavngbD/HJYJlHDM66
	WLO7Who+AlUzOjhwImK5ZWis7KpLlukheN2BrBsbXVGHuhJcF0lpIsO9qZVirh4S
	9Ql6n8rCZ37mDKMZyx8pDTElM56Nb6+amyzZ67A65RFiZcmH+3d3+kA6Yqt22MxI
	En7hoHryEMqWqK+sL2POcJD5BNth1EBxDua0p5qPVwD+trQWJIODV5PgF6c0+8gf
	9w8bhm51xQUImYfMMGk1GFofOwmL0sHnrtZIZmQxzLEpJXGjmQNzv9eADhDtPiZ3
	JkQkdh6zcc9KbQaGYt55cYQXa8wsCb3+suw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wbvtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:20:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6cd0ee184aso24351a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761171657; x=1761776457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0mvZxV1MDsJnYmRbT9+6JtzjrypiHsWcbXy/fmUaPY=;
        b=icNnuTNm3t8ncrdFlAXgDAFx4HgIHKpEhLAxJU4syWSvCJhFOCNQHjhnp8xgZsPM1q
         TfSyq/aBqGFKRpzTXok113UVlPM8DKsGmF3XZKEG2mZyuXh3fyJBA1jFMNZDWNt0dMc1
         IHdDpP5AnfR0Ve0MyeYtLBsfHp/1k2l2TSRlTi0+e3k5+W2uaYqRr2Jb+3G6sNaUi6GF
         xD2N7hAXuVZ+uLXx6aQdScQ+wAeKeEmMc5HLMHXR5E71274tIKd0Mq1jFovmASrMFoZR
         Nc/aSwwa15Y8cuOftgEgA1eTV4GgXvJ0ZUVF2ZyzQWZndfbrPoSKDIzU+L3oaIddzfHe
         McNg==
X-Forwarded-Encrypted: i=1; AJvYcCXgpX9s7oCh9ohGfAFc1iOJuhKllCv6vnndrcq2Ozb2myFhl0ry4zHpEbfsuEG53PH5D9QOwv1WD09iUG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyokCMhpbEkagUXrcNrLhrMFOqGIgzNU9A8MEuEBI0QuTLB9rNk
	ZL5bZNRJgJkN11qB305Dp87IVPDa+ULn+O/l6d/BGUK03CsqOuGxgUKr9/oMvBRaWpPg82AcUzb
	zqRnyRlxxTxlYR+XPJUiKWL5Gz2xKxeB5HCYEmViKtWtutFi+ap80Lp/yGxj1OgqIZoHInOHB8O
	w=
X-Gm-Gg: ASbGncvhX43iJwm4r3duKggzkg1+/mYr8E3CTVBe30BDPWLfBGUF8cCTcF0DE4u2CU3
	ZXZ83wtyzBfIO0CrwYPveDf81b1tW+/Y0GrqLjWBxNNd279JYP/kNTQPylpcYGmkdAR3NhVTPPN
	wgJmAdZSlsPdC52Ambfn6mC+BFGUx3oNPl5OBchqK7OEZw5A+TBcP149uv/lFuTUnf0XjIlca1Y
	dBlBpOIje+VITJNXq2/F5Nwjun7SYx47sK+JBeGwBJGjtE2sU14xcYzWXrdtJlmwq7H2yePbwLD
	AeyxFhQi08TMOouh/5bszunkjkRRURfjz3KBshqQ0LkqZD0O2E0TRa5p1qS58NYJcKSi/sySNXP
	Xo92EjtFNGA==
X-Received: by 2002:a05:6a20:3945:b0:252:2bfe:b65a with SMTP id adf61e73a8af0-334a8523c3dmr29215685637.7.1761171656708;
        Wed, 22 Oct 2025 15:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHcTg7biN0R67q7mojPROACusX0lr4TEu2AEKXPQxVnJV9gXrUyzRzXnKDQhdID1RaUTlQhg==
X-Received: by 2002:a05:6a20:3945:b0:252:2bfe:b65a with SMTP id adf61e73a8af0-334a8523c3dmr29215654637.7.1761171656232;
        Wed, 22 Oct 2025 15:20:56 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e0a43asm115793a12.27.2025.10.22.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:20:55 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Valentine Burley <valentine.burley@collabora.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Reject MAP_NULL op if no PRR
Date: Wed, 22 Oct 2025 15:20:51 -0700
Message-ID: <20251022222051.10030-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wlNzKQXlXPbFLe8im4FmRdDngYLDewZK
X-Proofpoint-GUID: wlNzKQXlXPbFLe8im4FmRdDngYLDewZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX5FIzsHzy1RGE
 NyqiVBbO7QPzFdDsDsduz1R2JlKTS3ny8EuF+5JM5BNOgLHqYSxDcPGCxyQQr5Pz8rZZQ41dzwE
 Y9Okh2NNL+L/rrUCVhjBBUan5JAugprhyt0ezFD7LK4JufHGbHvOZIb+AsOFBYhR3UPJbj0avHw
 zO0wRBnY+9p6F1NIbKPOPigRbrBpcvIfXG5nc+iEHJiNhhY2eEH2PvdV9b3zUk/2ctpDonXmMLL
 0eEgbYVO9yaKLwt797JfnyoM8sk7IahMRP0cDb2izbXcCUM3SV2DWHZW6EktvMe9NPY6mL1M73d
 iDknwH1t6x3eCFT1OpnYr97I4vZG/4tRyg/zlxcW/H4j56j1bpmW+gQydxaqLRXj7vQqr9mCi1a
 E9r5egHbu5E2/eAPFOTOdo6ezzGISw==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f958c9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=AzObSZ8MGmcM1bWaoswA:9 a=x9snwWr2DeNwDh03kgHS:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

We need PRR support in order to implement MAP_NULL.  Userspace shouldn't
be trying to use this if it is unsupported.

Reported-by: Valentine Burley <valentine.burley@collabora.com>
Link: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37935#note_3153730
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  7 -------
 drivers/gpu/drm/msm/msm_gem_vma.c       |  6 ++++++
 drivers/gpu/drm/msm/msm_gpu.h           | 11 +++++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 19181b6fddfd..f93eee67240d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -365,13 +365,6 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	return 0;
 }
 
-static bool
-adreno_smmu_has_prr(struct msm_gpu *gpu)
-{
-	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(&gpu->pdev->dev);
-	return adreno_smmu && adreno_smmu->set_prr_addr;
-}
-
 int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len)
 {
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 90712586faac..96925a0f3965 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -964,6 +964,7 @@ static int
 lookup_op(struct msm_vm_bind_job *job, const struct drm_msm_vm_bind_op *op)
 {
 	struct drm_device *dev = job->vm->drm;
+	struct msm_drm_private *priv = dev->dev_private;
 	int i = job->nr_ops++;
 	int ret = 0;
 
@@ -1010,6 +1011,11 @@ lookup_op(struct msm_vm_bind_job *job, const struct drm_msm_vm_bind_op *op)
 		break;
 	}
 
+	if ((op->op == MSM_VM_BIND_OP_MAP_NULL) &&
+	    !adreno_smmu_has_prr(priv->gpu)) {
+		ret = UERR(EINVAL, dev, "PRR not supported\n");
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index a597f2bee30b..2894fc118485 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -299,6 +299,17 @@ static inline struct msm_gpu *dev_to_gpu(struct device *dev)
 	return container_of(adreno_smmu, struct msm_gpu, adreno_smmu);
 }
 
+static inline bool
+adreno_smmu_has_prr(struct msm_gpu *gpu)
+{
+	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(&gpu->pdev->dev);
+
+	if (!adreno_smmu)
+		return false;
+
+	return adreno_smmu && adreno_smmu->set_prr_addr;
+}
+
 /* It turns out that all targets use the same ringbuffer size */
 #define MSM_GPU_RINGBUFFER_SZ SZ_32K
 #define MSM_GPU_RINGBUFFER_BLKSIZE 32
-- 
2.51.0


