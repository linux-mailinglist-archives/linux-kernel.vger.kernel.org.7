Return-Path: <linux-kernel+bounces-887859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE4C39413
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 071FD4FB5A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FDA2F6923;
	Thu,  6 Nov 2025 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8e8NzQK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fI0u6VHp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9892DE1E6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409631; cv=none; b=h1GeaQPoLnK3Ug+BmhsXZhdUBxSswizEyKxZ+kYDFYRz9B/IBLT1/oGgMIL46xZNtuH15LZ307BVLrl2fG3DryKvFzd/Ev/rXdXncnQySokTKfkEhVhmtYrvuo4MVUDfZVHbl8VWmQ+TN+52N13OaM6o8umHsRglnKIUYblirIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409631; c=relaxed/simple;
	bh=HT4nVZpTKboMb5Or5J5uvYygpZjM94QiOo9HruFPObM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3qpCiqR0/WtbPD+0P0RydY/L4WWnL7VhAIMiEy5dm3Fk2cuRyOrb1QNTg0kbEJNcbxAoDRNPM6WE44VoyxhC4F45TnTuuZ0eiARQpD2U1rfsXnRGu0xDBHGCUU3A4R0ptcErjVd40wyTFLSKQrlnVSorxjtj+Yy6XRhrgTYNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8e8NzQK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fI0u6VHp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66DIf01689591
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 06:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Bz+iT1VU6DH
	p66xQoSXUMGHnHJ4BKJqm5XqeWac1BUU=; b=m8e8NzQKKakKGqJjDHdtOgtO3pM
	x+Wp/kgg0tgZcAg+Crii+FPwgqatmRMDTH4ZkAZE86FWVYliTOKyUA94WsY7R7Uf
	DpT2gchyflovf1f/mDDt6JAh5Auw/CJUrwZCbWohyAy6HS45kxlZ8zTwYFJJcaLC
	njzqSuMJHMW4umEiSSL0DR7A50nked+s4EdxUzHqsxx1nmhS10wH0cFYyxsGP2IU
	TxWJJvclvJxEKh2EqnTaaDCEhTqIxdW2+pAilQ5+T1Sj2nPmQI+BJMsTCAWd8tq+
	JKzvNc09Uq5hmX09cCeUZ2oDW/RjJMwCx7bOEq+hImzkuKpXSkgncZxF1uQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88pjafnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:13:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29557f43d56so8467535ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762409629; x=1763014429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz+iT1VU6DHp66xQoSXUMGHnHJ4BKJqm5XqeWac1BUU=;
        b=fI0u6VHpwWk2yho/VsFO1tD0BmnbZ546rFsSDigV7EPbN8meSD+CM2mcbrOmdioxFL
         FokI+uai2TNyDsSf5k6EOY3KkXFQI8FwvtR4XgWwgt6lH31Uwa8/TguAqDtA9Ke3CMXr
         TKqTx53LU0aZojkz4ugU0Nkp+k7BxlkfbNU6+XDWLRykJxh0vgyqgUp92GXpDRKXRVZM
         njg44dOHP+Q4eFYg/FwJb6O8m6SYM9mgkYT3SuUrftsHQZa0RHLR44fsUOchtBgzsZWe
         BEqI0A8lcKAPaxForuVqIe1FdHLzD07zmSL8WeQkBoxdZ8Gt9HnCdxjFmn3LHS/9N6FD
         eKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409629; x=1763014429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz+iT1VU6DHp66xQoSXUMGHnHJ4BKJqm5XqeWac1BUU=;
        b=n865cmYMXl+ZqBsmPKWGgp0TsYeK90jnnSk+zdtugMI6oLRYMZz/Rkwpv2q0DqWLzx
         JgNoXtn10IugCWpUeuyqilu04kpOEUNVCX22vQ7ZMKQaYJYgJ0jFuTk/1HYpAwqMFlz6
         ieXB1CLfULn7sn9plUOmghFUbGo/70Q9QZaUQuZyaueeICYPG2BAw2flbLSdcn4zXcMZ
         YOZaD12wUkUQUE/2/DbBGmzIlJcOmV3gsiCIvIqnjAomAt+zMAEQA/HveKbyi7TZQng5
         Ob26LcdJuSudCcCJPbpAi3iOitdaQ7/Xa0291pCdo6BD+AMuUPn/wbAT+ngO2ng7lTXR
         It7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmLKoCQNgJEgSIkSISwZZhyJq/q1sxwDB3dNrZ7xavo1UGzbEKKCo3EqDL032uMDGob9bbv+FjOPnZ544=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EVMZavV5FJg6AnqI5Wb1o/UAmrDxrY7k6kB9ryFpRExTOwo3
	6CT2STmV+p/c0GUDzYoA1o+X+eeZ8lQqJ0SPjYFda13PIXY6ZbR59RNC+0LWrxKeQKleMl+93P2
	2JO9RWr2+hRHYKFi4AO+gPD54TWN+cMJQ/OLEGs26CF48D7nrcBCM+7ii/605wyc03pY=
X-Gm-Gg: ASbGncuiz4uxfjNlimmf5JU35koa+2N8Bnf0p+MJTnt6qQWwtI5hNrl0Of08RQvproC
	ijM4VepxBjyd+eTNxAxG7u1762lmSOXAF4Bi7bte3v4qZrbHd/Z1I0NN5kFMvxgjECI5IcXZtpT
	2cHoXwTcrO6N8SsKoBOW7acMyFcZf8+yiNE4CA2/nrn5910/Gh3QBUNpcNsBG//JyFbeA4LMJlN
	0rYpoIndoAsqrZ3TCEcizRgy6UAV4KLabeD55GEt+RMGRrHaex5V9/qg0Wa6REJWyc88qGJCldp
	RP/okLjhE87vvvML4GYq+ExEZyn8DXetdkTNa7IE6LHxeYMQHccYndCISHKkaDihtqlrz+yDKe3
	DyT21bnwNNZRdnO1M
X-Received: by 2002:a17:902:e88b:b0:276:d3e:6844 with SMTP id d9443c01a7336-2962ae5588cmr78077475ad.33.1762409628777;
        Wed, 05 Nov 2025 22:13:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFchEuYKBu/vaO0ZLZ+TJY4t+sNboV0WKWOxuZqochr7Tk3bduN0PaUyD9tfuSGWl7zbKBjiQ==
X-Received: by 2002:a17:902:e88b:b0:276:d3e:6844 with SMTP id d9443c01a7336-2962ae5588cmr78077195ad.33.1762409628250;
        Wed, 05 Nov 2025 22:13:48 -0800 (PST)
Received: from work.. ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm15036305ad.69.2025.11.05.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:13:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 1/3] PCI: host-common: Add an API to check for any device under the Root Ports
Date: Thu,  6 Nov 2025 11:43:24 +0530
Message-ID: <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jNf07mNonbqdPxvDkZgWFnoYO3y49mT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0OCBTYWx0ZWRfXxPiTXpVD/6ma
 EFz5m4nsUwJUNpCZJv5o2kWaPIdPdeYcrxdlUT6XaR/D/6k7LYEfDaM7KWsQjxfrV4N4pFP6pKC
 2+CLWNLrgHyiyhYJhIfuKeQGVPe94juEuJqi7tyRW2rw/NoQ0t6uuuyFa8hNgVVTM+ILS/ZukmQ
 Aheh/KYD1ErbFap65YwkuxR+a0mz6ykhyCpnyfMkoLTKon4SU31TINu5CxfglTOAMeSbzeGHiij
 fz8HOKoBMSVE0iEnVvGoxWIsqTooRi1sC0JuF6RY7Sm4lxzH7olLKc//AcZe4JSb7E5/hz0p7FQ
 CA2osU+Ty2HVGGDDI+o7deI4WJj1C7wwUxUvH+wtqHzGhr1lrq6DYZX+vz7nAUEHfQt35lk1eAZ
 9wQsUk2QAee5Zk6Kul5+qPqak3l2QA==
X-Proofpoint-ORIG-GUID: jNf07mNonbqdPxvDkZgWFnoYO3y49mT_
X-Authority-Analysis: v=2.4 cv=ZODaWH7b c=1 sm=1 tr=0 ts=690c3c9d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=X544SMn2G6euAj6E:21 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dVeha9RqDf-OwfEDNMwA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060048

Some controller drivers need to check if there is any device available
under the Root Ports. So add an API that returns 'true' if a device is
found under any of the Root Ports, 'false' otherwise.

Controller drivers can use this API for usecases like turning off the
controller resources only if there are no devices under the Root Ports,
skipping PME_Turn_Off broadcast etc...

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 810d1c8de24e..6b4f90903dc6 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -17,6 +17,27 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
+ *				any device underneath
+ * @dev: Root bus
+ *
+ * Return: true if a device is found, false otherwise
+ */
+bool pci_root_ports_have_device(struct pci_bus *root_bus)
+{
+	struct pci_bus *child;
+
+	/* Iterate over the Root Port busses and look for any device */
+	list_for_each_entry(child, &root_bus->children, node) {
+		if (list_count_nodes(&child->devices))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_root_ports_have_device);
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index 51c35ec0cf37..ff1c2ff98043 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -19,4 +19,6 @@ void pci_host_common_remove(struct platform_device *pdev);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
+
+bool pci_root_ports_have_device(struct pci_bus *root_bus);
 #endif
-- 
2.48.1


