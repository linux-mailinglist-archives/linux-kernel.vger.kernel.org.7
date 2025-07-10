Return-Path: <linux-kernel+bounces-724923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2366AFF897
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7093A56B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554F286417;
	Thu, 10 Jul 2025 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sMKgOZQw"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94429285062
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126410; cv=none; b=VVyZT1fG70B1eml8hsLRvgEdvAeG87HDPkFcpx5h63SitjzHkH9NoYcjCPfVaRlZNq4Rbc/Poe3k6fm4qZR5GId5VQiHTSGbEIwCQJCZFW9sX9VHpC75u+XwX4nKN1lk0xdAeL1VwoSFKwSjolsa80+9aLkbcof+gne7f6bAZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126410; c=relaxed/simple;
	bh=J2qm8gW2W9VTgWcNwObVC75+MPIFXyBSDm+GbHXBcPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9ZxERCTGz46s3Z5O78KVRtkkXHmDQd4yIuX/EBr2PXOuh9C+6vYxlaaCS8BPnSzfD8nV5fdJugVjzEEKvvU5aPnwcz+HRaOhd+NP4Wg9A4wIN01bUHBwKhhiw2DLvP8GACjoyaDi19nue4V3WtPPuqaZ3HUcsOEyJQOCYNGdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sMKgOZQw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569M1EiV023525;
	Thu, 10 Jul 2025 05:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LnZR9xz1XRA7Tkfee5q4RNrlkU1xyR
	gkS7m1fJPmQ60=; b=sMKgOZQwN+J7WIljk7xGTaa6c32QPThTUQ90i2Oj4T1Bn5
	2Vo6NYYqM0tio84qHz55PdI6h/veKyb8yjEDIxBdw3wwLtv+Aw0ZIDGnmX/M3Jt1
	jRYMdt0A1il8IsmwbKcRubSOrj9S6k2kM8muMysPt2uqza/PJ7psScpeI4kf4pVt
	s3k0Mewvg8lW2BfbYuTI0dDs3BTYlvLGHx5of7P1e75MnIz+Hl1bT1mYiGg1hzZz
	FibzyvG4UR/w2Cr3kKAxRJzqcLpPubsZyqV4nBFkA0lSALUyN8ngKK2c8+iKzuG2
	LAtqv9xdSddt+Y0IWG1RjFf/94jA1CsfHZ1XM7zQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnhupw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:46:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A5BIa6021515;
	Thu, 10 Jul 2025 05:46:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectv9vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 05:46:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A5kcs150397580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 05:46:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D09C2004E;
	Thu, 10 Jul 2025 05:46:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7D9D2004B;
	Thu, 10 Jul 2025 05:46:37 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.141.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Jul 2025 05:46:37 +0000 (GMT)
Date: Thu, 10 Jul 2025 07:46:36 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 0/2] scripts/gdb/symbols: make lx-symbols skip the s390
 decompressor
Message-ID: <3e05be39-6b79-4ab2-af6d-2492515b86ab-agordeev@linux.ibm.com>
References: <20250625154220.75300-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625154220.75300-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686f53c3 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=pcLcdM1_4t_Ntr76G24A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: cLvXQ5QrEbRsbRGZCm0eL7PLCFQCdJI1
X-Proofpoint-ORIG-GUID: cLvXQ5QrEbRsbRGZCm0eL7PLCFQCdJI1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA0OCBTYWx0ZWRfX8AUW3A2PT5dg nhrhq9LcquIIU+gZj1b5kiTke5x4EssEKgiHlkm4Rcw947/Ya2XNhAtLSsochvOKF2HBc1gh8NK 1MAapbD6X1G6s8XEDMtXV8GKQe62EdFbmIC/Iyj5W6wI8gaVtask4AygRIjul+FsL9g1sDRL316
 1vpt5nV/guoa12lpc+hnIZxc6z2SeZfpRAbyRU7HaIp4rjUy6dcaLUAkD9k+nOSa1J2uYiajvCm TJWk9PIVP0zS+JJoyySwRi0D9ZrBu1MzBdWc+wOB3d2lbFtMwIF7S0sRZoQa8PrhNPweVwHX5QF VHA/u6ftJ6YsAugV1D36+a0I5D6qq2xXqxifecP9LXnUAkvVwMrvHUotmwmpDSD2WnZyFHnV89Z
 GNdSy00o2uLq7cFUhj8KUyqcMz6TRSiipMUNkhUlY0xctInBg9qDCzyHWcjMd3AW2GwK9DVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=495 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100048

On Wed, Jun 25, 2025 at 05:36:50PM +0200, Ilya Leoshkevich wrote:
> Hi,
> 
> In order to debug the early s390 kernel boot, one has to skip the
> decompressor code, which requires some private scripts or memorized
> commands. This series makes it work out of the box with the lx-symbols
> command.
> 
> Patch 1 adds helper infrastructure to the s390 decompressor code; it is
> already acked by Heiko.
> 
> Patch 2 is the implementation; it would be great to have an Ack from
> one of the GDB scripts maintainers.
> 
> We would like to get this series via the s390 tree, if possible.
> 
> Best regards,
> Ilya
> 
> Ilya Leoshkevich (2):
>   s390/boot: Introduce jump_to_kernel() function
>   scripts/gdb/symbols: make lx-symbols skip the s390 decompressor
> 
>  arch/s390/boot/Makefile      |  2 +-
>  arch/s390/boot/boot.h        |  1 +
>  arch/s390/boot/ipl_data.c    |  9 ++++++++-
>  arch/s390/boot/startup.c     |  2 +-
>  arch/s390/boot/trampoline.S  |  9 +++++++++
>  scripts/gdb/linux/symbols.py | 26 ++++++++++++++++++++++++++
>  6 files changed, 46 insertions(+), 3 deletions(-)
>  create mode 100644 arch/s390/boot/trampoline.S

Applied, thanks!

