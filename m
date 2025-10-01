Return-Path: <linux-kernel+bounces-838677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D24BAFE75
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DB519416D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3E2DAFBF;
	Wed,  1 Oct 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+n5OKMU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AC23C8C7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311773; cv=none; b=k3HQ9/ZLIeVMEivYsU5mvi9jC4ox0XcKJfuJQh0UcaRf/Hc1R/8L6uHk73kALj55DL0El10rUfRq/oYv6dtZKvYJiujOMtSbJh6aS7g/g5cibvXH1asskP94gYLm/+6De3liYLDZWZcXwk6wXV45B9LX3XjxpIrL2LwAP3/UrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311773; c=relaxed/simple;
	bh=VsR2+PVDtYE3652lA3AwZ1sGcmyKJ3prqssc5PDRjC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhfrAkUF8ccG4H87Wih009qQCNsRmzYQ0Hv5X8U1YAu8uFs1WO7Cw89JWScEuo6ErfkJGujwewbprCEMBNA51qUhc8b61NCA1yOWXNLevg6f8AQTDOHhNpcQcAiCxWwwhtItlsb5bBPaO+pr+nWw7gyT4o+ZY+lejXlF3l6LJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I+n5OKMU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59199ZRF030612
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DrFdWv2iBXIeKGrs8bhA1iCXbL7rFu1+yvVc7NJeApA=; b=I+n5OKMUkidLe5KE
	FKY41O6FT+NOSTD3fVg7zfK9P0z/Oy7XDmVMCH/z8HlggB3VRH/pX14CgqI2C/Au
	eKCk9BSIimln+2Ru6iyNhiF/LuwE5369SbbAYW5GOZkZ8yJi8/z/ui6vn+xCxAu4
	+j1UNEo0kGlz6mn6VfNAYxTfGZ8tSZ5dltVVXOP1crz8uxQsrCwMgBW8nJ4gZveD
	JPZG+as3j++DJYL7FumuTOc3DA+Z3AA+319vfnwwA++FUwLItE4dsvYUGd3H++vA
	+gXtTwbzxMDAPw03FVhGVWuNWHDXuZjlORgH53XetkQ7oqNDeSKiLlpMUfJTvyk/
	hV1/Lw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdksun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:42:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8649a8dbff8so114182185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311769; x=1759916569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrFdWv2iBXIeKGrs8bhA1iCXbL7rFu1+yvVc7NJeApA=;
        b=Bi+6nFhPB60VyppZurl8RGSjqcyfw1e81MJtHtNVsvrP4wm+QFNWX3ThxI1g61NujE
         tXffcrTzf/43jj8PJuWCWABr3krhB77QgbBCl5ixnPSAjqba1EjLk9r/KI4+bUzPyttj
         7L+JMAGlLxwru/mrQ8YfrIEvatT8En3lKpqK2Ve8LZnQjXmMTjg8dxiVR3qhfo+jDE3C
         lCiIs1Se+1Ex1/kFJjL8DPR9wbReGIl1nOzBtzZxkAP4TvAEVeoFs4hYNroeVHyqdl3o
         qe6IyhHEHqrV0+5kyu1J7bw62+NAM7/bVoPZXbYmqCkEQ7eqogid5C9P8DWuwuDHih5E
         iXPg==
X-Forwarded-Encrypted: i=1; AJvYcCUnmvPoAguGhTMRPTRlKhC6FffM4Lvr5tXOxKG+zeSBBQ/BhR6fsY7bud/7jUz9T3oORG9Y6J7+VFWQ4HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkIQSSyR0+ih9rNm8qw8AqdC2GMVmJhZGKcpk5i/66ME+vEvJ1
	dz5IyHtpsIonnaXLBHnir+9wEoqoIpx4cb+A1XD4b0QGcUkCehJjxm5CEb4iw/wZKmddX8B9qXW
	1/SXATZk9LLsuLn7ZjKxNSXXrqX95u3IwKWvBgZ4prSiXUbu6j1QV8CDpheyVRHU2Nqo=
X-Gm-Gg: ASbGnctdD5pQGP8FaANDvEXdkS6foqQXA9n+8zeDtPIO9mUjqs2wS6VQG4bPK4OH+Oz
	iYXAzTrTeBq34XA7S+WEpBykgneWn15EmvugtPszgIZlbbLW9GvfJN7lvFrZW/WPJ6f2WpCVV+K
	9J4DG1KQ6YB5aMIWrhjc72YDGXM/TC6lMuQ2CsMnCHJZXe2pHMUVwnnq3Pk1wVkQ8CveKYN7/qq
	WpbcJb6QTit8C1ZIMiPyPTYV6+mRFu8kle9l9wjRYrvoYrpMaLCXeOzyRe8baOA/0r4DASY6udF
	SX22dwMiOnnw7TLut+xteNtMQJ5qmRoSQcVSTXdyM8srVSJuH57Bk+U6tlLod6wnMZllO50qCRp
	6N6XtpsH3uls9TRjIX4c5PbWxh7k=
X-Received: by 2002:a05:620a:d8e:b0:829:9017:82b6 with SMTP id af79cd13be357-87375760480mr275829885a.8.1759311769134;
        Wed, 01 Oct 2025 02:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSVWdZDNLhL7AkKEv+Ngs2uzjXJ5e/rNt3228AfvQUdNC5wR/kdISKu4lF1ZjtYbb//8x8wQ==
X-Received: by 2002:a05:620a:d8e:b0:829:9017:82b6 with SMTP id af79cd13be357-87375760480mr275829085a.8.1759311768591;
        Wed, 01 Oct 2025 02:42:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm628793366b.77.2025.10.01.02.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:42:48 -0700 (PDT)
Message-ID: <a31ac6fd-929f-4001-8199-1b8730ccbadd@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:42:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] usb: typec: ucsi_glink: Increase buffer size to
 support UCSI v2
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com>
 <20250924232631.644234-3-anjelique.melendez@oss.qualcomm.com>
 <t3hfr33t76ckecatro5gheycb2phnch57m6zzdpm44ibykbubd@e6nffasyetib>
 <4cbcf312-7697-4725-8fd8-45f2b5b0584f@oss.qualcomm.com>
 <6kbkkiwsp3hzu2u6uezelwufooeeh7efrcc2buydpbziuhr5px@xdp24rhfjqyf>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6kbkkiwsp3hzu2u6uezelwufooeeh7efrcc2buydpbziuhr5px@xdp24rhfjqyf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3k0C67rOqHk9JwpKnCO6F3Q5dGPu9fbI
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dcf79a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=K0chv5zXbCjWf1o7A30A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 3k0C67rOqHk9JwpKnCO6F3Q5dGPu9fbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX3x5Sbwa75B66
 EA2EL03XV0tXqzCUHjvlgcfwMg7c7KrvxaxpAiOxF40qGRK55GTzFsieXK2QouujI/zha9C63+7
 uWRQ5uDIaE5x8f0PJoMBdAA3c/L1PPGRqBWJShAmzu9tkNfloo1xEEnG0UQsp404XIvXQOySp2p
 UOWThjx6o9PyfJTPH/SS4vbwh2e93XunVHLsOejP89SPYhb2+Epf7T0tVlwuD7kQXC2RY6BXZeP
 8MYrzFyC5jqMR888JWNdOKJ28E8zv0rTuC5PdiD/9fJbuQmWQ/v4upta9iP4tk7QlzgMaFAi+I5
 eZpQ2jEEC6hO4DmFLjRuiCHGjgzz+YkeRW5zQcpSezluZRJq7rPgGu7is5dvefYvBfY4lE5VdRN
 UZqMQzBZJJJaCUzgr3UjNqNnHOz4fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On 9/27/25 12:07 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 26, 2025 at 11:19:13AM -0700, Anjelique Melendez wrote:
>>
>>
>> On 9/25/2025 2:43 PM, Dmitry Baryshkov wrote:
>>> On Wed, Sep 24, 2025 at 04:26:31PM -0700, Anjelique Melendez wrote:
>>>> UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
>>>> 16 bytes to 256 bytes each for the message exchange between OPM and PPM
>>>> This makes the total buffer size increase from 48 bytes to 528 bytes.
>>>> Update the buffer size to support this increase.
>>>>
>>>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>>>> ---

[...]

>>> I'd prefer it to be more explicit. Define an union of v1 and v2, fill
>>> common parts and version-specific parts separately.
>> Konrad also left a similar comment in this function "This code keeps the
>> 'reserved' field zeored out for v1, but it does so in a fragile and implicit
>> way :/" (https://lore.kernel.org/all/df671650-a5af-4453-a11d-e8e2a32bd1ab@oss.qualcomm.com/#t)
>>
>> So I figured I would try to get thoughts from the both of you :)
>>
>> We could have a union defined like so:
>> struct __packed ucsi_write_buf_req_msg {
>> 	struct pmic_glink_hdr   hdr;
>> 	union {
>> 		u8 v2_buf[UCSI_BUF_V2_SIZE];
>> 		u8 v1_buf[UCSI_BUF_V1_SIZE];
>> 	} buf;
>> 	u32                     reserved;
>> };
> 
> LGTM.

+1

Konrad

