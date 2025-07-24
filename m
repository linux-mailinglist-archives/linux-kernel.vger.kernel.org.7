Return-Path: <linux-kernel+bounces-743503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7436B0FF63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E09961179
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B191E7C1B;
	Thu, 24 Jul 2025 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nMnycV4+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED88F58;
	Thu, 24 Jul 2025 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329482; cv=none; b=dNdkyf136FTUiwEpuQb41v17DvXNev0UxGjrYnaSlDEYI4l7PTXJk+lTb2ygtV9uj/PQDa5ksH2/NLEmLN/c4SX14+ylMRniYsWT/+pJp5YBUezBK+Hh22huHHny26q5/r/yQFvHlCF5XCyD/6hnUtwWL+AjV+42+/X+eeENNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329482; c=relaxed/simple;
	bh=2KP5HWqRgP5XPryEpjOZRF23TArJSMv/gQ98xpHLyV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sJyU2AfjJ+GA9ZGsc6MVQIxfFf4Y0i9tiJso2epSRFCsvjDCpZM5S1Vtq+RED1EBC5DdjICSi4XeKZJjzqRFMuIabiD7Hiennmcdy4ryL0iw2dW3jENuvMfdEqArTlFTLUs0xCIa3Y7yelxv0MS13ug65J29kXN4kdRX/x+NrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nMnycV4+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXHNC023401;
	Thu, 24 Jul 2025 03:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qsLQ1Xw+NK/R4axx21pMYKpruTy3n65vh1zbPLYMc4A=; b=nMnycV4+VYvcVd7x
	B3HY8Fe7c5Vo2heYWTCdBdH0qA8AX30VvV0+l2tuc8q9K7VM+kW7BVrmCBfjGZvv
	YqKNwlFY51gaCVSkthKwFJ7eFRYMiOkYrll0x+LrDu4K3VpVvJLU/tGaubcOj6e4
	HbsrJRl7SYxn/gAsXsxTUYi1iSGrIyKPnGfwdMhOc68DamU0//ypOCpFgoxxBNr1
	kyAtANE3y2FECAXKMyv2xXVl7vDl8SF3FaBAps1WIWia164aJufaKhNzYxpCQbY9
	2SAvTSN04EalkwMry0PHC1pahBdEms5n6XMjoa+ok+DZMG6dvgj0R6UuVs/qt3PK
	2wYvog==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na5sjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 03:57:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56O3vjUX025125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 03:57:45 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Jul
 2025 20:57:41 -0700
Message-ID: <95f2a23d-5ef0-473b-b3f0-c6d828cf8636@quicinc.com>
Date: Thu, 24 Jul 2025 11:57:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: slub: Introduce one knob to control the track of
 slub object
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: <rientjes@google.com>, <vbabka@suse.cz>, <cl@gentwo.org>,
        <roman.gushchin@linux.dev>, <harry.yoo@oracle.com>,
        <surenb@google.com>, <pasha.tatashin@soleen.com>,
        <akpm@linux-foundation.org>, <corbet@lwn.net>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tingweiz@quicinc.com>
References: <20250723080328.4012263-1-quic_zhenhuah@quicinc.com>
 <mw52yqm7wfe5afb5ybvfkpdgo4pm4wobmzv3um2cov3amekzmi@ye5drijf7njj>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <mw52yqm7wfe5afb5ybvfkpdgo4pm4wobmzv3um2cov3amekzmi@ye5drijf7njj>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ibrhzoPwiDxgwEc-hjYGwQ0bQQYAhE_F
X-Proofpoint-ORIG-GUID: ibrhzoPwiDxgwEc-hjYGwQ0bQQYAhE_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAyMSBTYWx0ZWRfXxSLH4MHihbTY
 6nxONS2JvJDaPQTVC/aS3NPXAmjMeB05zphsyVwpJjdaeIf0OtsuMebfhj8Z64RxoRCuKtmQLc0
 YrUEnVkP5loaTI76B1kO9EprU8fW1/JggaWAfGX7phKujUj3joo4aoaFgu5mpmA2X/6hVgfFtS7
 xgPzlUfJCN8BRRdXK+UdsqRtgDfF1iNWrxjIqZ1URlHwYhFiA3lvyg2ZVVTlGwsnTpx3OIoJs0J
 mdVrxLvYeTG5NBKw9WfWXl6PybbAtQGc8e3x0bvjj5czMiunHweeixNAyfgjOOBM22YwODE9xot
 GHsCBQ4ovDpiuGBGjEAfEgHRypi5mCSrSX8ERx0jAoszKiPtANmSO7EryzsU7JPDxF39Cr9x0Is
 SxgYh26mcNP+lunzXsoQbvY6RYN3PYp3WRxZiDtoU7XMofAB1FRZZdgum6q3qFB9LhRC+Hcc
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6881af3a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EcI5w910fGlJdbpBZL0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240021



On 2025/7/23 19:31, Kent Overstreet wrote:
>> While In some scenarios, we may choose not to delve into SLUB allocation
>> details if initial triage indicates that SLUB memory usage is within
>> acceptable limits. To support this, a control knob is introduced to enable
>> or disable SLUB object tracking.
>> The "noslub" knob disables SLUB tracking, preventing further allocation of
>> slabobj_ext structures.
> ...Have there been actual scenarios where this would be useful?
> 
> We've already got a knob for memory allocation profiling as a whole;
> most allocations are slub allocations, so if you're looking at memory
> allocation profiling you probably want slub.

Hi Kent,

Let me elaborate a bit on the work we're doing. Some OEMs are interested 
in enabling this lightweight debug feature to help identify potential 
memory leaks on their devices. In the past, we depended on mechanisms 
such as page owner for tracking, but due to their overhead, they were 
not suitable for deployment on production devices. In response, our team 
is developing a post-processing script(may need to parse source code as 
well)—to classify memory usage accordingly.

One output example FYI:
version: 1.0
MemInfo                        :    Size_KB    Size_MB
slab                           :     440088     429.77
vmalloc                        :      71416      69.74
pgd                            :        888       0.87
pte                            :     104492     102.04
pmd                            :      12732      12.43
pageowner                      :     437760     427.50
module                         :          0       0.00
kernelStack                    :      54346      53.07
shmem                          :      18284      17.86
KDA                            :     188516     184.10
anon                           :     867120     846.80
ion                            :     420576     410.72
kgsl                           :      70328      68.68
CMA                            :     130992     127.92
file                           :    2037140    1989.39
zram                           :     156532     152.86
binder                         :          0       0.00
migrate                        :          0       0.00
Couldn't Parse                 :         17       0.02
slab_alone                     :     478939     467.71

In this case, we may not need to dive into slab-level details. Instead, 
our initial focus should be on checking KDA(that is, pages that are 
allocated but not tracked by any statistics). In other words, for a 
quick snapshot, it's unnecessary to analyze slab internals. If we need 
to debug specific slab leaks, we can even afford to enable slab_debug=U.

The key requirement is to make this feature suitable for deployment in 
production devices, as requested by OEMs. The 16-byte per-object 
overhead represents the highest cost in its current form, and we are 
exploring options to optimize it.


