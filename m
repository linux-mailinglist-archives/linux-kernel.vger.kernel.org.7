Return-Path: <linux-kernel+bounces-847987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F56BCC37B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD4D1A6589A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6998F25F7BF;
	Fri, 10 Oct 2025 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AiaG21A4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B582459C8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086200; cv=none; b=jm+Dy7HtLyIlejC+3nvzGIEGFn53KQcRB61hslludp2M9VzNY57GrO68DqjMIaxQ+Xt39seo9bBHDFDqoy2usAD1YFtdbqpk2iAKCBiLQYNsvtCYi2I8HvkItV/59vumlPtLB55swNJgNudevhgnzNDbssVM1H3Hz0lyu5As3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086200; c=relaxed/simple;
	bh=JSa8dssqMTZFfX2f7rVLTtNC8XakKNEjvuiexVQ4d5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxsMLkoFB4vrwhpPOau7zupY8jxtdh/ViwdqbGIgSmdaFGRTAcSBsGKgI0IXxnWZ932uoX1+3HrqaRalIfaTFfy9zrogF66Sjsm9xvr8ubdn0quVCYg4KZW49SF1/RjCf8qQ9jUGDzgKGCbKlN/Y7M1Eoku2YlKOLJvTYTOxao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AiaG21A4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6WgYc002272
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cwh4ZsIqg1G/kV4tcJ1hinaVGiVD/hz+Bz+dzBU2qIo=; b=AiaG21A4/6eEAxS4
	TwgvOuTTBuQb+RFCwGmITqDkoNzKU46W9v0MuWGXnUhSMy1d4MyOUx2Kc8yI+NIy
	z69AM1S7FvN7ksz2n38pwKXxKJsVhnH9yFzLxtWsoGxjCLUApaosAqJIGZBogzKy
	krLmcNFGxxfh0k9iSPMFJ6SO7X78hhiW45ivifFp2iPz6GtTgoaInXHv2Pgq8ABG
	VK6fPWqg3LDRW4LA4KHH/a1OcVeFBHJeFs78xhNh0QX3MLn4YAaOfQpIwxlz0vBo
	YVUCPskFm2fedFqdGe6Ld+9AtCTwnlyOs6v0FUrFZZ31lfowrVM/x3nRSx2BqZ+k
	NwuUDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49pgdst5u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:49:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85bb4e88394so58962385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760086197; x=1760690997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cwh4ZsIqg1G/kV4tcJ1hinaVGiVD/hz+Bz+dzBU2qIo=;
        b=bP1q5CSH/UZJ2weqqSBAhCE+cumyud8nIs8KcwpboOpnphepBWRtDoH8x0vhSB5nlm
         ZPfeySe/YD+rR5EmmTypTfiyWIcW+AywrxbQVOy3Q4B0TaZ4ht+ZyQiwIrjkmHnMQLbG
         VXlABjKQ7ITKe6G3N9+ZZ8AcB1P4PhzZmv59oPh8SGEFkovojSVOObqItxn0omdX5COh
         4TGjKQpuLkxe3vG4sbJBaa9sy66ykY4box6KMFE8PC3V8rGcqz/w9Q+70Ndzmkn40xfz
         LQm7LUWZp+pBqMg+WoIeMtHAQ69E1jsL1g6SuknmL0QRQLP6H3cWOvhzQYd5e6ajJvCS
         6B4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJPRaa0k3/j9VG7uS4OKwfHeqd1yvTVYUKti2AnU8mR1jdzr8tlztQl6OWpcL8+/krdOK/QGLE3dfmHIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRGrU+019PeWVR/bd7q6WC9xMSSnG5EG7DuFITvolyn/34AI/
	HxqwqGbUestX6H93n5IIdV1uJPzJtyYbZh2ZFkPqiSMiHWc8NyZFciWHvJslLGOWaXExPf991kE
	/UIELYcnrdpzZ5sNSRz5zZ8EehlVxmhTsb/gqTvtaNxvSVrZHCadtLo5ndMDT2D51xTc=
X-Gm-Gg: ASbGnctNqkUvCD7YY5FHtG/XoK7p4YhngtEkS5HoPYZBwPspcPnwKDMxb/urVcalOxd
	od7Gd8gTFj0O9iLEkPghRfoewv3s7/gos7rrNwIPREU+KLA4P+E6imbuw9RhdbkiuJ3Q8yw1bxl
	KtRvUOVSEel99OjRPdzSrBwdyVGBBiAX6HQ4XiGPQByC+Qt/shUPYAwelyYNeoSc9KzdkgpQ2sn
	COuTay7WanAvcslO7JrFbCjdLrRuly73HehyRVwbAomqP5Jwo4SBJZwzXVWcOi0pbPMQ5pvyBGY
	+JY2hh8zdY7o2Bgnknzc/Lfrukvfun7mQbvVaP5pUsk6LSD1PH+8NTMOBaiBAhvBRgLSIsEeQGi
	z+r2vbFCilP1/2ks5Qqv8AA==
X-Received: by 2002:a05:620a:40ce:b0:883:3c5c:9077 with SMTP id af79cd13be357-883543faa58mr1036124985a.13.1760086197124;
        Fri, 10 Oct 2025 01:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnW/+isTRsgYN2x+tF3lYH+BB+Zvwj6IcISdiTQNK0hXoGC7zcoK1c/76jo+BmMhQiHGuJcw==
X-Received: by 2002:a05:620a:40ce:b0:883:3c5c:9077 with SMTP id af79cd13be357-883543faa58mr1036122285a.13.1760086196579;
        Fri, 10 Oct 2025 01:49:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63b616d12fesm1034403a12.24.2025.10.10.01.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 01:49:56 -0700 (PDT)
Message-ID: <8c099106-49e6-499a-942e-6349fa96c246@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 10:49:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
To: Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul
 <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251006-topic-x1e80100-hdmi-v5-0-c006311d59d7@linaro.org>
 <20251006-topic-x1e80100-hdmi-v5-2-c006311d59d7@linaro.org>
 <141e33fc-c963-4f58-a69c-e7068c9ec6e8@oss.qualcomm.com>
 <e10594dd-cfc2-4d5e-bc1f-35aca05be027@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e10594dd-cfc2-4d5e-bc1f-35aca05be027@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dM37Dd9tFZ8hJfo9mZ22xR5GfIPmecFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA5OCBTYWx0ZWRfX9xoPBdqn7GD8
 kxwL2PnooNX1bIi8vU8eE+TJz0ruT48CxqvMLj5VtuRxya7WqS40PZxUwwNBqWqGWy22axBc41s
 7G4ELEWUF6KDN9sxBLHkjfC1zqmrzOITMTTZtLfzIOuHNii9msWWLLZpzEzyv6+qTkxS+j7odRA
 JfhLCYmUpA/kURV+SX+l0f5wKKJt3BHTBQktsa9axMEYJi5bNHEpmkKaFQejdUn5HYu8D/dRU5L
 ApnChgvvogenW8sfJoTK0Qvy1ko17Z/8oWwvYizuJwtJ1vz/IHTUDRA/Iqk6bEr814jutlxnHKo
 AkfrVktiezUw3FaMc+k4vxyuhfpXmF7WlkxTxF+Z3K2BVUWaNl57MBg2xW46FvQx6aWKwstb883
 ZPbzlKVgc8bCVCi2AdX1dqd2+2BgdA==
X-Authority-Analysis: v=2.4 cv=DISCIiNb c=1 sm=1 tr=0 ts=68e8c8b5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=kQruSXXmluR0ARYnVvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dM37Dd9tFZ8hJfo9mZ22xR5GfIPmecFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510090098

On 10/9/25 6:42 PM, Neil Armstrong wrote:
> On 10/8/25 11:31, Konrad Dybcio wrote:
>> On 10/6/25 3:55 PM, Neil Armstrong wrote:
>>> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
>>> of a combo glue to route either lanes to the 4 shared physical lanes.
>>>
>>> The routing of the lanes can be:
>>> - 2 DP + 2 USB3
>>> - 4 DP
>>> - 2 USB3
>>>
>>> Get the lanes mapping from DT and stop registering the USB-C
>>> muxes in favor of a static mode and orientation detemined
>>> by the lanes mapping.
>>>
>>> This allows supporting boards with direct connection of USB3 and
>>> DisplayPort lanes to the QMP Combo PHY lanes, not using the
>>> USB-C Altmode feature.
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---

[...]

>>> +err_node_put:
>>> +    of_node_put(ep);
>>
>> __free(device_node)
> 
> why ? ep is not allocated, it goes up to:
> 
> static struct device_node *__of_get_next_child(const struct device_node *node,
>                         struct device_node *prev)
> {
>     struct device_node *next;
> 
>     if (!node)
>         return NULL;
> 
>     next = prev ? prev->sibling : node->child;
>     of_node_get(next);
>     of_node_put(prev);
>     return next;
> }

_free(device_node) calls device_node_put() without you having to
add explicit gotos


Konrad

