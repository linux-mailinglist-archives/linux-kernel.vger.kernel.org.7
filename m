Return-Path: <linux-kernel+bounces-834542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E8BA4E67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB92C1C06696
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A330C101;
	Fri, 26 Sep 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJIdnbNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B535957
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911592; cv=none; b=CaXDVTKNTLbk0l8/uoSHd0kk/fZGp70UPdVRjqy7gV8T5ZC8OyqweTOnxB6+xtiT/cPaqaJlZZARire7s48zNH1k0q2zkDupyqHS7VBSQfC3DjodtIah/Dsg4ixTa1IlqeSPh7W0U16FEsrQ3vBHuoHoe98LNikSZH94IrKWrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911592; c=relaxed/simple;
	bh=1FEo+qjc2uVPZtPViZiq0sC5eXwLvDKqGoow+RAmhek=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=b0L7lWIJFzJm1kzPFzJ79HZVGeMtdbQMX8vj672qKCjHNqXyYNHqmQiCrOBmMyfxU780ppsvNeC/oWvIysTvJ0fZm+kLn2SfmOkE71OOpwYiPSNyGcWu3Kgf3qmSMFK1DJYXftCxthxV83mJD2TZxQw/qIRZo5jEfj3YqiZrNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJIdnbNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DFEC4CEF4;
	Fri, 26 Sep 2025 18:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758911591;
	bh=1FEo+qjc2uVPZtPViZiq0sC5eXwLvDKqGoow+RAmhek=;
	h=Date:From:To:cc:Subject:From;
	b=FJIdnbNtGWpNcMaPMrA5nKAjR4qQNuEbY6hfgfzXPnBJxHz8/omC8jhIXzZgmvbou
	 fQrrqiDzxG37jvslR9rDdBGPnKDGs1jp2j+kbHsy+hmC9CLJ5g+uFo6vRSoU89fYCl
	 7EDdW46P55Zo3WvfuP4pR8Vf6P4b34Oli2XfFpaHw04vKqIxYeknvscjoEEI6etu8L
	 mhVEGqdU6fKpWhPqDFOfFOMpshCfCYMhjWdJNjKN0ng0INAGcvYl0rlOSZIgVS5ao3
	 QxjYViXvt5d2ECP+Brbxz7xR8shR0cZK81/+OY9pBZINmhBYxx+8qY9m1p2DGHKo64
	 EuYLXcT0vSqcg==
Date: Fri, 26 Sep 2025 12:33:10 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: torvalds@linux-foundation.org
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v6.17-rc8
Message-ID: <c6ef1683-9c29-cb02-4498-31fce8934d9e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

The following changes since commit a03ee11b8f850bd008226c6d392da24163dfb56e:

  riscv: Fix sparse warning about different address spaces (2025-09-05 15:33:52 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-v6.17-rc8

for you to fetch changes up to e24108012ce9662d90093f91d5ffebcbf78da7de:

  MAINTAINERS: Update Paul Walmsley's E-mail address (2025-09-23 20:18:45 -0600)

----------------------------------------------------------------
RISC-V fixes for v6.17-rc8

Two small RISC-V fixes for v6.17-rc8:

- A race-free implementation of pudp_huge_get_and_clear() (based on the x86
  code)

- A MAINTAINERS update to my E-mail address

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Use an atomic xchg in pudp_huge_get_and_clear()

Paul Walmsley (1):
      MAINTAINERS: Update Paul Walmsley's E-mail address

 MAINTAINERS                      |  8 ++++----
 arch/riscv/include/asm/pgtable.h | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

    text	   data	    bss	     dec	    hex	filename
12772113	6174050	 419253	19365416	1277e28	vmlinux.rv64.orig
12772113	6174050	 419253	19365416	1277e28	vmlinux.rv64
11725507	5994478	 404229	18124214	1148db6	vmlinux.rv64_nosmp.orig
11725507	5994478	 404229	18124214	1148db6	vmlinux.rv64_nosmp
11723502	4702754	 309629	16735885	 ff5e8d	vmlinux.rv32.orig
11723502	4702754	 309629	16735885	 ff5e8d	vmlinux.rv32
 2612497	 761072	 119048	 3492617	 354b09	vmlinux.nommu_virt.orig
 2612497	 761072	 119048	 3492617	 354b09	vmlinux.nommu_virt

