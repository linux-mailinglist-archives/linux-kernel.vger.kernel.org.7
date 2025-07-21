Return-Path: <linux-kernel+bounces-739350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31992B0C51B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F26189C1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C122D9494;
	Mon, 21 Jul 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i7Af87Rl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B722D5A01
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104325; cv=none; b=KGNGhR4yZ3PdDj+929Ko1U/a+O5uDFLiAsHWgwZExkElBmgc8V5TzpM85N2FQC73PLXr7VXtOVahNEvSsOwBSodl6bFBfaYkvVloGozaNHpL1XE3ZgZliRXlf5WCKS/VqaKvXwXLai+N5nb6Wa0koiP6rXkuCudFOMkzCwbEMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104325; c=relaxed/simple;
	bh=UIGaP2WMgsKajna8R0R2j3HUDLSthHfOLtrl0z1bpfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiYf9o01lHK+r2MI8s25/TChbzMaAT2F0r7MBsO5/PHuTdM2UGeG2J5AmWvEZqk4iiGI3xhAwfZTvG25FKaxAS3nVTuKbxxBVt0RIWvgAmwRQJ3umHPxWj21295YdlqTLr03luqiz5EtU2msViSYJnnUIhWGo6GJQ0nzek+yRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i7Af87Rl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAWBm7000994
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rZQHynXS9Aj+ofzqFulsvS4teiqfVzJDlJMHSlRQVic=; b=i7Af87RlSsyPtyRr
	HrR0kGeh9hBMhTS8D+mPtI2cUrZ6cZFvfm6WqrUYS9Lgng9+sPvqV0ogMQKwBuZf
	h+z88asJNbJ/WqxDZZloocEJ+hJyjC23vnIIV0IJPY5RQXT6SPNwAQO9jJBPFLYo
	3Q6MDy2LOp0vidV8nn3ODILDkEbq3J/wB7gz9TTXsBmeCV2WcYt7BYNa3u5zF4Z9
	eUdRlsZNCVI2SA50hRM7wk6IX81r25SPRz5A2ykwvTMQkQdc03t9MKcKpxqtCe7U
	yc+xa3PP7yfNN4RgoyPomX+v4r6wAxjMr1MSR9iT8OnEK1MZ5CiStaKJu2OLtz8L
	koqCgw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dd789-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:25:22 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75494e5417bso4004523b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104321; x=1753709121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZQHynXS9Aj+ofzqFulsvS4teiqfVzJDlJMHSlRQVic=;
        b=Mg1f3Y8QueKM35XEr1IUR1rpmTqSPpnFNzNwjQn4IdL0hbMom+J+6Ck8zHxlGW8q8E
         Zr+sOzDegKr/EDH+Sd5KSwjleNkyrzCRGvbOHIKwsGPyhB0v9khMLDZTZxBB6KDPnoNf
         Va+XDs+VTHf9ITD8hYSOVW2um4DcG/HsgiSoxHv6kn2hpPeBp+3lV387CfTwUrhMVJwW
         arZt2gSvvu4CLY7TDy6r9tsS2miUS8/M45NsruhFzX8Cv7Ou77O/DHNL6H0eOGyGLJs9
         2/IYIVrHiKwLZg9ABA6DYydY/RGMayQMytSiBsQ7Pqo4tjjQMtx9KTTyBHnIS39gNpfI
         zS4w==
X-Forwarded-Encrypted: i=1; AJvYcCVHowHr9OeQTcI0Q9XW6crpsOSdNbBLqSaBvE7gymwz8dkkRsLs0YVUCrId4nD3gF3FKIQwvh0H0QiDJN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHo4nEV5NR/+0Eg1kw5B8Rqh4v7BxelxpS5FzrBrqEgxmh3yvp
	oI+AqcoQoy+MwrKNNMQMCF/GWTK306bNDoUhqVwddrqIhzCiYqXa4HKFilL/4gE41ySINJ4wSAu
	IunziBCoNE+L6H+tAB1rxV1vRBOqBjJKtw9Tr+eB10tGk5XxuR3/m0vZaQs3Jequ7krQ=
X-Gm-Gg: ASbGncu+NnDsmn5cIs21XzWmVmO6wQwapv1kL/9xOL8ScWfwe92vO/MadpNHLkgLMIq
	if+taWdcWQL4npmKxvhc/rd04693+UMl7kxnVrDeQ824m2u8DlSxQPbLLp8wLcfew2t8Rqy9ony
	pb9Zh6tfTUDH6W8QKOFmwTiJz8NHbWDzYxs5a2VIJ0Cm5LggIL5nGFVr8opOquf9FhrPjimj4Rm
	20X13FlKOPrZRvbKEenQsvLRuDEIPHIYufcA/TnUEmhjXSHRaW3j2Osot+QIaYbVtcqabWTtGHN
	RiUROy9nTXhZpaa1/z52sGc=
X-Received: by 2002:a05:6a00:440b:b0:74e:aaca:c32d with SMTP id d2e1a72fcca58-7583806f7c9mr22318727b3a.10.1753104321175;
        Mon, 21 Jul 2025 06:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVAG2MuKiinbLb8Q53VUsMTuw7REYbjlHCJcq0ez6hDk7d0Yrje6e4GNuTCOXMv94W2Rtf2A==
X-Received: by 2002:a05:6a00:440b:b0:74e:aaca:c32d with SMTP id d2e1a72fcca58-7583806f7c9mr22318689b3a.10.1753104320687;
        Mon, 21 Jul 2025 06:25:20 -0700 (PDT)
Received: from work.. ([120.60.76.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76da69sm5688821b3a.115.2025.07.21.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:25:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v21 0/9] PCI: EP: Add RC-to-EP doorbell with platform MSI controller
Date: Mon, 21 Jul 2025 18:55:05 +0530
Message-ID: <175310419611.11873.17918717791350182486.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687e3fc2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=5oemJFBbzWj47VPNxq3P8A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=mrIX6-fznQKVqVjsUugA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: cn7oek9uo4A8xsFW-cGJZ31ccxl0kZ49
X-Proofpoint-ORIG-GUID: cn7oek9uo4A8xsFW-cGJZ31ccxl0kZ49
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExOSBTYWx0ZWRfX+0IZvav/wL4k
 7/XXH5gU28pHU7Nr7bh3u5oR344Hm1hDJZihYJeRWCrk66jv7O2D48WHEUGeVZSx9SsvHnfwneH
 cGxVL2HFLJw+8/GgDarxVys5HMVFKtw5Ktlw6ip9LwQvk1aptCyHeQX9wkNfeIxMa4UjpocFMvK
 F7DgbKSGivuwxCOONzUP9vFRj5ewv8QakQleVjHkIUD6kQfyoLBJwm2YfiDS7jpcpjmqVn9+bhn
 g/O7tWq7Eij7sFZm8mpVWaX9gSXl7eQk/tk1E8Bwn7UUij9IBOI5KyBADI5XEusD+0ClMd8vacQ
 mPW7//yoGvBNHRHbMPCC7XB61zLdQbK/T/sAhmhoWlI6AuayAQ7JYcfLx9fToUrjflXAFuF0dlX
 BONtckM+MGnsWKadiV/RQL/NqkyrNPDVpf5iBM1QgQUUqZGsJF/AIV8jmCIlmQLwVk/Kc8wZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=942 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210119


On Thu, 10 Jul 2025 15:13:46 -0400, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 
> [...]

Applied, thanks!

[1/9] PCI: imx6: Add helper function imx_pcie_add_lut_by_rid()
      commit: 9d0ca8df2451eb66a0c13a9932f348d417d9603b
[2/9] PCI: imx6: Add LUT configuration for MSI/IOMMU in Endpoint mode
      commit: 234b9258c6907cabbb2594ee366286d35ff056f3

NOTE: I've dropped the Tested-by tag from Niklas since the tag was only given
for the EP patches.

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

