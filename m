Return-Path: <linux-kernel+bounces-875897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D886AC1A097
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA13580A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861733B971;
	Wed, 29 Oct 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ColIfwkE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juQobNij"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791033A036
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737441; cv=none; b=RGdOX/nxt633kmPLzkKfN2EQmUAlwRxPRDXfT/Rqph8tvTaCmMX8WQebVsJQwFLCmomaaJqtBctjMb77K0FkYTAjcdFZXpxdf+nsdQ1UF/u2MP8xmYOkFQODIfpw2lT5cQbLZ25mWXHZGHPIQG7Doc32Aw/AKDFhl8t0w7Z3Jdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737441; c=relaxed/simple;
	bh=9K/ld67bZDtw+m6f/+xoehEOm9YcU7EXoGsXpXOCEkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYXFB1DAAL7esn230LqGtcsi1wjRf3aAdbOC5pWEjCun3R+UPzLkaB0jt7CsqPM9NBZKgh2LmjLOojrOD4t3n7D0kCj0XAeZvoSKHZuPTvdmdNuoSq2BjJcNv2aptanUeBKQAhukLJE+bqedHGn1Yv7tDLgy1OrJaXHuBfsvcLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ColIfwkE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=juQobNij; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uxpB3663636
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wCTZOwr2cUSKWpV7LwGZiQjZBqN6lrfiwX+kWZQGXyc=; b=ColIfwkEu2Q+1Ppd
	FG6fABGdw9Cnbcr1yp5VTedz9cJHeTwjj+mABN+Y0zUEJ0iwQoqfAxjDV3bZ0Q8H
	n07IpwGw+mv/Dy6nwT6vhxw7qa5lkWmUfup5FUxjkR/Ew96DVc6jsm17iitG2ab2
	ZoxE9c1HoeRIZeiH/vTDve3ewFROHSg1twNvQ71ivDuWWmB/u8mwFEwCbmhOfWbm
	yNrT9hPod4sdJQUEN/MHEdfWbsUkqpURJPNrHLQbNxcV1OMoZgWLaOmY4yJrPFen
	46nrMQF/D2q/VrNEnAMcChraolbHd4oiBKkZ6FvbaV0sIC5weFpJokX5C76EtX0e
	jEUp8w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1ta9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:30:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27356178876so44777285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737438; x=1762342238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCTZOwr2cUSKWpV7LwGZiQjZBqN6lrfiwX+kWZQGXyc=;
        b=juQobNij127sRiPCsST6eHfsA6s5n3gesKPfdpUkqXJf/hyAzTe93cZAvJiGYBOoiU
         UdFb2KItna4pg18D/v5nudcG4aU81hJ1AinmipaWA4C1INdWF42QV+pWv5DOAOW6zn2X
         5oqy63jAeeDuCYBp13ykSdSWEAo33iySob+z4k8spJGZBWfPw5DmP2BKf9xVKoTF4070
         E0E629CT8Y7lN9j51OtA4nOyKSEvVJuAw+MRPp4Nq3zL9AwF/Ljz57m02Uy5EdHBplYr
         L07EZgCUpGrJlhe49GZi++cRbGUAdNFmu/hKfeOTXQUF79/L/JTAEfWbkS+rJb3h6gOI
         KzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737438; x=1762342238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCTZOwr2cUSKWpV7LwGZiQjZBqN6lrfiwX+kWZQGXyc=;
        b=ihQE7HkJiwn8z9TLGvokzXs5S3g3V/206icu0Tj0U728mOXGeFT/Vf06yE8geoAqqa
         TeerDWbTVy/1S1/8dnc8cR2S/oNBtVt6TJUfu3qCq5HfFcYM/AmRtATw0wFkNBx/RCWb
         a8rjOpygiUNG3UmsY9MQPP+jmJdBcpc7uOvzkt5UdfWvkY3K3V63zvTsuq+HslhzeoHC
         AewglrJ2D3LV+lJFGWZPFlNJJmmpyEKOyLmjohEz9SGPyCNPJ2KtRjiMjQimjwOE81Ja
         rHKyj5mKTNTLVWkowmwx41IQdt5VFzqx7uImZfAf5UwUHLxjFiRSdJMns7Km3Z3jo3+A
         erpA==
X-Forwarded-Encrypted: i=1; AJvYcCXTTBucMATKzLMdXASHKaGg6MHgcYuZeSLfb2wO3p06Ak0gP1jTWvoJKj81p3+iRvYz8gCXgIxj6jKon0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/Q+O4hLedN0JfLGESpkgCAT4sM3oylCKI4CfQeZj9xd4Zza6
	FEuJQPFGgTgOH+2Zj0Q1mttZ9bjaXy4bhZtVyOcieU/JRuFjYSUmhN6eA6i/JhsKiDGRNIAZEcv
	78tvxUcK6v0TTKl124bTLyobwDcMbtRvbOg5qggMZH3Frg6wWL3aoxT++OunLPBAjPlw=
X-Gm-Gg: ASbGnctcrw3IgkOrsNx5fCYEOz+AFg4YFSqmOHMCpp8OUTEdcYSjCnj9h0+mWsQlYMR
	8pISjdPKRNbUGvTB075r4DzoZKBvEwZdng4HIu61dexV1qYAq9bUpW09MWqb8GMEgxYVE6qQDkZ
	Hh0YI0i7HMmmIOP4ZLPJVoKU1rTBKYrL9pjBJrE7h0/jk30btgEUxTh0Y3DMBuEs82u2TfIlrY1
	Q2bGefaY+w9IOaJ0TrexSz9fW/wxWEfadPHmQ9TglS85CvHCOHzowlu6tFg9BPd15Rzw9vBefyl
	nHDCx/D5fAK8rmqVUzLd9HlvqKJMJ/WWD1crIfNzRQ2sD8jhw65cbhAt3V2UcYreNHPsmdohMPq
	vX5hrGrgCPsxggwennhCrH0TWhvS7zKcY1g==
X-Received: by 2002:a17:902:f610:b0:24c:965a:f94d with SMTP id d9443c01a7336-294deee4d1cmr30235915ad.46.1761737437723;
        Wed, 29 Oct 2025 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg2rhwEuCCYf5gyZ7/UlduGCKTgH7m45SVj3izWoOaQv88Us2VqzTA5ZMHvZHROpfGtq7z4g==
X-Received: by 2002:a17:902:f610:b0:24c:965a:f94d with SMTP id d9443c01a7336-294deee4d1cmr30235485ad.46.1761737437104;
        Wed, 29 Oct 2025 04:30:37 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:59:58 +0530
Subject: [PATCH v7 5/8] PCI: dwc: Implement .assert_perst() hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qps615_v4_1-v7-5-68426de5844a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=1708;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=9K/ld67bZDtw+m6f/+xoehEOm9YcU7EXoGsXpXOCEkU=;
 b=uB04FAqsEwXevtvjMHJajgLBMhaKPIHodRX+Jhi5X2SfE/FVlaqw6ySrvVsTLK8jD1Rh0zXwM
 RgGanaEuvGzBBOAzrGtaAdjqhaIFOmK8zscP3MLvhou+4+VPNTNMsy4
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 5vUKSMJWvu9Q3_j-5D5RTqna-M3sVHRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfX7aSUR64mex+P
 ZID2LHN4iFXdRVb8giyBN4Xxnd0ugI/LQqHDH/D35ICsDSRoDa4mMRshLuC+vDbXtqrIXwQWEg9
 5LO5Wzc8VfiD+gfz6Ai4GJ+8o/kGe88PvXrS23DfX+MjugqrmRzVF78E0L7Grtxo6MvUfN4n6Ff
 chRg2hdh6Gdoz3sioJPupRp+UNPKyJu/5mEsL2zLCss4Y9QxIEIUvESaSFclNgXkmVWevWUzrrH
 TkFwvP/vzmIh3hXq29IaSxP844juASurXfGR0LLG+X8FMY68Q+HmTsiWa7nTRpvXzDpMUSxWbB7
 gZ+/PVoYH2j6+lov8frPRuxZmE5sFfN7x8N8LyDhuoGmHGccEtoYaK4xUePE3KqnpEtyPqjGf4N
 eX0NTfecs/YcCkKdAL4vKL4MlwP5XA==
X-Proofpoint-ORIG-GUID: 5vUKSMJWvu9Q3_j-5D5RTqna-M3sVHRY
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901fade cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dSOQ3hK3KXaY1HoqDbQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290085

Implement assert_perst() function op for dwc drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda51bde3a7157033ddbd73afa370d78..a209701e8037039191fb6c61b83978d8f561f7a7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -856,16 +856,35 @@ static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, unsigned int
 	return pci->dbi_base + where;
 }
 
+static int dw_pcie_op_assert_perst(struct pci_bus *bus, bool assert)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_assert_perst(pci, assert);
+}
+
+static int dw_pcie_ecam_op_assert_perst(struct pci_bus *bus, bool assert)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct dw_pcie_rp *pp = cfg->priv;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_assert_perst(pci, assert);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.assert_perst = dw_pcie_op_assert_perst,
 };
 
 static struct pci_ops dw_pcie_ecam_ops = {
 	.map_bus = dw_pcie_ecam_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.assert_perst = dw_pcie_ecam_op_assert_perst,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

-- 
2.34.1


