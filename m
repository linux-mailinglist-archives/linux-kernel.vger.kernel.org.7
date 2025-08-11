Return-Path: <linux-kernel+bounces-762255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA7B20419
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B153F18C136F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820822D8798;
	Mon, 11 Aug 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NDDhxQz4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7D23B610
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905439; cv=none; b=cvrjC7BnWsDJ17nyMAMM80dDAFuD6oYmPwAVDSSOy0i8iKHLvTDpKW8W2kBsknmt/9ywOZI2aWpwiES/hQLF19nBevRJihRSQWUj4iGIiTUdDPNHqqvaopalnwhb3b82JBKRcr+buQtVoHDz7CCUu/tqPs0Hyvz5cgFehfgyOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905439; c=relaxed/simple;
	bh=Sxnvn1L0u1cdREZGo+HUE8ZUYQoYn3+f4oVXxkukJtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MooxBCTAfWPliyybUbQ+Ab5V6MFAqDAw7M8oL4aRTQ6oF5O5005QFWcjVXGJlDgldKLu7hN3eLfI7RSCBBXmIKuREY42e2xUws7ednuZaYFcI9cm+PrpXNVE7WJraX/0HHu8k9MJRJH2AMGCsBVlkOmI/6dpa54tSM6rENTqqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NDDhxQz4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d8xN019036;
	Mon, 11 Aug 2025 09:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lUcwRGg0z+w2vYeXxV6IG+A/Mtt9R+8aJIYLQYOBRnE=; b=NDDhxQz4yIjrPIRx
	vT2VfVSfXVE5q1OcmkIRvXR/T9+jX3gR2A90tnEGENt6cYK7cKsSr7YgyS4fqM5A
	NgiVrxmmKQnPy+mtNwsKsaPYW+uq/nrcY4uIObH16qjJ9htEB+Dp+0EOx9jKOs+Y
	cTziZ5uv6LzQHsg2ge8czRtjkgLUxfGDAwkpFMvVmxdQcNidKL0h0bprjAch67c+
	aE4/snQ9yvUlU7rQMCvr69MCq37RqgFowt/8NgGbt3MVy1JOFJAWOikpjn7H6OW7
	TZ380/snhllH6Wbew8B7+pNeV35vz0jC7mKOMPvvhw+qN45wcJcWTbyjRIg6b5GM
	p/tV5Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduuuj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57B9hL7B007780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 09:43:21 GMT
Received: from [10.218.24.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 11 Aug
 2025 02:43:17 -0700
Message-ID: <29e080fd-5f9a-4760-876a-a6ccef33129f@quicinc.com>
Date: Mon, 11 Aug 2025 15:13:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
To: David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <shikemeng@huaweicloud.com>, <kasong@tencent.com>, <nphamcs@gmail.com>,
        <bhe@redhat.com>, <baohua@kernel.org>, <chrisl@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Liam R. Howlett"
	<Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
 <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
 <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=6899bb3a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=wi6Mpm9A1vgHMwsftUIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RpP4wT7mu8o0-CCJ6Sq7-VwrHMkEoVEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX8NmacR4wshHU
 H9cNnSHTNCJVPU298FG/utUGnx2mKnp6jA0z6GIsa10N2+lKDre9USM5gmEGmWcMU3kjA0HUri5
 MLsZ+Ytz7iSWV1A7baBkwjDa5Q+5pEQkEYH9GNPVTxDUWJlSSP+fM6BO+Y+qO59xRUNbNwBS3nU
 nmgyqLQnbj6awPfz91v05UcG4PBDoQzeWNjbib+tMAymOUn01KoGteLamakarWej9n6FpCYaCbP
 o68OfHyJ7aUf6GaXXNfol9DdVjyiGUpugNiKJE0XCHLKuh20fJS5Wo2tGWgzzr7mPb0w8a6gyNq
 v0qtkFPzy+dsJTSfDApDU5ik+dEm0dznFsKi2rlj8WzgBqkh5p/ejtO6g4twpgCYW/L04/x8v6f
 dYNKwNqw
X-Proofpoint-GUID: RpP4wT7mu8o0-CCJ6Sq7-VwrHMkEoVEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

Thanks David, for the reply!!
On 8/8/2025 5:34 PM, David Hildenbrand wrote:
>>         if (mpnt) {
>>             mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
>>             mas_store(&vmi.mas, XA_ZERO_ENTRY);
>>             /* Avoid OOM iterating a broken tree */
>>             set_bit(MMF_OOM_SKIP, &mm->flags);
>>         }
>>         /*
>>          * The mm_struct is going to exit, but the locks will be dropped
>>          * first.  Set the mm_struct as unstable is advisable as it is
>>          * not fully initialised.
>>          */
>>         set_bit(MMF_UNSTABLE, &mm->flags);
>>     }
>>
>> Shouldn't we just remove anything from the tree here that was not copied
>> immediately?
> 
> Another fix would be to just check MMF_UNSTABLE in unuse_mm(). But
> having these MMF_UNSTABLE checks all over the place feels a bit like
> whack-a-mole.
> 
Seems MMF_UNSTABLE is the expectation per the commit,
64c37e134b12("kernel: be more careful about dup_mmap() failures and
uprobe registering"). Excerpt(s) from the commit message:

This patch sets the MMF_OOM_SKIP to avoid the iteration of the vmas on
the oom side (even though this is extremely unlikely to be selected as
an oom victim in the race window), and __sets MMF_UNSTABLE to avoid
other potential users from using a partially initialised mm_struct.

When registering vmas for uprobe, skip the vmas in an mm that is marked
unstable.  Modifying a vma in an unstable mm may cause issues if the mm
isn't fully initialised.__

> Is there anything preventing us from just leaving a proper tree that
> reflects reality in place before we drop the write lock?

When you mean proper tree, is this about the your previous question? --
Shouldn't we just remove anything from the tree here that was not copied
immediately?

Anyway, would request Liam/Lorenzo to comment on this.

Thanks,
Charan


