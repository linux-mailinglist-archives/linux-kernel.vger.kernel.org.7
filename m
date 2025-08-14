Return-Path: <linux-kernel+bounces-768111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1BEB25D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41B77A4F52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CDB26E703;
	Thu, 14 Aug 2025 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XeYe3BPg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325026C3BF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156156; cv=none; b=EmUPAVoS0ceCtrYGHhoeHrluGyyhRs9f7JQ/bZM20pnx904f160XOoB4rPAyb9QPQ+4ohwzjnQtrfL63VErlD1qgLShJW/BOzvnn2JFapBhFVo1J9udP2Pw+BMuD4xwMPyHPDClklTEb9wYrWSkCPX+aAs89kon2z70NleFlGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156156; c=relaxed/simple;
	bh=TtT0Nf2zRlo5tUth7b9XaXrqg4IP4hWtUayIq6Mc8HI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO5gsYTnKmB468/I9hfRZQkfOfurld3qerXicM+jf+/H2tKfMtkiNA2VRrJeeDayvdw51muTC5GLIjiSroK8v04uWFak6oaQjWZfCZjlfEqzvnZ6GPTRZrzLfLdRMBKxaisQ2qlqSbVNwYBQXCKFOQqCK2+voRj1zLzGdEdgC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XeYe3BPg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMLpoX002797
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iala9fw+bbdaJ5tA57DCC4sJNCfBziddLdxHkkyCCYQ=; b=XeYe3BPgqDtWOMj0
	4buMmIgjIar6qVZulmzVVU0bEWBQ05mkBL4EqOEWGinzSGoA4RJVlSbkMhRCc+vq
	lGPliE3mPeVz2r7dp3dtPzaiiVdk9NlWhH4X1vp/saJDo//bTZ/QngruIc3YGdgt
	opu00X318gfdsEeyeOKyWNvuYBQXunrplHKdBPQYd6MU0vIhaLHcNIHgRrMdW8vN
	RL6EiyB4XfMtoLEXsrLq5Vmx9lsNSeYiJ24LcsBTShYfuJ5hBmHk+hXsoujhX8QX
	kWOdjbQ60rolw+SS8zzTqBckpMrDpp3fqCOEANk1l0VczIPxV1fLZqr3YhYQOCwu
	cBWjag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv6rsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c5ac7aso15385521cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156153; x=1755760953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iala9fw+bbdaJ5tA57DCC4sJNCfBziddLdxHkkyCCYQ=;
        b=YPrmiRiV/p5/aFSOraU1nT99p3Xae3uYOMEwL3oSowZnpetJeguMCHS5nOU4czPisI
         IOeDTveEHGiTx5tAuTomD+gOXyRTG8Xl+WlOjPzOYy9hVZMolMli/X2yA7d6Lsak7Xha
         BPop41SQjN37TqzWqdiaMiNev8n9zaEFm+GDp6COuKG3gInZz3j3N1G3HhZzH22awI7+
         +q+/urlEU2uYSI2RfZea5LV1iQ6tNXshguMXi0fLMCn/ds0kiqb/gy+TBqYxp0yNYMqz
         HDnPovpH+mtzAwTJEYN8ha9tvMqwTBo/UNOx5deUFTUf598FPITl4uqj1acojaViVbaW
         dUpg==
X-Forwarded-Encrypted: i=1; AJvYcCUa/JEKF4ECrCR91JIlKHbp9nDiDX9D53FUw47KMdzcPWcQU9MtL+D/hbw58MZdGoPmY/fKBAEey9y9FR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIk+hWKlL6xYzKrFc135SBDL0etnbqThM5L1ATI6MMteoV/aI0
	nxauhT/Z7mwIxmi0SVM1JR9t/fp8BnGdgJvD8m9BlsWGOAoqUL5yDbUZwSP31XpDPbCZ98vH89z
	EEjCg55OLodrBzq5jFOxNdA2F7XsLSQ/xFnNZG9/9LphUGPNH1XrXhtZmYx7JEMZYtZM=
X-Gm-Gg: ASbGncsxU/amv2YLroM3lJOz/CRPKPAGQ3OKilBRc3dWruS5J3BanqieBnfE/KT6wi5
	b80c/ZAbewzgEdtDCUdv+EyKVGaVLmmNRIczq0cwEw58fklSbIz49LYV2RomXG4GEH9a8X813ir
	ourgP/1TPlfMaWUmugE0o1Is4C3nSInVSwxRKhxYGgy8BL/eraYVUXbF94LC7F/hc/BkgZojU4f
	0ri8xIdn69xWeeL7DmZGUIZCseHJjUae2u85AAr/f7fU2FTj6m2ifVMauXbvC5uwbselmnAT3MD
	Od4OdFfAgZlG8rZUJLsXz7FSEvasbqJ6tUmh+uwnX3YaCKzO6mO8tjqtGLBTh94lSeq4wgbhxCp
	TmYyWYtUdjGz/P/Oo3KVt02ldtXhmwXPH85agmX69Uu7uvcbBw1IB
X-Received: by 2002:a05:622a:1f9b:b0:4b0:743a:b4f0 with SMTP id d75a77b69052e-4b10c594815mr16459201cf.41.1755156152657;
        Thu, 14 Aug 2025 00:22:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1sl7ib4c5kKM6P/fyARJ7qBtEqOl5rM55p7yXhUuPoBHjBKCXG45d3uCaonUJQ6Db5KP+Hg==
X-Received: by 2002:a05:622a:1f9b:b0:4b0:743a:b4f0 with SMTP id d75a77b69052e-4b10c594815mr16459021cf.41.1755156152190;
        Thu, 14 Aug 2025 00:22:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bde5sm5648258e87.3.2025.08.14.00.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:22:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 10:22:23 +0300
Subject: [PATCH 4/4] soc: qcom: use no-UBWC config for MSM8956/76
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-more-ubwc-v1-4-d520f298220d@oss.qualcomm.com>
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
In-Reply-To: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=TtT0Nf2zRlo5tUth7b9XaXrqg4IP4hWtUayIq6Mc8HI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBonY6uR3H78dQvhyGcDcCaUJ7qPD3Xru3SjfvV3
 tXRN/z8wTaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ2OrgAKCRCLPIo+Aiko
 1cphB/9smaFAM7NADBVO6fZa++P8hH9+w0gPru+ONWB4peljrSZiX8CnO8npayp6z8RsETV8MGH
 Jyt5LAbeveLTgKKeSLa0k+MX8AuKWdWLXtA4ipvNyVyw4Pes05Gw0jXFDxrH8zuCHDNKHPnqEbl
 eH/XQ5hczMUwFVs70fgh8WQxc7+frMb6BJtMdRpwufyWM1AKvj1MwfVg3oY8vI9CxqlTjCkS01q
 07hegfbemKwn60pS5LcdBcnlf8dlelBoZHJkHFKlNI4prJ0KAUJAkySizsEqe77WazXqvwuVQ+n
 2HAMoZqv8COj0JM58vEulTArngfbn5ylZ4wXmKFBdCJDzXZX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689d8eb9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=XT48RGDP_DIob0G9p0AA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: M6aQdZBQM90F2bhenYNM2uFIBqI00FuA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX1NIDxXjXapkh
 sZ/ut4KEze2dUHEIFfjs9eD6k7Fcm7GkoABVRlJPoQbi+pSJ4KEugljcOXX2mhNXjQSDlY/Bvlo
 yAbL36zTRgc5vVsYsyM9wVfEyVeG4QWDIiqO+3gbJJQsmyGrkv03e7WwYIFzaak+4yqZhZkT+gy
 3mtl18klFMbyd8ae+XQ8S4wPQGm3fMe81c+XDwG0UBqJzOBLR6+lTCmykZurb8oaQGr7Ssdc3wb
 dNlo7hJfpwtnPqE/27e8CRsF7OI/cTyatdBPAe+VcIh5M1WvYAYsPa9UNCI4ZwFP02BvEZmJfor
 jREUPX/t38PsHqtHrPJmkpNb8d51xi5rW4IptGmY92rpZZ7zqAlRdXJlDcV5CNap7NmH2y8pMs2
 A92K+j+v
X-Proofpoint-GUID: M6aQdZBQM90F2bhenYNM2uFIBqI00FuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

Both MSM8956 and MSM8976 have MDSS 1.11 which doesn't support UBWC
(although they also have Adreno 510, which might support UBWC). Disable
UBWC support for those platforms.

Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 689e333ae44308cec178ff343bf09cc89bf9fce4..15d373bff231d770e00fe0aee1b5a95c7b8a6305 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -230,9 +230,9 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,msm8929", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8939", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8953", .data = &msm8937_data },
-	{ .compatible = "qcom,msm8956", .data = &msm8937_data },
+	{ .compatible = "qcom,msm8956", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8974", .data = &no_ubwc_data },
-	{ .compatible = "qcom,msm8976", .data = &msm8937_data },
+	{ .compatible = "qcom,msm8976", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8996", .data = &msm8998_data },
 	{ .compatible = "qcom,msm8998", .data = &msm8998_data },
 	{ .compatible = "qcom,qcm2290", .data = &qcm2290_data, },

-- 
2.47.2


