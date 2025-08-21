Return-Path: <linux-kernel+bounces-780484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF6B30279
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C6874E35DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A43451CC;
	Thu, 21 Aug 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XTc9V3v/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171D3469E0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802607; cv=none; b=URRVxoYgYQlSkK2QB72FVDvMXg4xYZMUzjRNZQYPRCmE+O1Il9asaTWmqZiN6cH00ZEYVYBvLflQhKgHYMGbJ7VlMZj0lCMk4i9L8EhKI0DdKIHrdzg5mA+GLrQ98ANhFV9X+GBbw15XrtKUNg0NtSjEGQV1c0Z1s2ewfmR+oow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802607; c=relaxed/simple;
	bh=X5/b2wPl0B5JtiyqdyVNBvFH6QvvW/Oc2oH1DyatOms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Myj1lw7djbkaeLInDUJb0fCYrn3viTLWyYJB+ZPjerg8jwaC8PfsAQBT4QNPCkZuggwrMo8hRjyclKUTp16HbIC7S2lFgzPSuZNk8A2tgz1hesw7OBCGc19rAY6JGu4IRHSkLkRwHAFi9cDJgWVIwlrm2/AZHvEJnBc2gPNPiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XTc9V3v/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9ja9014637
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Eyjmrtt67i/hSgA8ZAsqicrziXjRyLeDwvFEX9xKzs4=; b=XTc9V3v/xDZMNumq
	p5UbMbUr3Ey8ZhRVv5Z+a6mul442zRqvNs3CcT4ELBh5rmpl71dIRShNMtEKUgd+
	rYfJGQmuPqPFruhCYPTTmUZ5PrgNGFH0P4D+RjjeNpGPqjgc0M0cT383CVE4TSz/
	k6YoIcyM+Dm0/gtVSN9zBZQ8rRbkov/8z3qvM22WmkDL4SDaFTQI9oX7mA/keeez
	I294uWhwdq5dCiwcpUvzStDy+ndmwS0/oRxMd000GcbKra5PkWL+jIRLlpQbn+HF
	k2Uj70oTpsrks6m6qOlpgr+F1atUVMO1xs4E2Ak+QZxccrykdeMbuPnJHQ6mTz8g
	J8CXlQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dpf5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e8cc27f5fso1239984b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802604; x=1756407404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eyjmrtt67i/hSgA8ZAsqicrziXjRyLeDwvFEX9xKzs4=;
        b=f4KxEdbLDOHa8qsrPhOuPwCCDKDBb/teLv7rILvPMkBQoXAWNAhB6Rt1uShB9+otQg
         CsWCsl7xrTbxokAoT28LVUpwNth8YKI3gzqXEjMQnd95a/CW1FVRRWGKLU9E9A+pQpAz
         rInL/ZJLRKqeymmpTBrtA2XNXJoiMZd/Mov/8PgktLDKhcKklwCWSvlggMsgYGvC1GxR
         1JoXRsvGPe1PZioSItJ+eVRlD4HDc9Q63sGqDGbh0CCiRexT27Dv8xrhN/9Xv33Taxst
         uWIQdX+orFevH1MAwgy7olHFnBcdI9Iki3uoPhF/0Dgba9MQhJew+0DbgqxOOmMceG9A
         GYGw==
X-Forwarded-Encrypted: i=1; AJvYcCW31gy5z65DRucVUrwtOEV9nU/1xRg+yebGeCKWVqQyo/qM1walp6LBt7zxD4RhTG90zv1CExWmJlj604A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZdfCchFsLURALsbiW97Zr61+mZOc7An1fsmBA9OKzUZzuvtg
	Lz0kJhPlXRD+dqlZVeulmQuC7s2x+G1P9ymxEend8gtXkiDn56AISO2+WWTF4xukdKXQZ9GIeYS
	FN3GPAnxLMdnu7XJ4yQkYrjlOX2xFdemqKV4dNPdjJuDJkOnaMOVPkm1rW3kVoJ2v2go=
X-Gm-Gg: ASbGncuDuMDPpeby1nuyITt+bHmuv7ab+6HHI8I1tBZGJ1mZdr7JChyixaC28vi6rj+
	lkhVW7kK3++d3s4lXimLzuXRYt00knFYm4fFd+LOhojQl8zPHMJUh8moPn5IoehZk2uUdCcsraM
	HuDu64MgmcK1ZE+XxUkSTMnTk1gxN8UOm065KRGohqtLgkA8/tEippuoYDSBPy1jFOcPhKHQbkb
	kuF+mNJy1MFwEe02lE//k/wQQAcqhCWoFSNEjCczRCDZlmVLzeNJvRBlHzo3D0vfZseNxnCFteA
	aN3bcwi0fWtJW6VoEhVNzJ6mSJqu7Djy8M6fT0H7aT0H8LmC0aMz7g4M9fJyI9nO
X-Received: by 2002:a05:6a20:394a:b0:206:a9bd:a3a3 with SMTP id adf61e73a8af0-24340c3a714mr325120637.24.1755802603762;
        Thu, 21 Aug 2025 11:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLnv9zIkKigFMRZ5cTavEVxl0hH0Mk1mEGvhZ0Z3VQ/d704GnW1rvvfgCrrEv2z/W1xLZk2A==
X-Received: by 2002:a05:6a20:394a:b0:206:a9bd:a3a3 with SMTP id adf61e73a8af0-24340c3a714mr325089637.24.1755802603354;
        Thu, 21 Aug 2025 11:56:43 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764090b0esm2106977a12.37.2025.08.21.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:56:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 00:25:30 +0530
Subject: [PATCH v4 5/6] arm64: dts: qcom: lemans-evk: Enable Adreno 663 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-a663-gpu-support-v4-5-97d26bb2144e@oss.qualcomm.com>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
In-Reply-To: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755802565; l=735;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=X5/b2wPl0B5JtiyqdyVNBvFH6QvvW/Oc2oH1DyatOms=;
 b=mTcyCQXosL3wdwNsliBAQNXiroFwDZJGSaZ/bRV17fNt6HD7Zn9Y93qTXO6bpukLNK3gl2S2/
 L5jxBVtbKV6DM+Sf2O9Nz/+8Zr39EA/mNiV4RlT0T38+vpD8UVxN4B5
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/EZM8SeaEzsK
 N5lfeCwQwtpF1dZjrfrMoiV+/M73jBtXvY4LFMcuOnpIKbfn1U0cVNChn0tXd16JhdUvJ/md5Sz
 8Mjwfu2ZAK+ZWesi1+KZ6K5SDygGufvcqDeJyXs+cNH/J050GJODzuSSdKsHqSnGMdwl9FDHjrX
 jdXf5sZTeWI/ClsjpyRQ0Q8xPFGrN2IcHt5d3orEQ5Ee7M/dD5qkKpJkOuD98xIsSQdCao9TK6b
 JL4ShhRVv/+jvcWe+nDMSBP5wnAh7uP4MG/xsU1/En6I2sp1ELIykVzX9g/e56Au+LtPta/Etmh
 nmMCYZywoXRB/w4gkSElpkts4NrpnbvN8sTvifp+mS0TtnPz+5Z/eHoMResWF5b2te/PtCTh/A9
 pWQbsbeKTa23Icnn5aPh85rFUYs1nA==
X-Proofpoint-ORIG-GUID: LGXjonnRBvWt4RF8MK3LzbUkY9NVd8FL
X-Proofpoint-GUID: LGXjonnRBvWt4RF8MK3LzbUkY9NVd8FL
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a76bed cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=jbU5qkt2-FsioPMlu34A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Enable GPU for lemans-evk platform and provide path for zap
shader.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 669ac52f4cf6aece72141416068268531fd9f79a..876f43d761870b968e43ea1ecc360b4403f19fef 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -253,6 +253,14 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sa8775p/a663_zap.mbn";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };

-- 
2.50.1


