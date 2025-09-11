Return-Path: <linux-kernel+bounces-811664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E559B52C44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC43D3BC849
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDB2E6CCC;
	Thu, 11 Sep 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OrIY/QGA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789262E62A2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580814; cv=none; b=h3It2/VdGyMMkStwtEC1z9H/RCUDgeYSuHAmfoH6QqCiZRMEiq0oZrBRTnI99zUihikG7yAFux3vGewaRxNLaKT9ecxDHVqqIHd1XZdNoISLDkoTRpMNQlNtY3ZPV89YspkRqXUL94arvLh6AjwwutQf7KQLIohRcAgI4Ajx8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580814; c=relaxed/simple;
	bh=rAsx1W0BJTPP4nRI2Q1Nmo+8/AQQ8dP4RLS8RmnUsy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+2Rg8nW7AiYQmcEW8kkUHlsy5h1V5tVMD6TreAoZ++Bia7Y2z8fhN+3/6tcMghAvC+O8uPnWaq0pN+eOSgPqDlubBv4GwOmCRC7PxNG522YfYjYweEVow8TDOEphSEY38CwJc8r05yCQH2xPUMFbVSB/5/dHKm90Xw3B8hx3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OrIY/QGA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2JZCd000568
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ynWl2+LN0okkZhiNEn8Jl42YKjFcoHHouZf21AAoHq0=; b=OrIY/QGAjyiGsCvf
	Dmxj++57E6yEaDivTVuW7agmMUOYVnC/DM5C3oLOgZuxx0OCoj8r3Lf58/yLCjNx
	x2zKTAvM6/VIyfu4Ob/p2P+uMLolymGRxGIjExVMyPEy0Wz8bz1SH1/CEMDJKN17
	AJFUJ39O3bXtCI0zB99HZs2ouvKC/RrC1QH/CN0frAAic/bLsJGwXY96olQSdPdD
	aLJgznelxD2iQAATm+WkFealh2YMeYNtuscpRVSqXQcUhIn+ONuHSDzRP5FwU+xv
	0Sx0y+JpQh/Vq3qzD6Wer6WeilyLnVDkDGpEM1EDHM2arVchyWdLKp4UOurR27dI
	nAYTaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg6rcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:53:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b604c02383so2510131cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757580811; x=1758185611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynWl2+LN0okkZhiNEn8Jl42YKjFcoHHouZf21AAoHq0=;
        b=EfG3Zfp8xvYfYLmx3ZE09dMXzNsntzkDvJak9Zlt59pBKxZ1EYFl0mOsNZna+T3bYO
         4HYvxuOLdKajVS8Q10/Uyj5bvjeoZ5ifwOz7jADc8iqp0IOjXim8S4KBNw3SWzSPPcDN
         Ki26VUCGg0O0jcU34fXS1cY4wBCndAJTeK0gCJ+mxYB7G44Qp1IOVghmfyHzEiW8MOoT
         Du0RhxsH0zjkEJNw5xRU7IhAbkJcJ5VQcKZp6YYqa9WO2sx92H1cpWI6sqOX8vDzi9DI
         P0EejbPjyirnvjyBFrI+6B2KAsjrRFHbfOmSDPUmnQ5fZ5qIBSM3M7qrrBbxrMhg7Vbn
         XlZw==
X-Forwarded-Encrypted: i=1; AJvYcCX4rzEDsFRfnsWiriGpSK0pirDMC3WI6AphLn3hWcv+fdIO/xfchI3/sHeXrAlXqgIN9S5opiz/Tx98v4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+32bSY4g2UoKF2NO+oUaj3W0Vk2c5L78USJ0RU+H1MFmfGsAJ
	5DZy50f9BDAxIMwPuF2g0a09ypE6Zz12ulmNXYNzWjsJqAVtoAqJxDETtMFVpCZcvUyPX0e/997
	IDTgJPjkW0X/k7v01kcY4mml1Huuy/2+Z/2aBFrD20UWTygvkwLbEpDxrzuUwgkTeFFY=
X-Gm-Gg: ASbGncu5YXB84VpE90tgikeKbVEIRozquexc8gsQViqbkk+TIzrabbhxJPo9/G4yhqH
	5gce/+Ne+FdYfx6WeeNeRAu9TYnw7gCbrYD7Yc4rype0lw42uaYURnorUIkJEnmCaQ7skJ44nFg
	Neh3FVM+Sk66+05AdB4rSvZm1w9iDoFMlWrAOkIAIgBZZYgz+IXPJc9IAMzt3z8H1OAaG9HmOk0
	BMezofenddWYTU+SwCLqAtk8UEcuWdL9spafC86u8S5eEu+UPd2HL9l9OISW/Bbty+zMPCFsBup
	KLEa1VnpO4oVXdH5SSgrLAnp0cUQbGZDoaxEqoX1tBhf8A8i3VQhrY1JwsYjQ9S3tiGJQxgpfRb
	BseIH7InnZGk2k2LEQBXBqQ==
X-Received: by 2002:ac8:5e09:0:b0:4b5:f68b:86a0 with SMTP id d75a77b69052e-4b5f83aa98fmr140394551cf.5.1757580811166;
        Thu, 11 Sep 2025 01:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwrCXlNX3e4J1CCi9Qj59YkjWyURxTP0akIJvONe/E360yXgamsqbmCNGDwjWVWtWm2ONHng==
X-Received: by 2002:ac8:5e09:0:b0:4b5:f68b:86a0 with SMTP id d75a77b69052e-4b5f83aa98fmr140394291cf.5.1757580810734;
        Thu, 11 Sep 2025 01:53:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f20ffsm86223766b.79.2025.09.11.01.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:53:30 -0700 (PDT)
Message-ID: <b83a59f9-16ae-4835-b185-d5209d70a0f6@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 10:53:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew+netdev@lunn.ch>, Vinod Koul <vkoul@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski
 <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
 <20250910-qcom-sa8255p-emac-v1-2-32a79cf1e668@linaro.org>
 <175751081352.3667912.274641295097354228.robh@kernel.org>
 <CAMRc=Mfom=QpqTrTSc_NEbKScOi1bLdVDO7kJ0+UQW9ydvdKjQ@mail.gmail.com>
 <20250910143618.GA4072335-robh@kernel.org>
 <CAMRc=McKF1O4KmB=LVX=gTvAmKjBC3oAM3BhTkk77U_MXuMJAA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=McKF1O4KmB=LVX=gTvAmKjBC3oAM3BhTkk77U_MXuMJAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: n7L6kn3sfI7KE8jtRrLPCWPoC4PdPi4G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX9giHvfvmYYAn
 3F7unyGX8feni9N/bzoI+M0q6ph7/q0zv7ya+/GA2SrYqrZEJhALo7H3icwVO3SFyrnmeProuCL
 pL+f4QVv7U3MoPLUoFjfZxIT4ZMxPhaun/dKQAO/AUmxjuipRARJ0Qk114rviG055YvR23oSUqB
 1V6uuO0m4N5GRvOX2gcXKNzOwjWvBP3lHsGUZgb/VHmKiZDDPqikkB8CXXG/Kij8U47LZ+ptppi
 lUZrzX5B93C+k/fuek4KjMX8Go4TdiFLO7FwAH6m1HiHS7rn+um3AVnwUDizddfgaSgQvlz0k+6
 pMomuAFYPHlfRMj+F7Yeba12ijZzBN2ZpgWaZLKAUfa62GIpUEuMXkDHw203Fw55Yz3qSIjEmW+
 0wzBrmby
X-Proofpoint-GUID: n7L6kn3sfI7KE8jtRrLPCWPoC4PdPi4G
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c28e0c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=E8Hth7WlfHmEou41Ml8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/10/25 4:42 PM, Bartosz Golaszewski wrote:
> On Wed, Sep 10, 2025 at 4:36 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Wed, Sep 10, 2025 at 03:43:38PM +0200, Bartosz Golaszewski wrote:
>>> On Wed, Sep 10, 2025 at 3:38 PM Rob Herring (Arm) <robh@kernel.org> wrote:
>>>>
>>>>
>>>> On Wed, 10 Sep 2025 10:07:39 +0200, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Describe the firmware-managed variant of the QCom DesignWare MAC. As the
>>>>> properties here differ a lot from the HLOS-managed variant, lets put it
>>>>> in a separate file.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>> ---

[...]

>>> These seem to be a false-positives triggered by modifying the
>>> high-level snps.dwmac.yaml file?
>>
>> No. You just made 3 power-domains required for everyone.
>>
> 
> With a maxItems: 3?

In the common definition:

minItems: n
maxItems: 3

In your new file that includes the main one:

properties:
	power-domains:
		minItems: 3

Konrad

