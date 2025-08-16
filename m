Return-Path: <linux-kernel+bounces-771720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CCB28AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF17E568C37
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A94E1DDA09;
	Sat, 16 Aug 2025 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jevQ0cpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183478F24
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755322377; cv=none; b=X2clzcd9E3cC2M7FhXKFFllcqPyID+LuYtE67nIYBnBeiVEqrw//pSB/Mb7t9jnUvSjH8l5W/OrQonJiaUE995OvdkNA1/ve2qylFZ65hoI3za4N5r39Rva8JqcLiXT+szfOF0qYGIZnMX0eRElJhUTBPcuOzJAolKWmwEITJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755322377; c=relaxed/simple;
	bh=X7O1jVKovpwhLjSTwmeZcxswY/N3bjAaHeRDsMVRDag=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b2J+3mZi8DblfSOBz+ZQDq99a2xMK1rR+WPuUT4KRyfauwDqFKZ1z/OxfbfHNeGFtOMjkCmtys43Dn8+iMYCrmT7Ka+kSnxjEST6RIvpUfB9Wau8KlC3GUK11S/XavSiv9EDx0ZkZYA7i08QAD1qi99kKctlUg8dML3GEPws5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jevQ0cpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF153C4CEEF;
	Sat, 16 Aug 2025 05:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755322377;
	bh=X7O1jVKovpwhLjSTwmeZcxswY/N3bjAaHeRDsMVRDag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jevQ0cpIKyiUMzImRBWj1P+2mNroXv7SJjyDPeyGcWpDY0PtiUhOccUUjkw37HCbo
	 0ZMnLMa4HUaVl0E1dvHSk6Eob7iSkd1+jgHli0wNMVkNK/paSYHC3HX5d5YDF2YvlW
	 6WyUttO9FK0ihtopVxsp2hq6TqYmtEACRZKSQFtk=
Date: Fri, 15 Aug 2025 22:32:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Yu Zhao
 <yuzhao@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark MGLRU as maintained
Message-Id: <20250815223256.111f6ce04da3528fdf19ae84@linux-foundation.org>
In-Reply-To: <22qegz4vktquv22nome6csd4vngvwcaeydoyg3ttqoal5vum27@knjvryszxbdm>
References: <20250815215914.3671925-1-axelrasmussen@google.com>
	<7a46f7jwlwgkbdjvbxjaalrrdamgtxkptmytllhkr2qv4ovbge@nbugfzavwh5w>
	<CAJHvVchYa-vUcQo92awyHE663n-iMsLK31o+1FKrMvdLMAuUOg@mail.gmail.com>
	<22qegz4vktquv22nome6csd4vngvwcaeydoyg3ttqoal5vum27@knjvryszxbdm>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 17:08:59 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> > > > +MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)
> > >
> > > Why not just add yourselves (and the missing files) to the existing
> > > reclaim section? Eventually we want a single reclaim solution, so why
> > > not start with single reviewer section?
> > 
> > Sure, I can see the argument for that.
> > 
> > I suppose the case against would be, perhaps the folks already listed
> > in the RECLAIM section don't want to additionally get e-mail for the
> > extra files listed in this patch? (Perhaps mostly the MGLRU
> > documentation, the rest of them aren't necessarily MGLRU specific.)
> > 
> > I don't have a strong preference either way, I think mostly I'd be
> > interested to know Andrew's or the other reviewers' preference. Note
> > Lorenzo suggested a separate MGLRU section here:
> > https://lkml.org/lkml/2025/8/14/271
> > 
> 
> I would not be too worried about folks getting emails for MGLRU. Anyways
> whatever Andrew decides is fine with me.

We all like lots of emails, don't we?

I don't know, the main thing is to get it in there - we can fine-tune
things later if desired.


