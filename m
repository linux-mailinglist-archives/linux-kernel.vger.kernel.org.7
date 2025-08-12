Return-Path: <linux-kernel+bounces-763935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF9BB21BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCEC426E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9E61DF27F;
	Tue, 12 Aug 2025 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n+lQbuD4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9782139D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970362; cv=none; b=p1IOLXCFGRDO8/fUS6E3c7J55U+S1Km9u57hQ919evnr/97kltK0VBJbSs7ZkvkRCxm7yMRs5jxlxpdIm1uA6AVg3GVM/Q6GXb08LItHqP/6mZjLrSFUUZiwoDIGlEF1iWC58Z36WwOtzQiH5pQfKSZ8AECBmM8e0wcCMBeSris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970362; c=relaxed/simple;
	bh=uq1iFLrAntOLexQc1zApfJz11vi8iOWR3dJOewxP6yw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJAIYdNophPVvHEjQ50SBSEqd08F5lF5mPIka+sTSPD/x75N0oXD+8F47B5dCeTLjDy+ep4KH+vI8vpt3SWUcMU8DpW1gt7BL9aNt7zMcftRIfUP2URquEuXNANmikiB+sBjfFkDNiCkPcwEyr7w8KL+vW1/wjRNObsUz0R4Rww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n+lQbuD4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C06ccc007051;
	Tue, 12 Aug 2025 03:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9q0gyF
	MLlQZ80P29WiuD/0gjHl1p7rDeeQUw/CFDdr8=; b=n+lQbuD4TolJiw2ByCZWaa
	2ivfMmfaBQJP+XqPMNldoL8BXnqpK725L+1bHGKmkM/nyvPkRnmn8ropkmUsRG7r
	JztOozAm1y44MZrDDqLxkusR0xj3Cpc9/W+vMvW5v+QqsB8yZrSaaeXorwmhWtWf
	7XBLD7DtYYH6SwdB02V0YF1+Xt7+6xLF6JIUxbrTU8tlIhhVO26uKlVzl50/Qk7J
	Qp7iv1omTG5N/u+l2kJRLjjR1BAZncU7dxvsF/fSlQ7PMTLCDqX2MqFmVQsH70Rt
	YtPcgRvDEkmt5++pjq7L+NjuTa5SBRAHkdNzjgCUlQ+WD9itu6Y1mwvLecLaTb5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14cb7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 03:45:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57C3jgJE030651;
	Tue, 12 Aug 2025 03:45:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14cb7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 03:45:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57C0C3UO028585;
	Tue, 12 Aug 2025 03:45:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n0k78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 03:45:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57C3jdU110159228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 03:45:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67F8658059;
	Tue, 12 Aug 2025 03:45:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94EEF5804B;
	Tue, 12 Aug 2025 03:45:34 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.150.9.64])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 03:45:34 +0000 (GMT)
Message-ID: <4adce2fdf58f74e42949528e1d6c4345337706b7.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc: pci-ioda: Optimize
 pnv_ioda_pick_m64_pe()
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Yury Norov <yury.norov@gmail.com>,
        "Jiri Slaby (SUSE)"	
 <jirislaby@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy	 <christophe.leroy@csgroup.eu>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date: Tue, 12 Aug 2025 13:45:32 +1000
In-Reply-To: <20250811165130.37552-3-yury.norov@gmail.com>
References: <20250811165130.37552-1-yury.norov@gmail.com>
	 <20250811165130.37552-3-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rsad0eRKtkOpz_KqJuf7rD7dvcmKxzRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAyOSBTYWx0ZWRfX+xP77WtJt37o
 Pn8BnX+j9HGO+jwQmMwtdbAh9MnSQAN/3SmXP3j6rhPgkX0GiMRnIN9BLcISas6hs2bu3/b51k2
 M02A+p1DrFer8F4qyiqs180xGsm0hnYOm+Qg8IQu20ivq5jCW9vEgdjRUEGppoMHmtbGDk0HMwc
 xEqni2k7MqwrmZEjKIg+3BmqhL9Gfu5kJLX1RBP0kEv0QdE2ZgpHUZ4LDC+w1rVXjLWEbF3oim0
 dugTEP/WosNlWPyUEJnDuifty8PkgFB465F8yN6g1GvR1TlDxfsZSlQ6AG3ul4YcfdgQUWbopFl
 L7lw1IftNPwL5Q8Mb/hRmYm3SKUb4WH5L+C8iy8NxjnarWVbvunYHdxi3gQLpTvpiFT4W/A8afi
 FQC/5ZCFoT7tjZr+WYJjsBbzrSGmMyrxiELpzm/ul5iqY7Ed2QJWd3ja4G352RRwcKNddE5O
X-Proofpoint-GUID: dKeHuJW1_dp9vEApp2VRkMjY1Bx9w3xf
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689ab8e6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=KWSvNgz8TR5Tj8vLfpoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=485 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120029

On Mon, 2025-08-11 at 12:51 -0400, Yury Norov wrote:
> From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
>=20
> bitmap_empty() in pnv_ioda_pick_m64_pe() is O(N) and useless because
> the following find_next_bit() does the same work.
>=20
> Drop it, and while there replace a while() loop with the dedicated
> for_each_set_bit().
>=20
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

