Return-Path: <linux-kernel+bounces-767663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F1B25762
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2F2728073
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073662FC87A;
	Wed, 13 Aug 2025 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvgKzPIT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF02F290A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127155; cv=none; b=sOvuBw3f0X8fou2FXcGkw32JOezpB7as5TsX3ZIK+CSJv3iFIgwWmkg11LwyGgHlJp209mdGXN3g4UwW/se2b26n+6jGc/gl4qz3F4+OADI288jlM2SxJ7pQW+Y3WnME0nBFlPqNe+/4ZSxHQDn7zJTZvwZ4j8MISbzwNyXvZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127155; c=relaxed/simple;
	bh=J7HPyC/viLo3ASlp4BEj2IzMnozhzIy4ActEhtCF/UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED93cgLXoalXfzWRZG3TlxD5315Ha/ygR9swBTXI0gyRRzKECAROC0P1yxV1MMGRADdmD+ADEMzN/vjWojl2yKDhGCt6/K+DoTe9s8b2mf+yiqmpKhGenFrNLe+3gpX2LTpKO96U5dFRRolYOx5MVQxLKfRpxI7ZINxEDZZ5GJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PvgKzPIT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMjkjE012182
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2TfSABE608VzR8Ccb4ovCS90iSRhqxTosRl77AzoBvk=; b=PvgKzPITzN7s/w4F
	CWmDq3EBjBDvcHPTnE5J9fzFRBm5JuwXqpHyOD3UDwfrQm+CPO4qalH5ZusRrI5d
	syOJg9wfB711Q9ABtxbUE1ao4ffUbyTmicIEr2Q0OnL/Ukxm2p7Aat52rlpGqE9O
	OH7sCI1/xbp2CKdOGEQ0zs/t93Ayal4dCj8gPkwnxx62cdwGSwkKVxzcAjonFefc
	3eKld5Q5oOSdp/F74YRx0iyKCZyF4P3gZU+dxXES4M5zgTqoBQO7jMcD1HDhuRdH
	WAowXtuau2w5bYpTZ2zUbyq8qhOpQZUqju2QX72n3dcxOiReCJYZC89+HLB4aWwC
	jpjC/g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxbpgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:19:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eb9bb19so595431b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127151; x=1755731951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TfSABE608VzR8Ccb4ovCS90iSRhqxTosRl77AzoBvk=;
        b=cMMlI0AixBCIfoHBFtqTEI7cCDF4+1WyR8IOnbmzTAjN8dkSfWNHyETZ8MPJ5xFyoF
         5fHqrTAaaBZMZ8cZPn+1iULIOmKsBVASmc+zcNmVrnviFh0l3wiF4KhSXrwoYCamMVhN
         KNAuH3bU65KaF4YeyGh2wfG3u5Ay84ZNh0dzGyBjg83c9okIcxdAi95Q+iIyjrQGE/WO
         ImKpWTlL/KvRfiKNDmEvmhcdnk+zebZykBOAHYrqBYiLOXdnRF3NLlw5lCEh4OiUzJpT
         G8A8iuD7lJGf15ejEPjPBKZqHYWL8zX+9fc872U7ZgdBV0NZ8kYTDBPm86Lys5HdpD0H
         Lt6w==
X-Forwarded-Encrypted: i=1; AJvYcCVyj62SuJV7WuJqJlTf6xlJPLt3JQrY2DacSftmflGBKHp534+x4tCLPgZjzpZ7X6WEVOYhPq/M6GzQYUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayW+HNwaMRvYLzADaqtaqz7Uu1fbd7aBQ7IdfnV8yblMiIH/p
	+HVKYQ4TObgrUmiNIWyWY3ptaZkfkSCh7SnEfKIRarBgczom8sgMB+S+YGON3u2vCaKqqJXteN/
	wWkFiUA60X4oY7eWnjiUsifC/J3PtvYczPtoLAq3A4Ss0yXRY8hstQzN1oPc0mPUmPg==
X-Gm-Gg: ASbGncurbjqGCvYlEwLYc16Bt0rQa7ih6JYLWHWAq9/5KDzbAD6S/IgLwHb6s6y864W
	N9XcnipUuekap+F/CEbT5PwsuVLihrRPGkhsGGLSyMmKtTLeiXizVmcLmNlhDJgNXsa9k7ClyMF
	b0kx9hGcukuCcpVEt+uzBV9NrAMJyccWSb7DcU1Jc2uQyswdGKAVYjwgOcrF87Qj5cBXIi+TWCg
	+yJKcUoeSkn3dJMNNENqpUPMQSIXAvOZ06Scss+WRyslbLnbpdf8pI1KyVN6YMfIsRnVKbahSBs
	q6NlreDH6QNfSq7B0NafGicE4rgBEkw1t2+K8wHN3qm7lmbZ7Oq0xXULEeepAZhuCKFMYyXx1wq
	aNGw5CeUe2KS8Z+X7x1dvZMSseMzimyBCCbV44g==
X-Received: by 2002:a05:6a00:1489:b0:76b:f13e:f598 with SMTP id d2e1a72fcca58-76e2fa5dd6amr1713026b3a.8.1755127150801;
        Wed, 13 Aug 2025 16:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMWMipas6iUqagDKstR+TGWXPaYzE7u4u1viMcqd2w5yiGt/rETTcoLJmFUWDnm+dT5E5L7Q==
X-Received: by 2002:a05:6a00:1489:b0:76b:f13e:f598 with SMTP id d2e1a72fcca58-76e2fa5dd6amr1712998b3a.8.1755127150336;
        Wed, 13 Aug 2025 16:19:10 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf067e310sm28124852b3a.25.2025.08.13.16.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:19:09 -0700 (PDT)
Message-ID: <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 09:19:01 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
 <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
 <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
 <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXz+b1SJa//hln
 wCA/iwIqHgP67CHasUsc1dFe4Og2WSKJewfV+nYgia6+pRTwBzFGpIqqCxbqwSunZ3X0Ye54iMB
 JktzbWqZihKR4KzFTrtGbWFsKS09vX6t77L9Bt5Fim0HQ/t1ixC1M9TKirTj5Tgi7gx6Yr6ElH3
 robHuVfsC/0P63uPybbuXQ06AnmSgH56yfbmP+6x3jco2xqLgWU9/QHbC8bPYbML1aqK0Ht9JK+
 JgxX6q8t5fHIH5Ok57H7+BhvO21p0ryB8r9ZSzCV4bqRYwT+r/owQbXgaEzO9DdK8VnoKP+99Qy
 ui1awmjEzWys30VfBsaoeZ/L0CSCfoRMh5N1JtXjglHChGCHIevKLzcOmXR8imUDd8hT/tNYwbE
 EAYGKpV9
X-Proofpoint-GUID: yR19ssVMDsMgV5B28zDpdedeh-0CLiGX
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689d1d70 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=AwBIn8DhAZiLWRgty54A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: yR19ssVMDsMgV5B28zDpdedeh-0CLiGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057



On 8/14/2025 8:49 AM, Konrad Dybcio wrote:
> On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
>>
>>
>> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>> Enable userspace to allocate shared memory with QTEE. Since
>>>> QTEE handles shared memory as object, a wrapper is implemented
>>>> to represent tee_shm as an object. The shared memory identifier,
>>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>>
>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +/* Mapping information format as expected by QTEE. */
>>>> +struct qcomtee_mapping_info {
>>>> +	u64 paddr;
>>>> +	u64 len;
>>>> +	u32 perms;
>>>> +} __packed;
>>>
>>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>>> TZ will always be little-endian, regardless of the host OS
>>>
>>
>> I'm not entirely sure how this point is relevant. As I understand it,
>> the core that populates this struct is the same one that accesses it in TZ.
>> Your argument would absolutely make sense if the host and TZ were operating
>> on different cores with distinct architectures -- such as one being
>> little-endian and the other big-endian, which is not the case.
> 
> CONFIG_CPU_BIG_ENDIAN=y exists on arm64
> 

Or, you are saying we may have a configuration where host is big-endian
but TZ is little-endian?

Amir

> Konrad


