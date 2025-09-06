Return-Path: <linux-kernel+bounces-804150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3BEB46AC6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A11EA4E1330
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FB2E7BAB;
	Sat,  6 Sep 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OJJtA2DA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C92D4B44
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757153279; cv=none; b=fAlcLouussXJgRiaXZGjtzkaqxVqOslQVlYujMwfz13vGc7dEZ6SlZ+pHXOeiZ7OciUJ73HyOg+ODeZgltOiJ/8L6J5DRV6trQJO9JWjfxYwcFyCn1Je3hfhVfTV/ABse29BH/8hu6w0IdXuBZkjYVrV0luqTmI1kYE/bHPNw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757153279; c=relaxed/simple;
	bh=PIr/iGmM2RAFhQjT1Mh0y7X35D9RTBHo9baiuWxOr8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHTrz2DHhCIx3JGp88seFmpXmGy6oc4HKtTq1G0QdYuWzRKMF+6wKNd9lRkmVZZgr0DYMf4mA9/qsMOwYmD9L9prXbnl+tB/2Gc7hBQZ1a2j9X9rKkR3MT3wj6YiKmPTfn1CjrN/UkaSjuMZNhFKHx34Vb4F27YcjSb+7UxclzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OJJtA2DA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5864eb2m017518;
	Sat, 6 Sep 2025 10:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D2K6WA
	DPfyzF1q6psUiFGQ/kUjPlrOypEDH+Sv7nKw8=; b=OJJtA2DAoDKvu6geyd3kIm
	BMn2Gu9qCOpzF6ziWyfFaVRVjEmftpM3piOD8GjKshqh0eRUyzFliFWWsrtOwGS7
	hvhhpRU4JMJvYrGZqRE1XOuKe0R5qFXsrNTKfnIJftZ5ShcLOPfE+rTZjxn2bs04
	71NVUV7fkHM0f3Nby0IfZAmqOFTwc2pYx41pfQ57fkhvsxTfdixQRtdndcu+lB5J
	0FmgEaBKIXa21Z9Io/snOiM1VM/5IWWzNuZ34czyZmONdsC+C/Y2WyQXbFakcHgh
	wDUBBjG2Ja/O5p4q+/U1RFabr1/yn5FwCz++DWyqaNTMCfNrLLAuRgCHeP25mTiA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfes4rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 586A7LWR003043;
	Sat, 6 Sep 2025 10:07:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfes4rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5864Xon6014038;
	Sat, 6 Sep 2025 10:07:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3w4fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 586A7Jnw50921814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Sep 2025 10:07:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A3DD20063;
	Sat,  6 Sep 2025 10:07:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11E532004E;
	Sat,  6 Sep 2025 10:07:16 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.107.45])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Sep 2025 10:07:15 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gautam Menghani <gautam@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 0/2] powerpc: Fix integer underflow & leak
Date: Sat,  6 Sep 2025 15:37:14 +0530
Message-ID: <175715312006.95031.18312967895718915434.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754300646.git.namcao@linutronix.de>
References: <cover.1754300646.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4gvLGvKcbmaw3umDgGbo51QpLT67bZS9
X-Proofpoint-GUID: 1OIDBU-VTOMSl_r5wYuRk3p2k-DTLKAO
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68bc07da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZiPmK-8AuTT3vM0SIfQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfXx+b4GHjNA7nV
 z83Q7YBTcTBRDa7JQsvJy29fgFibTNhqL+kUFZDv1vi0MErUXUKLXcoKBS9/FMQ+SWbLbge147r
 yJAegcubFOufCUfLRPtfGz3ItHEf6KF8aVgVdAIZ+p6FRs+rbFadao7UvjvrWAAB57fwa3mjOdx
 8TyMa0194znE4ZujR5gsJi+wI7niweESN+6YpJbSoSXC8e7Vgnn374Vu7WEx2s1foNifrEc+iyz
 Osjf0TWk7FeNAR2RVZE23KDWwwgaJZuGP2QpKadoRW9b0ySxuwr9lEf92SytAzifcKhKRWq15Lk
 5Vh1x94ZLqTtRYGpxLn7CLiM+fo1KnUVPgSMkUh8inlybtopBb2pcf47C/lrc8sd8KRtQgamep1
 L7ayFWjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Mon, 04 Aug 2025 12:07:26 +0200, Nam Cao wrote:
> This series fixes integer overflow & leak problem. I noticed this problem
> when Gautam reported a kernel bug with another patch series of mine:
> https://lore.kernel.org/linuxppc-dev/aH9Na8ZqrI0jPhtl@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com/
> 
> The root cause of that report is a bug in that series. However, that bug
> triggered another existing bug, causing the reported end results.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/pseries/msi: Fix potential underflow and leak issue
      https://git.kernel.org/powerpc/c/3443ff3be6e59b80d74036bb39f5b6409eb23cc9
[2/2] powerpc/powernv/pci: Fix underflow and leak issue
      https://git.kernel.org/powerpc/c/a39087905af9ffecaa237a918a2c03a04e479934

Thanks

