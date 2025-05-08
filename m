Return-Path: <linux-kernel+bounces-640239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED555AB020C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06579C3144
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCED288523;
	Thu,  8 May 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h/fVgsjr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E32882DF
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727310; cv=none; b=X13Ib7iAP1oX9fmA17WX/dnI9qzlqw3m1N0iMnkBPczdy1t7f6Ozw5jyQt7W34cY3ZyruAFC4Mba48recb9xiODVZR5m/oLyG1wwPhtnXFWFCyA4wW9c8leHcT9ziEQn3SFNGguMkJGv3WVtsiKEFSZ0XTyp7F8aRJQoeUdujNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727310; c=relaxed/simple;
	bh=tf0e69QEXx1KRcqDH6MbYOhTdYNkdEfOzBuSMhRr9+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwsVaWSM5PWjBGLfDSBdE7gGzIEgMIQpD+H3ThBXrOw9TqPKoeUCc+zeV8/8sXrLiW16XeSGSOkfYhSHBUWN2giQ26RonAQ2TzVxejjkhTO441gXApn7xAU6RMoiewYm55Rs3NoEu9eft5AoJrvBSYZbkWxMrMVXZ+/pstSus08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h/fVgsjr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548CblGf025418
	for <linux-kernel@vger.kernel.org>; Thu, 8 May 2025 18:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	faYKMx3ZAB8PhnJu8Fjo1te3lAGIdH6dTqFWB5Uw6zU=; b=h/fVgsjrXVOin7in
	MRmmMVj8wmE4+Zp8Inpda4d1nGqGh3x2jM/45AFIWVajwYRE7dppj5Bcmz0rGLtB
	2QSJNrF7a6F0q31t3lRVMpML4/9BJpgtFSakHKTrKhRg5sknEZuZqrkt2uR393VY
	O+EqHocY5Eu/fQERR0hSnN1ytLRTMGodRuwsjDgeoWdf9zZpwmjw/cdqsdDWcyQy
	csAqBDAXwRE2IjeNDsYVD0q+a+p6mv/1CrvdT80SZMa+wGUIbSZGNE9EAwOcBOTs
	bHj+QoiadZE0uxOFot0dhWmR8hLzuRxPkExa2KpUEBQkzNSYEnAcj9kQxkeUP5VX
	7tZU/g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp1274f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 18:01:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47ae9ed8511so2710701cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 11:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727306; x=1747332106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faYKMx3ZAB8PhnJu8Fjo1te3lAGIdH6dTqFWB5Uw6zU=;
        b=HtmSpQMnwzaq0Rw/cIAWKZMF84GnNIBNcn+Y/98FPzNfiJeUn0tAFzb8bJ7zTgeQiD
         RWFOdZZM2lT+Nf1Nwcxt9N5sOBxg9qFSCQ3wH5dvx10RFEyyxafu0uGy0Cn7+n3I7FuJ
         3XkhBINv9c1ahgb35znh6ztAMJYrp65KQV3jL9AgxpvlHPA3uzvILnJfWh/OYN1n+Lqx
         KsJ2Ygc+Ojd431oWdWldDf5MAjyNpuQkztdYlS3EZ81ktu9B4zp0XfigjBMJMpc09Mjd
         wJDJ7NEY2EqGuj6T01nhF4Sbvu2jvz4QId3r66y1KZ9pG/g6m/3HESPuaLGECXRWFHHv
         UeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/gQXPNzpiWMtJ9f2n84M9Vw11ItE9G8mmFFMUfTvU7xc6JWaIExKilTfEY+AC+tW41U9JKeDJt2e35MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy60ehs/X/F2rlhz8MUA9nKgbFKlLA79dBjdu/Mo1BFQSL54XJE
	j5qaoAWjZ+D2YpWM8E5w3DBVmrY47O7BA11TkgZZhcVqInlTEiSC2oFXJWvLSxc3pV77JiEyH1i
	Tpc9fAQmsp9YgS+M166Ag+kmq6x02k+15iBV9n0Hrz0SvCpgVHrau///+y+B8KfQ=
X-Gm-Gg: ASbGnctu4rrDax52vHbhV75977K6NF+QW4weMR85rSp8lzJ52qxifH/cZiH8bxPu4Al
	ltoL8lg04IIysV6R2w0uazzoS1q5KVYHSNAco0LLkLhK8h4mZSeSjz7gVZhgpLcrhz/WO1prhsP
	vwWwZ3Svth89qrNul/GhYbFchUtJcO8EYzZaTuDenf0t+PWZXYoXEj5xQiuGiRHaqH/PSRU7ZBy
	qkKV4mPr60CmdryaAVk9wsiYVJDRJ0impbu+AaTa0bJW1E1JUavtEwmp+fBbN4Gx9kZ6qb4jDN7
	hH7Q8MNoexOWGar3p6izpL3LLfbYv1iGSaWdo5EWZ1j4gsVHmHDaUvfeT2hZT7GU9+Y=
X-Received: by 2002:ac8:7f89:0:b0:476:66fb:4df4 with SMTP id d75a77b69052e-4945261e5c8mr2116531cf.0.1746727306369;
        Thu, 08 May 2025 11:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0RfkAw4JpFJ9hanOqIpMrENgKJ7h2yQpbIeU9EmRylaW6/4y4JTXRps/+PPWzcOvYGMLL6g==
X-Received: by 2002:ac8:7f89:0:b0:476:66fb:4df4 with SMTP id d75a77b69052e-4945261e5c8mr2116291cf.0.1746727305834;
        Thu, 08 May 2025 11:01:45 -0700 (PDT)
Received: from [192.168.65.105] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197468eesm19194866b.110.2025.05.08.11.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 11:01:45 -0700 (PDT)
Message-ID: <03409f08-9612-40be-b8b2-6cebd5acd0a4@oss.qualcomm.com>
Date: Thu, 8 May 2025 20:01:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] soc: qcom: socinfo: Add support for new fields in
 revision 21
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250425135946.1087065-1-mukesh.ojha@oss.qualcomm.com>
 <20250425135946.1087065-2-mukesh.ojha@oss.qualcomm.com>
 <mc6n7fbhjhe6cxyoqkxs23kjs7gsa5cihy6qwrcrnz4g3kwjms@vh3vfqzfprw2>
 <aBzPn2OXapJLsikk@hu-mojha-hyd.qualcomm.com>
 <s5fd3txerbwgzzgqnoovkffmijgub5dxfucqqskhdqyjqzkbyl@5cyycrfmubup>
 <aBzgaKSspA0Af0sZ@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aBzgaKSspA0Af0sZ@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE2MCBTYWx0ZWRfX/ZBzwxQ/GBXA
 Kfgc5etNuKTjyRMIgtSdsg+fPpY4IUn/jY5klvGXDiUilYNoa22jjG/pHrKubTbx+n7TjsyzZbO
 +KT/nDfIJ6duu1HTae9zrshDvHXZAOlZDlMZI183ys9U8rTqF48DZSr0+3Kf7ilB8r2N8J4Ood8
 qZ5tagnzuE2St4nYi4Hwm+dH4xiQa40z+t0Z3LZuM05oOLp/905Lljx/RytrPNS1rIAmzIiZHaz
 z6bsQYvL9FE6yscv0HT4A+ywDfpeKTLBdDC2kaZrelvNFb3ag/AriTMfoL/mLdW/glwTs5gjsnQ
 x+aIYCbmwBQlyL3UvWvU3bhR00NROIm79plV3dUxlkfmGp85ZbfoDQIyK2nLPfPAShjEu3wAgVD
 HwMe0+bGULd241z+RUNKVZOw6ZjDojPDEkr0ZyOX6Id6csccB75seeKVUmd8EFrzmpDrjqwe
X-Proofpoint-GUID: DCirQlW7E7Z6jL0JlP71OcFAcbPnE1TN
X-Proofpoint-ORIG-GUID: DCirQlW7E7Z6jL0JlP71OcFAcbPnE1TN
X-Authority-Analysis: v=2.4 cv=W4o4VQWk c=1 sm=1 tr=0 ts=681cf18b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=o0mhMSQjO9SjGwgmQLoA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080160

On 5/8/25 6:48 PM, Mukesh Ojha wrote:
> On Thu, May 08, 2025 at 06:56:47PM +0300, Dmitry Baryshkov wrote:
>> On Thu, May 08, 2025 at 09:07:03PM +0530, Mukesh Ojha wrote:
>>> On Fri, Apr 25, 2025 at 08:28:51PM +0300, Dmitry Baryshkov wrote:
>>>> On Fri, Apr 25, 2025 at 07:29:45PM +0530, Mukesh Ojha wrote:
>>>>> Add the subpartfeature offset field to the socinfo structure
>>>>> which came for version 21 of socinfo structure.
>>>>>
>>>>> Subpart_feat_offset is subpart like camera, display, etc.,
>>>>> and its internal feature available on a bin.
>>>>>
>>>>> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>  - Added debugfs entry and described more about the field in commit.
>>>>>
>>>>>  drivers/soc/qcom/socinfo.c       | 6 ++++++
>>>>>  include/linux/soc/qcom/socinfo.h | 2 ++
>>>>>  2 files changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>>>>> index 5800ebf9ceea..bac1485f1b27 100644
>>>>> --- a/drivers/soc/qcom/socinfo.c
>>>>> +++ b/drivers/soc/qcom/socinfo.c
>>>>> @@ -154,6 +154,7 @@ struct socinfo_params {
>>>>>  	u32 boot_cluster;
>>>>>  	u32 boot_core;
>>>>>  	u32 raw_package_type;
>>>>> +	u32 nsubpart_feat_array_offset;
>>>>>  };
>>>>>  
>>>>>  struct smem_image_version {
>>>>> @@ -608,6 +609,11 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
>>>>>  			   &qcom_socinfo->info.fmt);
>>>>>  
>>>>>  	switch (qcom_socinfo->info.fmt) {
>>>>> +	case SOCINFO_VERSION(0, 21):
>>>>> +		qcom_socinfo->info.nsubpart_feat_array_offset =
>>>>> +				   __le32_to_cpu(info->nsubpart_feat_array_offset);
>>>>> +		debugfs_create_u32("nsubpart_feat_array_offset", 0444, qcom_socinfo->dbg_root,
>>>>> +				   &qcom_socinfo->info.nsubpart_feat_array_offset);
>>>>
>>>> An offset into what? If this provides additional data, then the data
>>>> should be visible in the debugfs. Not sure, what's the point in dumping
>>>> the offset here.
>>>
>>> offset into info(struct socinfo) object.
>>>
>>> I agree to you and I said the same in first version this is just offset
>>> and does not provide any debug info we would look from userspace.  For
>>> parity with other fields I did it for all newly added fields.
>>> I have dropped it in latest patch.
>>
>> I'd rather see the decoded structure that is being pointed by this
>> offset.
> 
> You mean info + info->nsubpart_feat_array_offset ? 
> 
> There is more to it which I don't want to mention as they are not
> upstreamed yet and unrelated to this change.
> 
> data = info + (offset + (part * sizeof(u32)));
> 
> e.g., Here, part is a enum represents camera, display etc., and data
> represents their feature presents. Since, part is not upstream yet I
> don't feel we should expose this information to debugfs. We could always
> add them in debugfs when such things are standardized and upstreamed.

That's what Dmitry's saying - just add support for them

Konrad

