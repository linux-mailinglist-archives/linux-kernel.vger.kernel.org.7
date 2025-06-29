Return-Path: <linux-kernel+bounces-708430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C87AED03C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 22:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA893B4C67
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCDD238C3D;
	Sun, 29 Jun 2025 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGMJ9S+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26E230BC3;
	Sun, 29 Jun 2025 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228087; cv=none; b=VWPlcN9IQBp063JHgtEQTNyeQGrbAy3l39HaRLVRLuYuDOfgS3UT6HAz6hE3pj/kyRnUkFr9AnWk6ftURFUqW+/mCyui5QEVlapfrx0vKBCQfrkbShVmUAEwcmtljQPw9s9AcurKyaCoJDNQpGgRugVNq8hYz1W/pgEyf2wmyhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228087; c=relaxed/simple;
	bh=YmhJzLmrTV4n3mJcdv9jvwEmM2fyyH58/UncPVtVPeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rE9spatzx/ZMFkidklwS5k3kfm+lLBbB5Yn2nf0k89ExPYC1pmA9GkNLSlQKlqpGXVNAgEFmjbwjd3t1QpWojL8FEEHqYpU74gtuQuLy4ipc6EPUeQFMiSft2sFJhQxLtU80e/hp+YDSO9RUon/8H+ELWQ0BColXRpwfV+GAEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGMJ9S+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BF3C4CEEB;
	Sun, 29 Jun 2025 20:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751228086;
	bh=YmhJzLmrTV4n3mJcdv9jvwEmM2fyyH58/UncPVtVPeQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KGMJ9S+WvCwARjvH/iV27nmgwV09I7E3caQcfwtrvVU2+xaXIstlxI6sJWLdKScwz
	 TPt2TYz3WDjXLTo4RujNo21MOfFSL8aGnzPYvkS0Sww2QcVTesBNWOcvmy/V20BdOU
	 FQOh/7iUgNYRq9h7t98QG+P8t/bsiHTHnYV80g6ywdqPe8PTIaPph+CcWls9S2MEfu
	 ALy785hdz+aDLlD9tsF5l2DUK2tXebSgMbpOvjGUKnHrZzapBj5S3U1yV5JflQMqlc
	 LkD/2zUmX+aarkRA+MBlEaf6gnWhK6Fg5CVkKWlzPnmt5VVwOySMTTwvhvXO0QjAFv
	 pUl4Ip1IQQmhg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/6] mm/damon/core: support multi-source reports-based access monitoring
Date: Sun, 29 Jun 2025 13:14:37 -0700
Message-Id: <20250629201443.52569-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: Extend DAMON core-operations set layers interface for operations
set driven report-based monitoring such as per-CPU and write-only access
monitoring.

Background
----------

Existing DAMON operations set implementations, namely paddr, vaddr, and
fvaddr, use Accessed bits of page tables as the main source of the
access information.  Accessed bits has some restrictions, though.  For
example, it cannot tell which CPU or CPU made the access, whether the
access was read or write, and which part of the mapped entity was really
accessed.  Also, it cannot capture accesses done without page table
walks, e.g.,  TLB hit case, or unmapped pages.  Exisiting DAMON
operations set can capture the accesses to unmapped pages utilizing
PG_Idle, though.

Depending on the use case, the limitations can be problematic.  Because
the issue stems from the nature of page table Accessed bit, utilizing
access information from different sources can mitigate the issue.  Page
faults, memory access instructions sampling interrupts, system calls, or
any information from other kernel space friends such as subsystems or
device drivers of CXL or GPUs could be examples of the different
sources.

DAMON separates its core and operations set layer.  Operations set layer
handles the low level access information handling, and the core layer
handles more high level works such as the region-based overhead/accuracy
control and access-aware system operations.  Hence we can extend DAMON
to use the different sources by implementing and using another DAMON
operations set.  The core layer features will still be available with
the new sources, without additional changes.

Nevertheless, the current interface between the core and the operations
set layers is optimized for the Accessed bits case.  Specifically, the
interface asks the operations set if a give part of memory has accessed
or not in a given time period (last sampling interval).  It is easy for
Accessed bit use case, since operations set can simply read the current
value of the Accessed bit, which is already well manageed for each
mapping entities by the memory management subsystems.  For some sources
other than Accessed bits, the operations set may need to keep the access
information on its own, and answer to the core layer's question by
reading its own access information collection.  Similar implementations
of such operations set internal access information may required for
multiple operations set implementations.

Core Layer Changes for Reporting-based Monitoring
-------------------------------------------------

Optimize such possible duplicated efforts, by updating DAMON core layer
to support real time access reporting.  The updated interface allows
operations set implementations to report (or, push) their information to
the core layer, on their preferred schedule.  DAMON core layer will
handle the reports by managing meta data and updating the final
monitoring results (DAMON regions) accordingly.

Also add another operations set callback to determine if a given access
report is eligible to be used for given operations set.  For example, if
the operations set implementation is for monitoring only specific CPU or
writes, the operations set could ask core layer to ignore reported
accesses that made by other CPUs, or was for reads.

How Per-CPU or Write-only Monitoring Can Be Implemented
-------------------------------------------------------

With these core layer changes, we can implement new DAMON operations set
that utilizes different information source for page table Accessed bits
restricted use cases.  For example, to utilize page faults information,
we could implement an operations set that installs the fake page fault
protections to access sampling pages per DAMON region for every sampling
interval.  For that, damon_operations->preapre_access_checks() callback
coudl be a good place to implement.  Then the developer would need to
further update PROT_NONE page fault handlers to report the access events
using the new report API, namely damon_report_access().  The report
could contain information about which CPU, process, or thread made the
access, and whether the access is for read or write.  And finally
implementing the report-ignore logic to ignore accesses made by CPUs of
no interest or reads, we can do per-CPU or write-only access monitoring.

Patches Sequence
----------------

The first patch introduces damon_report_access() that any kernel code
that can sleep can use, to report their access information on their
schedule.  The second patch adds DAMON core-operations set interface for
ignoring specific types of data access reports for the given operations
set configuration.  The third patch further update core layer to really
use the reported access information for making the monitoring results
(DAMON regions) for API callers and ABI users.  The fourth patch updates
virtual address operations set to ignore access reports for none-target
virtual spaces.

The fifth and sixth patches are for only showing possible future
extensions of the report struct for per-CPU and write-only monitoring.

Plan for Dropping RFC
---------------------

This patch series is an RFC for early sharing of the idea that also
shared on the last LSFMMBPF[1], as 'damon_report_access()' API plan.
I actually wanted to post this later, but recently I received a few
questiosn about this, so sharing this very early version.  The
implementation is pretty simple and unoptimized.  No real use case of
the changed interface (new operations set implementation) exists.  We
will further optimize the core layer implementation and add one or more
real operations set implementations that utilizing the report-based
interface, by the final version of this patch series.

[1] https://lwn.net/Articles/1016525/

SeongJae Park (6):
  mm/damon/core: introduce damon_report_access()
  mm/damon/core: add eliglble_report() ops callback
  mm/damon/core: check received access reports
  mm/damon/vaddr: impleement eligible_report() callback
  mm/damon: add node_id to damon_access_report
  mm/damon: add write field to damon_access_report

 include/linux/damon.h | 30 +++++++++++++++++
 mm/damon/core.c       | 76 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/vaddr.c      |  7 ++++
 3 files changed, 113 insertions(+)


base-commit: 78af14fb3cf19eea2f204650a0090aa2c7022257
-- 
2.39.5

