Return-Path: <linux-kernel+bounces-758713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C6B1D303
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0DA1885759
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A122F76C;
	Thu,  7 Aug 2025 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwcUBmyJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C11F0E34
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550574; cv=none; b=bfVs9W3W66ciDJAKngOoj+h0X330GY8DlHfncu0DsCXpGMcSoGjnja92OE62ZQertFeZNZuMcP+A+KYsSy+v3QO5X+cWlovyIi6Z3Wa5ZJzsNRSNyxnDmZqhuxTuO3URDC3V0gkMqtVF6BGxtDVFioAIpK3GH1a5/e4o857M8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550574; c=relaxed/simple;
	bh=xr+ppKt+cddcjWsXhfIDZtODVhgjspa4N6oSE4eElME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEud3irzR4yHoqV/AdDBdDV35x9vNCqFQushtpTHPS2PwkiNrrpt283wHl8aCPzNz141pTb9QlkHCD3/xJK7TpjnATd6hSNgPFxJ2oAFR+8d0EfekswgaWIeP7Cdga0H6rOLSip42XVnGoHwOzHnd9tcT953gb4hEcYwZwSeudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwcUBmyJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5776Rrjr007816
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 07:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZEwGLYz8XiSmNdsJNXaQOuwAlw/NiAcoCG+ATk029nw=; b=gwcUBmyJClxJfCPz
	tLTTztNh1IbtGl+2NYSSrXvtC8PGxYbT3pOj5UulzXf3M1YTOTGY/ZL1vqowUNs8
	YnUSEmczySvZYJihLQBTnTcPcIXP29PJyIdajOiwuNRgM5ImnCoko0puw/ZaEiQA
	mpnTvSppG5zdR0IhrPZQ4vaplTYs8tecNZ7sYrYeUt2zmHkeaHpKVGQeaFGv91/p
	jOuFmQTl7zxXzDu+ZbB55Q4AHXhRqyL3Wt6xPenT2btkQdmqs4GEnqQy7f4PKjV0
	87F81+vlQSlKr1mRQOqACA3q4m79D5+kZGAivVz9hQSGvukMyyNJ35vVgWFlUhPr
	fBvBtA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy03xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:09:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b0e0c573531so535137a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754550571; x=1755155371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEwGLYz8XiSmNdsJNXaQOuwAlw/NiAcoCG+ATk029nw=;
        b=U+cWsO4sTDyUP9af1bEFh+9t/Pdrx2iHXtvIl3cVyGPu13m0hnqb0usPcHPzzQPOlA
         cJBzPWzCMvso88XxP4xgpx+7uuAB64qAPWHwcILdLTFw0MEDk5ZlNfJENNaI3Tq0CcFe
         rUrp6GJrk2gLD/+DRM/I+WqPEORV5SKtMQzjUuhlbILRwihK/JuKiaO8B5vVjL/YbFRL
         BHGLQCPdnIFdlJMVVPBrwA9J47U8nph/YtPCmP7rlqkwCow4dIMJV0Cy1o1hy682RGcj
         lYFYoHH8yC0T3WVwKldDbTQDTYGuzboO9m+bDU1affqOg0LvedP4pKhJ7dzmkMf0Exwp
         2nPw==
X-Forwarded-Encrypted: i=1; AJvYcCWFG0r9XaOPWGchT9qNGCPx52atavJXAHiv/+Bixx+Z3fMs1znNR/mg9yiCBGbfrdEQECq+zKbv3Eo+uRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0i/bOOV6OeHfcnMYthvs4yO/aS9i/uzrrx5VCQ2AVGfiMe3f
	Lr+6gt0wOLIHkL5SRGcudKfidhAukwmrRiRQXJGgsUqDQU/EKdNWMNQZ/nIwqc3l0R/mk9dv5eE
	a4p+kjI/bgaWRxzrswqrWhsFg9X9T7t3kLz48tfJtLb4JAEUXGTXSbRpHKP5kPNl0NOY=
X-Gm-Gg: ASbGncun2IVn3B/E1+/74BZlL/J3okFxdEcoZuxO2+RZm+68p1MFo899VEuzo0XZv5H
	eftAHmz7n/ZrP3gIsMoSgki/ovKh9955Ecmxiujc5rCS+uGakc/VEEa1CTj5gjvAeChybK2vigA
	iOGRBjHfyGvGlQ535nEXIttgY84Zsr3vweVMChR/KHfgHufUbFb4fp67aSx4oCVdGe5XA/Y/EUJ
	xXecEFT1PDzEvWDMNu8dy7EmQP3MTZJr3eP9RGtS+SrMcIiVeZEKB9sni/ikygh4dwDmE4MAMAz
	5DR8XiWmrcOjl5Pe9ci43QzSO5zI+n6aLAuifwS63qS978dd/568U7FQsAU9NEFPQBKX90TRNg=
	=
X-Received: by 2002:a17:903:2a87:b0:23f:f39b:eaf6 with SMTP id d9443c01a7336-2429f43b579mr90060965ad.46.1754550571139;
        Thu, 07 Aug 2025 00:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe3aRe1qG0DJXY2XfpX7tFnk8ifcRKx5s/G5Woq0MqAtS7oEMEjvhrtCOshWW5KX9VFzq6ZA==
X-Received: by 2002:a17:903:2a87:b0:23f:f39b:eaf6 with SMTP id d9443c01a7336-2429f43b579mr90060715ad.46.1754550570723;
        Thu, 07 Aug 2025 00:09:30 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm161651555ad.63.2025.08.07.00.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 00:09:30 -0700 (PDT)
Message-ID: <1c79cda0-2645-4f88-a05f-9082e305fad4@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 12:39:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] bus: mhi: host: pci_generic: Read
 SUBSYSTEM_VENDOR_ID for VF's to check status
To: Manivannan Sadhasivam <mani@kernel.org>, Vivek.Pernamitta@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Pernamitta <quic_vpernami@quicinc.com>
References: <20250710-sriov_vdev_next-20250630-v2-0-4bd862b822e8@quicinc.com>
 <20250710-sriov_vdev_next-20250630-v2-2-4bd862b822e8@quicinc.com>
 <luaoyvwqp3fpvqgybhstnnrutn46ry3tyfxw2launvnxzfvyqo@pdfdpfocfq6k>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <luaoyvwqp3fpvqgybhstnnrutn46ry3tyfxw2launvnxzfvyqo@pdfdpfocfq6k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=6894512c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=21QzX6uEHMqXofhgfOUA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: m4QM3TolTew32DBqCzFuV2L4yTYxM_FD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfX8PYr+PZITfse
 xNG0F4hsTFRQ/vy/yRZgxCFye/DTt8rE7kwW/PaiXfHqyxsTQgu5rFwfQUorVgPFOr1U0bnz8LH
 FWhWoYO+OV/fiDC0L6xLiAuSiCFErLRBfxuNQ6h7kEat5duvnE2d8fR8s/GJbmVgVi6dChY1E2R
 3DvwJI1mlPNIQ9jxZf1DdHiJJUodzWqg8u1I4WfpYSguAVYQNH+Jq/W8cUYl6OGc5DonDRxLPjP
 lwHK8ANNWmJ+4i3c+3iTqixTFG//CTHT312FjpX7vIkSsUuJeZTpXRWLpRMb9ZLEPNpxbHgCRsI
 /NQkCEeQvWg3R24Yap10Kji8kMciZOgiE9Uzf7YHmbigPPYJzCJ4w6l7SPVDTegDYCkDuru+gzN
 oczokq1T
X-Proofpoint-ORIG-GUID: m4QM3TolTew32DBqCzFuV2L4yTYxM_FD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046



On 8/6/2025 10:29 PM, Manivannan Sadhasivam wrote:
> On Thu, Jul 10, 2025 at 02:28:33PM GMT, Vivek.Pernamitta@quicinc.com wrote:
>> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>
>> In SRIOV enabled devices, the VF DEVICE/VENDOR ID register returns FFFFh
>> when read (PCIe SRIOV spec-3.4.1.1). Therefore, read the PCIe
>> SUBSYSTEM_VENDOR_ID to check if the device is active.
>>
>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/host/pci_generic.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
>> index 7d0ac1c34ddf95ace2a85e5f08884f51604d9b0f..4bafe93b56c54e2b091786e7fcd68a36c8247b8e 100644
>> --- a/drivers/bus/mhi/host/pci_generic.c
>> +++ b/drivers/bus/mhi/host/pci_generic.c
>> @@ -1025,8 +1025,10 @@ static bool mhi_pci_is_alive(struct mhi_controller *mhi_cntrl)
>>   	struct pci_dev *pdev = to_pci_dev(mhi_cntrl->cntrl_dev);
>>   	u16 vendor = 0;
>>   
>> -	if (pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor))
>> -		return false;
>> +	if (pdev->is_virtfn)
>> +		pci_read_config_word(pdev, PCI_SUBSYSTEM_VENDOR_ID, &vendor);
>> +	else
>> +		pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor);
> 
> You should not read the sub Vendor ID for VF. PCIe spec suggests reading the PF
> Vendor ID for VF. So you should just use pci_physfn() API as below:
> 
> 	pci_read_config_word(pci_physfn(pdev), PCI_VENDOR_ID, &vendor);
> 
> This will work for both PF and VF.
> 
This will defeat the purpose of having health check monitor for VF,
as we are always reading PF vendor ID and will not know VF status at all.

- Krishna Chaitanya.
> - Mani
> 

