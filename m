Return-Path: <linux-kernel+bounces-880040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B76C24B84
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9BAE346F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146D331A44;
	Fri, 31 Oct 2025 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YU89bmQZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c5AvPCUT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4313346E55
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909144; cv=none; b=fiDsmGSVy0oK1h13Y6r4JilLkK8J2KSxEuSh50Md+Q8iXT3nXEDnIr+pnLeobtXc4/95+5B1F331E6fnRqv1OJYcCGXnw3KeN6xM20CHvaN0HhAxvu1MjOBP4DfmU43hqGyWkm7c0akbzxlyqOF74c/5BWf9COR5j0ACJXKy4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909144; c=relaxed/simple;
	bh=0ISk1zo5mbRe9LxvVD2vadNQhbkjLDQVBj/SNxnxtpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4LTMW2KvrgCqa1HdvIaELJwZv5PCjAC4Bs0fwowCcxo9azUhtbwrDKNCu5ne6uiPERbu5WysBe8ybbLOrOj2hW07cLOZHIB96JjVO9myWOFZzbbxW2k6q12EeSuVTRqhw0fig08r7FopRWJ+DqUDAsxM8g2xTy2eWX+nS0lBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YU89bmQZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c5AvPCUT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VAXgFD1571961
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=; b=YU89bmQZEMxWYCcs
	m2QGF1NSck1KNs06moZqoX4eNjqBomt0mHZl0dPlGKEu4DjMAuwkUnB8Jm7unuGl
	7UHXviR+fTyR1IB9meaa3w9x27Zlfo2HQMjPrOh7jeXYUJP7CGGMqhbWEEpE/YvJ
	QRI3eILSdYFgtDHEqkslqZ2aUTVB1ohQmoUJ7Leq72NQfn9aE433aTPAsm+IyRhA
	6c/VQdFt2fKCEme3lIe4hUyL2Hzzh5Mz1B4q2fvBZVHFoMsFtEoTph+RkdKOwqs5
	pP+amidfsbdar0Q2f5Je1e/em6NGnUKXyrquQ0xS44uI9y2CKTSsOxbiClAhIPfY
	y5M9hw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc1cwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:12:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so1778101a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909141; x=1762513941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=;
        b=c5AvPCUT68ycnqYPek/OVKPCk4TIk5G/SQeMdXT6t/EeXT9XMbbQumZvzXER2ZebSr
         IBIJ199hq+WUKAG73oGeiLcs08dosTJOVpZYBoJOxEsm1McD3nAmdawBPy06B6wPLXRY
         H1SJNwFzjJClJdT9K29YogYZekaVaIvYV+9RTJw/HykDxa/jFgrxiNHHTdTHoD88QOFe
         43FFSJg00vGNhieANFPTCowDFRrm8EnvRBQy/qRXuO2tZQp8fL+No4ggBAfIeoxfmHwU
         1fmq6+sSTm4sIz7zyoH294H0KLP9r3qfOSdm48hKxRLyNTPqocWnJIi6qvG3EoWL+30D
         NcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909141; x=1762513941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=;
        b=XFGOXQ3ZQyjYMMND9tvgoR7f+cTM50HQxxB5DUaFoAdrP6XcHhPu8hEhx7nJZaLCWr
         jgoAiMDe6Jp9HFmFUdT6GYxccDcjBZs4Ws5yIwkcvLhq2+eUNym+qswEWVp/vynRR3ip
         uwLldKRdkfycr288GYzd2jq6RKhKGkCXm4GapTegQlrfJ7IJJYcBgMMLRL6G5/f3At/3
         fWzM8lNtoBzUFjYRpWqpqGsJquu/ItDaPGqNm0avCUXxJaU8InpRcbf+t0NH7xJ3N/yJ
         nX3akVWrDzrqo6hnuPIMRLnvSQAmSzMxZO3FeJEJNlFBfScSM2RRTmYAVUqo2kmac4qH
         mZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9+nV06yaIoFOWHW51GPNcBrUbslglqWTRXQdrZnAUFkT0GpWvPoxNomJvCBNVvpFho43lW27xwFcAh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8p1LBU4Vf4gbWlw2BKxGcferdQQBjNq4jj18hdWZ9HemdxIpV
	zw70xEmJVu+OQQLrdTll3wkqoYBoYdVKXZDRptlHmX6lkjEGYyg3gw92kn88glo9GeuGAgUNWEw
	GUiKPXNOhn8QT6wXQVFZ5wdOwovMQI0LNNCKL9mz/d2nUMll0KSHhCTXue+J5FZfoq1Q=
X-Gm-Gg: ASbGncsITsD0pyW4hN5f57+PC/613X7R+fFaEp7i7K/kBCS3fpNM/NnqXldDL4ykEWm
	8uhv+Qb66EhZ5Wtiy0W2SvPI6ORGMn6k0WIVHKDZrUNToRLykRO+JX+QU17yslru8+07n42cbj4
	8flZBeuOoG+RKbn8pnb0gEAUxP29BGs/AYAqiuk/BltHf7mZc5QFfy8wF2dCTUY/pouO/R4Dxvm
	Jlb75mOymiSFzCFEvgxicoxK8hpULi8QJFF3E+Wdx5vhN2JCZ+TNZ5VkAmIiEuZUhqlMVuoqguA
	RwOROCAW9O3yQr+1K0f6bDcYdaIpFuDFUQyWtfTJEPXbvFWmrWVjQhApjDnMiQC7fTf0DipGouX
	ut7D15nY02oHPyqmiCVgIn9VnQpQgECZjAA==
X-Received: by 2002:a05:6a20:3d1d:b0:343:72ff:af80 with SMTP id adf61e73a8af0-348cc6e41fdmr5322011637.58.1761909140617;
        Fri, 31 Oct 2025 04:12:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnhck3BWPobTsauAbQ5RwX/zIMsKhm0xVqeroOO6S6bRw9RLy4SQMcC7r20N/6kh+wagp+WQ==
X-Received: by 2002:a05:6a20:3d1d:b0:343:72ff:af80 with SMTP id adf61e73a8af0-348cc6e41fdmr5321946637.58.1761909140010;
        Fri, 31 Oct 2025 04:12:20 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:19 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:42:00 +0530
Subject: [PATCH v8 3/7] PCI: dwc: Add assert_perst() hook for dwc glue
 drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tc9563-v8-3-3eba55300061@oss.qualcomm.com>
References: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
In-Reply-To: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=1362;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0ISk1zo5mbRe9LxvVD2vadNQhbkjLDQVBj/SNxnxtpA=;
 b=DYTOxZBqY+ft5pm96m+zZlUuvyl6F4tC+d2+Avi307pmsNbY4k2Vlyiua48R9m/gNntKVH948
 Bnd2G88RWIgDk7paaO5wcNL/phBYVyLFqkoK7njDArRWhuAKnU+CQIc
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfX9y9u9M3LiVyZ
 WISNoIcY7fOG2Qd50RVCMvNF6nCXSwe6/cw8Gv+//hRpMPVG8JyoXM8s9SptB0A9OmyZL26KoXS
 JjTK5YRkqkv6TMtRT8SAzollnfoUnoSVca0MfcJJJPtS4b1bZLxQ5A+TUi7ZSqYD5F3Vdtk4IVM
 bw3RjWrABXN1uJPngup+ryc2vpRqLyLjE8EFEWct+5xvHvrgRaLEQM0lfaEdxLPD11sgXrsc08+
 KQSVQarVRgygZynlEKJhS93okFERyY/GUafk1B+bCI0nF5NkL70YNrZkG8QT4y5vx1zbCPEjdh5
 FJ1j1lXUue+lXLJqsm20QofKFcH3aqtGVoC29bTPQT+TWxDFYfKLEaK5+tNLrtlnsAtd0PasE9C
 D/8Mh4rNNZ29gQKDG5VFVufe+NGc1A==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=69049995 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Nu4G1_TjFvcKWil8NrJCxA8C6Zwm8v7F
X-Proofpoint-GUID: Nu4G1_TjFvcKWil8NrJCxA8C6Zwm8v7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

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


