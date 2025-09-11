Return-Path: <linux-kernel+bounces-812328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24313B53659
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC195A0536
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09DD3451A5;
	Thu, 11 Sep 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X1srIZVf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CDD340DAB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602330; cv=none; b=VAYqRbDkRRz7ugNTS5WcULt9pXiwfyUn3gCEvCYLB7ibGetQ8aSjB2NrCyPIvq7xOg/SsgfdT2+dQFzwCYXvBPF1MhskIpucOf/TSpHEPkmgKAq5T5wyuvJOntyVuPI/5OQAE+YBejd2qUkYNsRRsI0mlMEUBcbzEO6MGMa5zIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602330; c=relaxed/simple;
	bh=XUnWDnhmJUT6GLGLfZ8dfUraPryJil2OqonDHT4V8FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAWwLZg4Pne0AISJ9BCA29+eSOQKDxp6UUNIrA6sq8efQ24Q48UskvzipCDy/QkHpmWCeXuCApbixmTmxRgfYsZcevl655Q8yGPvNmD4KHeTF3xP6yyref3s2mgrMKP8sCfRvHNcc/hVBhl/vOwB2T7JZbJo/AU2YgSzmK/5r8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X1srIZVf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAqMug025747
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WojJDvsX9kdVKAnNSnxIU1th8+eZ8pVWigC6PBhk65c=; b=X1srIZVfXz6frseC
	6UVh+E42QctEW94Jng3VYLFtPsGhJRQxZ1/kA5u7hea2LzIlpzCxsdkFGSKCkIiJ
	y0NnJuSwT8mize+yh3H1ofS7h6d6GEzgCEaJLsGUcMLuL1XsoL8jqL6y95WEjrlt
	2/v//VyQKQzTha71IUGgaqZOO/YJjsXBA2lNdT+/OAAmDK60OkqYjWz3yVapU/x9
	Ov9Xmp4RH+xrjoLwYITHfp34X2rRBQMZxL+dSDT22TI434vHkksmBkOrm/eNwLD6
	AI1ToTY1zy63cW5AI+dH5KAILpeOj7B0HJ6NK5kx+hTcwREQmiy+p1f7Lo8QJC6x
	NeRLwg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj103mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:52:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25c7d8164a8so1215155ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602326; x=1758207126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WojJDvsX9kdVKAnNSnxIU1th8+eZ8pVWigC6PBhk65c=;
        b=FOVIFnxdRZy3WrYbuZyQMIYnQja4vbMVvVv/ikbGwOlEpzVXy+c0b1sKqx4ZrLyDwb
         NgSv7AzuDYgNDWKE+X9kTZVNHxXuxJnm1o2iTxiMa4hc5umcq4ZaINBJOZtZO7+QGH3v
         5e+XxibZy4TLk2+303ZYuOy4CI171QL85drymO0dhDpi04fX9URtXjoNi0dLeYwzca2P
         UvGUHSCRViS8Gv4Gl3RT77Nhn9sjhW1+nG576a/7j9ev/HCkUawFX7e8Cq1zcdoMQ+ak
         yhtXs4+kPSo+aOkq54TisokcdROExkp+bxjgJo8K0GtqBmOGm15/UGLSnn7fcYREpRii
         3SPw==
X-Forwarded-Encrypted: i=1; AJvYcCV3S2h+uwKFdOoh6qqYMISnReIMWAn3aD3lNjh6VS1qJbNyAQwa93c9DK68uRKh0KtYZblurORvZieQBTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yTtqKbsWgx/1fNx4JqAMOILcMTh8OpNIIFR5/sMXvmLv+wDb
	0v0WN+wYnzvgd+7Y+76ZBTPqfqkphP798UaPZYMRxftX7TjZjDh8OqzmyJD497QvheOsvlPIh2+
	nl4Zquy3yDhZ80QSFQUC/VRNWRuvum5zTxLBtsG93bKrv0J/rcn/DP6cPYimDgbd0QKM=
X-Gm-Gg: ASbGncu66oQKYBAK7GoyuQxelyA3QpH4ahnIsrU9g/eAo1g+DdSkYrzXbkv1uSNFaoR
	OvMzXPMo9NATqJdnvge5i4/5NazkQfLRKCq5BxjtmYoh974n4Hi3a8rlrk9UNZlW9j9cZkdT/8i
	ct2qQSYJV1QBq5mgkiyHUdxe0cbU2An5KW2xMjpa7ODT9G9gT54Sx/07Yp81P1aC6/40y0hs8n8
	Hg6mp0TYIg2WHa3/QBdJis3Mg1wGShKvaFmCOVRu0rnJIUEkMx8VLL5WPhhI4f+FIutIACAnIPc
	yIc9edBpe/kC6W1V94Ts9SeFPLsN69fdVWAIlDdFF30jw6gHYhgRIHCWO4GthIvmQP/EPShZLP1
	nMOrPVeJO4FIU+jq67rAGpgKGjMa9yg==
X-Received: by 2002:a17:902:ce83:b0:24c:b36d:637 with SMTP id d9443c01a7336-2516ed66eb6mr141725375ad.1.1757602325772;
        Thu, 11 Sep 2025 07:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT+PRAiEdvkLjcRfWqdV9jt0LLP+pDcy5hdt4QkW8ZMuAA0nniD4jnVIYnBcIAtmyR2ZAHuQ==
X-Received: by 2002:a17:902:ce83:b0:24c:b36d:637 with SMTP id d9443c01a7336-2516ed66eb6mr141725245ad.1.1757602325286;
        Thu, 11 Sep 2025 07:52:05 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ae28408sm21345695ad.109.2025.09.11.07.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:52:05 -0700 (PDT)
Message-ID: <33137dc3-254e-4a7e-9531-8d682692fe29@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 22:51:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] (no cover subject)
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-177348170c2d@oss.qualcomm.com>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-0-177348170c2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VBvgiFwTlZ7NbX3wHccgy_J6iXnp2b0P
X-Proofpoint-GUID: VBvgiFwTlZ7NbX3wHccgy_J6iXnp2b0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX0E157aD+OZb5
 EVWrOzkZGt9CP0wQybK5T6O5ZOx2iz23iDhx8IzymogIy09tkPv9c/E7d6U+s53yMZ2HB0POCTN
 ZqXIwIvJfHcp+fqtrki3Bl+4a6PDG6aQOD7WAXAp7lpeJKyomvFKJVYWrXM3St61XzcN0cEpJqD
 6iBOtOBUQLiHXVRw+CCBMHy4zH3cjxWXP6OOCf249TnciWv7OQ2rNaOiEvSDs2vgXTJEsdYiVU2
 vWk3c0b2gq/b3Nyk7NzbSxgtgC3ZnnraD6hBx7P/JqaQTFkleffTwaavTjKyMbIg0J2TcvXYR/p
 1dVnxcxnPPtHW79fPZJEdHRjO6WWie4+QuBF4GUo4XpMfXkIBPkivGQSPF3SWzGMy0YXzCHCP00
 sfbO7dV9
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c2e217 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=BiXlWXQ3g7YhofqwlSUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

Sorry for miss subject and will resend later.


On 9/11/2025 10:46 PM, Xiangxu Yin wrote:
> This series aims to extend the USB-C PHY to support DP mode and enable
> DisplayPort on the Qualcomm QCS615 platform.
>
> The devicetree modification for DisplayPort on QCS615 will be provided
> in a future patch.
>
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
> Changes in v4:
>
> - Drop patch v3[01/14 & 13/14], will sutbmit new patchsets based mst dt binding series.
> - Update maintainer of qcom,qcs615-qmp-usb3dp-phy.yaml to myself.
> - Add missing aux and pipe clocks. [Dmitry]
> - Drop second TCSR phandle; register offsets are described directly. [Dmitry]
> - Add USBC PHY series related init_load_uA configs. [Dmitry]
> - Drop v3[04/14] qmp_phy_usbc_type define and use dp_serdes offsets to confirm DP capability [Dmitry]
> - Reorganize sub-patches as suggested.
> - Link to v3: https://lore.kernel.org/all/20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com/
>
> Changes in v3:
>
> - Renamed qcom,qcs615-qmp-dp-phy.yaml in v2 to qcom,qcs615-qmp-dp-phy.yaml in v3 for QCS615 USB3+DP PHY.
> - Updated patch v3[02/14] to revise binding title, description, and property order. [Krzysztof]
> - Updated commit messages in patch v3[01/14] and [13/14] to reflect the DTSI rename and clarify compatibility. [Krzysztof]
> - Added USB3+DP mode implementation in patches v3 [003–012], organized in logical chunks. [Dmitry]
> - Dropped patch v2[03/13] to maintain full backward compatibility with USBC.
> - Link to v2: https://lore.kernel.org/all/20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com/
>
> Changes in v2:
>
> - Add new binding qcom,qcs615-qmp-dp-phy.yaml for QCS615 standalone DP
> - Split DP PHY driver into patches 4-11 by logical chunks [Dmitry]
> - Update DP PHY configuration flow to align with QMP Combo PHY implementation [Dmitry]
> - Update all hex values to lowercase [Dmitry]
> - Remove redundant comments in DP PHY driver [Krzysztof]
> - Remove invalid USBC type define [Dmitry]
> - Move lane_map， max_dp_lanes， max_dp_link_rate parsing logic to dp_link [Dmitry]
> - Add TCSR-based mutex logic for DP and USB PHY coexistence [Dmitry]
> - Drop patches 6–8 and remove related binding properties as rejected upstream
> - Link to v1: https://lore.kernel.org/all/20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com/
>
> ---
> Xiangxu Yin (13):
>       dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
>       phy: qcom: qmp-usbc: Rename USB-specific ops to prepare for DP support
>       phy: qcom: qmp-usbc: Add DP-related fields for USB/DP switchable PHY
>       phy: qcom: qmp-usbc: Add QCS615 DP PHY configuration and init data
>       phy: qcom: qmp-usbc: Add regulator init_load support
>       phy: qcom: qmp-usbc: Move reset config into PHY cfg
>       phy: qcom: qmp-usbc: Add DP PHY configuration support for QCS615
>       phy: qcom: qmp-usbc: Add USB/DP switchable PHY clk register
>       phy: qcom: qmp-usbc: Add TCSR parsing and PHY mode setting
>       phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP switchable Type-C PHYs
>       phy: qcom: qmp-usbc: Add USB/DP mutex handling
>       drm/msm/dp: move link-specific parsing from dp_panel to dp_link
>       drm/msm/dp: Add support for lane mapping configuration
>
>  .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   |  111 ++
>  drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   10 +-
>  drivers/gpu/drm/msm/dp/dp_link.c                   |   71 ++
>  drivers/gpu/drm/msm/dp/dp_link.h                   |    5 +
>  drivers/gpu/drm/msm/dp/dp_panel.c                  |   78 +-
>  drivers/gpu/drm/msm/dp/dp_panel.h                  |    3 -
>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h      |   21 +
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c           | 1089 +++++++++++++++++---
>  8 files changed, 1192 insertions(+), 196 deletions(-)
> ---
> base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
> change-id: 20250911-add-displayport-support-for-qcs615-platform-2f072e2ba239
>
> Best regards,

