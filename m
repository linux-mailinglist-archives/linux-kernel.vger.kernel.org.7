Return-Path: <linux-kernel+bounces-769739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD40BB272FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F1B1CC77CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FE28507F;
	Thu, 14 Aug 2025 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2nc3wY6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCB928751D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755214082; cv=none; b=RqOz/TUbqM+iDo/Ytkj/oZZG0F7+P7H61JbHSVU8TMkzZzRk34nJIW0XZK2RKRQa+KCVCDpddnxIVpduLH0zY3mOMd4JNL7sq/4hq96lYiRJxES2TGTeUKPfxtE8uY0b/lFFc2P0dpy1grwzUu2Si5QeDXsXaZnjxT8qvXxWRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755214082; c=relaxed/simple;
	bh=RKMPJD91oygjixSsHWj5e0vCdzOp27ndBzqTMRaZ2B4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XHgTEAxdTE8St5f4xy2WzT+2Ka0VI4foim8I7tqkISCwR2ephm1/B22LafpDwo4i/cVBqkhSwdtflcDKsFsicfLeCksm5O+3LvqjKJlOKeibLBBaV7Do8qu9nzFX813XCHwfSRJXw2QCXQkmgVGeMZtgYlrt7/Xi44eNEvdcuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2nc3wY6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6933C4CEED;
	Thu, 14 Aug 2025 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755214081;
	bh=RKMPJD91oygjixSsHWj5e0vCdzOp27ndBzqTMRaZ2B4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2nc3wY6HZVO3TgsWr3n8qKoRazbe/rFSYW3Vu93F4/XRHsdO3EVO88kWu5LBU/OvL
	 A86xKo2De+y2rzau5wNNTNkps2GmviyfmIGMDqH+wkOPjtgagU6NOLcp3/dL2HwaRA
	 Swry8zQyOTYUXdG5XbXofKKu+LctVQ/C9k25bh/4=
Date: Thu, 14 Aug 2025 16:28:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: "Herton R. Krzesinski" <herton@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/debug_vm_pgtable: clear page table entries at
 destroy_args()
Message-Id: <20250814162801.08ece6844de66ac43af5224f@linux-foundation.org>
In-Reply-To: <5e5f45c1-e813-4900-8fad-2ed0dc067468@arm.com>
References: <20250731214051.4115182-1-herton@redhat.com>
	<5e5f45c1-e813-4900-8fad-2ed0dc067468@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 16:16:03 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> On 01/08/25 3:10 AM, Herton R. Krzesinski wrote:
> > The mm/debug_vm_pagetable test allocates manually page table entries for the
> > tests it runs, using also its manually allocated mm_struct. That in itself is
> > ok, but when it exits, at destroy_args() it fails to clear those entries with
> > the *_clear functions.
> > 
> > The problem is that leaves stale entries. If another process allocates
> > an mm_struct with a pgd at the same address, it may end up running into
> > the stale entry. This is happening in practice on a debug kernel with
> > CONFIG_DEBUG_VM_PGTABLE=y, for example this is the output with some
> > extra debugging I added (it prints a warning trace if pgtables_bytes goes
> > negative, in addition to the warning at check_mm() function):
>
> This has been on linux-next for almost last two weeks now and
> no problem has been reported. So I guess it's all good.
> 

[top-posting repaired]

Thanks, I'll move this into the next batch for sending into mainline.

