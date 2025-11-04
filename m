Return-Path: <linux-kernel+bounces-884219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE8C2FA49
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7504E34CD41
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8D30AAC9;
	Tue,  4 Nov 2025 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wp/FNPGT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cI5j7OYb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF530B53A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241780; cv=none; b=Za3gXqnmHKy/9htjggOYijC/1GtwUbYEnWrHcH1z9GxOKEpmox6bLweXa8bKEeU8kaVBJqteaHIWBQODtFXxITUrUYQ4xyiHc4vsnvy/BwOOs15gKZCIn6PPZhpyirvHVW6HTYzJm1Z9FFqyV+rZj7Y2bJ4dJrgonKZZpsaD3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241780; c=relaxed/simple;
	bh=FmKGIfydpIBvZwHLGbtykFwsfVO47sNP+uEYs4V3KtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQ4rERBq5vYxWJaEZLao2DTWY5y1rqSi5zq/9fiD7knJSnwa9V+8icNGD2XR+usuvOtfWNV3Ztu494vTiAVuYl/uT1XRDg+rh41Jxa20E6AajqH1BL5ociY62/7X5eA0UZgyS7E2dmjP2bMI3D1VoEWPav2CbWHxxnQRQboai6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wp/FNPGT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cI5j7OYb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43DJQV3595028
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LqXRNN5WgLhy970VZ7+bHvuWbBP7UIoDXfqq5soCIW8=; b=Wp/FNPGTlUw0CQot
	majLNEPt2dZeq+WVsPM1J8lavB2b4ZupyDrhpja/jGg7y7ABn1wjnTgvhIcJJTGs
	0LpnPWSFd66YRrHiHZDVJZ+ZCYCq1vSNld6t/8/xjzZnXrzHAR0N8hul6h5GznSg
	04VLfGMSUr2r9KAHN5GGRIF1rfueCvnvb9Qdhuu7xjQuYdiX2y4dmk2I9q4Hbzat
	jujGD66rp5ipyAl3oY7ijCVH+M0RkeGu8RvFzgxTo8o29mP+pdVXSqD0c6rTrKmA
	9/BTGM1bGwX78bSPAJ7EBeLZGnGe/k2/mEOFyW61UHd+bh0xNQO/OBy6bOzNdI+Q
	qlg6hQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exj33t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:36:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da21394adso6324608a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762241777; x=1762846577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqXRNN5WgLhy970VZ7+bHvuWbBP7UIoDXfqq5soCIW8=;
        b=cI5j7OYb3eW6Cyt+HZCpTkne17fCCsiwMHG8fIUD58NXQWyvpAHf5biuum6F3rnTcX
         tIs40iKB80MbLGbtNkg2rg91WVwlINPWVPr+CiiGcJSNbhsz7fojVt8zcFtUWtNmdcSF
         nq+O9dT4CzxOCX+lxI2GHb0tf5+CtFv/yiHFLQONjpsw9yA/4gGIA4hxktBzBOlDD4Gm
         pRsBlE/OfzoN0ZY5eMS8yVQQhqOrA1+roKOtKaPJJvmljLL6uEkYYogLO/fIyZS/fUB5
         0+T+VralA6/5E+xumYmPSAhJsBpWN/TCCcd9zxUoAunaECbbNQGIehFYet5OBoDd+ahn
         PXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762241777; x=1762846577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqXRNN5WgLhy970VZ7+bHvuWbBP7UIoDXfqq5soCIW8=;
        b=FwG70mQVuzES9LPGDheKXsQ7K2wxQaECVCVpJYJRpFkYsfXjpxfp9fsltkVi9/DE4H
         S58A6WWqkGEqOxsJW0O9XoySsS0s9g/UeJuCbYUYq/xyB/igUxzERoi8E7b+cfEQFDu9
         tMNdXFFu7CoOX/oJiVF/393wdIiK7PfiF7pxNkiWC/zEE6J1Gft3HBii/yccUjCRVSFu
         c77xPbVfeFn/ibAP6feEW2T9PZGjqbekgVpWVVOiOHA7DQUlTG0uw/WoJ0lyBhDfvK4L
         KT5i9AKjTveQYEUPpqy6hLXL3SbiiEe/PbXBslv1PdTTCr7DPf2q6cm+s/u8WXJBHNx0
         sl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvkLVwR5ynY+z5MizaFhAR/A5RNKlahYy2E9osuEFdll8ublXsvis048crknJWY2iO3sYkk4RyMGEFwyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMabau2/WAiSMO4TlbR3SWWNspAjbzZnUsCwOvi3ANEpMVcNx
	MsD91in1eyQYWJ6kHvf2+AY730KNgQ1wekEWKXw+cVTvcNCgZUVMt13cEyJoQ6b3HMHbOqeftkX
	JHp3qDHnNqJYI2emzNGkwMty80aJfC0J6C8pzYZq0ggZNQrY0GIuQgd1Gx4KgPj4Cx+8=
X-Gm-Gg: ASbGnctORZwjxZKBes8xIt+IzaMvoBaFy6ayTM74MmTMrwMLbYer1QoO6OkVLQhvU++
	IVcOTsclgcsL3CAwtsSjj5crSVJVRMtnRS8HURTm5qSKm1VO/aWKgHHeRyqQc+CrlgLoeI/gYCO
	vU9CeCWB5pDWQluRMF8v1B4UXjnKY5Dw4VAki4FCPkv0XpeoXMp2wK496Ls9AbfZ3EmdK9xtix0
	pUYnRMPVn1wfE4DJLIBDVqFqWu+U10cxCgw7/URb1dAhA2UpvMdOU1SmKd2fA6l+EkkWaNnles5
	dAI7WArgI3POwo/Pi0nkH9APfzd5SUAlJa5FZJNyZu/XvF+t4SDVeY5KlB/PRyVUhfwJ80k9inr
	0q+lsVenzoH1hTn2q5ChSvtkO1Q==
X-Received: by 2002:a17:90b:2b44:b0:340:f05a:3ed3 with SMTP id 98e67ed59e1d1-340f05a4111mr11890995a91.17.1762241777215;
        Mon, 03 Nov 2025 23:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC0zzraVPxykKEoWBCgsKtSlR9peX7tZKI1998OGHVxAi0b3AuVr6yJ9IR0P1G35ZoVuRFiw==
X-Received: by 2002:a17:90b:2b44:b0:340:f05a:3ed3 with SMTP id 98e67ed59e1d1-340f05a4111mr11890952a91.17.1762241776608;
        Mon, 03 Nov 2025 23:36:16 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm3484367a91.19.2025.11.03.23.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:36:16 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 13:05:42 +0530
Subject: [PATCH v6 02/14] firmware: qcom_scm: Remove redundant piece of
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-kvm_rproc_v6-v6-2-7017b0adc24e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762241765; l=701;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=FmKGIfydpIBvZwHLGbtykFwsfVO47sNP+uEYs4V3KtI=;
 b=JaZMbmQPwIaJzEwbqi26osYgo8y3y8kiIBl0iE5kn5gZ4x4ye9GXg/gks3sL/Cs7FcDBR7nMs
 zO734FNyCQcAIWUJKEm+gpEv0OfPdPdaWUU5dlR2GEWi4HhpZmqmNwx
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=6909acf2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=QKOBHnd7J3GditHIzEoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: I5Ndy_4_M3VkxApXw4i2pOh4QYKPv2vU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MSBTYWx0ZWRfX7YBVPJmtxXgL
 Vw5SghVfkD1ITbv0vWZncunFPxfJytg334Xhln96CAQOuyRGZtqK4MiGYBHcOOVcRjqbuQ2hO1z
 4Lqt9AedHAS5uVm2+fb0BxrrdX2ofVBvghShEabL9dXsQkRADwbmXzqlKha4dWhNrKIs+7webJJ
 tEUawNOqcy7nL+KW/TnkKxJRGUHZyVdEb7QZR73zIg6fNuzhDkElHVM6dnj3PkBilFQ7l64MNXR
 iqvtafZ3p6DX1Ui3OsCDK2XQi1uqmxKcYGGn7aQ9svMO/rj0zv9FQ0Xe4sfzmRhZ9PyFECeIqFq
 jLU0FFIdbpQBMun1sCauTJpXJ64Qi1fJA1y+HpsAeZ81Dy7z0VFoy/wN8B0UFbUjg+j/OfO9fC9
 9SYFP4u2uz22dVsJ+y2TQygwaiE+Kw==
X-Proofpoint-ORIG-GUID: I5Ndy_4_M3VkxApXw4i2pOh4QYKPv2vU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040061

Remove some redundant piece of code to save some machine cycle.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e777b7cb9b12..26969bcd763c 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -650,8 +650,6 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
 	dma_free_coherent(__scm->dev, ctx->size, ctx->ptr, ctx->phys);
 
 	ctx->ptr = NULL;
-	ctx->phys = 0;
-	ctx->size = 0;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
 

-- 
2.50.1


