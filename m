Return-Path: <linux-kernel+bounces-688069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9AADAD5D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9E116E6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E5829826D;
	Mon, 16 Jun 2025 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nY4rYel9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EF296166
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069748; cv=none; b=AxMaYn8L4CK3YUMfk2JDCgNitVseoEEsnkRe1Mm7NabXEirozoVTqewBmYHC4Yq14rF4qGLHdHyEMXHOsvgfJyMTpn6Klz91VfWePBk6YkFNSRMWxyw2UGGrpEH4ZfQmAo7VqPwFifi/WZDmyxucINJWrCcP+KrvvgjN0LMukoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069748; c=relaxed/simple;
	bh=0R559xUsT6M7KLx9ml6gSoRr3yISpy3Slele4i01a4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=roJLKWXyCkiy4MXL9n10VxRMdn4APbnzDwLdHaEar6ghbVr2qlPfmWjRC6CgmIf5fGEZDNJM3aCVTyMwRmTDGj1va5DvYejN/VSNIBpITxaBzLljgbPO2D03vag1EAutGN+PoBHwEtU6kTT3O6XIh1/K0ui4si3It7bYLMI33e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nY4rYel9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8fFBq022895;
	Mon, 16 Jun 2025 10:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HJFxoydqfNwms4ix0SU8lhL5DJUXnQE0mckHnpvWwJY=; b=nY4rYel9ClCwW1No
	X1pl+QvuihnmFS7Bwbtej22gCEu2w+4blJuVxDh/vmPmCt42KjChFqcpSd63+VTe
	N3amWaUQ6qCxIyoKzITJVrufnzVErMMKZjRS++dXPOlYZwDcOIpwci2AMtE6jm8h
	Lr3CLH88p9CJ09F0s2kK1n449eSW4m5aUuSWFRwO0416rRZG57hm8PLi7bOqIzbE
	ffsoTrVnQdoYEmDxNteBQ+jtsd37WaHLbYu8wwoKVp6nzE9f2pvxARlR+i5jbOql
	XkMA5G0Vb2Dzq42krXnEUsqv5YBW65+6uW3Q7zDBkicombJyPg4aWRLPU643iYTL
	ZU6TdQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hcv4eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 10:28:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55GASZqU015512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 10:28:35 GMT
Received: from [10.253.8.97] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Jun
 2025 03:28:28 -0700
Message-ID: <3fe9e742-48ec-4b6e-9819-8e0f3e3dad0e@quicinc.com>
Date: Mon, 16 Jun 2025 18:28:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH v4 1/5] coccinelle: misc: Add field_modify script
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>
CC: LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        Andrew Lunn
	<andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly
	<joey.gouly@arm.com>, Julia Lawall <Julia.Lawall@inria.fr>,
        Kiran Kumar C.S.K
	<quic_kkumarcs@quicinc.com>,
        Lei Wei <quic_leiwei@quicinc.com>, Marc Zyngier
	<maz@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Oliver Upton
	<oliver.upton@linux.dev>,
        Pavithra R <quic_pavir@quicinc.com>,
        "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>,
        Suruchi Agarwal
	<quic_suruchia@quicinc.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        "Will
 Deacon" <will@kernel.org>, Yury Norov <yury.norov@gmail.com>,
        Zenghui Yu
	<yuzenghui@huawei.com>, <quic_linchen@quicinc.com>
References: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
 <20250612-field_modify-v4-1-ae4f74da45a6@quicinc.com>
 <77406d43-230f-4690-b306-4d698449c01b@web.de>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <77406d43-230f-4690-b306-4d698449c01b@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NSBTYWx0ZWRfX0trSX0jUlmbl
 6/Kiw2eqMZ+BaTUN2QnDoVU6PmcQoECUdQU/nJ0Rd2nbupFMdM8KE/vfTcoi6S/ezP8CF4fMOmu
 nAbdpUJwGCI8QXx+ejCbePe7SbtLchEX6GY4DQPisKkvTkzD471AK6Z98T0ZN+XfCaaWPoOxvNv
 7DSZG+Dl7/vDooXk9b070/1QEG8CKbTNcJXzvfo8/rVO9Pwctb8E1h4yZGvaILsWyrv44QjmEaA
 lBxRVfKemoD1a0I6TqeBob35qYuwSg/I6n8hJbupx28VRiuRYwBE1X70QteRfWvdloExMD6fDrf
 irkVboxpxihvVQUNFfwYQWncbL1nKp0w3f1P3b37Yw3UBxWvENx9YgL9G0vnCESWwpxA9CUXgct
 tEasvGlSEjadoj8S3qlBBg1nZGnTpeSodP2a1y8+jtOe0Qk31qhbXeSX5BPvfct07rQt7R8r
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=684ff1d3 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=AhEd9QK3q4IM9PeCSbkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R63nRGutN0gsMd22foqEZFrLFmuWrZDi
X-Proofpoint-GUID: R63nRGutN0gsMd22foqEZFrLFmuWrZDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160065



On 6/13/2025 12:48 AM, Markus Elfring wrote:
> …
>> ---
>>   scripts/coccinelle/misc/field_modify.cocci | 61 ++++++++++++++++++++++++++++++
> …
> 
> Did you overlook the addition of patch version descriptions?
> https://lore.kernel.org/all/?q=%22This+looks+like+a+new+version+of+a+previously+submitted+patch%22
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15#n310

Thank you for highlighting this, and for the references. A brief
description of the differences in this script patch compared to
the previous (v3) version were included in the cover letter, so
a changelog was not added to the individual patch's commit message.
Hope this approach is acceptable.

I will ensure to include the reviewer in the CC list for future
submissions, as recommended in the documentation.

> 
> 
> …
>> +@ depends on context && !patch && !org && !report@
> …
> 
> I imagine that the condition selections can be simplified.
> 

I agree that the condition selections can be simplified, I will
update it to "@ depends on context@". Hope it is fine.

> 
> …
>> +@script:python depends on report@
>> +p << r.p;
>> +x << r.reg;
>> +@@
>> +
>> +msg="WARNING: Consider using FIELD_MODIFY helper on %s" % (x)
>> +coccilib.report.print_report(p[0], msg)
> Do you know that a string construction can also be directly passed
> to such a function call?

I appreciate the tip. I'll update the patch to pass the formatted
string directly to the function call in the next revision.

> 
> Regards,
> Markus


