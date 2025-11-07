Return-Path: <linux-kernel+bounces-890957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDD0C41749
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 556EF4E9ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2A30649A;
	Fri,  7 Nov 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afnsRGFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCAA21D5B0;
	Fri,  7 Nov 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544169; cv=none; b=tRZGZ4H8rof85n8g612cIf8UPomorBs6M8MC6qiBEjvPTP3xMDNIgYw5G8NyZl+4/3FNusg+YDaNiuK0n8z8B5JFm1oQy9i9Z6sAu0cmgBeSldm+biyI8vchZYcQMv/cKBqbk5xo24qyyuw8dakS5Pu2KJBu0BYOxqW2UDkpDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544169; c=relaxed/simple;
	bh=fg9uYgd2B0WyhnLjk+5ksTZikFgPUleuOedpHoldVGU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FXnWlGX0mLrPAb2u6OOWFWZlXVJ/2/B6AYW9wVRD9fymOQj9r0oz7FIf+3Tb5bLo4tfqojfBBPlCFMuz5M5QVXfXHhYYwI4cg+k+wPBQB4ocg5z/A5lSWzArA+ifNZYkImAurbb5RKFvPE43U2VD6Ba1QBhfhInpqR/h/WX91j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afnsRGFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B211C19422;
	Fri,  7 Nov 2025 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762544168;
	bh=fg9uYgd2B0WyhnLjk+5ksTZikFgPUleuOedpHoldVGU=;
	h=Date:From:To:Subject:From;
	b=afnsRGFwf+9mqTExwk10lhe7LGnmGa/YLLBYXqnFnUB9VyGOpgvBDbuZkvcCephIs
	 oMblRhVHyGGRNwg/gRkIqvbzvb8cTsXPMUrY/oYgAxZy/nu302OPOzM6jmkXqnBVjx
	 M1xow9v6W0jrf4AW9UTPGG6gsTgpCOp0hN7ioZu+BLeV9L/yZhVlKa54lbqTxLztd8
	 BmTzM9EDG8X1/2yXd/kaJLE/FFv6NrCICB+0uZgpiXhoSlTh4qM6AApAl7OD7EdpjF
	 SUeefmNCJ0SVs0OTtwy9bKa8W3jZSD9bVC+jPOHcTwUBhr5PphyXL2pxsQDCF9v01X
	 F9E0DdoRST1ow==
Date: Fri, 7 Nov 2025 20:36:04 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] parisc architecture fix for v6.18-rc5
Message-ID: <aQ5KJJJVKWhzoyz-@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull a single fix for the parisc architecture, which fixes
a spinlock recursion/crash in the parisc stack unwinding code.

Thanks!
Helge

----------------------------------------------------------------

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.18-rc5

for you to fetch changes up to fd9f30d1038ee1624baa17a6ff11effe5f7617cb:

  parisc: Avoid crash due to unaligned access in unwinder (2025-11-04 12:21:59 +0100)

----------------------------------------------------------------
parisc architecture fix for kernel v6.18-rc5:

- fix crash triggered by unaligned access in parisc unwinder

----------------------------------------------------------------
Helge Deller (1):
      parisc: Avoid crash due to unaligned access in unwinder

 arch/parisc/kernel/unwind.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

