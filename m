Return-Path: <linux-kernel+bounces-762196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5FCB20342
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F5C7A85D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7B62DD608;
	Mon, 11 Aug 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jKdT/Wjq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB492DD60E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904323; cv=none; b=kWUIy7ne7vJmZbaHbWmzKM6CA2Q0Hb8UCwPSKUb+ULGKZQWW6tQ/pVG1n4aco9SPkIBVYe6T5YDz8ULBSlkrPLqPJrbxR3c/03gLLcjhoO4wf+YjvBrieRKtHPKKtaxSYJ7SvVbqw+tgDvbyfxDT+DEFOr1e3EGt9+iO7GGqg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904323; c=relaxed/simple;
	bh=5qIM046RALuOts1rvwHZ0Oae3nIbBnTPFzNmQT9Ch0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+nIc2fhA6ADBL18YcEz1PZ5boQdHplYYyCYIQMNDjXzwcAjIdiYbVvb7JsPG/+eTxUZA5ge6wEK0pYFZVU5Qf6dNS3FOD7kjN8hFAencdEejCF5EasujahIVapT2vWGWsLscfJUvlLDXjOD2B4k22LY34ZQ8eM1jcdhLX23iEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jKdT/Wjq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9MC2r011512
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d5brsbQXcuMZs7M3LpkJq0KWrfVjzolKtDa4nkNHsDo=; b=jKdT/WjqipJFNT+a
	NX/oG2GaNNjl6thViAQBbbLnd+ZcCCMV1nAbOuecIXsD2j9OBGn/M4xkrZrP96n0
	ZCqnFu7hqWoOOp/9b0kelE6VxmZziTcZs9CRTgSFNheDFrSNSx/nnuGsfm9kumxQ
	yj8k/pNdksFryrpAwOzQrzLBUAVHxmU6LQoSiVgf/rzKczcN3QuQe1Y3rJTiMBLr
	xba0F8vI7bxouN7coQ9jhS2JqjXYD1NjFrZgtsTzbs1E39C7JIjyoabNT26znjML
	FSDaDj9McIAmrZmbuOggzrUUMRFAuuOnmVjDIDfGAuCVov+/Hx4tDVk8jJPG91Qe
	5ugK/A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmkxnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:25:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2424aaa9840so45424205ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904320; x=1755509120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5brsbQXcuMZs7M3LpkJq0KWrfVjzolKtDa4nkNHsDo=;
        b=edg3kpd7r7Wy73Y1SA3041yb7rQzr1dF9gankCqhEtFTP8czd4UwVUx91jD3mUeQsV
         m9WJBm5ubRYvN+rU85H8Q2Tq7dkzGFx3RmeYxf4DgoZTzYgcDmaf8Am0UGsaDVWBwfT0
         RYrIogiVPvKw/+jTsV8FjXoxIC3mrOJ1qa0Be/7LujDQTUm8i838uk59fVZ9ZcLL/OS0
         l7gsuugafsVHmcXrwegFJ8nQyyO2RrCZ6enZsdcIBoyCUcQMWRaHkA8A0zGH5esHaINE
         MZt1fll2ozjcC/DibMKaJ/f3jPJ2C8tCP3diAJwE+F4U15ZfvjEdQOtQ128FkLn//yj0
         q3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRXPmxVStRAYRjpSiSmJXNogfNKAvCdQzSLZkHm1llEACOBAkMXZIUp2GQL8ZIP7RPlQX48lDRZctyAF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnaZFhdR36ym2jyBs8vfI9hPjdr90qaPaVYB1jMIXRZgCz8aY
	VYDR1Lpvyz5PJLxR8WUriGbv2aJVUzVDRnrE5WHUhJH/sDOgFAdRR2fIi6LU0a7CzM7n2uDQmi7
	f/odp3znEcIwFOOhWmXb3fmahNeOjgvA3OksKE7j5siUFshoog9k1nlF0UXeyUUboiPQ=
X-Gm-Gg: ASbGncteiAC3et++s7MhsApYmBnQvH/AosX7CFmuh7cWuPeoLnyjcuI5ut/qU9Lm2oF
	k9zAqYdT2H1YU6ilhHlwNYr5qNjlJBmvXoC+0KFs5HV5eDfy7est0IxSW83gzCYSR9tJ17Z+3BV
	RnwpWXNbfF7FxhZ7jxV8uXvA1mnbPS5UckRvEuanRSCQ9pqQ9AGpWWYNz3McIHlnM988OjXn6jZ
	bIl0mqtkOAOpyQHd807dF49QuKcBSWMKY7jpVzAQyQaZo2XT2izIYDisJ3k8mG3qRWtsLwM2xAa
	ufFDP8cm73voRW/da+xjY21Kx0L71VyEbmwfgmGC3xJgabcyq9tevojbuBaKWWWvaHDUP//cQdQ
	OBGustqOjyJv8xk9F7wU5PdwjgGHuNg==
X-Received: by 2002:a17:902:ce90:b0:226:38ff:1d6a with SMTP id d9443c01a7336-242c2003629mr183281655ad.7.1754904319825;
        Mon, 11 Aug 2025 02:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY2W7Uzf0+Hhm/oLMQxV3US2K/ii+xsd0BX+O+K/VV6q57R8neGNUbis0mR8USg0+ba7mSKA==
X-Received: by 2002:a17:902:ce90:b0:226:38ff:1d6a with SMTP id d9443c01a7336-242c2003629mr183281315ad.7.1754904319373;
        Mon, 11 Aug 2025 02:25:19 -0700 (PDT)
Received: from [10.133.33.13] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67aesm269903595ad.6.2025.08.11.02.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:25:18 -0700 (PDT)
Message-ID: <571a76a1-c430-49a5-a8b6-974f71a6437b@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 17:25:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] PCI: dwc: enable PCI Power Control Slot driver for
 QCOM
To: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        robh@kernel.org, bhelgaas@google.com, sfr@canb.auug.org.au,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, krishna.chundru@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_cang@quicinc.com
References: <20250722232255.GA2864066@bhelgaas>
 <a243dc20-6b48-425f-ae43-786d347b2458@quicinc.com>
Content-Language: en-US
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
In-Reply-To: <a243dc20-6b48-425f-ae43-786d347b2458@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=6899b701 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=cQi23a1KtdDCxFO6Ja0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: haRB3uDe1o4NMRKlnxk4qk5pvErVxPu3
X-Proofpoint-ORIG-GUID: haRB3uDe1o4NMRKlnxk4qk5pvErVxPu3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX1sqaX49LIsls
 WBTqtZHKFj3P8QDcEBPMkoI5b1RLGRNCaDLcCqg/jTF10hYzU26igiJPVrtSAxMdM9777M6guUR
 /9LiKSoXakOCG8TRvdlXWk373HjLNNdaS35R4qzcz+I2BP2FC0+4QmBCyLgIb0P1gwq1A/Dtgho
 y97aOo7jIhdrbZkdxvN+BQPvaDIuG3ebgVlao1Zox86zyh/tS2yXomNBsZky2o0hKkOh/yrCQng
 U13PXBjy2mUx/lQPzukM9fvQ+NyCf2VzJ8MqWf/62PK2mG3/huYJtJvDt6bayk1SM+NGjcsea8N
 90YmxLWekU2noWfuemu41Q9QXazmghInFESVeVS+j7IuybUB5KfAx/TaZcW9tZfSBx+21WwPBtz
 oKvp0hLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1011 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000



On 7/24/2025 10:52 AM, Wenbin Yao (Consultant) wrote:
> On 7/23/2025 7:22 AM, Bjorn Helgaas wrote:
>> In subject:
>>
>>    PCI: qcom: Enable PCI Power Control Slot driver
>>
>> This is not a generic dwc change; it's specific to qcom, so I want the
>> subject to reflect that.
>>
>> We can fix this when applying unless other changes are needed.
> 
> OK， will fix it.

Hi Bjorn, we have nothing to update, will not send new version, could you
please pick up patches and fix this when applying if there is no further
comments?

- Qiang Yu> 
>>
>> On Tue, Jul 22, 2025 at 05:11:49PM +0800, Wenbin Yao wrote:
>>> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
>>>
>>> Enable the pwrctrl driver, which is utilized to manage the power supplies
>>> of the devices connected to the PCI slots. This ensures that the voltage
>>> rails of the standard PCI slots on some platforms eg. X1E80100-QCP can be
>>> correctly turned on/off if they are described under PCIe port device tree
>>> node.
>>>
>>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>>> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
>>> ---
>>>   drivers/pci/controller/dwc/Kconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>>> index ff6b6d9e1..deafc512b 100644
>>> --- a/drivers/pci/controller/dwc/Kconfig
>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>> @@ -298,6 +298,7 @@ config PCIE_QCOM
>>>       select CRC8
>>>       select PCIE_QCOM_COMMON
>>>       select PCI_HOST_COMMON
>>> +    select PCI_PWRCTRL_SLOT
>>>       help
>>>         Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>>>         PCIe controller uses the DesignWare core plus Qualcomm-specific
>>> -- 
>>> 2.34.1
>>>


