Return-Path: <linux-kernel+bounces-888055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213FC39B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC161A23C25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51B30AAC0;
	Thu,  6 Nov 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KU9yQjR4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q8YPuo+0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51690309F0F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419666; cv=none; b=f01KKxXz/7GATmWdsuBFGv2jX/KTAx3XZnekwwXrj4ZopOF+WCSHOC0l6rgx2eokzcD5z0DIR1ILovIP0nLmix+HYZqES5glJY0eI2jehlWpJjky4gS5HG5/K+yScnEttFzTGkyZQFz0BDcg01tBXv6VivnAgcc7Rr0t1VAD7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419666; c=relaxed/simple;
	bh=sFtmxrI9M+6L2shmqdSOdn4ucPduzotVbBJxctZ1ZRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsIudUZ/qknk5ucvGzNgvVsvPpn87lBdCOi7Gof1124Pj4HJCnH0zJT5T+ERsgJy+ByuaGOsNZV1xR5JB9vfmfgRKK6RDvoaI+e7Bon+lmBuEzLgJuF17P3z0OTDdL9mhLk1fAfcCSZmzc8qbZOuQpr3BHm60agO/rU3bgFciMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KU9yQjR4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q8YPuo+0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68xcZY2389214
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 09:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PtoKKtNoi4tQYPNVCx7ZmLMBn5/f/cR86N8wMznH7A0=; b=KU9yQjR4q0MSmJ49
	dm1vxcMOmodOzw8bCzO12TPJftOC9uGSOicJglLM08uWiH4xBecqjVTrnkFtt564
	1qjrWJNJgnDsHvQpJbF4o8wuQySL+9btCSnt4nOpkiMF/cgEf7+EJVyJRPeaLTFC
	LkiW+WqviZFf6xt72CQnnquRyvScSsK8Akd15LjSVYPqdRXWCpq1s/sIfFwwz3Ol
	r6RJszaHw0hZn+Ju1yJvUdVIRQUw0PtcsR1jicUcU3meRKBYNJDuqf+o+ngudnJR
	k8/cjLHTyde7ute2Z5Zn6RTAwmuCZSlCMeXmKwZbagGdKHyVNW1m41zbl9KYb896
	auFCPA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9us8up-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:01:03 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a43210187cso822067b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762419662; x=1763024462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtoKKtNoi4tQYPNVCx7ZmLMBn5/f/cR86N8wMznH7A0=;
        b=Q8YPuo+0Bvv0y8kFYSerQ5EUwQXbxraROVu68MZCtTHMba/f1wzk8nncQZ4z2/dAvM
         9xueeLFqV1hxlqYm1FlDTHSiP6P8TLlfGgd5W0icagFFzMzB6PhsVOpvyOzxBcqsrEyr
         TkllFQCMUni7CgYlimehrLwkHNHZeXKe3BsGB6ir56Zf6qNDk4oczOb4lxMQFQnFKAaD
         ZJh8exv6mnN7tU9vQiMmHnfHmBhXuX0rdgAnK6Kgq2XssjIdda+Iu5ZLQJv+XREK/nmQ
         bOqSPnOychuoI4klabnFY2hU8wDFe14W3s9J9v/IEaF1V2wlAGrLxSSd6Qe/vsnkuafB
         sB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419662; x=1763024462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtoKKtNoi4tQYPNVCx7ZmLMBn5/f/cR86N8wMznH7A0=;
        b=QcuVawWdYfDK9QMrAG4LMxxpdRt0XrxdbGPUsomsVJQfCjKbTYuWJf7lr8RL8HSUMs
         TwP6lMF+aMyFHgkGg+kjDAVeEbjhL8M2A4oN2BOu+6mVdQYTfgjxt/uTPyUVcbmfhM2Z
         cvJCJPkJLPIYSR448SCgS7RmOrSPlu2jPNzq028k3DDq/XCuIrYJmhJ5jzbgX4AI2pAq
         nEQDNIBnIEM1VDcdNxzLVDb8mOksLyoV8FvaOTX8gcEWpMAdyCbE7ozbXOraDSHo48+y
         EaRcmaq1LqGOpR7O0m5VUpt4qS3CRDNjacjMwAfXkdW1WQDbrz9cNCp+81NGNL6pI/hU
         855g==
X-Forwarded-Encrypted: i=1; AJvYcCWWlKntVMs1GnHaBoRvFf6iioMEcvF8M7Y3E/x2tx9sMtQG/e1ZFhOip6INDQ713d5dxJAM9W/fdhlmk9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjuT/QlVFkOI6aLipMuWmswpjU7iB6NsFAmSgX9bb0axz8474
	meSlMBsECCGetrtxGN0eVMCcP//vfa/RHqb9TwOiu58eUOj0UuA3blJPUVDWFTF/6dFf2TQLFRy
	AILrlIqEkDc640p/GudGxUOlc4Eh/U2U3XZHBPcVw/WJVz1Qxkd+NnaC0g52UsWU2S3o=
X-Gm-Gg: ASbGncsPLQowN3LY2cgZ/d+o2UX/gqPGs5GR4t9tPf+OiZbGTZ6Q5CAwTI/Z1bpDoVp
	LXZ2hOjTeKsXC4n6nQnqJgX4oQTsGeWnHgA3dG26Oe5zbueO0C3HTe0tT7dtKx6k+7rp/SNWaio
	QTpvBeZfWYDxumZRdhnxg1BcBBax0Xf2CeUKOlT7ubupzwShrjdLs7qvRMpqCcmcQXzXQZB2wRm
	z2jH1tE8GtLG05VnpytyGd8IRMWRmAQCB7NJm6sACWtpa5o2CLjWwIDmaTAnINHef0P9yp65jpz
	Kp9xZ+qQj1jt1rvFRLSniIfp3zMMMjApwkWo5BP6obonPigZTkzpW/PgOxpyDslDtmZo5mtde0W
	KrPjc9b7ZWrNXdgZVJFlL5HlU7tlfp/rk49yF9/JFT9sxHl6jKC1P+dhBTXqB5cr4
X-Received: by 2002:a05:6a20:258b:b0:34d:fcc9:2272 with SMTP id adf61e73a8af0-34f836ef31emr8825085637.5.1762419661591;
        Thu, 06 Nov 2025 01:01:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8t+GNpTY18rySL2vGh08/gFSj3q+kAMQBIFky233fS+n9VOYCuiclCi1nHnFv2zQiTzXsOQ==
X-Received: by 2002:a05:6a20:258b:b0:34d:fcc9:2272 with SMTP id adf61e73a8af0-34f836ef31emr8825020637.5.1762419660986;
        Thu, 06 Nov 2025 01:01:00 -0800 (PST)
Received: from [10.133.33.196] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af827f0552sm1965612b3a.51.2025.11.06.01.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:01:00 -0800 (PST)
Message-ID: <1ad1fc7d-7b6e-403e-936c-4c5a12d4e6f4@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 17:00:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/5] pci: qcom: Add QCS8300 PCIe support
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
References: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20251024095609.48096-1-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c63cf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=QyXUC8HyAAAA:8 a=IHEL40AIkIxnPEiLsFYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2XBpm-sCvOxutJaMwYbkDjIG_65A6RfY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3MiBTYWx0ZWRfX86rW6g7isgnI
 n64IoJWRiKSgURS14vgKqts7I/Dt3+sjh0O796ZFkZ6yzvEXVWNRr/ug8GfKlwoDcCDdohzp5JB
 66ijDMYEBhLcwhxmzbWrdIQvAX3B9vHfsJ4qCeNsgmVV9QtO4U0r4WlfxWtuL+qVtLNUDGp4R6G
 KpAr9qGiucoyVZUxb6vtnkr0Sfbu5QLCkl6ZYqS6ZpsFYL3VHS0RaswSeEZD71wqZ0KDQnI7B8c
 tht2VA8O1Ri3CBRbG/BY9sor/ye+qKYESd8UKQ/ybDfPbnvdo8I91TlU2qVIDiOIQ7FdWKAePkm
 9YJ45KY7G6J78CrQ7YeINTzXvvgqgI/pyjuXYMGRUeOtSCnLWPCyr9orincqDM3OVwbEAMcCFDe
 tCplVMWGQRW5RFRm6YwFthWugFdwsw==
X-Proofpoint-GUID: 2XBpm-sCvOxutJaMwYbkDjIG_65A6RfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060072


On 10/24/2025 5:56 PM, Ziyue Zhang wrote:
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
> Changes in v14:
> - rebase patches
> - Link to v13: https://lore.kernel.org/all/20250908073848.3045957-1-ziyue.zhang@oss.qualcomm.com/
>
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
> base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
Hi Maintainers,

It seems the patches get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue

