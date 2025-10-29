Return-Path: <linux-kernel+bounces-875896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B758C1A0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 783865066CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B433C515;
	Wed, 29 Oct 2025 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fc70GeIB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJX99EVn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86821338F23
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737435; cv=none; b=B7ML98P2X5Whjz9wnCgm+BoWB1HvNOVoiCayvkPODEYLem6IWISmtJdymhkBxbaPD951oVCKU3eozR+B8jqblofdSo08xkaHLR9hNcgoKq43ha5Qv4jHJfjZG6QwNESxaCBIWDaAzM9FfEoMuEUCBoo5U+p3idFUL3cIHM66It4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737435; c=relaxed/simple;
	bh=0ISk1zo5mbRe9LxvVD2vadNQhbkjLDQVBj/SNxnxtpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HykyU+OIMyDJgPjSBnpdUJ1xOOyovL3YsP4m4JHHHH9uDG14FKk1OXGuyoPW1RNmlK/iAPRl+rKERW6KRmZ5OmdcjYNIagrMh7MCfsnCvglUJHh7k76XCYJT9zTu3M987J3E1Qt+qFYeTnERCTM3qkAZGmvpvmdu1eTh7pcmCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fc70GeIB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJX99EVn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v4aD3755384
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=; b=Fc70GeIBGwxokD80
	gTwd2frpgXYsUgFR9D+UQYKXzs64EokyWRZq+SB4BEwJubyeto6Y6PkIX5vO1rCn
	IgLA+UTVKypmQTtWxmD4OTLZIolhf/WV8m380wBk5VNl/Q+UvIepon/z2CFq4efl
	VhIGwp7TbW5xiekkftvfRqGEtumtugjrhyV3sSKs9b4PwDmMeoy7ooF6imYNKVHg
	x2ER9A0YYhT1ooPD1tPu/P8QDN7z/Nya819lZ46SPxRMBmqGSU6flUcIuhQ6HoPi
	La18/FE97HY/Pbp67ept8J7xFwDYJTDFO8qLq7rtS+aV6GBXr23dw1Dd7w91upoy
	l84cCw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0jbjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2930e6e2c03so75410975ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737431; x=1762342231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=;
        b=VJX99EVn0qgb2QczArTvKf8obLWgQzmCZ/ifMmkmcF6UEvO5GZiaqr4N9L4uvKe9hK
         m0vbl8qpSqZv9XlYUFmcc3HmqRZjX6RnHdy+FwCfcIBqJh4nY/AbXPbcr+NjgymLLxAV
         y01l4lpEsklMPEub8e9TEbi2ChSg98VOt6HSjalLawIMigkIGBckwgVk/bGtlF2q8sbJ
         Tt9DZ1JS2Zx5fzDyItxyjXAYarimmneHzpMZ3VdVSOd5EUdfJO/GdBcsJCz4uSjQqSxB
         UoSNcF9T/yJxk+4X7FrsqJrap0oy1xT+px5ZKFnxbOGV4BX1SCBzivl9Qme+Gv7Vv3fK
         A75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737431; x=1762342231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=;
        b=EgBFObNcbzFM9i+VKqWyIXhDYL3wk7q7PwzaqRPGG5ZZUh/IsCYWnUMsu/ukbMjz7J
         n4V4QC0humjF8KA+e1vUc2V30zzA48MIixKdDzK4U7Leb0K8n//G//076kdPr3+qZB4t
         OZnvKYY1kpoGdXZ51uQRcdDy31SAe9XUQaXjVRi+3yehWTYhx+E/lwG3L8CjxcIRWkxO
         VYzqK+XmD1MwqJOLAiMWBFM3Re8JgIuha/fDlmhNHjpXqi2vO/RugdAWnuwCSULTc2CS
         5pZczPAFVCw6KFQlPAVHlXoiDfBmTnPlP4G//9dWBvHxg83WTqu4HkSNxvk0rBhon+4v
         rOXw==
X-Forwarded-Encrypted: i=1; AJvYcCUoaIj20ogSi1NtclGteGBkqd/3xdzgj3sHSRD8v7IpLt9Ubrd8pB6BWY297jLhjslCYxCPf4pggc5cnto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5dkL2mlInaAb748VStbU5G01cY4yJZnm7EWd0JU367aOrd9H4
	OKMJHJOxAvfcHAuz9OtdW98M1GNXAIblJuYwRP+QpY+Js5jUsifV8zWqhOaUIY2J7Fqp1twawDS
	DV+qJyn2J4bK8WVIxtCZdQcH4TiVtbFY3k7LofdNZ6ufjLhCR+T/C/B44oIalf+9Q5Bs=
X-Gm-Gg: ASbGncuV3mzwpUGBEeo8ahXUmIsZzD9tBaejC4Cpm5xKJIjDyzamvz3kp4WFVa19jRo
	QbHnD7ibO6Yg9oP3B3IbfaZjVY008krCwPyHhudOz+EWGFVY/oMo0/2pIEfF24sDNXdvbsbE3OM
	sxUwxFl9kq4ANg/ShfIR0B4DxtIBqQTeC7hbblva0WQtd5re77gPoRY5po7NUWikTxomQVD47EX
	c73S4Vf4x2BZh7lZD+NY5hni0FhRjjrkx5hUxyBpYAe/gPIy6aIRY/35DqVVQKZpOn1ivstQ9Xc
	q8gYijLZ96zXP4pEiyi+6MoFvLaSjy5LBJRH0/HzT7aaRw+Oareomooh7AeDbFs2gyROqTYCho7
	xcaFF15Jvw4Os9Tc2hGlluF21Ndx4buSp+Q==
X-Received: by 2002:a17:902:d2ce:b0:269:a4ed:13c3 with SMTP id d9443c01a7336-294dedf443fmr33997105ad.5.1761737431335;
        Wed, 29 Oct 2025 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzD3E0IZm0JLmQ6eTP7Lq7ar8FKXrfNnuIQJfcHUciek8CdlXU+uEBlYoC0IXK5Nyb/Xjdwg==
X-Received: by 2002:a17:902:d2ce:b0:269:a4ed:13c3 with SMTP id d9443c01a7336-294dedf443fmr33996485ad.5.1761737430778;
        Wed, 29 Oct 2025 04:30:30 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:59:57 +0530
Subject: [PATCH v7 4/8] PCI: dwc: Add assert_perst() hook for dwc glue
 drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qps615_v4_1-v7-4-68426de5844a@oss.qualcomm.com>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
In-Reply-To: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=1362;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0ISk1zo5mbRe9LxvVD2vadNQhbkjLDQVBj/SNxnxtpA=;
 b=kOSo+nmmPNadAjOdB06SfSAKWKG/olLMaKQnaw1Yrr90I/zKaUVLNSJ2NCiJnpG3h7DLefx82
 JJ7r2dS3VeABWmKmDzJ4i+yI+7xbpWJl/11xp4sC19PcUt3eyhvpgJE
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=6901fad8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: NjufxyZP-bS5-pHP9VnnsOXAzcQtm0bG
X-Proofpoint-ORIG-GUID: NjufxyZP-bS5-pHP9VnnsOXAzcQtm0bG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfX/WdX9w4kYw1k
 0oAr5TPTjj2O2WpB4OazcOgfIBTSd3yQvtMNY0ok9Cq3j1b1bTo1ZYkjc/1B2l/rEL+KbrAI9/U
 9ywAMlr4CJ11c+rjT6ybs06SFbxC9zzzJCBTLaJOIb6YmuHwGvzCNUEmfwNS6uR3NYeOyErVBS1
 EBETg4LUqT8D4P5+L2UvaJ8Qs59lH2CQyR7X2iBYRjtXtyZfr5PpYqJDCfLhxAX0UN02iWyfI+b
 VLPr3f+XUEELYFGEDuhwDbJHHKjbSFKEYE69U1hDDjYgULyP3RPkV6RTYtnCIjbkZZAmPY0ByFg
 iHpFrowuWc9pNLfiDNaeGvg6aXSVuLPNVyHqDXa/4uFYviLU+UdeKqhPQKxEPBhZL3aDVr7espt
 F0hj6oD/aLypf+6s0YBebOkHXeN8jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290085

Add assert_perst() function hook for dwc glue drivers to register with
assert_perst() of pci ops, allowing for better control over the
link initialization and shutdown process.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ecd10130d3be3358827f801811387f..99a02f052e1c8410573ecd44340a9ba4f822e979 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -485,6 +485,7 @@ struct dw_pcie_ops {
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
+	int	(*assert_perst)(struct dw_pcie *pcie, bool assert);
 };
 
 struct debugfs_info {
@@ -787,6 +788,14 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
 		pci->ops->stop_link(pci);
 }
 
+static inline int dw_pcie_assert_perst(struct dw_pcie *pci, bool assert)
+{
+	if (pci->ops && pci->ops->assert_perst)
+		return pci->ops->assert_perst(pci, assert);
+
+	return 0;
+}
+
 static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 {
 	u32 val;

-- 
2.34.1


