Return-Path: <linux-kernel+bounces-797773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC721B41535
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509D1189AB8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF042D6625;
	Wed,  3 Sep 2025 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8L5J+Up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9531A5B9E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881026; cv=none; b=SVvIl0Yhc6mCJJJh8TqZ1VSCjSjqSsZyvYdYnABjOjv00RLAbTqrkTAxHNUn5xOiqol5jmr0ptYcExRCcxp3tLoCWCJ776jxWx1qm5+UXWQ02KqVLCegTxbqNfiy1prPz0GHj4jSULiM7573PjbN5c3m+h5F7EJBQIdinPjkhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881026; c=relaxed/simple;
	bh=0BP7MTU7WtClcd5jUvnxmjOIUJ5oBGFWJ9RXidmD/b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3sIJblvHgV/xII2NArV0EiXViuK3vrcNliQLNPrf3LoWeVk1hJTA7O5yh0rHqt3gNrRJ7Hdv+psOo9y+a+Wbz5OupSKkueAHrtXIzd/cFW4f50PSpMcy2u2dAmFPhxpb1thjGjPx4FH9WlsBZdJt1u9oDyl/WTGr9uBqw610O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8L5J+Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FC5C4CEF0;
	Wed,  3 Sep 2025 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756881025;
	bh=0BP7MTU7WtClcd5jUvnxmjOIUJ5oBGFWJ9RXidmD/b0=;
	h=From:To:Cc:Subject:Date:From;
	b=r8L5J+UpwsZFc6vxvw/oeG2L7/kI3GOXOPF1wkLa53P0zXa/EWSrxgEzwd7YgKQE9
	 ydDjrfNusiUWQwYgKKVHO0PosNWMB/PZmMN9tLVni5+5hRx8udYAnSqB6SYqDNV4pd
	 /FfuvmrZuh9EtDb3aev9j3WRR/o2+RmZNeZKMA+S6uw4+BXkw2F961clb3kXyG/v4A
	 oF/fqFlwj7ciQc6VI2sP/soaMg/0ReJ4Ymze8kKhGy0nwNoECivEoI4pjBNmzw1cck
	 zQoKoyfddujrP8rjmcowiXA3gThpuJZskxVpkE3NEMVdEryDcPKcclpQ52m1PZKsE7
	 Ie5WO9SfESaBw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kho: add support for preserving vmalloc allocations
Date: Wed,  3 Sep 2025 09:30:16 +0300
Message-ID: <20250903063018.3346652-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Following the discussion about preservation of memfd with LUO [1] these
patches add support for preserving vmalloc allocations.

Any KHO uses case presumes that there's a data structure that lists
physical addresses of preserved folios (and potentially some additional
metadata). Allowing vmalloc preservations with KHO allows scalable
preservation of such data structures.

For instance, instead of allocating array describing preserved folios in
the fdt, memfd preservation can use vmalloc:

        preserved_folios = vmalloc_array(nr_folios, sizeof(*preserved_folios));
        memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
        kho_preserve_vmalloc(preserved_folios, &folios_info);

[1] https://lore.kernel.org/all/20250807014442.3829950-30-pasha.tatashin@soleen.com

Mike Rapoport (Microsoft) (2):
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

 include/linux/kexec_handover.h |  12 +++
 kernel/kexec_handover.c        | 140 +++++++++++++++++++++++++++++++++
 lib/test_kho.c                 |  30 +++++--
 3 files changed, 175 insertions(+), 7 deletions(-)


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
--
2.50.1

