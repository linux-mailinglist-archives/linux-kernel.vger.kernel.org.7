Return-Path: <linux-kernel+bounces-826644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2B1B8F082
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A792189BEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63FC223DFD;
	Mon, 22 Sep 2025 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gPguHyIh"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FED5C96
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758519848; cv=none; b=ZjKuE5vJmyPoy/rL6H4UZoRxsUn/rDkIqHL6pO5gTkh5cjb4JJa6+E5cszzS1uAdfMrstVGZF6vzjhASJmZx/Vu4WBLg8LwjkaB/TXatLzJQG6ic1R/BLt1feNKZGTkivN7iNxq+D4/EJOSqGbaWaTTKQlY2/o8ooV425w8iymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758519848; c=relaxed/simple;
	bh=2V47h1E7xCRPW0ofnysYKQR46htHfyPotG2sXJrlX/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwM4zdjX2fEeQQ25vQrfiGyuLm3VT5JigQpB1sg22KOu1lChL/LCc3/xQWsB06arElsJiZXtH0ze+8e2bWdSv98UDiyjQIQsk2F1FPonDiDskjLKAhl4bQCglofaz3z1tjUwtNZphntUXy5OPRSdsNZmrjPZNCVpWnIdzHisZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gPguHyIh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LHBdtD029199;
	Mon, 22 Sep 2025 05:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IMWYox
	wZD/4pz1AvW/u55mqtG47ap6rRBfxjw/7eJoQ=; b=gPguHyIhQGkL9kWyTIHhRu
	EDLDMRkDyyXgm2asIygnqFEDBSzhAyneB6hoTYqY3LsrplsXvqDl+T9j5PQDUtni
	y867hfWbS+UWo+xvRc+d3zqKHGtJLAMjRbyT/8OFrB+7ZvHVtUCPda8JoLfpodZP
	62tEiBivJr9guIYJljG9cJ4dj1GaMbag3XD+erwHp4h3Jrt4sP8rvOdH53Y7uhrI
	MPzqgVAJJJ4E4hE3hmdnSOlfHPbu5HbsYB3C1hsyWe2JFUB1k2ojoJtNTwh9kq03
	d6c/pmWHhjGoZD/zt8FQ/11GvBJk4qeaeuNcAOkvyJ7PUt/q4raQ4Wt7vkEHAfwg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0j8jbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58M5dJoB018943;
	Mon, 22 Sep 2025 05:43:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0j8jbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58M58Tb6019732;
	Mon, 22 Sep 2025 05:43:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83jvg67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58M5hnjB51970378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 05:43:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D9320040;
	Mon, 22 Sep 2025 05:43:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C89FB20049;
	Mon, 22 Sep 2025 05:43:47 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.82.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 05:43:47 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/603: Really copy kernel PGD entries into all PGDIRs
Date: Mon, 22 Sep 2025 11:13:46 +0530
Message-ID: <175851974396.1538174.14407108972132454918.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <752ab7514cae089a2dd7cc0f3d5e35849f76adb9.1755757797.git.christophe.leroy@csgroup.eu>
References: <752ab7514cae089a2dd7cc0f3d5e35849f76adb9.1755757797.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX/EH9VyigILfd
 Y+Mnz3TeZYj68T/CwofQHLr8K5nI9i85LuAZCMzJa6pqa9kop3syZ/ybFzMZmWJIRPAOGR/kg1G
 BMErPa294XyF8K0eh7zXrQQVGw3JJrp8jf26pfP+7nRjprFPbBul6EkrChVCQFZbHIPGvHJkQcQ
 nfJ6exKH2gxydaeFmB1pBjjP9C7jSLfiaKzDSmtcXgx6YYeG5fhsoATyTzWeaQOTekb3thcF3K+
 LDLB11nqHCbKuedW0trlA8VP4yBFIuy7gPYOpzBk0q068ofk3VCKFZxEni4/qYMTX0+O5n4TF2e
 yWRjMulzTIZyIM2oz3SVGO26c8p416d4FXxs95+OsgVZ1mcPXna0oaEGWkU0y9Dp7r7yHrbqfgA
 m7SqwWuP
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d0e219 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VFsITqSaSZWGP382EtEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qbWMU_OhsSGTpGz_k9vqD2vwKaiSsSIY
X-Proofpoint-GUID: bebGJehym61NPifIBFNfN3BsfMCGXBJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On Thu, 21 Aug 2025 08:30:18 +0200, Christophe Leroy wrote:
> Commit 82ef440f9a38 ("powerpc/603: Copy kernel PGD entries into all
> PGDIRs and preallocate execmem page tables") was supposed to extend
> to powerpc 603 the copy of kernel PGD entries into all PGDIRs
> implemented in a previous patch on the 8xx. But 603 is book3s/32 and
> uses a duplicate of pgd_alloc() defined in another header.
> 
> So really do the copy at the correct place for the 603.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/603: Really copy kernel PGD entries into all PGDIRs
      https://git.kernel.org/powerpc/c/f2863371f017eb03c230addc253783fa4c7e90f5

Thanks

