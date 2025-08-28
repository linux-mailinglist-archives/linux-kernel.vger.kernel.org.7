Return-Path: <linux-kernel+bounces-789909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3EB39C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA7016DA94
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A263311595;
	Thu, 28 Aug 2025 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X6SlWyIh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9A3112D9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383033; cv=none; b=FIQhNQFtXbowFSqfkIhOnxgoXH30+Mxu+m/mgRD8IgtdsIh1Kn2bJsSR41ljjI5djA7WEt34MmDQEzlVPX6Vqg6k2uhd+sWEOJEUW1OsobedtA4AoJ0zbe1s1wX5aqWPLdkWYIQen0r9ahnd5+R9quWNaoRnrhWlrdsI8rNpDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383033; c=relaxed/simple;
	bh=gJyZo4+y70cAtQtM0l94BcRRIWPsTYGyCPIEqvg0Um4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1Z+xMJW5d4La/QobBg7PiFXtIJseC8R0N9Sby0jg2H5Vd+HR4ThWShoFInQ13IrglPDUFJXC/Qr72Y1ycf6cHJPhalao2d2cVaowfIJ9sVUVAs9lezUoR+pfua1RfK/f7QPY7uY/sJOhVGsm2givSsofogp7jTErmuYF9cNiec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X6SlWyIh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SADtIN006992
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ed6L8eMIvW0AbHtn3XR+t7FYjsouaycVZOPUWpXRCik=; b=X6SlWyIht6MY+2gP
	qkxTu5ixJm3zsW11mJocaFzzjYBQdC+f/n27GVbArjDiLhkqOKQdYSO4a/Jmjdfw
	OODYV/YUs2rVylt1xpCErJEtfCa0pjBtsGlxh0QQ+Q448Une9VaKo2zaUW2r8ZM/
	cR4aOZyuv6NJXhGSBQ7ZOW3tPpcnTfrTP2VZDjv9HSFnCsZtQ38ZUp9FSGGUyqXv
	EYQvKLvK+MZTET2y6J+cC7ImGdCHCHCOMlvpawYyol/FJvcrmMY7tRS+ZjrpszBe
	eVptmnBLGpTj9i7XlQJIj5YcxOaCf5uILR2aZCwXz4lqKWTYXM78ikmMqy+0OwS+
	olqXTQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67ga3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c20148c54so726906a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383031; x=1756987831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed6L8eMIvW0AbHtn3XR+t7FYjsouaycVZOPUWpXRCik=;
        b=m21oAIExWmmQZeQ/wkuzcLym00GgH2YArchys2B0q8sSEwkyaNio3nDqf6Z2akBz1a
         egqpbz8AfSzA7GIXmkaRuqna8WK4VynSdQDMXk9Wsbb//U2mJxL97LzN/tLg9PuOdUsP
         9odFEU66ESHd2bMxzgJ1hGVoetLCk+vBujl94yb5/KsnVBZsbxjLNcgljOp1emMU109a
         b8T/L21Ewi+9+O/NfTB1oSqOje/D2IP5puiIaeHNpO5bRALW4nCGkTaRqyDufm92wIdI
         n6VUkso07/A5kcsn1IoZh0xoN3YGhOwFrDVwJOPQZXo2wSKNg0AMPD39lqyar2cfMiXL
         +cOg==
X-Forwarded-Encrypted: i=1; AJvYcCWhxz22gOg+suVMF2uT/bWhSxRI5HImZx70HPrIfYOhs03/o292YAlZcvyPTStGMb3ELha0jlFd1ZyJslI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBsWdIvAjd0LxI9ICq9wo4vqr3NDLrjGhmDKt/Oz/Q4/BDHf5
	XiJERiMK0ScFLbEQWNo7E8qZVNkQHWSNFT5MyoatGennfKYZg3mSxpNq4XK7pwMeMzVPr8n5t9l
	JcvR6NxU2b4T4DM5tb18J20OeANNC+TPSFcCoWoSWMqXgkJVRb3odIxeeweYn7HFRLqY=
X-Gm-Gg: ASbGncsIWCE4Ti2xPEaBK67R9yJrB6RFT5ZyKvmhr1bS46Sh0CrUssFVp/kfoHQAVJK
	dFY0p+am3+bsMtR4xOtsEgx/0ePUc2IcWCnJ0DwcPMYL/9hyfTGd7ScnVi9BdAZHtUjmSYNDODs
	ENOS+kgRGxN8gw6QBANT9F3/BXtWBRbvCW4RXC9uetVU7bH5g2uZwDbG4IRlWTXYo8WH8KxqSpb
	IoK88XeNaj6pavz4vAj/u7l5m2Amov/C5qx88dcVKvH/8XBPSwQI+pXBvQuN/fT2cFycKIzo3cp
	Z+BlrI5rthHGyXwprseSbtJA9h3bjyLsfP3DqxqpPKoyoExadPs2g0ije8KxltoHAIvw5ELwuxQ
	=
X-Received: by 2002:a17:90b:1f85:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-327c0c68a2emr1602909a91.24.1756383030488;
        Thu, 28 Aug 2025 05:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLqn7GbKDipnvW7wO7xyl/z3nxMSZZtjcarpD2Fv56UXUJZ4TTQws5DQWp7lRiXQXSlA/Unw==
X-Received: by 2002:a17:90b:1f85:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-327c0c68a2emr1602844a91.24.1756383029911;
        Thu, 28 Aug 2025 05:10:29 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:01 +0530
Subject: [PATCH v6 4/9] PCI: dwc: Add host_start_link() & host_start_link()
 hooks for dwc glue drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-4-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=1587;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=gJyZo4+y70cAtQtM0l94BcRRIWPsTYGyCPIEqvg0Um4=;
 b=m3Z83ZVY0UwHl+oGtMxjjvp8Cwj8Qi1oKlZ+0jAtkA1r8ZOAULJQJy/HJIbx09SyD/w0CwAm2
 oQLd0oEZ6nmACuGRfvCySXEqKHoqu3pc4HcgTAkcz87/6u3scmYEyk8
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfX+dT0/UXN4mA0
 7tDZU+1FrsSq8IClwIDHxLzHerslmMRpUNvDg/lpCTNykuwmOGVCunjJigyXQKmXrmaTvtwBWZ9
 L7IwaeScwU/KRu30vj4AV+FdQJN9n7S5C6LJlYiV1SL5FufGTiRx7Qvay/pc5x3B00pVkPVD535
 vT+/+PAkBI4aHy3v8qLDy4hZz0UVZQv/Tujqs1P2GO48C2WkYzcVJAYYb+MHETsE+LMxyH3tnuW
 hjKqCruBOp6rKbn3RTNTAxVM3ONFSd53xq//8AQtXcsNUyoB6JlUZuKlGkBUT2dyKrsQ6HLUpA2
 jMA4W0ope1lnK4I5hgRcOG0cMw3hvLuA1fs9FNFJW6IWfbbNA9B63Vjf7vy6Mipq7QYdo7m+CCV
 WBkym1Xz
X-Proofpoint-GUID: 3kAxkb_Sl42JBnd5TWSWQvTeYasv_0K2
X-Proofpoint-ORIG-GUID: 3kAxkb_Sl42JBnd5TWSWQvTeYasv_0K2
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b04737 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

Add host_start_link() and host_stop_link() functions to dwc glue drivers to
register with start_link() and stop_link() of pci ops, allowing for better
control over the link initialization and shutdown process.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcdd794013a865ad6c4c7cc251edb48..1ed7a75501bd516ef704035a63e5edd35bd7e0bd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -479,6 +479,8 @@ struct dw_pcie_ops {
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
+	int	(*host_start_link)(struct dw_pcie *pcie);
+	void	(*host_stop_link)(struct dw_pcie *pcie);
 };
 
 struct debugfs_info {
@@ -738,6 +740,20 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
 		pci->ops->stop_link(pci);
 }
 
+static inline int dw_pcie_host_start_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->host_start_link)
+		return pci->ops->host_start_link(pci);
+
+	return 0;
+}
+
+static inline void dw_pcie_host_stop_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->host_stop_link)
+		pci->ops->host_stop_link(pci);
+}
+
 static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 {
 	u32 val;

-- 
2.34.1


