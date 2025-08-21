Return-Path: <linux-kernel+bounces-779009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB9B2EDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CE71BC67B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2153D2D3A86;
	Thu, 21 Aug 2025 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c5bl2M5W"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65691D6AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755903; cv=none; b=e/8cvL9UisZl8moIjLC1/+shfk+uWPmND7zviDQKJMcbIBVP/WyOJSVFgOfH8pGg9/vLgVCLGXysryV3EAQSGV2rDrN93McncSba2HrhjBWFK7eEyAePmRSpT7chdRFGi/0p7teY5gUBgDwoVaGIwNZUnanWrY8j6zFEMa69O0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755903; c=relaxed/simple;
	bh=ejhiXdkuGJMlYAF++sSm5Ryi0diZPDstltfA+YiA7tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z95HfDnYmCFIocc0RhXYRz3NLc0DE2mLURp4RZinXxjA2LDutr1Kdj8E0i3VU767xBworPrVChtrYDM1FZC7KrZljHU4yA72CIyLEBW4+aYOgp3loquEkl3u0ORubGi9EZn0qyXB9C8fkQCjLNd8hVtWca5+kmvTy6TIrf7BIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c5bl2M5W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KMlurg026121;
	Thu, 21 Aug 2025 05:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yYaJtc
	7RuvgY1Ra8B+ajTl2nOuAh7H9zsChrSAlPBv0=; b=c5bl2M5WSzuyyqYu0NQSHm
	pxPEB9S3oL+29JI3Sjpsb7r3rwu0MK2OxjsM2CKYjby1O9yoWOkbWgOrYu6nA7n1
	L7Los9AwvKoPc3lAx4yHyP5MgLjTTa7/PPMxXyZpgx2zHq9n4rIUjGc2QV/ZxV/j
	weCKemTKu/pW62KP99tODI6XBDZi/UMJgj2xmtgLtXqlL5EhDz1sMjfJmCpHlZwJ
	SETVZ7p6Nz/j3wN018JzheKVBTbaBaFMLpJcZ4s7sTZNkGT/XbfOQSwrlOxYTvwH
	OPHc4t6Z43oDWBv4A4K8pXf38cVDJGPN8QQm6AmUdbTt3MXs1cgc1+W70GoqgKiA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vev1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 05:25:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L2hwtG016038;
	Thu, 21 Aug 2025 05:25:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my426r80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 05:25:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57L5Pbqk19530240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 05:25:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F17058056;
	Thu, 21 Aug 2025 05:25:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 353A158052;
	Thu, 21 Aug 2025 05:25:33 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 05:25:32 +0000 (GMT)
Message-ID: <b8156bb1-b7fe-4036-9dbb-98fdcec3ff65@linux.ibm.com>
Date: Thu, 21 Aug 2025 10:55:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
To: Keith Busch <kbusch@kernel.org>, John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, martin.petersen@oracle.com, djwong@kernel.org,
        mcgrof@infradead.org
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
 <aKZDRrfUTxJoFA1m@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aKZDRrfUTxJoFA1m@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXw8zxww9smSiF
 pN80EtrZVprrZOl8SgTAkDo+XM1Xa0sVE8b0j5a5RXOuZrJ8yj+n7KyNbwySdv6dEpel03H9HEK
 4vR37rUfE9fNEhEE/vq6NXA9cSOOMnkfz29YoBB/kYgdms2fJ56YMLoZMmLTSUd3AkrrAnaHXB0
 jQz9gQtvixthLqh6zYkUCuMfq7onKipBwPZGidJ9+a9cNlTL5iPqWEg3elJceIa5L+ZM4VEQaTq
 RtrY78wYrSvDwQGkz3McvOpVqocUnflLkwOqpxoRpBMzUlWjpM03WWOrQASde2snr7d9/QrtZGa
 7OqCYi2Bb0nAxJtwbnbeaVKz3oTjS+zwkHtiV71+RMfknBcOYBfKyzBsZrotQVIprl/4oWRIFdL
 nD6jROKL4JScvGuebrd/9mV+Q5zwoQ==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a6add3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=xiRpjWrZGW_SbaGU0d0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: FdsaARlXUgnrR_MZ-4H1Ngj0Qr7UKuy0
X-Proofpoint-ORIG-GUID: FdsaARlXUgnrR_MZ-4H1Ngj0Qr7UKuy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222



On 8/21/25 3:21 AM, Keith Busch wrote:
> On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
>> It would be preferred to stop honouring AWUPF altogether, but this may
>> needlessly disable atomic write support for many "good" devices which
>> only specify AWUPF. Currently all validation of controller-related
>> atomics limits is dropped.
> 
> These "good" devices that only report AWUPF, is there some set of
> characteristics that generally applies to all of them? 
Yes, I know of such “good” devices. Typically, they report a consistent
AWUPF value across all controllers, and that value does not change when
the namespaces attached to those controllers are reformatted.
As we know, though, validating this in code is difficult. A past attempt
to implement such validation failed because there are disks in the field
that do change the AWUPF value when reformatting namespaces.

> I tried to list out conditions for when I think the value could be counted on here:
> 
>   https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/
> 
Regarding the checks you listed, they seem too restrictive. They only support
AWUPF for single-controller devices and for disks that either have only one
namespace or support formatting all namespaces together (i.e., do not support
formatting individual namespaces).

> I just don't know if you know of any devices where that criteria doesn't
> git. If not, maybe we can work with that without introducing more user
> knobs.
Given this, IMO, an opt-in approach should be considered, letting users
decide whether they want to enable atomic write support or not.

Thanks,
--Nilay

