Return-Path: <linux-kernel+bounces-764169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04C9B21F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A623AC7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBF82D8DC5;
	Tue, 12 Aug 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdzBjRYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7A2D6E7A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982659; cv=none; b=qfTRDrQ+mWV4odjDL7+rII3dxlypsoqgJKgvLsd4F5UiqwptLb+pTUEEDp+Ir2eTT9EHL2qGcMAuYBPH8fsiyxsMzPfarUmpmhXSWXIEOZpgKosqTIdSuL5o/1xaNqdav9gMeMfuzmac5FdXBnIK2dZS4/3RYO3R2r7+pfJisEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982659; c=relaxed/simple;
	bh=0grhLNYnray7/yhDmufcTV3HyMYYhAB+577+1do6RLA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y1h1j8/5LOu6k7vUGwkfJ1Kdhyu4zgspXaK8bkZ39MEhOHv9p/Mms635QNHYFMBvwGYfnZAePy56BLxMtFj46KTH5DVKX7PG9067/sYAQ3nX55aCr1yp22qb6VMJYqT7H7jXYVvHz52kkxnkSx8nRaVPwvik3fn5v8vkIy+AZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdzBjRYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CD9C4CEF0;
	Tue, 12 Aug 2025 07:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754982659;
	bh=0grhLNYnray7/yhDmufcTV3HyMYYhAB+577+1do6RLA=;
	h=From:Subject:Date:To:Cc:From;
	b=FdzBjRYNZHrBf2XNahu8zJ2Sl1Z0e+ruDGUomlUxopNXjY5CyE3G6nWPgHlRfAd3K
	 3PNyHPzr7F2T2Mdd0F9X+lY6QaM8r/jYfOBbcVLBQrpBTh7CHfS+m8YW4leU/BHGZK
	 RV5IftDTifx2Wi6GfvXxUMaEr9cOGU3vSrOiD7ABJh0SxHc202R9veEllMZkwI7mrY
	 L0BlJggG5pbcaOVKSgdpfEyzxw9RwNpDGszODLjmztmb0ScJe50YUu9OJ2I/xJj2Jk
	 p+o4HimK/Uvu0a+keotly6diYuizTso/JA6O2ZY0aLRuP2obZ2f6/vNtNvpxgZOBuB
	 M8Rl0Rh49u2FQ==
From: Chris Li <chrisl@kernel.org>
Subject: [PATCH v3 0/2] mm/swapfile.c and swap.h cleanup
Date: Tue, 12 Aug 2025 00:10:57 -0700
Message-Id: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHpmmgC/3WMQQ6CMBBFr0Jm7ZgytFpceQ/josAAjaSQ1lQN4
 e4WVhrj8v3892YI7C0HOGUzeI422NElKHYZ1L1xHaNtEgMJUkKLA4aHmTDUxuFgwx2p0iUXkmQ
 lDCRp8tza5xa8XBP36TT619aP+br+TcUcczSqZWrKQgpD5xt7x8N+9B2srUifvv7xKfmNEiyPS
 nPN/OUvy/IGNPM2K+0AAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

This patch series, which builds on Kairui's swap improve cluster scan series.
https://lore.kernel.org/linux-mm/20250806161748.76651-1-ryncsn@gmail.com/

It introduces a new function, alloc_swap_scan_list(), for swapfile.c.

It also cleans up swap.h by removing comments that reference fields that
have been deleted.

There are no functional changes in this two-patch series.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
Changes in v3:
- Fix a few scan_all argument to match having while loop or not.
- Update comment message.
- Add a ptach to clean up the comments in swap.h
- Link to v2: https://lore.kernel.org/r/20250808-swap-scan-list-v2-1-d50e4758ecee@kernel.org

Changes in v2:
- Adjust change base on Andrew's feedback on int type and break out of
  loop.
- Link to v1: https://lore.kernel.org/r/20250806-swap-scan-list-v1-1-a5fe2d9340a2@kernel.org

---
Chris Li (2):
      mm/swapfile.c: introduce function alloc_swap_scan_list()
      mm: swap.h: Remove deleted field from comments

 include/linux/swap.h |  7 ++---
 mm/swapfile.c        | 86 ++++++++++++++++++++++++++++------------------------
 2 files changed, 49 insertions(+), 44 deletions(-)
---
base-commit: f89484324d5876ee10765fa61da0332899fa1a6a
change-id: 20250806-swap-scan-list-2b89e3424b0a

Best regards,
-- 
Chris Li <chrisl@kernel.org>


