Return-Path: <linux-kernel+bounces-839468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C059BB1AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C329F3BEFF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290B2EE5F0;
	Wed,  1 Oct 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J1FF9mYZ"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E626A0D5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350188; cv=none; b=djywEDKqmeGInMU+7+LoMCY442ezqKSI5sIwwJ7ebw4UPsjIKwt8dJlc4wkcp7XhvcF/PWgCznqiG+uuX2MF1Jh4Byp3t/L8dU339+3kK+BTftASqff46023GBxNsXZYKTyVdXSUQrTfI16Y7N0gei8bF4dKYn7xNzcwhOgyHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350188; c=relaxed/simple;
	bh=hFXtvIzan6aBBUVktNHJglc6ccvNWHLuZNDHHSA/sIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvHSU8BuScIlgMg0zZUEhlmFvJm5yB3xW5VbZvXp4gG1i/f21DWUWo2aVRtvNDWzB/V10a/1Xpg3Ih9LkTORAQBM1R2c3Z0FJZCuZtps2wraAGUORhsuZmWMzU1+0lchLim2mjgdBe8lIOSaeiWbWrA1x4/8nTj6/eY1Ph6CdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J1FF9mYZ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 Oct 2025 20:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759350181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9m0fgp5imm9+MQnY/QzylO+ByiO9mSzTdbEPwZykP4=;
	b=J1FF9mYZ9gvjxJFkcXYC7y0Dh2IROCnDorzVDw9UT7rk1MY+VnnaDWAvVc+P6ZKJt9k2z3
	9U6Xcbu2TgJd4zL9ZX3HyrdB1zcstXO2KHbD1Z1BTF7asqsmgisfdb5k/UA7f6SG8HEvxd
	VRFidcByI7Su6jhvxWjxw8wRVMtYn9I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Brendan Jackman <jackmanb@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, david@redhat.com, 
	derkling@google.com, junaids@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, reijiw@google.com, rientjes@google.com, rppt@kernel.org, 
	vbabka@suse.cz, x86@kernel.org
Subject: Re: [PATCH 00/21] mm: ASI direct map management
Message-ID: <eajnyirurulezkgpqaonfqmh5ydi7ujzztgok2ab3fsumcmtwi@34ios2bpwxk5>
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <726d6a45-d732-4c23-a7b7-766d6a62122e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726d6a45-d732-4c23-a7b7-766d6a62122e@intel.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 01, 2025 at 12:54:42PM -0700, Dave Hansen wrote:
> On 9/24/25 07:59, Brendan Jackman wrote:
> > As per [0] I think ASI is ready to start merging. This is the first
> > step. The scope of this series is: everything needed to set up the
> > direct map in the restricted address spaces.
> 
> Brendan!
> 
> Generally, we ask that patches get review tags before we consider them
> for being merged. Is there a reason this series doesn't need reviews
> before it gets merged?

I think Brendan just meant that this is not an RFC aimed at prompting
discussion anymore, these are fully functional patches aimed at being
merged after they are reviewed and iterated on accordingly.

