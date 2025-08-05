Return-Path: <linux-kernel+bounces-756481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2EB1B4E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B428C7AEA14
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0465274B28;
	Tue,  5 Aug 2025 13:28:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8E226861;
	Tue,  5 Aug 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400532; cv=none; b=jIvplhObO+H5fIAxhT52Uf0rrR6SCLtBZgi9nFY/2qWlTWSnqahHbpz3/+VZiIYQLZE7g3gcQskt1sFnCB8QGNAnFrTR4zahL/UewScJpgrNuLxI80xHpkaHiRjxS6aAvxkL4HAovdsBsCAC1x7i0gBNAEtMQiiVAKXX4rTylsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400532; c=relaxed/simple;
	bh=LGCtxZGKqJ/T7fT2EX9t2uPVkHMdfcR3gXKIlv9D2us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTa4bGADuR0ZrXjHi+OAf0szwc9+QRxBuSgpH6J0SnQVXnOg0LtLy8cN98EaHt2OkCj+xtpC2DCLNAoyV14UUAOVBwfdQa128iPp+xS8DakdO6sDWOqNQW8hoTnGUynIbQ/xF9GsPVQwGyfb6UgPWwJ7tf9KCOWpnhPNFFlQ3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A33FE160431;
	Tue,  5 Aug 2025 13:28:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 6CBBB60009;
	Tue,  5 Aug 2025 13:28:38 +0000 (UTC)
Date: Tue, 5 Aug 2025 09:29:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sasha Levin <sashal@kernel.org>, dan.j.williams@intel.com, Jiri Kosina
 <kosina@gmail.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand
 <david@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Vlastimil Babka
 <vbabka@suse.cz>, corbet@lwn.net, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
 konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250805092907.114eeb23@gandalf.local.home>
In-Reply-To: <20250804233906.GA12087@pendragon.ideasonboard.com>
References: <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
	<2025072832-enrich-pampers-54b9@gregkh>
	<1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>
	<aId1oZn_KFaa0R_Q@lappy>
	<aJB8CdXqCEuitnQj@tiehlicka>
	<aJC0ssMzX0KWnTkG@lappy>
	<alpine.LRH.2.00.2508050000580.22517@gjva.wvxbf.pm>
	<20250804181447.0c518b14@gandalf.local.home>
	<689139fe23f49_55f0910076@dwillia2-xfh.jf.intel.com.notmuch>
	<aJFCoewqTIXlhnJk@lappy>
	<20250804233906.GA12087@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6CBBB60009
X-Stat-Signature: ga34x1rbuidk78ckg6wninhur7qjhs6b
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX199WTIUFUacfwXt1+7g+5RNNUBC/xiBqV4=
X-HE-Tag: 1754400518-941711
X-HE-Meta: U2FsdGVkX1/LXeYrBOoHg13mAhKoYYR8wqCWtgfcwbQV4w73zaDSKeBVX+ZUsBEa5aLAQcBQR7qocSfRrNTC9dBvhpNQ2BGIue6CogyX0GtNwiiWTfZzUG/tuAwdxVUaBGKcPJyN4Ln93nwmDcAoopOQ6ny7+mordoCZoRVyZQL9lyEF4L/4GBqeEzpF334EzH5Wy7vQOa2qsSa8uUCNMAjYy9xZxcPxvlCtPcUXRUrVThrscqdvcryfWUjqGsB2FnKG08cGfwMTESFz7HSNY0l33BGehYaKFEy6hpa3qJAMGIYDkI1JSZK8UI3j7BPzpRa3I1TdTzQkXqxFTSN4sf6YbdpmLzbAheDfw4Ok7J3PE89UxRU/dQH/5t9RR9rS

On Tue, 5 Aug 2025 02:39:06 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> > >
> > >"Be prepared to declare a confidence interval in every detail of a patch
> > >series, especially any AI generated pieces."  

Honestly, I think we need to state that.

> > 
> > Something along the lines of a Social Credit system for the humans
> > behind the keyboard? :)
> > 
> > Do we want to get there? Do we not?  
> 
> Don't we have one already ? I'm pretty sure every maintainer keeps a
> mental list of trust scores, and uses them when reviewing patches.
> Patch submitter who doesn't perform due diligence usually lose points,
> especially if the offences occur repeatedly (newcomers often get a few
> free passes thanks to their inexperience and the benefit of the doubt,
> at least with most maintainers). 
> 
> LLMs increase the scale of the problem, and also makes it easier to fake
> due diligence. I believe it's important to make it very clear to
> contributors that they will suffer consequences if they don't hold up to
> the standards we expect.

My question is, do we want to document expectations of a patch being
submitted. It's been a while since I fully read SubmittingPatches (so much
so, I last read it when it was called that!). Maybe it's already in there.

If not, perhaps we need to update the document with the idea that people
will now be using AI more often to help them do their work. That's still
not an excuse to not understand the code that is being submitted.

-- Steve

