Return-Path: <linux-kernel+bounces-744652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE0B10F84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE37BA54C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955A2EA754;
	Thu, 24 Jul 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PRNFm3So"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6F2ED17B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373820; cv=none; b=We7D7UrVuoElSp92gXvG4lz7JAqSy3JJ4PFOeBvqUp1tThe07N9+rHoy9wMk2S/z+R40BacPTQSw23yXFH8dBr21jp57RJrtn+hl88Emk5PmwSsC4QGY+ShjJfifixHNNVlho/j2pq686zkHZT7AmzemxizwjrH+R6DMMwn4Ua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373820; c=relaxed/simple;
	bh=TJg6HtvC7AL60AP0HArOHhtrDS821WGFzhzEVcX5aCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvtrYiJQFg81SrW79xj7VpUsNAbgBE4lQeYTx+NiF+eLnwHj5UE2uNl+8ilws2PiZ5pldRLEVkeFF7SWnRgpI/9L6pMlcXAuooqOB3KYXqGnclIiIpOcJeVCUnp+/1LQ7i/PECtIm4jVzigpn1T5F6V7mv6VFJFrggr0kZ/hRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PRNFm3So; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRKYl017685;
	Thu, 24 Jul 2025 16:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=CEUH3tloZVV0/KlZuHAz7nJ/FuCLH
	ThVgGLTH13Ooug=; b=PRNFm3SovpVSpFvtxmEcD16/h6uf67Bdma7qBNRWZfGpy
	Knddy/8AQGqEqDWIX93tpTWIs2Jhzb9lMcsP3M+ggryhfL3KsNYBm+dwZOag3LVH
	O6VwsaBHQSZXDUmUqhUIlc5MZ8EEp3h1JPHT8s/gViMsn8qDMMteQfuIYO5xE9pM
	D/ExfEunbKN3PkxSYXlLhbm1qEJXfRV9DNMwPtZknlcqw/hcvhmpIaFAzUNkL27t
	8xG+7UDVKQJUovvs/9xW3VfydGoETCid0aZ+fvlh0iBLpiAfhV2Z+ZSFuILQ/sIY
	OuDVfOFli8OjWcVy8DF0e+ywK0AXYv2CIXVKtimjQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056ehuuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OFrow8014461;
	Thu, 24 Jul 2025 16:16:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNG034466;
	Thu, 24 Jul 2025 16:16:27 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:27 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 00/11] Scheduler time slice extension
Date: Thu, 24 Jul 2025 16:16:14 +0000
Message-ID: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240123
X-Proofpoint-ORIG-GUID: SvJ5YZ9KO4X9uOrzZxnKmExV__rAl-X-
X-Proofpoint-GUID: SvJ5YZ9KO4X9uOrzZxnKmExV__rAl-X-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfXx1TFWIAsOv6h
 MqM9+QP28v2yNKXMmYJ9M9foMgENq2CS7cpO2R8Pb+yd8j5v/wQ06NwPevFcbN3WCItNM+whZeq
 aF/PhCfkKJkVyD33Nv1d+++JeNoHhVQzPItLSM8HcS1XTXhvuNvp2eV0n6F+MR+BkSA0JsmwJq9
 3nMLIdjGqO0eHyqJtvv1mXVKtaKFwjDS+SLVD1hj+TDpqqctSxnr+cywpNAlvz2XW5A4z+UAlt9
 LNmM2cbj/7k8kwg13/EM024GHY/eqqGrd4uXv6UftvjXz096sWqsW7Jpsk0KTBYetWaN02vEcPh
 VK2GhzPdUpNc0tSd/o40BmqNz35jGczW5vfQT+L+3fEg5zrG4xb/dqYvBLUaDZdkfJSfjrmVuAQ
 iA3cngNYhrK6RmP7Fp/2DJ5ZyzPGd+DA0HodkdgkHN2qS/whAdsPfkmxQyHaWDpcNtlwQZWW
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=68825c5d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=meVymXHHAAAA:8
 a=WsHKUha7AAAA:8 a=vjCvG0qzlwfpJfpLelEA:9 a=2JgSa4NbpEOStq-L5dxp:22
 a=H4LAKuo8djmI0KOkngUh:22 cc=ntf awl=host:12061

Based on v6.16-rc3.

Patches 7-11 in this series are an attempt to implement the API/mechanism 
for an RT thread to indicate not to delay scheduling it when the thread
running on the cpu requests extending its time slice, as suggested by
Thomas Gleixner. This is required to address the concern that with the use 
of the proposed scheduler time slice extension feature, a normal thread 
can delay the scheduling of an RT thread.

This will require a new TIF flag(TIF_NEED_RESCHED_NODELAY), which will be 
set on the running thread when this RT thread gets woken up and is enqueued. 
The API is only allowed for use by RT(RR, FIFO) threads. 

Implementation of TIF_NEED_RESCHED_NODELAY patches is on the lines of
how TIF_NEED_RESCHED_LAZY was added. However, TIF_NEED_RESCHED_NODELAY
will be effective only with the scheduler time slice extension feature
(i.e, when CONFIG_RSEQ_RESCHED_DELAY config option is enabled).

Introduces prctl APIs to set and get the sched_nodelay flag. Adds a
new 1-bit member(sched_nodelay) to the struct task_struct to store this
flag, as there is no more room for a new PF* flag. This flag will be 
inherited across fork and exec. 

The API provides per-thread control to decide if it can be delayed
or not. Also, a kernel parameter is added to disable delaying scheduling of
all RT threads, if necessary, when the scheduler time slice extension feature
is enabled.

The above change is more of an RFC, looking for feedback on the
approach. 

Patches 1-6  have been updated based on comments from the V6 patch series.

---------------- cover letter previously sent --------------------------------
A user thread can get preempted in the middle of executing a critical
section in user space while holding locks, which can have undesirable affect
on performance. Having a way for the thread to request additional execution
time on cpu, so that it can complete the critical section will be useful in
such scenario. The request can be made by setting a bit in mapped memory,
such that the kernel can also access to check and grant extra execution time
on the cpu. 

There have been couple of proposals[1][2] for such a feature, which attempt
to address the above scenario by granting one extra tick of execution time.
In patch thread [1] posted by Steven Rostedt, there is ample discussion about
need for this feature.

However, the concern has been that this can lead to abuse. One extra tick can
be a long time(about a millisec or more). Peter Zijlstra in response posted a 
prototype solution[5], which grants 50us execution time extension only.
This is achieved with the help of a timer started on that cpu at the time of
granting extra execution time. When the timer fires the thread will be
preempted, if still running. 

This patchset implements above solution as suggested, with use of restartable
sequences(rseq) structure for API. Refer [3][4] for further discussions.


v7:
- Addressed comments & suggestions from Thomas Gleixner & Prateek Nayak.
  Renamed 'sched_time_delay' to 'rseq_delay_resched'. Made it a 2-bit 
  member to store 3 states NONE, PROBE & REQUESTED as suggested by
  Thomas Gleixner. Also refactored some code in patch 1.
- Renamed the config option to 'CONFIG_RSEQ_RESCHED_DELAY' and
  added it in patch 1. Added SCHED_HRTICK dependency.
- Patches 7-11 are an attempt to implement the API/mechanism 
  Thomas suggested. They introduce a prctl() api which lets an RT thread
  indicate not to delay scheduling it when some thread running on
  the cpu requests extending its time slice.

v6:
https://lore.kernel.org/all/20250701003749.50525-1-prakash.sangappa@oracle.com/
- Rebased onto v6.16-rc3. 
  syscall_exit_to_user_mode_prepare() & __syscall_exit_to_user_mode_work()
  routines have been deleted. Moved changes to the consolidated routine
  syscall_exit_to_user_mode_work()(patch 1).
- Introduced a new config option for scheduler time slice extension
  CONFIG_SCHED_PREEMPT_DELAY which is dependent on CONFIG_RSEQ.
  Enabled by default(new patch 7). Is this reasonable?
- Modified tracepoint to a conditional tracepoint(patch 5), as suggested
  by Steven Rostedt.
- Added kernel parameters documentation for the tunable
  'sysctl_sched_preempt_delay_us'(patch 3)

v5:
https://lore.kernel.org/all/20250603233654.1838967-1-prakash.sangappa@oracle.com/
- Added #ifdef CONFIG_RSEQ and CONFIG_PROC_SYSCTL for sysctl tunable
  changes(patch 3).
- Added #ifdef CONFIG_RSEQ for schedular stat changes(patch 4).
- Removed deprecated flags from the supported flags returned, as
  pointed out by Mathieu Desnoyers(patch 6).
- Added IF_ENABLED(CONFIG_SCHED_HRTICK) check before returning supported
  delay resched flags.

v4:
https://lore.kernel.org/all/20250513214554.4160454-1-prakash.sangappa@oracle.com
- Changed default sched delay extension time to 30us
- Added patch to indicate to userspace if the thread got preempted in
  the extended cpu time granted. Uses another bit in rseq cs flags for it.
  This should help the application to check and avoid having to call a
  system call to yield cpu, especially sched_yield() as pointed out
  by Steven Rostedt.
- Moved tracepoint call towards end of exit_to_user_mode_loop().
- Added a pr_warn() message when the 'sched_preempt_delay_us' tunable is
  set higher then the default value of 30us.
- Patch to add an API to query if sched time extension feature is supported. 
  A new flag to sys_rseq flags argument called 'RSEQ_FLAG_QUERY_CS_FLAGS',
  is added, as suggested by Mathieu Desnoyers. 
  Returns bitmask of all the supported rseq cs flags, in rseq->flags field.

v3:
https://lore.kernel.org/all/20250502015955.3146733-1-prakash.sangappa@oracle.com
- Addressing review comments by Sebastian and Prateek.
  * Rename rseq_sched_delay -> sched_time_delay. Move its place in
    struct task_struct near other bits so it fits in existing word.
  * Use IS_ENABLED(CONFIG_RSEQ) instead of #ifdef to access
    'sched_time_delay'.
  * removed rseq_delay_resched_tick() call from hrtick_clear().
  * Introduced a patch to add a tracepoint in exit_to_user_mode_loop(),
    suggested by Sebastian.
  * Added comments to describe RSEQ_CS_FLAG_DELAY_RESCHED flag.

v2:
https://lore.kernel.org/all/20250418193410.2010058-1-prakash.sangappa@oracle.com/
- Based on discussions in [3], expecting user application to call sched_yield()
  to yield the cpu at the end of the critical section may not be advisable as
  pointed out by Linus.  

  So added a check in return path from a system call to reschedule if time
  slice extension was granted to the thread. The check could as well be in
  syscall enter path from user mode.
  This would allow application thread to call any system call to yield the cpu. 
  Which system call should be suggested? getppid(2) works.

  Do we still need the change in sched_yield() to reschedule when the thread
  has current->rseq_sched_delay set?

- Added patch to introduce a sysctl tunable parameter to specify duration of
  the time slice extension in micro seconds(us), called 'sched_preempt_delay_us'.
  Can take a value in the range 0 to 100. Default is set to 50us.
  Setting this tunable to 0 disables the scheduler time slice extension feature.

v1: 
https://lore.kernel.org/all/20250215005414.224409-1-prakash.sangappa@oracle.com/


[1] https://lore.kernel.org/lkml/20231025054219.1acaa3dd@gandalf.local.home/
[2] https://lore.kernel.org/lkml/1395767870-28053-1-git-send-email-khalid.aziz@oracle.com/
[3] https://lore.kernel.org/all/20250131225837.972218232@goodmis.org/
[4] https://lore.kernel.org/all/20241113000126.967713-1-prakash.sangappa@oracle.com/
[5] https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net/
[6] https://lore.kernel.org/all/1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com/

Prakash Sangappa (11):
  sched: Scheduler time slice extension
  sched: Indicate if thread got rescheduled
  sched: Tunable to specify duration of time slice extension
  sched: Add scheduler stat for cpu time slice extension
  sched: Add tracepoint for sched time slice extension
  Add API to query supported rseq cs flags
  sched: Add API to indicate not to delay scheduling
  sched: Add TIF_NEED_RESCHED_NODELAY infrastructure
  sched: Add nodelay scheduling
  sched, x86: Enable nodelay scheduling
  sched: Add kernel parameter to enable delaying RT threads

 .../admin-guide/kernel-parameters.txt         |  8 ++
 Documentation/admin-guide/sysctl/kernel.rst   |  8 ++
 arch/x86/Kconfig                              |  1 +
 arch/x86/include/asm/thread_info.h            |  2 +
 include/linux/entry-common.h                  | 18 ++--
 include/linux/entry-kvm.h                     |  4 +-
 include/linux/sched.h                         | 47 +++++++++-
 include/linux/thread_info.h                   | 11 ++-
 include/trace/events/sched.h                  | 31 +++++++
 include/uapi/linux/prctl.h                    |  3 +
 include/uapi/linux/rseq.h                     | 19 ++++
 init/Kconfig                                  |  7 ++
 kernel/Kconfig.preempt                        |  3 +
 kernel/entry/common.c                         | 36 ++++++-
 kernel/entry/kvm.c                            |  3 +-
 kernel/rseq.c                                 | 71 ++++++++++++++
 kernel/sched/core.c                           | 93 ++++++++++++++++++-
 kernel/sched/debug.c                          |  4 +
 kernel/sched/rt.c                             | 10 +-
 kernel/sched/sched.h                          |  1 +
 kernel/sched/syscalls.c                       |  4 +
 kernel/sys.c                                  | 18 ++++
 22 files changed, 380 insertions(+), 22 deletions(-)

-- 
2.43.5


