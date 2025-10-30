Return-Path: <linux-kernel+bounces-878187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E195AC1FFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5594219C51FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D832F2607;
	Thu, 30 Oct 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aN2y5qTR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hv+pWHew"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891519539F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826873; cv=none; b=l4sPWso3dhXgCJoqPU6gM1HD2OG77amBDGME4/TiE6Ew7e/PfBKiGTfMYUcO0GSgKnATRjybjpgB0u0LGE12WGldC1OHzgVytPuplyTyuh5wv86hfxesZuLCV7Y0PngwKW3rG+ir5PI7ZoJ2hbI9+GVsm2WP5cWzMhUAXgTu3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826873; c=relaxed/simple;
	bh=BtClwc/SBf8PtBQY1f79oGGMCj6JUP94qOT273TptgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkPBbvdr6PrPMrDwsxneikw0/qGq56lls7thDHTRZNQg3g2+f74+208+OaXQQL2KHgWxgnY0utMUQ6teP5gTKItr80HD51G3jEkHYmsIrhDNXpcZNHLHSRzrURmwYGhkWSSFiLjgT4lAMDHDhP39AIBDoAajPFCEECOExsRCWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aN2y5qTR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hv+pWHew; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U4xhCB2623030
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8u/d9fdIaldMlj+IUObUL1xUVuajEoWHiVt1WYY4+8o=; b=aN2y5qTR6+HqHbGk
	1Sz3ZlwyuWtpaqPQyNOZWA48XBHZZvnXK0/pltTCzLseexL/RCUQiGEl6sBnkRb3
	mKhLumvuW+9M3UdTFDFZTzqBp4xUaVnjub185VOxg6HLx4K0fED4jvykRjEA9iRG
	Pt0xVaVR/5kWWPJ9loKMnOFauuL0yWc+kPGT1o8OSu5YZUFJzj1R27/c4YcaJTsL
	pK+ssQC8i4QKfIQ85gTiOBWRXpUNJgeIcyJAHvPqR1CA7ZCCOBXkmE8sS/0/lHkH
	tx1GTqodp7jpcGbmXloZb2vsuPW8L0vEbhm585peptBU2h3goNyB2OPmrbWfp7lr
	L+EncA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a41fxh7jy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:21:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2930e2e8e7fso7471765ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761826869; x=1762431669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8u/d9fdIaldMlj+IUObUL1xUVuajEoWHiVt1WYY4+8o=;
        b=hv+pWHewUIBDHriTHrsnPSopOIgsAtXlmLo+XvNyDwc/hRDqkpEFNFEm3d4nK/8gwM
         urtPMtkox4nQsq2h37SCOHcOw1ktxfE3GfmjP1Uh4jK5KnMZ/1Go83+Ed3mcG4K4YpNJ
         alQK4HJT7Um/MksWtUHux7NYXeLxu7O1eFOA/olSWc9k1ZAYhovz3UO8zU4+S+CPLHP7
         gsYDud1HlZmddrUHY2FEek/p67BxLyGMvuDwsVeiOfcuLxHg3wmZZyK1TbrFdAXV2fND
         AUD9Uhz2sUid/NV28fkYPJNeZkH82IgErWCRnPiQwutUeuHeop1bDrIBlZ6/4J/v2LCl
         clBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826869; x=1762431669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8u/d9fdIaldMlj+IUObUL1xUVuajEoWHiVt1WYY4+8o=;
        b=VZFEL5aPto6+S2f7HF0dbKVBn6/rrsqaymzTfRNjOLOCcUucAFoTV+j0LpMEeac4VT
         rB9wbN4nokzgqLW2Yk4v28d+njQ1mmIvo1RwnGbUauYYxhqSLCO86fpN5cPvQP/eZvo2
         YVRclatAxf23iysRZ3T7lSKAMOPSYPisHTzcl2RXacrrI9/pTnUBj2vxU4BPYykFb4eJ
         hRJcytMV33U8NAgvdcFYu3Y2PQPhw/XtiA7KU/UYA6hTEX3pFUKyrctpF9Px1gsngp54
         FhmPpCoWHVhBva/S/oLMMSovCLzTyYgR1ykVd4yt2cbw/P1T8/VYzkny9aVnw0hgNy2f
         gSIA==
X-Forwarded-Encrypted: i=1; AJvYcCVsWQPFEAb9jYxjA9TRyZ3afZPPZaGDeVVQ2eVWmc0i8e4+31O17eycIIFaOQi+53MhtRxS0t+WjdWU5J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmbS4RfPzLI2zQtGoFeniOeCJr/Hu6/gKqVur4+xUjwji+JPaz
	lqKTUBXKAsNwGpPe+HZSdYax2KR2xxDWRNDS3SeWUmTU0bBlidhHsdApl85Yie9Yvlf/kQrYuup
	WSa5X1D5oaVKuWyCnGYHgJaZVurg9MRtnfRPmXKnjI2decJVO83xXFM/4V0PP/LF1DmQ=
X-Gm-Gg: ASbGncuW3o6cJAV7+p+5AFiYWH7dV4JT0FHzIgxME7NNZjkbKGP0EMHS/OLVxNjCiAy
	uemKtvj7n2tzLtWseEMwzFts1DwG5nY3IDy/DLpyp4kB4bbP6wgRaHSx0EoIvSaaBMuO5NZcLsa
	d0Ui0dp1zWeDhJsbhtH429Klbeneok9LHsaTlIu4nQMxtLuLZ93y9hZegpATJCSNhXrwS/h7BmB
	GSvymdwNWOyMtqJM35sR2qivI8yZavYYtGCRIQfjiq35ykFhYGcxVTTl2ze0ddCdXJ24q0sfG/d
	6RT5q+CP4fmiAnTHioNeU+YxDryGLmmfkJQz+pPIl65D2gv5D7OREdpsl6rJnbEiWS6ofASX99i
	7tKx5XLf+MZvJr80Ttuj2x3sh6tA=
X-Received: by 2002:a17:902:c403:b0:246:7a43:3f66 with SMTP id d9443c01a7336-294edb935b2mr38687025ad.7.1761826869176;
        Thu, 30 Oct 2025 05:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9a+1g/H7YMX8/5719QDerZeZz7R1O7nnHZuhhQfmWjkfEEoOVbjmAyEBhWoR4OGVkuIGDFQ==
X-Received: by 2002:a17:902:c403:b0:246:7a43:3f66 with SMTP id d9443c01a7336-294edb935b2mr38686465ad.7.1761826868367;
        Thu, 30 Oct 2025 05:21:08 -0700 (PDT)
Received: from [10.204.79.108] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050ba1472sm2466032a91.17.2025.10.30.05.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 05:21:08 -0700 (PDT)
Message-ID: <58a658bb-7338-442f-ad8c-845b5fa5ce00@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 17:51:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/WIP 0/4] arm64: dts: qcom: sm8750: Enable display
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jesszhan0024@gmail.com, quic_rajeevny@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Abhinav Kumar <abhinavk@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250424-sm8750-display-dts-v1-0-6fb22ca95f38@linaro.org>
 <w6f3s56gx7psqgweuntqvkzrot7elhc5pdrxhvenukzwyt5eys@fndmaszfbo5k>
 <921afe20-42b1-4999-b5c4-035669dc831e@linaro.org>
 <32eb3b4f-b2c4-4895-8b48-ade319fd83de@oss.qualcomm.com>
 <CAO9ioeWdJpKfpu3jGyv42Mf5+02ehxyEu_Lj+Boz0NyDjPZ-CQ@mail.gmail.com>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <CAO9ioeWdJpKfpu3jGyv42Mf5+02ehxyEu_Lj+Boz0NyDjPZ-CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kjnYfmSE6e4u48Sy4ezXqOeNZk6LBf3q
X-Authority-Analysis: v=2.4 cv=UJrQ3Sfy c=1 sm=1 tr=0 ts=69035836 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=RTWzoQZwi2ic3pXUtg0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kjnYfmSE6e4u48Sy4ezXqOeNZk6LBf3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwMCBTYWx0ZWRfXxi7MkFoLLPXz
 2NL2C4tMrLe9CUuD2JfeHQ4NpD+TDKS9pmLEZ2cDz0TQ+LsqKlkjnr+09h1hiJ5Q7cAZXtj53gl
 nZ2SRTv4QeJI4u2EYDQhku0G3xS1bzF3RveECCwkDbk9H3j/aVZJlh5Rpf1OfGVqBqGLmc1gNXr
 Xnyvavoz6foxR+9ck5IMYCdJra3Vqz6poDuhsz4kdCT6+PhoYz/geHV+PNyMxWgk3ZiOHQOpjlT
 zaBlNai3E6Fray/DWOvbrN1IT+i26B3C/fJkJtCecNwFDKmLD1f3OC+g7UCLcRi+9779FaMBvVI
 8ri/JkrXYtIqsA87bHTKJfOPVz5OsT5l8hl6HKgNHbTVVYA+/3f/Hpr1H8W0mfDcPbbdhTEn2pC
 nfH8cYNdUBAhwqDeHyFdp/xyL+r91g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300100

Hi Dmitry/Krzysztof,

On 10/30/2025 4:46 PM, Dmitry Baryshkov wrote:
> Hi Mahadevan,
> 
> On Wed, 29 Oct 2025 at 08:20, Mahadevan P <mahadevan.p@oss.qualcomm.com> wrote:
>>
>> Hi Krzysztof,
>>
>> On 4/26/2025 1:24 AM, Krzysztof Kozlowski wrote:
>>
>> On 25/04/2025 21:34, Dmitry Baryshkov wrote:
>>
>> On Thu, Apr 24, 2025 at 03:04:24PM +0200, Krzysztof Kozlowski wrote:
> 
> Could you please fix your email client to _never_ send HTML emails.
> You've destroyed all the quoting (quotation?) levels. Your email was
> caught by the automatic mailing list filters, etc.

Thank you for your feedback and I've updated my email client settings to 
ensure only plain text is sent going forward.

> 
>> We at Qualcomm are currently working on bringing up the DSI display on MTP. For this, I’ve picked the following patches on top of v6.18-rc2:
>>
>> All the DT changes mentioned in this series
>> [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d merge
>> https://lore.kernel.org/all/1154f275-f934-46ae-950a-209d31463525@kernel.org/
>> [PATCH v2 0/2] drm/panel: Add Novatek NT37801 panel driver
>> https://lore.kernel.org/all/20250508-sm8750-display-panel-v2-0-3ca072e3d1fa@linaro.org/
>>
>> However, when testing with modetest, the panel appears blank. I wanted to check if there are any additional patches already posted that I might have missed and should be included.
> 
> Any errors or warnings in dmesg?

There were no errors seen. only panel was not lighting up. Got unblocked 
and able to validated modetest on DSI and working fine with this 
workaround on linux-next
https://lore.kernel.org 
all/20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com/

> 
>>
>> Also, I’m curious to understand more about the DSI PHY PLL VCO rate issue that Jessica had narrowed down—could you please share some details?
>>
>> Lastly, I’d appreciate it if you could share the plan for merging these changes upstream. We’re aiming to enable display support on this target as part of our program.
> 
> Please see Documentation/process/, I think it describes the process of
> merging patches pretty well.

Sorry for any confusion in my previous message. Could you please share 
when we might expect the next non-RFC version of this series, 
specifically for the DSI enablement patch? Alternatively, if there are 
no immediate plans to post an updated version, would it be acceptable 
for us to take it forward and submit the subsequent non-RFC versions of 
the MDSS and DSI enablement device tree patches by adding dependency to 
this https://lore.kernel.org 
all/20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com/.

> 
Thanks,
Mahadevan

