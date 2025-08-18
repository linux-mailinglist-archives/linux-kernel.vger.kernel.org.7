Return-Path: <linux-kernel+bounces-773837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC5B2AB81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51D73A5B28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317F270EAB;
	Mon, 18 Aug 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X+/fQxfB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958A14E2E2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527242; cv=none; b=Dx8jfJ9xp3RojebaPnu77u2SL4hkQ/kfhIUxbmjOw+4XgYjfXLgpMadfC/yU9HXewKUMoKVeCdQ8xR202eodpreodF2CkWWhPPcH/7Xey4CoGzWHimDhQD6kTq5nCtOvvAkwKbOThiHqGkDjWGEL+lqUSAdAgGPe09uObGebnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527242; c=relaxed/simple;
	bh=wUFfWZPQ6+Xi6xURR/rzIZhf9zbhow+p5bYXIdENaNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eynm/TbF/23gvCzp5WzfuVxMc6fol2HS+FgwneiQSIMS6aE2vT3f1c4hPQsxJNjEbMv+PPztXwfKB3juVZuBaJH+h4IiVz6gWmOxKONquH3+o6NVcaYtQDfH/so291dNjiXJ1/uPYU97v9MHbmmJV2plyK3MytT9yP30hc9Enuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X+/fQxfB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8UcmF014629;
	Mon, 18 Aug 2025 14:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N9XTtPIlb1beSEhqR68lpF56qfXbGpzXDW+vo24hduY=; b=X+/fQxfBXTRDcjyI
	AoxW4bMMKA7nuLTn3u2JeX/TnS6zpuU5c/HqlSPO1dtlXJsgQeNigRSd4AjRocfe
	QVOjROlbMSbiGYjOjoyCzN2FYRGD7WybBPEuoIyd27BXS4xhRPKiZiuaPX0sd8xs
	VU4/Ic8uBniVF2Ieaw9GsLX3smQhQ5TLXZjAUAUfqVVUSgfQ+1iTHNbqGlf3Ve3Z
	TQwrxR4WgmB+59F7/q24mKCwpoMh9mpMXu99RbS4fmXhZKMgxzmyZnK/+/LQPdCc
	9EYs9cLkvox+RDIRGuWWQ2hmxOR4LHe2hJLDPaqA+lzqye5xqOY4SgB87mnu2HW5
	SwzXwg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh075279-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 14:26:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57IEQTGY017650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 14:26:29 GMT
Received: from [10.218.24.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 Aug
 2025 07:26:23 -0700
Message-ID: <ec37a541-0803-43b0-a0f6-aa3b632bcb97@quicinc.com>
Date: Mon, 18 Aug 2025 19:56:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Remove XA_ZERO from error recovery of
To: David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett"
	<Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mike
 Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal
 Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn
	<jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        <shikemeng@huaweicloud.com>, <kasong@tencent.com>, <nphamcs@gmail.com>,
        <bhe@redhat.com>, <baohua@kernel.org>, <chrisl@kernel.org>,
        Matthew Wilcox
	<willy@infradead.org>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <3970cd97-2e9e-403f-867a-3addfbe399dc@redhat.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <3970cd97-2e9e-403f-867a-3addfbe399dc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CVnTXHqcMte60tk48I5qtYhtMN12fvDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX0OUlx77pTTnV
 S0l6UGnrZ2CvWTs2XqQAQXAdJbV+CMBi1dZFhXoV12MyVHj/E2vxcftwtOi6bdgKGNbYHG+wIkR
 RqsOG7k3wdTXSq0kOEOHJUpnB2/mv/Tdu6J7OPW6VdM1R0XkXeD/vjJUnAPZj+7TuXQDloN7GgY
 gg4Edm5ztuZApPxqtlMP1r4HFS6AYOSEAuynM0RBvJM3vFeOQDum36FdqK/+SZo0O2HKmBZQLUe
 G8tYfL7jGHVURisq1rj5Qm/Di1cd3vL0jT1IXD02SGENOkEExqnGo+SvQUX2Y70qfFPDy6oHqHE
 zYBxFKtbaagMDevKZUeJ/UoRPfgnmsXC0ZphvKt8bcLc9VnCxpY/j/IoMeLEBVJ1Ig5cnecBb4p
 JBUB8Vcp
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a33816 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=XXfpJIKeY94Gd0witf0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CVnTXHqcMte60tk48I5qtYhtMN12fvDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020


On 8/18/2025 3:14 PM, David Hildenbrand wrote:
>> Before you read on, please take a moment to acknowledge that David
>> Hildenbrand asked for this, so I'm blaming mostly him 🙂
> 

Just curious If we can go by the suggestion of mm unstable check just
for the 6.12, as it is LTS.  I can't see this issue on branches earlier
to it. As well this patchset is not getting applied cleanly on 6.12.

> 🙂


