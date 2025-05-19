Return-Path: <linux-kernel+bounces-654321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD0ABC6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819594A593A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CA1F2BB8;
	Mon, 19 May 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hse0VHlA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527C1C3306
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678072; cv=none; b=aQpGyCcIs55fr8gl6tnDmpUg+rmMjWqYeBsFehWSlEtkYYg8i0uwOYGxoVJiBLo3oGezq7ZrMgYpZfN7/SFEgqNf9ErtDLpRBFmx3ElS68CuO2n3DTuub6o4LuCM5v9iMLMEbKWhBavR52SNyPyeKTnadKCJGkKLRnL8Lxmmi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678072; c=relaxed/simple;
	bh=TVu6Ue0+tThI4wwiN68DTgRJxBwb2V+yzajqnxj7Xc0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ud31aVDjhhMIkqmv++SgwNzfmjksCCjV/3m8+4UcWiPuGUUcLHMGDE6IPzKjWx6x/XEqTbeu0kQTJWLi2b09/bY/jCfs5/YJEjD/nfdmF9aTnBAAEvINBtAPNoDruUTInyPJVH8JU+9yh5NT0+7ADBdFF9wpdnCNLYCZFW/ioSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hse0VHlA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFQ9vj031505;
	Mon, 19 May 2025 18:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ynTozM
	TkisgWm7nLVFPVfSuICeiaDry/u5m5nFTRhCQ=; b=hse0VHlAxrCKal/Re3pBAL
	fGX8SVKxGOvJJeoYmqzR+U9C7FU4NVHRFV9YhLzvGRAdlf5W+E9ESXRXxPbHMNBg
	fFSQvF0ghDD6paDP+h3NPIS6FvWzTABC+PwATUidobKKkiCWPHDXwex98k99SgsC
	m1yDQ0SrwPxT+hjBf4UzIxdDfpDeQjyqvwoKWmbf8ZqpI/LvurFrA4wTjh+vdSU6
	MB8JdEkaZu/uQ04pD/7KV4nXRGZ+GNozdzGv2NGPbfDyW4061/nMXo3S0BEaTY8k
	oYYXT7D9UDo2OgP27KAWG+jsuy1dIl2/gRU23bfgU6aUXq3oTH3p205udLl06NJA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qn68na0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 18:07:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54JHxlmK008758;
	Mon, 19 May 2025 18:07:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qn68na09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 18:07:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54JHBDZj030098;
	Mon, 19 May 2025 18:07:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q55yr334-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 18:07:16 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54JI7F0T20841104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 18:07:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D25A58055;
	Mon, 19 May 2025 18:07:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45AF558043;
	Mon, 19 May 2025 18:07:14 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 May 2025 18:07:14 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 May 2025 23:37:13 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ritesh Harjani <riteshh@linux.ibm.com>, yosry.ahmed@linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG][powerpc] OOPs: Kernel access of bad area during zram swap
 write - kswapd0 crash
In-Reply-To: <6r6hex7p53bsbaje4u7so7tfsz6jemazerzujzraibiah7eq4b@m5vgjaff2cdz>
References: <89bfdedb74416156423d36d28c5b92e9@linux.ibm.com>
 <87ldrujhr5.fsf@gmail.com> <3374b7cf6a68364c389a260d7ec9067f@linux.ibm.com>
 <6r6hex7p53bsbaje4u7so7tfsz6jemazerzujzraibiah7eq4b@m5vgjaff2cdz>
Message-ID: <29cec5ca090a1b833c6a68d103ef9e15@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _fj80Oq0bAsyCG92_EMOzTZw27KKKfMK
X-Proofpoint-GUID: 6tsfe39TkC4xcpBIw-_ajd4QhVuq24I7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2MyBTYWx0ZWRfX9Cs51r9TPd0d nksTwKvgORZ7YCfcoEDvqeI6EImOm0pshn79iq7bqdeYeb8MbHh23469hQT++X9YK3jB75eVX37 j1x4v03fK1hXutqI+YVVdouU0N2QIHHY5/R1ZVIK7XwPJ7eNrRmwK89A9EGXdK7tbUts254L+X5
 zJazLoL6vVz6PZ//4dwV9VKy+a34AT5sLIq37mKwvjM3S9rJdlMGR0nAxXoyJ1q4lkJ3M1E+Bl4 rYC11ZaKNnGpP5IJA5xcTBrcbhyMuDVrYSMM13A5hMTX37xernd92PFKBu/2nducXp+3BdxkQdZ x7qnRlOhICzRKibqbMd3G3x8DRu8DwCHV8LyGFKH9jIlk2TcQ/MERV/+YmjDJZoMyigoX/afY0R
 uaZuxnwhW+G9C79vvp0QaioI3Cc5BbtlMqDhjDOEDJWp2DNUIIbPtqRd2lf9owIP7Br8yZMa
X-Authority-Analysis: v=2.4 cv=CN4qXQrD c=1 sm=1 tr=0 ts=682b7356 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=JK2cp3ES9FE06y1yGSoA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190163

On 2025-05-07 06:03, Sergey Senozhatsky wrote:
> Hi,
> 
> On (25/05/06 11:09), Misbah Anjum N wrote:
>> I am facing this issue even with the latest kernel: 
>> 6.15.0-rc4-g5721cf0b9352
>> The suspecting commit is: 44f76413496ec343da0d8292ceecdcabe3e6ec16. 
>> The
>> commit introduces zs_obj_write() function.
>> Link: 
>> https://github.com/torvalds/linux/commit/44f76413496ec343da0d8292ceecdcabe3e6ec16
> 
> Can you try the following fix
> https://lore.kernel.org/linux-mm/20250504110650.2783619-1-senozhatsky@chromium.org

Hi,

Thank you for the patch. I can confirm that it resolves the issue. After 
applying it, the kernel panic no longer occurs during memory reclaim 
with in my KVM guest testing environment. The Avocado-VT functional 
tests now complete successfully.

Patch:
Author: Sergey Senozhatsky <senozhatsky@chromium.org>
Date:   Sun May 4 20:00:22 2025 +0900
     zsmalloc: don't underflow size calculation in zs_obj_write()

Thank You,
Misbah Anjum N

