Return-Path: <linux-kernel+bounces-892465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD4C45269
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180EB3B1722
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2042EBB86;
	Mon, 10 Nov 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PV37QXHp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KAOWAS+F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBD2EA156
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757990; cv=none; b=B0yvLefC5HMa2DmnRCp5RvSFRvOFRBK7YjKRDxAqgLtvZ1yLhEmqSgSkR5yvP4y6L72hXl87EFAVXst+Er+Ezz6sz8hhwpkrAqLVPCQdQR9gawzVPwTbsP6poxPQVaTqB9YJDfuDYF/qeVqnfjpxxCMT+Nam64oKnp2VcoxPxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757990; c=relaxed/simple;
	bh=hqQvTcsdaEoA9+Xh3Z8OKwCXQnyyBaKEZqGjPB6mXCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hy1fI3eEdzRHBvLuPI8GuvaJhFR/eb1lQ9Tgv6M7934AfyFJKRTDQacwAgJE2LECtm1F1EoyG0LZ3CQY9dXM1o5bTBqOIQQ1Sw98ATwkn4GYQA7Xx7in+WQe8fmWaa7MVQu+9ALq5byzuZNJAvwCzfiLZ++ug/kPMWhU16F8bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PV37QXHp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAOWAS+F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9NulOu1974403
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mYziPPcWOcBexeJkEZqaFdvsUz8rXfl8MMCLo92Ben8=; b=PV37QXHp7wM4bj/s
	grYsCL8yLpulimrPKA3ZHLQ5kbX+XRmOrSJx0tqbeXSo1pSuNt12NwlBcCeMiczp
	cnkdWG3jrAc2ThCeuGlgNSVNWyVmqvJqhHU8niuUbOYmzyLmgZWYlFMvt3kT4JBN
	FHHm8GM2Xkl5rBUBCVsz7YGp+VY+EvpW0rK1BSizfADLlfNS7v3cvFeQjaK8IzEB
	FiQFw3MRnBH3Bc1HcJ3dEpCu3yUM+GpkHeWrU9MQY/GsfZJLx5LOQM4VTmD3IVtT
	FKIJwzSdgIDYvHIZHiluTFgAPRA7w4RvFK+AFqqI6awn+peAa5yXPgpPUqTiaJve
	YsHerw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xueknm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55735710f0so4903550a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757987; x=1763362787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYziPPcWOcBexeJkEZqaFdvsUz8rXfl8MMCLo92Ben8=;
        b=KAOWAS+Fg69+H4J1F9CwNPsjRE6N4WaR2FUFIapuSZzj+c9zd9JT8v4U9RcYLIktF+
         n7qhYgTTWFIZ2KpHHGmCDL7UCvO//98jTGga6ofwT68MwDDlfuooYB6u0UyR3v3xtj50
         SAK74VIYVz6YZNGbRTqzdLJ7B9YcaxBu7T0GwP8TJpyIsKc3eRiXvxx9Md2w/vnNaPGd
         cC1nIT6Uy6xl/+LBK45gAclHOpvIjDxjKJ0VhEZ29u8kJG/1eJaDUqkQ5sRmmtDKr3p1
         raqLJMMMK9NEogStjkbEkW5ftsURFKKXTzKEiy+p/2XJ9JZVdnZuxDdY0qWkAfLXttLG
         DalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757987; x=1763362787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYziPPcWOcBexeJkEZqaFdvsUz8rXfl8MMCLo92Ben8=;
        b=D0JVkK/WzSHdfy8j3DblthZCkhzgC6wGSkoZx1k7BJ7AXv4LTP3CopL8GxKp+NG7yX
         D4EUzxFLYZxAbWIE1pIKy7mTp3wvpWGDEx2p/zMaTaiBWjcNcIJTN3DDyvztJrOf3dgo
         nu7hTqbf1/p3zuDQ57yloDU3LtACPXTfuKDkpIzNu94DPyYhc20/ocmWd5HvE7v8WdBG
         /3M92I/3ycbEhZkL34gHWlQgNJWOdvL26TZdXl9GoUAK4QZK/ROZC/NV+JvSd0In/oF8
         7q66CKfvf9EfjJeTKJahl8+SlAzp0r2XitoXFpO9WUEo7vBp3O902RUJZnBFDjXdbdkP
         xvOw==
X-Forwarded-Encrypted: i=1; AJvYcCW/OvFneFr6I5CWf6XnZKZpW+Wq4aR8Dmlw65ODxjDgpTqZ5t8BdJqothgcn7Up2j1TPpiw2RuwDdm5Z6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFrgYOYkA01tKOi91MzKUmFduolV7NVgSw9ukPhBi6UsWQkAf
	zgO8tE4112+NNg535Jhs5ta17+8qseVoC9V8Whp/8UCXr77TH1nKrlwbeFk9SrgLPtM5wVDJqqO
	/5a/QSrB1VYJybjIr7SO9XS40XwYZr+m3HEIFjYbv4Tav5cvycbkk2SwX5u11Cd+KOcI=
X-Gm-Gg: ASbGncvZA9Da41ZI14tfOJYReVjo7diuzKnH+deSLoiCHwmtWsLnsWtGJ3OQ2jN3Xkb
	81i8ItSCrTvnE5Kp0LhGbDygK5aTumAIJOeuC3rMRslaYaY+B6B1xjTGfLj0+c1BX/8fHF3nbx4
	zBMy9aXGdtPgib5+AWgyX67iyWob9eoSX3NZ5DdF9EGTnpsp0iesDNAed/P1/cZn2NEILDS47qj
	SFEuAtq0EExxV6eDUEalBnZzKL5a1m4sMbjSPLATlxIBum7blUa6a3Iy+RFlPmimBj+kJTzzhKT
	Nhjb19lhtruaYqzRMWeUjCH4QIRPXHcliJAqKtNFxPXprIW0H59WLenhlvfhTH2kqI+Djj9mkBc
	CIRd6c5cDtOF04uUTjhvalvzoTSWirrxrenMPJz5DR3PFtQ==
X-Received: by 2002:a05:6a20:7493:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-353a3c5a177mr9628306637.42.1762757986901;
        Sun, 09 Nov 2025 22:59:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3z0Nf+Q3hsU4EESDEEfUFc+DFDUPQpL2ymkKD+yZf8xXnCnqsksN0b/+02pqZtLCAHdVbgA==
X-Received: by 2002:a05:6a20:7493:b0:340:e2dc:95ae with SMTP id adf61e73a8af0-353a3c5a177mr9628273637.42.1762757986337;
        Sun, 09 Nov 2025 22:59:46 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm10565900b3a.20.2025.11.09.22.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:59:46 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 22:59:42 -0800
Subject: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762757982; l=2379;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=hqQvTcsdaEoA9+Xh3Z8OKwCXQnyyBaKEZqGjPB6mXCc=;
 b=a9TNQphv0olEWd4VZeZicZIvivZzIDMYwEDpaxxIOnLRVfiJaisq6pzmb71V78utdnylUOr5k
 l1B9B2hAcppCFWYavnsq836rkyolkarAOQc99T9xPK87VlrsLQifiEs
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfX+cFaA6YunZ0G
 vttRNbNWPe/BIy0YPKbY9O8padLfbHA8L9+eOV56UK9aG4LwGHY/QAeCfpMWAyLGfNQZ52sLelU
 K56czLNNhq/j0Zejm0FbApNKRYaqm0rfXtGUAogFor66fHS+bUPj9N76gHe9R17iz3lXv5S/Ik9
 iSWeeLFmDOy1Tr/Uh41WKb9MzJuIk6uNCbfVDdqHKXCdCFo1XwXqbT2OIQTgvGj2vVHjaJZlZOU
 rI+XlQcOgIBrUXgptq5nU3ipf7BV5pqq4x9Vyo5Z71B97FOn9dJUZOowe4VtJIbqQrN3LwLCsD+
 weI1Eh0qimeutH2XedyPK6+kIcGIoCwjW3a8EmNOxd+A/SiJ9doTs74S4K2KB6LmX9/UkqFa8lJ
 TIh3akn5IsNCqVLx09M2lm1cSqHEYA==
X-Proofpoint-GUID: 8gkIaOKupBE3iiGu-MtsdLVQ-0BDE7eY
X-Proofpoint-ORIG-GUID: 8gkIaOKupBE3iiGu-MtsdLVQ-0BDE7eY
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=69118d63 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=q7mzEFEhQNumAzJHHS8A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100059

Some platforms may not support ITS (Interrupt Translation Service) and
MBI (Message Based Interrupt), or there are not enough available empty SPI
lines for MBI, in which case the msi-map and msi-parent property will not
be provided in device tree node. For those cases, the DWC PCIe driver
defaults to using the iMSI-RX module as MSI controller. However, due to
DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
when MSI is properly configured and supported as iMSI-RX will only monitor
and intercept incoming MSI TLPs from PCIe link, but the memory write
generated by Root Port are internal system bus transactions instead of
PCIe TLPs, so they are ignored.

This leads to interrupts such as PME, AER from the Root Port not received
on the host and the users have to resort to workarounds such as passing
"pcie_pme=nomsi" cmdline parameter.

To ensure reliable interrupt handling, remove MSI and MSI-X capabilities
from Root Ports when using iMSI-RX as MSI controller, which is indicated
by has_msi_ctrl == true. This forces a fallback to INTx interrupts,
eliminating the need for manual kernel command line workarounds.

With this behavior:
- Platforms with ITS/MBI support use ITS/MBI MSI for interrupts from all
  components.
- Platforms without ITS/MBI support fall back to INTx for Root Ports and
  use iMSI-RX for other PCI devices.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..3724aa7f9b356bfba33a6515e2c62a3170aef1e9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
+	/*
+	 * If iMSI-RX module is used as the MSI controller, remove MSI and
+	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
+	 * interrupt handling.
+	 */
+	if (pp->has_msi_ctrl) {
+		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
+		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);

-- 
2.34.1


