Return-Path: <linux-kernel+bounces-793930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D22EBB3DA5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABEF163881
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18925A34D;
	Mon,  1 Sep 2025 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="THgSErlX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7663239E79
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709774; cv=none; b=TOA6CeRnK50b0ZguCbnj9pZ/1abs/CeyLJkQ2lk/5etQBshuTJqhf1eF8wtkDccM/dNFmH81GzxNn2GRcvmVk0iHDAc5d2Ouy9NPQMoJsYgWjYzeMQ2BUvIMg4Czq0CUfME5lRDbFMdE/7I/5mAAFjuK5MdQt9XEC+zJLfWoJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709774; c=relaxed/simple;
	bh=Kr7bzmorPtSCUASbDkgAHM3jzfUg4k7jSAJIfdMlUUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8sQd40UGkUY1EzDBBy4B/XqqDYbqZDNfyz5i+ULOKs6OgHuK/Pf0gyzEI3FIlv5U5nWumVPw9ClTQu2fcRRuGN59cP22Pg0FyC7vF9d+ZTZVMdW4rdngVddyBj0ZA9HUAuDTcizkIp3lg9NbnlpY2i7hxRrEmcRsOkgmSZkKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=THgSErlX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VNh60c019339
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 06:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EUTMpiJXGYapQKmYjxRPfwmA/QRa+grJXv3ZH9iFjRA=; b=THgSErlXkxFPhrDP
	QdsXzrF1SbsD/3nYOoVqP/InZd+C12uq6dgO3yUcHhVMuniE+IsH5bkq51bT1YYC
	+4tS+P15GoMQti7suWRACpJYSXbJRdPbKntmzXZmRCJc7tgEO/Ar7DISVEwPy5x8
	XKblqNqSKrFOwqyyRC238PKH13UkmLJG+BBGpjMHqVASyfKnS8KRwBm0zSQwm+8S
	iO4/eyP3wM/E/xL3CRI4NvzQFcm91Mcz8peksXHQECckOvYpZmHSGDEe3uKqI2Tf
	wDLoXNxRhaLJZNEOLbm+vNAPmwhG+bHFHwGwiEbz9hwEdDI6Jj7MwRC0RsmTUND+
	Jot0bQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48usp7uj8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:56:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e55665b05so3454019b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756709770; x=1757314570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUTMpiJXGYapQKmYjxRPfwmA/QRa+grJXv3ZH9iFjRA=;
        b=jY6Pn60LUYuzawXGme3lp/bGpZIYsZT5x5OREiUBZYorx+So6bb3ha/6o8i1wRMt9s
         mcVGKIB4+PioKp0iLa2luAOCycCvV7kRQUG7WmYWtMNfuiY+sG1l/8M8RPmdsGNNxt+N
         dQAlH+dvKyRvMtu/iveWj6N4S0+r+fP9TwYADbw8FwwUKM2m4HqyuJXoED1KBrttxboQ
         fNwmn0sKsd0bkbuisQ1Qwiwp7z+JgHgAUBEvuM9lKFy5wYoYlkwOS7LCWasqvuEJ+iun
         G/Hsns08/h2uYsDhTBDwnFqxR5NdyW6Zud7Ne6Yyoxzh1SQ7lmRO2Xb6PbE54DhKnJZ4
         dAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKDLX8wD3djiOgu6pahfQJZYQ61wHxLWgXeOB+r5/2RXL+j+4FZMrXvCO+AS6GjDs7n/+kDGKIFUEMvzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0of/KcCE9/POrcgp08I9FdQRJdY+bxPfY7AX/wxhFIDzhuzuH
	4ihzAiseFBzHX1DZXAN3pJBa5QZoq6nmxFZ82yVM7DfWSdaxMbhVrNrEWdT4xf8TG4wYgiVSuAU
	77Quelks7UEAEHE1sLadzZeA16WWzaRVMwoeGfyKXjDffeSReFtz/HoI4LeKy9viY9pY=
X-Gm-Gg: ASbGncsbkoD58imTQrYZIafymGJPG5YphiScFzBWgG8JKgzBjhbpol1Acmm5ujLpTaE
	AUBP88R/RIVsUrr2RR/C/94MGPAT/0+kcDwZqWSWmB2DbtZP+RtfHRDUiTIHJ9LxVnPw4XfZrYn
	erJGnqCNm8mwpmVhVM+FfJuWhUvqFkv6pYAubbCuRmuL+O8wJBYLrSvUNvWpO7WW2fdmquge/SD
	KEJJHrIxKHVYOal9/pBNsOAX8XePF3G1T9XGHYzGf28kOhMzfJ04k51FwdZ7K/ck3NKSWUoCjaa
	je+4dwKeVRKrvP9831n1SVBQKsmsttc+w4PQQBsmY4tsfP5JQrt71JlSk1EityjHvfKKYGS8WlU
	plv0FlMwcloIbTybYgnhgMArFqfURlDFcFA==
X-Received: by 2002:a05:6a20:7fa8:b0:243:a91c:6564 with SMTP id adf61e73a8af0-243d6f431a3mr8852541637.50.1756709770379;
        Sun, 31 Aug 2025 23:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSaKYhdRZRLVbaVGgPFjyPsISXyEB6DA5LnZU9TaTrGjeZVotxSEaTfa85XU0yVwRM0haE6w==
X-Received: by 2002:a05:6a20:7fa8:b0:243:a91c:6564 with SMTP id adf61e73a8af0-243d6f431a3mr8852476637.50.1756709769320;
        Sun, 31 Aug 2025 23:56:09 -0700 (PDT)
Received: from ?IPV6:2405:201:c40a:785d:2c0b:e596:ead5:2f45? ([2405:201:c40a:785d:2c0b:e596:ead5:2f45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7724284fa02sm5689324b3a.102.2025.08.31.23.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 23:56:08 -0700 (PDT)
Message-ID: <3cbe6692-2ada-4034-8cb2-bc246bca5611@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 12:25:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] PCI: dwc: Add support for ELBI resource mapping
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <20250828-ecam_v4-v8-2-92a30e0fa02d@oss.qualcomm.com>
 <ymsoyadz2gkura5evnex3m6jeeyzlcmcssdyuvddl25o5ci4bo@6ie4z5tgnpvz>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ymsoyadz2gkura5evnex3m6jeeyzlcmcssdyuvddl25o5ci4bo@6ie4z5tgnpvz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX0Fouh9IxR+mz
 YTbk5N+Gb7ajLTpCMO/pwuFsOZyD+7hpy7YrcRtxocW8dtHjdTLoKJi8R8mf5VVvnbFXBk516BK
 EkfsGwG3nYcYL3nDHPR9M/K0iIbhV88pGY1LNYbSsply4sIo5sBAZKlfUqHCU4X3Ff6sm8/kVsP
 8/UExy0OnKU+g9/4e8/Ii9z5nXUOfXyDIJ+bUBdSnhMONGttWK7ZOBUSyfK6dRSqQ48rRsmvmSZ
 XGNtXpWvLNWEolNlf2KneLOobjNuH5F+gAFp9TjeRhQRCnij4oePJjA1sOCbB9UVQsfKKjmpegh
 FqLCMojUJdbAg/6YH8w3TcqgDsbPkWUxp/kVNxENqptRW8cut0ZadcXgSceQglDUBxmc0lsBgff
 MNYL3Ujt
X-Authority-Analysis: v=2.4 cv=e6wGSbp/ c=1 sm=1 tr=0 ts=68b5438b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8Rd1e7yjQrnBmPj41GQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nMXj9I-RUmH10WwML2GUNYd1t3ieTr6d
X-Proofpoint-ORIG-GUID: nMXj9I-RUmH10WwML2GUNYd1t3ieTr6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034



On 8/31/2025 5:18 PM, Manivannan Sadhasivam wrote:
> On Thu, Aug 28, 2025 at 01:04:23PM GMT, Krishna Chaitanya Chundru wrote:
>> External Local Bus Interface(ELBI) registers are optional registers in
>> DWC IPs having vendor specific registers.
>>
>> Since ELBI register space is applicable for all DWC based controllers,
>> move the resource get code to DWC core and make it optional.
>>
>> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h | 1 +
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 89aad5a08928cc29870ab258d33bee9ff8f83143..4684c671a81bee468f686a83cc992433b38af59d 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -167,6 +167,15 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>>   		}
>>   	}
>>   
>> +	if (!pci->elbi_base) {
> 
> Why this check is needed? Are we expecting any DWC glue drivers to supply
> 'dw_pcie::elbi_base' on their own?
> 
I was following the same way that existed for for dbi_base, where we are
allowing DWC glue drivers to supply if they had any different approach
like ./pci-dra7xx.c driver.

- Krishna Chaitanya.
> - Mani
> 

