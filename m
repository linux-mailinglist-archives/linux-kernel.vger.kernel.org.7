Return-Path: <linux-kernel+bounces-769738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF6B272F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D9D568A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66E287505;
	Thu, 14 Aug 2025 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0jiS0MN4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BCD284B26
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213846; cv=none; b=YJqf8QqjGG+iuX/0nybJTzjW8sci1gnEBf6N7/03PT9WbDswD3Mmc/WbiqSov8OeFlLdWlHK79CzWozJIf33cfeWBE+28FNmEwy3aPAtmRcJPbtDD6Bemy9S1YsJPVvCT8vZZ+K3owQJqfXH0ICdB5+xywlFTZCdl9e8kZjNxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213846; c=relaxed/simple;
	bh=Lt6jBIulxaTo9RIUgXftMb1SwjwcRMNvaTJxyrnlj78=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mNTKQhCvFNsvtPKN+731PgFFwuKGXLYLyEp5CrRGaqN+SfjC0DmuLLFSEwFH33oXswDcfN+bku/X2XKDI6Ze/7yjYU6mm4FtOYx8k9YkmkVr3DZwpxLt6IoaSs+9xmb/29AqvIMxpX0Pezo84ngMAKRsTayjFw05t3RcDtfAEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0jiS0MN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1B7C4CEED;
	Thu, 14 Aug 2025 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755213845;
	bh=Lt6jBIulxaTo9RIUgXftMb1SwjwcRMNvaTJxyrnlj78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0jiS0MN4/TWhe764dHWzjTgvAGMJecSSdfZWFOkJUS7BuIjhyZKOl+A5PrqjFOduD
	 IsxvOxBO+k+v+PziyRQf+Q7TQM0DhZnFEQ2PaknBTmYhxEHSQRHua4azWjzIgmIkiW
	 ecFxYV+H+SUkeqY9R/HRVhofTlwwyNEN4NBGc7RU=
Date: Thu, 14 Aug 2025 16:24:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, x86@kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pasha.tatashin@soleen.com, sweettea-kernel@dorminy.me,
 nicholas@linux.ibm.com, christophe.leroy@csgroup.eu, Rohan McLure
 <rmclure@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v16 06/13] mm/page_table_check: Reinstate address
 parameter in [__]page_table_check_pud_clear()
Message-Id: <20250814162404.e3a0f12e2aa1a87de51322e7@linux-foundation.org>
In-Reply-To: <5aa057d0-dc76-4723-80d1-82065320a428@ghiti.fr>
References: <20250813062614.51759-1-ajd@linux.ibm.com>
	<20250813062614.51759-7-ajd@linux.ibm.com>
	<5aa057d0-dc76-4723-80d1-82065320a428@ghiti.fr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 14:11:45 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:

> >   	for (i = 0; i < nr; i++)
> > -		__page_table_check_pud_clear(mm, *(pudp + i));
> > +		__page_table_check_pud_clear(mm, addr + PUD_SIZE * i, *(pudp + i));
> >   	if (pud_user_accessible_page(pud))
> >   		page_table_check_set(pud_pfn(pud), stride * nr, pud_write(pud));
> >   }
> 
> 
> So this made me realize we (riscv) did not implement 
> pudp_huge_get_and_clear(), which was a mistake since we support THP PUD. 
> I have implemented this function in this patch 
> https://lore.kernel.org/all/20250814-dev-alex-thp_pud_xchg-v1-1-b4704dfae206@rivosinc.com/T/#u
> 
> That's a fix so I'll merge it in 6.17 (at least I'll try) so your 
> patchset will break the build on riscv, I'll keep you posted when it 
> gets merged!

Thanks, I'll temporarily grab a copy of your "riscv: use an atomic xchg
in pudp_huge_get_and_clear()" to keep mm.git compilable and testable.  

