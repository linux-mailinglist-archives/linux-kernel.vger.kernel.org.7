Return-Path: <linux-kernel+bounces-876912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2986C1CC10
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABC0427CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE2B2ED87F;
	Wed, 29 Oct 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T73DY/BJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFDF350A31
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761761; cv=none; b=A/t0/OuNHmfA3pWPdBSgjXdA1NJcgz08zv/Tgh3bwq0Wxd5ObePt4SYtQAMFZtuwiZnzYta28iB8cfyHjrZfGBx9Tx1n6FR9xo74XWBohHu4Tk7FDq5j4Fz2YmcOwjfJZ15RInjc5XPU6h54DgTouPV8dBYk0yDSifV4D/PQ1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761761; c=relaxed/simple;
	bh=eLbccdj+72VhYU327uN0Zxnlm8keZTmMM2Y3v4EP+vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF4JpalW4TCHufGO+nVdopjXwD3haw7pl7jzr/xFajW1V9KDEKJysIgMYIg6/hjegjp3G3VvAX+cLhh1P+Ta3lhgxO8tPGBJgAJHuhDY8eC34dlFpMF/a3hkSPVToP4bArfZFvjw39B9K/e+VDz6yhjc4vmsi7UcmPCam/gq7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T73DY/BJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE21C4CEF7;
	Wed, 29 Oct 2025 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761761761;
	bh=eLbccdj+72VhYU327uN0Zxnlm8keZTmMM2Y3v4EP+vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T73DY/BJfAkbXY6fKpZl/O9cj1+Su+EgbmJYRTf3U+uqURDEmiGf1Oqsk8ptDWNik
	 EvbAWxgQmqn+hTHBuZwL5+1fsOL+Tpl5DydIwGt4kuNHgJkGHhQqSJYrZutMGfQQDV
	 MD3G8dYmAIJcF+QZ/ew+pZey9uxQHLkEbnZLmWQyr2JCVwCVDjU1Wc5gFcXyLo+giJ
	 vf4eM+Z3NETGYsc62FowhYsOQAhIoe46PgDcUhiTIgfaRbVN5UCWCaeoDjrfiOfEJM
	 hEN/k006LPPMZsElT+TFsOn9KIp3TvJiwRfo+CGV9jzNcVw9c2VtDDgML77mWT+zZ9
	 gZ/f6/BEO5x+w==
Date: Wed, 29 Oct 2025 08:16:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	simona.vetter@ffwll.ch, pstanner@redhat.com, dakr@kernel.org
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aQJZ4E5axRGCPpPv@slm.duckdns.org>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
 <2e1e9d6f-4f9e-49f7-90f0-6759c260701f@amd.com>
 <aQEkq7DYy5/AaJ4R@lstrano-desk.jf.intel.com>
 <aQIthmQmKfztyaQZ@slm.duckdns.org>
 <aQJE170PEFatwXCG@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJE170PEFatwXCG@lstrano-desk.jf.intel.com>

On Wed, Oct 29, 2025 at 09:46:15AM -0700, Matthew Brost wrote:
> On Wed, Oct 29, 2025 at 05:06:46AM -1000, Tejun Heo wrote:
> > How about making it a WQ flag?
> 
> That could work too. We want to enforce rules of drivers actually set
> these flags setting passing workqueues to the DRM scheduler. Any
> objection to adding helpers to the workqueue layer to fish the
> information we'd like to enforce?

Difficult to tell definitively without looking at the helpers but no
objections to the general idea.

Thanks.

-- 
tejun

