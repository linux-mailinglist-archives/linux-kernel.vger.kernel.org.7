Return-Path: <linux-kernel+bounces-763997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8644DB21CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3705625BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227011C861D;
	Tue, 12 Aug 2025 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dT4ntOO7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECD1A9F98
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975140; cv=none; b=HU2uIdOZfg6iyEcRvhEzUAOv193pYEH9+G618yR5Cmnr69eqw5qFz/leoXCrpDaD4zidEA+lGCJrG7bBfI+kg9I0aNaLiWpVGWdvN4MMSGnfEmxH0dHpr0sozwe1OtjDfnFbdpTSBywAX12AezRfkW4XXYOSckikgW8yFY2H4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975140; c=relaxed/simple;
	bh=QI1HnyqqGXFzazfF0kLLFQgBtZu2qOy6Z70INXj0J/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMFK0CcfBttRs+ZASSid/jgTXk0xp54802rZz+GiWiZjGH9Xy3DXKtyTzHy1ZUr2ptoO9B3ejzJ+6CKYG7cJ4J4HxWsTTuOKEUcTMiHx3Qbh/3/RqycXpCrndOBlTITCVNzM6ra7hhY1zpQR2yQuiWAvoYEcnQWTWBMKzdpuIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dT4ntOO7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGVEbn021319
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HyY1Y88Y0ORrgrBRfShLFFoDdBhRhqgMxdPtmHpsxLc=; b=dT4ntOO7AgEts2E4
	YibCqph0yiqXySfAbVfDMQyXjy8BzyR0G06yFNASqSGrokOQilF+Uach7JjgXh3F
	BAsFNKTXBqZLuhRrsikgqfA6lttMGBV6MHgiXUu7KILbfx/RNtRBYavp8X20n+Jr
	TRQBATkc445DLOL5J3Jm4DezeGYPw936RsOQstg0Rrg//ySTQKU8lqu8HhqEpaOg
	dFZpz4k7WcWCNvE+EPY6mdo1XgImRhwMJcoL/tisXbd+48fRs2eWgEtxKspEU/84
	VRJ2g4XSd6pWr3xVX3D70cNzmNyK4kiIrfLvjXNgC0HxiNUUczlDow/9VvzxoF+R
	3p80NA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vhq6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:05:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4310451ae4so6792108a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754975136; x=1755579936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyY1Y88Y0ORrgrBRfShLFFoDdBhRhqgMxdPtmHpsxLc=;
        b=Z4RY7Bv6mpRcgdgRDO7l8di5wzxWfs2Px0Pgpa4vRW+8b6AtqDKgJyhH2EB4CTiAsK
         CeT9mRAwSBrRHewRbxApy4YBRyE8rwqRhn1wgWIOWpDFdJCuGDGJzuK1gUFo2/oF07Ha
         LQJIiHZVItRw4cHgRX/wyILp2VUnmxoRyU8BL85ye8gsmumNl0oK5FF9Ttasef5MYSZ5
         Q5To+bsd0LrZfsmepUvcrH1fRge8X3wrW5G0Vtcpqq+tQST1wa7tuEYzu69wsYpTCpmb
         nDuWgDBXTXH6sQ59yw9P7C7B2uHT4o+9REemLzn8enjq2vzj9MwdvDzQJortrvTyFCVG
         5SgA==
X-Forwarded-Encrypted: i=1; AJvYcCVBPbyTzdY05GRp9/3lZbmBIZcver1Wx1pPizMl2xG/6iYcXHBHByX/+DtoaehztVdxD5j1s4qpk4mG0GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFAxl17UANpdDgRSslckve+2cnAJ2ld0UyISspT6dHfFDiq/J
	5Uw9bRk576RiI2K10Lrv1fomLwH9tRHCQETC9U1jFMPKcaJLMggxjKsge/Xz+QcGXfDe8aAi16Y
	2CBDsB3D0+peT2lDlpSCqYT+6Or+QDmZn0dqZ5+wrrDOEVks6jnodFw1lxAJKL+GX8DQ=
X-Gm-Gg: ASbGncvs4oE6xG2iXjjYE2bwB6MNe/KAAZUwWa1BAI9KF/7bRsbWNtjHPCTQtQsgVIe
	++hSTZrIURzmPRD22ZtrS7OrjtZO5TJucFY4lUKEcl012D56Fao1F3uyNd8VxgR2bNKFojDvBAD
	aGJcp32oGlq0MSJ6txPwWZS9Gm5Kvoh1XK0MP1NRVAoO3n29Vr10nI2CQZlbZ9VVyHkveNjy+43
	edhCj4ME6UlFrfzmDf/TCHuL6nV0Xya0dWpBB2Tfw0H1SsuyG4QpTIDFgtIBWA2OBDtN6CDaTDY
	ksjBnJK/6VbckrvIt+Csscek0+OaPMp/wfI+DWFYKQyUtJDoBXDXtmLH5WINJ4MPpTtU
X-Received: by 2002:a17:902:f68c:b0:240:900b:7550 with SMTP id d9443c01a7336-242fc21006fmr28005285ad.5.1754975136426;
        Mon, 11 Aug 2025 22:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp8q7iEcoE6icwUvjRib+HG6J9UgPT0yWBcxWWwYRBGOzentck67PNXD0Zcb1/vkf9fjph/A==
X-Received: by 2002:a17:902:f68c:b0:240:900b:7550 with SMTP id d9443c01a7336-242fc21006fmr28005135ad.5.1754975136011;
        Mon, 11 Aug 2025 22:05:36 -0700 (PDT)
Received: from [10.217.217.159] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24304c2943asm373085ad.30.2025.08.11.22.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 22:05:35 -0700 (PDT)
Message-ID: <ed0341b3-4056-4826-bec7-e835a6da4fad@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 10:35:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: qcom: dispcc-sc7280: Add dispcc resets
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com>
 <20250811-sc7280-mdss-reset-v1-2-83ceff1d48de@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250811-sc7280-mdss-reset-v1-2-83ceff1d48de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX+Slk5OCv+gnC
 +MV3BXO2K7TxEvwWlP5sT1gXvs79rdDT6wUJlJGivE9EcIUWwhuGeEbJRoONzB//rL11JkzUpR1
 ItfXhc9/E6rBkob83ngiFuGh0A1uKaDV0e9HymQqktntlgp/reFv2pBj/TGKy7acg/aSSKNXfsY
 5+OUOYW7GE7wtoV2HCPuMcellsu4Sc4y+Vun1nS0AtEE60V03GLVydXFOpqv9cMXWXvgE6YZ1bC
 6+zLhTzpatvmo3ydriIAUC2Tk+m8XutTOQco+pFSYtHQt957WuiOYHmMM6poqIvEbM1u3ry88jg
 XOpO3fdIKN37+MST8sguAsAgRP0rvm7YV/JwML/3a8ElQOOzRnVfPkCbc84oP+h9jwJV0UexU6j
 UHW80B6p
X-Proofpoint-GUID: 5E1WP46PcLADdahptWcjXjKMyAE3iFim
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689acba1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NNVWRqRCdYL-THHIErAA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 5E1WP46PcLADdahptWcjXjKMyAE3iFim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107



On 8/12/2025 8:41 AM, Bjorn Andersson wrote:
> Like many other platforms the sc7280 display clock controller provides
> a couple of resets for the display subsystem. In particular the
> MDSS_CORE_BCR is useful to reset the display subsystem to a known state
> during boot, so add these.
> 

In this issue I believe the requirement is to have a clean sheet and
restart the MDSS explicitly. Historically MDSS never required a BCR reset.

> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/dispcc-sc7280.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
> index 8bdf57734a3d47fdf8bd2053640d8ef462677556..465dc06c87128182348a4e0ea384af779647bd84 100644
> --- a/drivers/clk/qcom/dispcc-sc7280.c
> +++ b/drivers/clk/qcom/dispcc-sc7280.c
> @@ -17,6 +17,7 @@
>  #include "clk-regmap-divider.h"
>  #include "common.h"
>  #include "gdsc.h"
> +#include "reset.h"
>  
>  enum {
>  	P_BI_TCXO,
> @@ -847,6 +848,11 @@ static struct gdsc *disp_cc_sc7280_gdscs[] = {
>  	[DISP_CC_MDSS_CORE_GDSC] = &disp_cc_mdss_core_gdsc,
>  };
>  
> +static const struct qcom_reset_map disp_cc_sc7280_resets[] = {
> +	[DISP_CC_MDSS_CORE_BCR] = { 0x1000 },
> +	[DISP_CC_MDSS_RSCC_BCR] = { 0x2000 },
> +};
> +
>  static const struct regmap_config disp_cc_sc7280_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
> @@ -861,6 +867,8 @@ static const struct qcom_cc_desc disp_cc_sc7280_desc = {
>  	.num_clks = ARRAY_SIZE(disp_cc_sc7280_clocks),
>  	.gdscs = disp_cc_sc7280_gdscs,
>  	.num_gdscs = ARRAY_SIZE(disp_cc_sc7280_gdscs),
> +	.resets = disp_cc_sc7280_resets,
> +	.num_resets = ARRAY_SIZE(disp_cc_sc7280_resets),
>  };
>  
>  static const struct of_device_id disp_cc_sc7280_match_table[] = {
> 

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

-- 
Thanks,
Taniya Das


