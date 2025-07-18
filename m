Return-Path: <linux-kernel+bounces-736475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DEEB09D58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7203B324E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1312A292B24;
	Fri, 18 Jul 2025 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6hI3PNg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF61D7E42
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825839; cv=none; b=oXckU5byd0er/AaZX4fz8HEmDpPu6CO6FenVIMlyjmod9c5+lr1P4AYqij45R0NfYmC8Dk+oWTAZtbMDtTB0tWQ96xpOF8K1X02QxSr1S1bbKYJDJKxle5hN1VVnowr0jyoUT966Ab2i3julgHEwdSaIr44jZoUZQ3TP/5weH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825839; c=relaxed/simple;
	bh=Cd4S2/x3c2nivhZqYlZo9PbkOfdJG+AH9/oE2X9+BKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sd2VKLa7idgGvcIUnhgvSahGcvgx5YzAYGM6cGbSySx7zN3JrV4Ses0jTLSovHVwZZzfGIEztK8pcxx+AwnZmp7zRz7MVt91sJiUS1iXi6pO5I/u5GVkCzmtjZFH4bP25+nwGd3TL4j+WcWjfRYRrga8bJz9lLw19lv9JdcENSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6hI3PNg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7AUl5028060
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxueihSNUT2gvfRCYLszVQxvKLpm8BbA2TEvBIULlTw=; b=R6hI3PNgaBmb/wKU
	275ikXLUpWvTan0VU9GJXpxejQRUnNmYjnz3Mjm+JRaQKEbHtpKcco40BPvput0d
	puOMJKcwtKqrsuQ2OHqbMBHdCuUtebky9mT1WZcjzgj6uVfCu43dqDULfuW08Q5/
	TtBicGgbRW/EQqxyOxhIi3MVKKDq0IzmdayJQEuVIYc7BoEfF38Rpmd2RW9WKmmU
	ipF0/rUS1BDPZsI0gy3p11dQvPviH3W/C03bxuszcW/qEluvI0XXHe79F2wP3dqx
	M/fBzMbRZjT0jGgnqMTSTD6nfLu3AgAAkJq3SDOWiAKKqhS0vdPHRr2JjTJwPs7N
	RhZIUw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh62w3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:03:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3f2e05fb78so658300a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825835; x=1753430635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxueihSNUT2gvfRCYLszVQxvKLpm8BbA2TEvBIULlTw=;
        b=g7v3ntngYtdyB+5nmMa/vL3DW3vvpdx6aTFsuUTqU2AtKoRYwoEqZkZ/XTGlY+9SL0
         7BcR6NameoILfba1QXfk1GRfJWEYpp6uH7S2AEiJ4JlafL6UN+zaSv6K64WJ28JAMMBH
         LnlAgTqZYbQBAt8VZB2gM+o3oKsI6JMdCRKHrFwMr7WJcP315V3adC2Obmmc297Awf79
         eMHtlRR+Sx2SO7eth58rmW5C+1yMiFoXABMP2rZ8+IyEvevQTdQx3JONbx0+khMfPBdh
         CfqjA1q+2RNp/QAD6d6kX53RhSc+RNQftxyqcj+KBDeuJvMiKC3vytRVALobuRoO91QE
         XNyg==
X-Forwarded-Encrypted: i=1; AJvYcCWnBUeS80rWwHnShwXW1w8BkiaQArv6fMI5kYWuhlqzR5OB3enR1TS0ZGdiDa7C8WC8EDIDTCpTAumn+gU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzba7yAjwAB3nMDj9INynCixC5Pi8PSs645OTolYU9Ah1eJGBMB
	NfOKsFd+1XVdi+/ezkP0P2jr7f4VwBlzE6Pu9T3vfIn2HE15eFcuyujDxdQXVA4fvkHGEaxPkh+
	J8GzZ8Etc440bKQ1FFgfdxp8676anKZgfbU6OEZ5cWQgLnjm5Jyql29zuSCGsSyz+QvM=
X-Gm-Gg: ASbGnctByFqvHiSUC/B3HXflZPsyf91vILR5tFzf+f+SeALHiac16CrKG1w4mBL9gpg
	30vah6XwhxOmcQcX2pDe59+3rQGFu7WxtLQzcPg4PTQ8u98Kk4eh7+vB5NR70Ot8jeLYWzQ7r9m
	Jo0amvwLabLtWIbBJc2gL6By/p0nfUr4jiLUW0y16U4zRBno6bBBGuO7iHMghYZOmdDw2Gh5HPW
	N/+r51iFsTB6cSiq4WliRTNu6qq7BSKF40NSU5H5Tuc9iSFbtIKzPu+9TMLPVs1Ory0oTS0BYjj
	t/JhkypOJ6XwQqwLqjMYV0cAx0cv9zOaley5zyKK9Dv/IU+40KhhXTOov8t4x4vDUwAXcQ==
X-Received: by 2002:a17:90b:38c8:b0:313:287c:74bd with SMTP id 98e67ed59e1d1-31c9f4c46d3mr14699052a91.33.1752825834940;
        Fri, 18 Jul 2025 01:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxPYhZgCck07MGmNFAvaF85ucZQYS+3cPmHxVMPoQhjM4CsqlXubj80zgLzii9a5VFOEcvWQ==
X-Received: by 2002:a17:90b:38c8:b0:313:287c:74bd with SMTP id 98e67ed59e1d1-31c9f4c46d3mr14698992a91.33.1752825834371;
        Fri, 18 Jul 2025 01:03:54 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc0be8975sm737350a91.1.2025.07.18.01.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 01:03:54 -0700 (PDT)
Message-ID: <aa2f6350-3235-422b-be04-a03bd3a1010d@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 13:33:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
To: Manivannan Sadhasivam <mani@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath12k@lists.infradead.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
 <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
 <03806d02-1cfc-4db2-8b63-c1e51f5456e2@oss.qualcomm.com>
 <o2gqqty6lakc4iw7vems2dejh6prjyl746gnq4gny4sxdxl65v@zmqse3244afv>
 <1db7c119-882f-4184-9ca4-9dbe5a49cb16@oss.qualcomm.com>
 <gx5gruyhrhwhvwkiqlkp2bggqd4oqe4quvqiiphfzolhjtzun6@okogvabkqah3>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <gx5gruyhrhwhvwkiqlkp2bggqd4oqe4quvqiiphfzolhjtzun6@okogvabkqah3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6879ffeb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bhzlIsU2D2yyHOt3_ukA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: AVfGCtzpKxxgcYhYDhkv0T4TJZnaCyEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2MiBTYWx0ZWRfX+1TzEQORAk8j
 Zf2ugMeOMtxDhZ4aJQmB+8MqUk6/MpT7Liuk9HZSlcMr4twFvpQTGrUU96UNdD4pWXK55iNKbda
 /8n7frLks1pGPLPnZBWc06IgTg6HAMKlvW8/sr4wpIonh4PAKuY6qmBqsStycthObxiuzcXpvBm
 /FyDsKKzJUTJJGDwgHo9HW9Lt4DRt4CWMsquU+kpSB0S6ZPGFUK1W5jING6dghG36S4cgIoT9qG
 GIsvS3Q6oEHL/CtBWck2PGXhoaMtOiuODjJbPkE6lOV7JApRWs8QUWs+uM2AZ5aE8p7Nyiewp44
 yXlGxghapNMo8ra/hrC4S6a8GHZkVuI80gAuHSzZEX+Hy8/k97aypLKu6sz/RO1RU4MZLuYpZ1l
 BfvVwSXuajuDFLyYuoJ4Qh1EsIwyedKmxm1rhaBWJ1l00hEFqWZjVz+/PuSCsun6kyJRXQfQ
X-Proofpoint-ORIG-GUID: AVfGCtzpKxxgcYhYDhkv0T4TJZnaCyEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180062



On 7/18/2025 1:27 PM, Manivannan Sadhasivam wrote:
> On Fri, Jul 18, 2025 at 10:05:02AM GMT, Baochen Qiang wrote:
>>
>>
>> On 7/17/2025 7:29 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Jul 17, 2025 at 06:46:12PM GMT, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
>>>>> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> @@ -16,6 +16,8 @@
>>>>>>>   #include "mhi.h"
>>>>>>>   #include "debug.h"
>>>>>>>   
>>>>>>> +#include "../ath.h"
>>>>>>> +
>>>>>>>   #define ATH12K_PCI_BAR_NUM		0
>>>>>>>   #define ATH12K_PCI_DMA_MASK		36
>>>>>>>   
>>>>>>> @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>>>>>>>   		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
>>>>>>>   
>>>>>>>   	/* disable L0s and L1 */
>>>>>>> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>>>>>> -				   PCI_EXP_LNKCTL_ASPMC);
>>>>>>> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
>>>>>>
>>>>>> Not always, but sometimes seems the 'disable' does not work:
>>>>>>
>>>>>> [  279.920507] ath12k_pci_power_up 1475: link_ctl 0x43 //before disable
>>>>>> [  279.920539] ath12k_pci_power_up 1482: link_ctl 0x43 //after disable
>>>>>>
>>>>>>
>>>>>>>   
>>>>>>>   	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>>>>>>>   }
>>>>>>> @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
>>>>>>>   {
>>>>>>>   	if (ab_pci->ab->hw_params->supports_aspm &&
>>>>>>>   	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
>>>>>>> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>>>>>> -						   PCI_EXP_LNKCTL_ASPMC,
>>>>>>> -						   ab_pci->link_ctl &
>>>>>>> -						   PCI_EXP_LNKCTL_ASPMC);
>>>>>>> +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
>>>>>>
>>>>>> always, the 'enable' is not working:
>>>>>>
>>>>>> [  280.561762] ath12k_pci_start 1180: link_ctl 0x43 //before restore
>>>>>> [  280.561809] ath12k_pci_start 1185: link_ctl 0x42 //after restore
>>>>>>
>>>>>
>>>>> Interesting! I applied your diff and I never see this issue so far (across 10+
>>>>> reboots):
>>>>
>>>> I was not testing reboot. Here is what I am doing:
>>>>
>>>> step1: rmmod ath12k
>>>> step2: force LinkCtrl using setpci (make sure it is 0x43, which seems more likely to see
>>>> the issue)
>>>>
>>>> 	sudo setpci -s 02:00.0 0x80.B=0x43
>>>>
>>>> step3: insmod ath12k and check linkctrl
>>>>
>>>
>>> So I did the same and got:
>>>
>>> [ 3283.363569] ath12k_pci_power_up 1475: link_ctl 0x43
>>> [ 3283.363769] ath12k_pci_power_up 1480: link_ctl 0x40
>>> [ 3284.007661] ath12k_pci_start 1180: link_ctl 0x40
>>> [ 3284.007826] ath12k_pci_start 1185: link_ctl 0x42
>>>
>>> My host machine is Qcom based Thinkpad T14s and it doesn't support L0s. So
>>> that's why the lnkctl value once enabled becomes 0x42. This is exactly the
>>> reason why the drivers should not muck around LNKCTL register manually.
>>
>> Thanks, then the 0x43 -> 0x40 -> 0x40 -> 0x42 sequence should not be a concern. But still
>> the random 0x43 -> 0x43 -> 0x43 -> 0x42 sequence seems problematic.
>>
>> How many iterations have you done with above steps? From my side it seems random so better
>> to do some stress test.
>>
> 
> So I ran the modprobe for about 50 times on the Intel NUC that has QCA6390, but
> didn't spot the disparity. This is the script I used:
> 
> for i in {1..50} ;do echo "Loop $i"; sudo setpci -s 01:00.0 0x80.B=0x43;\
> sudo modprobe -r ath11k_pci; sleep 1; sudo modprobe ath11k_pci; sleep 1;done
> 
> And I always got:
> 
> [ 5862.388083] ath11k_pci_aspm_disable: 609 lnkctrl: 0x43
> [ 5862.388124] ath11k_pci_aspm_disable: 614 lnkctrl: 0x40
> [ 5862.876291] ath11k_pci_start: 880 lnkctrl: 0x40
> [ 5862.876346] ath11k_pci_start: 886 lnkctrl: 0x42
> 
> Also no AER messages. TBH, I'm not sure how you were able to see the random
> issues with these APIs. That looks like a race, which is scary.
> 
How about using locked variants pci_disable_link_state_locked &
pci_enable_link_state_locked give it a try?

- Krishna Chaitanya
> I do not want to ignore your scenario, but would like to reproduce and get to
> the bottom of it.
> 
> - Mani
> 

