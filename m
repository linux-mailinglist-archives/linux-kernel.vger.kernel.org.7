Return-Path: <linux-kernel+bounces-845673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B99BC5ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C41420F0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CB2F7AC1;
	Wed,  8 Oct 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LAsO6lpa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C402F658A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937871; cv=none; b=mFMPlDfeOcbgOFAPVkow1Ww8dzG6krAVuh84pHfVVSTo/qg7YzNxTRQGuQvcQIYKiUvK6G7zHokCVt/iM2xKkVwTPIsjeYNZLUUE1eLvUI4QylLhnFW24QY4bAiWWKjOZDliLhU/M0zmCRU4VgOSXd9RH9NVIBjKF7qjKF//9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937871; c=relaxed/simple;
	bh=KlHt5XQeGRsL2MzJqjJiYmZ7o2G1WppR2KYmO/pQOzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAri7DuwxdMQO1/rjKDiQkQTeUfc/qhbg2JBQn+6U/vY8jggkOopTtDHuYjXPc45qrBhTeZOmM8b8MN4wiqAnT8ba3G4EAc/bfOKKN5JE1EvDlTiMAekzhmBvMRp4BMmyqMKa+EdSFmd0Koc5aXw3voa0ldGqszO4IZ8lIWhDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LAsO6lpa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598Dmp2Y005709;
	Wed, 8 Oct 2025 15:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bb9Kcp
	+SuQkcJvL73IGi/JELHqGZ6mZxoBcn0YJUzaw=; b=LAsO6lpa2vrOBh31GPJgg+
	QBjHJ1fc2bNbAUJlxmBvWddfV7+M2e3XUHFs9kXh8YCV+F9UtEsMkmrIcHBjSHnX
	IyOekGDs3qqrm3uRAr3XwOapxA1LuYSwkmxpuW+Vb1xqzWXAZsLMCAqquWoapH0c
	9rZN9BCMqyFCcyYbyu/MF8JImTtcF8vD808eTA4AFQOY7eSn+CN/oJwjDOppFEIa
	wc0mugwHhKRXU7TliY/ey5Z73gy9/NoWP28VG0ykIPqM6/UQqoYDT0OyiW+q5dH4
	MGgM8ak77vjtA0jOiPB8erp72SpiTnoqN35Kb+U20gIzxOhPw2xefPt73qPVO+GQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju8aw7xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:37:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598EoDon021221;
	Wed, 8 Oct 2025 15:37:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kgm1gw9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:37:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 598FbgWG29622968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 15:37:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5851E58066;
	Wed,  8 Oct 2025 15:37:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C90F858058;
	Wed,  8 Oct 2025 15:37:41 +0000 (GMT)
Received: from [9.61.26.35] (unknown [9.61.26.35])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Oct 2025 15:37:41 +0000 (GMT)
Message-ID: <b1f1ae25-4adc-40e1-94e8-ff004c796771@linux.ibm.com>
Date: Wed, 8 Oct 2025 10:37:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: occ: Update response size to 8kb
To: Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20251008152157.1387182-1-eajames@linux.ibm.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20251008152157.1387182-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Agm92PdpxzNWuhmIy_ZPUzFHRcnT-8GM
X-Authority-Analysis: v=2.4 cv=BpiQAIX5 c=1 sm=1 tr=0 ts=68e68548 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=e1z_xrLAd5A5IXzM0sYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX8/Rxs8QJC9FA
 07cbLmFnogy0NXywMJrBVDUBbs9zZ9rrq8Yc3gK1cxU+koN90jy2Ug+wJhydAKa9tKeWLQA/V4/
 m4Wk30EzfNJDu9i+vj28kPS8uGmVWHZjz+fSBi3mzKKOKEEn5K28naifBk7s5plUN7oYokaabqI
 cePTFSXimU4AssjQqzhHAmAcOHz6bKnWf4JbSBipFdeGmM6zRUtgSRJl/cWIshk6qS2PYj0hT0W
 jbhmrDgLzpR7YbWeAnRBojBkSrRvtXnZmcbIMoqrISjCnkfjs2VDr+1rv4JDqOKVPpr0my92qoX
 2hwLgiT2EjMyi4w6s8Xn3BWYeVoeuw+IwLcMwRRsqbn6GUr7fZpp/o/NeRbXXUH1tl6Er+qsDu2
 4Jua6iYz5qicOYfCw/NaaCoQosmjFA==
X-Proofpoint-ORIG-GUID: Agm92PdpxzNWuhmIy_ZPUzFHRcnT-8GM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040022



On 10/8/25 10:21, Eddie James wrote:
> Newer OCCs return more data.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

-- 
Thanks & Regards,
Ninad


