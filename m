Return-Path: <linux-kernel+bounces-771354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94995B285ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F7F5E7711
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF8244664;
	Fri, 15 Aug 2025 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WSGj1qdF"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37353176E2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283415; cv=none; b=nabeOE92bBQJEgcXkL0lN24ejqX44RFY/I1hWcCF/Sx0pZK5neRQLS655MdhjNRicGaeRfx3qRPbF5Glz7p3dhc2udEaFGWI7nskT+yTz+1t5gFZcws7S5c/pYRbPBncFqqkIMv6X8KyoKgd2hU9eznHeXkbr8X/GeeaHJ/2tHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283415; c=relaxed/simple;
	bh=flsyiKxUh1QJGZG+IWRoapG2HI3Ae9rWebBZjAboWqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TwKu1M5D3qHIBM5pSPqHHHGJMwdu91REiieP3DJBSfPm3vrrXWN2SYK6TFuz1TT38nwtpaaOkSPK2lljbfy8CdTXQnHHIgtQm+v73jTnVRzek0ZJIOhP4hq7Ciogp+0ViA4CC5GmeLTMxTs0uf43FsFhAVbwzZjMfh0ahRy9zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WSGj1qdF; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755283410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=flsyiKxUh1QJGZG+IWRoapG2HI3Ae9rWebBZjAboWqM=;
	b=WSGj1qdFdt6XMJ6aEMN+XRFSirVkjZ3TePNBUTpTk1X3ow7p1z9BkNDRMKp3S4EHbe2rlE
	rABR15iV8X82IXKQk9qAr6nY/OCtU7lAeknrUW/3kesrgcYfogey+Krmz8NV586/3JAfw3
	rDXX7YtWEWHO11VuFAlHbbJb5ijF/Ic=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Regression caused by commit 4687fdbb805a ("mm/filemap: Support
 VM_HUGEPAGE for file mappings")
Date: Fri, 15 Aug 2025 11:43:25 -0700
Message-ID: <87plcw8lyq.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hello!

The commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file
mappings") causes a regression in our production for containers
which are running short on memory. In some cases they are getting
stuck for hours in a vicious reclaim cycle. Reverting this commit
fixes the problem.

As I understand, the intention of the commit is to allocate large folios
whenever possible, and the idea is to ignore device-specific readahead
settings and the mmap_miss logic to achieve that, which makes total
sense.

However under a heavy memory pressure there must be a mechanism to
revert to order-0 folios, otherwise the memory pressure is inevitable
increased. Maybe mmap_miss heuristics should still be applied? Any other
ideas how to fix it?

Also, a side question: I wonder if it makes sense to allocate 1-2
PMD-sized folios if mapping_large_folio_support() is not there?

Thanks!

