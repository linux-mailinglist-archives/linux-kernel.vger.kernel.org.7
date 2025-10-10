Return-Path: <linux-kernel+bounces-848842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18A7BCEAC8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1D5189FF48
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F1826E6E6;
	Fri, 10 Oct 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VGYITCBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EBA189BB0;
	Fri, 10 Oct 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134125; cv=none; b=P6wsW1zEFsojZQJiNrMBNIZdyvsLnjMPTxd9HVl+XMiWMHprA2PklvNo0tozOOUqNzwNvF8NSouqZr/SFlpXbEvTszylcLfnEQp84mJ8ArSuK0+aiwXbP0Lck3H1ce/plkEynojtBcrT5D2wXbmjcaNHNPWPVyHEWH8oBJFY38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134125; c=relaxed/simple;
	bh=V+KqT3fmN9PfM0xYoQfnTgfVMW7tzUUYviSX+SWUvaQ=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=COJ040s2yte5H31jGTdBOSO88i7FVVd+rtIiJUd5HxuXY3s6bJJD8X8TWA8AkOdeukSCrC0cGLuNIbW3s565qzSIRgeaRTP2pAC/5GornhAqyqyekrXUj8xM01NcXzdzmneufUcys//GeHfQKQHaZZo+hFig/5m5qJlYEOSyIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VGYITCBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C63C4CEF1;
	Fri, 10 Oct 2025 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760134125;
	bh=V+KqT3fmN9PfM0xYoQfnTgfVMW7tzUUYviSX+SWUvaQ=;
	h=Date:From:To:Cc:Subject:From;
	b=VGYITCBYPDQbn5ijuhutsAgIenUjKZrMdR40UGI5xCRvqTPRjqqEd3r8pYuhEqWsQ
	 ysmK7Ba5RT4RQf8+ZSGx2j4E1tQL3MccKvKlEKmWoLlgz5dHShx53rFI1xsZ4knyBw
	 BQIXxH3KhjjMr4B60kOclTEY+1Ot1539bJhImNSM=
Date: Fri, 10 Oct 2025 15:08:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] additional non-MM updates for 6.18-rc1
Message-Id: <20251010150844.1ac58a5f9b89aa1e7e260ace@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this small and final batch of non-MM changes for
this merge cycle, thanks.


The following changes since commit 7a405dbb0f036f8d1713ab9e7df0cd3137987b07:

  Merge tag 'mm-stable-2025-10-03-16-49' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2025-10-05 12:11:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2025-10-10-15-03

for you to fetch changes up to 90eb9ae35727a662789c850efaf225ffe5511fae:

  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt (2025-10-07 13:48:56 -0700)

----------------------------------------------------------------
Just one series here - Mike Rappoport has taught KEXEC handover to
preserve vmalloc allocations across handover.

----------------------------------------------------------------
Mike Rapoport (Microsoft) (4):
      kho: check if kho is finalized in __kho_preserve_order()
      kho: replace kho_preserve_phys() with kho_preserve_pages()
      kho: add support for preserving vmalloc allocations
      lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

Umang Jain (1):
      MAINTAINERS, .mailmap: update Umang's email address

 .mailmap                       |   1 +
 MAINTAINERS                    |   2 +-
 include/linux/kexec_handover.h |  33 +++-
 kernel/kexec_handover.c        | 361 ++++++++++++++++++++++++++++++++++++-----
 lib/test_kho.c                 |  41 +++--
 mm/memblock.c                  |   4 +-
 6 files changed, 383 insertions(+), 59 deletions(-)


