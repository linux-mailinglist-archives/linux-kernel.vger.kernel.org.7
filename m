Return-Path: <linux-kernel+bounces-854895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A5BDFB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AE32503B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB63376B9;
	Wed, 15 Oct 2025 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eB12Sh+4"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D6338F3C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546365; cv=none; b=uUEn0xRjo5DqXJ9P3JfNQi/GcDAMxbIm2FbJmlrBQ7E3DiC2tQqWcqWIOfvWpJJZP+Ae2T5VKtSP/7egzmrN/+Toys5fyZbHzLv70Yi5PwnJnxpF5Y8V561LdxPdO+Y+9tS7kRrmAp5bdexqy9KWsKSsVKvutZt9v8aE0gmeQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546365; c=relaxed/simple;
	bh=3vhI/xg8SnWc5rRClQbWMA6E6C7CiFe0d+GGfZPhu5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZGuxH/FKRkqG4v5eKAwGFbcAP7QykY+/Qbc512PguBcGKnYt77S7aIvR5Kycr16cuYKKxIaTpAUqD2tDs7wMadQdko4nvO0Rzo0+cRu0knxcq2whPZKHk4JNSPjZ9xuAmGzj0o7dEKp/WfrEPSmSP+rFllBP/YB7SzmxHvdaEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eB12Sh+4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Oct 2025 12:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760546359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=j+PyiTMoXVvfPzWSvegW1DSTCdHPFWzbFBY1u+0oV3w=;
	b=eB12Sh+4FT06d7kTUzl9mSiputBLeio6uhXkcAGXcT4QNAda4eSnPVt2F4IFUwjjyM3czE
	uSEkPQ5mGvqjyXE0mKEzcMqbyuiI2hc9GJPQCKgoR55E4uoHwc5x2TbKJG7K7gNz37j/jo
	vwNHxGWAeIAYRRL3xki3OGuKPNZu8tc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] block-bio_iov_iter_export
Message-ID: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

This just re-adds an export for a block layer function (that I
originally authored...).

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/block-bio_iov_iter_export

for you to fetch changes up to 518bf42dc62419cb0636d8f4533ba7f73f8780f3:

  block: Re-add export for bio_iov_iter_get_pages (2025-10-15 11:53:11 -0400)

----------------------------------------------------------------
re-add EXPORT_SYMbOL_GPL() for bio_iov_iter_get_pages()

----------------------------------------------------------------
Kent Overstreet (1):
      block: Re-add export for bio_iov_iter_get_pages

 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

