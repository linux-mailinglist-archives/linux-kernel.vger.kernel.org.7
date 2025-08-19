Return-Path: <linux-kernel+bounces-776617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4AB2CF96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2AD4E7E69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A76023C507;
	Tue, 19 Aug 2025 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wSLTv9O+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243E225414
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644354; cv=none; b=oPDUhOa88jXGgjcKlWMUxs0MYY2+Q9Z19ZiYeK7QDbTGk5NYf+h5N8SX66z3mo4QtK22408CkKyzACfbkkhWSHn5sz0IWpz3J0fH3u6sAFVOqWo5qunJhDs0O9nySM5vpEYWciJqFkV18bpOOElUQ3y/xS2S+od6/ig0iJbZlEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644354; c=relaxed/simple;
	bh=BVbmAkMOYMUDWot0uFGf1xYhRBt7KqDDIeXylb23udU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N5bFoq8iQ4UMthyUOkhSitKlE/2oL1mJfTc1cq/OzEA5FVlJgvc5K0M94TLzJPPVbLSmlBJsuo2HtfuG3m71qHzYdCDiskTeBwirMauawOAmttcDt30u797fpGSQRG+3lI7MmCH4AiG2W9Vz80ENhZjF7MiHtGPypnRSTWlSvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wSLTv9O+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A487EC4CEF1;
	Tue, 19 Aug 2025 22:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755644353;
	bh=BVbmAkMOYMUDWot0uFGf1xYhRBt7KqDDIeXylb23udU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wSLTv9O+PtzDoICJq3wXd9IZimlNLA9NkvH3JEF++r5Tr6Bx5Qd11jreFlitCFR9y
	 Wredzfa/xj5ZBNJF+fDCAIDJE9/h5+zcQ9BzFkgHBwl53TqWF+2b6qyZJV99uCC9n+
	 qgnOa3FI9kfjeHWmbdKgqFPm/UOBDmJZNIG8ADHw=
Date: Tue, 19 Aug 2025 15:59:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: jane.chu@oracle.com, lirongqing <lirongqing@baidu.com>,
 muchun.song@linux.dev, osalvador@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] mm/hugetlb: early exit from
 hugetlb_pages_alloc_boot() when max_huge_pages=0
Message-Id: <20250819155913.93e549fc5bd728c2f9ddacf4@linux-foundation.org>
In-Reply-To: <fc444f71-849c-48b1-8a1a-9bea6410ca8e@redhat.com>
References: <20250814102333.4428-1-lirongqing@baidu.com>
	<08cc4405-948a-446e-b198-5745c32f9ee1@oracle.com>
	<20250817195945.a845d2f5c045e4f60b07469f@linux-foundation.org>
	<fc444f71-849c-48b1-8a1a-9bea6410ca8e@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 09:46:59 +0200 David Hildenbrand <david@redhat.com> wrote:

> >>>    	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
> >>>    		return;
> >>
> >> Looks good.  Could you add stable: ?
> 
> Can you elaborate why you think this is stable material?
> 

To prevent the

> [    3.702280] HugeTLB: allocation took 0ms with hugepage_allocation_threads=32

message when hugetlb pages are disabled.

Yeah, I guess it isn't very important.  I'll destabilize the patch.

