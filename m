Return-Path: <linux-kernel+bounces-887860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73189C3941C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 523294FE64C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3CF2DF3FD;
	Thu,  6 Nov 2025 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NNFlPNMo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DthdEz89"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FD92DF12F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409640; cv=none; b=Uda1Vrfib0J1zHbWXUiJGGmJcHQUem7ff1jjSR81fcJYRlYJIKk4Y71n8uR4RS9MCCaqfQKPmIM/5Pjv0//krzatOwioT3hIRjKy3UN2d2W3xRpY0o7NZgp8bdqyJuCIW+LOjADaIACU1J/cc//rtVnVvIB9FxjRsKmqcCZoDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409640; c=relaxed/simple;
	bh=b/OstpgQdPxEZ88gQf9VC6a9dVIu7gF7ReuXlh3rFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra5T89zjkpqPUjQG3PUe29K3PPPMdaDtdSS1u8cxJGQjY3Xu2veH88VdO7EItfPmUNN53ECD0mn7X4fHlchEdoCn4LCktYnwc1Yb9aP7OdvFbtlCOK7AXfp/vOuOiU6uLvFJIZV92gD9OEyt1dDigVY/rWLJp6gj2iNK7f9hQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NNFlPNMo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DthdEz89; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KF3Fg1938893
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 06:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ekiVpYGZ4cu
	OD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=; b=NNFlPNMotHJzq/cpAt/J4osS94f
	N1QIDw/g9cy31ZSQJP23uKoPgZmeLwNibRzw17SLBhaL8VssJc0mATxSsuK/35Mt
	JyRUY9CJg4MffxCy+WII9xAMW+YgE746J5oIpJW3jdaveyOyJaNFeRRQNKlPQHBX
	Pokosgf3CGjP/Po1peRXNlkirm45B47x/YkR+CjDlvNwktcC6pmTF7vgJkxTsSlB
	ND5FsHeoYK+8/dnbOiZFok5dWm96lINwZbaxfMcIz3ifVknLklmcRJj+2kGUlzb1
	q7t3RFQ9mOy5jXkVbUFPjiMjI7U5MAjDLZg3FKo/v+k9VmwU6E57qKX9n/g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8apgsyfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:13:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-294df925293so7699965ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762409636; x=1763014436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekiVpYGZ4cuOD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=;
        b=DthdEz89yGXHjHYxaXnv1cNBryHsPngvVZuOmY89IHkysp04yN/jAzpJnegwlC+2ok
         iXR/L326I7Jq1sRLxYy/RJCfJjLAvATtCb52GhY1VznGyJeJdeR2rpSvx77x3TK1jBxy
         k9dbHgVybdO1r2ToPriOvTzEVSbaBb8s0aaHKdotuJ7suSKqrbu1NTpEtcqMI1ZsdMnX
         ARPdgYa46je8YcsmFJEGKKOHqfNshUi2oTiSENeNK1jJeDE508Cfhy3FCDpTI6xnojTv
         gSkB5dj8uMuQEWkFRzcqU2ahXa63sc2MhHkaMZsfWv39sYsdUXvnIr50G15kMnTzR8zv
         1v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409636; x=1763014436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekiVpYGZ4cuOD+sx7L1HrtYsiK1aVYOs0lLCXxJpsWQ=;
        b=PcRhffqBFa33/ohfIBRD8uTdArp95tmLnpHjYJO4vlYMXSMAnUUCX08OO2yJniXD9l
         GRidR9ejbEyXrRYBsFra0V6Fiyz+qg74/XHllO9KZskRI37Pc9WX3d0dOVwONF4RJ/gR
         w104Y4r3cwNtR3RleDxyPxR0SsdfrFpxViycXEKiDpWAkO7qLIjgYRDPeKYo8i4tI12j
         FIa8w8miH3MKl8qtf1kGRrERdUIhQbUgRGDO2CuFdXnBa1vSED3ym4YcSjCAZYi/DgSn
         USPomhDTq6By+xevxLiODrAxPZzQy9Yg4QU4ZSGJAmegBYVTvGN4HV94HfWEpzTYlc/G
         uEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSutoUPY50xcieZIQ13Ex9aCPWGzmVOvcKk17aOttq6im1hP/dhzLM5rMbP0YwCZ1gWvYFT6h+VwSExXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNxcFs3hQEwOnnPigNYNlR9I4Z8GohtzBJIR4SrlGgZBX/dii
	VAxdnmbwNxy5RTAEc1r6iXVIs6hN0KoJDJU95enWo2Cs/d5U2XBfB2LrKNDvSN2imUIbTBvlZX6
	Af8stepWyKbmCv8oQhmR8WVjyMZUG9wH0kcdhVwHlNvKO4gAaPrZhhtlodaMIOtmHeK0=
X-Gm-Gg: ASbGncu0UQZ81aEA0qCA1JPhZVP9jf2IsvmGbrE4e5ZwRyICvwdM8rMVbGmWKVQHiAZ
	NL1CC7J21Ol6x6sGjzNQKra8GJAT3pM5B5iLXQ7MYwieAxyX84Sxm2BmygQjVfl0uNvxRnd2fmN
	icGRf3wWm7OLMNM3wfFRV+ag/EKETPP/8qbklpYKgchB2cVuiuQrgk6bs6wm7lUr3zX53mZ3+eY
	0jNU/0ALp3reDx6qXZCSTLE0fthBRC9xL0Up+Kmm8R5c2ovcesW5kcmO3I5lDiZgNcvswcPkO1L
	QSPzlQf8VE9/GSQs3u9leR/gm2xsNERYmchLxq/QERFZ8vehT5Bd3hV9u1uZ67getjUUaH7s4m6
	2+eh7BZR11KU0agbi
X-Received: by 2002:a17:903:1a2f:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-2965ea8eeecmr15364435ad.17.1762409636382;
        Wed, 05 Nov 2025 22:13:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd+XJvpr5YFw1E4aixknmuqd76EwZo1ROcav4B5CeitIgUuDOOUVEABQbOKyCFB2odzUE9oQ==
X-Received: by 2002:a17:903:1a2f:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-2965ea8eeecmr15364115ad.17.1762409635918;
        Wed, 05 Nov 2025 22:13:55 -0800 (PST)
Received: from work.. ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm15036305ad.69.2025.11.05.22.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:13:55 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 2/3] PCI: qcom: Check for the presence of a device instead of Link up during suspend
Date: Thu,  6 Nov 2025 11:43:25 +0530
Message-ID: <20251106061326.8241-3-manivannan.sadhasivam@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0OCBTYWx0ZWRfX4wvlH0oyHBwT
 up7cGVBTSgJd8P4jmQLhziSkJnCcdFFIiVxaj5WJDTbAnu6sv2hqbfPZ97WGtukBMgRbMIjxCFy
 B1ZT/3ifMhwSkEIxZ7/hcFJkz1NSaq6/8uEtqwvuu9V0eaImjQgLhKh+1i7NcFEvuiS0Bp604j7
 mgJ5jARhotqVB/7kdQLXttR1nm74IwvVBTZ7nQehJaRjnHHjFMHNzKFPuHRk1KPNO9DmpJk2aHM
 OExSDoxay+8HarbvVSmqCtZjRkNfk9KY0/RSx9Pi2no3DIEUUYLDWMlmI1ZSV5Uh/4+DUr0DjIe
 03VD+tV25WZxdC3quDQy1WzzoF85dyL0uCBSwLdqzZZJHxeA00AwpwPSkpv/x/JIiNKolcXLCB/
 EYXaKOWJ/NU3nPWB5JhLmpoxEYWM5A==
X-Authority-Analysis: v=2.4 cv=LoCfC3dc c=1 sm=1 tr=0 ts=690c3ca5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=pvCTKC4ah8od1FUW:21 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=J0DKTq5R2LgoJC8wmisA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: UEhjJNHLMcw1FD1BRgkNI7jUs1rD7jUK
X-Proofpoint-ORIG-GUID: UEhjJNHLMcw1FD1BRgkNI7jUs1rD7jUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060048

The suspend handler checks for the PCIe Link up to decide when to turn off
the controller resources. But this check is racy as the PCIe Link can go
down just after this check.

So use the newly introduced API, pci_root_ports_have_device() that checks
for the presence of a device under any of the Root Ports to replace the
Link up check.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eb..b2b89e2e4916 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2018,6 +2018,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie;
+	struct dw_pcie_rp *pp;
 	int ret = 0;
 
 	pcie = dev_get_drvdata(dev);
@@ -2053,8 +2054,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 * powerdown state. This will affect the lifetime of the storage devices
 	 * like NVMe.
 	 */
-	if (!dw_pcie_link_up(pcie->pci)) {
-		qcom_pcie_host_deinit(&pcie->pci->pp);
+	pp = &pcie->pci->pp;
+	if (!pci_root_ports_have_device(pp->bridge->bus)) {
+		qcom_pcie_host_deinit(pp);
 		pcie->suspended = true;
 	}
 
-- 
2.48.1


