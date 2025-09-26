Return-Path: <linux-kernel+bounces-834543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003E8BA4E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B03628668
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DFB30CB2A;
	Fri, 26 Sep 2025 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiU5gx7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F079635957
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911626; cv=none; b=ile3kaEbi8+TeH1y9raoXESjeE0bn7mkggM6Q2AvsXUM32WCCq5xcBIk6HnhLx9iqzR/RBnz8muecYkNxTUzbswbWX7gr34qvNqEqhsPAGE7EEWBTcx0qDXjMCUeAGbD1+EKzAAQF5JNnM2r1w8vaOJdswmelQmQ2pt7BYeQMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911626; c=relaxed/simple;
	bh=oXdar49xgqDvb/6GA2k51Cj07chVCcuaXGpUDgposp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TINPtQ9R+9KTLBMJLhGCC9rxDS5d8cLs327g7Wg3WYZMmFDrVyWTjEVXEIe+m1QydcoQlv9GyfddbJmT7J5FgVr9LNmikpwXIyjy4apeFyJTdcqULocNLpqa59nm90MFx3tvelGnilZabDRbPi5ig00wvEOnv6CxI4zBvEEaywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiU5gx7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA16C4CEF4;
	Fri, 26 Sep 2025 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758911625;
	bh=oXdar49xgqDvb/6GA2k51Cj07chVCcuaXGpUDgposp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiU5gx7H0Z0QQWEfyb0ghA1Tu7eHHeEowdMW+LPoN/nofzvIs7hbcItqMMNVqf9/L
	 4DTttr8+d2VqDqgnWKhtNV4BuSlv0arCRIEn8csIvEGkecoPjkGqoWKdX4lemoAtFH
	 ElieiZpxTN5FpVoLOCVeU187mGKM4C2uB6d4iwGL1fcFYn0ikMaeDwPPWeeFHZjV36
	 /HlK4miuphsl2G7UIqdghk3K3ayfLH7eQ/Njd75oiUsR3uAWdKaK24eUhrvLhHZsbS
	 /SQCLU1d1BXb9CGUhEQ3uvAC2nVEHPPLuRzr/FOzolSmnS1PyscXdocYetENd9zyqO
	 PQU5ezUcuhcmw==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Fri, 26 Sep 2025 11:33:43 -0700
Message-Id: <20250926183343.54956-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250926182438.3108364-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Sep 2025 11:24:37 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
[...]
> > > @@ -839,7 +839,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
> > >  		if (do_pagesets) {
> > >  			cond_resched();
> > >  
> > > -			changes += decay_pcp_high(zone, this_cpu_ptr(pcp));
> > > +			changed |= decay_pcp_high(zone, this_cpu_ptr(pcp));
> > 
> > I'm not a fan of bit operations unless it provides clear benefits.
> > What about below?
> > 
> >     if (decay_pcp_high(zone, this_cpu_ptr(pcp)) && !changed)
> >     	changed = truee;
> 
> Here, what if I change it to just:
> 
> 	if (decay_pcp_high(zone, this_cpu_ptr(pcp))
> 		changed = true;

Looks nice to me! :)

> 
> Since even if changed == true already, this will be a no-op.

I was thinking the compiler might or might not emit unnecessary writes, but I
don't really care that.  Your suggested version looks good to me :)

> 
> > Just a personal and trivial taste.  No strong opinion.  If you don't strongly
> > feel my suggestion is better, please keep the original code.
> 
> I feel like if someone (you) feels like bitwise operations here makes it
> less clear what the code is doing, others may feel the same way as well!
> Happy to make the change to hopefully make it more easily understandable
> what is happening. 

Thank you Joshua!

[...]
> Thanks SJ, I hope you have a great day!

You too!  Plus, great weekend!


Thanks,
SJ

[...]

