Return-Path: <linux-kernel+bounces-885699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24427C33B68
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EADA74E4D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470311D0DEE;
	Wed,  5 Nov 2025 01:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hUd3ZVyM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bvSFyLNL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679B42048
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307646; cv=none; b=IxU0BLMB9nRKAed2AXsJiQV7CVucnWLCFfgXxNia5zppnYZuPXNghb651cX1e6HI6gzK6lfDEqiY+Un7i4KjnEBaSFCyoCMMAtsby+AII5LsqtDdmRrPF7HuseO5r0nm5WUlEFie/NvlUJnpHLa3vYfRZ+L7YsL1mnFIAi2hKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307646; c=relaxed/simple;
	bh=Wq9L4LDD+TJ4+YXbM5Eoy/o/4C0nMjMp6YTsLSz1Rh0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qcOITJvXzSjJcyC7oRaOWJUThP2nj5tyjG5VsaKsmBS+rYIe0mwFSBIvD6oWRlBpWG38dK8tqhTkzCSDuWaJbBV+fAfAhQTR4kGVQXWtfnjOgR8fOK7X9aAj/7ztWmtdohp37bY5d2bscgLgdbwqvIvc8Cp/aFMYaNk21ONp5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hUd3ZVyM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bvSFyLNL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KfnVq2967309
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 01:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXmhNVJ3hoJG6pe/vOtNZg2Q+Bbm2uaXXHuBILr0mY0=; b=hUd3ZVyMwN1XBkDq
	RNjpZHU2/jYeih+0Vy5RMw+78f7w4UPnHluulORvPzCGYHCMEqbEhx742VW1vgil
	N5ZwEX6tQehuNbgMBrT0VYwkF5N91Ze1HQm0SEuQweZgwWNIzaUTrvTe183F0lZo
	gnOevR/n/jk1siJ9Rx8YlhnYGsdI38/1CqTi1HsM8+TQVR5sabkBdK8jKUTmAude
	pyM5QH51u7h0Wxngt4oAmwZwnYFa47X9ELJwr5H1Z+3LURHqwl9zbMF0ruy3R54N
	KnmrcWK+ZiqGAwgPHEltFE7Bd0BsClDzF47yJfMWL6XdicXfhKt+WRjxAluTbA2Z
	iG+g+A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7heaj7gn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:54:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so2383653a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762307642; x=1762912442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXmhNVJ3hoJG6pe/vOtNZg2Q+Bbm2uaXXHuBILr0mY0=;
        b=bvSFyLNLxO6z4xvzYKdu2XGejUWLIug8FCiM9C/3EyaYwKm1LNBtL09U/MWKlID8VK
         PHK1NfPraeM8VPoSYVoE7Dtn/Prm0hZKxYjww7FekcWyLZPvaMZGt/QNzBBosyfjVsY4
         vHPz5wYDfQZO2f5Kc6fHA20LrErPglk0AQzcdtmmQxkmay1pdIAd20tsJDuklJlj29iE
         NuKnd4sIuginq4MNi/DCBoWbED+6mGQR8i9633/7/FEbK1qjFxyNWTr4w9QQ/1MtFx17
         mYygKmhVUDCFLMTudKaUdDmHqXU67WaV023ZS3SCU9HZXK4U/l8I1kbFTz/nuGEVY0yo
         s7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307642; x=1762912442;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXmhNVJ3hoJG6pe/vOtNZg2Q+Bbm2uaXXHuBILr0mY0=;
        b=vW8cyh/o1PVE8nnX9y/TWJfnsUzPsKMogTV8DZFc1fLB7R3GGHToRn2vY/iaa5k48Q
         xHRzrc3uE1I4lUolY4ANXP58urC0lfjv30sDa6tvh+6zcutyC4vwsdnG/Qf4vfLvikbR
         2n9McCMGmDm+akJF0UIPNHqfaihx4sSU+nlA3tprUeSMg8/wRxvldCqdgEqBI4QKHw6k
         5nDArr6kb4eJcl7mSe2NpdRSu18RWtkXyaRRYf1CZUcvUlIOgYgB6t2X+y5PU6WWgV6N
         bYoCyBi5VrCf03qOcG2WWZDyFCMD2K+vMajF2s/dD/0+WDjB7BXf1jn0AcGU5BTZUZqJ
         THcg==
X-Gm-Message-State: AOJu0YwQPjDsev6aQD1GoXL/7EYpLLx56bmszfURrMDm9BAshV3agUWJ
	ZgrQA8ZRq7V6v15FBWiTPQycB+2H5r4HuhqJvglx7BHWiOHUmU2js74miuNs3Z7Eu9jV2uV9T/R
	X9jOjCvmm3Qy1aJn9N8eUF4sc5tRe4MHOvdpiCgQl4XB3KvEBYZtlwk7BrQePZugbVQQ=
X-Gm-Gg: ASbGncvVVMru/YAhLkGn54X/i3iALdwjqypcSUsmAOIbDs/DtTHsaKK0zcNOa3zP7Yw
	QbbSWIrk1ZXPuhaAJ43szPNLKUaNA3jS2A5l5qxDyqr4lTpQuRR2NBkdM55pJijAYrKdoqdJ6+d
	QIucSM7dMLPRsjtn3eYdNKroesJrcNgbULGtWZDHo2H31RVuMlRSARwlTj5dGIhM+WdPT7mUxMF
	cvf0+8yoEp1VaQ3qOjDhKQgHUMauwQ0URD+4hMtDLDFDW0dovXLedMHRbXXdJBzaj1B3ronzD3A
	jQh8wY5jWnd2prkQ2KxnhD0i8ZIxz64gzyUrfqj/Ei9ETY3oD+sHH9ZgX/9oBJ5pt8hoMI+OEbU
	9xkK5NKVgwDd92TYQv9YE4BDl8xQ0fkMPfD/8nbbLjTlIBticClBwlm7R+oZzcnUbCyrI3w==
X-Received: by 2002:a17:90b:4e83:b0:33d:ad49:16da with SMTP id 98e67ed59e1d1-341a6de76a3mr1454706a91.31.1762307641938;
        Tue, 04 Nov 2025 17:54:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA/bg0wXqruJ/4EMP1KV3HXVtGWNjBWM/YLfvsxYb2Nat5WHW/87S3quP7HRJbxdTtN2aw6A==
X-Received: by 2002:a17:90b:4e83:b0:33d:ad49:16da with SMTP id 98e67ed59e1d1-341a6de76a3mr1454689a91.31.1762307641362;
        Tue, 04 Nov 2025 17:54:01 -0800 (PST)
Received: from [10.133.33.81] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a699c98dsm948828a91.17.2025.11.04.17.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 17:54:00 -0800 (PST)
Message-ID: <88daba74-f005-4be7-be3b-627ccd424276@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 09:53:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts: coccicheck: filter *.cocci files by MODE
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: Nicolas Palix <nicolas.palix@imag.fr>,
        Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        jinlong.mao@oss.qualcomm.com
References: <20250606060936.2756980-1-quic_songchai@quicinc.com>
 <54b6e30f-a194-4f5f-9df4-5df0d3d4d738@imag.fr>
 <d2fd354a-e3a9-491f-b5cc-86040b037ebe@quicinc.com>
Content-Language: en-US
In-Reply-To: <d2fd354a-e3a9-491f-b5cc-86040b037ebe@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GekaXAXL c=1 sm=1 tr=0 ts=690aae3a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=rWyacSYSx-f4FmYYJUoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxMCBTYWx0ZWRfX2lRsPigILTDo
 B9+ROC+bK9HVMpjDomKBXWC0pQB7qglrIVwpbJRu+Q7hYMc8wAwrwRL34eErx4x54E0Gj37Z5yC
 g1IL5WZyHdwSs6FL1psV8TEFzlwf4JjtvFl4coJAHvcshgUyePvn0saeosTqJjDxYeKePZG8h48
 1QpxE9chg0iB7HK5yTJSjTsIE3O6ZZbmR3CxXbwdk0N2FR01wrqYkJxuEvfmpYEMw7hzDJT3ZV7
 BNB1f6GnQESeFK6br2Z/wYGJAJQnZq6Gvts0txbgEyAhKK+JkmcGTE1G7kBpoF4gxwly1Q9RzQv
 2VV9/ubd6oPsLleybM3PSWpwy5JcOAk8Md6OELQ50Ey2A8F8eBB99uetWYBBcMISejvXVHqKTQO
 yTbSh6oY1cLXyAPfSTGTt2daVlxQBw==
X-Proofpoint-GUID: _8YDCN3xMFFScpp6yFZb5pKDwRgIEGZp
X-Proofpoint-ORIG-GUID: _8YDCN3xMFFScpp6yFZb5pKDwRgIEGZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050010

Gentle Reminder.

On 10/27/2025 10:39 AM, Songwei Chai wrote:
> Hi Nicolas/Julia,
>
> Noticed this patch has stalled after being ACKed.
>
> Could you please help review it and assist in pushing it forward for 
> merging?
>
> Thanks.
>
> On 6/6/2025 3:26 PM, Nicolas Palix wrote:
>> Le 06/06/2025 à 08:09, Songwei Chai a écrit :
>>> Enhance the coccicheck script to filter *.cocci files based on the
>>> specified MODE (e.g., report, patch). This ensures that only compatible
>>> semantic patch files are executed, preventing errors such as:
>>>
>>>      "virtual rule report not supported"
>>>
>>> This error occurs when a .cocci file does not define a 'virtual <MODE>'
>>> rule, yet is executed in that mode.
>>>
>>> For example:
>>>
>>>      make coccicheck M=drivers/hwtracing/coresight/ MODE=report
>>>
>>> In this case, running "secs_to_jiffies.cocci" would trigger the error
>>> because it lacks support for 'report' mode. With this change, such 
>>> files
>>> are skipped automatically, improving robustness and developer
>>> experience.
>>>
>>> Signed-off-by: Songwei Chai <quic_songchai@quicinc.com>
>> Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
>>> ---
>>>   scripts/coccicheck | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>>> index 0e6bc5a10320..89d591af5f3e 100755
>>> --- a/scripts/coccicheck
>>> +++ b/scripts/coccicheck
>>> @@ -270,7 +270,11 @@ fi
>>>     if [ "$COCCI" = "" ] ; then
>>>       for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' 
>>> -type f | sort`; do
>>> -    coccinelle $f
>>> +        if grep -q "virtual[[:space:]]\+$MODE" "$f"; then
>>> +                coccinelle $f
>>> +        else
>>> +                echo "warning: Skipping $f as it does not match 
>>> mode '$MODE'"
>>> +        fi
>>>       done
>>>   else
>>>       coccinelle $COCCI
>>>
>>

