Return-Path: <linux-kernel+bounces-871576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F250EC0DA41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C4518897CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60CB30EF7B;
	Mon, 27 Oct 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1r/83dx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1C30E0CC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568992; cv=none; b=p8XT3WAsPuqB8WBmpc2ST80CPeN9oKX52VHaIgHmB6OkLuHBChRO5xCYqgKwrFP5Y888L7V0PoR90TyDo3Wvky1jUayn4r4UQXPIWZD1cA8Ynr7cPnqFNmrxAuEvyfHOIKUOIPmeGCBsvJp46h3oOa9lC0uL2IHegbk+7xfyMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568992; c=relaxed/simple;
	bh=HpERi5uGFKaxtRcnIprvxmoHJmzJgw/6+EovG8r7mK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uhEVqQqlyp7syst4C3naT9D2tu+85d2JyLK8lja74twZ5hrw/h89mQBmzU/02lcprvhO9kdvFVOu8eK756FD/cxs2pC6w5wFKKpClC5atFmlODC/m1TffvBjWceJo/Gl2kLq0LUqFqSbx0YRXCpB+AUgvQ24WnC+jtUKRtKIluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1r/83dx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RBJe002546590
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdjmtQpetkz0YQn4BhbUe1OxkW0bA3u5wuojcjr81Ic=; b=N1r/83dxtRdH1PdG
	ld+vkrqOaa2GEiTAQUHgYE1tyMwJu3czrggpwQVCcOPbPbOcGSYZUofUgMs5Fox/
	o2F4/lpx/IkAe01l7HeFUzg69lLC32wCuDWwXr9rz6LxvSakesAojLTmf+XNbG2U
	aCv6gFavGvdqJsF0sxMrQPDPg6gSi1peGzsLhkAWN7SJgMXgVdUXyQSaeJByFY4R
	w1G9Vca4fBrpBtvOGyoD/ftKpEbjR2Buh+9A8nGonT/ZLbllZhIO3eR/Fx9h64Dx
	741FCKNv8sEa4hAOe4UrTw4XCuNwo18YSleuJ17FV1bmWGxuMqYuXrVlKmY+EFZO
	BUS5Ew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2g6ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:43:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a4f7e885c9so28244685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568989; x=1762173789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdjmtQpetkz0YQn4BhbUe1OxkW0bA3u5wuojcjr81Ic=;
        b=X+NMivD0uQITrt3dyyBzkPRP48rynjrYAqAA2OCV7/IiMwCJEddyoxFfMT1OA4bnFq
         C/BAKPaT7fWEYZL1lMSQY32BBpsIqzGmGrJrRt7HVbPNAoU0cdy39TWj2ye7J1g5RO/P
         K7mSeUINThftrqRE14Of+1Yfs232o1IxKszyc2wUpx2C+s8sXJ6Muoh1IH6yBXdPAQT3
         4WB572wWa+DQ0v2Y4wbPesuqTbqeMDpnMESnsmXaAW5SlM2KUtZJAfWfHrk/h+SrW//r
         2KQGxGuGVZxbNIeb/URVx1xjeZkUArunGwhW6oamPkU1o+xWzTrsFqqyeZoGXaSN0Z40
         kZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCXhPkc4se2jt8oqvH+Utx9NewNGkfF2nb3nfR6iHGI6wNL6wDvATxWEUc03OZ4FR/tRzvilASbyPQ0De9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rdRHXFr/7HXBqWmtsG1Jqrt+qUezwyi3ueLrzT1eOuCJSbTp
	J5Khl45Em7WilaSxLERXDts5x3FhhioerHWPpv8Jvx21AWyty2LnLArPJ7yUnjfuFhDnBbZMb5U
	qxNAeYUFsaZYxNxL/z+oW/VtIcAO9bHjEaDC2WpZGrVH6Pu2GKFRbtRO2J9d91JYFJ08=
X-Gm-Gg: ASbGncsuL9nJDiHmfHjQ9qONFJz9A8V6thh8Kizd+VpCE9x1vWZ84FQaomsiKFA9Qso
	iQ2bPhTCQpdcs3w+jI1WZ+VqXFoopS27HUdc7bc3WjCckeHqZrkVtoB0lBgS4olrDaBlcBHMgnN
	oIyTxZJPPnNOfSHTePaAATQ/OBu6vdFthszT/cvSt3HJmZoe9LHKxzQxXdxN2Hf/0p2cvMkKvvA
	tPsYec+4k0uPb3GQ1kB97vMSmSyh8EH9IBv5Dqxbxglgqrb92CKYyOPO8amhnlzA0ppyScTlL5E
	e4UkQmTL3qjymBKtDGJCM0HAmPEzsc6nz/AE+SRDkMAnEsTt4c1OKbswiQOJrpwJaQV71CyecHl
	iJyzWp66RsHSUQJA6DTe5eFk6jveDU/8IwgALHsl94tjp8q/o1z/7waqz
X-Received: by 2002:a05:622a:1a04:b0:4ec:eec8:e9cb with SMTP id d75a77b69052e-4eceec8f9cemr45634541cf.7.1761568989537;
        Mon, 27 Oct 2025 05:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1HqeE9MvodZNYXC7WwzDrvESBdzQm1TEemMfGCepQyLUEGzFaK7Rb8u7ydwVzQs3atb4nNQ==
X-Received: by 2002:a05:622a:1a04:b0:4ec:eec8:e9cb with SMTP id d75a77b69052e-4eceec8f9cemr45634011cf.7.1761568988857;
        Mon, 27 Oct 2025 05:43:08 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d854763b1sm747106966b.71.2025.10.27.05.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:43:08 -0700 (PDT)
Message-ID: <82971ca7-8f52-4350-947f-309e913a6886@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 13:43:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e78100-t14s: Add audio playback
 over DisplayPort
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021111050.28554-3-krzysztof.kozlowski@linaro.org>
 <20251021111050.28554-4-krzysztof.kozlowski@linaro.org>
 <51da0617-db4f-4c6f-9f46-0492e49c9a2f@oss.qualcomm.com>
 <a3808dca-2356-4871-83e8-c535cd0cce86@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a3808dca-2356-4871-83e8-c535cd0cce86@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HzZBWx8vwB2VEFKoaUGGl1tHHTk0SPep
X-Proofpoint-GUID: HzZBWx8vwB2VEFKoaUGGl1tHHTk0SPep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExOCBTYWx0ZWRfX2Z/5hzR4/yah
 O3F6BKDtlVmCuo2lGqWo3o/IEi/Tlt93uzb/vik6JT3SitXZ06fbgMSR2YhR78XGO1zy9QywDUg
 CAEyElF/D80y0Bk8KuxyrsXe0KTfo5WTD7fcI5ZfDwyxmfzoDVfXss1IaknrdoMkLFAW6eydjYQ
 P54Sjno+7Es2YHgNlPxKkQHHJ+RNXTmH3EHlhIRRtvuqOqdaIVUn/ldEldTXupO0b9tnm/pF/gO
 J/37PDH6iZQ4jLqfLho0ySqbSRVPtVLtLe4OzeT4JhxDUb9SmNVWKvqERO8DwYoSnHYEZFzSSVV
 EtH8Osr/XFGta9BPQxvICbTRPhRqg8ppJ0SYgPHA8MeCyu1DRJgJ8qGvpgZsKe5EcsfamaNEQ/q
 tVa8jT1yDR1FYpA/G7Yw9FVV+sT10w==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=68ff68de cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=7pKaQVV4AfFCDnn0ZdoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270118

On 10/27/25 1:38 PM, Krzysztof Kozlowski wrote:
> On 27/10/2025 13:20, Konrad Dybcio wrote:
>> On 10/21/25 1:10 PM, Krzysztof Kozlowski wrote:
>>> Add necessary DAI links and DAI name prefixes to enable audio playback
>>> over USB/DisplayPort and HDMI.  The HDMI port is not yet enabled, but it
>>> should carry respective DAI name prefix regardless.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> ALSA UCM and audioreach topology will follow up as well.
>>> ---
>>
>> [...]
>>
>>>  &mdss_dp0 {
>>> +	sound-name-prefix = "DisplayPort0";
>>
>> We should probably push this into SoC dtsi since #sound-dai-cells
>> is there
> 
> 
> Hm, that's important for user-space and represents actual naming or
> wiring on the board, so it is strictly a board property. IOW, there
> could be a board which does not have DP0, thus mdss_dp1 should be called
> DP0.
> 
> If you are sure that such case does not exist, then indeed we can make
> it shared.

On at least x1e, any of DP012 (not 3) host can be re-routed to any
QMPPHY output, at runtime, so I'd rather keep this bound to the DP host
index.

This is utilized e.g. for USB4 or MST. Or if someone has a fantasy for
remapping their PHY<->DP links for no good reason.

Konrad

