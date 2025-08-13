Return-Path: <linux-kernel+bounces-767664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200AB25765
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C061D7255F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9932FC87F;
	Wed, 13 Aug 2025 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZUr3CSHf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2D2FB98A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127236; cv=none; b=RX4JnoL3MfLJvVVmCDUr/pYBny+5IXmyN1cQ+El5mgMjsOoDu+3PJeTcfM2XciFrpAcvyb8Bl/H3gd/T+Qs/0UQa+KWs9WRLdr8VEcYO5rsqB7gMGgyxHKo7ZBUMuuIi5NYj7KeEZvsH+c5qq9AfIs4tLpZiZH7TV09eZ5ahZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127236; c=relaxed/simple;
	bh=K41reef5ANbMRiF4uxfGDDzVnXCjuA+uPaSg4T4I0S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHvoX7jdDcpyghbDik8oM8yTIQG/75PW0wtNsZCnXN4YheT7Tn8fOdMTrV9syhf5Iv9ALwUG1wm4LmYhxakf7DgBfVM9EkRVFgP8bwXVVvPX/08D3C5tFOqoDXz0VVBFFnA+92zwEmnl7jb4bvV4DrPu1vxZfOvi4au4/bZUh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZUr3CSHf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNCNCx024004
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MqQ5LAlEsNqEJ+2SlpIbhfIckQ4duQR//L6MMCTIFNU=; b=ZUr3CSHfaxYU7N0J
	LwQg1xZ/rtIGFfgOgxl//7sS/0lm4Aj5yk7ZCp2DrOeQnltcqlalw/MjKgKXJmB+
	oR6whs/bwSNoSSjCUsRBmrqLCuyYyseg7WuKg2byxi3NUBFU4hAcB1Sdee3KVWPP
	crdL2t/xZelR9gxtErvlVatGaPVfFcMk+mzQujkhNYImlwRCBKmehZkMqLAxIAXM
	ApjsmvSP8+P/Lhv6k2mBaW7cR7600sun5hZnVYHOR82/Gm4jqyUqYAyyrV1fU002
	d28pwp6qqgU8yccOV33hbPzippgHDkbiotXdJ726hvXMeBz1QTAZ/E0N0QmBMdb2
	A5tNZw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rt79h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:20:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109be4724so1147071cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127233; x=1755732033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqQ5LAlEsNqEJ+2SlpIbhfIckQ4duQR//L6MMCTIFNU=;
        b=cYcyrQmooBSZP04mnr9hPv1yNrD+oahDmdiHjCBvN3MwkuH6vlMIqIwiw+SDccoiY6
         C3hZqI0MM3rFJcKcnWLifqvf+Vy30NmX/wzQHGjRrTqT81BozMVMb0RJdHRPlTS3egG7
         6BJuNvhiEtWcFeZjc79yV5Yi0DnUD9b4HO++OVNqYx6wt9um92nFTlhwXHg1e/8ahxJD
         MPRVCmhLCpONjjEPr8jZrpPPGwsDfC3qLMAGB2KVomqvJUAGPZhqzCSsVWMAQpVfrk4/
         Ta4jhi2+KPrG3tBX9SOVhftwvBTSNzmcBL5f+9nfbPgWefS6zNLzR0C/D3QYEaHvb5jV
         rVLA==
X-Forwarded-Encrypted: i=1; AJvYcCWH5CuUFKPa6J8IHF9BmGeKUBXFi05CLnik4RXvDUxk5nFB+0JQaSADUFFdsTfM7sboRQ1/KWud8jH7Zbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiucELnfOZlL3/TYfmv6XCawWfgu8N9XOye5NpOySl8lA9T39/
	D/E8kdbaI/sZo1w1KD1hIG86WMgwNQiCuhfM9YzOa9TQdA9fzF/4hE0omMLLPZ93wEXiOF+8K2X
	DPD2r7ZE3uCciQtrp8lYxegxqZUb1+2fUytfQIZ1WTHscvhFu/fjtzP77Yl3UKr26SbI=
X-Gm-Gg: ASbGncs/WHZ+iMSLhXzgv1eMkErvGr3rwJ8WkXv2sSVmH+86Oki0aMpM7uIwqQVvG/p
	P4Ka9vMwPL8+rfMk48D2fffWw8urQHjgmDvKotwaTNOiH1Trdz9rbOLjAph0aKYM1gQpz0m/dhe
	JkYlvoUP5wgw/9/cdIMuZAJez0Aqo94OT0PlpEofeEa9XaD9F1nPa8s9YaTt4ooi5DJvUVeWyex
	hh62YBZlKUYy0e9o62tbWVHmFy8uTu4A/VEvxlIg94Rqlph9hyQGQXJYDwWr1NLOT9vJkfqRXlV
	FkLIB0z8UdSaLb/wqx5YzwnvzWsLyfAZGXSKxrOJPx4oly68bYqwqHW6oTvV+OAgivavwfJMRur
	7poBWFqOvKvqft+06sg==
X-Received: by 2002:a05:622a:11c9:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4b0fc7bd280mr35471991cf.10.1755127232824;
        Wed, 13 Aug 2025 16:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEerwHUOumqAcf494bszPPlRc+za1y06J1v7a2/RnRceuUSxkyYhtRk1xeTG5320KKmAVxs7g==
X-Received: by 2002:a05:622a:11c9:b0:4a5:aaeb:dce2 with SMTP id d75a77b69052e-4b0fc7bd280mr35471561cf.10.1755127232170;
        Wed, 13 Aug 2025 16:20:32 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm22753076a12.57.2025.08.13.16.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:20:30 -0700 (PDT)
Message-ID: <8bcb37ed-2885-4f4d-abed-5dd5ec6a254c@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 01:20:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
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
 <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <87c884ed-0975-4ac2-a0fa-16e830a57c72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfX27xLdw7uBgQr
 kMij9B2MqB/jNBUqIyg9d0+xW0Lad+8zmtc0HGJzxqJ6wf0LvoaxVMUvgdvez+oSpGfq7ahs/EF
 7PwRuQzdLeN3wwQaBPmfoyWlmOE81s8hdxrUsc6yZgQDYOdgvf57MT8358KatWZNuEgvQPbBg/w
 BVcMCaL0XZJBiKurq8HTPsb0zMjSNtu3YwzdzRR/c6MYn+tHZeT8ijEGl1zm+v56Ci8QdfUfM6U
 4TsZTkCwNDrQ9j0c2fHyN63Ylw7UuyMp/IE3+0doUdQzQPo2qeyEgMn07/r8i3u8z6pV24NPFQU
 6lo8+d5P6dMnXm86TXAdNsWzosmkZsjqP4i5kXhVMeyDuw5TcrjlqMDrg7xEtTH6kZd6w3SM9tE
 GdzqEQl1
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689d1dc2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=frUY0QHmMtcHLPOZDgsA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: E2L6_LdtPlt_6eDJ0Nf4YFhr5-PoLGT5
X-Proofpoint-GUID: E2L6_LdtPlt_6eDJ0Nf4YFhr5-PoLGT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On 8/14/25 1:19 AM, Amirreza Zarrabi wrote:
> 
> 
> On 8/14/2025 8:49 AM, Konrad Dybcio wrote:
>> On 8/14/25 12:24 AM, Amirreza Zarrabi wrote:
>>>
>>>
>>> On 8/13/2025 8:00 PM, Konrad Dybcio wrote:
>>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>>> Enable userspace to allocate shared memory with QTEE. Since
>>>>> QTEE handles shared memory as object, a wrapper is implemented
>>>>> to represent tee_shm as an object. The shared memory identifier,
>>>>> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
>>>>> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
>>>>>
>>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> +/* Mapping information format as expected by QTEE. */
>>>>> +struct qcomtee_mapping_info {
>>>>> +	u64 paddr;
>>>>> +	u64 len;
>>>>> +	u32 perms;
>>>>> +} __packed;
>>>>
>>>> Please use types with explicit endianness, e.g. __le32. I'm assuming
>>>> TZ will always be little-endian, regardless of the host OS
>>>>
>>>
>>> I'm not entirely sure how this point is relevant. As I understand it,
>>> the core that populates this struct is the same one that accesses it in TZ.
>>> Your argument would absolutely make sense if the host and TZ were operating
>>> on different cores with distinct architectures -- such as one being
>>> little-endian and the other big-endian, which is not the case.
>>
>> CONFIG_CPU_BIG_ENDIAN=y exists on arm64
>>
> 
> Or, you are saying we may have a configuration where host is big-endian
> but TZ is little-endian?

I was indeed about to say that.. I believe our tz is always little-endian
but you can run the HLOS of either endianness

Konrad

