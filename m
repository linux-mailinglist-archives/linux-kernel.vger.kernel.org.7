Return-Path: <linux-kernel+bounces-789317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C7B393D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5541BA3A86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5079727E07B;
	Thu, 28 Aug 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LjLbq1ty"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440F27B4F7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362811; cv=none; b=OxpoVqPIb0NRYfs83A4/WGaLBlGmTMQoYAvaC9a5kXFlpihqB2/trA4i0HrqGvvU9FrT9qcdtAJakojJjKW3QaQ66Ylpb3sdQNoVj8RVdgU5R4dsCpqH/I6+YOzbifVsqso6eJtO6uSHqV14SE5tqD2eh7cfJFM6Ru/26Ot5Yq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362811; c=relaxed/simple;
	bh=xZQ77Cm9cc3IHvMJZH3DQ2b0B8xyKC4fDfX2kFd3AOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzyBDu7QqM2DzdkkL3HHgCZq6BdDE10BQDG5/ipeXAmbef84QNS4QxOeJUiohtAK1BMwecaydyCEd1YywmnzvtpfxIJmehiChBJCHk5mNdaThHF3jAHb4yGmJz/ROkedd/BDaF9HsJ4b5LbZAavAs1DLghliUfc1zmeLgRzuVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LjLbq1ty; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S2ARto003786;
	Thu, 28 Aug 2025 06:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y4tJpn
	maSVm0XKtlWBoiq+6XChRtbBTbGgMlfO7RY+Y=; b=LjLbq1tyHrN6SUzVaH5QBa
	VpMOi80T9XdecxPqcYRMYAlKNmE4Tri0NaFgiLgbRi2LQ3Ojz9gv+gW4fVVpfUX2
	eXMEWRyUt4gaNJZbbhnDOseChUZ1MzIRkzxcvmScrDJZ5uhR46GHbTv65l4hcPBv
	38r1tcMObkLYEgn3BlKM0k4L1eg4ruVwhHQCVCQSaO3dP4LMzS5tgwLO3cwMIzxX
	aBIF2kuoZDYFVmqhZtUrAl0GUjGJdFlPu8bk3eEdwl/N+5XKeRo/8IZyAL2vo9Rb
	Ul346v7LMazlU/d7Qn8J/LQikhRx8+Y9myLcnBX6UOevdMA2h7yYtBUrL+/q1+IQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avr4da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 06:33:16 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57S6VxUD016762;
	Thu, 28 Aug 2025 06:33:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avr4d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 06:33:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57S5aFZX029957;
	Thu, 28 Aug 2025 06:33:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfmuj87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 06:33:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57S6XCUk46006560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 06:33:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93D6A20043;
	Thu, 28 Aug 2025 06:33:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F6EC20040;
	Thu, 28 Aug 2025 06:33:11 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.64.161])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 06:33:10 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, Xichao Zhao <zhao.xichao@vivo.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64: Drop unnecessary 'rc' variable
Date: Thu, 28 Aug 2025 12:03:09 +0530
Message-ID: <175635911050.1554354.5226234621328451734.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801035908.370463-1-zhao.xichao@vivo.com>
References: <20250801035908.370463-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VExv-ZE7OWcx9B5d4oHRybycscjQ_2ZJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX7cl2AZIplOI7
 nHSDCnmhccYyD+4dymlP1NnCAiJs415DhpoZ3un6D9CVfx5dG0kakLxMZzUUHwJ/9A2Ms0fVBrY
 3mSZij042XgzoJN7LKVOjKw2hah6ML2WT88sr/V8edtYytne3X5GX7aWglUSb02CPZzY2loH/EW
 Dn5LnInxp14Zf8nE33yNIXz+fH3JLqbGp9hLc8xZCjUo7REfCYpfFTIU/JHjXvllNq1KIXjqlu0
 CLF+r4Cdqsfydjofz1dR35G1HuNNixTSLfePPkwIGB7mPtzex2fKyZMDD2cEc1jXhFTAfqYdJPY
 zRn/wXz3hzRMkQ73uKBh2XyAJ5K1vtssWqof7LrYj8oPwDm7YCaH//Nr+QVpZ154kIZ0wizzE3M
 kFrkWsEh
X-Proofpoint-ORIG-GUID: p4KGUqfMXWHFcTISzsguXEn3ufH5N0lA
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68aff82c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=kQJjBC78qQ7jkp6vknIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021

On Fri, 01 Aug 2025 11:59:08 +0800, Xichao Zhao wrote:
> Simplify the code to enhance readability and maintain a consistent
> coding style.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/64: Drop unnecessary 'rc' variable
      https://git.kernel.org/powerpc/c/8b5d86a63bc9510e094a15d7268c60bd4347b95c

Thanks

