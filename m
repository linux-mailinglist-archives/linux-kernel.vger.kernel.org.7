Return-Path: <linux-kernel+bounces-884226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED45C2FAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F513B6DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5344430E842;
	Tue,  4 Nov 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lsEdF8u3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gWwRc3Rh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25AF30E0E4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241807; cv=none; b=FvFVF4iTDqRnmAsfiAaS3Yhp7Mvg9nOgsayuCT3viuEOaopXoH3NE38bUp1dlqMzGrlA5FWY4wejfrkjxrYfWN7pY8/SnJbVC3Ip91z1m1wJAR+KSQFkOi/uO2smbXHEiv13vxJEco5uREqeF6COUSGSVcZm76qz6OgVsWYGsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241807; c=relaxed/simple;
	bh=PbJrbcMV5OQXvUmba6W2EyJeHOnn3O6dM5VwlxqyAHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fly1+PnP7MRiBNd+O2zl5Fb9cfQxIZNQchACbSleqklxj5EqQuRtI81fRcqI0MmiaWi8LemA0nksV8A8ZBiRG6ldqSOVB8bk5X/5JIZ/4j3KGsneVdWeUh53DicvkAauK82OLmC76rbonJQ0h/fiOtOHVK8DbTFdhZ5+/92Sczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lsEdF8u3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gWwRc3Rh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43Brvx3845956
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kPbFoot/G28aWoO/MaPJmFPz/1E0upU6UFcMCVJwwY0=; b=lsEdF8u35QuGb7pg
	e9Ev5GMrk+jyYFBchcFJnFqUqd2O6jvK0Rb9mHKn3WvgoWd4827HTqBJhu4u/OoL
	IWPbRHb5KBaGWBCSAKRrsxy2vBIa53aKJbrlPxpohF+BRm5v3ZQIQ8/k1hrUNuLR
	mGc+ZSojtXqtIFkc/su8TOJ3GonLr8I1SrLUWUjqbq1gLxT8PVx1XXhViIRCQ4GR
	+RKUPi55CG4Q8Gw5ixbP+MP10SgyJbfFTYvDGmsrkGlEK6leHaGMJVUXMMx1QPHf
	gZ84nwc6NDG3kriExUWdnPgfcb5xqWCjWEiQWEKxMekD77/kM8tlWKNpO1tB5BTm
	OW+nvQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70f1j3aq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso13654269a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241804; x=1762846604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPbFoot/G28aWoO/MaPJmFPz/1E0upU6UFcMCVJwwY0=;
        b=gWwRc3RhwwgubIlnuSGj9TdDMDAypTgDMGwToV1EbOb3xot99LOs5IajyeMVW1stv1
         BhjNf6fNzcx0yPhe9Ai1uqyF0H2vAmH+eDIx3JluuYpb6dcFLK/5CKm74oDlTFUFa0Tb
         IMsm4xbWYsQbEj4+SKDki2bbUi5H7gJrGS14gUbdK5Z5nFbio2fxuUV1ppCxPZk52J2g
         xii9mIPjaRFkB+Trs7hXDYhcOxb44w2A8x33JbX2iCcRtVR/i0Y+ZBI/jPEK7N96gEno
         1/rRrVvKs5k6iJGw/yQw62oZuYaxu+OhYZXQLY/34XvoXliPNzMPz2byWEGdFQiaEcCm
         Yy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241804; x=1762846604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPbFoot/G28aWoO/MaPJmFPz/1E0upU6UFcMCVJwwY0=;
        b=minCtJNCZ9dRtwVh9VFMh3+ffhCTzTOW3pbqozBe1X5ypX0Owgc97wlj2yxg5E7DPx
         RiJdMx8jI1oD44SzpdYfZit3eP7B1lOW6zxCTBmX1rNOuNRf72oE0XPGeHbfpDqkrzbz
         xXwiY2JcvxL+JoaZiyWoYZNS42wHpUVqyqJrzy/ymTkUKuDFo+bjxntSqcEYlwEkWLG+
         y37pGqzuYcwpHf9HXuDDWZA+HnoYPhiI4Jt3AF2nEtxYfWw6Les3iTgGelHQHRGgNC3A
         njZDDJoUshBNYlIR9v0eMjqgDhvVrAwVegse1F7ROUA5paE0S8XNWe0V23k4GIJ3OtrA
         TRYg==
X-Forwarded-Encrypted: i=1; AJvYcCVdm7avnr7fxJ0yCraSV59kVyDK3qm4oIQ1Ob9pBJGO+MJBRFZDcM+kIjSWkE1hRsjsTGTjeYmYgDBnsEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMU16S/EvdJpjIlJRaBot2jZxW7sYpg8BCrV+woK14TduryI/t
	R08CpYI+1U+X/w0DlQ748wvhbdaCAEQTpG9/B5sRDR+ID7Tc7y7CeZRrqsallP0JZqsf9dYmV2M
	7jkwu4qHW5dPdlCZMCIM1dTBB0WMTnfHsR5cnp5hzlIZ9v2G0tvy1Ay8BZM5WSXxY+iY=
X-Gm-Gg: ASbGncvpCR+RfvFPf1eAaOH6JJtUAiLZlWuAEf0QadA/Uftq+PtqetHyGACB278GNjn
	qGhm8vDwxYNld8euhEVKMv781pFJjIUWW+7KZNPoSEetgMsxwy6SuQ9Zj67BNTzDcc+mulLDMKQ
	t/p6HhFaRE+G+fitFXo/DoUM+zQy/SZBIFvrQu8kR3T2cp1QK31g+EjbhLOtqDT22Y8+qZIJeIK
	1s7OTRYW1x/sMT9oyF6hz+2Iv+CFbGSbGfD5EFws4hbuYNDkLDZurnT4HbhboXTdotouUJ3glpi
	rcA5/e+Fu0o4et3K9X+lTJqt/Krd1ogrAierdnjG7V7Vd0cLPdGXaFZW5tBfPc8qotqCLI51vwt
	wOKHWtLkB4ub0xHTdoYCf6jl8eA==
X-Received: by 2002:a17:90b:2652:b0:340:e517:4e05 with SMTP id 98e67ed59e1d1-340e5174ec2mr10690603a91.12.1762241803696;
        Mon, 03 Nov 2025 23:36:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0poKGRTwX3X1vXN2ehIc/WfMWsh6tS+a4/ooPcVm665vDtBh4mGQCgYtkQuMf+iUIWBUX9Q==
X-Received: by 2002:a17:90b:2652:b0:340:e517:4e05 with SMTP id 98e67ed59e1d1-340e5174ec2mr10690554a91.12.1762241802996;
        Mon, 03 Nov 2025 23:36:42 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:42 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:49 +0530
Subject: [PATCH v6 09/14] firmware: qcom_scm: Simplify
 qcom_scm_pas_init_image()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-9-7017b0adc24e@oss.qualcomm.com>
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
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=2861;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=PbJrbcMV5OQXvUmba6W2EyJeHOnn3O6dM5VwlxqyAHE=;
 b=Mhc1hm2OcwjJzV543dwWxcWQUiOOgPbo6bLHA9sacoL8aRdZl3pwmri4h843tmt/2JVZ1ZPmU
 s7cbaw4dYQxBsqfRnM9g4oYpgJnm9oy7TTk9ljOiTkwzXWI4GJdCXHW
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=JLQ2csKb c=1 sm=1 tr=0 ts=6909ad0c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=4CDOrE8EU7KXtL0i2UkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfXxjf4oEaJhS5Q
 AUS6Rq8dglmBbyQbPQ8xVqBH/E2AJRL+WwUOy6H64ABi1TRzBBDLL8TcfLnBYMFd1nsE+dB7dTq
 ydz74VvVee+8itT1GZbV2UC0zo8rLzE3F8x03ZVDNzNELQ6IEiSMNsPaO28/ecU0LbVMGJDZOfw
 1SoMiSNxyzZByL6ViCIHKAM9WM9j9js+OJuY+GhhzWkYmU2g9TBt+837hX7NC6tm4RU6s3VpO5F
 r1d3etpvsbrvRznrepL/uw1pI9nlXdAZU+jvb2cLYK30jUfbaPUBuAficwwz7XlpZ/bH//AGCTw
 x24qfdNB5EHFv9/I/4rkM9h+UJDGn7E+hul3aSsk3XUm442FrULE7N516AADQ+LXTzjKvxUgTea
 7hzOPs1hNWAWI/Y/3pJ85qQb79+x7A==
X-Proofpoint-ORIG-GUID: Im7u69zEK9sKvgYdQBkF4TuTiX-3DGTi
X-Proofpoint-GUID: Im7u69zEK9sKvgYdQBkF4TuTiX-3DGTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040061

Simplify qcom_scm_pas_init_image() by making the memory allocation,
copy and free operations done in a separate function than the actual
SMC call.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 58 +++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 283e6cff550b..aabdef295492 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -594,6 +594,37 @@ void *devm_qcom_scm_pas_context_init(struct device *dev, u32 pas_id, phys_addr_t
 }
 EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
 
+static int __qcom_scm_pas_init_image(u32 pas_id, dma_addr_t mdata_phys, void *metadata,
+				     size_t size, struct qcom_scm_res *res)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_PIL,
+		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
+		.args[0] = pas_id,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+	int ret;
+
+	ret = qcom_scm_clk_enable();
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		goto disable_clk;
+
+	desc.args[1] = mdata_phys;
+
+	ret = qcom_scm_call(__scm->dev, &desc, res);
+	qcom_scm_bw_disable();
+
+disable_clk:
+	qcom_scm_clk_disable();
+
+	return ret;
+}
+
 /**
  * qcom_scm_pas_init_image() - Initialize peripheral authentication service
  *			       state machine for a given peripheral, using the
@@ -615,17 +646,10 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 			    struct qcom_scm_pas_context *ctx)
 {
 	struct qcom_scm_pas_metadata *mdt_ctx;
+	struct qcom_scm_res res;
 	dma_addr_t mdata_phys;
 	void *mdata_buf;
 	int ret;
-	struct qcom_scm_desc desc = {
-		.svc = QCOM_SCM_SVC_PIL,
-		.cmd = QCOM_SCM_PIL_PAS_INIT_IMAGE,
-		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW),
-		.args[0] = pas_id,
-		.owner = ARM_SMCCC_OWNER_SIP,
-	};
-	struct qcom_scm_res res;
 
 	/*
 	 * During the scm call memory protection will be enabled for the meta
@@ -646,23 +670,7 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 
 	memcpy(mdata_buf, metadata, size);
 
-	ret = qcom_scm_clk_enable();
-	if (ret)
-		goto out;
-
-	ret = qcom_scm_bw_enable();
-	if (ret)
-		goto disable_clk;
-
-	desc.args[1] = mdata_phys;
-
-	ret = qcom_scm_call(__scm->dev, &desc, &res);
-	qcom_scm_bw_disable();
-
-disable_clk:
-	qcom_scm_clk_disable();
-
-out:
+	ret = __qcom_scm_pas_init_image(pas_id, mdata_phys, mdata_buf, size, &res);
 	if (ret < 0 || !ctx) {
 		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
 	} else if (ctx) {

-- 
2.50.1


