Return-Path: <linux-kernel+bounces-789260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16DBB392E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786A77C3885
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1025A633;
	Thu, 28 Aug 2025 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iypRVBib"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D3367
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756358970; cv=none; b=NG2roPjkhpDpw5ynbFfbEgE28NfTq5x1+Nyq8HI45343ArRtGKn0YBR0vSa7k7SG1xRbYcmExH8XRHwb0uk+UFbkYID/SjGHaWUdvRArQeC3LxtmJVfsSQigsh3RlIw5Zjz5MtMlEOMEEfo6U53BY2RPC0/dpLxf2gB2+HQGiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756358970; c=relaxed/simple;
	bh=qAamn7e5AdkdBusBZDOLI0DzOB/vvGVBclWDECUgjjs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KZ35JQPFKavrlAkrsybvApCwWoXXv1z4OE9ahcr3ECMyGFbv1QI89+sWgocFMLUUIN/u6c+ihpZDNwt/H4Ba3uDh1t71oiNGHdUAdTrENv35E/ez2pCTEjQuyJu/xG0+rhUQ4QGzcEc0S0AbwNmdtaOLKI/8iy8F18HkKAGrKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iypRVBib; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S1fWCU030401;
	Thu, 28 Aug 2025 05:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=W3YZ/zTzqNnvixi2EoicWpWm0NUq
	tqRjH11Z9UGPw1k=; b=iypRVBibTXbpCrAO8OmTLV6vbbDumIhjTuNIoYdivXPb
	ZSjqKqwALVQm0zLcsRmeWXlEQltUd5vdT+Z4TPUVo+1/73yqrMsK0pM1Cd/Qb1V2
	vf97npdnG6p40V2tweDMB7VmVENdpgdWXL6ThU7LZ6U9XSRzP3NM6hP1Jjg27hTB
	1FGnqd2Ap9NeBj7Afy+e1C6s7B6r6/qwnpxLXmVkcOM9ZNpeTERSdkWng5BKGeUL
	5Y1hT9qYxoDVmz7tRfICsnhuVSE7QoXieCsX8drIalax0h7eZeZOkZtFQmFCZe2N
	ub6Z0EMPTAHoWGCXSqzgfmtMNrHOI2irgHY3+MwZyg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rw2vyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 05:28:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57S5QhQ7014062;
	Thu, 28 Aug 2025 05:28:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rw2vym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 05:28:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57S4CH4D007451;
	Thu, 28 Aug 2025 05:28:57 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyukm64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 05:28:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57S5SuHt590568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 05:28:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F395E58059;
	Thu, 28 Aug 2025 05:28:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F395805C;
	Thu, 28 Aug 2025 05:28:51 +0000 (GMT)
Received: from [9.43.64.161] (unknown [9.43.64.161])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 05:28:50 +0000 (GMT)
Message-ID: <832d6a3f-40b2-4e81-86a0-99d6ad73f1a3@linux.ibm.com>
Date: Thu, 28 Aug 2025 10:58:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ajd@linux.ibm.com, gautam@linux.ibm.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        masahiroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, zhao.xichao@vivo.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.17-3 tag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: owCUOC0eC1YFaJSIhzI6j5_N7kfEUQTy
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68afe91b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=F0ATjmcYWGgMqGeifjYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Wd8lPUtfKc5uEip6qM4oM60j0FhVq89A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfX7kp/RQXf87B7
 UH83HW27thtsSH4Lg5Cj+tLQrIcF25weCBVjrXEjBdhY02hCZkNbJaHrOwY7Xy335fR92aWq60F
 EaNI6IEgIoFTIj29fNWiztghqE3eiyzN0jjIdYE7rTCYUIjiEFoJ52jEDPogc/kiKvtu3Cjd9hC
 TJFm98LnO76pGUb2KYQSBGKE3+ArxcZdu+eTwxp7h6P6ULUDAhYekyP3+KzwS3QTn9/rVvzhnPw
 tRJseYfzMCJrfzgbqV8nB3mYr6C2WTu+vnmLty3dFBwUaLx6i4r4dyNKU4mLh3aFzftOJLUjRiZ
 ITbrdSaxYKBaDKwVnoJJhiatJl3pDV6vyrqIwlOFOgxOrbdYLfvFNSl7CRSsowmbRPUruqNusdP
 T6nRXL1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull couple of powerpc fixes for 6.17:

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.17-3

for you to fetch changes up to 8763d2257f5231cfdfd8a53594647927dbf8bb06:

  powerpc/boot/install.sh: Fix shellcheck warnings (2025-08-20 14:05:18 +0530)

- ------------------------------------------------------------------
powerpc fixes for 6.17 #3

 - Merge two CONFIG_POWERPC64_CPU entries in Kconfig.cputype
 - Replace extra-y to always-y in Makefile
 - Cleanup to use dev_fwnode helper
 - Fix misleading comment in kvmppc_prepare_to_enter()
 - misc cleanup and fixes

Thanks to: Amit Machhiwal, Andrew Donnellan, Christophe Leroy, Gautam Menghani,
Jiri Slaby (SUSE), Masahiro Yamada, Shrikanth Hegde, Stephen Rothwell, Venkat
Rao Bagalkote, Xichao Zhao

- ------------------------------------------------------------------
Andrew Donnellan (1):
      KVM: PPC: Fix misleading interrupts comment in kvmppc_prepare_to_enter()

Jiri Slaby (SUSE) (1):
      powerpc: Use dev_fwnode()

Madhavan Srinivasan (3):
      powerpc/kvm: Fix ifdef to remove build warning
      powerpc/prom_init: Fix shellcheck warnings
      powerpc/boot/install.sh: Fix shellcheck warnings

Masahiro Yamada (2):
      powerpc: use always-y instead of extra-y in Makefiles
      powerpc: unify two CONFIG_POWERPC64_CPU entries in the same choice block

Xichao Zhao (1):
      powerpc/64: Drop unnecessary 'rc' variable


 arch/powerpc/boot/Makefile             |  6 +++---
 arch/powerpc/boot/install.sh           | 14 +++++++-------
 arch/powerpc/kernel/Makefile           |  4 +++-
 arch/powerpc/kernel/kvm.c              |  8 ++++----
 arch/powerpc/kernel/prom_init_check.sh | 16 ++++++++--------
 arch/powerpc/kernel/setup_64.c         |  5 +----
 arch/powerpc/kvm/powerpc.c             |  2 +-
 arch/powerpc/platforms/8xx/cpm1-ic.c   |  3 +--
 arch/powerpc/platforms/Kconfig.cputype | 13 ++++---------
 arch/powerpc/sysdev/fsl_msi.c          |  5 ++---
 10 files changed, 34 insertions(+), 42 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmiv6G0ACgkQpnEsdPSH
ZJRFww/9Emkh7vi33dCowAFNTSNMEJFZla+JAAMPJ6TsX7kWw2Ejxcj9aymEBY89
udTNgrX8zYgdHkfFMUwW/e+XSb/B5/Em/ssEcFLTuVIc50WKdt8eod0b3gHMx1Nv
RmxaHxivM9Pp2mEuCuw7oEJYcYDQFxPJd6KToeKNgCODp7f+ZC4jEos/ObxuwPOf
+96iIeqS/QIkaCb4DRFg7ZMUYrSWJw2tQGRkocmuPW7/ryVSj4cVB8YQGR/oEhr8
BCSMiYY3PO6u+9laVxtth58AqJhQ6n8WMG83W+IHUt6c7Ed4C8rkYDHwdJSkMi9t
wq1VUajEmKO4V26NXSOgqZCtLZK2XMeMdBmP3rjkFX5/lPU4QhmDza2/RP9UAXlC
mXNL6V36iOyRa4GUDvY5prhEn/+Jli+W1aAnnrB1cqFDsy9wvw3NhrY2h8KsGPhF
CnNiUNfIfxjYgONFHxmcgPhbxkEF4f8OWudnmVUJzxq9ssXGZNOuR22OiIozrWTf
T8GFRvIUJ+lc49/iB8ve81+KCf7EPCdLUSMXsBdHxGK1bm1MR8tSOpixt0N2NxOr
Ujq6Mco57Bwz+IiaDKQ652sS2VpbhYWYh1dhQJcrcHODwQ289ONJ1infZ0xrl9mT
/EQhrnxj73l7e2/87Hdk6XNpbiY62IXks0Tgp18u9os7/WOZmKw=
=T1gP
-----END PGP SIGNATURE-----

