Return-Path: <linux-kernel+bounces-653581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D1AABBB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C993B1248
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B52749F6;
	Mon, 19 May 2025 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtwP8YOY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FAA27464F
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651219; cv=none; b=jlKdy5hWZcrC2Kv+hWCe7onTYo8s8mBOnA2wI9u7vJbkStTlMdUKAzXbtsTTJ5ghRhqQfPSpSQDhbOyJUQPqCIcsPG7T6Yf1wE3PPYmOfpqu8xvYrZLVuVYcN35mD4jER3FfbIp6pE+hdkDlWb+E8eS2408OdSCX5Kr0YMj1bcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651219; c=relaxed/simple;
	bh=g84ZbQQBNZAZVCDuB5DQ1dXFC0XI1GSPWp3OkBhpjb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIyfFnd/vsPaZFh3UIQKmy0tOn7CxkASUmY3GkHuHAc5EwhPwFdAjo4hqGMVri4lKnUBnJHZXqfIC7mHIsEpEF/0gyA0Lx+Xm8V5wFBdwMnG+mqEYxKIiHxRR9WLpnRuYuaBX7nJVanR7LpujAYj8l/yfcQn3GbcCIyBds9WC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtwP8YOY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9Mbki000806
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 10:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNunvHAyKDRuQjsR5Fk3dGl22lS8zfx04q4ZmVMevxI=; b=jtwP8YOYH80PO8LJ
	ABnPoGcVt+YjCrc/xbkA0ZoWc9MvForvYW1qzms6fEM8yHxPUqCwLblwcWi638cr
	mJZFb0IOwRavM2xOgLL7epeUznpglQbpq7ci/9/ELs7XokMmBrjnQsQJcRIFfDLR
	q6fJf1rYqzhw7x2ucFyRdAPZOBczO1y0r+r4SV3GjVwRhvObk39Mpi469fbvDB/R
	W3DjHLs9he/GdyOd7tCXvzGmYI8GN2/CtzUX0x3WHXu+Iy/pllfBEyyqirtiEiGM
	BwbeexUJx+C+tn+3hZ0owN4gp9CIcuDe2WRyHSIWru50kDha20odrLYS3BaqhD8s
	sVrtbw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pkr9v1hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 10:40:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f8dfae341eso5269986d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 03:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747651216; x=1748256016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNunvHAyKDRuQjsR5Fk3dGl22lS8zfx04q4ZmVMevxI=;
        b=rnPahfiwobstWIvPCs/r41ItHwd2dFSi1nR8Xf8sB5YtLjx3a3jrBWOBwVexHabmFT
         3k3JJB+uapWLSe4q+76rHDx/ntipBqxKHdb9W5DvnwIuUAYcFP8RFue19Qbkegg/eh4h
         4PALb9UfrPoNaOQApV0YsR0JANfnIVwTkjPbErEgtwvMJyYeEU95TqmY+wKlcGxJJXts
         jRMzYt4Cgk3se+snbNQmcPmLUB5pMzvFFbEifCPeuXzYEmPmgd0CqVxXTX6GdzZrJH6W
         3av3JqvRI7HHFQf/1Y8lyQSQYDqJI0OX6RFmLcVzoekcI8ZIUtBDMhwTihswbRJPxkm8
         gZNA==
X-Forwarded-Encrypted: i=1; AJvYcCX6d5QIeTgthveGcLcqH5pV7KYgIWzKOoBRg7VQmpBlv/szY8MWnK+W9s8X/NhrIogQfw0vS0ka6fEkCuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbE4rs7c2XkJm3ScTcFLrRBDCuKVYUN3dF7YJ62M5SnMM6/xTq
	GZY4nj/dzkeVz1KMIL3PnJ4fLKpueGe6q5aGxtHM1EnFmu+iR4hK6BEpuXfEL401eZ1RiSihC52
	OJhcGbhDzRR7GCNaELNDDhw3xjn3e+24+ObxHFpWw7AB1J2zunN0M92eFp/nE90mGqhY=
X-Gm-Gg: ASbGncsXSQM6dkNxf/DWWFb+H4mPJMnNPonNx7E88U2IxfLvg+Ck5MVc+WU/2p60dkK
	Vft/ML6cFKqmAZ6/D3JcwNub3INuX4zSoK+hvTVDQ2quC19rZathhtFjNuk/+ScowtHtSTU3lTr
	hFKE705u3e1R9PvSf1LGNDy1K8qA2S5dELXg31ML8ZsWoo13+ogPfT9omylVZeW1TgVzP8EYep0
	o4dSClcwvX0wAIigWNi73kNFH6bEBD1b1XHeFp+AKCOTDWOC3r4mZwYWZW1x+3hf45omsjYOG9n
	+a7mGOou8+CAK+Rp1ScPwWU2fvTZlh4pSHdJLg==
X-Received: by 2002:a05:6214:d08:b0:6e8:ede1:237 with SMTP id 6a1803df08f44-6f8b08f8b10mr180754506d6.43.1747651216012;
        Mon, 19 May 2025 03:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/Skc9ACExrbEwLnHLmp+Q0PppdvM9V5a695hjjw29Yz8NJtOmhXksNLJDqqYJRHflxLJ8RQ==
X-Received: by 2002:a05:6214:d08:b0:6e8:ede1:237 with SMTP id 6a1803df08f44-6f8b08f8b10mr180754126d6.43.1747651215476;
        Mon, 19 May 2025 03:40:15 -0700 (PDT)
Received: from [192.168.68.115] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a79asm12163358f8f.25.2025.05.19.03.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 03:40:15 -0700 (PDT)
Message-ID: <c80c48a1-f1b6-4520-9d7c-3a83915c7717@oss.qualcomm.com>
Date: Mon, 19 May 2025 11:40:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] misc: fastrpc: Add NULL check to fastrpc_buf_free
 to prevent crash
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, gregkh@linuxfoundation.org,
        quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@kernel.org
References: <20250513042825.2147985-1-ekansh.gupta@oss.qualcomm.com>
 <20250513042825.2147985-2-ekansh.gupta@oss.qualcomm.com>
 <0afd9fc3-3748-40b0-934b-ba5b5f6b0bc7@oss.qualcomm.com>
 <7svn6kgajzw6p7hxw3zzjbxz7ipakgv3gacbj4v3gxdw5ssdsj@lvj3hxn7qxu6>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <7svn6kgajzw6p7hxw3zzjbxz7ipakgv3gacbj4v3gxdw5ssdsj@lvj3hxn7qxu6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MTIl_FienDcisbFVJBQnoUVicuCIL0cO
X-Proofpoint-ORIG-GUID: MTIl_FienDcisbFVJBQnoUVicuCIL0cO
X-Authority-Analysis: v=2.4 cv=DdAXqutW c=1 sm=1 tr=0 ts=682b0a91 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=qkwAhwrShwPuNbHiLtAA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEwMSBTYWx0ZWRfX03ZPjBiSzRlh
 S1Socr35gcuB9M+PCgKsJC/FtXf1g+2KI2wemv88IGsFDaCJB00FMt4cALaDayuKerNBy3dRpc8
 zi0NftrT0/KtXMdupWYfnij0pojvniIyNv7M7iaRgRuuNo2CmvVJkdlybIoJ/eIKU1do97gdE8w
 qH6Z4bOmQXTdal+VY0BNJzms4n83/g0QdgoOKO/tyPxtj7e72MW8/AsiijcVT0vi9w0tHs60EYX
 490cdWUtCl5eM01Fo/CBHmOkovCmkns8dDoJyjHo4E5niQ2YL3EF4/aNlF/gMWHIG/WlUHSXq/w
 gnJpNMkBheNGGAxOkUSSXlDm7ioIYnm6LCzeqS0uy+m6ArI8iRFVoI1djw0T4MQ07md6Nm+/BDT
 bRnSFPJB0TW1DwzBYBH8eqeTuE5O4YDcdnv9TuJzqODdb5j2jJj6Df8VnWgrjA1Peo7zTjFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190101

On 5/19/25 11:09, Dmitry Baryshkov wrote:
> On Mon, May 19, 2025 at 10:25:46AM +0100, Srinivas Kandagatla wrote:
>> On 5/13/25 05:28, Ekansh Gupta wrote:
>>> The fastrpc_buf_free function currently does not handle the case where
>>> the input buffer pointer (buf) is NULL. This can lead to a null pointer
>>> dereference, causing a crash or undefined behavior when the function
>>> attempts to access members of the buf structure. Add a NULL check to
>>> ensure safe handling of NULL pointers and prevent potential crashes.
>>>
>> You are mostly defining the code here, but not the root cause of it,
>> What exactly is the call trace for this crash?
>>
>>> Fixes: c68cfb718c8f9 ("misc: fastrpc: Add support for context Invoke method")
>>> Cc: stable@kernel.org
>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>> ---
>>>  drivers/misc/fastrpc.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 7b7a22c91fe4..ca3721365ddc 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -394,6 +394,9 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
>>>  
>>>  static void fastrpc_buf_free(struct fastrpc_buf *buf)
>>>  {
>>> +	if (!buf)
>>> +		return;
>>> +
>> Most of the users of the fastrpc_buf_free() already have the null
>> checks, It will be Interesting to know.
>>
>> If we decide to make this function to do null null check, then the
>> existing checks in the caller are redundant.
> 
> I think it was a primary reason for a change: to eliminate NULL checks
> on the caller side, as we do in a lot of other kernel API.

Lets remove the existing NULL checks at caller side as part of this
patch too.


--Srini

> 
>>
>> --srini
>>>  	dma_free_coherent(buf->dev, buf->size, buf->virt,
>>>  			  FASTRPC_PHYS(buf->phys));
>>>  	kfree(buf);
>>
> 


