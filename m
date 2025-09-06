Return-Path: <linux-kernel+bounces-804146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34DB46ABF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602F67B1C3A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D32C2368;
	Sat,  6 Sep 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rg/+sDe8"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B526CE0A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757153265; cv=none; b=QQY8OEjZhzNEDJy1rRKqrqb1lV5nONxXrnLgIEUcjEeLt32diKLv19e6ILjuEDllS1uN5d85SHDj5rC+MK69vlYjg2v/ybKWbujz+Wu/Iex2NvjtNhIng5W+iK+wMR75ZRIF1WMlTshiWUoJ2EU7z08VhpXuRrJvQG1/QkXBe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757153265; c=relaxed/simple;
	bh=KRSayKcedx0bIsdNnwygqwYv9WhNvOjilcVdXVvaAaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THqlg0BpLk93VmHgo8aXkTNp+c51UoV4preXOjxhLt1RSRNQzWN+g5pKOeQOnGZoyCaRL5xY8PZdW2acr4tIl87b7Biyg9Uxrwjp8PYLRryLJvUf2VWKLDzAAsUDRitzU1/MOxHZraxuEy8ZmTwCAbuh38cwpz0Ven5EH7ZvhTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rg/+sDe8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 586308hj017310;
	Sat, 6 Sep 2025 10:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HDSNsa
	Pbgbsbf4K5WddRszFCvFluY+cX5Wbvk7aLnP8=; b=rg/+sDe8ngQ0BNeSQniZ6K
	Fjv47UA5MloVgxhX3HapgG7shw54sqifOH7xpLUDGZqV2xd/QpzlxlW+I9A3SLVW
	x4faeg9hRQ+/WxmDoHr1SN+EjsusSHhH0Pz6rapjPY4AqrPQpl0s0bDd2la4Bjyz
	Cw4WMkWrYgrH/5gjzLTG41UkTbyZyakSXiXCsTzHYVtQ522jez5FLO3vJyWgczOY
	GSoFinhiO6tZgn3MUAG7qqncgiT7v478lB8G0IqOdP7Uits+4+rBG0yxoD87iT8M
	Bls1M6lX/R3q6lxPdNGWm2ouhoS4uw3JdLZsL+SJD0Ex/5zBc04nreKPKlOVOYjg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmw943r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 586A7QWr018286;
	Sat, 6 Sep 2025 10:07:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmw943n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5867DubK017217;
	Sat, 6 Sep 2025 10:07:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc115hwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 586A7NGt44761560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Sep 2025 10:07:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D6F12004D;
	Sat,  6 Sep 2025 10:07:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9A592004B;
	Sat,  6 Sep 2025 10:07:20 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.107.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Sep 2025 10:07:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/qspinlock: Add spinlock contention tracepoint
Date: Sat,  6 Sep 2025 15:37:19 +0530
Message-ID: <175715312005.95031.13686272189997770445.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731061856.1858898-1-nysal@linux.ibm.com>
References: <20250725081432.1254986-1-nysal@linux.ibm.com> <20250731061856.1858898-1-nysal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yQM7L3OfKa3_xKUTbtPYHfhUZeRNxDTn
X-Proofpoint-ORIG-GUID: bU146MjV4rBY6_QoDjG3ZFVtVM6AQFp8
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bc07df cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=NXXni1WiAo173Buuo_gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX+xAZcOGF6E48
 DBKg9CuaQasAQTYb8SXS0B+8zirk5j/n+LypivJgNw8tvgRnOMN819r7jxtn0yWDQkGY9OOwD9s
 2CneTtP/L23fSfsmRoWj88i8069ZxzO+jrgC+nqrCb+jndzio6lYacBuR96kFxqQOXGI0+K5G8D
 dCo69R43ilL5R14LzoyOvwq7/DYyzZ0uYjnJkcQD4Qi9V6aoXRLi/OKW1uNDZQIKYr2ALGIq/rh
 lr62g6F5WTkwdtMH3StYrQQ76tv6/4yH0CWals/aucz0kQdv++8NJ8OqeKMcPNNsUKtgqxExrnS
 xxUQgs5stOdknaUOlEHSOXSM5gksMrNgM+KOjIDi0J0BOtVtrr5zoSit7rxbdN/okfoTzHL9GSs
 8jUSONgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Thu, 31 Jul 2025 11:48:53 +0530, Nysal Jan K.A. wrote:
> Add a lock contention tracepoint in the queued spinlock slowpath.
> Also add the __lockfunc annotation so that in_lock_functions()
> works as expected.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/qspinlock: Add spinlock contention tracepoint
      https://git.kernel.org/powerpc/c/4f61d54d2245c15b23ad78a89f854fb2496b6216

Thanks

