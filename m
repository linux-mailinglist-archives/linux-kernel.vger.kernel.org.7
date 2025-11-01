Return-Path: <linux-kernel+bounces-881098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49808C27741
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 05:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C271B222B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 04:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A7B1A23AC;
	Sat,  1 Nov 2025 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TuXMLO4M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZHUvsahj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0F26F2B3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969611; cv=none; b=dz9OmLFWAzzz96HFlQV9cK38piR6vkLiNgIZWq0nmsMU160pwR9l1uAlrWFvklKSgiSOwsSwUwDrjrBojnn7dcaUt5rki4vOHvsuMAM+Dg67NCDE2AdMlfsYzmgHe4fmitMl1YYGPlDn3eUPo55TVx5xQZwrDhL2DxGOtZOjE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969611; c=relaxed/simple;
	bh=/rHGDiZUdOdrl9DYepaOQeGv1VtjtTYXi/+ZkT8cb+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFxfID4Cijj1FRXX1rfxgMjGTj5HUaY8ijePxc4Y7i1RqEgS+fB6+bssFpoxGbFT31x9w+W6h+9FLZBHCPmckIhrLppOu8wElwEq+WU2bIPdxQLa4A9whV5xB+pq/qJqLSmnFVSQ1yxxvaBapwau+vPN//2ESHGrl0+iqpCUzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TuXMLO4M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZHUvsahj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13R4g7520347
	for <linux-kernel@vger.kernel.org>; Sat, 1 Nov 2025 04:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=; b=TuXMLO4Mwi+OQcmI
	M6GtmmtWO7xl/RyIJhOXNW5/k8NraVBPmAbcFzs1LpGUCW6X/XAqFgOmP/D82J29
	2MNGsBLpyhR7k4KBQQuSVMApYqYz4xOJYsxh+t0GOc7/u+Q5nm+mO/aC8DsYlgLW
	7K/6ijmu65Ht/Sx00jW8VbIxsvuSLVsHy5p3oz6t9+a+Qww0dphE0m1xLj57fqYa
	L13h/AotM1493JshZcymzKXUquvAq4hl8FyOwj9O4FZgT4qeBTE1lnBakS1zUota
	V9E7sy6ClkN0Is4+vKzI4/mFBRX+sw/ACafGj//B9E5iCqG/CwFn/N5i5Q27QbRF
	ojEYFQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5a9vg19k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 04:00:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294df925293so27525115ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969608; x=1762574408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=;
        b=ZHUvsahjt/knFgGJui7oDPL+E6OmvfRgp1VLICdckZAatL0KWnyq4osHYCLP2/rjsP
         J6pGGXd3g6o4UAjrzE8OhNpdmeX+ILXp4VaYscMgirJSxuDUqFtNEIku7ASPsT+FM4KD
         IWrBtiVNOUUE4T8nYvdpDB7+giqNzT9Xy3HODxbX0044LhKZ8ZH4xOeW2H5j9yfbClip
         zv0te9DMVy8J3siv0fxy2elEF0DRd7j9mVn5kGYNuwFOCF4IdKiOhF+QEefd0PsNT9wh
         Uk5S2/zEMWkbHsjaUlDFHttWK11Wm3j7auuSx+hW4gbgX8d9NbZUrxJrMPzY3XRVoY0x
         xU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969608; x=1762574408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=;
        b=lTYuN1J+vyrkb0XnlcRRBzaSvQKeP7TnoVF5HsUQg7/UmzOVuVdD5IEUdNM+JevqB4
         3JTHOvkXdJXgnCMMZ2y6Vhvxm4K6/AZJsDme442u1wzuArITClvqbAnecpiSGmwSL4AI
         umKXjPf1MYMOiOCVXOSj/83MQW9sB6QGSfNktjnlQRqFVzKSL+ZjH9x6weh7fgxjUaXg
         mLELlm5JYLz3FEDC5E+5z4b97TiYGr9f4JmS8ocNyrCeWS32dxXCNublfUxwxc7Rhh1R
         c0Ch7mmRuQPptarma7gg5F3QjdSOFl/enI41Q31V+14aXUGD1nZpckAHCzypg4A5O4UV
         CPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Bqpsor2o4jb7D977Bisq7Qfosp9Sqxxi4JrzzTRAPUMptTB1vKe0wIWfUCsCwZKrAEvDS2IykBTSZq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBTYxPCSlk4KvXyfBPVmA5QvTYXb5KEk+5CL/0EyoQB8HwguE
	VH9ZVDS/nyWb7F7jkKuuoL9eP/teN8Vnu4421uWPU9uS7rR/4gwj+0GzWkrfT/BDehD47RpxmwQ
	+zlPDuzM5mN2PdujYuVkwh4LQpcOSh4fqetFKX74WSmjfy3uwbkL6pjObZaCrAVW1S08=
X-Gm-Gg: ASbGnctFUekypQFf0W4FVbtHR3gXmPAz2rt87BVQQkhcd8aPNeoMdcgDxw0g+kXMnsV
	2MwaVFJpOPzWO++t2zml2+lLrSrPHzIw9oo88EY5zNzk1AC7aWrxO5+m+uuhQThucMoi4H1XZfr
	2iyuCZw8V+LUPmXEJV7BFRiJtrVMpgWPoXK7Sh44ypMOvdJ4pZ/opGlL2SYJEbAxK3kKbNABiQH
	TQ7oKg53w28sX29HX+O14fzFq4XXmgRHAkLtRplljvfvtBrSd7E+5otxXNZ33hToTtKYhcX/S84
	bJwaiQxaxtr7Bget+QH33LO5O2UeFPWjQXj2eoiIAvUIT/lieytRRlQ0BoQNtpn8vuUVTukeOGs
	dkC2KFO5ivZvBJIrW/zGgpyNIZ1MikdguOQ==
X-Received: by 2002:a17:903:185:b0:290:9a31:26da with SMTP id d9443c01a7336-2951a37a3d6mr76863545ad.16.1761969607633;
        Fri, 31 Oct 2025 21:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKAAec1m6KMSQ27zZIpV5w0wm864d/cFqrgqxQkc3z3RS2QIMzPOiuhWEcwaukQDzGofo9Eg==
X-Received: by 2002:a17:903:185:b0:290:9a31:26da with SMTP id d9443c01a7336-2951a37a3d6mr76863085ad.16.1761969607071;
        Fri, 31 Oct 2025 21:00:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.21.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:00:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:29:36 +0530
Subject: [PATCH v9 5/7] PCI: qcom: Add support for assert_perst()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tc9563-v9-5-de3429f7787a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=1479;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/rHGDiZUdOdrl9DYepaOQeGv1VtjtTYXi/+ZkT8cb+s=;
 b=Lnb0kzer2s2KLRgW1R4m1XdeYI6aM+xYc3kfH0jbPdg1zODFUgULpywmccRH/RJ5i4TyZrvs3
 TXDDygSCY9mCnIuEfsxGuYCrfV4Vk4yQ7h8Y6FivM/7Si6SgkyZQjwl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX2ZlY8UDRePBm
 zVMsZgst+HrXKTW6KLegGr0q5F4EjP8Wfm4gZ/U6qdxmE1LpxpGnro3ZlD6gltFCfhqX9HPtFiB
 L05ay8ak+r8VtuDaCpzCN1Dvwuhmuclp+7EuWrF2JrUpHGuNr7WwZ58nWDL/uCKiXsfngel3VhM
 lqTeJGTZgAd3ocGRikWnZb+OjaoliptBwrUSaUmka0VBTPtBiTP4uz2t0OHyEWswN1DZ/cNkTdz
 2zySamIfp1fnxk1PITaIwCxB5yNmUGGRYyW1MPJQp2kmv4n18nLEkTABvDZ2jUU1m6gc1ZQowFA
 sN9HwGrGpnYLugWgjpfsg//aCbAfj/keUxxXajHbp9y25CKpws3dfzeaAKVNKtAD/LTrLLyhb7g
 oUmseI3owhTo4H2D/taW9mcV8FyH6Q==
X-Authority-Analysis: v=2.4 cv=c6CmgB9l c=1 sm=1 tr=0 ts=690585c8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=j2XxTBISUlk66HYKGUMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 8Kpn9SF52BXALY6CQjURBZtHAW0oQ-nY
X-Proofpoint-GUID: 8Kpn9SF52BXALY6CQjURBZtHAW0oQ-nY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511010030

Add support for assert_perst() for switches like TC9563, which require
configuration before the PCIe link is established. Such devices use
this function op to assert the PERST# before configuring the device
and once the configuration is done they de-assert the PERST#.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..cdc605b44e19e17319c39933f22d0b7710c5e9ef 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -696,6 +696,18 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_assert_perst(struct dw_pcie *pci, bool assert)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (assert)
+		qcom_ep_reset_assert(pcie);
+	else
+		qcom_ep_reset_deassert(pcie);
+
+	return 0;
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -1516,6 +1528,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.assert_perst = qcom_pcie_assert_perst,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1


