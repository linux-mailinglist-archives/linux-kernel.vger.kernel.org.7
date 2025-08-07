Return-Path: <linux-kernel+bounces-758965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10623B1D654
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBE018A311C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0D26B2CE;
	Thu,  7 Aug 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OP38KEdX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B821FF48
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564823; cv=none; b=W/cQFLeo6FJfHULv/YQmmhnKODFrs9VY22/+nMaARY69m+OJPqhAfqPdKrPbnFBwaXLay/XlMbwOHaGoOM+IW4TqSx9avv1uTreLqqEcyb4ljMf827eq6xcLCCzYQsG+FGAiVMgiIHxeK8WEXqiDHahhY5M+1hpzjMBn6iYDNSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564823; c=relaxed/simple;
	bh=PWMkkhnX3vvqhja9YC5lzWekDzBqHRpC5OdRu/UEuqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5VTbHb6dl8pyHgr8qnCTOSkk0FQE7ydN0v8m/5SaJGr1J/4T41wuMfY/pkaXJMWlsvVYEHEiBKuvFGAfto1Bm5yCdGlks5NFkYLlbgx4CSLnpfc/EV8T/VeP/2ZQQH59EyT672iIOswinBmqUvD6fI5BHjQX+d08E9+JFtegL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OP38KEdX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779CtAS022425
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 11:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x5nNUQTMQ5AyDnKFFuuhfLnqvTm7neZssafyF8/oIwU=; b=OP38KEdXJyCzC8Uq
	eIQU3J5VlSiIv2cpj5hkLeTVBKSn8ssG1ncPfxyd/LqpavP1fZztoIlMDyoC/aAu
	iZXkoQQnd1PvRy2NE1MP/wLyU/fITiAA1O7FIO3ijqBKBRjoWL0CKsox2KYAjy/v
	Tn2vxGYIoMpCD5Z9yxSUngA79091COMdcMcZ/cOW49CIfkZPS3DvMPKOrYyRqZXH
	d4czasI8vQzPTAaPQR57H7M83qflq/xRHWYUgxU3qZ++TL70qadZD64itgciq5ft
	mAfCWGwcvFkH/vvbWvvNmezc8FSWeZftlqWNg1BOP0DChJkOfQ2dJsTLEHnfQqUb
	hI6bUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cs5n8awm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:07:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0938f0dabso1445961cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754564819; x=1755169619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5nNUQTMQ5AyDnKFFuuhfLnqvTm7neZssafyF8/oIwU=;
        b=RGvBR/l6rVqIocqRXN/8Cugvrc5yvqUlTJdkZm4Z8JjEvgYSWq9HJ69Vynu1lym1Xj
         2AwZFDpeCsjQn06BPiFh+9277uRsXG+cNuAtW/LCBzoA1V7ZD1N1Opfp10+yau2w7qON
         AP6sCiNAUVwX4lp2UGiWolMqPYqOhpi7M1nmAUU9fCWGxqdGPuxAo8FWoceYMGcMBBnL
         myVy1U2RoqZUPXebdeAnuLQVjO1dZjA45E9AETWjJrZD7R6MqLMWURVEi02QK7c4cTR6
         16u0f8ZLNGrWDm1XieQea6kD8MMVLu/aqlGZzp+b1DoHWnJSX95RBDDDB4V5869KXd/f
         jXVA==
X-Forwarded-Encrypted: i=1; AJvYcCUUGJqI2gF9bj08GRV4MRLB1JyzmCY6978N74dPuJY4FR/ptIxUnuAHzHZ6TvzOEtpgK25jfcdfJyqRhpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxKP3saKUJKGQTQtUoYNp2z9sfncnhEv2RUYBxqQPhpZh2dkW
	I0ntu0S1CKGM9esbkAyCv+qIT7xIguQcUuJkmcQLwhDQw09kjF2IBnodi5kpTpF7dHPmE3Pc/38
	PGffEnfyM3N/LtZIb5OZJ5K0frE8unReiypmzVXVGy3tmlbGEIIhA5cYTNH13/UxCNgo=
X-Gm-Gg: ASbGnctsPXNbiA3jzMNEa0OakUrXsDEn97/myIFlihj9QIV00wzivR12cUxt8LwM8ff
	h3ECip61PUixWkrejlxDJGgI9hFOZtzn63scs88GuNfqmppSv4dzadmKwjnjyx8rB6j7dI5I6/D
	2DUfGdWejI+kjv/nslUjhL3hzKzwv9XZba6+mkEX/ywssxJPMs+j8MaWd6x9bctNJgZrPBZgDpC
	KWPYL6+JavJYh5AQFWtq19B2Vml0ZEEbwbaN42Xu0Be0I5tsWLJkLQSSGcxsMnGy/r+ff1BgXg+
	9ukphKFPzWIqi+HY+i/K+9zswRJK6f4WYowTQvnXqbcIeOE2FomM2yEj5u8qv2PLUBpJYsJm4qa
	R3c53/cFjq81oP36RnA==
X-Received: by 2002:a05:622a:d4:b0:4a9:71b9:188a with SMTP id d75a77b69052e-4b091414bfdmr47817271cf.6.1754564818521;
        Thu, 07 Aug 2025 04:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFtc3EdN6HJ63OQb2yikwP4G5bxIWwDho2uGzgH9L+DpH3bfGDc/21pGOHr/8IdD4cEtKr8g==
X-Received: by 2002:a05:622a:d4:b0:4a9:71b9:188a with SMTP id d75a77b69052e-4b091414bfdmr47816921cf.6.1754564817979;
        Thu, 07 Aug 2025 04:06:57 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a22057esm1281409966b.115.2025.08.07.04.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 04:06:57 -0700 (PDT)
Message-ID: <4aaa09b8-e944-4d66-a681-a3659fc203cc@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 13:06:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: ufs-qcom: Align programming sequence of Shared
 ICE for UFS controller v5
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Palash Kambar <quic_pkambar@quicinc.com>,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com
References: <20250806063409.21206-1-quic_pkambar@quicinc.com>
 <ucr4imzntw6ghcvpeioprmva7gxrqnkphjirjppnqgdpq5ghss@y5nwjzzpvluj>
 <c62c2744-0d07-4fe8-8d2a-febc5fa8720a@oss.qualcomm.com>
 <mhridnexscaevsmssu6k3l4x276cj63gl2rlvypym23kj2kgov@pw323zkhqcrg>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <mhridnexscaevsmssu6k3l4x276cj63gl2rlvypym23kj2kgov@pw323zkhqcrg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Q+XS452a c=1 sm=1 tr=0 ts=689488d4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=ftMxJ0LbfJfX_HPbJzQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mOo794moPy6mA67ecnkVDjH-Vxfj6ACg
X-Proofpoint-ORIG-GUID: mOo794moPy6mA67ecnkVDjH-Vxfj6ACg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA2OSBTYWx0ZWRfX6dqn5F9VQvZr
 CSXsdLnMv5L8gzEBgnqnUG/74plVMFLJG+Xkt0NVyUVkeInK9XhdZ7IdmXQNwkD1GqEL5wduh+U
 nJUEHuMckaYJ5ACVil+SukTGEe3sV2E1OFnsz6R0dCEgJXX+PBKMD2wODIOxOr+HfmqFlxsIfaa
 Qt2r0NOHxACjtvk5WKHKY+j3vD2t8/aqyGj12pLbk1v+rFQYOh8eUh4svXalG1tOCkNKNUsHvtb
 wGgSGp3UgDAaEp45SBukITbFbYXFGfTGQ6VuNhM7jHj+/81ajgclWpiPTHz6dmkzCWmXFou9f+n
 KSGLXM0RpGby/q7ikB6aYa6oYvXqCGDO+6d+LgGrtGjCDoEzo8F8NQX+lSYWtOVuwufMtd5NiDI
 lxwqKMRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508070069

On 8/6/25 7:39 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 06, 2025 at 02:56:43PM GMT, Konrad Dybcio wrote:
>> On 8/6/25 1:14 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Aug 06, 2025 at 12:04:09PM GMT, Palash Kambar wrote:
>>>> Disable of AES core in Shared ICE is not supported during power
>>>> collapse for UFS Host Controller V5.0.
>>>>
>>>> Hence follow below steps to reset the ICE upon exiting power collapse
>>>> and align with Hw programming guide.
>>>>
>>>> a. Write 0x18 to UFS_MEM_ICE_CFG
>>>> b. Write 0x0 to UFS_MEM_ICE_CFG
>>>>
>>>> Signed-off-by: Palash Kambar <quic_pkambar@quicinc.com>
>>>> ---
>>
>> [...]
>>
>>>
>>>> +		ufshcd_readl(hba, UFS_MEM_ICE);
>>>> +		ufshcd_writel(hba, 0x0, UFS_MEM_ICE);
>>>> +		ufshcd_readl(hba, UFS_MEM_ICE);
>>>
>>> Why do you need readl()? Writes to device memory won't get reordered.
>>
>> I'm not sure if we need a delay between them, otherwise they'll happen
>> within a couple cycles of each other which may not be enough since this
>> is a synchronous reset and the clock period is 20-50ns when running at
>> XO (19.2 / 38.4 MHz) rate
>>
> 
> IIUC, the second register write is just reenabling the mask, so there is no

Yes

> delay required between these two writes. If that's not true, and if there is a

Yes

> delay required, then do:

We don't know if it's required, the HPG makes no effort to clarify it,
but I would expect it's probably not instantaneous


> 
> 	ufshcd_writel(0x18);
> 	ufshcd_readl();
> 	usleep()/msleep();
> 	ufshcd_write(0x0);

You'd still need the second readl to make sure the de-assertion has
gone through before proceeding

Konrad

