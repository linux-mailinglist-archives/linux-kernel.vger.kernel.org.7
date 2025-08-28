Return-Path: <linux-kernel+bounces-789809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B04B39AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF177AF49D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836230C624;
	Thu, 28 Aug 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkzNktIe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57C262FE4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379117; cv=none; b=AAKQjl1zR0jOlqrlwN9Az4YBo3DuJiGTTGJYfCvagEbWhr2qXcrJ68bBHyhB7uoFi+WNjlBy/NwMK4+7n4v6u2SAqOmEsVwO1IdnllH1BjKkolwnvGuR4FJqLP6qGZku0iaKPTyP2FNJZL/OfJBIw8+eYMMH3jbY7POTWQDmEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379117; c=relaxed/simple;
	bh=e03dVCkvTvpanWPDwCJj9vnAVCkN3SPLyZbfuEJYznY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhHzl8iaUtUi5g90YSfE50+ZIjENq8o1N5ujKKEQS/kNYN59YT+RVWFRJuhpsdPtw0W+SpEAgcLn6afO1TgcwwqoOEc2nGbJw39eXKF4WQIUuf5IVu+mKkqyS0J4dNGnllPzPzBYBd2b1RrNSzk4dH5g6bOjAPsUdsC49XbbpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkzNktIe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAE5bu007248
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWz4EmxyWXf7dXG5o/SW5rNMyyXGmYaGBN9NZMKjXjw=; b=dkzNktIes08QLczO
	hlxo3ShN3hIS6b4EPWNK7XpY0ycS08KtG+q8doSF83aKpqd8BIjg9xWQfREPwSgH
	MQNIkYh6KYv64gvNZgoCoJKybu/BjmFW3o+p7V0K78upoKCyHZ2Bw2f6Ak14MLdK
	HGUgeeSx5sYiI6+kuCH31IWr/5fNHnVVi4iPifl//6dCEHs2spk8IfxR3r96dODv
	jfXHjwiWOdPTWCYQT7zTp+2bCJqHQQ8Xs1ZProWWlP3TLDlGCvVlz7COfXqLDPhD
	2gtdzc08CYCrgXLmuh8p25hghTl8KsKLuHAfPfMY1dahPyKzPoDYFu7Jqxb5PZrK
	EVWzdw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67g4j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:05:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f55eb56so16836536d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756379113; x=1756983913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWz4EmxyWXf7dXG5o/SW5rNMyyXGmYaGBN9NZMKjXjw=;
        b=W2rAA6aVVKqak2OdArOgl46WJzUmty30uvC9FQgwKG3lhUY/IE4e0TWwMT/bheHcg1
         ZtUmXLekKJX3ORhBf2ReFHqT9Sh2kOAhOVOEO363beoN/dO1LL8Yn5hvbC3geJr47ifV
         /rUwF3vKZdVtW9JA6SaTvSOa8s6i1ayB7i5fymkJn48JqsrzwSBYZxABKr/GD8A75vqC
         8ESrJvgEXo64YMtoyp5KAMalKnhBfk9UOBSGtQXkpD4j2L65y8DZui9t9kBbC4m6vLkV
         Cd8jDgRissG8P1fOO8HlqLqoZcx3HHAul1tFZTK941jeQNMnvVSnAorjGZLPF7MsfKaO
         pm/w==
X-Forwarded-Encrypted: i=1; AJvYcCWkCcNPwD+bLtmgSM7K7GCsNrsYxU8Z6wQVE7RED1BfVqh1DGxlGhc4ZkWrblQi6B9xTDw73ZyUB4kQVU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3E0ytjTJmq14/164MgBVr9pwILuInyZiDQBpITfO+0j3qmXYn
	MLQ7ODItfKtzFzr/PZqbXSsNK5PAXO07ghnvgQpZoTWcb7xYD0S5szalc/9piD10SBwKthU45ed
	wKRdp8gMQCqsB60haz3QtJQVQKDEyIzhE5PHmCr9IaKJWXXwNqNyF1EGGOsgqYQ1d4Bc=
X-Gm-Gg: ASbGncvX+G96/jJqmD4e+SWlFM91/uK3Kf3DmYRSDmLhh5GBO0Nmoat6/7n/1fB3LMx
	7Q+xDe/8ZzkUlBl9SrWgaz/bTXdz53/3DFcNnMvg964j49XkZs/3vb8TRhl2WF/YcQ9ogqVMwbc
	Tu6igMzM3CoAogdGDNCr3eiEryShle226GZLAHJ65ttdXlIGdtfKOfMvnZnan9irrhksixta6jj
	ej5ll7/HKmtR6JS8zRJt8HWsOfGFPzCGcyf+bL3dw4pP1Xg4a+O5At9uZT3oMiYZBYD7BGO8OiY
	UX215sDEjSBjATNC8Vq2PINuBDmrqRukjSQH8UULEkLj0n8tHX13Kkh00n3Cb7P3RVd9HeLEDeO
	Il63eEKPVAF/gsZoIUu4weV2GLfPkr7NHL3HMWxbMowA=
X-Received: by 2002:a05:6214:1312:b0:70d:9291:bdd8 with SMTP id 6a1803df08f44-70d97109866mr271525626d6.30.1756379113185;
        Thu, 28 Aug 2025 04:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLnBHAxYeOFUCjvzXXjJoPfriPl5kZ9soekFn2bdbrOltVRygzUC2PVtjW1wYnOgDWaHGQnQ==
X-Received: by 2002:a05:6214:1312:b0:70d:9291:bdd8 with SMTP id 6a1803df08f44-70d97109866mr271524786d6.30.1756379112368;
        Thu, 28 Aug 2025 04:05:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e5da244sm30163331fa.58.2025.08.28.04.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 04:05:10 -0700 (PDT)
Message-ID: <28b33851-24eb-428f-b046-b145342fd982@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 14:05:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
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
 <75ra2ofecqu6tid6kr4hnyuztpl6jjaq2ksyquafyajhq2sa4d@4tkggrdqky7y>
 <8918feef-219e-4e69-8901-367189f5066d@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <8918feef-219e-4e69-8901-367189f5066d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfXzLQfjPC5axEN
 kT0pJdMA2CJrM4pg332/Fv4sVMLX/+ixqd8P6bdBAxH23u+bKzMIril49Y3+GL+6ZFIv8Lc7vZ7
 8TD8OmzDMc0qC6c8ZeSSmEJETFKAHY1RlH21XijFiH6tva10APHwSr3GN1wZutyw9kzYHeDQWzw
 yiT25MIe0ngMh12IvQOgnVvvR+WCQ1Msf48gPoXuLpDo//1Fcuvyzk0CJvW6z5Cvx7Xn/n0JPww
 ZCfCXbcfuzKRF6Ll4o36k8zg7+CwJjB6/I8fH+8OggzA5FOJ3l0MDyw4QmFFM8Gy1KJYLPUEi77
 ldKqobmnGY+IOckTHiTGSZyMkL1GyqzRgWpzhkbs0ysWeoUNlhEisA5aPfNow77d1sF67fEGwMu
 fAbzWKpD
X-Proofpoint-GUID: OmicsU5rO7tLDHDDoP6DHGjXcZaJoMAJ
X-Proofpoint-ORIG-GUID: OmicsU5rO7tLDHDDoP6DHGjXcZaJoMAJ
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b037ea cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KSO3TaR41uafEWVwNF4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

On 28/08/2025 07:51, Xiangxu Yin wrote:
> 
> On 8/20/2025 6:18 PM, Dmitry Baryshkov wrote:
>> On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
>>> Add DisplayPort controller for Qualcomm SM6150 SoC.
>>> While SM6150 currently shares the same configuration as SC7180,
>>> its hardware capabilities differ. Explicitly listing it ensures clarity
>>> and avoids potential issues if SC7180 support evolves in the future.
>> I assume, it has no MST support. Am I right?
> 
> 
>  From sm6150 ipcat, I found MST-related registers and pixel1 clk definition.

Then please describe MST as the main difference between SM6150 and 
SC7180 (which doesn't have MST).

Also this needs to be rebased on top of the MST bindings. I've picked up 
the latest posted revision, but basing on the on-list discussion I might 
need to drop it and post another iteration.

> 
> According to the hardware spec, MST is supported, but due to limitations in clock and pipe resources,
> 
> the maximum concurrency capability is restricted to 1920x1200@60 + 1280x720@60.
> 
> 
>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>> ---
>>>   Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
>>> @@ -27,6 +27,7 @@ properties:
>>>             - qcom,sc8280xp-dp
>>>             - qcom,sc8280xp-edp
>>>             - qcom,sdm845-dp
>>> +          - qcom,sm6150-dp
>>>             - qcom,sm8350-dp
>>>             - qcom,sm8650-dp
>>>         - items:
>>>
>>> -- 
>>> 2.34.1
>>>


-- 
With best wishes
Dmitry

