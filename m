Return-Path: <linux-kernel+bounces-804539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94883B47935
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E7317F5FA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF71DF265;
	Sun,  7 Sep 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haXlZ207"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8CE552
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757225074; cv=none; b=S+/7xIbzZaVB8d1One9Gm1TXXUywjN9l9T/fqygwG+A3I5toIYq9qs/1HOw86bACevwYDpSp9wE/c5fPjtIj0JrSGreIOdrsg5hZNLPFfEms9q//VDbXs7y1IFs1MKHCBEelyOhyePYjzjgcCtxdhwON49QPA0kzj0SECiXCKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757225074; c=relaxed/simple;
	bh=Y+6NT7qGhfiYpIQPVV4I0mtOFqnghk5yu59oPQEuT2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtURa82l52QAbO46IaA9ZYB48sYV/ItzcnqnXg77bfSOxIDhIsLCXeeaqBAdKuWeeDnFwMdKucgGV9S6HYi4O8zFtFRUq9fliEU7i9mnH21S+969DYwQORkQKrQYpzp6hkp7X9EEjPr26wvXN+bbi/Zd4XXpwT/MCZOog5kwmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haXlZ207; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF20C4CEF0;
	Sun,  7 Sep 2025 06:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757225073;
	bh=Y+6NT7qGhfiYpIQPVV4I0mtOFqnghk5yu59oPQEuT2I=;
	h=From:To:Cc:Subject:Date:From;
	b=haXlZ207G0qpRnmByYvNsmw0JNfqiAaOWam3kbsqOPErDLMXsEshkfvubab9jT1Iv
	 1EsfHRPcCfBb/kX57nh1sb/nXMBWWizrNPR7BXJzeyM0I8e34ZFgkDk6enH9CUzUH/
	 +8wV7owr1jTRIULdJU43VRMFrD41BIvVyBy6ERgjo+Kq4S1SFixIAFNd/1jIqhIzHX
	 KbzPnzGz59GmbarsOi70dgjNMdY7iNUJFudyE/xeA+O3VzuUiys0LA7mLpL0fdPCsc
	 zm3wlMU+hpMhSzkpHMt17fH0Jg2VoOQ/vbEkTjX/AdjbkATpaQ5QChPFzvFzvZG+qN
	 RS7tHHD2QgbTg==
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
Subject: [PATCH v3 0/2] kho: add support for preserving vmalloc allocations
Date: Sun,  7 Sep 2025 09:04:26 +0300
Message-ID: <20250907060426.2177717-1-rppt@kernel.org>
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

v3 changes:
* rebase on mm-unstable

v2: https://lore.kernel.org/all/20250905131302.3595582-1-rppt@kernel.org
* support preservation of vmalloc backed by large pages
* add check for supported vmalloc flags and preserve the flags to be
  able to identify incompatible preservations
* don't use kho_preserve_phys()
* add kernel-doc

v1: https://lore.kernel.org/all/20250903063018.3346652-1-rppt@kernel.org

Mike Rapoport (Microsoft) (2):
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

 include/linux/kexec_handover.h |  12 ++
 kernel/kexec_handover.c        | 200 +++++++++++++++++++++++++++++++++
 lib/test_kho.c                 |  41 +++++--
 3 files changed, 241 insertions(+), 12 deletions(-)


base-commit: b024763926d2726978dff6588b81877d000159c1
-- 
2.50.1


