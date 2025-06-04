Return-Path: <linux-kernel+bounces-673662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FF4ACE45A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 20:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E3A172CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961020127A;
	Wed,  4 Jun 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3bhN1iP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECA1F4625;
	Wed,  4 Jun 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061892; cv=none; b=b1e5qI7038UgI3SzT1fYImwgV+XwWUVlBQsWpc+x2mxRZbmrWKfErmeZqqRhVOZrIOt0uwcnsQaPxQQdkGrQkyIcTDh03iNhn7hAJpU3yleka1P2uYcFnxGb7NTbamRPJeAjt4dP5TOMchk84W3ueulbSlJZmZqbnqZVEX4b71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061892; c=relaxed/simple;
	bh=TTccoSC8u0U8JAyudIFqRLqdhcUIXwmp4ws5Q3WnaBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c2dsi7TVDOHJFBt//kzpZT0YlBDSE+wbKY1PbIAMhKjZed7Kyi97vo44dlaCsLPZ4CIceU/jXSv/GZ30IJ7ce7fCJkFx1cOBj5XhcKX4iuXuGHiDWuX3ltq9NUx3F7jBpUFx1ow4BlvuwDDwoYEotlHKldAN7ghnXnAfeeaPoIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3bhN1iP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E4CC4CEE4;
	Wed,  4 Jun 2025 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749061891;
	bh=TTccoSC8u0U8JAyudIFqRLqdhcUIXwmp4ws5Q3WnaBM=;
	h=From:To:Cc:Subject:Date:From;
	b=d3bhN1iPy3ThjZWVrgAwb3qTfEDDILFdEoQEAem2WbVuLwufaUG5pQsbck2GuH8yZ
	 RPR9lepicdrnPN1ucrSbfEciCHIc9cRwndS0tJO1a0nWiqzGt3XYpHT9z55FZJYu5K
	 U2ca/1bNy1K94/OdQ3SRchpMz27OrmWBGHZ/Nkb2eVsBK0MiEAAlM907ZdZhErAQ+0
	 rNjgXb9y2Kmh3UU5g0MiP2wZkWkit7/nuWcNMpwrpMuLRSi9OaObaACQvYFzrOzCY+
	 mHHKBcM/4ynaHfJG/OhSDhhUGg+tYIoKgZnyVEAja/vjG7f7zYIQCx52E60c4Hzh6C
	 ppSloIVZ1twig==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/4] mm/damon: introduce DAMON_STAT for simple and practical access monitoring
Date: Wed,  4 Jun 2025 11:31:23 -0700
Message-Id: <20250604183127.13968-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON-based access monitoring is not simple due to required DAMON
control and results visualizations.  Introduce a static kernel module
for making it simple.  The module can be enabled without manual setup
and provides access pattern metrics that easy to fetch and understand
the practical access pattern information, namely estimated memory
bandwidth and memory idle time percentiles.

Background and Problems
=======================

DAMON can be used for monitoring data access patterns of the system and
workloads.  Specifically, users can start DAMON to monitor access events
on specific address space with fine controls including address ranges to
monitor and time intervals between samplings and aggregations.  The
resulting access information snapshot contains access frequency
(nr_accesses) and how long the frequency was kept (age) for each byte.

The monitoring usage is not simple and practical enough for production
usage.  Users should first start DAMON with a number of parameters, and
wait until DAMON's monitoring results capture a reasonable amount of the
time data (age).  In production, such manual start and wait is
impractical to capture useful information from a high number of machines
in a timely manner.

The monitoring result is also too detailed to be used on production
environments.  The raw results are hard to be aggregated and/or compared
for production environments having a large scale of time, space and
machines fleet.

Users have to implement and use their own automation of DAMON control
and results processing.  It is repetitive and challenging since there is
no good reference or guideline for such automation.

Solution: DAMON_STAT
====================

Implement such automation in kernel space as a static kernel module,
namely DAMON_STAT.  It can be enabled at build, boot, or run time via
its build configuration or module parameter.  It monitors the entire
physical address space with monitoring intervals that auto-tuned for a
reasonable amount of access observations and minimum overhead.  It
converts the raw monitoring results into simpler metrics that can easily
be aggregated and compared, namely estimated memory bandwidth and idle
time percentiles.

Understanding of the metrics and the user interface of DAMON_STAT is
essential.  Refer to the commit messages of the second and the third
patches of this patch series for more details about the metrics.  For
the user interface, the standard module parameters system is used.
Refer to the fourth patch of this patch series for details of the user
interface.

Discussions
===========

The module aims to be useful on production environments constructed with
a large number of machines that run a long time.  The auto-tuned
monitoring intervals ensure a reasonable quality of the outputs.  The
auto-tuning also ensures its overhead be reasonable and low enough to be
enabled always on the production.  The simplified monitoring results
metrics can be useful for showing both coldness (idle time percentiles)
and hotness (memory bandwidth) of the system's access pattern.  We
expect the information can be useful for assessing system memory
utilization and inspiring optimizations or investigations on both kernel
and user space memory management logics for large scale fleets.

We hence expect the module is good enough to be just used in most
environments.  For special cases that require a custom access monitoring
automation, users will still benefit by using DAMON_STAT as a reference
or a guideline for their specialized automation.

Revision History
================

Changes from v1
(https://lore.kernel.org/20250526210936.2744-1-sj@kernel.org)
- Wordsmith cover letter for usage document reference
- Rebase to latest mm-new

Changes from RFC
(https://lore.kernel.org/20250519164415.43935-1-sj@kernel.org)
- Add an admin-guide documentation
- Wordsmith commit messages
- Rebase to latest mm-new

SeongJae Park (4):
  mm/damon: introduce DAMON_STAT module
  mm/damon/stat: calculate and expose estimated memory bandwidth
  mm/damon/stat: calculate and expose idle time percentiles
  Docs/admin-guide/mm/damon: add DAMON_STAT usage document

 Documentation/admin-guide/mm/damon/index.rst |   1 +
 Documentation/admin-guide/mm/damon/stat.rst  |  69 ++++++
 mm/damon/Kconfig                             |  16 ++
 mm/damon/Makefile                            |   1 +
 mm/damon/stat.c                              | 245 +++++++++++++++++++
 5 files changed, 332 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/stat.rst
 create mode 100644 mm/damon/stat.c


base-commit: c28c2c0b515650b906025a5c41dc0989155720dd
-- 
2.39.5

