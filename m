Return-Path: <linux-kernel+bounces-887798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09FC391D2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 05:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D38594E3FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 04:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BEC2D3EE5;
	Thu,  6 Nov 2025 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lr9MjWeY"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39424A04A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404696; cv=none; b=rvR0NLaYbKL4S5ugTaI4U2C325+HCczvJsXne1dKk9UzYUsHNVZfoEvuUu+2QrAOfZAomkBT6qhwU15qBj3MdcozfbOYrDNrre1YpDxXrYizJ2aDwtKoFOzqus19aLk22JJWM5I+OlRsgFjbIa7wuUbnRqD+rmoveMGQWaJ7IBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404696; c=relaxed/simple;
	bh=5iqIv+jZZQizYCdMI/ydF2bJ6VDOyBQniQQxdw+CObU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM0WNA2kqgqOhqc8+W5yn3FNeC7RK0Oy2Q0TtsY4iEhcV/Mdu0ae1I+8U2YFEu3Sv2bJ8UKSPmC9x/Erz1Zlc6I7o9tAPP5Ma9aU3WY2zcBak4DyixDDoDmNb7OQd7W7jxYqDncD/MDV26AIvx+EQTwwlit+9zRu47IYP47ba8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lr9MjWeY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HHWPT007984;
	Thu, 6 Nov 2025 04:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=t6ZGzI+lmWrKHgAQrU3g0zBwXtXocDa7Pt+nSKTsl
	5w=; b=Lr9MjWeYsS6rtxcZuLQXCpVSWr82G/mAc/tMUdanTb75ZluIfpA9zncAl
	jrTNJxHQO33jPgNmGL48lcj1zZv22R742JiM2yq5zB+cneoaOvgJf1+RKfeH2IIg
	7lpTvZdslcO3BY6uwkzI4u8TT8+fRskfGbExvniHWgX9frbdaYZbZVw/EO3h2JGj
	Shr3YRgPJtKVZOosSGr4Vm99weZ2+NoJlhsWWQ1q2ILoQxqncLS+6eXikHVz1y7L
	8tQfcQo7/sgQN3o78qQ/kO59F5yjR8mk5TW0SHTSADvLH/bZyAzsu56ZKiwoXjSF
	FtxYpPqp0Iud0+da4tVNCuma2CfoQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc53f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 04:51:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A64kmnN011733;
	Thu, 6 Nov 2025 04:51:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc53f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 04:51:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A64VAiv012845;
	Thu, 6 Nov 2025 04:51:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y823eu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 04:51:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A64pFUh44827062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 04:51:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF4920040;
	Thu,  6 Nov 2025 04:51:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB4B20049;
	Thu,  6 Nov 2025 04:51:11 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 04:51:11 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Jiri Bohac <jbohac@suse.cz>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
Subject: [PATCH v2 0/5] kexec: reorganize sysfs interface and add new kexec sysfs
Date: Thu,  6 Nov 2025 10:21:02 +0530
Message-ID: <20251106045107.17813-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX5CQx7SCh2kek
 qYAhd++d60ohe22mOKaLVoiYMJNKmwanQW39Aq0TQQdUWR7SsMnS96Kt+4OgWp3TFMqgSw0M+kP
 h9RAd8WyU7DCgdSnU07lyspm/NX9m2u2Nnfk3xJiHRnOS/IKo4ZLHwJBgzTKP4Um4mYxJ/hLAgk
 j9MobE9g+n/n6W8k+nCYiM6jgKuS7yUXtooqtXhFWaCXcB24/0xEAST5qB+4Xe8wA80aYMYIraL
 IqqZGY8bA/Q1dnw666QClbc9Vxzudv4n4ZhZ6ka/WLPEqeDJaQplbfOWlqnTRgvMLV5eWFJ6NwY
 5BbTM4rl+jLlm9Uzh6YtZHFP5yZ8GedvJIwv1DTc8ctjSB9Zf90/46Po70fpMRk+MujbGq+O4Dx
 Ns/FVKH4z5czwndzayr3SIi3y+ypKw==
X-Proofpoint-GUID: BRkJBFIbd1iEaeb1OE7FUCT4H_3rNtGb
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690c2949 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=JfrnYn6hAAAA:8
 a=LRU2jnFezOS3J6eLL00A:9 a=HkZW87K1Qel5hWWM3VKY:22 a=IC2XNlieTeVoXbcui8wp:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 8p2ec5RZks7lsiT5R9iNvRbbcqj20fl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

All existing kexec and kdump sysfs entries are moved to a new location,
/sys/kernel/kexec, to keep /sys/kernel/ clean and better organized.
Symlinks are created at the old locations for backward compatibility and
can be removed in the future [02/05].

While doing this cleanup, missing ABI documentation for the old sysfs
interfaces is added, and those entries are marked as deprecated
[01/05 and 03/05]. New ABI documentation is also added for the
reorganized interfaces. [04/05]

Along with this reorganization, a new sysfs file,
/sys/kernel/kexec/crash_cma_ranges, is introduced to export crashkernel
CMA reservation details to user space [05/05]. This helps tools determine the
total crashkernel reserved memory and warn users that capturing user
pages while CMA is reserved may cause incomplete or unreliable dumps.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org

Sourabh Jain (5):
  Documentation/ABI: add kexec and kdump sysfs interface
  kexec: move sysfs entries to /sys/kernel/kexec
  Documentation/ABI: mark old kexec sysfs deprecated
  kexec: document new kexec and kdump sysfs ABIs
  crash: export crashkernel CMA reservation to userspace

 .../ABI/obsolete/sysfs-kernel-kexec-kdump     |  59 +++++++++
 .../ABI/testing/sysfs-kernel-kexec-kdump      |  61 +++++++++
 kernel/kexec_core.c                           | 118 ++++++++++++++++++
 kernel/ksysfs.c                               |  68 +---------
 4 files changed, 239 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-kernel-kexec-kdump
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-kexec-kdump

-- 
2.51.0


