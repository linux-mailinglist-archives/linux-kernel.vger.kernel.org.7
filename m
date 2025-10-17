Return-Path: <linux-kernel+bounces-857547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B6BE7140
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161DE3ADB79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DC32741BC;
	Fri, 17 Oct 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mkvkb1I3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E8262FD2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688921; cv=none; b=F/04tx8p4FjgI9E8U4B/ZyN9QbpeXfajTTuFMYIya3kL5pW+v79kCAAfGyGRgKmjfOX5B+B6PaH4sKMZVWv+AHLRFJhUKn9OoFkrXINYUayMTUOClji8LO1o81mGsygiVmAXzFquMbn7d41i4Q1iQ3Qm5VhCB4tW3ITTPnxzIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688921; c=relaxed/simple;
	bh=355ZQYXr0SrpXqcff5ZGYy2ocVo3QN1cz60xyMzgrNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7s+OxKzHfvn2rrueTxbP9TezCLjtV/GeB5PlRtvSlpMZV6H9YB6R7UpPZP8qAHvs9KXPcsm8m5MmBlr5GQWn3KBlEBg1j3lOM95cVpVrQBQaqcmgxz2dDZSShp0bmeBtvXvXhMa0471OtjjQi3PxD3qXjvTyISLNinEQKDwCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mkvkb1I3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLqOA009923
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YH9LQ4opbrfuJGfdLV9HqMypIACkhbjKtURAqLKFt/4=; b=Mkvkb1I3MlwPJEBQ
	66u9AJqRdeR0TJJZTusSOV1YG0xjxHB4yJynHCeVrX13u5Jm+wc3jNUgPKHhNql0
	hEN5cci28Sm0oilDpagXP/GHWfFag4ocpucieEkYggw3KcLas7FovdyDy8GiQA3J
	rusFchAchzJPSt3qvBSvxpeAgwl+CuW2PMHhbkY6jW746quObgtTOpEJ3C036VzF
	ggIKD+zLw4kKsBW/xizl+XEjHd+5dOOqOOt/BIl1qYlI+sE0J62C1NoOtUtahxw2
	L9H7MHOilMzOsE97oKL5v0UlIhm0L1P1jVKl6YCag79XCXLc30EySXaAaP+NBdhE
	Lsj7jA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1aqn4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:15:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c262c72b5so985236d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688918; x=1761293718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YH9LQ4opbrfuJGfdLV9HqMypIACkhbjKtURAqLKFt/4=;
        b=NO2pyRll7vw+VWOj0sgfGfO1BWpGZm/dEP9XHm00xwuU6XmrKaGD2isQ+U2nEcT+2r
         AW4ROcJWK3Bw9RhiaxmQzu6rxoLX51jYHaqTyhrY6HexXg/INYj+TUFbsELysRBbJtpx
         Cr3BSOssi9xZd5VJ1RE6iUaqYvVGVqp+F2YC88HRjRO6nQ81dzx70cxINKO6dl3oq9Yr
         WQsUNKnfWRizBdXeER9jBqSuJgU1BLK6vF0za5k8UULpPZjHYRQ643kczi0iuaZwC6bh
         PHkf+AL7oJroed7uSRR77FfIpB1AkfbbXgdRD1sZ0YAX+sTSlb9vET/JFRMunuDxVfoT
         7yNw==
X-Forwarded-Encrypted: i=1; AJvYcCXqEjbNIdbQXiQmLlBhJVwdJyKEJsY6uDDsz2B/eoCjGU5wi7DRoE93M52UbRvr1PKcJtRB+c03Kyc3898=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFl4YNfD8WwlUH3yywEybKmgqIDsWrpyhRZKu+lhL+ADLAzXN
	jDjYH0o8Yd6hAtT8xcNsCApxxP3ff1IzGe5wu1cbotUTB4tgoh/VzpMIw/CiVYlxfiT4kmGXSxK
	TQNpU+xoqPfdUkFJH5/1eHXVWRxTxM4uC4dro6stxE/Tfp5tU7SBZvekPZZAra+NeL98=
X-Gm-Gg: ASbGncuTIcnpYPuQyFfYsgVre94gMi7zgBMvPxioqc9jCjfSAdPHSN10L391pVAM6C1
	lWOcIlT69UHz5eXsOH7bTExIeeWaFD2/Y7TZZaYjQGkFj9vfAbpEEzr6iSMF/wRSI5jlAlWsS5t
	HiyKft1efgZLJWUjKTZO7AAk49HdQXLFmzEYRBztjXeFB50+4sR0s1RE9rpIvf1sb8HHj1EdH+c
	ryAr7meZLu7uBHCicur/unCCwdzopounVBKcuDSeq/Rx6uF88WYZ4IrYR3//AxHFDBkfaZTzP67
	ql3+bwBtn+HlON5UZDnWWvqn0Rgfd1POo1ong5wojOHCcNgZqBm+J1rsA0N2H+k8+gLnLuFpmHE
	kkfIpmvt/VzO4DYI1jjMi21lp0y3PAA9+XY7vDlsIAvJUAZOpluwQwcab
X-Received: by 2002:ac8:5fc2:0:b0:4e8:a001:226d with SMTP id d75a77b69052e-4e8a0012877mr15379031cf.7.1760688917816;
        Fri, 17 Oct 2025 01:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW30Y4pQiOAyQMWLPe7O4NJYBXWqsckHtEv47TZ7+NBWOm/H3wXN4WXNlx4940VABaCGsNSg==
X-Received: by 2002:ac8:5fc2:0:b0:4e8:a001:226d with SMTP id d75a77b69052e-4e8a0012877mr15378691cf.7.1760688917157;
        Fri, 17 Oct 2025 01:15:17 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c2955aff9sm1041827a12.7.2025.10.17.01.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 01:15:16 -0700 (PDT)
Message-ID: <0a9874d4-29e4-477e-a675-c4534658f9d9@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 10:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_SM_TCSRCC_8750 from m to
 y
To: Krzysztof Kozlowski <krzk@kernel.org>, Taniya Das
 <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
References: <20251017-update_defconfig_tcsrcc_sm8750-v1-1-34b1b47a0bda@oss.qualcomm.com>
 <30390038-0f90-48a4-befe-475cf88ba1fb@kernel.org>
 <37f54b76-a274-4ce2-aaa9-88ba0eb84199@oss.qualcomm.com>
 <90c8dda3-f753-43dc-8bb9-d03a808c8704@kernel.org>
 <38b8468f-5006-46a3-a4ea-28e6692ef14a@quicinc.com>
 <03ac36fb-a227-438e-bdf6-f787e26008b3@kernel.org>
 <8580ae8e-50e9-481c-b9f3-125b6d1cb494@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8580ae8e-50e9-481c-b9f3-125b6d1cb494@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f1fb17 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cKZz56y0KD5bUEMw3qMA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: DyWwkXemocVfjklZaQMA5dG1iA8AN48R
X-Proofpoint-ORIG-GUID: DyWwkXemocVfjklZaQMA5dG1iA8AN48R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX+PvVm5Bj0TSG
 1JF9lz2t7gHyWRlsAUzPUvwXg5rtVN7htx7Fj5x7hz1I8PVEjPLFhbWasbkjhu/uIV/wNys5zIY
 1A/DmcYxwsFzCDMb06WqdOj99/9/9Wyaag7+OjiN8Ec0mNjraVegTKK1ZsxYev0CFqcqvlzWrUh
 j4SjujYCACrNZ6d3s4XX+SBa2iD4evGurw33MkpWWID0InX4zg+cFMwVA5IPl19ymQ9wF8CFgH6
 DunBYF6BokZ700qSEUn0CCoClYxjFobtb12jCPMzj9vP1VifycVm7gn7ehWI48vHch0iROVYvAO
 4SfUPrThkoQN1maf2NG9sr+QfmWmSIQZX2RMC8Bf/ncIIB9L1sqQ8G7UKTt4LHeezi/O5Db9C8p
 W4ALPw9Hbtq+jZzfnigrEdpxy8verg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On 10/17/25 8:54 AM, Krzysztof Kozlowski wrote:
> On 17/10/2025 07:56, Krzysztof Kozlowski wrote:
>> On 17/10/2025 07:49, Taniya Das wrote:
>>>
>>>
>>> On 10/17/2025 10:51 AM, Krzysztof Kozlowski wrote:
>>>> On 17/10/2025 07:16, Taniya Das wrote:

[...]

>>> We have tried booting up recently and and that is what we observed. The
>>> patch from 'm' to 'y' helps the UFS probe is successful and the rootfs
>>> is picked from ufs partitions. I will add these fail & success log
>>> snippets in the commit text.
>>
>> That's not enough. You need to explain why UFS fails. After explaining
>> this, I guess bug in UFS would be exposed thus that one should be fixed.
>> You just provided band-aid without fixing the real problem.
>>
>> NAK
> 
> 
> ... and to prove your analysis is wrong (because your setup is likely
> having issues) I even tested now linux next with defconfig. Works all
> fine on next-20251013. You did not share which kernel even has this
> issue, maybe some downstream tree?

Is there a chance you have the TCSR module packed in initramfs and
Taniya doesn't?

Konrad

