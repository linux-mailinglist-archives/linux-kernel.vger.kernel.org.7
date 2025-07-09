Return-Path: <linux-kernel+bounces-723177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E7CAFE40B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2923E7B18AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5EB284686;
	Wed,  9 Jul 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iRNZECdZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6A274FD1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053233; cv=none; b=K7KFGxc5LT7CoHUAIZAe4fblouKmbQqHUBfirbhCRrAVHtCgHi4WxrxqBlC5BSGCMyH9wz7RhmvAdn25vBkXNBw0uT4LbCHeUTCqx4Go8mR2hFeFKXkIAbEYzU8XPGn/E2jcs9Bu0K6HokBZ0bGeo477tKp9FTkEnfasNhC2ZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053233; c=relaxed/simple;
	bh=B3fvOxKZmOCfYFKktLkE5PPFaQF52uhWc2RudDJgaKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LwRPPkyky3MBSMuZOMatP1OmRdsIjai8mlGqzbgdY00cV+0EsmgzZ8DiA/URSHRRfwGNArK2kj6/riPYyqtan/bLFJeut3XW/ZJC2xh/UDSmf1iySjENM0mwqVy/FLatVJ4+DVpLDu3amiiZnEbWMRpaFCYfN6LFcWA4ezfa8l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iRNZECdZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5698SYSA032284;
	Wed, 9 Jul 2025 09:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B3fvOx
	KZmOCfYFKktLkE5PPFaQF52uhWc2RudDJgaKA=; b=iRNZECdZ1Nb9/25zBSKpP/
	gqx7gl6e96Hg+xk8LqNXpPuOByQ9Nyp/oR/EanpGuZBsGFbrJqk3Lm+tQtuWqSsx
	yPd80JBV7Sk84ZENInVmtFCQC76PKSYIf/o+Hwiw1ogwrTXEt9k/VGGwe1jlnJQu
	u8d4q3E1X3hO2X3aSHooyuZn2AgORFqoXOA9jISS3vQZxPN9D1x7iNvzekapXXf8
	spk49I4NET6zsyFDIZTtXU4Xtg1ZQcDgsfcrbi7XvO2GvH0yJu+NLPOa9yljuETW
	S1w9DEy3qyRpLrpl6Oodj4JPzvkyLiPm3X1rSinNwIB7tMfIdKHuDMBoPLVHHxsg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk45e9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 09:27:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56982FKV013577;
	Wed, 9 Jul 2025 09:27:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkky98w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 09:27:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5699R2vM50069936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 09:27:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC1072004D;
	Wed,  9 Jul 2025 09:27:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C41920043;
	Wed,  9 Jul 2025 09:27:02 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 09:27:02 +0000 (GMT)
Message-ID: <8c112fd80ba37a1f05e0899afd4daa0bda7d6066.camel@linux.ibm.com>
Subject: Re: [PATCH PING 0/2] scripts/gdb/symbols: make lx-symbols skip the
 s390 decompressor
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Wed, 09 Jul 2025 11:27:01 +0200
In-Reply-To: <20250625154220.75300-1-iii@linux.ibm.com>
References: <20250625154220.75300-1-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA4MyBTYWx0ZWRfX+vM9Xm5gKdNQ HPg+1IT84dC8h7N4afICs3QjZjaNjOlpc9PTDzTOsQK2SfqTIut4NEWMq4sb0oy0pQFQkkDGG7q c5KjRCUIL1hdC7kh2hCHj0lYhiNGazf3E8t+Bfe050W9vRLVh6/iLpA4qinX8UAfT8uQBkzN1Id
 hbqWbuDk2OcL+0rBvA34Wpvsmol7nw8ORSg0DTv6uU3XM+9fDotPopkc5KdnfIUcyjwtPDxfAZ8 By4+xkIiHyByHptUCdmSzE2/lJZ8eKbIFdPp9bYytoP2SNYmfZ05eVq2m6II4hbAGkVjc0Bvpub 5w1zBhNMQ0HiPU1WDzse/y62Grw8uEVf05TDH4B1Y5YtxeM4PAF9c2Jg8aXgMtvLseVebmxydxh
 E5p09kdg7GJYDxtkfUniVhG2V+9plSklGksm23h9H2Ij9wA+2SbL4+/QeuP6bwhXEUHcxjYT
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686e35eb cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pcLcdM1_4t_Ntr76G24A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: b2qMO8rsilk0tANpMg0Ixny3vubq8ZIA
X-Proofpoint-GUID: b2qMO8rsilk0tANpMg0Ixny3vubq8ZIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=612 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090083

On Wed, 2025-06-25 at 17:36 +0200, Ilya Leoshkevich wrote:
> Hi,
>=20
> In order to debug the early s390 kernel boot, one has to skip the
> decompressor code, which requires some private scripts or memorized
> commands. This series makes it work out of the box with the lx-
> symbols
> command.
>=20
> Patch 1 adds helper infrastructure to the s390 decompressor code; it
> is
> already acked by Heiko.
>=20
> Patch 2 is the implementation; it would be great to have an Ack from
> one of the GDB scripts maintainers.
>=20
> We would like to get this series via the s390 tree, if possible.
>=20
> Best regards,
> Ilya
>=20
> Ilya Leoshkevich (2):
> =C2=A0 s390/boot: Introduce jump_to_kernel() function
> =C2=A0 scripts/gdb/symbols: make lx-symbols skip the s390 decompressor
>=20
> =C2=A0arch/s390/boot/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0arch/s390/boot/boot.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
> =C2=A0arch/s390/boot/ipl_data.c=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++++-
> =C2=A0arch/s390/boot/startup.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0arch/s390/boot/trampoline.S=C2=A0 |=C2=A0 9 +++++++++
> =C2=A0scripts/gdb/linux/symbols.py | 26 ++++++++++++++++++++++++++
> =C2=A06 files changed, 46 insertions(+), 3 deletions(-)
> =C2=A0create mode 100644 arch/s390/boot/trampoline.S

Gentle ping. Any feedback would be greatly appreciated.

