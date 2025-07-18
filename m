Return-Path: <linux-kernel+bounces-737178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A1B0A8C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A37B26CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322A2E6D2F;
	Fri, 18 Jul 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ylh5KbBs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD22E6D2D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857000; cv=none; b=jlqgV654XqCSFcmDey0hv68HUOKXwS5Zd+yyIGcJT3a0CLrQhISWvK3JC5c0pUcOkKGKw1Npr4Ih35P9IEDEsfd36jeVErJSf/L2mUKXBERUSh9Aowt/riZRclLwLnuogEgKiJ3hgmyN94WRZSOZ1zNp8pUtig2G6rOLfkocUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857000; c=relaxed/simple;
	bh=zl2XmPcla/ndXnFDbA+nGwqG2fJeK4/YvV3eHZew7Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=An7bVHVSjAwYkBx0uhloX0YRdkieN+fcPBs7RaXnWoGR22420HFhlu+PtNPzluNgf4oUTFz5VF/WyDM4W+Ecxx4ezY9zsGQapCl1Gc+Pj6B5zntc/5NTLwqyEAJK6ZDzSpuOO9DXGXO+1YO7qn0dzthrHbykA5aDUTNP8e8jJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ylh5KbBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I85TxI025441
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QS06yXcjbSspxBecv3JOOSas1/fugGVTr9GX0MVCJoQ=; b=Ylh5KbBs/AhTwKD8
	TbrkOekYjnCBffFWkS1xyRuNgd3RfyLJQRqK4iObww63pTiV4qFZMZw4es7MltOv
	g7LWTunJ6cl9MVutvxCqXrg0tKcrVAe7dKyhKLo8bRwitwrVGRHgBdllSwm9Dk6+
	mx4rNbY/he3TeIme6GtenjG0hdJ9Nfm8H8+spvFVPS17LMz4HBfivSFsLyuH+oVj
	5rI6ZIYATcmEr9QKCMbatIjr/6RFPq03ut4ztcNVD5A/3/eZXoRUK0AOIqcJQ5HY
	u8xMCdpBvoxgi4jJt4jdcXt5ojaIF97VkUEiTITTvxS0Ce8hUoYaPq7XtnSEOUjI
	AdfVMg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqgfq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:43:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso2408235a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752856996; x=1753461796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QS06yXcjbSspxBecv3JOOSas1/fugGVTr9GX0MVCJoQ=;
        b=aHPt4dbQVVfvgJhmYp0g4Q4qOb7NVjRtsyu12sabaeTpMKO+qHf31PrUXkWj/CkKSS
         qZhw2NlRuacJD8B+fXEGoegu7v+fSdEZ9uUUP9K/Hm/dvWDJ6HckJvW+28tg7BHaEGiL
         rOK34KiRK1cZmAU7DO6b3jh+xmX5IF5mZ+7VQJk7NIdFGvNGIdNVeqIsKfvIiaFrzK0Y
         ZikCe7XgD+lf74cv9athkb0MCAQOoH8hJ1cQSpv70RcUPHZ3id45Bs3o/up4MJUvnD5i
         caqW6/NfjiFTz5RA/XupolBrT5Dgv3WL2yqwpEu0QvPEOlJrLGjk3Fb+nWlqc4yKxfaq
         ai0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4Ok97RyZZiC9I6BP0HdS4OB+ZrIsNlCpm7LzJbiPj8jkYU+EJTMNQHoASVb99RZz4ySePKcjYHTxDm0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8b6wtDf1g0i5qFdxwvJ8Xc06AdBMd8T6cNT8RN795daXG3k/
	P1vE93m3/QrNNEazd5mFdmS/pkj1b/0p67K0IM+UbZM7/7EwaYGzd2Q7GqWlL8k85oOuR8MPX+Y
	v+txR7J7nFilnJoxntF/VXgp1wNK9jVZxbD1IkT0GzpzEq9kJJnG63lfDr09z1b2oaCs=
X-Gm-Gg: ASbGncs5yrp85O2+Y+cCjBRPzjwikNLyGoeI4xzNVi0G6K8NrIxMnfzovBFV+L4bS8a
	sXFwzfEUGX8poX+/snHqY1eQ+FJYinzdlIdr6ZJy8Jli7Gno5k4liLQJwmAxdin4RHaFjDItiMq
	GhyvMAMvir6yAeqPXIQKtX+LquAz0A/PSRe8Inioa4P0nBLNMZhYB5xXdeTvIE+PG0tRpTy9QhZ
	FpA3IfrImYK6JyBA05kgby7Arc4odS/DOnQbi5y0NzlU3e/YeX1iU1e9XSENfFsNTrP88Rn6ivl
	+fYjOMZG4Y9Cbdh5ajDbaLoOtchEONFk3oRSgYvJbMWr0Ca9wfNaD4e7hqFjq5xbhCPy6ytwlVG
	Ku/kgGbrhvMR6sjBjgxpmDw==
X-Received: by 2002:a17:90b:1c04:b0:312:e9bd:5d37 with SMTP id 98e67ed59e1d1-31cc2515a29mr5615547a91.6.1752856995999;
        Fri, 18 Jul 2025 09:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+SiK5x4mKGH5S3TmuPOs72xqUJSROCjvf33zej2kjfIp7ot9LWhtsKx+NbT7x7Y+uEruIVA==
X-Received: by 2002:a17:90b:1c04:b0:312:e9bd:5d37 with SMTP id 98e67ed59e1d1-31cc2515a29mr5615498a91.6.1752856995510;
        Fri, 18 Jul 2025 09:43:15 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e61d2sm5340211a91.11.2025.07.18.09.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:43:15 -0700 (PDT)
Message-ID: <f59a6654-e04b-4caf-a570-16016fa4be81@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 09:43:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] dt-bindings: msm/dp: Add support for 4 pixel
 streams
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov
 <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org,
        Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <lekqhgqzb4iimsu44y54cvxbasux264lbuqsbssj5nd66ocvji@nfuxnyukujjy>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <lekqhgqzb4iimsu44y54cvxbasux264lbuqsbssj5nd66ocvji@nfuxnyukujjy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687a79a5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=1IdYYe72uQdTEr82hC0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: eupofcofBi94mE78dsuyCQVyd5N1Y9MY
X-Proofpoint-GUID: eupofcofBi94mE78dsuyCQVyd5N1Y9MY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMCBTYWx0ZWRfX90+yuKJ6tp7G
 h5ayXLLHK7C3YFoMLpEk8TCwmHNzG+3WNwdw1FPEr8xl4lifHe5/MSreSa5CdEx5278KONmuUtr
 TELEIk1AITxLPpJtnP0J7eOMmY63D0HyNfHguf+e3zsQyezb/RnuI1PsrM2Ca1sIgBXFUtOsu5U
 v3Om3PNF+6OhHaSvapJm2QCYUdkiM0QaU8PjU+iufYPbCWbSG5h3uGZ4D3Xk/Qd7DkG5h4Cgccn
 7GIpUg/BXw47rb6LMor5Kg9JDrP2FLWX4EC9Q+hBluWU3E0335fQKqN+y0jSavvYTf5VdPMbNYJ
 vQVy26N8VEGdoxMhh+xmQDvaxh/qFM+p6Gh6Lnnsjkq+tMJh71iiTbQfVpUrDEng53Wcl3boHNV
 zghVuAkvI2JefTvynPmvsQDZCXXYW115I6kWRVhJycu+Er++OdDU0psTZftaFv1sTxcRdJKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=976 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180130



On 7/18/2025 2:22 AM, Dmitry Baryshkov wrote:
> On Thu, Jul 17, 2025 at 04:28:42PM -0700, Jessica Zhang wrote:
>> On some MSM chipsets, the display port controller is capable of supporting
>> up to 4 streams.
>>
>> To drive these additional streams, the pixel clocks for the corresponding
>> stream needs to be enabled.
>>
>> Fixup the documentation of some of the bindings to clarify exactly which
>> stream they correspond to, then add the new bindings and device tree
>> changes.
>>
>> ---
>> Changes in v3:
>> - Fixed dtschema errors (Rob Herring)
>> - Documented all pixel stream clocks (Dmitry)
>> - Ordered compatibility list alphabetically (Dmitry)
>> - Dropped assigned-clocks too (Dmitry)
>> - Link to v2: https://lore.kernel.org/r/20250530-dp_mst_bindings-v2-0-f925464d32a8@oss.qualcomm.com
>>
>> Changes in v2:
>> - Rebased on top of next-20250523
>> - Dropped merged maintainer patch
>> - Added a patch to make the corresponding dts change to add pixel 1
>>    stream
>> - Squashed pixel 0 and pixel 1 stream binding patches (Krzysztof)
>> - Drop assigned-clock-parents bindings for dp-controller (Krzysztof)
>> - Updated dp-controller.yaml to include all chipsets that support stream
>>    1 pixel clock (Krzysztof)
>> - Added missing minItems and if statement (Krzysztof)
>> - Link to v1: https://lore.kernel.org/r/20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com
>>
>> ---
>> Abhinav Kumar (4):
>>        dt-bindings: Fixup x1e80100 to add DP MST support
>>        dt-bindings: clock: Add SC7280 DISPCC DP pixel 1 clock binding
>>        dt-bindings: display/msm: drop assigned-clock-parents for dp controller
>>        dt-bindings: display/msm: add stream pixel clock bindings for MST
>>
>> Jessica Zhang (1):
>>        arm64: dts: qcom: Add MST pixel streams for displayport
>>
>>   .../bindings/display/msm/dp-controller.yaml        | 53 +++++++++++-----
>>   .../bindings/display/msm/qcom,sa8775p-mdss.yaml    | 14 +++--
>>   .../bindings/display/msm/qcom,sar2130p-mdss.yaml   | 11 ++--
>>   .../bindings/display/msm/qcom,sc7180-mdss.yaml     |  3 -
>>   .../bindings/display/msm/qcom,sc7280-mdss.yaml     | 12 ++--
>>   .../bindings/display/msm/qcom,sm7150-mdss.yaml     |  5 --
>>   .../bindings/display/msm/qcom,sm8750-mdss.yaml     | 11 ++--
>>   .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 21 +++----
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 34 +++++++---
>>   arch/arm64/boot/dts/qcom/sar2130p.dtsi             | 10 ++-
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi               | 10 ++-
>>   arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 20 ++++--
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 72 +++++++++++++++-------
>>   arch/arm64/boot/dts/qcom/sm8150.dtsi               | 10 ++-
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi               | 10 ++-
>>   arch/arm64/boot/dts/qcom/sm8350.dtsi               | 10 ++-
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi               | 10 ++-
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi               | 10 ++-
>>   arch/arm64/boot/dts/qcom/sm8650.dtsi               | 10 ++-
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 30 ++++++---
>>   include/dt-bindings/clock/qcom,dispcc-sc7280.h     |  2 +
>>   21 files changed, 235 insertions(+), 133 deletions(-)
>> ---
>> base-commit: 7a88d609b069b7d2f4d10113b18fea02921bedb1
> 
> Can't resolve this commit either in Linus's or in linux-next.

Ack, I'll rebase on top of the latest linux-next.

Thanks,

Jessica Zhang

> 
>> change-id: 20241202-dp_mst_bindings-7536ffc9ae2f
>>
>> Best regards,
>> --
>> Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>>
> 


