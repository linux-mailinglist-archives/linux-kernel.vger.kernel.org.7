Return-Path: <linux-kernel+bounces-743479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98247B0FF29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA73A173EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D401DED5F;
	Thu, 24 Jul 2025 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DTJ+MLBW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3B158535;
	Thu, 24 Jul 2025 03:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753327780; cv=none; b=jhKvX/IH5UtuMMs5053lqIQo75rmx61nEKhdVAlsXsnxnKq9BercKSzyOEW8x61ooJ5gb0NXppRsdOkbJAoOfY+cplE0hWEizuUhoMK3Jn07CnHTaPI/8XSzy2ROQx0EhCCd2M3LijlBkMUHNzedah+Flkw8w5VN2yeOa/+ATaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753327780; c=relaxed/simple;
	bh=mMhy7lBHvKNT/Otl8Zn3g9UW060LUNpNcF/L4SYZxyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lcgzM1N83ovpz60QizQHUk9/oJbR3OnfAuDcxSWabTT2mlnhBt6F8geGcgg+9o8PPGDIRVBopwNhKPgURul2JeuQkC3mMOasDqa1dD6657l/lnu3pXQDyaracO/Yohcy2lohPqGWvqVD+N+Alt9xygFJGgVd1oETX0QK9ZzOZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DTJ+MLBW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXZWx016006;
	Thu, 24 Jul 2025 03:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mnJDM/0zfvI8HbrY8ldAg1aTC2VsVALZRc/Q4DEWBBw=; b=DTJ+MLBWzzXAUvyr
	2FEJk5JEfdLWDbCDfO0Ys4xhZ2VXlPGf0cO0ndK2tBmW5a7C2w0ArXabWvbLpgpH
	yrSyrM4yvMOlPouY8pKsSn1Sa6AMGC52W3TUjA8gxPH4m4QiW07xoYz+Cmp6VFol
	IZr3TfmG62xU4hXtd9hb/KhCkGitWwy8lO53o7YHm1ZXo8uNrgNgU/+0r+alo5RV
	d6AsAYPOtFPuWj74y7XBgBXvqqa6u7ScHsP+131mK5/3aaoBauHof7tVmREwoPUd
	vNRWpDsy1TEKp8xAbXp2Kr4w90gYt4xZIWf944qi9xWmSDZlZGIsuvghaEyyMpNK
	pzyS2g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483379sdau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 03:29:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56O3TN7Z011817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 03:29:23 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Jul
 2025 20:29:18 -0700
Message-ID: <91e59f27-27a8-4504-bacb-3e96ef1e6bbd@quicinc.com>
Date: Thu, 24 Jul 2025 11:29:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: slub: Introduce one knob to control the track of
 slub object
To: Kent Overstreet <kent.overstreet@linux.dev>,
        Harry Yoo
	<harry.yoo@oracle.com>
CC: <rientjes@google.com>, <vbabka@suse.cz>, <cl@gentwo.org>,
        <roman.gushchin@linux.dev>, <surenb@google.com>,
        <pasha.tatashin@soleen.com>, <akpm@linux-foundation.org>,
        <corbet@lwn.net>, <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>
References: <20250723080328.4012263-1-quic_zhenhuah@quicinc.com>
 <aICpMWKNvhveAzth@hyeyoo>
 <aqscos5ivap537qljhqa2pntrxfimfkfuflji62rl2picpvaiv@sams7xovbtn6>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <aqscos5ivap537qljhqa2pntrxfimfkfuflji62rl2picpvaiv@sams7xovbtn6>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4xXG-fDMPLxWGgB-1UeLjz1aPROUE_yA
X-Authority-Analysis: v=2.4 cv=btxMBFai c=1 sm=1 tr=0 ts=6881a893 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=_DfhJVbmsquJgjLii_kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAxOCBTYWx0ZWRfXx6hatoW5yu3x
 cbraOFVYkOvIPC49/IczoTvBlz3W9LNcClvgfKaDv5Ymos2TB4Ct0MDqSAFhfNF5ZaQc6xh2NyU
 3bIjmd7jzdNhMoapwuXBf/FbvGmMGmrxyHIER0HLottvsbBledePbp3Wzc9UK7Pm3VccMU8NZjE
 dTRfmCSM2svUUeMsP25eqRNl5jenxht+8O8VcwIAYsbB++RHTTf35H6b+It9OMrMIXjvM5HxVvv
 Cq2fKWGk7ugEZNHjx3B4MU+1z4OZ54dJ07Atr3uoU9IBWx3ifTwJY5FQupqTspQcj4rTk5JqeSS
 hDnGmrDhg1JHFiiE1s045LWGCzTUjma2FtWZzSHNxV3mahmIbcl0Ppb2jTSS9G47tVJ7x/RfEiY
 zpv4oCiDHGTSswtffzs8R+Z+CcmWCuXPvzFZpHjMIH6LYPo1DHHpyaaDIfi8VEGNey4GqEvm
X-Proofpoint-ORIG-GUID: 4xXG-fDMPLxWGgB-1UeLjz1aPROUE_yA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240018



On 2025/7/23 19:38, Kent Overstreet wrote:
> On Wed, Jul 23, 2025 at 06:19:45PM +0900, Harry Yoo wrote:
>> The subject is a bit misleading. I think it should be something like
>> "alloc_tag: add an option to disable slab object accounting".
>>
>> On Wed, Jul 23, 2025 at 04:03:28PM +0800, Zhenhua Huang wrote:
>>> Mem profiling feature tracks both "alloc_slab_page"(page level) and slub
>>> object level allocations. To track object level allocations,
>>> slabobj_ext consumes 16 bytes per object for profiling slub object if
>>> CONFIG_MEMCG is set.
>>> Based on the data I've collected, this overhead accounts for approximately
>>> 5.7% of slub memory usage — a considerable cost.
>>> w/ noslub  slub_debug=-
>>> Slab:              87520 kB
>>> w/o noslub slub_debug=-
>>> Slab:              92812 kB
>>
>> Yes, the cost is not small and I hate that we have to pay 16 bytes of
>> memory overhead for each slab object when both memcg and memory profiling
>> are enabled.
> 
> I believe we did something about this for page_obj_ext; the exact
> pointer compression scheme we went with escapes me at the moment.
> 

Hi Kent,

I recall that it used page flags for compression — not actual pointers, 
but rather *idx*. Since every page has a corresponding struct page, that 
makes this approach feasible. However, it seems this assumption doesn't 
hold for slab objects.

> We did it for page and not slab because page_obj_ext is a large fixed
> size overhead and the page allocator is slower anyways, but it's
> conceivable we could do the same for slub if the memory overhead vs. cpu
> overhead tradeoff is worth it.
> 
> And - pointer compression is a valuable technique in general; coming up
> with some fast general purpose code (perhaps involving virtual mappings,
> we're not so limited on virtual address space as we used to be) might be
> worth someone's time exploring.
> 


