Return-Path: <linux-kernel+bounces-706250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A117AEB425
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 12:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12C03AC478
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FE029992B;
	Fri, 27 Jun 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R6lC6nTe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1D2951D2;
	Fri, 27 Jun 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019376; cv=none; b=a8bwRUH50xGlo6ftUhF8mlu1UjEim7nyQArxs0FsMQx8Vm93SWR3JGAQZ9kFEmnmrT8Zr0p8H/ywyCnb3njhXTCXB/xzTEAY4E/xzg56N0ZFvXekoja6GH+or7wNrDB0mA9ui8m4fZWG7yURe3HtlLzjSMWvGr56OMjnj6hmCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019376; c=relaxed/simple;
	bh=l3MXeCKLCE4V4WDL1a0YYyXD7TdNstvMiK4jATH+ZFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W4rZUmetz2HSP7ZIgkMUd+1xwLOeSMBhxAvYikgCbkIyPgOvDJsjsJX1vzjyyrz/8mQG+vHtX2FgV7tPJTSkh0F91TZBZNwp2gpatU9Vqq0CJ0HzIpxm+DKjogPo9LzqrGHzv0hO/VTucyQdWLtqGI/Fr8RhbAbzXy/6f6gUqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R6lC6nTe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4DAeX011315;
	Fri, 27 Jun 2025 10:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ej6060Px8LTJFEpTirXrl8cNCe5SgWbJxsnR8+8uv+E=; b=R6lC6nTeGa+JGYTl
	Xnk2A76x25ZYQdo2wGnHYfm0p/yuLl8SIH1D0WjfUAmLAVbOH451ywxtFfwgZE04
	yy6P669SJeBSctkwJvhTQBo9eYzx9nzGFLQU9bAQAHLqO6Zn9KrmUjBglNgo5Xku
	Bt0JnXhyP10W5rMleSC2sm9NEoYOnKsEsRtiHbkBgTAqjHE+mnXKtgrqADd/VUO9
	XH3+50T+YXc9LCK4LSVVKqb74bpVlYKgjTJ+Y8TJc4TMPYOgslBoFwrmrOE4b+QO
	FyeLmrUfGD+5/KrZBYNNLAJ3vZQWagBXwnbHL0mOYSEs9S0kGAJTJmkvhatU1eb+
	q2KuZw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgpdvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 10:16:03 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55RAG2NL021601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 10:16:02 GMT
Received: from [10.239.29.49] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 27 Jun
 2025 03:15:58 -0700
Message-ID: <9fda4c17-869f-4d2f-930c-01eb714d68a8@quicinc.com>
Date: Fri, 27 Jun 2025 18:15:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: misc: qcom,fastrpc: Add GDSP label
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <srini@kernel.org>, <amahesh@qti.qualcomm.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <quic_kuiw@quicinc.com>,
        <ekansh.gupta@oss.qualcomm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20250622133820.18369-1-quic_lxu5@quicinc.com>
 <20250622133820.18369-2-quic_lxu5@quicinc.com>
 <j2nni4oyoochjgw5w7vodxnn562vff2krkesta6zzgqs5ihvcx@5up7ga7k4gdl>
Content-Language: en-US
From: Ling Xu <quic_lxu5@quicinc.com>
In-Reply-To: <j2nni4oyoochjgw5w7vodxnn562vff2krkesta6zzgqs5ihvcx@5up7ga7k4gdl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hu4jpJRLnpK6e2srN_MY5S0P_fmMZo-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4NCBTYWx0ZWRfX1LboU4UUFUj5
 XOI3yHZfTc2OG7YczfauH9Wik6KdFSFIlcUq9E7KztqpvdlqTlKj7DBPoIfJf1WZE66y5kSnRDY
 PDaSENDL+0z7iYNhJvAu17y1SdGTiJnXV3c0ZEoI+7XKkWns6jxbQSE2lvDIrXSZF2ILx97XhZt
 OS6RVEqizXhBofj+sCYrN5ZI+ZvYRd6Hswhb8QYUPw6fWDZ0NxWnkdRkTCMOPtAMjZIAUQqCR3f
 JOe5797ZLI0+ojyxZo4F/Ruro2VHkfPoksGwar9UNd6e0tlWZIYO3vDa+bNIer7f4nOKhkdkUiB
 9u+KobwBB9QM62MOkVSsqqU7XWYjeLffqkEi5KfzbYB2Z2aBToIyyD/zrnA2BTcZaQJGVplxuON
 xhKPl/LjEUDrNCS6ZRwBbxtf2yg5CLxharA3ZAvwHsy5MVTqgjCJihSz1lCoLc8eZG2acaVB
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685e6f63 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=5KBTReNGNWZAHrgyXRAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Hu4jpJRLnpK6e2srN_MY5S0P_fmMZo-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_03,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=864 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270084

在 6/25/2025 3:44 PM, Krzysztof Kozlowski 写道:
> On Sun, Jun 22, 2025 at 07:08:18PM +0530, Ling Xu wrote:
>> Add "gdsp" as the new supported label for GDSP fastrpc domain.
> 
> Neither this commit, nor second nor third explain what is GDSP...
> 
> Best regards,
> Krzysztof
> Okay, I will edit commit message in next patch.
GDSP is General Purpose DSP where tasks can be offloaded, and it includes GDSP0 and GDSP1.
Analogous to CDSP (Compute DSP) which includes CDSP0 and CDSP1.
-- 
Thx and BRs,
Ling Xu


