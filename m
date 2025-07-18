Return-Path: <linux-kernel+bounces-736493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A18BB09D97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFC87A1A33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91F21D3D3;
	Fri, 18 Jul 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YS6d4pEW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B819E975
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826632; cv=none; b=HqpkdEcrISjqs66t9JH5g5LHw6Ug5xvjufmnQK1IUM8XBh866AJE4EUFK4Sb4p4uCuRF72VDEhaVdNR3Eas5TNS3tuqsVSb3AdWju43Gn82q1QtOBB0Ivh1xgT5Bj5VjuYKJmoE7fpF1Kd4RTvw7+3I/d+dbkxw4SEn39S1AxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826632; c=relaxed/simple;
	bh=c3hy9aRgyv6WQeXmKUg+68PWX59cR69jnZ9pNPjGnPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMFdn29+YjuhTAy3avIb5sDC9Jp8Emxx/1jC06lR0fM/OLEcmPHHoz+ZBI2+xfUMzXWVTjBDyKU6iUMLq6rgpNEnGYNXWMm0lsc+ADGFFeSJ/9xnPY6+6edPyanJ+46ZpPMr+wI8BXWfDB+IMRmjXHJ8lX3lOcU9SwfE8bP+LpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YS6d4pEW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7ambv000598
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Sz6UouOYzYap4GYepp/i96AYC8KEzgfVubsa4OTvKg=; b=YS6d4pEWNQ86kyze
	B3uKrZ6/ciQRyaccGTChUVg0jamBZrUYwPUhJNunx8nOA6Rc8Hy9Dh1TLmubbPPD
	M7hOEZxmAoCjybdFStKqwHaGOEflvdyjZOEVi2vGVbjx7F1UntJ9P2mNfyPj51CH
	wHTiVWtJA/Y0HR+gwbtwsZGTz/OqQUDAA2J4Rgmkb2BdbljzYnaur4blmMYLC9Ua
	FPX1pIsu149aJ+XJYKXTDbBd1zQzVR5/BzFJBjlVEVdtojT5MFcs3mteqTJaXTPU
	4nzsIBjxnFHeVVXhvFFSw3VpF/xzzjJmAOihDB9YpkPPQdjAlx8F+JKaWmRtYPsN
	TTeg5A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drwrr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:17:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-237f8d64263so18776405ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826629; x=1753431429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Sz6UouOYzYap4GYepp/i96AYC8KEzgfVubsa4OTvKg=;
        b=EB+1RMMlPeuIrVvI815R3UwLhvIN+SlQN8vTbwVd+2YipT2Pfm2Nnedw3kZUEx3HR2
         3M2QMy5jYNcIMweEVUkH4bIMAjUEucXBIlk3NY7qUTJzago6NXEuihPxicEAvbrjjoXj
         uCZVETZsTp+3YnNU49I6PDWNWjhOEM3XCjs1j1INoVANOEPU0LuIYzPetp4uCb7eQ8q5
         njfheM57r+Q2mT7RT/c+/3lkJrL+ppKNs1u/kndOJGkp7kJwRAthS2OWbeuBEh7nfw0Z
         su79epxTuui3PrhxkxE8+l/ZhdzIMr2Hdo0AiTIGufz8nvTvTQM9PYkDA0Ax6G/B49Y+
         2AvA==
X-Forwarded-Encrypted: i=1; AJvYcCWKzk2oO2ctt6NgFlkaGE2VXyVGM2ojrAL8/afQ/bLTsa80L2piCkdFHzI3jYHvOFtRu6qsd9Iz38iHcBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mT3VGgFmtEsXVifN6K0Brw9jkB1QRibRFPY8oWECoYDwTdPD
	8vZ0pbGlFEojxSzzvMNg021J4InpWhA0KJszxudbPkJu5cOBcyAMk2ihL9mev+KES/SBawulr69
	toRSx6qe1DszfDIKW367K1I2dgYvtgQwNuZw3s8dA9no2pFIob7PCdhWM48BAy/bRfCA=
X-Gm-Gg: ASbGnctukyH6atdD4uhixyFJ0lt8Q4e59Pmd85oDlaA/ciKdEvC5AYFwV1WsMv75Lm2
	1d6kuJIMrzfY+ePX3J+4S6CEabAowcjesksPO53VrLw5l/9qfilZ0tI4uEfIg1CGMy9/2KqNYGT
	O9C5Jx59wu4GEpmtrtR2bTYf5WNHHaYsQmzig1YRAN950o8AybC2+cj3V8xoK+t9rhhZyyg5OnT
	hr9oHI7ZTftqy/wbNYWq5F0J1RcNoHK0zYf/IxzqMMQwO5j4ifHT9w5O/mhvmlpA540NydgqAL3
	conZp1RdaSoJEqVcKhMFKfrLVdvKkC+Si4hfPsTNJUknmoFTZ8SPTbwXS1q0t8n3zSw7xw==
X-Received: by 2002:a17:903:182:b0:237:e696:3d56 with SMTP id d9443c01a7336-23e24fbef08mr150794745ad.32.1752826628985;
        Fri, 18 Jul 2025 01:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTX0ICCMvqiCRiHCtB0fXgHKCePe7G4D1Ocxr/5VJZponrjW4cuIj/Sc2rud59/D0HbeHIPQ==
X-Received: by 2002:a17:903:182:b0:237:e696:3d56 with SMTP id d9443c01a7336-23e24fbef08mr150794305ad.32.1752826628462;
        Fri, 18 Jul 2025 01:17:08 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e400esm8408515ad.47.2025.07.18.01.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 01:17:08 -0700 (PDT)
Message-ID: <94944e2f-545d-4185-8679-65404cd01951@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 13:47:01 +0530
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
 <aa2f6350-3235-422b-be04-a03bd3a1010d@oss.qualcomm.com>
 <wbmxxpmcjhsxbracfpvaoishnfz5foqy2rdbp3syqrd377koon@t56m44jvdyft>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <wbmxxpmcjhsxbracfpvaoishnfz5foqy2rdbp3syqrd377koon@t56m44jvdyft>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nNvYRyXRIWzU8yU2QFLQuz2AaCoy95nt
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687a0305 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Dy8vuA9QIKNjNhFCyMYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: nNvYRyXRIWzU8yU2QFLQuz2AaCoy95nt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2NCBTYWx0ZWRfX3PCyBoNa2OOR
 hJnDDo4xbO8KN+UkOnT3zW0mhBp31V64OyNtqqhTcY3TpI5iSryxSV+YtO9azBDUBT5iAqj5vna
 Uu16g0Hnqfct5I673MOX1hvseE84mL1lbSZl36/VulGdIMa4Cv5yGvceimbcVrcWpo3yyvOwTgN
 Q5fLL0d0VPQejwxK65ZSOE2SnW9PAGHCFf4AIw8KRFvDTpvMuxvWghKT7tcEnk/cXaaoaz2jXhL
 +ibX63DgDf/VH92DrK3MFN7tdb2Dm4h/XxRxhE/+HldelPVaITEtOzVsENJ9k4jgLbLXral6NCP
 4aWhSBGJg1GVWVLzWIkduveRCMW3xo9Bp64cbVCPj22IoDL9EE63vU1O2jC1sIWm7J0UADTWSf8
 HjkIcL2QvKayKgrZf8vqfiv1stxeoTIievTqWS3DOfbhw52zk1RKx1jbweqdqNsamsUz4Jv+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180064



On 7/18/2025 1:42 PM, Manivannan Sadhasivam wrote:
> On Fri, Jul 18, 2025 at 01:33:46PM GMT, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/18/2025 1:27 PM, Manivannan Sadhasivam wrote:
>>> On Fri, Jul 18, 2025 at 10:05:02AM GMT, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 7/17/2025 7:29 PM, Manivannan Sadhasivam wrote:
>>>>> On Thu, Jul 17, 2025 at 06:46:12PM GMT, Baochen Qiang wrote:
>>>>>>
>>>>>>
>>>>>> On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
>>>>>>> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>> @@ -16,6 +16,8 @@
>>>>>>>>>    #include "mhi.h"
>>>>>>>>>    #include "debug.h"
>>>>>>>>> +#include "../ath.h"
>>>>>>>>> +
>>>>>>>>>    #define ATH12K_PCI_BAR_NUM		0
>>>>>>>>>    #define ATH12K_PCI_DMA_MASK		36
>>>>>>>>> @@ -928,8 +930,7 @@ static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
>>>>>>>>>    		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
>>>>>>>>>    	/* disable L0s and L1 */
>>>>>>>>> -	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>>>>>>>> -				   PCI_EXP_LNKCTL_ASPMC);
>>>>>>>>> +	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
>>>>>>>>
>>>>>>>> Not always, but sometimes seems the 'disable' does not work:
>>>>>>>>
>>>>>>>> [  279.920507] ath12k_pci_power_up 1475: link_ctl 0x43 //before disable
>>>>>>>> [  279.920539] ath12k_pci_power_up 1482: link_ctl 0x43 //after disable
>>>>>>>>
>>>>>>>>
>>>>>>>>>    	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
>>>>>>>>>    }
>>>>>>>>> @@ -958,10 +959,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
>>>>>>>>>    {
>>>>>>>>>    	if (ab_pci->ab->hw_params->supports_aspm &&
>>>>>>>>>    	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
>>>>>>>>> -		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
>>>>>>>>> -						   PCI_EXP_LNKCTL_ASPMC,
>>>>>>>>> -						   ab_pci->link_ctl &
>>>>>>>>> -						   PCI_EXP_LNKCTL_ASPMC);
>>>>>>>>> +		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
>>>>>>>>
>>>>>>>> always, the 'enable' is not working:
>>>>>>>>
>>>>>>>> [  280.561762] ath12k_pci_start 1180: link_ctl 0x43 //before restore
>>>>>>>> [  280.561809] ath12k_pci_start 1185: link_ctl 0x42 //after restore
>>>>>>>>
>>>>>>>
>>>>>>> Interesting! I applied your diff and I never see this issue so far (across 10+
>>>>>>> reboots):
>>>>>>
>>>>>> I was not testing reboot. Here is what I am doing:
>>>>>>
>>>>>> step1: rmmod ath12k
>>>>>> step2: force LinkCtrl using setpci (make sure it is 0x43, which seems more likely to see
>>>>>> the issue)
>>>>>>
>>>>>> 	sudo setpci -s 02:00.0 0x80.B=0x43
>>>>>>
>>>>>> step3: insmod ath12k and check linkctrl
>>>>>>
>>>>>
>>>>> So I did the same and got:
>>>>>
>>>>> [ 3283.363569] ath12k_pci_power_up 1475: link_ctl 0x43
>>>>> [ 3283.363769] ath12k_pci_power_up 1480: link_ctl 0x40
>>>>> [ 3284.007661] ath12k_pci_start 1180: link_ctl 0x40
>>>>> [ 3284.007826] ath12k_pci_start 1185: link_ctl 0x42
>>>>>
>>>>> My host machine is Qcom based Thinkpad T14s and it doesn't support L0s. So
>>>>> that's why the lnkctl value once enabled becomes 0x42. This is exactly the
>>>>> reason why the drivers should not muck around LNKCTL register manually.
>>>>
>>>> Thanks, then the 0x43 -> 0x40 -> 0x40 -> 0x42 sequence should not be a concern. But still
>>>> the random 0x43 -> 0x43 -> 0x43 -> 0x42 sequence seems problematic.
>>>>
>>>> How many iterations have you done with above steps? From my side it seems random so better
>>>> to do some stress test.
>>>>
>>>
>>> So I ran the modprobe for about 50 times on the Intel NUC that has QCA6390, but
>>> didn't spot the disparity. This is the script I used:
>>>
>>> for i in {1..50} ;do echo "Loop $i"; sudo setpci -s 01:00.0 0x80.B=0x43;\
>>> sudo modprobe -r ath11k_pci; sleep 1; sudo modprobe ath11k_pci; sleep 1;done
>>>
>>> And I always got:
>>>
>>> [ 5862.388083] ath11k_pci_aspm_disable: 609 lnkctrl: 0x43
>>> [ 5862.388124] ath11k_pci_aspm_disable: 614 lnkctrl: 0x40
>>> [ 5862.876291] ath11k_pci_start: 880 lnkctrl: 0x40
>>> [ 5862.876346] ath11k_pci_start: 886 lnkctrl: 0x42
>>>
>>> Also no AER messages. TBH, I'm not sure how you were able to see the random
>>> issues with these APIs. That looks like a race, which is scary.
>>>
>> How about using locked variants pci_disable_link_state_locked &
>> pci_enable_link_state_locked give it a try?
>>
> 
> Locked variants should only be used when the caller is holding the pci_bus_sem
> lock, which in this case it is not. Unlike the name sounds, it doesn't provide
> any extra locking.
> 
Got it. Thanks for the info.

Qiang,

Can you narrow down AER issue if it is coming always while enabling ASPM 
only. And can you share us lspci o/p of the endpoint and the port to
which it is connected before and after.

- Krishna Chaitanya.
> - Mani
> 

