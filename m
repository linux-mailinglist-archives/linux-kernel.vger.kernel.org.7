Return-Path: <linux-kernel+bounces-758814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CFB1D426
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27B1E4E3A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3C23C512;
	Thu,  7 Aug 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zw0Hlf4P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889B182D3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554550; cv=none; b=tOc9c/ddoEjhrjlqJrZWhYsWbJsjn9j4v5RehXqhjFGOO6G4yF/3tpczvmyN0BUwM0VhiMDbY1GgnM8NNt31SiagaqBjj/NX8lQ8lymiiMMHG0sTTX4EyGkEYgF46aAEJwtKFJk/luNj7JkpvKEwDIVziP+SWrZyopTiGgjXAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554550; c=relaxed/simple;
	bh=r7B6Q+7VnOlSFD9dmRU69c6xXNsKJZl6lpeNkdeAlW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMWrqia+xWObDSdRsn+aNc+u1ZpSJDQ/61qL4XlJEiPPhqb0cGRxbyKbFQ4nKISMow29jWhyBu5qrbbtpUowlTeN8dFnvKf0+cdnZbHuEN/iUphTzLJuu2Y0Rk4balFfLXQgOs5JDeoRMvjbcpvrQ5+ZYS0CbjOi/VfO2xEiN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zw0Hlf4P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577248Jr020326
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 08:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8FFkztz/vOpS42siZaTzrJaru4LZfNmwJ6q9DN41I/Q=; b=Zw0Hlf4PZ+FqrUk2
	meWkuRneDRHwocs9It4DIeEOTI0KAJIwAK3QcCnNNUaq3LaBzpVE4wIYeE9sdLJH
	HGQF2wv7yH20XDwoHYLAjuMDAzEBeHKTeEMlbJ75UUcI0pjrD0DExHbG2RvpDWVr
	XIZNyMJP89xuUgf+nSAHGqXmYMxZiLmRCXs8WEY8NoWq6IfD9MTGwCMLvFF6W2no
	DDn9ptcD4weuqS/fzSgx7uHQs/RPHM8holEp5JzkXVw6/s7DBOskZnBqI9sbnz/Q
	7ngqwm7mE0CT81iwMAjeFmABHKyC1/YK+Z5JywDJfuiXWGus50O1tYL3KKXiAux/
	ZC/5Bg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvvwj1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:15:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fe984fe57so11211475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 01:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554547; x=1755159347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FFkztz/vOpS42siZaTzrJaru4LZfNmwJ6q9DN41I/Q=;
        b=OTH/uwktQHbe/N0Svl1REmOlDnNZXjZNGABmkmFYywcDtd6LDo15AnR1iT6h+zTxWX
         7pQD/QLlJmLM9c6qcZdY5atpzfI/rUY6FcU44lF7xypNMJvq/X5wtItDwUml9tIYS2Pf
         ZYv2R4TEXyYTF5luh7HLo8OU61O/tt/zACKP3nIa4SaiSlWJkAQrx/MUSBk1UdIPnCwT
         dzgPJpzLa05s8Grpn41EXIee+vxmjLA+K73uCQHDjL8vpjRcpgZbdrWpCFjRSnXGA0sJ
         idErFTPb1vSLzctPPRLqP+DdjnSJOL1Pm0alLM2RTTtUOkKnQsJlMYv+SnFdfGIkaEpZ
         FjqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1MwsW1KrUo/165JZDuULhHlpP/4pMo+utqvCz2bP6pvN8XIM40kZqnZbWjdhOBhIYsxQc9ytD/sXDvjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEt2Uu3MMJswHfdz/PPuZvuSBEkSOhGJJ2786mi2+aefwCRP2M
	snN1C+lYzXFhmT+eY76AqAcrbeuSk03tCR+Dr/QuquXnyjlORPXAK16Fcm6a/a1ceAG57mdQ6eM
	IF3nlNpRRiIA9J8qktTBUORoI0OXDv7yleW5i8OR2mMu6i7Eddmo8wENBglP8Os1oBuo=
X-Gm-Gg: ASbGncslOq+g0/ewgEzUnZqNbvHO3C5SB04rtKuNv7RzXx7f2293NbGgeHaGFctQIUs
	laFcBH8gcXxMR1gzpP+SegGDvrDT8Rpvvg70k+k+YEfg1sTfKjhWwSwnwYolGTQrIuNr3DGrCVJ
	+8mOIYNfuUutrB9I0krSZP6gDJKRW/VmHSfLMfz0JPUEucBT9FwkSJRZeY43Xk0UFqLM3vnS5nP
	XBzz9XD04W3wT1Cs9a5GVOtHlq364ptZXjLon2h3N2r7SmabnlyuXbnfnFd9STQjcE5yn/wweVo
	LqFl4Bl/8UlSoHLKkcP928OTFkxjGfF64Ak55NPnPJVvFpE9+lA5Uw40C74G+bmJhT/INAykqQ=
	=
X-Received: by 2002:a17:903:189:b0:240:3d07:9ea4 with SMTP id d9443c01a7336-242a0a91131mr91223215ad.7.1754554547102;
        Thu, 07 Aug 2025 01:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzSnmBX83MC5kqRMV7W1QAuTOZBWwPl92I78BofL/XeVsXz8pCRHuSkr0ugBp8auFgWzSvVA==
X-Received: by 2002:a17:903:189:b0:240:3d07:9ea4 with SMTP id d9443c01a7336-242a0a91131mr91222775ad.7.1754554546546;
        Thu, 07 Aug 2025 01:15:46 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef65d2sm178661625ad.31.2025.08.07.01.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 01:15:46 -0700 (PDT)
Message-ID: <7118392a-2a19-44a4-97c0-d5e8a3190c08@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 13:45:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] bus: mhi: host: pci_generic: Read
 SUBSYSTEM_VENDOR_ID for VF's to check status
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vivek.Pernamitta@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Pernamitta <quic_vpernami@quicinc.com>
References: <20250710-sriov_vdev_next-20250630-v2-0-4bd862b822e8@quicinc.com>
 <20250710-sriov_vdev_next-20250630-v2-2-4bd862b822e8@quicinc.com>
 <luaoyvwqp3fpvqgybhstnnrutn46ry3tyfxw2launvnxzfvyqo@pdfdpfocfq6k>
 <1c79cda0-2645-4f88-a05f-9082e305fad4@oss.qualcomm.com>
 <tynmkh4isrbi473zh6t4kd5bswrthxy3garhgpzafq6n2wrmqk@rfanfjgciyqv>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <tynmkh4isrbi473zh6t4kd5bswrthxy3garhgpzafq6n2wrmqk@rfanfjgciyqv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: n6vHwTkOdGRY9Eo_oOAAru2CPJbUTB3k
X-Authority-Analysis: v=2.4 cv=GttC+l1C c=1 sm=1 tr=0 ts=689460b4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uIgEQj9WjdynuVTCvEgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: n6vHwTkOdGRY9Eo_oOAAru2CPJbUTB3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX0LzSj+sHcizC
 wiC714CxSfU6CMrx6yt75SnhQDPzurKFHNIEjjuhiq1Q1JiWu8sNvGpbs6ZOhKNyX28vQhaPJC9
 MStBl21d1E5Als/Fmw+LEnVSnf6uPHrRyX/nCVusyGinyvLSiBkN1IPixRHl2MaFXcIllM9Strb
 rrVIfluKOGbAUXhnogsF+dss+eYQJHkhdyN/7B0jnxy09hGg2A6g9eIiz7IsuW70rl+Qi8Ncolw
 rsQt/ZxiStXiMN7GLPgjQlnaD2KC1Yofq5FFbyY++SPWSpzG+oByzayEQ+o2CPkb0SBPc6L8NGM
 b4w3XqtiCScBJ2KZ767FGUzOpkphLRwKOsiJz6FGhEFCoXazThYtoEB1NXnU4wX22Vu4gnXJOJD
 WiI5ruaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/7/2025 1:43 PM, Manivannan Sadhasivam wrote:
> On Thu, Aug 07, 2025 at 12:39:26PM GMT, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 8/6/2025 10:29 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Jul 10, 2025 at 02:28:33PM GMT, Vivek.Pernamitta@quicinc.com wrote:
>>>> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>>>
>>>> In SRIOV enabled devices, the VF DEVICE/VENDOR ID register returns FFFFh
>>>> when read (PCIe SRIOV spec-3.4.1.1). Therefore, read the PCIe
>>>> SUBSYSTEM_VENDOR_ID to check if the device is active.
>>>>
>>>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>>> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bus/mhi/host/pci_generic.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
>>>> index 7d0ac1c34ddf95ace2a85e5f08884f51604d9b0f..4bafe93b56c54e2b091786e7fcd68a36c8247b8e 100644
>>>> --- a/drivers/bus/mhi/host/pci_generic.c
>>>> +++ b/drivers/bus/mhi/host/pci_generic.c
>>>> @@ -1025,8 +1025,10 @@ static bool mhi_pci_is_alive(struct mhi_controller *mhi_cntrl)
>>>>    	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
>>>>    	u16 vendor = 0;
>>>> -	if (pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor))
>>>> -		return false;
>>>> +	if (pdev->is_virtfn)
>>>> +		pci_read_config_word(pdev, PCI_SUBSYSTEM_VENDOR_ID, &vendor);
>>>> +	else
>>>> +		pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor);
>>>
>>> You should not read the sub Vendor ID for VF. PCIe spec suggests reading the PF
>>> Vendor ID for VF. So you should just use pci_physfn() API as below:
>>>
>>> 	pci_read_config_word(pci_physfn(pdev), PCI_VENDOR_ID, &vendor);
>>>
>>> This will work for both PF and VF.
>>>
>> This will defeat the purpose of having health check monitor for VF,
>> as we are always reading PF vendor ID and will not know VF status at all.
> 
> Do we really have a usecase to perform health check for VFs? Health check is
> supposed to happen for devices that can fail abruptly.
> 
yeah as VF is not a physical link we can disable health check monitor
for VF's in the probe itself.

- Krishna Chaitanya.
> - Mani
> 

