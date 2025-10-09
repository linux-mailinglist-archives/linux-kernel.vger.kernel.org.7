Return-Path: <linux-kernel+bounces-846993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D5BC99BF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E09A4FD1E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF72EB87E;
	Thu,  9 Oct 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AuDIsEqN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A01B4F0A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021196; cv=none; b=Nv8+oSZW+5kwupBZIaz9cthu4BDIbiitsFsZwmNGN0pTiLRRXfci0WT7LwkLqAqCForH21Aw0zbv/6STAMb3kEeMde7yIX2xGRr3AeGBsmSlrcJx1xc+sWRRIMSZQbquKTBR04qLI6LfW9yN/njzy5GlS9EXlhcds9W83GfBp3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021196; c=relaxed/simple;
	bh=HCVYg7YLF1NRKPfftTczIu52IvG4diO/x2IeTxseCjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0LRspwcTliO74+m1J+HW4zcwi+bVTie7oEFYUlZxV90ISDDv2ia2i2Z4rDa7SHBoWHxFKmJOuPycPxX4gKIzbvQ/2UpuZmIu8rtBDLgATY4fnPCkRIQqlfC/l9xpz7z0/fAyQhlRzkaLJ8vYC9nSxDv0NiDAP6nhRojd7VP/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AuDIsEqN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EJVt019131
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 14:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HCVYg7YLF1NRKPfftTczIu52IvG4diO/x2IeTxseCjk=; b=AuDIsEqN3HKUd6bh
	3IaPolLJ6PiAMVZuDNDzcoAtaIxDGUmQ5VFei1tlX+usRQ1mM0csGHt7pkOdwIx3
	+h10kRLQmncyg6/J3DSk+LGldv9A1x5jDc62nweQf4LdWX6rAKCRtulOYV6RcHLP
	ag4qDkmVnXvJGsKmY90SEXooR1HGn8pZ0oAbjoZjw/dTvc9qyDfrzc9uaGmDaeQM
	2lpY22+mczkEQNQ9Fd1o4+2RR4qoukb2zeCfnkYIhiqi7xBc0y7opCTeD0dOKeM7
	/BZ14GTrgkyhwzjLyW2ZIlTiiY0KxrT+URGnWflOL5I+/J2uYwWOtsVVXqURQ6lv
	xgYZ1A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nu72j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:46:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-81d098fee40so2186956d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021192; x=1760625992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCVYg7YLF1NRKPfftTczIu52IvG4diO/x2IeTxseCjk=;
        b=dVks6Z2Hi96/3LqYkX8gcSdyUNK1jYWX45ER7quaLEeJDhyLx0S7m+h7d9jlOtKtxK
         92QMqy71RPUflBcG0bQJJNcYDw/B0Zz3EPpwNms1VenUbsuEW6cU2W+dqyNBNmS2NEtW
         HvFfNpi9ch8cc0I+sIj9Es/VuX/sOYiOZNLazP6MnCDYBETYuxgV6BbeCF6yO0Ejh3XK
         CaHk2ti5GPVVE73QoFOkK/9x8pauxj9b3GbLTV3sov/MXxgbt+WUuVuih4b/1nM+fTnZ
         i9tDsbTpih8Mp9oaltlYsekiWqPjiCd/3Wwdi1HzpjpXudFpA48XLKveylZ4cT3ebGQ2
         iigQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6uSd9LZvTxpuqNORuLFSOJnyB6CFc0EEjgrZ8XOUXFF8w1ttQl8ccBmxbxl/8RO2Z6FQ9CeSBbHsVKwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvjBLS41/N/e2POs0cIx42kkkpND11G6NdDPywXTC3oCAdkAnF
	lYtNAnJgCKBTzKKXOlj2od6oTFD+ka4r6GrM1q4aL0iNAeLkVslSqCDOPPILZ8wa1umTmppgZvQ
	/14p8Mx1ia2cSH5phhcJamV/Y2VxGmJKK8QWoM9D4b1Bu/OifAoB/hU1GpXvIfM0NlbM=
X-Gm-Gg: ASbGncsR/1HgMM/W3bJ/LKqgAaEIOlBSLCFwo4PScw9jhs9UT1+E9cMyiIiSBLEFzxB
	0MCAnuyH489II4SgmnjWNTUZ82Rg14nn8MGiSuxkWL9/hREs3r08o3ElBQGy82lJI6hcvNsNT3f
	eHXoZDc7xSYcBvQ8AeCMhjC6+2v7mrxq0BSBRtKVJirl0fO+oExCb73KLZQnqGOOeG2kmlYuL88
	l1Qy7VM5B9wExbPnkYyo46Q1AaNE9/pkjDk0jC9bFhMoYqtYBV5ihyGm7dTP+wNlku5bhLMQo43
	ETCRZ//F1sPlr4HS+r8jJREXhmV8xiZnjTeimar+WcVZdDcfBmvLedXdJbYlzvJyiDWN7lUr+aG
	rG32sQM6/IdyOe9cPzKQ59g2+38k=
X-Received: by 2002:a05:6214:1c89:b0:7d0:8b28:aaa4 with SMTP id 6a1803df08f44-87b2ef9394bmr70624136d6.6.1760021192175;
        Thu, 09 Oct 2025 07:46:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbkxsgpA2R6ZHZIpuug3KaY9J4Jw9+efaGwspf70reNmliHQ6JBJOzAn8d48ngP1fI+sY3xw==
X-Received: by 2002:a05:6214:1c89:b0:7d0:8b28:aaa4 with SMTP id 6a1803df08f44-87b2ef9394bmr70621816d6.6.1760021187635;
        Thu, 09 Oct 2025 07:46:27 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f30d51c7sm2578021a12.11.2025.10.09.07.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:46:26 -0700 (PDT)
Message-ID: <045401ef-3a39-4b65-9874-0a0086e72325@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 16:46:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: qcm6490-shift-otter: Enable RGB
 LED
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@lucaweiss.eu>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-5-5bb2f4a02cea@fairphone.com>
 <rnlkxpm6crulpvfleclkszio2fms7t3ulc3rpsdozteml2bak2@zvfuyc33ohez>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <rnlkxpm6crulpvfleclkszio2fms7t3ulc3rpsdozteml2bak2@zvfuyc33ohez>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p0K-pRhG_9jjC78t-OKY3m6FWdhYQPCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwDZV8BgjBtPD
 bhVWV1HEaoQPszhbQNEYcgUOrtrvzufRL06XcyhiY1YTT4TSWThTxS9Xw9sejhCyzehAdrG9YGC
 RiMDV7HEZE01vaRn+Ej38UT/rpL5oOnbS2Sn4M2Rzywge1y4yue+SKKqOP6tfRRd8gbg7wvU5qf
 Vy23flDf1DPC8V3Yibap0OG52DqXjDNHchqJ7LpdReAVk5otNybW1b4jRYnOgsS5s0s2szLJ4LZ
 /dyBZr/S/OrmP7/ly5581AwC2HH1y8gKXtfiaIFyGXAgfZLR8PpVjphRSWvx/fco92BRfMMPUbf
 7y9SOGV32aTUlwTYOMsZPoEUEN+JX/ltrq/TF0PqVgLz3EAb+QDGvWpEG6mX5SvmyhKlA3ROTGB
 nSg7/u59uByv/Im0mH4JQoHT2vMSVg==
X-Proofpoint-GUID: p0K-pRhG_9jjC78t-OKY3m6FWdhYQPCe
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e7cac9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=dlmhaOwlAAAA:8 a=EUspDBNiAAAA:8
 a=6H0WHjuAAAAA:8 a=h-s2VQCXUef8IyaNg1wA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=y4cfut4LVr_MrANMpYTh:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 4:42 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 09, 2025 at 11:06:35AM +0200, Luca Weiss wrote:
>> From: Luca Weiss <luca@lucaweiss.eu>
>>
>> Enable the RGB LED connected to the PM7350C (PM8350C).
>>
>> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---

(you sent an empty email, Dmitry)

Konrad

