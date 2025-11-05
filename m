Return-Path: <linux-kernel+bounces-886128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E873C34CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E831892F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514C2FBE0F;
	Wed,  5 Nov 2025 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l6S85Saq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFT6inZa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A72FD7CF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334197; cv=none; b=b8YooCEldJy3gQ+lKGoZVyvDQuolxW5cjQabd3AbHKaxMj0fXHyagPpMLIbAIWlWrMiwRIjL9cn1gqguhpWSFhkjH89gCSYFlDt26p9Jw1GjDWlwm9oMRrKLBM0GUGQz6MG2wXSpI7qOg9dJZx4zZBtaWHNT6zKSrsiM8rz9Rhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334197; c=relaxed/simple;
	bh=G5qLkPbiy5mAe0CS1JhXvG0iaH8m8lqZJ9LVnFx7vuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gkvt+ruOyigoI2qqIoMDJ4kPD6TT9PJr9gFjCF2ChJO/jF+7pNScWPmyc9eQSSt8CVCSn79XNWdfJjFVxyjHh0aGNJTR1BcBZ3dJscHGeACuhOcy5OefMcTkdEOTTl7qZjDrPDtX/+WVgiS4fAzkX+PK9pzGDT/FiZXit6QKhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l6S85Saq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFT6inZa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58U0aZ3165295
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 09:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sFARRt9q9VyojgpMQL1RCl
	I6kbqGYcPQtji5bXwNoNM=; b=l6S85SaqYiZwBhH8cAVJCI+RuVdBw65528FU39
	tKh+ghK5bEuPts43nPW9p/x/1XY0cOVXWcBOoMdDAoM/iySUq0v/Igi+hYVhNyE1
	P90D9t150gMf3/EfV9d3A8TAODZFvrIvRz3iuIFfBx+sae/JHoOJMT54emj99ZlZ
	0xId0eLSlm3WlXNTMaqlbabyo2LiSBGV01UIdoBLSI3Ab9pf1Wdab2o//3YhuXGz
	wStqrv2ZzH+ZUhu01REZ0Mtj9viAdof2Dp/M0wdJa8phCwz/jtpm9qb/E2X+Ofzm
	ZdIeOZTAwbA6zRG8OwzyFkQtmPR5WOL2gov/v0Vguh8dCWjg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ketk22m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:16:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340be2e9c4bso3774983a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334192; x=1762938992; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFARRt9q9VyojgpMQL1RClI6kbqGYcPQtji5bXwNoNM=;
        b=UFT6inZa+BKOJzHe3lPjtshn7yZp8BwhYeBacxzZKWE9vs/ZinVEyWITMpYiBWD7eK
         hnoTEGW+zUAthRDjIoXOpspOCliJq+/cC0vKSRz33/SxhjZdbGhrsrNKxUxn0yjbAzSY
         v/LJQ611+FecIakwba5BD+nTisMrX2xemwXsMtKSN2ZZtH2XbwrRTOw2ng8tt8MVszlf
         s4E892PduQ6fm52VnGnYjg/lbvTQMT+YHOoYSrkw2oaF/U5u90JMpyJ6ApxA4MKj+P7+
         EbqV4ZgmLCOOLS8V8rG74A15czbaQfIvw3nREq5tpdP7xspmlqgGLx6BW1hTUC1+dghL
         VCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334192; x=1762938992;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFARRt9q9VyojgpMQL1RClI6kbqGYcPQtji5bXwNoNM=;
        b=k/JJh6t2Xh3HX6cpCCDkVEecB1ylmFwtQbzzjR2rerecNtvwYLcDB//5tdrA/HdeXN
         hQ5RqFNGlXJZLsu2ciMbCWYFSey0Z2p1vR+RYJeN7NNDs6bVs3m9RUhE5EPc2mM/fOcr
         ss6nQzqbNMnsbe4isDxPmAAQ4l4oDgqLtxeO35F9BLuG4dxATA7xMUfEVHzlo1lZUh5X
         8yTZowrEJ10jr3LRjWBl7isRoaA3GnKHCoxkrko4vLPwxTJPRuiXiiGhRBRKCFn6jPWI
         VTrM8Re3Q+BPp+9DN/CDodx0KLU+tPgER0sdDc2eKWjlor2StUlhjIghDhJhG1j20u7e
         U02A==
X-Gm-Message-State: AOJu0YyPT1Y8agU3kJqtukbPv92ji39ItTD+kKMqX5NOectmRXIxbH8o
	1+khvxsmQLiyaCvA4TEv7uYuuL73r2p3VJN+j45UfS5FNB83betRJmDnd2uXrUYWFbDmgf/e+tx
	heRblS0CWbVCipE4MkMyn6Fnio49wXz/WZi/r46uF2SJ9hiZYAdqG/j3Er5/iHk1d1oI=
X-Gm-Gg: ASbGncszTbzyb13BVbCMRGJ1Yoj5oDT6Hsd+KfHbr6uRg24bF56wkH5B5x8lZFCLxlP
	SVeBKGcpW1Q8vSZphPUxB/3kGhjgPtUwKrJTFNcO0KhhW6PrAy63E1tCSycdZzClRq0A6VQCoO1
	oYYNT/8zgsUCNDfE4grHqDo3qTDBj5XvpsV5xwFY5GawfWiD6sfVVJ1qndOgLfEZ2/NWbguym1w
	gxC49/HuOL1SYy72narc6rWsPRwR1FJWS1OcVsTJ8NGem09QGKIouAGXcJ7t1FHHfMd2daAlCU4
	59/W47jB9BP9VhVHEkw7x+fXUEhdw0g0IOUT0sj0sNZhVh5BzNHnfhPxOyU1RrF59FGuJjRjb0m
	IlHpuE3G2HN/FQXFY2SH91mBJZXkG
X-Received: by 2002:a17:90b:1f88:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-341a6c4d7aamr2891965a91.14.1762334192438;
        Wed, 05 Nov 2025 01:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFxgs1fikzPsn/Uzt2XJnjpiZb5nexbrA/xinXkHzp1PjfMUCh8IEA/nDWZDho9364Lklw3w==
X-Received: by 2002:a17:90b:1f88:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-341a6c4d7aamr2891925a91.14.1762334191932;
        Wed, 05 Nov 2025 01:16:31 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417a385563sm2274249a91.0.2025.11.05.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:16:31 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/4] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Date: Wed, 05 Nov 2025 14:45:48 +0530
Message-Id: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQVC2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNj3YLkTN1cI11zM2NjM2PDJLO0xEQloOKCotS0zAqwQdGxtbUALbp
 yFlgAAAA=
X-Change-ID: 20251103-pci-m2-7633631b6faa
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3343;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=G5qLkPbiy5mAe0CS1JhXvG0iaH8m8lqZJ9LVnFx7vuQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpCxXoDdyGhLtN9uKCzqzSqHPnH2YoTYU4IrxY1
 Ve++Gmb5UOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQsV6AAKCRBVnxHm/pHO
 9beJB/oCjStqQkgyMExHRzWblMIVQmQUCcrOHhmFhFh4gQMU6s70nszG6SRwPwawERB6MI5FcKL
 uUrIOacvZHgjirXX3mItamztaSmiC+qKWmrm0w5ReBlXTpA0H7Nub38DEI6L5hUeNKlN+5SLO+7
 dpPd9E2Rq1V399rHZZJcyqn3qqtQUbMd/nk1uPzKRpQGL0h01ateAHj6q1dirRL8kXY1d7b/pqX
 Ib3piaYcYQBeU7QgIK8YIRMcdrwzpYaLyjx/1jkXGdHdInFEMAP98dXcSWOhpyt9kS1U8pdpPuw
 GywqFZWfsxLaJrdpEqGXHJQy6ttj95C973WGiVUDVoWuPNyB
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OCBTYWx0ZWRfX3mSI7xl/gXo9
 N+KE6xu73wvGvhtmuGSbmD3QgJV1SaChpP+138iC2SCS2BIIarstX6Tc09+tbCy1ufTSxPfUY09
 NyK5b6aA6/OuTQ83xnttBEoQzkdPyWLzalLaztfj9inCveWVvSBpr49JAuWr3BOrMlJ4H/CDURa
 Q2QOv+Nlwz6Hga/OcJMVtpvyxbSAPrZu53HX41IbDa0cRjRrYOPcsUsigyKM6m7HmFtjbML7E0H
 Kuwwub4IPGTbnsJ1iPhj2QDEx+TPMI4pab7Jw1lrSLO8JNy+onbIDvHoCZKUAbuO9FXlturBRdr
 rKUhfl9eOs6CT8vqDDDWuPADKS5Txxa1nlcqbkpWsS0q8I+Vda8s4yI41k2acNzh6rozllJvT3T
 3+ARtT/+pqyElcYgWy06gd43yp5hVQ==
X-Proofpoint-GUID: 9CRwn2gf2j-Bts_fIObapF3LD51V5EZj
X-Authority-Analysis: v=2.4 cv=IdSKmGqa c=1 sm=1 tr=0 ts=690b15f1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=adoi+G5QptZiRYWGMQz2cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=YBl5744q8zTd1FMgO4cA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: 9CRwn2gf2j-Bts_fIObapF3LD51V5EZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050068

Hi,

This series is an initial attempt to support the PCIe M.2 connectors in the
kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
in PCs). On the ACPI platforms, power to these connectors are mostly handled by
the firmware/BIOS and the kernel never bothered to directly power manage them as
like other PCIe connectors. But on the devicetree platforms, the kernel needs to
power manage these connectors with the help of the devicetree description. But
so far, there is no proper representation of the M.2 connectors in devicetree
binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
and fixed regulators in devicetree.

So to properly support the M.2 connectors in devicetree platforms, this series
introduces the devicetree binding for Mechanical Key M connector as an example
and also the corresponding pwrseq driver and PCI changes in kernel to driver the
connector.

The Mechanical Key M connector is used to connect SSDs to the host machine over
PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
support for driving the PCIe interface of the connector in the kernel.

Also, the optional interfaces supported by the Key M connectors are not
supported in the driver and left for the future enhancements.

Future work
===========

I'm planning to submit the follow-up series to add support for the Mechanical
Key A connector for connecting the WiFI/BT cards, once some initial review
happens on this series.

Testing
=======

This series, together with the devicetree changes [2] [3] were tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
over PCIe.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
[2] https://github.com/Mani-Sadhasivam/linux/commit/8f1d17c01a0d607a36e19c6d9f7fc877226ba315
[3] https://github.com/Mani-Sadhasivam/linux/commit/0b1f14a18db2a04046ad6af40e94984166c78fbc

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (4):
      dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      PCI/pwrctrl: Add support for handling PCIe M.2 connectors
      PCI/pwrctrl: Create pwrctrl device if the graph port is found
      power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors

 .../bindings/connector/pcie-m2-m-connector.yaml    | 121 ++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 drivers/pci/probe.c                                |   3 +-
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/slot.c                         |  35 +++++-
 drivers/power/sequencing/Kconfig                   |   8 ++
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 138 +++++++++++++++++++++
 8 files changed, 308 insertions(+), 6 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251103-pci-m2-7633631b6faa

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


