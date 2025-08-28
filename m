Return-Path: <linux-kernel+bounces-789264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F21B3930E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E476851C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE711A3172;
	Thu, 28 Aug 2025 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6CY2779"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17846111BF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756359330; cv=none; b=pa3p8/08tKcDgJKtiHkQfcCfUVMLqSofSt3Ub84RRGMBxZKJv+0dyL4F+sD22yD1xtOnJYD7qHKb+5tIUUl75tSMjfwuGeJ1AjBWIIa6nXHxmkUbUUPglcu8+Mbtg1kGia9QsS6ejGrrmMxO7qFaJG5D+vadZIFhq0d6I63xXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756359330; c=relaxed/simple;
	bh=hNT7UD8Ou4zIB3Wx+NzE0njI2PpVlD1H94gqBstvBrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M7Y5z59eX+6wIMO/T/W909+isWNaH/3WMql+XBWiqp6ruYAFweWNkIJ2LYMs4Y0bxjQYoQNkViFxODvA9zS7GrdpiCAhqauZIEYPq7nMb2OoFZFKE+cOKFnr54HUVDD5JFmQIWfNVAyCan89f71HIheW3PUie03PjSL4mZEWUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6CY2779; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC96C4CEEB;
	Thu, 28 Aug 2025 05:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756359328;
	bh=hNT7UD8Ou4zIB3Wx+NzE0njI2PpVlD1H94gqBstvBrY=;
	h=Date:From:To:Cc:Subject:From;
	b=J6CY2779PfUGq8bvFRiTykWWVQ62E9iaBbWI224v1pNdfpfZtBwTJTFn/QQVm0SuO
	 0hJHz+R6dLxe4WBO5q1Yg/Q8ROrfX1pCt/HepU1PQqyJPeyc+tfBce/5OLjtyT2SDh
	 JPCGqSoMzb7EgYdcbCJYBiUuCDrRatDWQyPALUSjwC/qhGPar0bCxt2VpaQ3FJX7xX
	 EN+d9+n/zpRrfQyTKXwxh6DXiULyTVHF4+AGSLkaewML6zX3wbGpCQFd2J5tuteVuQ
	 DFM7UxMnOIeVoYNkEVgCWJN9gcbkpsjk6R/LTW09T2sh2y7DP4wT+wfwEQdUPHImkP
	 SQHHq6WWdVb4Q==
Date: Thu, 28 Aug 2025 08:35:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock fixes for v6.17-rc4
Message-ID: <aK_qmw51CJz_Tz36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2025-08-28

for you to fetch changes up to b3dcc9d1d806fb1e175f85978713eef868531da4:

  memblock: fix kernel-doc for MEMBLOCK_RSRV_NOINIT (2025-08-26 10:47:03 +0300)

----------------------------------------------------------------
memblock fixes for v6.17-rc4

* printk cleanups in memblock and numa_memblks
* update kernel-doc for MEMBLOCK_RSRV_NOINIT to be more accurate and
  detailed

----------------------------------------------------------------
Mike Rapoport (Microsoft) (1):
      memblock: fix kernel-doc for MEMBLOCK_RSRV_NOINIT

Pratyush Brahma (2):
      mm/numa_memblks: Use pr_debug instead of printk(KERN_DEBUG)
      mm: numa,memblock: Use SZ_1M macro to denote bytes to MB conversion

 include/linux/memblock.h |  5 +++--
 mm/memblock.c            | 19 +++++++++++++------
 mm/numa_emulation.c      |  4 ++--
 mm/numa_memblks.c        |  6 +++---
 4 files changed, 21 insertions(+), 13 deletions(-)

-- 
Sincerely yours,
Mike.

