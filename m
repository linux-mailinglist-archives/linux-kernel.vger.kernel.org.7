Return-Path: <linux-kernel+bounces-881096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1AC27729
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 05:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D81B21DF2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F389238C0A;
	Sat,  1 Nov 2025 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QXyvL2Ko";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B2PzB9vw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC206261B78
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969601; cv=none; b=lYdNRWAvEO07wtO2Z/CLEDKNrQ6gjUkSeDEZIK2G1eCBDgRgwh+VUJuUp9PdP/TBW/1d/0YCAfqIEj6z8zn383MeSPxVQuvyLWGHeMTg214ZwZqNJYSeiFDyEdD/CtCKm/ve0RDEqn4f83YbZvPakZQ6xOQeg+yQqd+d2eWfWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969601; c=relaxed/simple;
	bh=0ISk1zo5mbRe9LxvVD2vadNQhbkjLDQVBj/SNxnxtpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuFK6gpzZFwcqr1a+ovoZSi8dMyBH5gdfVLK8ktuS4EMU9KZltcANAJZaoedSlqEDdyVLVZpTY85jL4OI21QgFH9xjFKTQaY1/dtRFERoRSQVKV4S6CdyP57G++Fy+IXdC64sqpgTFJmOIY/usS3WVUP2d9b7fYxlQhuFhsrVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QXyvL2Ko; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B2PzB9vw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13rH4L572920
	for <linux-kernel@vger.kernel.org>; Sat, 1 Nov 2025 03:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=; b=QXyvL2KoRZKxfRTJ
	cvMABRkrG0rdyUxPGP4PzRibuen36GV43WC87dkgRY8HK6Ofziy+pRZHsIezQ4BA
	mB0MgNo67uyQ1NYf4STNyv8H/G8WrvQVyPqf+Yzl4ePZPcVvaWbwikquKoYw1KK9
	FvuOctD0Kz1ajs86HGIGL9/lLuzgTPlequnNvoFavVhj3Ls3MgvM3H70VaNy5yDi
	KYt1ox4EZ8wZvHyXVGYujZqirjOeKoHjZs2GgLqQzaiE3Y1yEoDioIKGw0T8XaS2
	2d7eWZTCBIELa+qMoAzsB5m9oyj+O4GqjkdLub2Z2l6fURK2EyoiE7YJgjINgMeS
	RJikpw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a59hhg35d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 03:59:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29554d36a77so5174965ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969598; x=1762574398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=;
        b=B2PzB9vwanaO/susS7kzX9B6rcxuVubYoTS+cTtJD6hRMmhQ/DTpMqlM1V5cad1CUZ
         pyELkqm8wxzTpmml1clMH7zz1hwzEJQ6yDRMK2kwZqtuWjAzfVnoU3nxfceP4DUynLod
         AoLEUT/fZSmIGm9l1lnsonTbi1TZ2Iz17iSHUu9GSOvV85bMyrGFzAXktqD4/PsrLSpo
         QwX1h20Zj36V1MTxqCRYWyhCaYwXN8PmpOn6AY1EU32r6biW3Mn/OMYYsscAEV+Vr5qw
         7R91DnWVG5jgoPPLPyklMbFPwbvechumS6U8fRtSRSNTmphJ3l8/7V12X6qiIppRl+eg
         I7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969598; x=1762574398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=;
        b=QW1Yu7zNH/JIBfVVa2bdq0R72s5B4Q8yaflsblZGP0ZEACggroh1XisZvpno3Qi1pS
         XcEFwu+EbkUbSvLw7fNBAhtIaidh5mcAU9q7fj6aB3lw00GqvvTx8kB7Y3Id4wSb9yAd
         sQzVr/wsTNBOM7vy079yDNNSmaMQW6efvYqHT5lRRIf/NkU4PiX1iiZxzwkWMfkiGneP
         Ve2uQJp2DRULdXXKtyMSEl9Cppka9PBPn7H6tWqj+mLDDLM+qkBXVS6GPHl69uqqRBdB
         uDiMNDFuKWRN899UMUt7xqnqElSK5dEtnI4ZoFO1fYfGR0HMaP1jmMPfOQ4TYxs91T3V
         dpWw==
X-Forwarded-Encrypted: i=1; AJvYcCVL8+EWqFG8ggnG9mzpY+CZOVQ4Uj4zxNwlIfdJH7w0e4w4wsjS2wc0aE3YRQ05hSaLS1i3xGpReb7FYZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlk/2qGoD8FLjWUCV0RR5MiX5rZxTh7EK90of5SgFWX7AzPDbv
	BFZxyl8a6zQFqHYchnPl+ZRIBjfYwwTTUnHRPARGN22/A9zqw2p7aUiOBdkOcUIIApw59wLywBS
	+saCm3iaFbaAiiIC+mUQrKfJOlj7fNX5CFOrhtXIHJWBm9Nzw6j9By/yRKx8Vq5cneNM=
X-Gm-Gg: ASbGnctgx7P9ieL5Q9diMskCA0wBwEHdzcVA36/u9WDE7UOZHCmRtUi1Xvp9GN5bWvJ
	u9KDrgXbu63RJKCH7oeeBuXWbDTWwED/u3VYe484nwmDyuu8Msf8U8Pf5iYpPptDmAQTsbYByNz
	sHIY2HDQAflWnHLj8/kkgK1jYDiWrlfOKdHzNvdyiWyEN6wNQzD2HQlJE1v4gr7WNt83e8ahCea
	rIpJOiuxgkQImuwih6gxh36mhcdnrERuGQoDI4XU97cwS67nexWwgApSIYXxbcIhB4lOdvJAIn8
	VafDH2IWz5MW2+GzMUV1Zjx6AZIyoOjLAp6Ql02KnVo5nowutjMh8WfneVxiGOkI/YpT+TDv6l+
	CcXqMfutK3/PKwZ2FBCWbia3pIqOKU4HWAA==
X-Received: by 2002:a17:902:c947:b0:295:269d:87d1 with SMTP id d9443c01a7336-295269d893emr49212655ad.52.1761969597810;
        Fri, 31 Oct 2025 20:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJc8g/476xtMo1z1kMshWvFgOL9ZnM1ggtVT7FaVakM6XhShCNST3snp68LNvZ2gl9YcoVDw==
X-Received: by 2002:a17:902:c947:b0:295:269d:87d1 with SMTP id d9443c01a7336-295269d893emr49212415ad.52.1761969597358;
        Fri, 31 Oct 2025 20:59:57 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.20.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 20:59:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:29:34 +0530
Subject: [PATCH v9 3/7] PCI: dwc: Add assert_perst() hook for dwc glue
 drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tc9563-v9-3-de3429f7787a@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=1362;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0ISk1zo5mbRe9LxvVD2vadNQhbkjLDQVBj/SNxnxtpA=;
 b=5hoG2lVfjcLdohSHpM4iCeuSiCiha0smcKSS9Zwrty/Rdaz1tc9AqhNjVCwmZk5gbLJ5LkNAs
 2oricXxhAPwADqvJwtlzr2twoSpmYYyJr3rpbzwhKqorhO2GKO3K/AL
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=V6lwEOni c=1 sm=1 tr=0 ts=690585be cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: jZRhPTXFg4lyUGB-7Td5QoG7rX7fxZdA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX9Yw7Ez/yuJ+2
 WXGbwtGxZ3ydu1iitJoWoMYkHjVzfFhuNW1S1Vr0FF1bS5qFEr+QHbrkquuuzF+/cpbTmNml5QK
 1OydBh2RXqi/d+lVa5sdpYJ1va7DkE4mRXNyVOm3AB6l2BY0CNyN1x/T4If3SCG9MUe09AGfAXF
 R8REE/NcnyFBDwsJQP/JmO2BNsGYhAz17/r8spjfTYjmpPcd4bMHYXoy44HzZYHbOJagKb98kk9
 8uaMi1VJQqaAFb9mXAvzy83ez9NCR+m4DgeuYDAcYsJRgby0AOJUX30vIfdc5mQxCHdjFhTe01E
 O1TFKt667SEc6xpv0cRPkDCuqsMvOa4rl5K19zm/NLDHsBjAYGYT3hrrEAR+NhRQAdEnakfSMS+
 qGzMj23M6z51TY5bAxDwxoM4y+4Z4Q==
X-Proofpoint-ORIG-GUID: jZRhPTXFg4lyUGB-7Td5QoG7rX7fxZdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010030

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


