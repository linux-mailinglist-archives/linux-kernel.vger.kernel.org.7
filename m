Return-Path: <linux-kernel+bounces-747265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D856B131AD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3076B7AABB4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC7C2264BF;
	Sun, 27 Jul 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVXVjafE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BD7080D;
	Sun, 27 Jul 2025 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647499; cv=none; b=E0nVRagVdDX6bVjo85Udil7w96G8Nmkwrpe26MpHi0jLzvU2q2w4FlvcrPTklh8cooP2gruaKHiLsGI0adPqYr2gYv8mP/dRrAvXISJcO+UQ2DwL9R6Ss9fuj6fXxi8MMaTJMoVnsNyt5ySvGkkaxQucDMxPypiMjmPMSIcvN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647499; c=relaxed/simple;
	bh=JZKBZYAEnD2JMnOJ6uq6sX/y3f6cA/dtZlHCa4J6zvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfdQ/5jy+E3l7EtmJsCrEEYpEcq1MB0+F7H5AiG2cuJiic0pKfLWtCGb1SZAvd+lI9RKSPueh0KGl55/s1uMkJBLs0ZFCJw16b/AqiygstaNnzNi8MkqyWutc65bvyrQu44iH4oQyRJ8okxM+e7SsCaPBLvD9gzGyIP3gGcd3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVXVjafE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ACFC4CEEB;
	Sun, 27 Jul 2025 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753647498;
	bh=JZKBZYAEnD2JMnOJ6uq6sX/y3f6cA/dtZlHCa4J6zvU=;
	h=From:To:Cc:Subject:Date:From;
	b=cVXVjafEJPv6BzNl0EbQ0IqCszyCYQ84R7ltbogGB8Y/GEPyeXYPHtbRarX0U6rIR
	 z3j4sF1M+Matcp9hOxQn0Je7TkjiZVwX7RbGAQsVqP4y56jgqB6zvSNpYkjm0j5Y1/
	 WE1fWlay4b25Sr5/SY7T6r/sA8zydWGtqY1kSASgo7rGAofgp8rECrHNlvUJwd88w2
	 gyt9aSTXg8oRhv+786rMzOocQjBP7JwiubKRoBwKGaS1kdSSwu6N6CH3eN8Udtyml5
	 IkPIvTDuVt3wfL7V4GMoDrSETptqzC2SiuSej6q93dgGr79b+qHs0ZRgfge7HjcLfZ
	 untmLXiKvGIDg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 0/7] mm/damon: extend for page faults reporting based access monitoring
Date: Sun, 27 Jul 2025 13:18:06 -0700
Message-Id: <20250727201813.53858-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: Extend DAMON interface between core and operation sets for
operation set driven report-based monitoring such as per-CPU and
write-only access monitoring.  Further introduce an example physical
address space monitoring operation set that uses page faults as the
source of the information.

Background
----------

Existing DAMON operations set implementations, namely paddr, vaddr, and
fvaddr, use Accessed bits of page tables as the main source of the
access information.  Accessed bits has some restrictions, though.  For
example, it cannot tell which CPU or GPU made the access, whether the
access was read or write, and which part of the mapped entity was really
accessed.

Depending on the use case, the limitations can be problematic.  Because
the issue stems from the nature of page table Accessed bit, utilizing
access information from different sources can mitigate the issue.  Page
faults, memory access instructions sampling interrupts, system calls, or
any information from other kernel space friends such as subsystems or
device drivers of CXL or GPUs could be examples of the different
sources.

DAMON separates its core and operation set layer for easy extensions.
The operation set layer handles the low level access information
handling, and the core layer handles more high level work such as the
region-based overhead/accuracy control and access-aware system
operations.  Hence we can extend DAMON to use the different sources by
implementing and using another DAMON operations set.  The core layer
features will still be available with the new sources, without
additional changes.

Nevertheless, the current interface between the core and the operation
set layers is optimized for the Accessed bits case.  Specifically, the
interface asks the operations set if a given part of memory has been
accessed or not in a given time period (last sampling interval).  It is
easy for the Accessed bit use case, since the information is stored in
page tables.  Operation set can simply read the current value of the
Accessed bit.

For some sources other than Accessed bits, such as page faults or
instruction sampling interrupts, the operations set may need to collect
and keep the access information in its internal memory until the core
layer asks the access information.  Only after answering the question,
the information could be dropped.

Implementing such operation set internal memory management woudl be not
very trivial.  Also it could end up multiple similar operation set
implementations having their own internal memory management code that is
unnecessarily duplicated.

Core Layer Changes for Reporting-based Monitoring
-------------------------------------------------

Optimize such possible duplicated efforts, by updating DAMON core layer
to support real time access reporting.  The updated interface allows
operations set implementations to report (or, push) their information to
the core layer, on their preferred schedule.  DAMON core layer will
handle the reports by managing meta data and updating the final
monitoring results (DAMON regions) accordingly.

Also add another operations set callback to determine if a given access
report is eligible to be used for a given operations set.  For example,
if the operations set implementation is for monitoring only specific CPU
or writes, the operations set could ask the core layer to ignore
reported accesses that were made by other CPUs, or were made for reads.

paddr_fault: Page Faults-based Physical Address Space Access Monitoring
-----------------------------------------------------------------------

Using the core layer changes, implement a new DAMON operation set,
namely paddr_fault.  It is the same as the page table Accessed bits
based physical address space monitoring, but uses page faults as the
source of the access information.

Specifically, it installs PAGE_NONE protection to access sampling pages
on damon_operations->prepare_access_checks() callback.  Then, it
captures the following access to the page in the page fault handling
context, and directly reports the findings to DAMON, using
damon_report_access().

For the PAGE_NONE protection use case, introduce a new
change_protection() flag, namely MM_CP_DAMON.  To avoid interfering with
NUMA_BALANCING, the page fault handling invokes fault handling logic of
DAMON or NUMA_BALANCING, based on the NUMA_BALANCING enablement.

This operation set is only for giving examples of how the
damon_report_access() can be used for multiple sources of the
information, and easy testing.  It ain't be merged into the mainline as
is.  I'm currently planning to further develop it for per-CPU access
monitoring by the final version of this patch series.

How Per-CPU or Write-only Monitoring Can Be Implemented
-------------------------------------------------------

The paddr_fault can be extended for per-CPU or write-only monitoring.
We can get the access source CPU or whether it was write access from the
page fault information, and put that into the DAMON report (struct
damon_access_report).  Extending damon_access_report struct with a few
fields for storing the information would be needed.  Then we can make a
new DAMON operation set that is similar to paddr_fault, but checks the
eligibility of each access report, based on the CPU or write
information.  Of course, extending the existing operation set could also
be an option.  Then accesses made by CPUs of no interest or reads can be
ignored, and users can show the per-CPU or write-only accesses using
DAMON.

Expected Users: Scheduling, VM Live Migration and NUMA Page Migrations
----------------------------------------------------------------------

We have ongoing off-list discussions of expected use cases of this patch
series.  We expect this patch series can be used for implementing
per-CPU access monitoring, and it can be useful for L3 cache
utilization-aware threads/process scheduling.  Yet another expected use
case is write-only monitoring, for finding easier live migration target
VM instances.

Also I believe this can be extended for not only per-CPU but any access
entities including GPU-like accelerators, who expose their memory as
NUMA nodes in some setups.  With that, I think we could make a holistic
and efficient access-aware NUMA pages migration system.

Patches Sequence
----------------

The first patch introduces damon_report_access() that any kernel code
that can sleep can use, to report their access information on their
schedule.  The second patch adds DAMON core-operations set interface for
ignoring specific types of data access reports for the given operations
set configuration.  The third patch further implements the report
eligibility check logic for vaddr.  The fourth patch updates the core
layer to really use the reported access information for making the
monitoring results (DAMON regions).

The fifth patch implements a new change_protection() flag, MM_CP_DAMON,
and its fault handling logic for reporting the access to DAMON.  The
sixth patch implements a new page faults based physical address space
access monitoring operation set, namely paddr_fault, using MM_CP_DAMON.
Finally, the seventh patch updates DAMON sysfs interface to support
paddr_fault.

Plan for Dropping RFC
---------------------

This patch series is an RFC for early sharing of the idea that was also
shared on the last LSFMMBPF[1], as 'damon_report_access()' API plan.  We
will further optimize the core layer implementation and add one or more
real operations set implementations that utilize the report-based
interface, by the final version of this patch series.

Of course, concerns we find on RFCs should be addressed.

Revision History
----------------

Changes from RFC v1
(https://lore.kernel.org/20250629201443.52569-1-sj@kernel.org)
- Fixup report reading logic for access absence accounting
- Implement page faults based operations set (paddr_fault)

[1] https://lwn.net/Articles/1016525/

SeongJae Park (7):
  mm/damon/core: introduce damon_report_access()
  mm/damon/core: add eligible_report() ops callback
  mm/damon/vaddr: implement eligible_report()
  mm/damon/core: read received access reports
  mm/memory: implement MM_CP_DAMON
  mm/damon: implement paddr_fault operations set
  mm/damon/sysfs: support paddr_fault

 include/linux/damon.h |  34 ++++++++++++++
 include/linux/mm.h    |   1 +
 mm/damon/core.c       | 101 ++++++++++++++++++++++++++++++++++++++++++
 mm/damon/paddr.c      |  77 +++++++++++++++++++++++++++++++-
 mm/damon/sysfs.c      |   4 ++
 mm/damon/vaddr.c      |   7 +++
 mm/memory.c           |  53 +++++++++++++++++++++-
 mm/mprotect.c         |   5 +++
 8 files changed, 279 insertions(+), 3 deletions(-)


base-commit: 3452e05f01b2a3dd126bd08961cc0df8daa5beee
-- 
2.39.5

