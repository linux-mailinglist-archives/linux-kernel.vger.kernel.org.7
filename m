Return-Path: <linux-kernel+bounces-882849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7222AC2BADA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA3AB4F94D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9630DEB0;
	Mon,  3 Nov 2025 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RwVvNEzs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gD3rXCQp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41D30CDB5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172632; cv=none; b=Y2kIi3vdbLWS+UuMCRpdGdlvVGhT9bbBhU+sYh+aBsBkxEVAcgOLmi9TtP930oaUM1y7tfwylsSvPWAVVJOm78DKnP4HKi4NLkU1081x/VRSqTYKN3xlv/k8/+lzN/w4vhIgqPSxLzk9b7SV2ExX/WLnga/FCIP5VIYxZ832rDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172632; c=relaxed/simple;
	bh=GL67y7dtpFN+c7EYfHg2LIS5mPBVg3wakU2g90qprTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBMI9QZX8yLf1hiLtVb/v7pJOY6RXMAbugp3SWmAXl7eB9wxCX6ie1RmxYqgHc+03lL1Mrmj3wZ118m0kKDNmn7sYp3PLMtmBgz1mT8ozTYqTJgLfChsHUu/k9PCvDSnh1eO96sWoXtSMxXX/44YA8l+qisHHVeIrz0ml0ruioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RwVvNEzs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gD3rXCQp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AS9GV2891249
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 12:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLDocl8OIbPcP+9ub1WxgqdY32ZSLXkBpKRcN7PVu78=; b=RwVvNEzssueT+rXy
	gr0p6nyCoKHoUo7l2WxXOJE5SoNfTzbHjm9SbjptxGZH9CXGXFKyWQBXvinacwnA
	fUvl0XhE17esXfaZsQ5wjP5P+VMjCE38SR6c+Ei0XuVqjHV8cknEArX9g7qxVLak
	nEqnbgaR3/Cx9WZBUf42I5ikzdksvgNhFNDeW62gFr0yKu7nCTphE6hK82YMPgRN
	SFa9m/GCb7W608WFlnxARpVlMn9xdRxJiJC+Nm5zu1Qlefnb4fr+MjIMPHtLvbPu
	loUaXyiUFQFq684GCMYYyAFn/SpwlNqd6/M6WQdNEtcfn61N5Ixv3I6rIVH9bZm3
	TdDKVA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6tnrg9b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:23:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8805383611cso135236d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762172627; x=1762777427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLDocl8OIbPcP+9ub1WxgqdY32ZSLXkBpKRcN7PVu78=;
        b=gD3rXCQpdmsfZmVaDyydJyoJHwm0FOMUC51iUTOJNzoUQhWea5QoJj6fwZ34UsoIxk
         8VjXnL6UXMFUNYRYDjW4+AVCQ/iyEB6PrLAmmCzeINrzVE1FqwcN2jCGv0TC6rb2SB2L
         5wCIMIKOerihgk6zZ/hJXfvrEfyOwv860dlLCcxyhJrSoUh2e06N5T26JsOlxDScQ19k
         spSilok/2ta12SkgFU0UXKJF1wWCR/0reM13o2Gz0VqzX0bwIskzmmWLhQSzJ/WeO1PU
         DdkfBe+jqgisW64jSSShqKd/tlKkCszab0KpyYyVptb19AEjidj0FaB2Mdk6ZbBfF6kM
         CGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172627; x=1762777427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLDocl8OIbPcP+9ub1WxgqdY32ZSLXkBpKRcN7PVu78=;
        b=E4FjaNmHd/LgVN0dIerIMNHbfZ/I/xfUei/rSJRs0/nUGkmO4XZ64ISVABCOpUTXpg
         fbgk9hY7nd+gKbHVR7PbOK1zO4qTMxdtUMDzlKXH3xKON6XFsA7DW/iJUdaFlPOzJBqI
         RswDWkLQVvQb0HoaMlsMmXfMLFrLMkErKu7IjYPWMxEaxdElukAHSyIhpHLri26UfxFY
         h6ykMrjp+/U7A5BHqO/zMdv6Mo4Al0pAK6hX3FNpkoh47sWbipsNvWxsvfrd0Du16jm8
         Ski7eYFYtnyxnOP+ZQN4EhYKCOQTpYbH1n3RGBJ7QaZ4czJuCO8irupAJ1rnVS4wqOXG
         VRLg==
X-Forwarded-Encrypted: i=1; AJvYcCUTAKbyM2woo9C8a0qQf3rWVLjXqWbCW/EGZcvZmiZhdT9BCUXtfbFtcLntkXnycFmBa292vvUMJ2EqR5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtTQ+t3c4pG2LVnQ2NHP05oVA4A8NZ4sc3uUQQHc3HEgqE78o
	wcxUIuiqhZCyLM+vKcE7U8Llu++g4t2uo7fAHYcktBF/eUePTakk4e/hK4kdksAAkqqyyIDhUNC
	cZmQTNhmJJGp+USAicRX+lrUXk47d4P55LcejW/t3zEKKntkXUZ254NgVAQ593TOyw1M=
X-Gm-Gg: ASbGncu2+Bj0JPEKRUIeq0/OL2D5S8OvhgSZSW2CEPUwt6aAmiJfvJ3OQnup8m8Lstw
	UP48UgDshUwmeRGpt1oDfDsX2Bm3vHrG39/wZnb9FhM18EROCFrcFLydryAGvi2Firy6t1ak4Eq
	r1M1qDmphBp76odTANblLJxzMwsb/rAl+ACIXK/7S7n4SFVit1UtOT5mHX9LW84BSzWHr8qSlbs
	e6ctJK5m3N9zp2gOQPzNuzw2OFReS2Aam/fLLE4oqcillEJH0Qu3NQn4F8fhU6mxb7jafGJVXo1
	9nRmcV0wNDdGip+fPE+DqZs0u5IfxVzfyeO7f5JVCJDSIVdNNJpulj9HdlNFcolNJ4DkR4iIPrj
	ChfECPSCkoqydgbvvGFEGiDTUMOU4QJwN/rKg4hgmXv5Do3fPnU5ApqC/
X-Received: by 2002:a05:6214:c86:b0:87c:2360:d41f with SMTP id 6a1803df08f44-8802f493160mr98182146d6.3.1762172627384;
        Mon, 03 Nov 2025 04:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHNEHFu5uzZ0tS3YbeG5ybPjbh0d4UBxSalGY+3hESR5a39mHj9S8jaxD5JqLSDjkMxCzcSQ==
X-Received: by 2002:a05:6214:c86:b0:87c:2360:d41f with SMTP id 6a1803df08f44-8802f493160mr98181806d6.3.1762172626865;
        Mon, 03 Nov 2025 04:23:46 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6409012a6a2sm7946707a12.23.2025.11.03.04.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:23:46 -0800 (PST)
Message-ID: <0fd020e4-636a-4bb3-9c22-7a5b16e4d3c3@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 13:23:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Various dt-bindings for Milos and The Fairphone
 (Gen. 6) addition
To: Luca Weiss <luca.weiss@fairphone.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
 <c93afd94-9d94-42fb-a312-df6e26bb2bc8@oss.qualcomm.com>
 <DDZ1X799V2KV.269J9YL1AGCIF@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DDZ1X799V2KV.269J9YL1AGCIF@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMiBTYWx0ZWRfX/qgudmg+mEHe
 R6FzZLXDoGysWCGSdxSAlbQPHdz/vopoX1Q9mZsE2I6sQztj0NkRlVZU8uJf/1tWFkof7BlHhdg
 T6HIV6Mf14eIG1zn0vcqlG1KW3oVOUQK9fe/mJjlk/UX4vk+0GenAdUbT7OqSgTKUWmYMogpilC
 pl3Wo5fPIxFegeHKhvUOW0besI6CfWrzbISS2eFkpP/HeX3uQAld4dN0jN0GDCD5YPGNlY9zs0S
 oRjhynwbDVIa4c2+d6S9Mynye9EK8k8zsOxbeY8yy8/Pt44Ku5GhlzIQK8H1dbD4HUJZsOy7/H0
 4wBGBFsxo1wOnz9BGKA9t+7YktGY7V7eGXMaW8HwSXNIgmSdg0PiNyzpwCaUhvoQGt1BSpPhdEH
 1Z++DogLGgmRhbaueZ57odo6lm/aVw==
X-Proofpoint-GUID: SPpl8IxzM2yd4BswAJdk0y2Wra5Ko1f3
X-Proofpoint-ORIG-GUID: SPpl8IxzM2yd4BswAJdk0y2Wra5Ko1f3
X-Authority-Analysis: v=2.4 cv=BrSQAIX5 c=1 sm=1 tr=0 ts=69089ed4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=ySytLBbe-S1-HUGBodAA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030112

On 11/3/25 1:17 PM, Luca Weiss wrote:
> On Mon Nov 3, 2025 at 1:14 PM CET, Konrad Dybcio wrote:
>> On 9/5/25 12:40 PM, Luca Weiss wrote:
>>> Document various bits of the Milos SoC in the dt-bindings, which don't
>>> really need any other changes.
>>>
>>> Then we can add the dtsi for the Milos SoC and finally add a dts for
>>> the newly announced The Fairphone (Gen. 6) smartphone.
>>>
>>> Dependencies:
>>> * The dt-bindings should not have any dependencies on any other patches.
>>> * The qcom dts bits depend on most other Milos patchsets I have sent in
>>>   conjuction with this one. The exact ones are specified in the b4 deps.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> FWIW this looks good.. where are we with regards to the dependencies?
>>
>> Are we waiting for anything else than the PMIV0104 (as part of glymur/
>> kaanapali)?
> 
> Hi,
> 
> From my side, I'm not aware of any patches that have any unresolved
> comments, so I'm essentially just waiting for the correct maintainers to
> pick up the variety of dt-bindings patches in this series, and the
> PMIV0104 and PM7550 series.
> 
> Any advice to make this actually proceed would be appreciated since most
> have been waiting for quite a while.

Apparently I misremembered, kaanapali actually uses PMH0101 and PMH0110
and PMH0104, whereas glymur uses pmh0101, pmcx0102, pmh0110 and pmh0104

(it is not easy indeed)

so it looks like PMIV0104 only showed up with your series.. and I'm not
opposed to it, let me leave some review tags there, and I suppose I'll
just ask you to rebase this series on next & make sure the bindings
checker is happy

Konrad

