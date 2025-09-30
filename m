Return-Path: <linux-kernel+bounces-838058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F1BAE54D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A91944B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE95325B302;
	Tue, 30 Sep 2025 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="fXL9i6lG"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B7247284
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257800; cv=none; b=SDe1BwI7a1X82fERVz3SeIBNr8UtPRvZGh7bNU3iROJpXZKjN8LeShzYisfsKh4KU0U3T187qbfb7Q87+wCJQ2IRlfkvHp1twAk4FOQbrA4iJlz57qXOcXyl8bIa8gpkUP0aXYh4PEohe/1Ra0oc/JUZHyBBw3Md6GS+m36K3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257800; c=relaxed/simple;
	bh=LA1zHS4ppZRh5M6cwwSBzWIxCMB5psoEo4mhhfJ1HxM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Swuf1BWoQqpe44M9iTQJcBEi7DFoz+4bb8Z470syxY/izkDI1bzQaTca96nt2nJ+pDPgyulApJJa6sM9jDtmJpjjYYnbzM808JGRssbFx0EGWc+NsHoHavNNO8VxtSH0FB0m9GS34NBdiCBL4rGAGuu87C18rQPlYvA12AIkKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=fXL9i6lG; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1759257792;
	bh=LA1zHS4ppZRh5M6cwwSBzWIxCMB5psoEo4mhhfJ1HxM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fXL9i6lG8VWMAVmrXoaaX5p50VgGLRcXQoH4aAYQfRNXTYY+nt2g0u3Ak4P0aqcBj
	 ob8dpqIxXUZk7H0BciB5FbB6J+cUcBagNxkztKMJOSh1y2P5Ye9yiQsPAQKTu17I8J
	 ls4aot+054QGye8fUmxcqCd7tiXRHgN9iUJu35Sw=
Received: by gentwo.org (Postfix, from userid 1003)
	id 6CCDD402AD; Tue, 30 Sep 2025 11:43:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 6AEE04028E;
	Tue, 30 Sep 2025 11:43:12 -0700 (PDT)
Date: Tue, 30 Sep 2025 11:43:12 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Yang Shi <yang@os.amperecomputing.com>
cc: Dev Jain <dev.jain@arm.com>, muchun.song@linux.dev, osalvador@suse.de, 
    david@redhat.com, akpm@linux-foundation.org, catalin.marinas@arm.com, 
    will@kernel.org, anshuman.khandual@arm.com, carl@os.amperecomputing.com, 
    linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: hugetlb: avoid soft lockup when mprotect to large
 memory area
In-Reply-To: <6cde8290-3aa2-411c-bf29-eb91a99e33a5@os.amperecomputing.com>
Message-ID: <ef139940-5627-13a3-747a-b030b11e7544@gentwo.org>
References: <20250929202402.1663290-1-yang@os.amperecomputing.com> <cc40d827-3b98-4e15-ad45-5c2033e4ce20@arm.com> <6cde8290-3aa2-411c-bf29-eb91a99e33a5@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Sep 2025, Yang Shi wrote:

> > Does it make sense to also do cond_resched() in the huge_pmd_unshare()
> > branch?
> > That also amounts to clearing a page. And I can see for example,
> > zap_huge_pmd()
> > and change_huge_pmd() consume a cond_resched().
>
> Thanks for raising this. I did think about it. But I didn't convince myself
> because shared pmd should be not that common IMHO (If I'm wrong, please feel
> free to correct me). At least PMD can't be shared if the memory is tagged
> IIRC. So I'd like to keep the patch minimal for now and defer adding
> cond_resched() until it is hit by some real life workload.

It would be good to send out a second path that covers the other cases
for discussion.


