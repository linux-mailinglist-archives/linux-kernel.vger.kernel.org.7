Return-Path: <linux-kernel+bounces-747360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0876FB132F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33296172AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5AD1E8837;
	Mon, 28 Jul 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VIA7qPPS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026613D51E;
	Mon, 28 Jul 2025 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753669728; cv=none; b=ZTT9ZmT+eNEZ+g1jWGZJvAj75DUuMc6yFudHaTIoYkUUYxt/gGwJTUMXJy4DuZOLvyMAreZIlqgODQQStz2FpHYQkjyrJ72M/fpo/Y087tz/WDmelvfR2gXEQvNfFRAWs5YB02dQMp/jejkICT8toNh3wlOK8P72Mr27FYPV2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753669728; c=relaxed/simple;
	bh=04Q/IQbYaUnmsKtizhEjQMSpuc7k5isaCKweQiKd19o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhdWh03z8Z4+w39ho0mlTjF32ohVJ2QBKxawPoA5+okSGncBKX4V/g1NNa/rdo3I+uSxn3spCm4MgV//ObvuEC5o38J8kKpYFeCk9oOihrNFnD9FDYjskx30IX7K1xmMXEnY38e2Z1z/F/IkZS5+fSURyeW7J65kax3qvoRqwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VIA7qPPS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RLe2EC008006;
	Mon, 28 Jul 2025 02:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T7TBnh
	vwJxZeNQf8ohXhQ0QqduJYLe2O2CG/Agz1HVM=; b=VIA7qPPSZb+C0ddyy4VO4L
	siJmXW6XUpy4Rb0HqjlaARCXgfxm9lRAxWz6AxVLxo5MCnK0YjWj8/TCE/K+TI+v
	TOTZx4adifGF4kiXRylOFZTaiFQV0POqgv1Lhse5lXuMboaY0Y+4kHFceZ7W0oQs
	tMko4+s2ObMw6JvJtOxu2i52/uJtQo+A2+sR1OolsaDJyqV5DWN8ycVq8lqy6TzC
	eh6BqPH+f36MnKB7kdmhWy/VMBgt9IQ1XhlAuNw3vCXYA6nt+rbqji72W6aieDFG
	XtK88KKDQglPMrmU+JxqwaWjugC+xAp7NbQcogGp+4CfFFBBjH3UhasLHdfl8MDw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcfpk0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 02:28:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56S2SP9v010212;
	Mon, 28 Jul 2025 02:28:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcfpk0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 02:28:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S0LFpG018304;
	Mon, 28 Jul 2025 02:28:24 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abnuus2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 02:28:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56S2SOWY27525886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 02:28:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E404858054;
	Mon, 28 Jul 2025 02:28:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EF995803F;
	Mon, 28 Jul 2025 02:28:20 +0000 (GMT)
Received: from [9.39.20.72] (unknown [9.39.20.72])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 02:28:19 +0000 (GMT)
Message-ID: <8096841d-4d94-4b62-83cd-c35d05ee3626@linux.ibm.com>
Date: Mon, 28 Jul 2025 07:58:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: powerpc: add htm.rst to toctree
To: Randy Dunlap <rdunlap@infradead.org>,
        Vishal Parmar <vishistriker@gmail.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        corbet@lwn.net, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250727110145.839906-1-vishistriker@gmail.com>
 <5ac25ceb-023d-409d-8e7e-014d010c5028@infradead.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <5ac25ceb-023d-409d-8e7e-014d010c5028@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAxNiBTYWx0ZWRfX2vlYdEbACMBZ
 LsKk5O2Oq14Xq5WMK8i21bEOcDgR0uZ2yXtRUQ17fh90qS0LRuSKTC+7mD5X1+R/GfQLFHOymvH
 ll062xaKTarNIHODyX3IvtUhyfxOh17+iikh1Kfx/vkPUOb7KTW7m8iUjFkE1tSftRhet0p1Q08
 2tkx50uc7IuaAjG5MbLTXryB+KDfSoJU7EGFJ8qH1YpSoVuNZVzTaw6+cYyOKmHxEebl9o0o3OL
 CuKDURAahTSQI+XN5Qe+gu+5lDBsdHZfClhWdHVzPGYsdWPb6Qs4LSX8AyxHFhLvFh/TCWL99qd
 7JCBqUUSHxjC26oNfpnwZexPQGlgHBOOGFlznnbGA1BFaU4uVmRNF7vP7jVSRWGLydQ7ZUVwQYv
 paG7YuowdVKm+abZCP9DWQlQ8W23nR0ZpGHkHkHZoHVXVBlYPqQfKLU2itZf3rh+9pVia17I
X-Proofpoint-ORIG-GUID: bpvzLCELX4mmRrgOpwkDezLAMXBtoMQv
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=6886e04a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=80uqdGE25AKLF_4ApEwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 088rYj0OLFalEC5ah73O0gGUsJxtqgra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=949 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280016



On 7/27/25 9:11 PM, Randy Dunlap wrote:
> Hi,
> 
> On 7/27/25 4:01 AM, Vishal Parmar wrote:
>> The file Documentation/arch/powerpc/htm.rst is not included in the
>> index.rst toctree. This results in a warning when building the docs:
>>
>>   WARNING: document isn't included in any toctree: htm.rst
>>
>> Add it to the index.rst file so that it is properly included in the
>> PowerPC documentation TOC.
>>
>> Signed-off-by: Vishal Parmar <vishistriker@gmail.com>
> 
> There is a fix is available and scheduled to be merged (when?).
> 
> See
> https://lore.kernel.org/all/98a8a5ef-45fd-4b1e-a775-d1e1306ad682@linux.ibm.com/
> 
> 
> | Yes. I am planning to send it as a fix patch in earliest rc for 6.16.
> 
> @Maddy, does that mean during the merge window after 6.16 or as a
> merge into 6.16-rcX (which is now)?
> 

My bad. I lost track of this. I thought I did push this,
but then looks like not. Apologizes.

Will handle this as part of this merge.

Thanks
Maddy


> Thanks.
> 
>> ---
>>  Documentation/arch/powerpc/index.rst | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
>> index 0560cbae5fa1..173a787b6cc3 100644
>> --- a/Documentation/arch/powerpc/index.rst
>> +++ b/Documentation/arch/powerpc/index.rst
>> @@ -36,6 +36,7 @@ powerpc
>>      vas-api
>>      vcpudispatch_stats
>>      vmemmap_dedup
>> +    htm
>>  
>>      features
>>  
> 


