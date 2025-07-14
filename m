Return-Path: <linux-kernel+bounces-730923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE45B04C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB471AA16E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D638279347;
	Mon, 14 Jul 2025 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZv3y7C7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C8244673
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536450; cv=none; b=XZ2wBa3UOnGISAKOjqsGnScgFDIrAIcWmiWGnQ4khbfItVuugPxYnstCEUXavk6EyrP1q7eWyqpZygppMAy+BNE2G9bftSmC0Rm+G0/I3pfNfout60FBqh+xujwsB0Z3C2mR6J9HLj615JR21QyAXbFwC+kAb9IkNHPBKTDpI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536450; c=relaxed/simple;
	bh=f0Dnyo9xoPNSPclRBPVIGihMLC9tyDlqpv7KrDQI2Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saapdwYfP3vto+Rt6fl+30230IOdjLe98oqVkFvAjObnVFrDOQF744tX9y6ZIP8im1+dwtIOwL0W2CjQG5o5ck41UY7dUUYEWy50JKz4TAzJ8eBJECTmPITB6YOpL3KkdL6vPseF1crPT99EDtyGlayDKp9k4XTJv6oMwQAR87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZv3y7C7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGRlXt011111
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yXi+Vfo70q22tr3GBwXIimObUqUqXmPUkoh91UkH8FU=; b=HZv3y7C7URS8ZUn+
	Q1l4TUF1kw5kagXw4WUZfSNvS7sEH6cH4tMAmlGHSxeK3AQvLkLxaOvVQLvhxsQQ
	11SOhCFMg8n5LLQgMv0hXA4PwOdZfxiLcmSyV61eLT5xcUVz4T40Ct12OW8jClhO
	E/43i6bMC0e8sDtwPYlx/AaMGHACnkPV15N65NdIRsgFvJD/8bpeCmJBheRIseiO
	FNEJHjiUDRZxt/s/CoH2bv9Et/s2nKRt7zWL0N3D/cMfJbpT1ONitwigWwB7cvoG
	gemzBK00GFqnmAnkhnPAq0NI8dWAwHtjVdz6vvlfIfNLa+WN9+m6xzsVfC8XIP8u
	PMVdMQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dygxx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:40:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fabbaa1937so16845706d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752536447; x=1753141247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXi+Vfo70q22tr3GBwXIimObUqUqXmPUkoh91UkH8FU=;
        b=AVIWpumXWYn313VnS0R7EJuA877gRvMq51J7u49zrYtPteBJ3cESF3bfW/FT1hyFfV
         mIR0ZyklVuyh6MhOrr7P9lhdDfLBkePoLZRI/kP1VMHNPUxiXnAe7iUyU7Yl3Lt4fIts
         0zRFKqlt2BrAJPbTjhm0Wq4y7cCOm5clj2z7bFM2VlZgviH5zJ9KeEP78rtEPUfssLLp
         5ylMuOER/8NePVt/6cacWNA1Kg8nc2qKbnHI9j/RBvEv2pFBdScT5cNUS9x25dnxCWXf
         UGPPdwV8xzQH/6qvnwYMlSLVPHaazRJx1W3UkdmOKUoubZEgEADiuw4a+VQMmjTZ1KoX
         jgMA==
X-Forwarded-Encrypted: i=1; AJvYcCUriDlkFIs3wSgpickExHAFwTt/BtYZynCeHER/n9S4NdIcG3o6DzRH6WZ1HZtZxc+NjOuJz214blfBmw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlbrQi4OG1Tlbw0BF6+SWkBxLk4VI1Ll8TbcpW38/762sttTQ
	2O2ZMPADhBal062tTsKwjSeh75iNukxDneckjvFJArntW3IqUAPJPC8lqZr6Y6oOan5hAktK8a2
	BL2UK8+SMgoMfKV8USRW/OBJ4L+XhNhlHRq2wNw1XDP72/KxgPZGDuPuf2iCGiPCIXEk=
X-Gm-Gg: ASbGncv82B/EjwOclXEJDi8Ye4NcqQGvsrnhIBjUAGUfsMdsJuqEQ9AimGPxv80YS4X
	eRypFRJypvBe6xjmfzeYRmyqz63dxSWpbzGhDdfO9rVpPvdy+OjCtUbYlSWpJs6C7pqVGRkIs3v
	WmUC3rIudshsOqw5gatdrjKAzEapVd1GCljjNPqvEp+DmMH/OBko0jU1C1v+pWgRZ6Pge0eS8jN
	j7+k31WYk0uXoDhUIMBZ/Jbj9dsdW99EGUfr3CXX3V9uuDMz4/vtR2kU1HDj27xkrSZND59ny37
	VRO3bx+xp/hFglSuuafVHFcwbGv8T9EJ0NtJ02yL+ZRT9N86+RG860lvt5pS6zTYUEMVF05R+rN
	MOPB3tU3dikeTOTJg9Slu
X-Received: by 2002:a05:620a:d86:b0:7d3:f0a1:2f3e with SMTP id af79cd13be357-7dde99530b9mr793274085a.2.1752536446972;
        Mon, 14 Jul 2025 16:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEND06f7E/xldG2SwiZSQTbgDcvn/Jbw/7eu/cnbVCi9unjwVVB7Y5X5mBj0MZNrcNpy8/YbQ==
X-Received: by 2002:a05:620a:d86:b0:7d3:f0a1:2f3e with SMTP id af79cd13be357-7dde99530b9mr793272685a.2.1752536446427;
        Mon, 14 Jul 2025 16:40:46 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e829d061sm909166966b.142.2025.07.14.16.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 16:40:45 -0700 (PDT)
Message-ID: <5567e441-055d-443a-b117-ec16b53dc059@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 01:40:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: Remove sdm845/cheza jobs
To: rob.clark@oss.qualcomm.com, Doug Anderson <dianders@chromium.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Helen Koike <helen.fornazier@gmail.com>,
        Vignesh Raman <vignesh.raman@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250629135843.30097-1-robin.clark@oss.qualcomm.com>
 <92314f06-e6a8-4882-a31c-914438d7761d@oss.qualcomm.com>
 <CACSVV01AUOp7vZ7kLt+gwxvfv4CYLtAQg6MhUccygbi1NpVJMg@mail.gmail.com>
 <aaaa42ed-989e-43ee-8d45-2908f52e8584@oss.qualcomm.com>
 <d323ceed-19e2-4b17-b97e-0833f132be16@oss.qualcomm.com>
 <CAD=FV=VV_xvcWwdpi88wSYWXyftUP5eP-SQVkgEBRQgfwDN+zg@mail.gmail.com>
 <CACSVV01PkDKWSRq4eQCJGFePKmSKmFdkNFt2PSC4w+r1U9nZuw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV01PkDKWSRq4eQCJGFePKmSKmFdkNFt2PSC4w+r1U9nZuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yGV9aImtTV0XvPaRocQndmb0K-P_UR2L
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=68759580 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=dRXE1jWJAAAA:8 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=Jp5PGaZ2n-Q8juSPBdEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=I84_JwFgYcz8Gf5-qaVM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE2OSBTYWx0ZWRfX4/8BsUarr15D
 SXKaF0kFaW8nAuRQL5ncsRqAtLByHleBCm/Gl55C7kXwEI+qhZzyUjrhs3bWVpY3G6TdEQ1hPmr
 mijTt16MpojgHe6J2nLptsalUABCwG8V3c2Jxc7SooHNWWIM0ET03++tlsMY+hKUoKVRcjRjAov
 d9aXUMEK+nKrwM4RKWSn/Bh5v8s/3pf24/WAdq1v5AuxtwrSGzwJkbTeA7m2Pn+dFW5Ll64iVQ1
 VlxMg66y04vd7A84cR4wyjS3b41e4O7NDtNy+UhLf1zIDKHQrSvQJ1Y5KzkcYpiPrdy5HSGu1CR
 Jm3u/4qTOgwyIZ5ynTKTocrH05JHBzMBETOWDi/hdZs+flVBQiUTf6UETUc4Lolf5sANzscV+us
 nVj8/NajkNaVgzWl9ZajysOOMnZ6FGELJiWHZCrxt8yKyi3FKXGX1fLKq5XjmPmIOA83hmtj
X-Proofpoint-GUID: yGV9aImtTV0XvPaRocQndmb0K-P_UR2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140169

On 7/14/25 10:08 PM, Rob Clark wrote:
> On Mon, Jul 14, 2025 at 12:56 PM Doug Anderson <dianders@chromium.org> wrote:
>>
>> Hi,
>>
>> On Mon, Jun 30, 2025 at 9:15 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>>
>>> On 6/30/2025 9:26 PM, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 30-Jun-25 15:46, Rob Clark wrote:
>>>>> On Mon, Jun 30, 2025 at 3:34 AM Konrad Dybcio
>>>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 29-Jun-25 15:58, Rob Clark wrote:
>>>>>>> These runners are no more.  So remove the jobs.
>>>>>>>
>>>>>>> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
>>>>>>> ---
>>>>>>
>>>>>> Do we have anyone using cheza at all anymore then?
>>>>>
>>>>> Probably not
>>>>
>>>> Adding +Doug +Akhil +Jessica, if we don't have any users, we may
>>>> get rid of it upstream, as it never made it to the outside-outside
>>>> world..
>>>>
>>>> Konrad
>>>
>>> I am not aware of anyone using Cheza boards within Qcom. So it is fine
>>> with me if you plan to remove the DT bits.
>>
>> As far as I'm aware, anyone at Google who had a cheza gave it to Rob
>> to put in his lab. If Rob says nobody is using it then I'm 99.9%
>> certain that nobody at Google is using it anymore. There were a very
>> small number of external developers who were given a cheza prototype
>> but I can't quite imagine any of them still using it.
> 
> If it helps, this is what the batteries looked like when we pulled the
> cheza's out of the CI farm:
> 
> https://photos.app.goo.gl/Eh8EJhqBhKUuYfiH8
> 
> ;-)

Spicy!

Thanks for confirming folks

Konrad

