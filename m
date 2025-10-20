Return-Path: <linux-kernel+bounces-861693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52926BF35E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F28FC34236C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29A92D6E53;
	Mon, 20 Oct 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWTdBCev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76A2236E0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991546; cv=none; b=Nhs5DHoPiuRATTQ8OtvqV/ZZjDeGTVtEWheP0OdVMpb5vkEYbDVBivo4kAy3cF0jK3lNHxfU3rHcOs/wwtCXNXeb+0MpU+rULhy4huABsI3PIY/wMHVqCWHJ0mP2bNbpjsmohID5A13jQP2y2HXUqYiklZS/NC0FysKhEi0iaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991546; c=relaxed/simple;
	bh=01YCaKh5Wt7oKTEJH28qOs2bFtcBa8gWk/i1AJMIOo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYgvMEVbBD4Jam07sAoA+SoghSv0yqhw4mP1svALEAbu+YuYHfpFADU7VAgkGqkyZR93wNjoldPt8LSkIZJNVF3Jcv1kOKOaPJLO+JRThEJMR7mr8FtNnCsbR/mefJ8sPH5S+wgF3/gw8f3/JJ7EaYOFfINA9LrJwPx9d3uRKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWTdBCev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3CAC113D0;
	Mon, 20 Oct 2025 20:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760991543;
	bh=01YCaKh5Wt7oKTEJH28qOs2bFtcBa8gWk/i1AJMIOo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWTdBCevDJwhGE+ozHSGgPYatr9uLFWZIux6xGFqpSioIec5pxPK3Z/CQCvJgdPht
	 BdLkqM2KOimK/OvuSGJwxwleYe6Vum43E694X8I4u1cze5PrCmoo4Wt6ExweAI76sq
	 NMszJIZgZdhO2l+9KNd9Qg/4pYMJsKOIukcgH33L9N3onJ6cgjD7AApobA2WnNqnHl
	 Eqc0mXpKV/twHeCRXRQ32uTZbDyxhUNPw459XbEBv6Vo/Gsq8reokJV+tJq7EKIDZr
	 Ke+0HuKVJpwjR3fjYsQ+AN2bfnltKJx7CkOs097yV0NOYmAVjU8EuAqqUkFlknbOMf
	 J78ua8gL8Qvdg==
Date: Mon, 20 Oct 2025 13:19:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-kernel@vger.kernel.org, 
	Arthur Marsh <arthur.marsh@internode.on.net>, x86@kernel.org
Subject: Re: tools build: Fix fixdep dependencies
Message-ID: <oavj77novhxcvo5fmvbdrpg64ishdvfdtij5olhicz7raxqjom@k673wwslnm6a>
References: <176060840507.709179.15363439615733763867.tip-bot2@tip-bot2>
 <c1d395c6-2d3b-4504-befe-6e67c7ed96fc@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1d395c6-2d3b-4504-befe-6e67c7ed96fc@leemhuis.info>

On Sat, Oct 18, 2025 at 07:12:02AM +0200, Thorsten Leemhuis wrote:
> On 10/16/25 11:53, tip-bot2 for Josh Poimboeuf wrote:
> > The following commit has been merged into the objtool/core branch of tip:
> > 
> > Commit-ID:     a808a2b35f66658e6c49dc98b55a33fa1079fe72
> > Gitweb:        https://git.kernel.org/tip/a808a2b35f66658e6c49dc98b55a33fa1079fe72
> > Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> > AuthorDate:    Sun, 02 Mar 2025 17:01:42 -08:00
> > Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
> > CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00
> > 
> > tools build: Fix fixdep dependencies
> > 
> > The tools version of fixdep has broken dependencies.  It doesn't get
> > rebuilt if the host compiler or headers change.
> 
> My daily -next rebuilds based on the Fedora rawhide srpm failed due to
> this patch while building perf:
> 
> make[4]: *** No rule to make target '/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/perf/libsubcmd/fixdep'.  Stop.
> make[3]: *** [/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/build/Makefile.include:15: fixdep] Error 2
> make[2]: *** [Makefile.perf:981: /builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/perf/libsubcmd/libsubcmd.a] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 
> Full log: https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/09700031-next-next-all/builder-live.log.gz
> 
> Happened on ppc64 and s390x, too (and likely on x86_64, too, but that
> failed earlier during the build due to an unrelated problem).
> 
> Reverting this change fixed the problem.

Thanks, I will post a fix for this shortly.

-- 
Josh

