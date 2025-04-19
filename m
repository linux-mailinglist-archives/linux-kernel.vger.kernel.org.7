Return-Path: <linux-kernel+bounces-611697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699BA9450C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 20:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ADE81893986
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265181DE4E0;
	Sat, 19 Apr 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XDyag/lY"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB001C2DB2
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745087851; cv=none; b=mVxbveZfMISp8L4enkFqqtkAeh8aj8s6DR4xt9aoyh5Xy4ueZP3RSfOrsmRkgY1VJKDSgZSxIEbJLMZSA3gPnQnFxdXCDcJyUnhWOL5+ux1m+6fO5sZj7eclQmJy22Hud2oreb217Wi8SQ7HSx6jJFTDgRDCKPSaLOAMpCKt648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745087851; c=relaxed/simple;
	bh=bYVXT/gi8Vmo7V8R1HO3Tqd+QyUFthZGaL2CtqUKmtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ/MaZUlz+tVEEqKrKQVzcZzyZc3wfDTkfr+rAm53r01EBEFSZs9chOcQOUGSBQlbnUbd/8hPMAiL2nAeTBjdWAagQ3YS4ZhguV+5vlp2AAMc+ghsqsiFgSFE7IuxRNIMZBrpW43ZeRaetEpTBaXQzKgiuihWb7KxjRsXSJAi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XDyag/lY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 19 Apr 2025 11:37:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745087847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ka2oRAjGjNJo329BJpc/w566FeETcwM1BtabKQ7KTgg=;
	b=XDyag/lY0QYQravzP+pLHoe80W8Re1TyTTEVpu5JCWEGNVxneNbp/tonovgEEW1XNKGdsg
	1QTobfjkKLRZqUoHM3wdSVrrIvjJSAp1mKoj5jzAZFZieJBO8mPTqIn3dhUS3YT816o+8o
	ZdmXMTBK5GQCUkJtgjLCCimX7kogCMQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, longman@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 1/2] cpuset: rename cpuset_node_allowed to
 cpuset_current_node_allowed
Message-ID: <leup3efhttams5y3j6cvgfjcai2ns45zs27jp25ijbqk6fh6iz@bsa5pnwhydcu>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419053824.1601470-2-gourry@gourry.net>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 19, 2025 at 01:38:23AM -0400, Gregory Price wrote:
> Rename cpuset_node_allowed to reflect that the function checks the
> current task's cpuset.mems.  This allows us to make a new
> cpuset_node_allowed function that checks a target cgroup's cpuset.mems.
> 
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

