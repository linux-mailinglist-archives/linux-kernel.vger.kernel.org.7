Return-Path: <linux-kernel+bounces-726227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4EB009C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC634A31F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D82EFD81;
	Thu, 10 Jul 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kftSpZ9Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759B022FDF2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167889; cv=none; b=g54SnRvUmDLNbveGOcCMwwWC93GSaP/tAOXgpVHJ1JnTkQqEJIE5KcHxtSCx/CJfODDuvv2R4QqbwQ3vXIIl2ISHq4drL2dJXIkt1zJPoHMYwvWXmn6rZicf2UywlMDwWgWUvy/aLiZWD5VK7LmlL1548ro0xgkkBmSwYy+AZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167889; c=relaxed/simple;
	bh=AMvH8CbgflCSwtZv4m6a1RA/Wg9jDTGoMyT6/VZgH/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eG8CjAKPS/lUAxtHGzfMGS2ArNt0xLHIyRwHva1uCG7OQvqFFZdbVTfXQmUnEAza+n5pjKaQqGbbLqpUFfCDuW60F6YbBbtWZsi/rhLUeSL6o5g3Ef/6wdhw0dIkugwLdbnakVKjkV/ADd8VRhVWOADxLb+m/GrrQTr9nWwIOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kftSpZ9Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9FxIs009948
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ar7cVymq/jtUHBmvH1VZaUyciNOHi8uWBeFm9Lj+JaM=; b=kftSpZ9YXjb9tP8z
	JAa7GP/C5N1nGxlH9A8arpDhrAqIcgd0Ga9o0P84DK05+Q7dKtyGNZt6b8HMn2tw
	2ORX65/2UdoBSPG0ncP6NiYWtDVilajBiYoZ6j+5CahLCPbwt4t8lyz9oZ8rUkB5
	tmZWZN+HNChoCB6+SRBUW4I1tS2X3FifvuGUeLC2qUMcNERFtPWQ27xtQePftVGY
	H5SdSLyPMSLonbwuZYQFzVQHI43CrnNINhkcycur23ivtvSTguMNk/IHaQh8e8c+
	x1KfD1I4AVZIIxD8PhiiccHeNDKBbgGNNU51RDnTtnRF11rxnwvnNfHsIZ5/Uw/3
	o+Vzeg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9dwshe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:18:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748e6457567so1829984b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752167885; x=1752772685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar7cVymq/jtUHBmvH1VZaUyciNOHi8uWBeFm9Lj+JaM=;
        b=fIz5gjvPu2nSbgGnsyPVQoDWlaD/3yrpHAySOjvi/98Gf4HhhXN8DNb2b8SrJYZkso
         f64pvSXwOd1xXgQIiAlFUX/YVyPU2XCzmclTAb4KF0OPxbZk3Jy1/EAIb3qh41AH1Xd2
         Lel2AlEzwTj+e8vVuhpyixC1aCqE5C6kTuUchbDj6KPqI+MQrM/vGeS6VMCmLCZELc9v
         E8f+dRsu+FbnETu6rqkTY42KVN+pavWd86nGOjPryBQO++oGBMVxGwFNQKcbKge0wwN+
         eVCDsayfJmd1ETJDhumukSgoKcXknAIpd6ffTfj52wxecK5j4uKAlKCOez/kwI1BF4s3
         OL8w==
X-Forwarded-Encrypted: i=1; AJvYcCWar+U3e0zRWvZE8CzQAnjo5GfZM/xFVe89ZxT0kY21owhRgKsMi8aJ35WsKC3QR+O7paxrZ/3Xrosjz+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHqzMtkd4SvZ2+tUG7ossGXvCJmSM8n2RzbIlYrONqf0+JbfP
	Hwa6knW019tv5szACel1f2W72LsZJjJeyjJOj5y650kPa/o+2LAfopfQku6RrbLkG44Msukk93K
	Wjivjg3bAAv4hL9Q8TkktOeHfJmlFtghQBAE72oWCRlrFVkS7gWqpmczal8vXmN5SzlQ=
X-Gm-Gg: ASbGncvQ86upMJ/P/AY6U1tqsFRdmNTuSbY7hVYEIHiNpb4GVAFVIqtRBEoS1LYllk9
	yRrx0LF/3WhN4noR/vZJD9nU4tRE9ip1qJahszTV0hgN+Rn53rAPwbKID1844N7IoqxCVNMKtON
	BUokyfPMPVl9xT1gTHO8EBmnPsc6EAyR0kQDgdXtB1Hn/I1oQGtDQbTiiAsrNYubMieohBG74Ek
	mEmZ3QA0OjPwGsGJVz0for0BETSgt4txssUnBimyNnsNPgn+KKAdn5e6DxIigpRBDuW5GqcbsRI
	bsdvAs9891JT5UclMuwBtcMBz3rltD3FZfmzBQ7yWuera7J3XAU=
X-Received: by 2002:a05:6a20:729e:b0:21f:9b24:321b with SMTP id adf61e73a8af0-22fc57e7824mr8500611637.20.1752167884941;
        Thu, 10 Jul 2025 10:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHffsp+s2THEsKwd99/2YsGeT6E/wKdQJkZlm+vr/bjKBhhIbOq/IXrxnXy0oU1VYAbUwh2SA==
X-Received: by 2002:a05:6a20:729e:b0:21f:9b24:321b with SMTP id adf61e73a8af0-22fc57e7824mr8500573637.20.1752167884443;
        Thu, 10 Jul 2025 10:18:04 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.227.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe72ea8bsm2779997a12.76.2025.07.10.10.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 10:18:04 -0700 (PDT)
Message-ID: <304d71ca-5773-4fa6-aece-50f92b70c77f@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 22:47:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] bus: mhi: keep device context through suspend cycles
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>, John Crispin <john@phrozen.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-4-usama.anjum@collabora.com>
 <b72b3635-1c09-444f-98f5-30fcc219b297@oss.qualcomm.com>
 <c40f13e8-7420-4046-880d-7c72620fc021@collabora.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <c40f13e8-7420-4046-880d-7c72620fc021@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QNTylPatn27AnxSrTKfXbr1whHI3Z9_T
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=686ff5ce cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=4nqOr+EkFiuPl9GB/B4vcQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QX4gbG5DAAAA:8 a=zOkQIraDPy1jB-BB_0EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: QNTylPatn27AnxSrTKfXbr1whHI3Z9_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0NyBTYWx0ZWRfX/UyKh3MogcaW
 hvi4ap5jfp9+c0gk4FfD2KL38B07qpGTB2Gk4eh7Cm43jjBXHn5QYm7kCVEs2Vb3ONIbbAxD1ct
 0yrw4DbwAFuDVEDAvUt2R2iYaQDgcluI6HAdgZfd6CJ5QJ7LJsJMRjncBw2/bgv/uQS6WPIhr5u
 wBeMSkVqh7786ftkLQEsGo/tNtpP4WDLb2E0Lfh/b5wrp2ZZhe4VAftFmZpIccJPlc/AE9ETfaA
 nJqWOwJonxbq1Zh8orasTtZVvphBu0/+ySzM/HDifth5/F0YxT7t63Hy5pJOJ7PQExv8pUo3MW7
 GjeYrudaLYUn3zP5Wdii9u6PP8kz/9/856DfFrywQ9f2jXUVNSkyi6mheDPhVLL3kmtUMpXl5/+
 BL5eYzK9HJ0RvUw9i6vLQ43Am6m6+c8ImumoE6gns15asa56AzuVLccE9DLHaGVKeRSGFlBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100147



On 7/10/2025 8:37 PM, Muhammad Usama Anjum wrote:
> On 7/8/25 3:15 PM, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 6/30/2025 1:13 PM, Muhammad Usama Anjum wrote:
>>> Don't deinitialize the device context while going into suspend or
>>> hibernation cycles. Otherwise the resume may fail if at resume time, the
>>> memory pressure is high and no dma memory is available.
>>>
>>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>>
>>> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>    drivers/bus/mhi/host/init.c | 11 ++++++-----
>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>> index 2e0f18c939e68..8f56e73fdc42e 100644
>>> --- a/drivers/bus/mhi/host/init.c
>>> +++ b/drivers/bus/mhi/host/init.c
>>> @@ -1133,9 +1133,11 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>>>          mutex_lock(&mhi_cntrl->pm_mutex);
>>>    -    ret = mhi_init_dev_ctxt(mhi_cntrl);
>> mhi init dev ctxt also initializes the ring pointers to base value,
>> I think we should take care of them also ?
> Are you referring to mhi_rings? They are getting initialized inside
> mhi_init_dev_ctxt() and de-initialized in __mhi_deinit_dev_ctxt(). That's
> why I've not handled them separately.
> 
Maybe I was not clear in my previous comment/not a correct place to do
the comment.

My point you are not freeing __mhi_deinit_dev_ctxt as part of suspend,
that means we are expecting device will continue to use the rp and wr 
pointers of ring as the previous i.e before suspend pointers.

What if PCIe keeps link in D3cold as part of system suspend, will the
device able to handle the previous rp & wp of ring. I don't think
device can handle this.

- Krishna Chaitanya.
>>
>> - Krishna Chaitanya.
>>> -    if (ret)
>>> -        goto error_dev_ctxt;
>>> +    if (!mhi_cntrl->mhi_ctxt) {
>>> +        ret = mhi_init_dev_ctxt(mhi_cntrl);
>>> +        if (ret)
>>> +            goto error_dev_ctxt;
>>> +    }
>>>          ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_off);
>>>        if (ret) {
>>> @@ -1212,8 +1214,6 @@ void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
>>>    {
>>>        mhi_cntrl->bhi = NULL;
>>>        mhi_cntrl->bhie = NULL;
>>> -
>>> -    __mhi_deinit_dev_ctxt(mhi_cntrl);
>>>    }
>>>      void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>>> @@ -1234,6 +1234,7 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>>>        }
>>>          mhi_deinit_dev_ctxt(mhi_cntrl);
>>> +    __mhi_deinit_dev_ctxt(mhi_cntrl);
>>>    }
>>>    EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>>>    
> 

