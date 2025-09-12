Return-Path: <linux-kernel+bounces-813154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A661B54149
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E35AA0C91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B762765FB;
	Fri, 12 Sep 2025 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGWiNXQ6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25527703C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649385; cv=none; b=O/MYrIvPh1bwijpc8GSgnvNzP2/AP7MK56D5icy4xT3kbKE9+Y9PDiPen7cuIM5Dpnmz9B8yuQB2mhNEceN+RWTjv0g5pFQxLHsY5aWRao7FbOIIUq3GhohyQEP/RgBpULusS5NfDHJCCfytVKrJdVr6U8eWWCUSnPy5qCEru5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649385; c=relaxed/simple;
	bh=iby5NE/ViyM8YFQd/LQmct7Cv6IKNpIlhVlmTrN47Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYeoFpLoDRHQ69tX+JUI4L6EPBFQBPQ4wOHgrsSGZt8FZhlUNUin1QZKboOkmw0L+MeIOYsbfiZXir1ehaoGC+dHq++/Ml0+SmEDtONWi8w+IHyJhamVU0pnCTWy8L8TAFcn9XgfM4d+e0xQBFHRsQiqIjZpPgrfaotu1UGz88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGWiNXQ6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BMC9vv020534;
	Fri, 12 Sep 2025 03:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xBHwy8
	CjCOA5Mmgul3+MTNVwaFPl880y3omYzqcLyzM=; b=gGWiNXQ6XhNLZz9WEezEok
	+H7m0OEZJs2rU46v2k9YH/KBIArKyFPZA9XkOooCwFgwy/qUMNv6h7v9EALbziN6
	lrQdkNYmWJ1L5eL5VmpLnYH98kJ1n4zYMKg3nJM/iGfdRMca8JruF5g65PQl4EOT
	/1xeCrg76p0EpUHphw1dp/b0JpEpwsfOOSwJUzuZtOAs/dwn/Wy5tNRR9Eois+/B
	9U4lZ1O4oRfymnA94ZvTUvNm8WL1iiM4YA6zrb50UIIPkRcGd8kpjgeoFNgyQ4V/
	Jx5j4xT6iyUE6ONAKpGYLN1nf/pnnKHOiKUW42L+4wtePZFXpgyC4K88hDwdXjyA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx9006-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C3u8sk025145;
	Fri, 12 Sep 2025 03:56:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx9001-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BNuHwa011447;
	Fri, 12 Sep 2025 03:56:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9us9dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:56:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C3u52a51380548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 03:56:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CC0720043;
	Fri, 12 Sep 2025 03:56:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A02C22004B;
	Fri, 12 Sep 2025 03:56:03 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.98.111.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 03:56:03 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/vdso: Include asm/syscalls.h for sys_ni_syscall()
Date: Fri, 12 Sep 2025 09:26:02 +0530
Message-ID: <175764920911.610338.12386684613166363012.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <e2215a515ae0e21393c50e2f38791a6567cf1dec.1755509195.git.christophe.leroy@csgroup.eu>
References: <e2215a515ae0e21393c50e2f38791a6567cf1dec.1755509195.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WZhKrsp1NL8AA_05fJ2MhNrhLGkQPPeP
X-Proofpoint-ORIG-GUID: kFcdqfRNwzm3qIipYzyOKBQQQBVbCnkb
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c399d8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=ptlMtBNaAhq1hGr5q6MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX4qqNauxynhsH
 KSAWo2LTztrsLfj1nMtqp/lbwOe8jfKvR12+wZsfRX8jyGYAD9LqQvWUBLWvbqRJTpU4pZ4ZO9t
 YEwBFy8pWjMBUS8KwKmsgCGNBXjjYnE+OgJem1fkttQdQVL8bEl+VqRgwd1p5fRY+lWH0dmeLIj
 X+TDOGB4CH0P+b532ZfRXo6MrEsLSdenQDtlmqldpqqDYzn1gJpva8V/IsyBJgvrXmIliOn20sz
 ekdAcp3U4LkXh7ov1G0rGttxWE5JymhxDZHw3eUiK/jaHXy7J6nqQ0CfmycZ0f7zLV/UTeINd8C
 7Vy+6YnFa3vEaQSel4riS6mjq18wqyAOiihUTR/GS7Yc1Jk8Bpkgh+fvCgasltgr5zkhkBaJkUW
 BfW/1kv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Mon, 18 Aug 2025 11:26:44 +0200, Christophe Leroy wrote:
> Include asm/syscalls.h to get the correct prototype for sys_ni_syscall()
> 
> 

Applied to powerpc/next.

[1/1] powerpc/vdso: Include asm/syscalls.h for sys_ni_syscall()
      https://git.kernel.org/powerpc/c/58f5382a482ba7313085de57767bb784f211b475

Thanks

