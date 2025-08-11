Return-Path: <linux-kernel+bounces-762153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A3FB202B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DA3188A11B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5572DE6F1;
	Mon, 11 Aug 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JqBwC5QX"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A817213248
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903333; cv=none; b=B1I8bWXgeyryfHz6nkWjIC8T9ocUIVa+VfJejhq5zxudPF9eCmMuXYy7Q2XVZP3t5z0N0IfOcIvpLCKoaHNltFqCwpBK4srAMZYal9r2nM29OZ4Ac6yM2bHhoVZ7W5TXprgJ7owro1GASHVk2pcLjvDNBj+Q87TqvilOWHKU00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903333; c=relaxed/simple;
	bh=oPT920yCrMwJ/DrVj+omrDcapGa1haoaopDWUczbotI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SpVVXA9R+ggtX9Aa7dvhwiwwLsxhTuTZp7MCdyns10Y9GyI54YmyJkDp7AXX/3wjKiXA3BmSfgf7ZMwsTRtOyhZa640f+0SMi9uaOIM87sDT7+ITsZrtnqlkYvSwLHYpT8cYSHEPFoE8ne8H5iSaC55rY0obhBbrKweWVLqgH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JqBwC5QX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754903328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7w6hRtswdKKWxQGm/mydBnvkPywUGlFP9d4b6AUpcg=;
	b=JqBwC5QX7WWfgNhX2rH6o/DYC7q4vsktCoWp574FPmy49v4EZw7RbrwHbdc7IhwjH/X9eX
	s/2NGyD5tsmSgtcU3TOHLuFdDZKrFJdwHceF4kjWHBOj+LCJMzjvAnm0RcK69ZprPpExVH
	7CKwOHZrnssG6w05DvrZG0sJm520Glw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] mm/hugetlb: Use max() to simplify
 hugetlb_vmemmap_optimizable_size()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <7fb6ce41-a5e7-496f-979b-775b8e30e764@redhat.com>
Date: Mon, 11 Aug 2025 11:08:34 +0200
Cc: Matthew Wilcox <willy@infradead.org>,
 Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C6C36750-2C87-4C2B-B683-9789F55D34C2@linux.dev>
References: <20250810214745.2368-2-thorsten.blum@linux.dev>
 <aJk2IygsxWKYf17u@casper.infradead.org>
 <7fb6ce41-a5e7-496f-979b-775b8e30e764@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Migadu-Flow: FLOW_OUT

On 11. Aug 2025, at 10:26, David Hildenbrand wrote:
> On 11.08.25 02:15, Matthew Wilcox wrote:
>> On Sun, Aug 10, 2025 at 11:47:45PM +0200, Thorsten Blum wrote:
>>> Use max() to simplify hugetlb_vmemmap_optimizable_size() and improve its
>>> readability.
>> That ... isn't clearer.
> 
> No, it isn't.

I guess it's personal preference. I'd prefer max(0, x) over a ternary
operator any time.

Thorsten


