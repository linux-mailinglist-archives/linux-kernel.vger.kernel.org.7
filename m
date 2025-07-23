Return-Path: <linux-kernel+bounces-742322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FAB0EFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3439A16B914
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB6283FFB;
	Wed, 23 Jul 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0yrZJWe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C228272E70
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266835; cv=none; b=qNjUE+GmyV8OiBJCQIvNOgD+/5dhpTixpWF5mXs42LkmcIaLSNRLG2NY8Rh3Bzu+Be4f+1VlVvNpuOpAS/qz5dPrXDJASkTpu97GbITrzCFT4G1XL+Ab9Q9ROHCoBYObH9Uex5C7RPcTDwTE5JwekI5x/mtctSJPlm5UhK7cG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266835; c=relaxed/simple;
	bh=KPN+vp3SZ1U4t2zJAOAO6TQevWKEb7K0+lf+cfAmgcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnfhHH5ypscpGomXFCl0tC4Iz/40U6qTZu/5Tp8dj8daJtie97ZZiCMF+zoL4FK/usr9P9teEYPaoSmrR3PDt4ZTUVIHPBQkOjY2NdwEbWF2iHVtdDpDgyyvwNl2Y+dX2DoonKjeaWM5BNYL/jMF5/x5JGCnvpd8FixMw/Rh4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0yrZJWe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9LTNu005205
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oBHkd60XiHv3KTV4Q/cfQM2d2Sgw9xBBOOYrRSYVnq4=; b=Z0yrZJWeWkVSGRng
	ztzDGzJDZ7ad7CtObEmZZxE395gQXCp5/a/bKKALwUBwhajCf+C7sYP9mdJ5doP0
	8yteaZRW9EIKZX33NyvAm3XQ3yWjm8jwy0qCYwOBYf9kwu1oEAmsJLTMfKuguF7W
	SeiW4YJ08+ybvypPghMWMRPzqJmYh+jssS/HmL9yOkCxkHbw6U+ulUTh1A6AI7yK
	rcPWxFbQLcAZ2BZqakZI2qbqLdvX4OXucGtR6MdzQKaBSWh1FpbAeiqwtAowSiiA
	vKMbdQ1w4Zmoi4TnP9nEkbqixtLdFwvpaLRTF5G4DyvyzDFiSK6fhZWUNNmT8CpR
	BhARHw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w5y6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:33:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6facbe71504so9875846d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266832; x=1753871632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBHkd60XiHv3KTV4Q/cfQM2d2Sgw9xBBOOYrRSYVnq4=;
        b=WQxvgWaLyQYvxjovGnnToQ/FJKHUTJeVih+99MImvVMjGaOmjmYZysxv/M6ZQWKlPr
         HtprKNOTjgwhd1SMdG7FvfoYp/jldux3HzjB2tVJjUyPAbeTIiLBX6JlC3/ge1GnlL4o
         b8rwHzOBONCdbnimYtZ7KiD7V1cR2s6305RqK2SJ5YarcHI9bnwdzHoyhbAxUZUx0CZv
         LSrctjeKU38sD1v98muqwVddFAx7wrD6DieXpzAU4YdmNG9aANBfn4IEvO0MQHVcoV83
         0j8Eq7OpLxGZSTLQDEIinT9XYmtvglfD73fLT5Q+n9ZaAhgmwhNolAIkZJcIU8llztjT
         wnAA==
X-Forwarded-Encrypted: i=1; AJvYcCUF/OZE/FLfj49lZCLWdK4wMEbOOVMbdemJVLAhpsklQ91NskpKBQEMl0V4hWHXA0WD5udMZGtzBYl+LOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRlpqOvc45w494M0DjOgxTWFeAjMnP6D8F+k566SQw9jPd+0X
	P4K72gEMjRuPDGHhQP6Lvjwq+KyniWSZayqs8mHXlbOptZ723mrofrD/UEfKFXOx4t9mx++7xfw
	OQFPggXH7J1TDMsQwGXIfCNGLIrTyEjsCB4QhZSEynp4mJ8NPvqpXJbmhUbuiDjPh03A=
X-Gm-Gg: ASbGnctISbhycW/sCiwcuNIKoDvKbSJn/mE6/OvLJn3U9w1gjBp95m3GyL15FzFysve
	ih2pHr7PL+jzW4Spm1X9wsENPKxbOQySFeqgMb5xDunH7zmDxxOqdubvvE1e6NOOO9Zq1edhHpo
	bS6+pSAfDlzq+NZurcFOVb55Uozmr0kUidIvF+Ow9cKj5Ka0EcvKUZJnvocRF3XL98nzblBJvlI
	PdxqfUwQc2gYM145B5T2wLsO6+k97eDylsFnILglWF0Y9CscR9hyeGbxSpw0sU+GHBvlFjV7XRv
	XIHFLvWbZL7PF2xATeMVGUoClNlHveUxVtZJ7Xrcp+qtFhyXKP0y9PHzhbC2/nDcwIu8BqtMZma
	ZEi5sHtS4SqdYXriUCg==
X-Received: by 2002:a05:620a:2a16:b0:7e3:512b:97f4 with SMTP id af79cd13be357-7e62a1211b1mr119488685a.3.1753266832060;
        Wed, 23 Jul 2025 03:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2NMUcGI464RrH7J7b4NwsfI3U6elRNVRs3V+eXGNIbBdAvL30yamLCKXZICj1j4UL5vBZ6A==
X-Received: by 2002:a05:620a:2a16:b0:7e3:512b:97f4 with SMTP id af79cd13be357-7e62a1211b1mr119486685a.3.1753266831636;
        Wed, 23 Jul 2025 03:33:51 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d68a1sm1023903366b.46.2025.07.23.03.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:33:51 -0700 (PDT)
Message-ID: <50d6a7dd-46a4-4281-968d-d7df041f21ae@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:33:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] drm/msm/a6xx: Enable IFPC on Adreno X1-85
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-16-9347aa5bcbd6@oss.qualcomm.com>
 <37nuk4kevhpwlzbpgm4tyhnmk6vi3a75oosz7l7xbvvn7qwq22@oomdnizhc673>
 <85073de3-3933-439d-9912-1f0ff145df97@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <85073de3-3933-439d-9912-1f0ff145df97@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=6880ba91 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KWxADXa3oT3Tu5R4PFYA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4OSBTYWx0ZWRfX7E/gSw8iAJiW
 R9giE4MysK07Xo8/0J8SgyXFGyDQNZOjIXfrSG9kXUYk7+Xb6zmtuycz68wTOIUob1QcULjOZHw
 aReamhb1z/IJNrUhe6ltQg2ftVfwBxxEbhwxHszUTOiFQ/SLyjpx9yWKTT3mUK9PQ+H+zB04dnR
 DkJbBRFaM1CpurJYTt9Bu8UhCbPJHPvqu+Gs2xsu5xFdAAdnVDtN9RsEEnkc8ra2JRB9Yzh+A3H
 wfKSecXRk7Izb3bM4DnGmJjGb2UnZtmlDRq62bXZAOk5tCxyxCLjH9nhxjUA3Q7p+XNmdmEPfBp
 Jp/f5RCXQLqMonoQbWsNETHXFjr4nCS6FQDoWFU2Hkzu+wrKDzZB0DtQSHkwLBN77sYTol3WZ2Y
 hdAkGyhSGJYvLM3BWLzTzyXaAbWWfg3iiTGWxDTcjjsg2Vsj/2jLG3uR4zm8LeDoh//9c+q7
X-Proofpoint-ORIG-GUID: kzFPn6_0A20JC6UHbWdzR3qEY-mWgPSD
X-Proofpoint-GUID: kzFPn6_0A20JC6UHbWdzR3qEY-mWgPSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=701 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230089

On 7/22/25 11:37 PM, Akhil P Oommen wrote:
> On 7/22/2025 7:25 PM, Dmitry Baryshkov wrote:
>> On Sun, Jul 20, 2025 at 05:46:17PM +0530, Akhil P Oommen wrote:
>>> Add the IFPC restore register list and enable IFPC support on Adreno
>>> X1-85 gpu.
>>
>> Nit: GPU
>>
>> I can't stop but notice that KGSL enables IFPC for a bigger set of
>> SKUs, starting from a630v2 and a615. Is there a plan to get IFPC
>> supported on those platforms?
> 
> Sorry, no access to those hardwares. But I can certainly help if someone
> wants to do that. :)

Let's get the groundwork merged first ;) 

Nowadays you can reasonably assume we have access to at least one board,
no matter which SoC

Konrad

