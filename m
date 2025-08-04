Return-Path: <linux-kernel+bounces-754605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F121EB199FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7869C1896F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12701CD215;
	Mon,  4 Aug 2025 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fTs3A3us"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C417736
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 01:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271969; cv=none; b=EM2IvyFR90P9YEPHskZiNpQCffgr8Yruve6tfEmBysYs4VQPjxISj6R7/eNwyNirKngIXks+IL7wMyiaFRy6I+syScP0m2VvUU+jWkNztH5wzIFnxPgI/9BsSD39MHj84zSvu+3FLN1jxKpOcoQ1Wm+9G2UuYbL+KI6HNnlmpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271969; c=relaxed/simple;
	bh=prylmbu0nnnd0K7w/ETKvkXxEIiXVVzOuhjaxbIbJXs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uZ5AhIHIdh8iRz8eNuv1XBixe34bLKGTZcQ+HZ56Y4vNs7zHkJ+R25nPq50Pd/SOgWH9h5z5UWEO2/V6ydftTb+pyYOFLlKMgyZSTo9ei9A/U7mXxzWAjbbJ/5I+Co0FEuNjmF0bpDY30Q2P4PwXeZvs7lCUdeGkjsN9kSiML0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fTs3A3us; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573Llbb0020089;
	Mon, 4 Aug 2025 01:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=slPRuwjCZJ/eNkgeU2PZQcqzDuP7
	uiS2GsJlcfpnEMs=; b=fTs3A3us1fBs37FLigqRa0lHaLkn89sbEX0/lQ9S5SZ8
	y6Aj/5tpI/8oG6vJdGtYtThKk8uvMAUsLcIJbm+pfaJuQEysCEBA7bhMnPaor9p6
	grGUNJ08DUWpLkhVZRmK1R67JXCz62ZH5D56YHC7bJ5zKG2zIAX0hlIZjtqarKuh
	jV3QODZ6rmowxTL3fn5J+Ci0s19M9QiIfMApfe6jjzKUdOkoqx0HjqqtMAeBlfLR
	y/DlfdoOCrXMe/uP2HsqoWTsoLqdUvcjuiDSoa1JAFsa/T43UW1WBvqkGyCu3sK6
	pLZAT5H+xD8QEEZ/VMoMLsklqQTDWP144iHAUsPzEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48993p6fqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 01:45:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5741jZFa022530;
	Mon, 4 Aug 2025 01:45:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48993p6fq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 01:45:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 573L9M7Q004549;
	Mon, 4 Aug 2025 01:45:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2bb2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 01:45:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5741jXpf32244348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 01:45:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2E6758063;
	Mon,  4 Aug 2025 01:45:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C96358056;
	Mon,  4 Aug 2025 01:45:31 +0000 (GMT)
Received: from [9.124.211.172] (unknown [9.124.211.172])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Aug 2025 01:45:30 +0000 (GMT)
Message-ID: <9c2b1303-bc28-41c3-b87b-e8640960fcd1@linux.ibm.com>
Date: Mon, 4 Aug 2025 07:15:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        puranjay@kernel.org, tpearson@raptorengineering.com,
        vishistriker@gmail.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.17-2 tag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8a-yIwtNX14tobdc_wLSV4WDzIde4U69
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=689010bf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=MLdSzP9YufQmr4hYxv0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gNVilf6q4Gnx4VRA-ha8frpLZRDCAwno
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAwNiBTYWx0ZWRfX7WwGxop9Ka9T
 RnBKRpSMYBbVlwnCSYPI4kSts+CzLyNseaLfOMdPJ8cqv/lvpuReHdaCwx6tCQ/qgiWKnXq+v3p
 jEEk0qO9fyJXsyBdBiNsrE9lC9HFpCOeGZ86ExKh5KPdjF4Vj4DZwTrbkA4LtVW8K8RSnqxHGcA
 x6pxK0ymQxP+4KTRdFE/40StJL/duH5WjdWeOHi+KVi7/qsZpxW4HEHQnnYGRGWM/+i0u0L427S
 0u/NbNZYx1iiY/a5+E08hoUvd/OtJc2SiMKBqTB+Q8+EIpmUEOj3ZueDoo94tE2ts80UD6S2uCL
 i3YM+5MwXvLOjeU53xmFVHnH7+R85+xWkZjZx8GynN97M0RNSjTKAJeAJdwYs4fCxaAWcseOXCQ
 Mf7FKEeXa83crBSljVezRkiwJ0UgWMtw/C1Kb8Z0qOuYbPBTn4G2hCci0momGuEuzJtUUws4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_07,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040006

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc updates for 6.17.

When you merge this, there will be a duplicate entry for "htm" in Documentation/arch/powerpc/index.rst.
If you could please remove one of them, that would prevent a warning in the docs build.

The PCI hotplug patches were applied by Bjorn to his tree and he asked me to cherry pick them
from there, which is why they have his signed-off-by.

Thanks

The following changes since commit da30705c4621fc82d68483f114f5a395a5f472d2:

  arch/powerpc: Remove .interp section in vmlinux (2025-07-22 14:21:19 +0530)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.17-2

for you to fetch changes up to cf2a6de32cabbf84a889e24a9ee7c51dee4a1f70:

  powerpc64/bpf: Add jit support for load_acquire and store_release (2025-07-28 08:13:35 +0530)

- ------------------------------------------------------------------
powerpc fixes for 6.17 #2

 - Fixes for several issues in the powernv PCI hotplug path
 - Fix htmldoc generation for htm.rst in toctree
 - Add jit support for load_acquire and store_release in ppc64 bpf jit

Thanks to: Bjorn Helgaas, Hari Bathini, Puranjay Mohan, Saket Kumar Bhaskar,
Shawn Anastasio, Timothy Pearson, Vishal Parmar

- ------------------------------------------------------------------
Puranjay Mohan (1):
      powerpc64/bpf: Add jit support for load_acquire and store_release

Timothy Pearson (6):
      PCI: pnv_php: Clean up allocated IRQs on unplug
      PCI: pnv_php: Work around switches with broken presence detection
      powerpc/eeh: Export eeh_unfreeze_pe()
      powerpc/eeh: Make EEH driver device hotplug safe
      PCI: pnv_php: Fix surprise plug detection and recovery
      PCI: pnv_php: Enable third attention indicator state

Vishal Parmar (1):
      docs: powerpc: add htm.rst to toctree


 Documentation/arch/powerpc/index.rst         |   1 +
 arch/powerpc/include/asm/ppc-opcode.h        |   1 +
 arch/powerpc/kernel/eeh.c                    |   1 +
 arch/powerpc/kernel/eeh_driver.c             |  48 ++--
 arch/powerpc/kernel/eeh_pe.c                 |  10 +-
 arch/powerpc/kernel/pci-hotplug.c            |   3 +
 arch/powerpc/net/bpf_jit_comp64.c            |  82 +++++++
 drivers/pci/hotplug/pnv_php.c                | 248 ++++++++++++++++++--
 tools/testing/selftests/bpf/progs/bpf_misc.h |   3 +-
 9 files changed, 353 insertions(+), 44 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmiQECsACgkQpnEsdPSH
ZJQsahAAjibWx9iFZN1Fek897IIwok0yJ19P2c0m9qp+Euw/r1iCnWcSVtyjSqbv
81Vy3xhNEC4SFv8zQHmiCV9oN5xnKzGRFlKwk6ofN4hGQ816abSeBbOumm85SikP
Dd09RUv3Ac2zQOkXIqcb1+cjJsM/qpXw/SrAtjGhQc5Yg0En5J5pCEK9ouB5xZIF
QH6s9GksNMuKwwjna25D7w2RJo0FlFrTP/bVDSxf9RwiYWW5nFd3FziX5eGHYkO7
mxfHoSvvkW/Ic8CloWXacc9c1X0/Co5vk21AJjqkym71pjf4kE9BGM16+IghujJp
h/j6SQgvpyBDd8sYoK+Y/h3ZDb4K8iDH8bkccogkMIFV7Ydmm3n+m6ZxAFqTy3WB
1iqCkDCGmVqdkhGMwoZRdPQBii024whKCY8XDNM8StQZUCzqLcvynn0b2shCyNtM
k12CCmRl+YtKOEJIFPZ4s9cCDaCI7jHdyjJpis33+4YmIEn9WqS+sd22wr4WWHmd
JfRGpoCBKk214tXS+YZ+gmWHHA3EXWWJZ+/64IPjaz7lPtzl5GX2m2E+ctqbEfTr
7RwPBt2h2gVxD4SMNck8ajuvCMOEGI1CY5UOeSsBXBRIkrggwWVMKVBy11ptWjJ1
oR6cy+Da6gIzhZV6FguOxfctalBbawqv9/tVnA0IwPXrsy70yYs=
=jmtq
-----END PGP SIGNATURE-----

