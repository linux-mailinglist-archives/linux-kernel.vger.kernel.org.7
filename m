Return-Path: <linux-kernel+bounces-745498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32736B11AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471537A5AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844822D0C9A;
	Fri, 25 Jul 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgBC+3be"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771682D0C71
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435437; cv=none; b=Y1EoaA4xrcGrqWIHMV7k0Vse/pmGX4ZFeucF2HZMDiIIaDXQGhMYCi4CzsgrehMvf1PLeO24bZ13t9NEF0m+JOocDofd9HFIy0GASM+AxDoRGbJmUUAYb3yYezivkn/LQ8KIHFLXmJ9j+HsySIciGkM6hwdDoJDlSyXjb0+hFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435437; c=relaxed/simple;
	bh=Dloj46RLVL4mRBXYmPz0/KvEtFoPFJB/naJFsvdgGkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjTl8kxM5OWzVLJCeTwUI4KnMXrjwigeaLbNUqL5H6t9aAF0R+ryVtmc0QUp0yj2YAm4paZ1NQL5nHVQWglO9CMhwCSdzrGrWC1lHQEu2vF2w0mxXoyQ7H7sq37LWJVQ0uupCxbzSB6TaHaKnHZ3Locg+ir7NCgKQAsmj3KWmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jgBC+3be; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLrWro016116
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dloj46RLVL4mRBXYmPz0/KvEtFoPFJB/naJFsvdgGkk=; b=jgBC+3be9f55Wejc
	gks88R3qugek5GEqHZ62QR539xCGy8pI/WecpsTt7WnvT9lHDhuSp2ffynAi5yll
	yTfff2L1rFUllvMA3nMfWgQozkCo/gy7P/LVsf3q3Brk/Sf06mh5hpPznZHnMX9s
	KYyqfhplTDXZSYhdIjN2j2NN0FQYEB6gElCLHc0i8lk6B4xxowevnBqYJMh3Y2YA
	vrBR45+vjuySZriyyc+xbvjZcuYoRPbml3iQ7rTZ1QRBEdQN7P7PycANS+nM8Hqy
	AnenL6Y5N6yZkjP2v/DjhiuePP8B9Xy7fI2AaIMSzf2cDgvbYKm2iYOsUwl+JS2l
	fI2SQg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w501hm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:23:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab60b83e11so1467281cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753435434; x=1754040234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dloj46RLVL4mRBXYmPz0/KvEtFoPFJB/naJFsvdgGkk=;
        b=IDOaOLCQAnJXLtSbUro5PxY/j8kLeGVqLe36hehIs5665L9VAy0+ydmUgAqX7ZyEAj
         hoAAF1f1z0nPz1vIH8W4t3TPz/Tq3rFWJrbkOIBCYufu3547qpCKacYKnKzPHI0sC6zq
         NZUh5+ncJJNlanSmsC8dZVnnGSkb7BVQ1cPx0NlJtM2tZKemUI9zleyylsytGFQvmnpj
         90QV8QkSMB3NIxgQRx32U4Ma6bDTiBvwUiiHs3ZNl2rx6bxOmZkpQz+ZILlmhPzUZFZt
         hoF7qF9a1s18N9fixgzbvj9xMXwk3RNW/E3Q8IRpCG5hQoDlYQ+eWbSD03pPRG9wRIA3
         9icw==
X-Forwarded-Encrypted: i=1; AJvYcCVuW/9578ivJi9j9/kLeiZb0LjIX4KZ/VjPAFaTiEqnrbI9C9+EOOhuGtbWKegRBHw60H/MEsOhYzyb7JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hI4qgXV3uZRpGOcUYM7YuJ0R4oZNIEfKEObOLEyHiA/hfrFa
	y3jT2LawX5RlXshGtNcphVi0LYWmMR4rGNU6eD5WrjxqXvplHG7dvbxIOwoV6Iy1yqpNN/D03UQ
	WNvOHNRhBfI3NxzrHRLFkE2GgxwpDKuHvfMfiqVfWchLaZ6ZGI3pI25SoZ/PgD3I+FV0=
X-Gm-Gg: ASbGnctbJyCrEwDI6L1AltkTwufJd8Kd6mNx0YYMvnp+w2sPZ295BwcIP7vIjWcW+M+
	Xi8gH5zaEDcDd0Wxb43a3Gjbnw1hTTsL4qSY0wmR4UUyHx5i3qyWQZD3sVF5TbpjCDvwn7XWoU+
	TaqVImcPbgOIkHs7JL0y4U0OjTqFjlM4EeTJCZWuN72LbUC8r7SDD2WJmXqqSvYn5+n641sMxoB
	polSz4/dTikB2/vIaDoMLNvBt4hmernhOxjwJhFe+WFoP1a14RogsrNphUz5/Cqtb7eCHjyavcx
	FgmvRVZ54crYjh80RIjOXzwA5Gj1hHksJ2Qy4zdinZIYp5a40ZQZqOJz2WEybbn372sr97nKPPk
	Hi7eLbmtw0MKS1J5tQA==
X-Received: by 2002:a05:622a:11d3:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4ae8f015169mr5405561cf.10.1753435434578;
        Fri, 25 Jul 2025 02:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgulUkKqOz4bY42aroheUkGoGh4nZBDDpLlQeXSeqH6w6hf4y0ytwWggsRf8Lzc3sqtruYOg==
X-Received: by 2002:a05:622a:11d3:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4ae8f015169mr5405431cf.10.1753435434080;
        Fri, 25 Jul 2025 02:23:54 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cd650basm239257966b.58.2025.07.25.02.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 02:23:52 -0700 (PDT)
Message-ID: <adffdc2f-7dbc-41ea-ac9a-015af251b43b@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 11:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom: Add SM8750 GPU clocks
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723-topic-8750_gpucc-v2-0-56c93b84c390@oss.qualcomm.com>
 <20250723-topic-8750_gpucc-v2-1-56c93b84c390@oss.qualcomm.com>
 <20250724-blazing-therapeutic-python-1e96ca@kuoka>
 <7d444f4c-fa1f-4436-b93a-f2d2b6d49de2@oss.qualcomm.com>
 <a3846433-f1f8-4b83-a965-baec24ee5159@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a3846433-f1f8-4b83-a965-baec24ee5159@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t34U2jEUiqGfyqrm6x20o5bWbrXmQDzn
X-Proofpoint-ORIG-GUID: t34U2jEUiqGfyqrm6x20o5bWbrXmQDzn
X-Authority-Analysis: v=2.4 cv=bKAWIO+Z c=1 sm=1 tr=0 ts=68834d2b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=S94FfrcSPokYo2a8pT4A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3OSBTYWx0ZWRfX5sgoZLVcJJ7g
 uK7Rn4QqEGYb5Ft6lmFQpUVbCJZxA/aWbR6x1AgSWq/DYO3hc8UrBsLIb9WSrIx2+78RGCAx5Jp
 xnvxMi3sgwweqPRyx+oMvMeeiNVnl7UI2RxBdklnrlxSSaIOLMZynE4MT5NZJEvAr7UI7kIq741
 GL5hqT7KOOP5Jd3wpy4S0ZYSM0V9EwWo7RlRwSImMRrBRybmuwmluBcSN7EJ8c6hHdpcqltpNgJ
 XdINfboWy9jTQ9+qSVCnTljbJyqEBoxzLRe9dMqqDxm6BHwFXB0uQabVO4P+m3w8JzNRva+tJDr
 Sij7Cw6mydUnmN9djQ0TwAZzUspAmnlGaFTqhN2YEyEKxAwDyaTG6oV+ylHYJOSpy3110Wg4IfF
 +VrZ9dSbOtnjx3MmmTUTG772sVyuCjGv9di20osSjgWR0OeHOidkJ33wWU+srGYYSHTgat6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250079

On 7/24/25 4:42 PM, Krzysztof Kozlowski wrote:
> On 24/07/2025 12:53, Konrad Dybcio wrote:
>> On 7/24/25 10:18 AM, Krzysztof Kozlowski wrote:
>>> On Wed, Jul 23, 2025 at 10:38:48PM +0200, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> The SM8750 features a "traditional" GPU_CC block, much of which is
>>>> controlled through the GMU microcontroller. Additionally, there's
>>>> an separate GX_CC block, where the GX GDSC is moved.
>>>>
>>>> Add bindings to accommodate for that.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> ---

[...]

> Yes, qcom,gcc. If that was missing intentionally, it is fine assuming
> you implement the rest of comments.

With the description addition that you suggested above, should I keep
this file in clocks/ after all?

Konrad

