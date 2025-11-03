Return-Path: <linux-kernel+bounces-882949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80002C2BFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8C3189A62F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04CE30FF36;
	Mon,  3 Nov 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I5oH72qr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrqJj451"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4E3101DC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175212; cv=none; b=nQjOzmm+WDFYRhqf7PeMqevAy8ocMkkdr7H7FCvW7/Z0zLs/i9AZ8pdC9EzBYFNyMoRvn0d0uvfhIHuS4epQdXS/VsEWHQWVex5fQkEYbr+aGd9CNyIIg4XMrG3xaoSEyiP2hhxn4RyJxGF/xUTvGBkQmXPGPAPxgP0pWtDUUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175212; c=relaxed/simple;
	bh=FYiwxvyL3zVaY/1QX0QkLlPmbUiAY7sdzTU30Lh8ax0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnZ30zeF8sZGqPXhusfQrEfdrucH5Fm5kssFXAay+nDd4X9O12WV803BASZRcV37wenAh6JoDnPlE+T5zBZASSPM5r9xPudWBImY438f2SlCEk0bMpMdWkKyOQxfzNhvgbgxf13aJNRzgp7s+11ThiDCBRkqHyWRXcAjWRbqq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I5oH72qr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GrqJj451; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A383U0j809005
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 13:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0gQtupiQh7xm0fUtdhHWILT97Aw/Ir/GtOFHBMes/lk=; b=I5oH72qrzlazKvy9
	7vSITRnkb+IvYVfTFanhWTi3mGmmn67gQwqIyuUKBlkiTNvBs4lByoIbG5+achDu
	RM5kfu00589K9GCK9Ag6JwSe5CgRTfp4Y4uqCpLgobboZk75itUEDtbP/04dVMXP
	8NRLFqculFcNDwguXZ1x/fAuyGgIuamax5GbqX5lAcWlRz5BBrK3StmGLFerJ0NQ
	dlrqxqpIWRifoGkZGU745a1AZBjRqPWr6ivFBKWA2b+KDL0hIMVP8m5D76UCIB+Z
	zluy/iBd+22IHCTb+O/fpfMdqMQd1b7xosYP39QplmGTxdA9ZEHixQhnpXTqnMqK
	35JvFw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977crvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:06:47 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5db22173f9fso439223137.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762175206; x=1762780006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gQtupiQh7xm0fUtdhHWILT97Aw/Ir/GtOFHBMes/lk=;
        b=GrqJj451fKx4k+GyF85E3a3zWUYdUnfl66WjivqGIy1mBKSJMxSdUeuTMNmq3L1XMz
         ARgIu4Z9v1KcsL6frPySzhwDiI5cM45yw4TwM9DP2QfZPGd5BL20OYfcoFM0YAilb4nl
         G+3NlQiINuo9QFFyR8pHCbV6ClVj+l2VCGwhD8QuSNEZD6cwlLnV1iCzEjUT3SNWbIDJ
         ARPiEwWPSAS/k6gJei7ZhKJoAJwC23yDdNFN6yvvrVCF9iPkUbCRtP0D1pOBTlqONnyK
         zUd+oxN/cYicjioWQsKbdDYpGcqBb1O100Xs4u9oICgYpSttMf2ABBjo9xZWYmmwp1PN
         GtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175206; x=1762780006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gQtupiQh7xm0fUtdhHWILT97Aw/Ir/GtOFHBMes/lk=;
        b=R8a0Q3dRXCAT/eUP1kWiSt2XhjQxVGtfxLecINUtyTrUWksC2RgoEhqtGVR00R1ETA
         89mCS+iUZ+oaFx8Zoh/OjasRd7aQ7SC6A6tEFGnjhOVBh+JzdIzdwxOOkIZ19KKXfh4x
         iBSsolmfvt784qI7dXwYZOyRSnBjyy4CtoYRwXNHxk/cFZoipHeYBYAuXZg3pRPHSIQT
         3wiAGUFgqoT5/OBN9Ys62Tnp2uZIjUVOqXN+53ToWYJ2ZsgL1/K3AWYgj4JNGZKGEnWv
         lgx4HcQZ09Ap24iipqxCcJrz7yQK8+LnkY7IWOQAqKAft0ynfFsQJgxKuDiJU8Ppdy0+
         fyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj9mttpkOlKD+spyx4PirPmEYT8goMhMbnxr1rUFe5izpmQf+pLmGEA//tUuI+/rQUQJB5n/0p/qHbg38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ggpcOzf/K9y7GSxtwwH5Bp9ETqBjjlqRUd/W/AVnzVafE0nO
	HOHy3Fvt/D02Cq2shCEi6a8EXbSJx7oSP3tSa2M3ddrbsGZLC6EUONiEs0a/bKQxUlWTrfu5bAQ
	d9Tn1XJmOhD06T1Be/E/iu2oePWoXiXpocL21ov6YfaRyyBfx6hh3dXm08ia6Zb68R6Q=
X-Gm-Gg: ASbGnct9eCU1Y3HR2ll27rUJDzIYDzzX1c44jIqtYNC/IAu1HhRTty/gVVOIqhz9ryq
	af9ImUltjwdiCgP43bKdeGRTBKoidquzJhJue8yrZRWoc2ZEHE78b7CrTTi829kpeX9ZgVd8qp0
	AICgEK2oONvrR3JqfTG+Y9GYyokQtkgugathjjCBQTkzv+RHWBwm6rdsFN7VBHfTuSk4IX+aKtf
	XDDHPetvsPSlw/NJ+uyWfhm3yxCNSC5YygmxnaVq0vfnLdAnIJW0Dt9eri87hAkX7UDCqC04SnT
	mjpjtjYEFDY2S8zawLI9LpT+mdPAfst/tno1goHJNbOPltdnkLfHxcFaEVLEwpUyIK2gELSc2hZ
	f9JhfdG6Bx6v8rG6qQOvMBfdOHBSyrX5/+T5YcVAACyPIMOngliO4HxMK
X-Received: by 2002:a05:6102:c92:b0:5db:36c1:17bd with SMTP id ada2fe7eead31-5dbb1384cd8mr1552717137.7.1762175206259;
        Mon, 03 Nov 2025 05:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZQfYGFiNLW1rcYHKPA9Aj4aba2BmPzD97bB586pREaBpqcLuVtZl8564mZTLw+J0EloBKoQ==
X-Received: by 2002:a05:6102:c92:b0:5db:36c1:17bd with SMTP id ada2fe7eead31-5dbb1384cd8mr1552698137.7.1762175204392;
        Mon, 03 Nov 2025 05:06:44 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64095f9ee0csm7261405a12.16.2025.11.03.05.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:06:42 -0800 (PST)
Message-ID: <c0780268-74da-42d8-892c-b0cf2b86ffcf@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 14:06:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH DNM v2 3/5] arm64: dts: qcom: qcs6490-radxa-dragon-q6a:
 Enable all available QUP SEs
To: Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com>
 <20250914-radxa-dragon-q6a-v2-3-045f7e92b3bb@radxa.com>
 <1d4ac08e-ccfe-4b6a-8f77-e97836171310@oss.qualcomm.com>
 <C33391CA9466C163+e15aef57-454f-4c83-abed-542e62890087@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <C33391CA9466C163+e15aef57-454f-4c83-abed-542e62890087@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jYjCRbGD280gsoQ01ofu4ex1QytxttfT
X-Proofpoint-ORIG-GUID: jYjCRbGD280gsoQ01ofu4ex1QytxttfT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExOCBTYWx0ZWRfX3sxvhPuQrHRw
 dCCSk5Qm9aURFih7drtQmMZ92PuEm6u5PynQEiLYuHDOXzlkHuw1m/sx5YlhSPTQ9VtqXUyO5Jc
 lITbSavlvJXoL9jVqzT4FAxMN9QIMP4f9cj3VFli4F9LT0pbePskKagHpKoLg0jroDzUh9ji9Hn
 jTJdMn8/OdZOOMSK680aS36xW3kswmrnA/QpPC24fJBiUrW/TKCnfMBu9U9GAq6CD0FTChQ3Fgz
 286HyOHWjLfgUQfqvV9kdeP5q1dF6qnJMPiBBOskgUB7nuCwRjesbEjjY9zWjQ0Vgyd6wMNukXN
 GYs0jsiCxpjkLmUNfgaNOeZ9AL0nZJyfAOMc4pk5jRk6BM6v2Nn6pUDyqMseuBrlct3dMC+lfZn
 Gnd0QYVPXRLvQVGe+FSIz0ph0gyafQ==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=6908a8e7 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ksxQWNrZAAAA:8
 a=99GkO54zK2vxxsZGscUA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030118

On 11/3/25 2:04 PM, Xilin Wu wrote:
> On 11/3/2025 8:57 PM, Konrad Dybcio wrote:
>> On 9/14/25 5:57 PM, Xilin Wu wrote:
>>> Add and enable all available QUP SEs on this board, allowing I2C, SPI and
>>> UART functions from the 40-Pin GPIO header to work.
>>>
>>> Signed-off-by: Xilin Wu <sophon@radxa.com>
>>>
>>> ---
>>>
>>> This change depends on the following patch series:
>>> https://lore.kernel.org/all/20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com/
>>
>> You should be good to go resending this change now
> 
> Thanks for the reminder. I added the QUP parts in v4 of my patch series, and it's already merged :)
> 
> https://lore.kernel.org/all/20250929-radxa-dragon-q6a-v5-2-aa96ffc352f8@radxa.com/

I had this patch marked as stale in my inbox, it's good to see
it was delivered after all :)

Konrad> 
> 

