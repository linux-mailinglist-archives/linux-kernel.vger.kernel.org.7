Return-Path: <linux-kernel+bounces-898831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE7C561D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBCC3A2C67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D21732ED46;
	Thu, 13 Nov 2025 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUev4afq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evpGfOT4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E632ED3E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020095; cv=none; b=juYB69Kq/9Hj1la0TVAumB99jM1U4Foog3gdns6h35z4q3Y/ucGqNtf2F0kJAWohh3JjkRm9KV+rzNF+gbznex8ww0WnPBaApbdIeq0Xvn0ZEk7Jl1BLwirT+BL5yOtnj6Zy/QkDICjH2hKl6hmX2yXD1wo3q8pSEREPfuiDCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020095; c=relaxed/simple;
	bh=vFb2M/nGxgnEBD9w5S2ekv3idrtEuY3kFjlfebSCyeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cmj2C3PJyQaiSy8eIKUiHhhJPSMtHpuqhdLbXKZW22qAFA+PUaJVwdBeqVU/sk/J7AckCx23Hv7rxZtJYxDHQkENn+T4LMGpOQdriPCf2KQGWxzQTW/9OsuaikR9tSsnfYtD//aqFz51y9vE8VcYku4U8IAHk0twPAkoOoPGQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUev4afq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evpGfOT4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD5S6bS3440445
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZhJiozGc7U8ZGJ8uF2XWeIPBKlSbzOs14hlPqFLDlL0=; b=bUev4afqfG1rIKXk
	adLozXY4vwGey3rmYhB7jvaFd4QdWpywYz0fC2ZUySlVflX6gn5Kk3rrMnw+5Qg+
	T6UJV396b3J+dRotjg2muurlmmslNjiTZxLPY4QNOP6T4KjJIfxGEQ1IDtqSIm9+
	+HqWEZA7ZOQUmw8ta6QjliNsBVHuWoQO74XEGqQ9973z7QavTew8F4ik2hLgiROC
	0kI/ZJM4aSgNA8zR0tXJ3R4AjfR59nTGdlqoQ9T6RDYgeMcR38/tFR5VipCDGm+Y
	aFO0MwvDpyLyD4436+u6cO2ah4LtDYie4ybWLK5FyA9N9oQWXAjHZBiw2PGkqxIU
	bAYq2Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad9788djf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:48:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295592eb5dbso6559485ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763020091; x=1763624891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhJiozGc7U8ZGJ8uF2XWeIPBKlSbzOs14hlPqFLDlL0=;
        b=evpGfOT4PWoMD+LQj99PQtAObLm89GzULZm1xLVaIjrCzyTewg2DL12hyufRmgsQDA
         ypQjbeONOFFY9OJXMh5z8UWmri0T0BnNgZjaApT26r2wsqdnNgy6uhPno4Oyi1LQDy2Q
         +pBtive8gHlyIo8ZMPYhodGw6R0zWSsfgaTPopsOoh/Nh+RBmNO1JeBKe/0MfsPxZ0I2
         ZaFQXZ5Nd8zABm9mbb8AaeWZq6WIFyUQoTxWcZbm8i/PB7PA+ads6SAigF6ZAILKpj/h
         07QBTVCQp5dhQJ9MqqNPMG8jV6Bbup/eyt/myMjJuBZiCJYJg8TGlcyP7Cy4P/ijS2ee
         SBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763020091; x=1763624891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhJiozGc7U8ZGJ8uF2XWeIPBKlSbzOs14hlPqFLDlL0=;
        b=kDbe1wMjv/qD699Yk8EFWmW1J0LmZIkwkXi1gw57Uh5DmDtDgIc+RxVLxlfcDFJys9
         fHVICUvuWl2xkd7bQVRFEonzI0cWFAkw55VFl1DaWxpUrJHiOvZBdjx6Xtn0Y4LiJkhL
         RZM2YFdQTGuV/FkzoVeeg2cz6O5xg3mktcT2kPLS2M2/vDleHTwDDutRHGcptMr+t7Em
         6YRH0vjs2OkqM29N9wQufrV8ebbkPNYiCl/bIb2lTreG5bvZkGod+DbSELjVlxX6rgH7
         5/KjnrRvqcavSG/qwbjX8xabQIeG4QkFxtmEJ4fyeH7eMXcsQpCntBY81+sQcnrS4olg
         8Eqw==
X-Forwarded-Encrypted: i=1; AJvYcCWEFS4SmonrUW2UMEqCIpBAOkWtQGT9JNTOjsmbmdKnFIuwzn2nAjFxx1bj9LWp5ztQyxJ7TuqURQqyI7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2KHIO7TmhmK8d9Xxa+wDoplOdEw8F/BpGx6zz5vekjcWBjjO
	vDn+aOWu/EE8RV59XOiuzMUkOJH1RHmaqd6S00UiV5hn0xuYhMrUhwuzZ5WkkaCI2plbF0Zp0uK
	mSJ0Pks+t5z/4PXr2XncrykeulcI2MofjRyKErlEjDYrIVNbFjDWdk66BHHwIEExE6k2uuH/FiV
	0=
X-Gm-Gg: ASbGncu/nQDW08zH2SwArnIZZWAzFyBYFN2HgqBLkbvfzuLQs+zX9/tabjcrctGVKjE
	pBWjQ0zZZE28MK/92LrTUgEkArgjvJT6ObpKrnGDjvnuKQsY99cmWO/8x1OJSUxuYCC1fVZ9Q3F
	hChfGhraxrRvo/UJgPlDqfa2t69+FL+2/18mCbDx+VEbOj0MHnjTHCKZj3U0CqsSGUt9LQaLG2P
	zjZG8nnspMQ3q4/YdXiEjMBT63j/rMMS7WlwJnmQPcFjuZzIDKToIumL5WExJ8BWM5p7XNM2GBI
	D26VE78N12kUiikySzACKq38tF0z5PvaDNeIiXv4ZWZxh/21S1KGYEIOqskTXzBH+aJhz23h/P+
	JxdOY4CKHnL3rKGhc1iF/AW+BSaEAS/k=
X-Received: by 2002:a17:902:ebc6:b0:298:495c:1bf0 with SMTP id d9443c01a7336-2984edd2700mr69775655ad.44.1763020091151;
        Wed, 12 Nov 2025 23:48:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8rRkEuWW/6gSHvrkhgOhcnbTpcGFokK+8H6N4ylsRW3aMFxk3k4phtF2p1olCGtMTmr/Plw==
X-Received: by 2002:a17:902:ebc6:b0:298:495c:1bf0 with SMTP id d9443c01a7336-2984edd2700mr69775255ad.44.1763020090661;
        Wed, 12 Nov 2025 23:48:10 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm15548045ad.88.2025.11.12.23.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 23:48:10 -0800 (PST)
Message-ID: <9dbae7ca-b24f-4591-99cf-7720ace6a452@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 13:18:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: andersson@kernel.org, robh@kernel.org, krzk@kernel.org, helgaas@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
 <gqvc3orlyk6l5jq2bpxsf5lvvafmtxcpdquffcpdqdiek3bldh@l3em25rqaldg>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <gqvc3orlyk6l5jq2bpxsf5lvvafmtxcpdquffcpdqdiek3bldh@l3em25rqaldg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA1NCBTYWx0ZWRfX5gV7pAtSLciA
 fjCe8813I6YLRAazpuGvMNPNapUGvsYkxE7gZvcNWt/VNaArS83rM7wFl+NapWtHhSjV1heyxYU
 LhPruZZUSWMuI7I77k2opgN4GA4K005iK2Xc+8088MVD861uze5fHR+MXaC17XXD6OM7H3RP6Ha
 S0RJRObDLYXuhPvujVPmfzyqZPuCERdsjXtxyaRNdZ+AGtC3B0izCCP8XZVNxJU2j/gMOHtoOv7
 MGqyoqs8tRRFbM5cgGR1LFixwLwAQhi22OjyURyeynLi3WmwlthWY+iX9/vtdGo65dVa/1HLrM2
 Cw6Pgbl+Tr+PLp342KMPJi5UEWT1PXJ4nQb9ActmGb/JxNovXmSvh4Zm7SIRpDPlNBZ3NRJWHtR
 m/3bRJvfHdRMRcOyVTlKXYuRqHGqDw==
X-Proofpoint-ORIG-GUID: xTvysJiMEwfYPHVvsuxKFQ6PVQihO1nX
X-Proofpoint-GUID: xTvysJiMEwfYPHVvsuxKFQ6PVQihO1nX
X-Authority-Analysis: v=2.4 cv=PIYCOPqC c=1 sm=1 tr=0 ts=69158d3c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5gsRW-pyyPTur7QFVg0A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130054



On 11/10/2025 5:33 PM, Manivannan Sadhasivam wrote:
> On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
>>  From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
>> minimum amount of time(in us) that each component must wait in L1.2.Exit
>> after sampling CLKREQ# asserted before actively driving the interface to
>> ensure no device is ever actively driving into an unpowered component and
>> these values are based on the components and AC coupling capacitors used
>> in the connection linking the two components.
>>
>> This property should be used to indicate the T_POWER_ON for each Root Port.
>>
> I'm not sure if we should restrict this property to just Root Ports. Defining a
> property in 'pci-bus-common.yaml' means, all PCI bridges could use it, but this
> value is applicable to endpoint devices also.
Better to add in pci-device.yaml then.
> Also, you might want to add some info that the driver (or DT consumer) should
> derive the T_POWER_ON Scale and T_POWER_ON Value from this value.
ack

- Krishna Chaitanya.
> - Mani
>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>> Changes in v1:
>> - Updated the commiit text (Mani).
>> - Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t
>>
>>   dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
>> index 5257339..bbe5510 100644
>> --- a/dtschema/schemas/pci/pci-bus-common.yaml
>> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
>> @@ -152,6 +152,15 @@ properties:
>>         This property is invalid in host bridge nodes.
>>       maxItems: 1
>>   
>> +  t-power-on-us:
>> +    description:
>> +      The minimum amount of time that each component must wait in
>> +      L1.2.Exit after sampling CLKREQ# asserted before actively driving
>> +      the interface to ensure no device is ever actively driving into an
>> +      unpowered component. This value is based on the components and AC
>> +      coupling capacitors used in the connection linking the two
>> +      components(PCIe r6.0, sec 5.5.4).
>> +
>>     supports-clkreq:
>>       description:
>>         If present this property specifies that CLKREQ signal routing exists from
>> -- 
>> 2.34.1
>>
>>


