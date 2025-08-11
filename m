Return-Path: <linux-kernel+bounces-763234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40CEB21218
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A224E3A4760
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA6221267;
	Mon, 11 Aug 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RZyKPJdh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB041A9FB6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929829; cv=none; b=MmzoiXWqBZNIPQIRAuHI7Z/k42IoIWM5PeJica1n/6QvqOOjh2FiFiNFpggz+/JfoE4I92IayWePfZ6uVC38SN/qU2m3a7A8i4F3SmSgMRKgBkfEQz6QiZ1H8zzRHYlrp0SDRxGDgLimY0UzevKTrpxhRDIlFKaXjlOJHLRyOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929829; c=relaxed/simple;
	bh=nLwFsXXmcF4CWKmWS1PZk11GRAQpaVXy52auHJdDnHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vz7bIMM+hHCFPSBVUvVB/trXo72FtxrxJt6uHvdWXqIWvD5iknDRddxOFrGNoIjBfTXOuJlsZFEmKP5daII9sot9cS54rRSM6cncLoYz6oVTplS/F0ubVFDBNADxVqF1uQs6IZkjBoPb/JklhGdESYjLS/4RqA/CQHKW59E2aE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RZyKPJdh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBWOV5007754;
	Mon, 11 Aug 2025 16:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HlMP3HUL6Cc8PMyjMVeTRfAvfp9gV/f6PuorDrC/x9M=; b=RZyKPJdhen1V4+Hr
	zW2NEPk4jQDgQ7MYOS5fc1lmVUVeFQWVbb20VyG60DZl7yVnWonD3XNH4BNO6JBl
	yiFFK8qRpZi6wTqEhSZvIWV98cIooL+0rPy7budq1lz4Y8F9KWeRtkRn4QvmyD76
	QsClMxdjqCCKaNZFTvnewjzKcij2PiTyF/d2LW1fIgaM21+WCEl4YEHAAqahFJm+
	uPdnW6WoCTVdtXaDGmXo3iLUxAuTE8euMbCJhEE1+GfOfamrFUfsbfdkfOrp0C8s
	v9jyPQhqsuQXrLhKB3jRXy+qBoiaiLsepYhq3nz91/f8g2RORx7S3/M+nahKFLuE
	0RGXww==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6gx3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 16:29:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57BGTtYc030278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 16:29:55 GMT
Received: from [10.216.45.192] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 11 Aug
 2025 09:29:51 -0700
Message-ID: <25f6b30a-75fd-429c-ad3a-29cfc3a677a8@quicinc.com>
Date: Mon, 11 Aug 2025 21:59:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <akpm@linux-foundation.org>, <shikemeng@huaweicloud.com>,
        <kasong@tencent.com>, <nphamcs@gmail.com>, <bhe@redhat.com>,
        <baohua@kernel.org>, <chrisl@kernel.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
 <46d4a5bb-5734-40b4-a5f1-3094500ef1c3@lucifer.local>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <46d4a5bb-5734-40b4-a5f1-3094500ef1c3@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX3cOyk7cOWaNP
 X9O6YD0qm4tN42PMd2cVWr4rmsRn728khHrJMWs/qobrWaMvg4RtLXsudawgppGwIfXcLYEMTDs
 KnJgyKSAszS0V0IekerdkFlSTN99leBMVSw8npoeg96NEoLSoHnIK3u2IiPt5XjYWVk1to6e/Wm
 OUV+h0+nzky3WHvhSC8TQtVBrgcl17/6MIgzxwGyHlsA1T9y+BziezB4rO9RorilhzhU64s+5t2
 GSiQawACZX9kw+8zg++Ru1ZBl32Yq1KnYG5s3iScUlYZfYPIoSCpr721dCqXJJJFZnZZI4W5PY8
 MP+sENMEGy/NXlmfHIeTcC+PSP83FfB21witL+OVFBmA7W0d2i7H+4vFVL4cM17ZxmZwNzMnxfq
 4CBQW2NC
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689a1a84 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=Eu7-4bY5xJMfsWnsbBEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
 a=QYH75iMubAgA:10
X-Proofpoint-GUID: dgL5N7pKdAMMncEIiKUWYf5ebzNIeq1P
X-Proofpoint-ORIG-GUID: dgL5N7pKdAMMncEIiKUWYf5ebzNIeq1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075



On 8/11/2025 5:37 PM, Lorenzo Stoakes wrote:
> Any syzbot link or further information as to where this bug was found? Was this
> on your system?
> 
> Has this happened in reality or due to fault injection?
Sorry, missed to mention this information on the commit message.

Yes this is really reported on the 6.12 LTS kernel, while running the
tests on the device farm, though, reproduction rate is very low.

Thanks
Charan

