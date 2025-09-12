Return-Path: <linux-kernel+bounces-814382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1883AB55331
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B4516BD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FDA1F8724;
	Fri, 12 Sep 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K8b0X1KV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3E20E011
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690513; cv=none; b=rqz/+VnkVjT9jskKaOpKFnAMvP4PKIqig7skgATr1D4So1eA0nuRWK8f/7hTzAPBc9OcxFI8d2vbij7Ihc03F8sIn2wduhVG34syEUUtYSh08THF7LztBdn+jVFHbx61XtuvFat6wFbIkexDZRBwBmmVw/qGObwfMmLapGLcWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690513; c=relaxed/simple;
	bh=eBIffqaVHIpwsTFQfSPsL8wny4UadlGJ2BPVbfEZXaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYVDPJNcXKASZOW9py0ESkmDvfX20kZgSQF9+DG9CNN08AtHgesiNAyvQ0ryVagPp9Ing91531jfo8CwynIIEtyVXcq9aJxPVwRb5Ml02ThDtzhn1JIH0y6LRGvw7CqEz8pi9s3r/1JnibshaS57qIFR879mxRk30wNH5Y062Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K8b0X1KV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fInR018577
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M+exJm6u9FpUAVtJ/TTJtEO6k4t66aLeQK+HjdP6fvU=; b=K8b0X1KVEG/SjrWY
	HEQdqCn+n3B/BrrB4oRc8xbqANPK4Wy+a4+MWuSX7ejVROc7KnmHhM3uZGlDUrfx
	D393XHXAbJLStlGwNdnMN87khJ6wXpjmVGfJgpzSGL3EcAcYtsKg0gpTaJREWYSy
	GAmz5PLbVoFOfRAoG8gYpp6H5nZ1zmy75T760ZymqKDVkQaUdq3mUJQBFWC/4dzt
	oW9DPn9V9LGHE5LwPuUDLTTlZo31pViACuBC5Y5vIX6c/FM1/gZRdRoXrE7FCBw6
	R4PhsN4YNdHcB9TD5nYwyv5apytya9yChNjNp31FyVlJ0K/nEQeQzDCLsVHEU9Ei
	nuAEvA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8am1t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:21:51 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-770c2440225so1994816d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757690510; x=1758295310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+exJm6u9FpUAVtJ/TTJtEO6k4t66aLeQK+HjdP6fvU=;
        b=XL8QTZCuy/pxfI50AKj6I6NhY2p5l1//TpZe7GIP8nVaWGg9NapgW9tiWaJ5Jox/8F
         kSbp1LClaH0+RVxfNXuTMLdj2yjEedXaPkH6V7eUI35CNkU/pPuNOev6u8JABOoJAznd
         SSNYRr+FF2yrw+ncvL+aAkgGKzCcQQ1oGKd0Ngt0Ity5BCcd1KCSjqUgFToopFic6EGM
         GzvmlDeupKsa7hOcB00j4cFMeeqSHXmfHY+3jrSWAfkeAH2l5IQIssTqAShwytuCpEeO
         v55/vX23FiA/yFnE39Gs4TzBIyH5//NvI6D4eTsmK163vZsCBQ/n06TwI191wsXuKKBy
         fCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVffB/y89Lg/gQF+k0GliUDnpJcnqs4ErVsna27wlHxicFHdZT1muqw5C3qd7R7YLZ+NfWpKm3qdmwFB8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzN+gE5nTqV/N7Q9sBvfRGbHnI9Ao0eXyO4MBjlcb/X6zjQ2cz
	bg/YUSJZValTQFHR7Pz4UU/ltG7QIRA7cTDund9KQ2LyEpDB6qSnAVdqjt8AW+4mZVRl0z4F9n5
	RPbEzyDM9w2wBd1+rD5dm6DsEtyI+gKeB0pPUVjpmxxjd10tBHpA3CMGSKC5cH3IFlMo=
X-Gm-Gg: ASbGnctuuHqCsrps8MUL4RKxYXho0WWRYEapny/mJniCevCSLBYpZxjBhr/fgLIBIo7
	u3yP8oJXJK3GnKrf7zWj7kwaFXJ025u6Mbbs0u6Dbvo/bcX50AMO37h3A4vwnml60UWQisWuIXF
	Mj2zxAeQuOpCVd2QOaewy1/kCIF6B7SojiuBI+iuVw/0ECsoG+EoVog27hB396CZZ4zIPBkVM54
	8MqnK84kQo8QtJllMQ82QsUGStXfqQs9Iph+HLyZNJFI8kkS6jo9/pd0U499aVIF9LwzQQb+thS
	EmQBoDYxEaft7YUahiPm7/7C5aJ+/VXhh5QTpskR8JIhuG7ruG/uYi5s/+NoJu8KLJmPhM9/MJ1
	JDOM7bklIIDG2VNBLU4qTTAsEuxil+pI=
X-Received: by 2002:a05:6214:194c:b0:72c:c04b:b159 with SMTP id 6a1803df08f44-767c2720ed5mr42799606d6.42.1757690509349;
        Fri, 12 Sep 2025 08:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyKcxwpDuk4tKSoFa+mZlm5MoLmXac023JvmnI0G1eJnCPOF9jK2aXwL+yVhrPHN28eYwVWg==
X-Received: by 2002:a05:6214:194c:b0:72c:c04b:b159 with SMTP id 6a1803df08f44-767c2720ed5mr42799006d6.42.1757690508665;
        Fri, 12 Sep 2025 08:21:48 -0700 (PDT)
Received: from [192.168.1.188] (87-92-23-212.bb.dnainternet.fi. [87.92.23.212])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5d5e6c4bsm1234353e87.49.2025.09.12.08.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:21:47 -0700 (PDT)
Message-ID: <9f72e137-94de-4526-b3f0-769f82414c66@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 18:21:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] misc: fastrpc: Save actual DMA size in fastrpc_map
 structure
To: Greg KH <gregkh@linuxfoundation.org>
Cc: srini@kernel.org, linux-kernel@vger.kernel.org,
        Ling Xu <quic_lxu5@quicinc.com>, stable@kernel.org,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250912131236.303102-1-srini@kernel.org>
 <20250912131236.303102-2-srini@kernel.org>
 <31a37e24-0044-4987-89a9-d891200592ec@oss.qualcomm.com>
 <2025091212-umpire-large-b601@gregkh>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <2025091212-umpire-large-b601@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c43a8f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ADr2fr9vtsuHB99cpUQfeg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=94lG5FN-mdgIUN_F1v0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VKTqi27NBotkZYoK20oMY2G6pbb0-JaC
X-Proofpoint-ORIG-GUID: VKTqi27NBotkZYoK20oMY2G6pbb0-JaC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX23GvVQmamS8w
 m1ijvtecMzL8UhlX5cs1qTbduZaY6EmyhByqkFu18ELGhMQci7V6SdUAmms40p7BFDBVUmTS8gL
 UlMyVTS779igrNmM1QdwNoSVzLngOxmdvGa0L19iMw5/oLSj4LGQK2vYiHMJ5UCnNCbkynwxYCZ
 LL8NFGhjNvE0+vxNJ6zMWoW1U4IMaj4TXKFSkIPn5HcxFnuKFeteyhgP0r1KReIb11OGFgn6+rw
 k1IRtyKnZhG1oZC5RkhODXIb1JeUV7qu4KR0XlwpdLfOUnRr0IdzA+L90T6uzydDdEy8SxVtstP
 mCDQ7yfh1sourPXzs5EN6sYrPWDzunLQPFXwdCyuV896yJWDdhFDovZHHHDOW+jIv9HrCo32fYG
 rPTMSLIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039



On 12/09/2025 17:22, Greg KH wrote:
> On Fri, Sep 12, 2025 at 04:30:37PM +0300, Dmitry Baryshkov wrote:
>> On 12/09/2025 16:12, srini@kernel.org wrote:
>>> From: Ling Xu <quic_lxu5@quicinc.com>
>>>
>>> For user passed fd buffer, map is created using DMA calls. The
>>> map related information is stored in fastrpc_map structure. The
>>> actual DMA size is not stored in the structure. Store the actual
>>> size of buffer and check it against the user passed size.
>>>
>>> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
>>> Cc: stable@kernel.org
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
>>> ---
>>>    drivers/misc/fastrpc.c | 27 ++++++++++++++++++---------
>>>    1 file changed, 18 insertions(+), 9 deletions(-)
>>>
>>
>> Please use correct CC list when sending patches. You've missed several
>> entries from the MAINTAINERS file.
> 
> This is just to send these patches for me for my tree, it's not really a
> normal "review" as that should have already happened (based on the
> signed-off-by chain above.)

Yes, I'm sorry for the noise. I didn't notice that the patches were sent 
by Srini for inclusion into the 6.18 (there was no cover email, etc).

> 
> thanks,
> greg k-h

-- 
With best wishes
Dmitry


