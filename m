Return-Path: <linux-kernel+bounces-813151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2140B5413C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F31E1C243DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CF26CE39;
	Fri, 12 Sep 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IKj7qR/+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75725C821
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649374; cv=none; b=Dq4ArfcttPyZgKjyXpj2dHK8Z3VTO4kZReO9tmOczNvzumUzEUBbCP9i7qzuTKqlpqxkU+O0S0rfKpL2z96lBx2JgIuH+KkiLh0evqFKGEC+iFvqENg6hDFmE2a2/GQRrTBH/ezsuf9OynNZ3i1I1XVks/U+84F7romtop3NiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649374; c=relaxed/simple;
	bh=mX7a1MBMeegAehdHvvkxauw7d/5AQid8C/bdexGHyOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKxbJgWcyjS169vmXZHm6vaXrd2l3qrErvgIbES9utEk3uYUDnTDoFt9R8SfSJyI2Q+kFLzrRbd35FIynB4FvMTtKOu52S9j5N+m8vSGCIVzXrjumGCqtLMgucn2MVBqo5iHSj882OgnFClpRClWzzJAiuBP5lZx5Z6tpZ+FEME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IKj7qR/+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BMtGwZ003803;
	Fri, 12 Sep 2025 03:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B+lCbu
	IOH4KsblSKkytZGX2JEQmS896+Po7sLTH0XI4=; b=IKj7qR/+9PnVym71F0Yarn
	IK3sX2Fgr/XVwV60Ufe+qWtXiwEnWKWXuEEr4hAPG+MrOMcoE6zKzxK7Vri19hw2
	mG4diINJsTrXhsXKCGS/nHxYq+0+C53M8FofT/A+0eYREK1N9+8hporUizqrrN6v
	xzNdJD9SU/4z1y3d4BiVg17hHYJ/iupaRg27p8GMoUToJcRtOeB+SqFwSR39MdMy
	BAhEr07agpeVV11JQwxiskNCgi2geNCqPPJgCsswLK6YP1RzGjHOxYyaa3wwxOtG
	0WpiLGJ3LoHQvrwzYzWyTYspzBGR8MFA2Ot/R1bOlIs93jVgqy3vY9JZGz0JQ6xg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct7tp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:55:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C3tslb017546;
	Fri, 12 Sep 2025 03:55:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct7tnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:55:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C0Zfag011443;
	Fri, 12 Sep 2025 03:55:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9us9d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:55:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C3tphO56230326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 03:55:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D63CE2004B;
	Fri, 12 Sep 2025 03:55:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3B8120040;
	Fri, 12 Sep 2025 03:55:49 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.98.111.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 03:55:49 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] arch/powerpc: Remove support for older GCC and binutils
Date: Fri, 12 Sep 2025 09:25:48 +0530
Message-ID: <175764920910.610338.3948689825494793519.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <b6b94cba7492c8581e8d5d25b15962e5ad7a37c2.1751366979.git.christophe.leroy@csgroup.eu>
References: <b6b94cba7492c8581e8d5d25b15962e5ad7a37c2.1751366979.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX9YXtZEPtVviO
 f0ybfuMGxsIZA87ieSVJhd5pMKSF2934GwUoGHG0YOL9dt33RqnquqhDfFtg7Kp4tNe8YJFipnJ
 uVkc4qND1+V1xH0GScdw/8DfkrNdnTDdpngeEvPiYrJipZkAgI6+wyGyYL3D9+PDYjCuUV7sAS9
 9/BXRXZx/4mdoFYkvEE1tV6kSDMox7fmeanjRD9iA9ovDFkpDM43RYj5qZwIU5DU0fSY/uQW2Tg
 iv8cA9pdf0NMhnJWZGOE0i1M/J+xjDJ1gllUA9ngRPVaGwPZwp454tuVR98slj/pkoPRA7xOxTP
 rkEedUo1emeqpQvGn2ufr4BGqKNdfsf5Jlr+Lghd5dYVcWN8WjIJ2ztInmEuDEr0SqwKwhEoqV4
 xsBl03kv
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c399cb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=fHqBPzmgJZrzYLskxAkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0ZoXueZfXDXnRpuCIoeXtI3rPt_gZCbT
X-Proofpoint-ORIG-GUID: Ta0TUSk7oKR3ObUglrYp_5jgqDuIYq1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On Tue, 01 Jul 2025 12:50:07 +0200, Christophe Leroy wrote:
> Commit 118c40b7b503 ("kbuild: require gcc-8 and binutils-2.30") raised
> minimum GCC_VERSION and LD_VERSION.
> 
> Simplify powerpc build accordingly.
> 
> 

Applied to powerpc/next.

[1/1] arch/powerpc: Remove support for older GCC and binutils
      https://git.kernel.org/powerpc/c/a41de5ccff85a0fe45ea1b4078230bf53faa7dc4

Thanks

