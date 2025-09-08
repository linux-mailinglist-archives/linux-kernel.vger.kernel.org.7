Return-Path: <linux-kernel+bounces-806755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA365B49B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7393BAF90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EDE2DD5F0;
	Mon,  8 Sep 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zz/hBNzV"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9812DCF61
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365443; cv=none; b=UEz6cWziWPeWaz3WSslWY8xepMpaZA91LR+8GMRZd0jJSxeXz43Aakt+NcIvyT4l4+YV9t/StDJlhHejG6g/5BE2bwmGdJvMQTQ4rSJLMTGOFUvz6sc6CdGyLn1vw54jSmJtcRL2ux0W8fzbSu+SPWGKFSfY6/ObIOiTl5H/Vus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365443; c=relaxed/simple;
	bh=Hh4z/dC7vyiiGCjUoxnvIevcOOtrwE7OFXPugPChxf0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bDQbJq44GN7dLSpHEbiQGBEzxJUIFU+FoDyHoUhhLX4/eHTy6u6MiJvu2vS8BF+7ck9JmqfIRtzKu275MU3uCXbcj9a2dOYcgSl/KpH3WLciFhchWpD4KN3WKqCOIB5OLTNsX8vRuNm6+Eka+TI2/2f+8dl6dzBztUE2tJ9XPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zz/hBNzV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GqNe0004387;
	Mon, 8 Sep 2025 21:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=TxXmtbRDof/tqCBn2kWDQQrJuPkP
	OHGNbejq/garmMw=; b=Zz/hBNzV23CVHkbY1r49upeCgiEkaMkytX0/4UZ3+FUz
	4H7+DsbvQBRDXouOPTm0PoXgKcc1aCYT6RmB9vNjl1RQ7XMuftoLtirW/wWrrGwZ
	6QrxfSSDAygjJPC9FH4RTVtg+UstncVIcuNIBhnQescnesfk/BK6ALb/9jjtUgPa
	CEPaV0aV8TrnpbQ8b8MpxoxBoH4d1bkCH6oZ7S4kaBhiW5Xt0nXNUlWagne+2r7Q
	ejB47ixr3aw678NjxK2vkysInKrMBVN8G4dNDUqPtF+4pkfBpBahW9fHSJuoIS7r
	xVdrw8a1/IuTqKb/4pN3VAnSa1ZlZTOjnj/+2OGiuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsksrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 21:03:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588KvUCR003431;
	Mon, 8 Sep 2025 21:03:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsksrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 21:03:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588KCMBU020458;
	Mon, 8 Sep 2025 21:03:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0r33d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 21:03:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588L3Lg454723042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 21:03:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A434820040;
	Mon,  8 Sep 2025 21:03:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C341020049;
	Mon,  8 Sep 2025 21:03:13 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com.com (unknown [9.39.29.251])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 21:03:13 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, oleg@redhat.com, kees@kernel.org,
        luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com,
        deller@gmx.de, ldv@strace.io, macro@orcam.me.uk, charlie@rivosinc.com,
        akpm@linux-foundation.org, bigeasy@linutronix.de,
        ankur.a.arora@oracle.com, sshegde@linux.ibm.com, naveen@kernel.org,
        thomas.weissschuh@linutronix.de, Jason@zx2c4.com, peterz@infradead.org,
        tglx@linutronix.de, namcao@linutronix.de, kan.liang@linux.intel.com,
        mingo@kernel.org, oliver.upton@linux.dev, mark.barnett@arm.com,
        atrajeev@linux.vnet.ibm.com, rppt@kernel.org, coltonlewis@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 0/8] Generic IRQ entry/exit support for powerpc
Date: Tue,  9 Sep 2025 02:32:28 +0530
Message-ID: <20250908210235.137300-2-mchauras@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX/kn0XNBk1pqh
 G6hMShw5lExP8JA/wbunQ2Ba023Q0Z7fiIaJRJSXOdKZQWUunO87kYNNKyCd/s7Eu5sBGhwK3Wq
 fWkwMGuoxDTrvQL8kg783l6iGDnZN5t8AhfqHLdRoyrJvQpQEgI/UYJhYG40+MzJmsfo4vF1OKj
 GKTarqX9tIHwjnqyPjXn9ZDmRUFblSyWydhXl6zjF5/9Luu4JoO3+/hdw0giBnw/pPIlnfFYzoj
 rNQwQhjtXM724/FNcFGM+nQDGtXjCIblnlQimxifCvvJkfxc25dx8RsLfMPdZHIpFJ0zMSeRlD3
 XtQS82jiFFV8ZqulAUHE49booIPITHxHuoySLTIbPzYtgc5t4hNElcS68MPiOqx5uqWP6XyupHe
 HmnHmWE4
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68bf449f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=4vtfHP31wVu_lv1VMw4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TQqEA0mI5BoNRm1Y_yetjOoNdhDII7SK
X-Proofpoint-ORIG-GUID: txrgkYK7in8xLtAk-A3R7EXaGmrixyXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

Adding support for the generic irq entry/exit handling for PowerPC. The
goal is to bring PowerPC in line with other architectures that already
use the common irq entry infrastructure, reducing duplicated code and
making it easier to share future changes in entry/exit paths.

This is slightly tested on ppc64le.

The performance benchmarks from perf bench basic syscall are below:

| Metric     | W/O Generic Framework | With Generic Framework | Improvement |
| ---------- | --------------------- | ---------------------- | ----------- |
| Total time | 0.885 [sec]           | 0.880 [sec]            | ~0.56%      |
| usecs/op   | 0.088518              | 0.088005               | ~0.58%      |
| ops/sec    | 1,12,97,086           | 1,13,62,977            | ~0.58%      |

Thats close to 0.6% improvement with this.

Changelog:
V1 -> V2: Support added for irq with generic framework.

Mukesh Kumar Chaurasiya (8):
  powerpc: rename arch_irq_disabled_regs
  powerpc: Prepare to build with generic entry/exit framework
  powerpc: introduce arch_enter_from_user_mode
  powerpc: Introduce syscall exit arch functions
  powerpc: add exit_flags field in pt_regs
  powerpc: Prepare for IRQ entry exit
  powerpc: Enable IRQ generic entry/exit path.
  powerpc: Enable Generic Entry/Exit for syscalls.

 arch/powerpc/Kconfig                    |   2 +
 arch/powerpc/include/asm/entry-common.h | 550 ++++++++++++++++++++++++
 arch/powerpc/include/asm/hw_irq.h       |   4 +-
 arch/powerpc/include/asm/interrupt.h    | 393 +++--------------
 arch/powerpc/include/asm/ptrace.h       |   2 +
 arch/powerpc/include/asm/stacktrace.h   |   8 +
 arch/powerpc/include/asm/syscall.h      |   5 +
 arch/powerpc/include/asm/thread_info.h  |   1 +
 arch/powerpc/include/uapi/asm/ptrace.h  |  14 +-
 arch/powerpc/kernel/asm-offsets.c       |   1 +
 arch/powerpc/kernel/interrupt.c         | 251 ++---------
 arch/powerpc/kernel/interrupt_64.S      |   2 -
 arch/powerpc/kernel/ptrace/ptrace.c     | 142 +-----
 arch/powerpc/kernel/signal.c            |   8 +
 arch/powerpc/kernel/syscall.c           | 119 +----
 arch/powerpc/kernel/traps.c             |   2 +-
 arch/powerpc/kernel/watchdog.c          |   2 +-
 arch/powerpc/perf/core-book3s.c         |   2 +-
 18 files changed, 698 insertions(+), 810 deletions(-)
 create mode 100644 arch/powerpc/include/asm/entry-common.h

-- 
2.51.0


