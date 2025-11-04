Return-Path: <linux-kernel+bounces-884230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA35C2FB03
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3213425270
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805330FC39;
	Tue,  4 Nov 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaiIhBg5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dn5Ryl0j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8C30F947
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241822; cv=none; b=NNplW1/em9NSh7UypxbATp9D4xoSwJ94PBsPQQvwuk59kDWH/OgNDwfsQ9ZVlnIAd8CoVoXGUX3eDOS9D99GVT7PJ07sLwdzcOLYeUy2nmiQTp5KS3xLpoZH3+4USYJnbWs/QID7D2w6Qdqz+BWflEVBU4uWcUUrdLgzVjYuhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241822; c=relaxed/simple;
	bh=WElPtVnlh+C1PSgldb6zWFPdJuCyxq0WGV9rXeZJ+rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yokg1orgY11Xx1z5SjdK49lks68iwXcDQSgjZyEmK9i5hK7/CEFkYn8ushpqnfvdK5kS22MNVFEE+wIc5gFpBrlT6DFyGoy1y4IDJIS5EGRJ5ALNLoLr1XPN7fdA3znDSJPHb7un8VyvkuCY7Aoal5vWdL42doeTJxbAah6ciwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iaiIhBg5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dn5Ryl0j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A429Eh8697093
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ttv0A/uYCNoEfTOIueJ0Teu2hpiw4Qf158DWOAthokg=; b=iaiIhBg5GBKSlZcT
	4Z18dxVW7K45Lyna7uXFKfri4v2siZLCohcIU8fLWwBaODqzvAp8SqqIBEf9uKHR
	dZpsbABzsHZbQhw9HZCsU1VIUVQCmgbE/HBn0StFsdmhKVLYov94UQwa5Vga568z
	E756XNk3O3FOGVm5gCl0CTU3QfD5a+Z8aP8gRMMnStbIuu0kD3OWlPM/2OVpC6Dj
	vzsfY3k2fwo/XTizVHE4TK+HY9gMY6htwFHSinQcFFvV9e7vdOFEo0P04nGeMHBb
	mm6O/dv+N7BLTG2shN0j4/+vjA7kLnYHWYcZBoJipkgl0fIzGJH/1mt9k3OYG98V
	0EJD7A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a78eqrsss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3418c17d21dso69559a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241819; x=1762846619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttv0A/uYCNoEfTOIueJ0Teu2hpiw4Qf158DWOAthokg=;
        b=dn5Ryl0jVFyjI1z0UCDLqpMbV3e2x41UlpcBqXdXW2DWuYjFrOkJiDPdrr8pXVWzXA
         Lmmz92EMCDbmi/IpaDA89GXx04TwS/60OSxe+Ze3z749KD62UIXwcSEMNNcbGRbha9Ms
         Y93MhkzW6xgAGW4jdgbzIEx26gVvNsnFrCzEjhzU1HD2MiQHm5Mb2ZE88qg/YeOlsbBq
         9GaQYf/dqPE2O/NH1nz+fx6GxyCerXHMWQWzBAf86kR99x1vYNBL/l+D6R/KSR72wOmY
         T3jxXGH2ULoa78aEuOx4NuJnu9/EiVOzoDmPxgbDz2fdZHY8PnhjCLfGQ9bfIRAYetkL
         garA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241819; x=1762846619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttv0A/uYCNoEfTOIueJ0Teu2hpiw4Qf158DWOAthokg=;
        b=hq2C8KexRx4zIO9QyiiZH5UFHj5iuVqGa8JLoApnofq1zNhsztCud1Iz5WREiKLLdH
         DmxgMyoCxe5sYRow92c5+EqQ1KuU9kZ6kTeWcduw25wZCmTINVYoK+dpTwiK3vyarAon
         2ZiOSz9OVZ0Xk9S67yEVmsmLtPwzvihvflO0h8N0g7U6JwLQZfNkde9//vcYzVr/nz6F
         +hoc0LmfgaQ/DpMr3mLeBJP5RNlJnighdgz82TXw8MCnVeGmedB25upfJgwu/QZuaZzL
         ROaApxnAN0IMfI4P39F1CJDA1xscHuIL3XL5rbZfTUGKeyulusm8cvN8q4aPy0001R6I
         Gj4w==
X-Forwarded-Encrypted: i=1; AJvYcCXc39VdSel6T/VeSb3Ws1YD0G/Z2heVUXevYHmfB4XzimJnV/9/hsJmRCpuGDyFrXaMlUlppmuHST+1l2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pfhEHcLocBpU5UE7OeQrH9oin3l+LKT5hXGpXMn9JjPVhnj+
	T85wSVSnU9mMgAZB3aly3L5GqPePTXmUYp8gfUIZxNsN9JjUlF4OyHzucLw5fdg71Ap1amiZP7b
	eCSs7f8EFbcnKghRtH2SMlqnMOniaDv6I4mODmY2DUtIYVA3+JCqcUMDvTH/7dy43omg=
X-Gm-Gg: ASbGncvE9XSO+gzz9MFD5+ilHwxrqQFTyxD4C3BSjS8o2zMp73PIIdh3SHiiz1VqYMe
	DUMybYjM25YIa67FqP60zvcNfn1NT0mWd3YTUUk5xoF49RQcLOHsaZiGqhqhceJqXfE7E+Xz7CY
	KYxSLJu7uNh5mGJ6qr+snBulczLRoZUKzuvaWhC1PO/THYwdv1VlBzkyCw+uEAMTF1eavXG9ty4
	pYYrP+h2v2XTVwQONC1E0STGE683dH74JeLOkcx98lbvUoyQhhxvlz+XqzLV7sP06lrghVqdo2E
	QyNKDwFdIYN2WCSIdx0O2VsO0J+HnQz2XjkpROTk7J7w21ewMb0n8AfxRaMi+2b7dkD+S2DxvoE
	67fxb/NhiCRHNSPgYU0VqWkDjeg==
X-Received: by 2002:a17:90b:2e4b:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-3418bdd5d5dmr304457a91.7.1762241818725;
        Mon, 03 Nov 2025 23:36:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzgRpt33g8LH+r/hUNLLbndg+nf7J0Iu8VGs80RcMH+Ykfd+QAkTkyhAw+/oQsik5bSPDVNg==
X-Received: by 2002:a17:90b:2e4b:b0:341:8bdd:5cf3 with SMTP id 98e67ed59e1d1-3418bdd5d5dmr304401a91.7.1762241817990;
        Mon, 03 Nov 2025 23:36:57 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:57 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:53 +0530
Subject: [PATCH v6 13/14] remoteproc: qcom: pas: Enable Secure PAS support
 with IOMMU managed by Linux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-13-7017b0adc24e@oss.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=5426;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=WElPtVnlh+C1PSgldb6zWFPdJuCyxq0WGV9rXeZJ+rw=;
 b=e6KOrcaoVF+JgTkvZ7OssMAQH1daA6mX+N7uC9YUPf6nUAxgDb+EvwuXEQys0RhH7EU4BKY5M
 eGewFwwExulDjoTa9scKsHp8ITiWWbmmzECSPyQfgZcb0aftxymeCaM
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfX1q2O0nYMPvbX
 SUGzm6j1yZW21KLikShjBdX6wKqADbQraEd0z2n1Ap7KtROYBeKsE/eL2yxVRciaAk14BCDW9Ha
 MGAqTsL9svLZCYE5Vjb9QcLirtHBotR/cQDZRuyEiQTTeNoLDxO4ArYnv8ZltNmGXUn88GcPLXt
 LKaROvJCuxHOhjgkv06idZedBWVuEFBeI54GZPda1Kr/7aksK7G295wpHuvjoFVblYUq934PbZ8
 MGZ7gS/O8DxHV4Zrlnf7KL9HQOkmXgsGhyLjXDuyPs248LY1jyi4uSEt+1U/6UD9r76u/KIqzLs
 vwbckGxY74Sf/OnufokwOtkwZsOz58aQroj0eIJ8T51vuW2RfF4ZtX5Fsd6RFRBRiQQl07CMUgF
 hpQrw8CLXA11mdrEmwDWrErDVxZZEw==
X-Authority-Analysis: v=2.4 cv=fofRpV4f c=1 sm=1 tr=0 ts=6909ad1b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=58pnfTnN0ARRJNaB1lkA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: RncjmhLEOM5ZtWQQu3qnrephJvQ8I9YB
X-Proofpoint-GUID: RncjmhLEOM5ZtWQQu3qnrephJvQ8I9YB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040061

Most Qualcomm platforms feature Gunyah hypervisor, which typically
handles IOMMU configuration. This includes mapping memory regions and
device memory resources for remote processors by intercepting
qcom_scm_pas_auth_and_reset() calls. These mappings are later removed
during teardown. Additionally, SHM bridge setup is required to enable
memory protection for both remoteproc metadata and its memory regions.
When the aforementioned hypervisor is absent, the operating system must
perform these configurations instead.

When Linux runs as the hypervisor (@ EL2) on a SoC, it will have its
own device tree overlay file that specifies the firmware stream ID now
managed by Linux for a particular remote processor. If the iommus
property is specified in the remoteproc device tree node, it indicates
that IOMMU configuration must be handled by Linux. In this case, the
has_iommu flag is set for the remote processor, which ensures that the
resource table, carveouts, and SHM bridge are properly configured before
memory is passed to TrustZone for authentication. Otherwise, the
has_iommu flag remains unset, which indicates default behavior.

Enables Secure PAS support for remote processors when IOMMU configuration
is managed by Linux.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 48 ++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index a8d3d2e9a70e..59196a13e3a1 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -256,6 +257,22 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static void qcom_pas_unmap_carveout(struct rproc *rproc, phys_addr_t mem_phys, size_t size)
+{
+	if (rproc->has_iommu)
+		iommu_unmap(rproc->domain, mem_phys, size);
+}
+
+static int qcom_pas_map_carveout(struct rproc *rproc, phys_addr_t mem_phys, size_t size)
+{
+	int ret = 0;
+
+	if (rproc->has_iommu)
+		ret = iommu_map(rproc->domain, mem_phys, mem_phys, size,
+				IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+	return ret;
+}
+
 static int qcom_pas_start(struct rproc *rproc)
 {
 	struct qcom_pas *pas = rproc->priv;
@@ -290,11 +307,15 @@ static int qcom_pas_start(struct rproc *rproc)
 	}
 
 	if (pas->dtb_pas_id) {
-		ret = qcom_scm_pas_auth_and_reset(pas->dtb_pas_id);
+		ret = qcom_pas_map_carveout(rproc, pas->dtb_mem_phys, pas->dtb_mem_size);
+		if (ret)
+			goto disable_px_supply;
+
+		ret = qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
 		if (ret) {
 			dev_err(pas->dev,
 				"failed to authenticate dtb image and release reset\n");
-			goto disable_px_supply;
+			goto unmap_dtb_carveout;
 		}
 	}
 
@@ -305,18 +326,22 @@ static int qcom_pas_start(struct rproc *rproc)
 
 	qcom_pil_info_store(pas->info_name, pas->mem_phys, pas->mem_size);
 
-	ret = qcom_scm_pas_auth_and_reset(pas->pas_id);
+	ret = qcom_pas_map_carveout(rproc, pas->mem_phys, pas->mem_size);
+	if (ret)
+		goto release_pas_metadata;
+
+	ret = qcom_scm_pas_prepare_and_auth_reset(pas->pas_ctx);
 	if (ret) {
 		dev_err(pas->dev,
 			"failed to authenticate image and release reset\n");
-		goto release_pas_metadata;
+		goto unmap_carveout;
 	}
 
 	ret = qcom_q6v5_wait_for_start(&pas->q6v5, msecs_to_jiffies(5000));
 	if (ret == -ETIMEDOUT) {
 		dev_err(pas->dev, "start timed out\n");
 		qcom_scm_pas_shutdown(pas->pas_id);
-		goto release_pas_metadata;
+		goto unmap_carveout;
 	}
 
 	qcom_scm_pas_metadata_release(pas->pas_ctx);
@@ -328,10 +353,16 @@ static int qcom_pas_start(struct rproc *rproc)
 
 	return 0;
 
+unmap_carveout:
+	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
 release_pas_metadata:
 	qcom_scm_pas_metadata_release(pas->pas_ctx);
 	if (pas->dtb_pas_id)
 		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
+
+unmap_dtb_carveout:
+	if (pas->dtb_pas_id)
+		qcom_pas_unmap_carveout(rproc, pas->dtb_mem_phys, pas->dtb_mem_size);
 disable_px_supply:
 	if (pas->px_supply)
 		regulator_disable(pas->px_supply);
@@ -387,8 +418,12 @@ static int qcom_pas_stop(struct rproc *rproc)
 		ret = qcom_scm_pas_shutdown(pas->dtb_pas_id);
 		if (ret)
 			dev_err(pas->dev, "failed to shutdown dtb: %d\n", ret);
+
+		qcom_pas_unmap_carveout(rproc, pas->dtb_mem_phys, pas->dtb_mem_size);
 	}
 
+	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
+
 	handover = qcom_q6v5_unprepare(&pas->q6v5);
 	if (handover)
 		qcom_pas_handover(&pas->q6v5);
@@ -758,6 +793,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	rproc->has_iommu = of_property_present(pdev->dev.of_node, "iommus");
 	rproc->auto_boot = desc->auto_boot;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
@@ -837,6 +873,8 @@ static int qcom_pas_probe(struct platform_device *pdev)
 		goto remove_ssr_sysmon;
 	}
 
+	pas->pas_ctx->has_iommu = rproc->has_iommu;
+	pas->dtb_pas_ctx->has_iommu = rproc->has_iommu;
 	ret = rproc_add(rproc);
 	if (ret)
 		goto remove_ssr_sysmon;

-- 
2.50.1


