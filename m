Return-Path: <linux-kernel+bounces-804544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5512B47942
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 746F27A721E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 06:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E641D9A5D;
	Sun,  7 Sep 2025 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPP7q2TC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF013D521
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757228429; cv=none; b=McFN4nmkjhZKeijETja6QBIVbuRFrTplH03dsGxWWBWMZ1nbvBguP/66qkCcrup5MFjqYPDko2BI4nslnNiWRWlKEgVCiquaNdMPD5fOo6o4nOD/IQWC4MKUTSJLI81TJZM+ZKuBoi7R7MJIU5y5xBfztyNG9ejqId1FoY7Ud1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757228429; c=relaxed/simple;
	bh=lAKGsfnUG4rgDzqjzr2gwTb62JFdmQhbLIaqo8Ydwj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJ53vErtR3II/agGvSr6pjo0hFulfoYwBYe/bnoNepK1D7ni/o9oIH+8+oToQnewHl1B41f6sJnfaVG9FCHR1zSDKymg2s4VsIBLPiTqQilsZ7Ms0NlagRozXUVSuj/TgY+9Kvne+dkkq4ZLAsAtBj2mYgPbLeen4wIlXFW7dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPP7q2TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D33C4CEF0;
	Sun,  7 Sep 2025 07:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757228429;
	bh=lAKGsfnUG4rgDzqjzr2gwTb62JFdmQhbLIaqo8Ydwj8=;
	h=From:To:Cc:Subject:Date:From;
	b=tPP7q2TCiDeELr22eaA6eXoox6CcsBeYkx8QFMoB8UJ4AuPgNYvFWeuwsX8wJICmg
	 oWCGrjEjZjRjKZuK3FGmP/Jj1OrKgOtT3MJqJAlsKvBueRq4eJQ/rkaKQpy4kiE6Uw
	 TigcrvW8Ug8aFmYqWqMByd+PgVWpaH7UrsycyExB08ZpgOR0JMbHTAk58cMLpUZ3mQ
	 hdeMqT3veVF2EsYhb0sCcsBQXUrGD4NT1CqrqETcMtC3twDaXCL0lJWERop0i+3eLf
	 yH8jqwy27Lgok9hho+nTIQjPMH8YaI+tfGEyEyVVj8vcosp2vopYSg0O2v7RZqpz5z
	 YFi7pcicFIokg==
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
Subject: [PATCH v2 0/2] kho: add support for preserving vmalloc allocations
Date: Sun,  7 Sep 2025 10:00:17 +0300
Message-ID: <20250907070022.2177974-1-rppt@kernel.org>
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

v2 changes:
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
 lib/test_kho.c                 |  30 +++--
 3 files changed, 235 insertions(+), 7 deletions(-)


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.50.1


