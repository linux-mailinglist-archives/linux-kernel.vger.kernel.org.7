Return-Path: <linux-kernel+bounces-735143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48098B08B60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A905882C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B3529ACE4;
	Thu, 17 Jul 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZDJwHd6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB929A327
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749752; cv=none; b=pnqEL9h/iwXWezF/DBxgDzHBzrSLIHbpUs+CWeroNLQtux0RL5ySt5u8x6crKWjeOJidiMm46lSgNMpB3yE1sVoIG/pPT7/y8LaXslXE85qDqh9f5fnBIT7YrfPf0clDcLlUDGF79BxsQ17wjIzQinsVuDVT9k6vx6cislDkROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749752; c=relaxed/simple;
	bh=m4bhiRaxDw14G00aNNxF0/Fk5xp4oxLL37CkgM+bSuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5IZnhQBWl905ia1o2G7TZGNTgh0MLgpWGIRllTZY/8sE4wt2kczXU1+ADzuHvWtF8X6dw+/RYlfCRinJOGT6lF3nTrrdIWRZ90p0L8ZzXKKhUc3gMZ5hBgJ1kt0dJBQz4U3lv3O5ThVJXUHiNiKdbosx9bIKbouLBHNOS7cEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZDJwHd6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H4etkq032308
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EsEUvuBRDMzRKRRLJsUyfbmC1yOuPlsLU/0xN60mrqE=; b=IZDJwHd6XDcNhEnd
	3yf4+K38F3BML7mfcVVvbjH/f2Qlf0RdNFFggnIMqcGgv+5Tx0PZmXfho42t04C1
	pKsN6fTlZYmh5W077iGc97meCjX52xm4sbvx7+NN855CHSby5S6C3cW9gvHayI+Z
	YRFiQEnF8EnHazbc9mgiPOtVsjKT0rYYbVwRpSNlRztyM7kDY9kwqbSqqIlesG3O
	SN+Em2culeXThD9nnqxvOn5WH211W6FBvPA2gpI3RRHyQm6TZvSyboWXkhGEd+fp
	wjMTQulwOHt3I/Esw85vMa4xMcnyuWecMgFQosNTBD/xy+gDyhKdfxfukzSBjAZR
	oo3vHA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug387f7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:55:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab7077ad49so1401401cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749749; x=1753354549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsEUvuBRDMzRKRRLJsUyfbmC1yOuPlsLU/0xN60mrqE=;
        b=Gvq8n0egt3hj294+YBhAaEpeTWbWvdUrCPElpFo6jxy+KPdhNRTokhfN6012G5dF1O
         v79NgzPkdH75s1R6looSdOsordf2dar6UQbW8oH6sYKfb4IyzVgY5YujvgoQjO80C4qn
         9+k0hfVw0jCI0zGzlvpo+gnH2ErufZWNkr510hEPSVBtrUQn8kbq0XSeTp764+DTPyaT
         2ALdI+IOfuNCijfnAA0DakS7cmctSlNLsbD9A5LnrCnwwDgGPfZepu8OthHF1xmqzw5Z
         2uK2SOzZWWl0JzzbRMcIzfbw1ZbRQDz1s8WlFtzF6ACpGARTjwaJcwrrUF/l5ujPkv62
         j5fw==
X-Forwarded-Encrypted: i=1; AJvYcCWQQokllX7UQbs6wuH+c2cLfsRZSGoye0iAyVfm2GTRg4mPOTfkDI0k5xUnPfeVfOMGh1FqDluZ7GU6i1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ONIcPsg7dTg/RM5Rd0x3AzxXgC42+HjJW5Oz9X4s2qE5LSrP
	0O+7/7Mu4bD+ETe1aLwqUgTQTXrVv6RsIHhTdwAAhR7O5GQUiBCH/S/8dBRdBDRWb6heZ77d2o/
	xHR/lcn3cfdbVC79eXR5w92w7xvKLR9JMUgl/hDRT//dPNWqUwHXJwh29lh+NYd986io=
X-Gm-Gg: ASbGncs/FqDtXuneoerip/hHMQGGOkD5Wk8F3Eb5g4gasbQFI0PsYzBIS5Plovm9zFN
	dHynkCiILGGeB0AYnwxTJvhR37YiCNB3ndSHHgAmIa0mOY4NSreu2tK5/GBO3s6behoXol0ihcu
	eEzHeVEbJud9h0r9SghcjYwwpC2mxTrO6gFCyMAC+TY//ZWmi8k+BxS6SO1K1LMB034VTK5Z9fy
	QYtpWe+BqBPNMcJe/RkWZW2QqVchav07K5VPFbbZqCh9mJXmYsG1cshgfLcHHRunKl0ERA4JUYE
	261+IU7ns6pJQUgpG7dtdnT806p4HsNmEGKuxO5G+9+wbdaSYev7nJa9LbxgH1POV+9xct4lpIo
	hThIvb443CCd+luYiBP6J
X-Received: by 2002:ac8:7e89:0:b0:4a9:7029:ac46 with SMTP id d75a77b69052e-4ab90cb3599mr37973891cf.13.1752749748775;
        Thu, 17 Jul 2025 03:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIXtaAbwds9yIaxYyNO5vMi4lC/pKMkm1pehCrB0BGO1mpogQimYGvbA/xUnAXMGKXn/lD6Q==
X-Received: by 2002:ac8:7e89:0:b0:4a9:7029:ac46 with SMTP id d75a77b69052e-4ab90cb3599mr37973741cf.13.1752749748206;
        Thu, 17 Jul 2025 03:55:48 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9733935sm10034847a12.46.2025.07.17.03.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:55:47 -0700 (PDT)
Message-ID: <5502b2eb-f6d1-4ece-b918-1c8561a92607@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 12:55:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
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
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
 <20250716-ath-aspm-fix-v1-4-dd3e62c1b692@oss.qualcomm.com>
 <38ace6a3-d594-4438-a193-cf730a7b87d6@oss.qualcomm.com>
 <wyqtr3tz3k2zdf62kgtcepf3sedm7z7wacv27visl2xsrqspmq@wi4fgef2mn2m>
 <03806d02-1cfc-4db2-8b63-c1e51f5456e2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <03806d02-1cfc-4db2-8b63-c1e51f5456e2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5NiBTYWx0ZWRfX587c7IV993GA
 AibWdPosIW6ie3V4RjXlDY+pGdVJNkjZOYdIu8DCVgVGB9Nnf/p3u+q14HOgD/YWPZn2nNEalk7
 4/VoX+1rbOkrdGIQbXjuakia4W4XJh/RUY5eCuFyiECMRT5Bsnel968eY9UFDhM/1+RM3KfpBw0
 sPDoN8qxnFfnxhD/h52n0FvUnwdH/npXJdDUPXrW5jF0fGzHFVvYdoN47JxqVIe5pQY9pe4rRpt
 UuCTZvj7+h7dNq4b1tCYw4MljW6abS+Wl/ExTryhHOQK1a+4Z9miO45lY8py4LuxZCX4mDyvo3H
 S3w+0OVY8C64y0LNM9fe27AT4haVLvto4XfOf/BN9liG+TiO4bFUnQUUH/unjzS/qXTSr8OEcC5
 FpOQvj8gM4zRK2V9DuDJCIPscPjMIWgrLbaqOgZLwVaDgTpc9f+wS1VK4iMWVjYGFnjDn8vv
X-Proofpoint-GUID: O1GgH-jSk6IS-LWqAAb8DHCsQPzyfxPD
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6878d6b5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=a0K6PxZnllCBz7J7qkkA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: O1GgH-jSk6IS-LWqAAb8DHCsQPzyfxPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170096

On 7/17/25 12:46 PM, Baochen Qiang wrote:
> 
> 
> On 7/17/2025 6:31 PM, Manivannan Sadhasivam wrote:
>> On Thu, Jul 17, 2025 at 05:24:13PM GMT, Baochen Qiang wrote:
>>

[...]

>>> In addition, frequently I can see below AER warnings:
>>>
>>> [  280.383143] aer_ratelimit: 30 callbacks suppressed
>>> [  280.383151] pcieport 0000:00:1c.0: AER: Correctable error message received from
>>> 0000:00:1c.0
>>> [  280.383177] pcieport 0000:00:1c.0: PCIe Bus Error: severity=Correctable, type=Data Link
>>> Layer, (Transmitter ID)
>>> [  280.383184] pcieport 0000:00:1c.0:   device [8086:7ab8] error status/mask=00001000/00002000
>>> [  280.383193] pcieport 0000:00:1c.0:    [12] Timeout
>>>
>>
>> I don't see any AER errors either.
> 
> My WLAN chip is attached via a PCIe-to-M.2 adapter, maybe some hardware issue? However I
> never saw them until your changes applied.

It'd be useful to know whether that's a Qualcomm platform running
an upstream-ish kernel, or some other host - we've had platform-
specific issues in the past and the necessary margining/tuning presets
were only introduced recently

Konrad

