Return-Path: <linux-kernel+bounces-807524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10590B4A595
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8B9A4E259D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D26F255F31;
	Tue,  9 Sep 2025 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SamWdDe4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED9253951
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407183; cv=none; b=pOOQoKqTed2vZtmAbIXEPT8z9al41T15rrJuG2p82/WaTvC4TGqqI5gmAkb0Sel6I/SBZbkzH7vxsqNyyny1oxj4mkMBy8WkSfKhbEbGM4LKVJeCSanTy6/3XqoauXF73n8UsjVtO/otMedxbPMpEhh5/hw/VEzAqBbgP3oWjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407183; c=relaxed/simple;
	bh=CEpRgykXgmcUp1jg8eyRMU+1agl/A+ACDsCB9TJ+jLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwf2HHcGnW0+78nRDnU4MM9A78F/mGerV3xcvpg85kCRamhXlzAiqHUl9qJNGFcsA5CAJDOsw1UNGlO/NuKPObdDejYrV9zqmJiPtZtej6cJk0Sg03gYA7qJDzvWz8Xtrwk6bESeuyjxLC7288dl8b+lxn4YNJQ4waGS3tl5Lp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SamWdDe4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896TLmH029685
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TDpymrykwq2D9vEJfSPg+EEbvFuEeU+GWf9UCfxacp4=; b=SamWdDe4fTtbgA9R
	SvvGuYQtNjyLflZYkoug3yceJxrIesUeSQEEtWJrQJpvjQfSWzSIBlPsD5h6IQXx
	0IrbpslAYVraUSdlu828cic2BkGX0/LrZpbvFAFQ1tcaVYm1F4x9fGNo1xxcCOZy
	BCc5vCmrgUgOCn0uVBtO4YWExFS9Zist3V6gRtOnX8paRmBWFV1ToqtlAM3opInu
	eO4xORvJRD+ZsGS0bDSiWfSbwTzRI5zlNamN17RzZyD0D7CHI1tSq+UARJ7qVmqV
	M7L6upjLJifW3ToswczWfx+DxFTyrCZSaCzUozoELgOFR6xrKT+K/I5P5GNxCyQV
	IS2jfg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfyd14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:39:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32bc6306d47so1189421a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407178; x=1758011978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TDpymrykwq2D9vEJfSPg+EEbvFuEeU+GWf9UCfxacp4=;
        b=ns3my4jAiP2DtNwYX7djhvBNgaXbtpHyM3x1WYdgScK9vI6b2YKzv69rfecJgO1QtR
         /n6c9ircYy+KjiIKSDvhOwNrnBTrcI+iSQTdTrSoRbXhQ8sOmSFtNioOH2X/X5xSPGUA
         gCVxXPeTHAqAU8n4HVK+NgCCAivxe8GLn/41p3L05AQbKEhk83Ol1BpDtVtWyJeA7QjY
         EZInh047bBv94JWmkQN9b/G/DUbyOnIdAIFjkfDtGim7nSX4wMC0IAsiyI88Ad9A9RD/
         haSP25bJdyIS2xzo8AL62FeRhr2rUO7VPH12RPL27IFEVRiSkRWORfZkrWziOYKHzJnK
         IqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo6iGYD+zuw6A8UpvSHfIql4PfEq1+CZ0tJCvExcYmNMHksHfBs06ueF7MHA/yoTytv2laHH8sz4PZEiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9wNMwuXgv30JcZdvyQeuJ7e4A7VrsZVE8qfPRpDBnu92Tf3s
	ojI0GYYeZHnSsv/GzWF7ZTJpNRzDmeShMoOaqTvsFCgn6j+n53iuSbE+rAFjzFOSlETUdBw9Zk8
	VEHZGUwHfAsJbMe/zpD9mIJ8cZNuIbxgexClD3W7a0acGGCNcK/teEwahuD5vY6mKJXQ=
X-Gm-Gg: ASbGncsqKVIEAu2u6wRdRw7R1YVe/swEr29cCVBszf3Ys+iY+aMG8axE66Z/Kmp7R7v
	XEFIq6kdCdvraC5+oaxUrCf6fOJdSW4d2RaaanK0w6CBo2FIv20obmma2ZKiI0YDeyT4j8gzJh1
	srt4g5VxmLdeEJ+S1RaRlnQhvBw1B2GNHOOdj+5454Z+AnVX+iHqZzwfX6HXZeKM41OlyjY7nQH
	38ufzy972f8Kn9srzt7tRLSn3lPgL0MWVVon1CaCFfrNbLL4c3SOUqon0CEU6CmGcfxzzgIOV8D
	tispiaVhTTe/UJPyKKiHpvSJQoP5OWqtAL2nqfFcVLmf78e4yUOPXSJPCmIz2QqTgX/FR4WwnCt
	HnuSbGWW9NdUcg+tWEOHaLr9yJ69Q+g==
X-Received: by 2002:a17:90b:4a92:b0:32b:87ef:5faa with SMTP id 98e67ed59e1d1-32d43f91aadmr7805301a91.4.1757407178379;
        Tue, 09 Sep 2025 01:39:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7QbVcmVO7aZqm/k5QXoWRXC9zn0nVpx+dXw+04HHeABOWQ0WWeFhtm+A8ZDuAd6zzUqgtWw==
X-Received: by 2002:a17:90b:4a92:b0:32b:87ef:5faa with SMTP id 98e67ed59e1d1-32d43f91aadmr7805263a91.4.1757407177787;
        Tue, 09 Sep 2025 01:39:37 -0700 (PDT)
Received: from [10.133.33.137] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57b227sm39403466a91.6.2025.09.09.01.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:39:37 -0700 (PDT)
Message-ID: <c4eeb8a8-2819-4ac5-8dc1-cce209d7cbc4@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 16:39:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
 <xurpc3mk5kksx7lfpsdqgasov5gc4dpsmz6iv2hjhsp5tewbue@dvrupbjzgxle>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <xurpc3mk5kksx7lfpsdqgasov5gc4dpsmz6iv2hjhsp5tewbue@dvrupbjzgxle>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HiGea2XMG9CgzpVaE-MP8eEHrciK2jQh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX9Bynp3bzbNiv
 sFXbOvzO0BvqMx8WneVZ19osTkQv9wh5KIROxzpW+LiUx3jZBW0zUY+7TuI1YiatPn+sUji0WDZ
 TnQVc8qxLLsDSdxNPNDDhifX41qT6hv1MtuFf3t3FQljGShWDun3Ts8JQvKssK2cuQAypB+84wT
 KX1t3ojgp3rVdWDx4xdFUBVnknuzEBK24kY/qrDU4yOTfnN/T0YM5F8pG5Ev7nMarRKZHUMQjyd
 Eaw+rFKyc2VdG7TfhbFleLzHUpTiL+GYgAHS2iJxB4SbQ/GKrdtY0arhgGs8LQCIoRxqiyJs3j8
 oC2jTSzyeT7JXLYrNrgot5b6Rp67llJVSPTLixyyGm493Q1Y697zoI3D+btNAv1d2D59fp46K88
 Kawhg/Zn
X-Proofpoint-GUID: HiGea2XMG9CgzpVaE-MP8eEHrciK2jQh
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bfe7cb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tCOpKogST-nIjDDcSvwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035


On 9/4/2025 8:34 AM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>> While SM6150 currently shares the same configuration as SC7180,
>> its hardware capabilities differ. Explicitly listing it ensures clarity
>> and avoids potential issues if SC7180 support evolves in the future.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>> @@ -27,6 +27,7 @@ properties:
>>            - qcom,sc8280xp-dp
>>            - qcom,sc8280xp-edp
>>            - qcom,sdm845-dp
>> +          - qcom,sm6150-dp
> The DP MST bindings were A-b'ed and R-b'ed by Rob, so I picked them up
> into msm-next-lumag. Please rebase your patchset on top of it and
> resend. At this point I'm interested in DP bindings and DP driver
> patches, the PHY part can come up separately.
>
> As for the compatibilities, I think DP on SM6150 should be compatible
> with either DP on SDM845 or DP on SM8350. Please choose one which suits
> better.


Sure, I’ll split out the DP binding and controller compatible parts into a 
separate patch series.

SDM845 seems not support wide_bus, while SM8350 looks closer to SM6150.
But I noticed SM8350 is still configured as SC7180 under dp_display in
msm-next-lumag’s top, so this change will mainly about the binding, right?


>>            - qcom,sm8350-dp
>>            - qcom,sm8650-dp
>>        - items:
>>
>> -- 
>> 2.34.1
>>

