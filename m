Return-Path: <linux-kernel+bounces-826645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F4B8F08B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699191897B35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083923956E;
	Mon, 22 Sep 2025 05:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qztfmemE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BAD231C91
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758519851; cv=none; b=UncJOORCYKEu5QjG8PJj1AOCH9hFMg4Gn+nWbFNFJDpgbXpDeIDkNuHW58dffeVPCcxKmRLCPdjVh19gECjFtLuGHi9w1PMN+THIbJmZGUloaEqwuuQ+ag2eKbQwYNLuwBUFL7GY1CL17tZlPufUpWLfUCFTBnOlHjecaYNA7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758519851; c=relaxed/simple;
	bh=rTbFdYZM8fMuJp90nOdEkD1vY70sCbXHOR/TCxuA/CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQG3O+toZ762qh6XmmGAbU0brXNFou3+Nz/isBqdv9p+7nuu0+WquzYYvqXjWJAqKKPu2DM51cYercJjgus/rCSsYrtaWibTKMbBsJxyVk1BlCDZijdiNdlhqoVZV+HfwnvDMHTAo6Ubdk9YNPy25W/aBvcW+L2B76cVI+/PT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qztfmemE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LKrB4u030655;
	Mon, 22 Sep 2025 05:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RO2ZY7
	xLMP8KiSF7uSa1AewwYtt/b7IPLQoncZwhQ4M=; b=qztfmemEXTPw5issXWpOI5
	3b1IViAyAMfvNncCYOVLTcRSvOwYzA9YN1uOY07C1HHnsADPjJAoBM2sc+TcgpI3
	ew6frUqaqE27/e2j5o7jNj22XMxYnKlhFFwDeSzpK5i7BJDVTBLXmUgi3MI8rD0G
	m6GfxAmpigtMF8KFAEIcvDRO3Vh9bVyZkLk3cF5ZnM5L09xKF8/HpUyiAc7jqf1y
	QmV4aUeL56yV7PZSxcX6MURJwQP49LpzOxvXOxYGb6ksoiumr6UfjRc+56LGcpXM
	Fx2scfYcFAvOFxr1YjT9oiApMtD1W4W3iMtGIfUoqGBzQ57DRqboo5xiTvxpncsA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0j8jbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58M5htoj028612;
	Mon, 22 Sep 2025 05:43:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0j8jbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58M3PZhh029498;
	Mon, 22 Sep 2025 05:43:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a6krmt5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58M5hrXl55509328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 05:43:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B41C2004B;
	Mon, 22 Sep 2025 05:43:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F247D20040;
	Mon, 22 Sep 2025 05:43:50 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.82.69])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 05:43:50 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: Remove left-over instruction and comments in DataStoreTLBMiss handler
Date: Mon, 22 Sep 2025 11:13:49 +0530
Message-ID: <175851974396.1538174.830769628770011282.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <5811c8d1d6187f280ad140d6c0ad6010e41eeaeb.1755361995.git.christophe.leroy@csgroup.eu>
References: <5811c8d1d6187f280ad140d6c0ad6010e41eeaeb.1755361995.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX4a71Z6K6sHiz
 rxLYLBbAnUjIN7ugUDhBpLNt048YLhRifF46o6jPYZviO2TuBZryMp6zq7OzPo3/TNDdsiNFTz7
 E8W9HJaIAoLshhJ1/b184LBl6fTwssCmGtWTPeH7BWKFiWwA6GbcBG35vF22ndOt26rCl9ogq1A
 NHtI3iKZO24FZja1s485TKmRy6YCwGr+7++OVUXyuYIPy9wBHgmRmNk7+appC5rjH7MVaJ1FXqB
 zRLogijRyeyseg77qRfmvcoUf0m3b4ALB7uLY56hEzVC67wMUyIlJoqD96/HJD7kai6EUjX3FEG
 lHumvZwLGxFkuzHeN7dONQepHrOm6kUa39Bv990DmciJS8LySxT8hP+0qa8l+Ztlz9nacp+C/jf
 Sbe2Iuq9
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d0e21c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=r6zoNvvWdUelzOn1eI4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9_S7qh1nycexKg1ovZV-VNJG4m_jFUaM
X-Proofpoint-GUID: Zph-FYwycfnorUGeBjKaZFsd4t9xLw3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On Sat, 16 Aug 2025 18:33:26 +0200, Christophe Leroy wrote:
> Commit ac9f97ff8b32 ("powerpc/8xx: Inconditionally use task PGDIR in
> DTLB misses") removed the test that needed the valeur in SPRN_EPN but
> failed to remove the read.
> 
> Remove it.
> 
> And remove related comments, including the very same comment
> in InstructionTLBMiss that should have been removed by
> commit 33c527522f39 ("powerpc/8xx: Inconditionally use task PGDIR in
> ITLB misses").
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Remove left-over instruction and comments in DataStoreTLBMiss handler
      https://git.kernel.org/powerpc/c/d9e46de4bf5c5f987075afd5f240bb2a8a5d71ed

Thanks

