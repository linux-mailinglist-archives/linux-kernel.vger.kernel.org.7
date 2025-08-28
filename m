Return-Path: <linux-kernel+bounces-789907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8565B39C72
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E8236429F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79273112B2;
	Thu, 28 Aug 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7dE6MV3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9331062E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383027; cv=none; b=tJ9aazyJ2ZWODZ97x3Z4lt6sJqn6LmkK2Xl6U94K7XMtIxAL17X7T6L5ZjO9FcRTniQtnoS9aBacjkfSs+rlpDkGt2oZPhXp0T2RqIdsqs4FsfBLD3KVSSyN4Jj2ns7NlHEs1zkdhk5m/11rspI2XMSBqdRLSvxUDt8CyooJivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383027; c=relaxed/simple;
	bh=ocglQCinQJSbwG+WjNdC7ufk+jP1Ksb5I3ifJFa2Wm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ir66UEIfpj5+xNcY4KgJSLCvC2WPb3vVFutkE0TiKO7Y2cGwSgPzeVVChkUXVgGAe5bOb+Q5m4X2R3EmpzdaILrExvu2oNtudaZeTbkDX1b2BTX88d+jfnkgUcCuOtFqM5YH1YVT2H3lq7ajG6i/V8d716Y4G9rvSh0w3KPiSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7dE6MV3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5h0ai015908
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uo/dTPnL3NKP/2wFJT7E7eWnhiOWnpWY1KrKMQaPEls=; b=g7dE6MV3ggoTZjY4
	MsDh3VF0FWkOIk41LyGUXRSu48mwdp4XieP/6Siw/kdIratYOLs4EP56Pd9QjriY
	hNqGG6zsVmk49YVNe8S8Gyyk/DPKik3mLqCilEldvQzX4ZFDmvKPmFGS+7Jut0es
	QghJoUyG2G0zg8tI+plC0TeclshKizbqWeAcWFYEGgWm9pTSgStX4JMw638zAJeW
	fAsPMqwbc+sge+QG61sSjxTUvS3MKikqepI0qf0cUNF6ipIaH4HmJmPNk5+ZEKfp
	u3+0hr2aWANn1ibgo6b46diy7uKtYQ8ojEtMlvkITiid/lSDaN/pStlC3U1hQo1+
	vk4YcQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpf2ds5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:10:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-327706e0642so1596865a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383024; x=1756987824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uo/dTPnL3NKP/2wFJT7E7eWnhiOWnpWY1KrKMQaPEls=;
        b=CnJIm3w6qz4Vbn+erV5BDfyLWV9Bs6zut/DiqpMffE/h0AWsmMlnWYPDmIe2vV+4dA
         3qlBzD3CLa67lZocJBPFerhhR+cvSHrG6Uy6WKt0mc6uV4XYm39uZx+sAN13aMncT9mL
         SbUKY0M+gzT0X3+K17uwzj1pFX9yqEbjHuiJ0G4NC0EpHL9VbotB41vVAZh+WKj+C4dJ
         D6ny4n+LpP6p2Hv4axEwm3lPEFh4G+9LoQSD0uMwXPaKFlkqvBcfduKcBe95r0VFgTv3
         rt7+UeI9KqIPIv9lz2hUUehwnJR6laljAQCi4tp5u1Pdc5a3LKRDt6BNsePnaflHskL2
         uAoA==
X-Forwarded-Encrypted: i=1; AJvYcCVKVhwGy3jejQJ2Gw+fWP5XHMaUum8byX5qGPe7qbK8EFUfohFaCZaHF5fNdHkQxbEx0BZyzATn8IbUz/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRtT/m4KcZpwDPjC8ZzOaIwlseMutZiKTQhUBc+IPmLLrDTJE
	jYAsBYyl5HhA7ygRX6QR/2WOlMXIg/ImNPeyjUsQg8MnvXZVwmNYJcZT78uthdxmkEFjwnVT/Im
	XocskWzzLag7CMdhD3E9ro5pQNR5qQZZUoVzW0eWzmlhoueFkSmXmwKggOEmJJJD2lro=
X-Gm-Gg: ASbGncth4kKmSPe0y+uBTTBSJ6Ot2IqtBJhq5rYQ2it7p8TUWoOr/QnjULm6+ydLoZg
	UtSjVsRY45D052cLfN5kze/gBa4v1Ywf1UzyGfKZ3WEQRamTj9Lgd6xQoDqzMjIDB3rx9FCC1Pq
	nK+J7dk8mB75tp+m5wlfuQHSZA1/EkOoOrXYhzrm+/Px2czdzLfWdhPcIEcEVPclQeO9zQHneXP
	VAlGN8375draUocue8/05bUUgHDAtBh3wS25idvOG9Hein9/9oTtPos7vLWoKpdRO/PdbM7XN6t
	+ftXb/XIOsyVjFwkaxSAuFAcE7FZ3PMr0w2o+z+Lh+6+CXRwnviSLT4MGxJVCjuRjchQqdciXKM
	=
X-Received: by 2002:a17:90b:3901:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-32515ec131emr29194045a91.23.1756383023623;
        Thu, 28 Aug 2025 05:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNKDnXv3VfiyIL/dLNdbQShCWmdXMnoh1NjI//DlD9thMPONtr7h73EWWWnVXj35nDWc1eOQ==
X-Received: by 2002:a17:90b:3901:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-32515ec131emr29194004a91.23.1756383023137;
        Thu, 28 Aug 2025 05:10:23 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:22 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:00 +0530
Subject: [PATCH v6 3/9] PCI: Add new start_link() & stop_link function ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-3-985f90a7dd03@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=1557;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ocglQCinQJSbwG+WjNdC7ufk+jP1Ksb5I3ifJFa2Wm0=;
 b=pxhYVvJXh/UXBUsVF5XTmsLGQfjmqo1e5DxSbdAs39s+USdn55QFDV0BESSrK0o6aVHORtqyK
 EE+SzMqwjJ0Dv2FXwVIXXRbESJ5BySph77mF+5fYo+BhF+I7pmcsk7Y
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: bSCwhxaHwAz1c092BnHiBrQ1-tUDfw1V
X-Proofpoint-ORIG-GUID: bSCwhxaHwAz1c092BnHiBrQ1-tUDfw1V
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68b04731 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfXzgVxnq+1TcTw
 nAgm6k21KMzEg33sShB33Cue0lgCpY2LimK+TxiiXtsHmiTgOek88qdcMvUNn/ez4nhiPGg9w+M
 yCWzK11ZHDRpWcB6xB2G6mup/sV4uZ3/Q4Rzdt2EYP6YBHP5TBB0SCljyH3bIABpvfbDnd5iV3o
 YWyUtFQp4HIWHM8dm7CJsv7ijRcszuYqV+5LW8t9suHRS+HoRotjLquDFwBspg6mfpB/qaU0LV+
 +SeAA3CykIileJAzOjst62kuaqqzhF3hlVu+iQ9d115g3z/b6lT/wjVaQIp9aerffJfa6/sQQ05
 0q2wjwnvUuUGasQYVpc5gZh8EqahC9GXPal+jybnnNo8pzOvfNKiVj+PBiPjlP4qqMhY2+loPla
 M9MYrOVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

First controller driver probes, enables link training and scans the
bus. When the PCI bridge is found, its child DT nodes will be scanned
and pwrctrl devices will be created if needed. By the time pwrctrl
driver probe gets called link training is already enabled by controller
driver.

Certain devices like TC956x which uses PCI pwrctl framework needs to
configure the device before PCI link is up.

As the controller driver already enables link training as part of
its probe, the moment device is powered on, controller and device
participates in the link training and link can come up immediately
and may not have time to configure the device.

So we need to stop the link training by using stop_link() and enable
them back after device is configured by using start_link().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860dbe50ee6c207cd57e54f51a11079..848db224c49a630a33535d162b7049c37c50da5c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -828,6 +828,8 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
+	int (*start_link)(struct pci_bus *bus);
+	void (*stop_link)(struct pci_bus *bus);
 };
 
 /*

-- 
2.34.1


