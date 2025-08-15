Return-Path: <linux-kernel+bounces-770490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE582B27BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893387B2133
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6DB25B1D8;
	Fri, 15 Aug 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VVsM8c/2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804A1EA7CC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247893; cv=none; b=RelFd7ue/ptX3d2Haovp1MVEOmCOinT5F4Ips5NgXxigk/Qw06W9wGfCMHBtWtRaPYof9E1B96uqEQqvhm4ym+wr5mIqQyygxRhw7LG9z/YKx4U2NGHdo/JjS8a+0nmhWmyi1fMlY0dGPVs4cCkjPQGA2T7iydrQfS9CHEJ6lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247893; c=relaxed/simple;
	bh=UF5qyNpTXdoXNJ7pnDXzfEVK9jteDAQF6rVcXALvFwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvBEiq3a4GeW3Kv/D5qsfgU6QyvUDnElIiINPJ2Z6ZuU4RNjPcFGPDENYOG6GxMjDIFYO5m/880efvMplAdXEJ2nZ+xF0uyJSOE4ZQMNWA2JOpYb+PGiyzclsgHC1i0M3Lt/1P1UAeoihQC8iBGwp+OdOnU55COf3sxqQ1Eu0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VVsM8c/2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EJdgBo024004
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	viA0ftgPjs8CYNz5BU9g3zq8XF4gr1cHoqz5uG+TLmk=; b=VVsM8c/2HJspZpHO
	88q0sMUufJIP/OZqja2CN8vMlHuCxsOdYbW9mMkkd8VefDLfmoolFz+n6u8TlqQl
	VvxnrOK3eJP1CtPqTTCfg9Ckq3/4mbgj6b3Q7wqWBq7C6wf1+Z67yavWodqNxClk
	qPdlvRmvFEvX8RmO0IrN7mYqxZOOdDPv11GgXTQ1SJ8uBoWV/Z0m+AX1Et7YdLDM
	vEKoAj7hjqe1wtjFa8nnFxjc4BNtTBYaSFTCl7OIZQX6ZYezBifgIx1sMUwUFCL3
	QdYVLhRB8zfiuG73916yBy7gDgbUdZIL6Mu3UreaOy7do9KGBCr+D4qfAg9oZx8s
	nc/Yfw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9ry7e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:51:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso18937715ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755247890; x=1755852690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viA0ftgPjs8CYNz5BU9g3zq8XF4gr1cHoqz5uG+TLmk=;
        b=nRgJ0ngbwW7mX+NHR/mpBMx5BKcFV07imG5Exdl2XucnNhAIgfm5ehV9pTI8IAOg14
         gAlckoW06t+C3YsPbAS3zQDcGlkRqKdAX+DDP6RE5Bw0Cw4mSGCfcPSNtJALe/lSAkAZ
         8U90eBscl30Wyo/IYX2ctmkBZekry/3HaufKNExkkLujNEGurpUMGSjWBynJGyLqTuk4
         Nf1UFu3gkjXYYhbw+CzMHYRZpxMF7hSGcLiJmLhFFUL8zXBlg/cvNlai9MpiafcmmDPU
         GrzZkKuaw/fLQvNzc1umA1ooC1OMsmBP/Z3vDI50r3EPll24CRRiLc/zrrSuQhGLCyL9
         3b6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIK0vwhIZHeMDHdAzu9d+orq3Nz8wa7K1o6Wgjo3baxmDqLr1sLgE8CUk+t6gnXqGrfmNSRNJRHQjs1D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZmEWr2b74sFqR0ziTLaUGftH1Xi4qoDuI1lPtzNlyMz/JB3X
	lcjqaG24bLHBv34B/l60wvdtNIulCCdkkQzOrV6qX42KOrV3wCHYHsbID+SKwiq2yuoCtvC2LtR
	qD+Pt3TmqKZDxeaT8oOqMYaYB0oGhRd1PhWjO/TjKsPjmSgWKSQ9dUtE9V5bLiR1MEQc=
X-Gm-Gg: ASbGncsdOSy7dmvGvdQ+bLAsUILMl2bxfkGH+Y75bCrYfYjLs+72WgAM4gXwWl1qnZE
	YaLRpGngARFcL+NAVwHXWysNU3bt/P46clfGPSPyGfe0Wbt/TfvlBZDcgIdoq40uAau8IkIeCiG
	d5iRanB/AuKqKtlMhYgOZvBTYFCnnPgaJtbXAaM8ZJSJCbiXrhZHVwVdlbFd0L0gYcKfkZD44rM
	9mAOTBPr1uNiOq3e4L7oajKccYM1LpAq7YWaK9nqHB6F9RGJiBP3sAHOiKKGhlhtgfgUjID/dz1
	z4VykPliSaFwymF4RFxGhzIERi7kN3hUWxsD2BsrMehjXg3iApPZcjXkahqgxjEJUbgGwJD57vX
	gOnbYtonMfhnfOMH4dmOUY9m2lf3a
X-Received: by 2002:a17:902:cece:b0:234:b41e:37a4 with SMTP id d9443c01a7336-2446d5af49bmr20126765ad.6.1755247890317;
        Fri, 15 Aug 2025 01:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRZ3xoE0Z01Gar2LyZr8un5sb4pG+FITKlhbiCZfOjE53dG11yImWKgWB0zMbX+CcHUtPEvw==
X-Received: by 2002:a17:902:cece:b0:234:b41e:37a4 with SMTP id d9443c01a7336-2446d5af49bmr20126405ad.6.1755247889823;
        Fri, 15 Aug 2025 01:51:29 -0700 (PDT)
Received: from [10.133.33.31] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d55035fsm9240305ad.132.2025.08.15.01.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 01:51:29 -0700 (PDT)
Message-ID: <c931bbc5-f246-4d34-9280-0c1a551a1e7e@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 16:51:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] pci: qcom: Add QCS8300 PCIe support
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfX2v8e1H0zYy7Q
 ovsTc/0zOosC4LqA7Fy9cSR1TxvKk1/+5N3WyNTbWKff3xvBllEFYccQ2oQwm9Xmh0SDhyEzeNa
 se9jdPGCaoJfYfRC2EU7bQTY3uHI21p1ONX2hCTkm50lRLaKE56apAsIcGN0fFsxqKzi5J8BmhT
 mXm6Is+EOWTF4yHuhmgkejRF4Dg5adVu5wwO2KfhzAxna8YoQo/tp2jMAMdeUCLV+M/IyBd36Gg
 nw93w2i2ERSqWYJ4jAMIeQGegpLQCYbfV+IfCkTLu+fCFZLDhRZ28XDBps6JgYRL1t+25hFk0N+
 NyQGU8l+KDei5R+pv36gL8MMj8ejbmpPZQVQMOaZfomy1sPTFw1rAiHnn1bX1FcxnymGGrzjpFG
 KiaCrv3q
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689ef513 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=IHEL40AIkIxnPEiLsFYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PNPqusz0GWu09F2p63AcI-TRepOjHdh-
X-Proofpoint-GUID: PNPqusz0GWu09F2p63AcI-TRepOjHdh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094


On 8/11/2025 3:11 PM, Ziyue Zhang wrote:
> This series depend on the sa8775p gcc_aux_clock and link_down reset change
> https://lore.kernel.org/all/20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com/
>
> This series adds document, phy, configs support for PCIe in QCS8300.
> It also adds 'link_down' reset for sa8775p.
>
> Have follwing changes:
> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
> 	- Add compatible for qcs8300 platform.
> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
> Changes in v10:
> - Update PHY max_items (Johan)
> - Link to v9: https://lore.kernel.org/all/20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v9:
> - Fix DTB error (Vinod)
> - Link to v8: https://lore.kernel.org/all/20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v8:
> - rebase sc8280xp-qmp-pcie-phy change to solve conflicts.
> - Add Fixes tag to phy change (Johan)
> - Link to v7: https://lore.kernel.org/all/20250625092539.762075-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v7:
> - rebase qcs8300-ride.dtsi change to solve conflicts.
> - Link to v6: https://lore.kernel.org/all/20250529035635.4162149-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v6:
> - move the qcs8300 and sa8775p phy compatibility entry into the list of PHYs that require six clocks
> - Update QCS8300 and sa8775p phy dt, remove aux clock.
> - Fixed compile error found by kernel test robot
> - Link to v5: https://lore.kernel.org/all/20250507031019.4080541-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v5:
> - Add QCOM PCIe controller version in commit msg (Mani)
> - Modify platform dts change subject (Dmitry)
> - Fixed compile error found by kernel test robot
> - Link to v4: https://lore.kernel.org/linux-phy/20241220055239.2744024-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v4:
> - Add received tag
> - Fixed compile error found by kernel test robot
> - Link to v3: https://lore.kernel.org/lkml/202412211301.bQO6vXpo-lkp@intel.com/T/#mdd63e5be39acbf879218aef91c87b12d4540e0f7
>
> Changes in v3:
> - Add received tag(Rob & Dmitry)
> - Update pcie_phy in gcc node to soc dtsi(Dmitry & Konrad)
> - remove pcieprot0 node(Konrad & Mani)
> - Fix format comments(Konrad)
> - Update base-commit to tag: next-20241213(Bjorn)
> - Corrected of_device_id.data from 1.9.0 to 1.34.0.
> - Link to v2: https://lore.kernel.org/all/20241128081056.1361739-1-quic_ziyuzhan@quicinc.com/
>
> Changes in v2:
> - Fix some format comments and match the style in x1e80100(Konrad)
> - Add global interrupt for PCIe0 and PCIe1(Konrad)
> - split the soc dtsi and the platform dts into two changes(Konrad)
> - Link to v1: https://lore.kernel.org/all/20241114095409.2682558-1-quic_ziyuzhan@quicinc.com/
>
> Ziyue Zhang (5):
>    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>      for qcs8300
>    arm64: dts: qcom: qcs8300: enable pcie0
>    arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
>    arm64: dts: qcom: qcs8300: enable pcie1
>    arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
>
>   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  17 +-
>   arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 296 +++++++++++++++++-
>   3 files changed, 376 insertions(+), 17 deletions(-)
>
>
> base-commit: e2622a23e8405644c7188af39d4c1bd2b405bb27
Hi Maintainers,

It seems the patches get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?

Thanks very much.

The phy binding's dependency is merged, the patch do not need to rebase.

dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
commit: aac1256a41cfbbaca12d6c0a5753d1e3b8d2d8bf


BRs
Ziyue

