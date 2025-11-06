Return-Path: <linux-kernel+bounces-887855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E4C393BB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF231A22F76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B62ECD1B;
	Thu,  6 Nov 2025 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fv7C8IWK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KX+i5+PW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285B2E6CB2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409621; cv=none; b=VjYa1nzhAl/M9gyl5bTY6chJq1aqTFpNfbPqihBWY25tnPCC8aorJSDTVL5wn2I6g9Td9YtcYhJ1eU5lIujaeNMS+n/LSNQMUqWlCYYpsZ8KvbJutalOXIsupnnOhI9OppdlYi/my2LcOZTQV+8O4amCTBvL1q/mADtlNXApIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409621; c=relaxed/simple;
	bh=DYLwHmGdJ3coXsTh0PPuy3fj9KL/zT5BoMmCnNKTDA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bf/25OFxDP0WSy2+KdyscCvoCt/Flfb2AQGz3uMLOfxCHS+rkeyvdd+1mxw3B55TyCfC6AWbY2Y5ocijlCtzSJOQksaHKnPTqW7dFNSKsPKBo5DCjAchF+UgLa5dMrLdIdD8i8vsy40C9zGSaTrgSkCB9QmaIG8R5nKbp9SyQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fv7C8IWK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KX+i5+PW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KEiiG1938348
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 06:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hP3iVDjjm1Yh6lCxDh4PcKbNlm1B6eEBTsx
	Er8EUr5Q=; b=Fv7C8IWKKNTfWD7DUqKuBJ+G1XHzrQsl8QL66j8W33JsZeKpXbv
	mghddo2CKE6qqCG8WQJBcnbhWx1jIGXRVIyvzdo7avGzE1nd57wdSVhh5KX74nXp
	uuJI43H3JRk57ZNKCQitR/EBvV995sX1jZxrpcBi0GFlFfX+luCmHQ5s4ulSn9Ce
	HAFCOdHYk0KdbA/I6pKeBVAld1piRNotcrHKa4t5EFwsE/tpt0/6/G12v0iX4OTY
	nDtaEVmp3I57fv70WGzzeB+VXW+0+iDDqvidA/9mTB6D4040y6AKfDkGtsSfMIxA
	tt1G3d7FzGDGKuuFcSUpW1Du9Zk8ppKUVvg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8apgsyf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:13:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2904e9e0ef9so2137345ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762409617; x=1763014417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hP3iVDjjm1Yh6lCxDh4PcKbNlm1B6eEBTsxEr8EUr5Q=;
        b=KX+i5+PWDpuGUK2kPeug8ovB6GiGRWmeKstEETsvrwNBiR5FBAKBTtLauf6jeyovTG
         DjWo9aJDxoiyBpKEe1+4LJvifYtplqa0MchZPon4iSRSbOmDZgTlffutROfcP4BcY+q4
         L8UEYNd8fXbKNRBp1fV4kd+BJ7wUKTJhIRAiUE8NZ2TPV7DtKe5RG9/sqEwqv3pCn5m1
         KODCOVrdbMMzXqL/XWr6UpUep1yC/UHRwyXZu9bPnXJxnzRC1FAuGYF9FnaP5oQdRuXV
         gltp6rGS61QZBlXGg+qAinm+6PwoKaCNhSkESDxKuOWqv+ngk7CM/WSpBnMVnwbI96VW
         fyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409617; x=1763014417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hP3iVDjjm1Yh6lCxDh4PcKbNlm1B6eEBTsxEr8EUr5Q=;
        b=CcD7sSjo7zKZPnXPckVREC4WYlHUXkS4GjVMucz/a9Vj/ZZ4PVeeUCHdc0I3ngMmqM
         l/Z3StQYdNPYRxWffNei8tex68tHhfVqsn1lI0F7X8q5csxvcPNVWl6jX/sN0dZHJ1nQ
         0hP6uo8lwAmVvaBchoW4Hr5UVqnyw1YUfLu8AUc9DEpgQqH7Dx66OysNKlap6wg/abN2
         KqL2GocLpPAw8ip5NOjQxdEXbFQHQgRIKKLzCNdGYa07X2QUAYC0E6YXCPQFjMQP2vM2
         /4nxtaT46XU45B4y1t+aTvS7/pDIZqrGTUE9TSniUFQg0Abqm499NQO3I2P3jA9uuARt
         RARQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwswT5h9uNm+8A+hy/A51qraBqP3S5bloKz22Ef91yfSeBFJS3kRDtC7cBgO6uiTejQ6HOkNp8Zr2QE7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfG+TyTLUdKB4Q3HYz2ipJ0X0dOu/OnJ+BrebnWw6nvhDuCNu
	w+e1LqEyQsNcx6fH7DSKHI5WRvwi6B+fue98VD2TwmVWTE60ip9xGRjs5ttr/le31geT8XAmZtj
	CzlT0qJJ4W+PbRTlk8wMd4/JWf+YmjMeKhjeKV0PdsL0KU/X/NwiEcP/cwCwN3zmAb1Y=
X-Gm-Gg: ASbGncvfrmmCvsjLcPYPS0ofAb7YBCl0sKtrbaoV0Jsx0a6Rg1ToADt6dophrJymOZm
	rx5ap73iGcC1CFEAqWh7GNZgkdA1orhr8gT7ABHhBHhnLug90kr7+/l3ohR9NcG7l32o+cpJVKa
	rj1pv9znV7OdYQXDoVZqXc6Rkg6Y+MmZPQMlejzUiSF2tG4vPeX0mw3yCegc0OrbC56ylam51eY
	LT9n9iOA2rATCRlfNL2Xh2UPr/iW18AfvgrE34sfWio1WZ6wtXpV5Pi+hxPbdRSmBJ2YwDco7tP
	eTR9pJs7zm2xmhPV/p5ZUFGfpiK7Ny7ZrFung9rZmmb0gG1rUWSlZE64qjZR/k4JcZH73OwMvWH
	rMuXr2AGRjvUwtT8o
X-Received: by 2002:a17:903:2a84:b0:295:4d50:aaab with SMTP id d9443c01a7336-2962ad21137mr94077495ad.20.1762409616895;
        Wed, 05 Nov 2025 22:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEewmaTtY8AK26J3oyoLch8DjGfmDdZM/mLVA1EXvkwehtfnOLT0872UXtmqd16alDYM/BoXA==
X-Received: by 2002:a17:903:2a84:b0:295:4d50:aaab with SMTP id d9443c01a7336-2962ad21137mr94077055ad.20.1762409616339;
        Wed, 05 Nov 2025 22:13:36 -0800 (PST)
Received: from work.. ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm15036305ad.69.2025.11.05.22.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:13:35 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/3] PCI: dwc: Replace Link up check with device presence in suspend path
Date: Thu,  6 Nov 2025 11:43:23 +0530
Message-ID: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0OCBTYWx0ZWRfXyM97S+m3rrTq
 RYInmKunof+UdbGnqt4pF2lmI3d+JP4Sd8I+GVVF6A1HzB+yeXko+9sUK2vfaHEcjH14+rhG9Ph
 uATALh21TpC8hKFUC/IOiriUhCWbKnpgb+OH5VZzfUDpaXALDkLh/WVAipdpJv6wiIcE8Be2hGL
 r/ro/5nKrf8lnTNMZ+RNOYJhIA+uCL/TlWZGP4UVHpJLqTLJVbDJNrusNzeuQktuVAYQypOywog
 4IZZ8Xg2dUC9mRgGUkC7kTnoJoDNK7IpAJ0tOeCBEwCCvmNn2j+EeZeahzx/vfuSp1w4E1VBBKk
 dK2CS530unC0IqCSBudu7DslzgJvRy/2PiarhrFsOuq6bhvUlwRf/qJ1zeMIdikM0b8zNNovJG+
 z2ez3qNj1xxRStx0cLUDEq41dGsvfg==
X-Authority-Analysis: v=2.4 cv=LoCfC3dc c=1 sm=1 tr=0 ts=690c3c91 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=h4SL0BZ7AAAA:8 a=nOfjJzbYKU6Ixk5oWvAA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=Cfupvnr7wbb3QRzVG_cV:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: fETVCDwe01AmtUjV1qMINqZKzbSksouO
X-Proofpoint-ORIG-GUID: fETVCDwe01AmtUjV1qMINqZKzbSksouO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060048

Hi,

This series aims to fix the usage of dw_pcie_link_up() API to check for Link up
during system suspend. The motivation for this series comes from recent
discussions [1] [2], where developers wanted to skip PME_Turn_Off broadcast in
dw_pcie_suspend_noirq() API when devices are not attached to the bus. They ended
up using dw_pcie_link_up() to check for the device presence due to the bad
example in the pcie-qcom driver which does the same. The usage of
dw_pcie_link_up() API here would be racy as the link can go down at any time
after the check.

So to properly check for the device presence, this series introduces an API, 
pci_root_ports_have_device(), that accepts the Root bus pointer and checks for
the presence of a device under any of the Root Ports. This API is used to
replace the dw_pcie_link_up() check in suspend path of pcie-qcom driver and also
used to skip the PME_Turn_Off brodcast message in dwc_pcie_suspend_noirq() API.

Testing
=======

This series is tested on Qualcomm Lenovo Thinkpad T14s and observed no
functional change during the system suspend path.

- Mani

[1] https://lore.kernel.org/linux-pci/CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com/
[2] https://lore.kernel.org/linux-pci/27516921.17f2.1997bb2a498.Coremail.zhangsenchuan@eswincomputing.com/

Manivannan Sadhasivam (3):
  PCI: host-common: Add an API to check for any device under the Root
    Ports
  PCI: qcom: Check for the presence of a device instead of Link up
    during suspend
  PCI: dwc: Skip PME_Turn_Off and L2/L3 transition if no device is
    available

 .../pci/controller/dwc/pcie-designware-host.c |  5 +++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  6 ++++--
 drivers/pci/controller/pci-host-common.c      | 21 +++++++++++++++++++
 drivers/pci/controller/pci-host-common.h      |  2 ++
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.48.1


