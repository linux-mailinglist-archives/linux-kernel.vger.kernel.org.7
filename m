Return-Path: <linux-kernel+bounces-821954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D45B82B08
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC311C0768B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB88D1C4A2D;
	Thu, 18 Sep 2025 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="la9pR+Bl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D71C862F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163897; cv=none; b=gx5xD+8EFwiSd2hdE/0oeoZ+LzsBE3fMZ8G39gkDTKGdXs8xpEMPlg2ZDZ95wA5E9qWwiGvlRTTgDYdMO6PsmkCmklaQXYXU3qFULgBcLQ9s9if6PU4e70k3XeDoKEVh8/Hw2La1CrvRHL1CmbSGaFExacs08yyvqaegwidEdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163897; c=relaxed/simple;
	bh=WcSRvEvShhrqbxNvzLtiCjssybnUH82Y+EQUkkK4AkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4DK0SfkBDsByVLbzfSuCoEiJZoFhKjlpfntpXWFsIpmEnUWoaJNqNdXsEcsk8Nd7/na3o0mHxm62JazF3nMXg1NDcCeJXKsAHHgsNaI7h/pxsigdVIMr5slT7rwwJsLDMk2LBl7ef9xTiTEKtoKpqEIL7Xi+LmdC9z+RohBKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=la9pR+Bl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMaGZd011110
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fgecCebfDJtpE3JoBpenuay0Bs5D6Xykj3YET5V/PY8=; b=la9pR+BldbY1vaar
	z2ZOcpik7u9tIlKZiJvBbA9VeNGYARVhcmkrJowjycZL6wbInfwlv2zl+ZiCjaqn
	QZRDTZeAzsNpa3RQOGjAA2EPuq2qPgOGIDGzQqnbR0MrD7Irko5v64FWHZJmHCtc
	6tigV/dNKYaXzM6qk/j8wbpckq1CTRow47BYmA+AXC4FSgZ/KfiTWOtZFPCh6eeX
	0U4TVstOEz/r6gCTphdgxh6crAuReFj7aP0FKuSQGA7kxsPWjrR8RYTHsZ5DFxpr
	v9BzvTyZcCefnD5wd6motgT6CdM5zkRIvfKNJpsn51OhYEOFEmfhapQ2TgOdDW58
	0oMqCg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx0kp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:51:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54fdfd5045so395323a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758163892; x=1758768692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgecCebfDJtpE3JoBpenuay0Bs5D6Xykj3YET5V/PY8=;
        b=r+N1Q16dm3Iq6jx+2HYLYc547JZEXmqWTCw0N6C6p+Ea1I7rzoDaVpVDUdOje3/lRu
         F5OvfAjW+J4A75xxBdR1gKKbyol2+JIbkdLw0DetSXoywyN18uWBnvfsbIRa4L1l6s3+
         Fsskp7Xl2jU5SfDrTcP36sTzp1wcYNQZ2Eps+cnXNe3Z907w6z2pMuD+HqMZ8pZ6sdFY
         4tMOtBjoIiCnE3GrS5A7wBKIBFDvsAub9Y/AbuTVyhKLZdDs3SVOO2jS216M5oHspE4U
         FNwF6LPTNpIFxcwOFHA5wb8gfA82k4IGpKrYkT1kCEcNs+a0bbdpBREqQZIONBHuJAfb
         ttSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe89lz+LXlRFVXQbRgOB4YLJCKapUWBjyoOQrauPJTbQ/DUkmV5UR4ubmxT6XUfMBf4qU4LlkOf2JZGkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYHM4tXvfjDq4mkRS/DR37HH/DCc6q1u1f81+4H24OqBUh0z+
	79qJDDIkJn8sJFj2ZjJGBUh4H/gW990tPOsgT9txRCIeAjv+V5eKQs54Yf7d81dwJXihSwj9kP7
	oNYI9SRJ2Lcu/0SLRG/zvTmYP2NYqgj4SJUoUC9pZ4WZn8YCSAUQeAiPco4mphVCOLt0=
X-Gm-Gg: ASbGncuPchIDq8FDgK0M4YwwQb0ARGBBJnNVeGBTFergJrhTdMw8t4SR2M3U2Rl7NFv
	u2cUUTWrmOpavyKcRMScwY546JARhicbujPvxR7A8418a8EXHGdn6uNcB1cCZRKzMP8IAZopiGJ
	vqFlujIjj3pg+fwkl3e01uiicfejX3YeM+Zco3aB97L9bYm+bqorUiH0/pfeBg6AkyBePD45mOF
	svASnroC7CmC3BXG3a7+weJ8mdrE1mBvFz6sNVDkKTkUvwH46QI++PuchlduJ8g7CvaMUJdx4QR
	rLe9rvds2Py5wsgSLank96Q2T6CuL4U4cfOFyX3t6/pj2UUf30SUszkMwPf2RJEB9kCofm6gWtA
	7CB/Ld0kOE2gab3l19FKsVg0dYz9i
X-Received: by 2002:a05:6a20:548d:b0:24f:f79d:66a8 with SMTP id adf61e73a8af0-27a96a993f3mr5835800637.24.1758163891910;
        Wed, 17 Sep 2025 19:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO8+Yv7Mvypcl39Oo+6RrtTJ5B0aTO0XwTIkdwLESldoizSlNvP5sGd7bDmK1hg4lFmJhW6A==
X-Received: by 2002:a05:6a20:548d:b0:24f:f79d:66a8 with SMTP id adf61e73a8af0-27a96a993f3mr5835757637.24.1758163891401;
        Wed, 17 Sep 2025 19:51:31 -0700 (PDT)
Received: from [10.133.33.24] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff435325sm869595a12.43.2025.09.17.19.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 19:51:30 -0700 (PDT)
Message-ID: <f16f14ab-ff11-42a2-b63b-ed28e85d620b@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 10:51:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/5] pci: qcom: Add QCS8300 PCIe support
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
References: <20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: erJFwIS8koWolGa6PY1HeIli4oHER1fb
X-Proofpoint-GUID: erJFwIS8koWolGa6PY1HeIli4oHER1fb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfX+bdYORRimWs/
 dr030zBIG10v5zrxXTZ6SodH/+zZhYxYrgamYpF0i7Jg/HeezwildGt/mUyBME2LyUDxMRaakqY
 MXNaz0Pv51dDQ7L5nkbRK6lEIbVb6YKC3bA8yy7M8yzLwS8oI194ZD9YW/qElEnXN3HnAVcQ06I
 AezarKkuddGs5AzLLSLoFsaervf45tDmO+obkgACFUa2mbusGRUYKzmcQbIAm0mwtdh0cjDsVYC
 1qfhvuxCAPj1WR4hQwu6gX53A7FypBhS4K1Bg2NS0WVcKGm269FjEmFyclPPvFLZEYlZwT9dmR3
 oVLghXKfoltxqCrawsHtgDowcC0rpgVSvHntX6XQsdQLnO0f+0aD12z9YcrkQ6TfiEiD9u7516T
 qDFI86JL
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cb73b5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=IHEL40AIkIxnPEiLsFYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219


On 9/8/2025 3:38 PM, Ziyue Zhang wrote:
> This series depend on this patch
> https://lore.kernel.org/all/20250826-pakala-v2-3-74f1f60676c6@oss.qualcomm.com/
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
> Changes in v13:
> - Fix dtb error
> - Link to v12: https://lore.kernel.org/all/20250905071448.2034594-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v12:
> - rebased pcie phy bindings
> - Link to v11: https://lore.kernel.org/all/20250826091205.3625138-1-ziyue.zhang@oss.qualcomm.com/
>
> Changes in v11:
> - move phy/perst/wake to pcie bridge node (Mani)
> - Link to v10: https://lore.kernel.org/all/20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com/
>
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
>   arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  84 +++++
>   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 310 +++++++++++++++++-
>   3 files changed, 394 insertions(+), 17 deletions(-)
>
>
> base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
Hi Maintainers,

It seems the patches get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue

