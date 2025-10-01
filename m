Return-Path: <linux-kernel+bounces-839337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56AFBB16A5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD77188CA4F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211D2D3EC7;
	Wed,  1 Oct 2025 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rR7ab9TO"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507E2C21F6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341394; cv=none; b=aKsBC04g9vGsCRaPrrA8rJ3JTHbu4JIOkJOT9ASuIqOB4BNs8hPZg3LtBL6SBqToGPyETGnu56rUX5B/xmtoIni1TkGFbFCSWp+UJa8R2X9xGkYFeY1+Fj0wVkrAeKLPlY4A/7hXF019fTOttSr+OPZgVcg3ohMbAXqhCq4/18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341394; c=relaxed/simple;
	bh=R40V+2RawauiPnXr3u1QBgd9+kra6CcFCPt+bg2yDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4y06fCsfcUOF68pe0C7KJlks4C6CXU5EVQtY0WIGU7iCR4Chq0D1GiAOaD8yS8+3nCTwWv07VHV5aX7kWuwyGHSN5PzmhwtEVVkEerCX0pPa5s6aCS4RU92CSH9/rAIH/mlMDi1BCzDDDZyG0Mvh+tHdBXFke/XKsbKjAONiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rR7ab9TO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RPq+VgOKsxNu+oCprJxr+nljWMfU2DwvZUq2//omNlQ=; b=rR7ab9TOJwxAgwL9Z26MYBb6rI
	idhwdt51Y1nFIEVoY/Vr+I2R+5B1j2hbhnT8E/s44Zs4FW5FkpH55UPJQOInO7TXmzm+gm/Z759jR
	Q9C73kLG8AIc9/jeJPgnIFN0adb7xIyJVp44+nPVAbCAoqxfVhvyLP/+Et9wxg1JMWwlFH7oZ/3GI
	wHwfg+R321O2ydmmhX8pa5w8QYCLGeaJY1g25AMmAYLNXN4JuIvp36bx48PxDIlLMot/tDkDk1iw9
	IzNIqEAbr0uwtrvkceROmB861h37vEC7ggvB8qB1FyYyThWjw3WcQ305lwCl1nKpnNkdl5Pt3bX/P
	oHtEa4+g==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v413r-002xd4-67; Wed, 01 Oct 2025 19:56:19 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: [PATCH v2 0/5] mm/page_owner: add debugfs files 'show_handles' and 'show_stacks_handles'
Date: Wed,  1 Oct 2025 14:56:06 -0300
Message-ID: <20251001175611.575861-1-mfo@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
 - v2:
   - Make context/usecase and hashing in userspace more explicit
     and add an example in the cover letter. (Michal Hocko)
   - Use different output files. (Michal Hocko, Vlastimil Babka)
   - Add context struct for plumbing flags from debugfs_create_file()
     down to stack_print(), avoiding more struct {file,seq}_operations
     for the new files.
   - Simplify commit messages.

 - v1:
   https://lore.kernel.org/linux-mm/20250924174023.261125-1-mfo@igalia.com/

Context:

The page_owner debug feature can help understand a particular situation in
in a point in time (e.g., identify biggest memory consumers; verify memory
counters that do not add up).

Another useful usecase is to collect data repeatedly over time, and use it
for profiling, monitoring, and even comparing different kernel versions,
at the stack trace level (e.g., watch for trends, leaks, correlations, and
regressions).

For this usecase, userspace periorically collects the data from page_owner
and organizes it in data structures appropriate for access per-stack trace.

Problem:

The usecase of tracking memory usage per stack trace (or tracking it for
a particular stack trace) requires uniquely identifying each stack trace
(i.e., keys to store their memory usage over periodic data collections).

This has to be done for every stack trace in every sample/data collection,
even if tracking only one stack trace (to identify it among all others).

Therefore, an approach like hashing the stack traces in userspace to create
unique keys/identifiers for them during post-processing can quickly become
expensive, considering the repetition and a growing number of stack traces.

Solution:

Fortunately, the kernel can provide a unique identifier for stack traces
in page_owner, which is the handle number in stackdepot. This eliminates
the need for creating keys (hashing) in userspace during post-processing.

Additionally, with that information, the stack traces themselves are not
needed until the memory usage should be resolved from a handle to a stack
trace (say, to look at the stack traces of a few top consumers). This can
reduce the amount of text emitted/copied by the kernel to userspace, and
save userspace from matching and discarding stack traces when not needed.

Changes:

This patchset adds 2 files to provide information, like 'show_stacks':
 - show_handles: print handle number and number of pages (no stack traces)
 - show_stacks_handles: print handle numbers and stack traces (no pages)

Now, it's possible to periodically collect data with handle numbers (keys)
and without stack traces (lower overhead) from 'show_handles', and later do
a final collection with handles and stack traces from 'show_stacks_handles'
to resolve the handles to their stack traces.

The output format follows the existing 'show_stacks' file, for simplicity,
but it can certainly be changed if a different format is more convenient.

Example:

The number of base pages collected can be stored per-handle number over the
periodic data collections, and finally resolved to stack traces per-handle
number as well with a final collection.

Later, one can, for example, identify the biggest consumers and watch their
trends or correlate increases/decreases with other events in the system,
or watch a particular stack trace(s) of interest during development.

Testing:

Tested on next-20250929.

 - show_stacks:
	
	 register_dummy_stack+0x32/0x70
	 init_page_owner+0x29/0x2f0
	 page_ext_init+0x27c/0x2b0
	 mm_core_init+0xdc/0x110
	nr_base_pages: 47
		
 - show_handles:

	handle: 1
	nr_base_pages: 47

 - show_stacks_handles:

	 register_dummy_stack+0x32/0x70
	 init_page_owner+0x29/0x2f0
	 page_ext_init+0x27c/0x2b0
	 mm_core_init+0xdc/0x110
	handle: 1
	
 - count_threshold:

	# echo 100 >/sys/kernel/debug/page_owner_stacks/count_threshold
	# grep register_dummy_stack show_stacks		# not present
	# grep -B4 '^handle: 1$' show_handles  		# not present 
	# grep -B4 '^handle: 1$' show_stacks_handles	# present
	 register_dummy_stack+0x32/0x70
	 init_page_owner+0x29/0x2f0
	 page_ext_init+0x27c/0x2b0
	 mm_core_init+0xdc/0x110
	handle: 1

Mauricio Faria de Oliveira (5):
  mm/page_owner: introduce struct stack_print_ctx
  mm/page_owner: add struct stack_print_ctx.flags
  mm/page_owner: add debugfs file 'show_handles'
  mm/page_owner: add debugfs file 'show_stacks_handles'
  mm/page_owner: update Documentation with 'show_handles' and
    'show_stacks_handles'

 Documentation/mm/page_owner.rst | 32 ++++++++++++++++-
 mm/page_owner.c                 | 61 +++++++++++++++++++++++++++------
 2 files changed, 81 insertions(+), 12 deletions(-)

-- 
2.48.1


