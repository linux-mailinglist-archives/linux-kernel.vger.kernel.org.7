Return-Path: <linux-kernel+bounces-755765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBA9B1AB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FFB18821D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9628FFEE;
	Mon,  4 Aug 2025 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jDZ96kNc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074C1F4CBE;
	Mon,  4 Aug 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754350767; cv=none; b=muZWB+1FEKR4xZcfr7LDMw/Cpj8ABwDK/DeJ/VYCzivAK0/YW7IBkBiMezA9FTaaPL2BScXi0NyVehZKrf0Axo+mXUQHoySzHHVRTQ/5DTUIdRZ1ZESxnLV6/D/XHaO6b5Sx1MUZKUO6E2cDDKYTacP0Tx/3n1MYlaKn8NNUoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754350767; c=relaxed/simple;
	bh=Y21wIn+9YS6YuHlvV176AwuvuiJ2FJWeFTpt1xcUhkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg2uC8PuGAzBZ48bBG0C8R37B9BZbGzC/lOvPjoVTZ7o3Ks/2ZlZOz3C7tlM3JtGpn2rD/db3WCBqrgEd2ahQNkkag4lDyt9NNkwkhFb1vDrqwaTWocqscWW8c851y+377Wxh/ol46MWKtPExrhcueLUU/KRkh3h5HxhvCUTYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jDZ96kNc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 6739032FD;
	Tue,  5 Aug 2025 01:38:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1754350713;
	bh=Y21wIn+9YS6YuHlvV176AwuvuiJ2FJWeFTpt1xcUhkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDZ96kNcCEGVlMVZfraOUZ/AKpFJ06ySWrGKEkivfVi6CX9DghyUTk1fUCARTxfnG
	 +ZaYc2h73Tv91GkmAp0COo2MnQi6rE3f45ijUJMrc6Niqis0KhvPjKN/aiYttBPf9n
	 MrCopIIjy9kpXQyLiuMlwSGNhvGV1CE5/LpL//hQ=
Date: Tue, 5 Aug 2025 02:39:06 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sasha Levin <sashal@kernel.org>
Cc: dan.j.williams@intel.com, Steven Rostedt <rostedt@goodmis.org>,
	Jiri Kosina <kosina@gmail.com>, Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250804233906.GA12087@pendragon.ideasonboard.com>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJFCoewqTIXlhnJk@lappy>

On Mon, Aug 04, 2025 at 07:30:41PM -0400, Sasha Levin wrote:
> On Mon, Aug 04, 2025 at 03:53:50PM -0700, dan.j.williams@intel.com wrote:
> >Steven Rostedt wrote:
> >> On Tue, 5 Aug 2025 00:03:29 +0200 (CEST)
> >> Jiri Kosina <kosina@gmail.com> wrote:
> >>
> >> > Al made a very important point somewhere earlier in this thread.
> >> >
> >> > The most important (from the code quality POV) thing is -- is there a
> >> > person that understands the patch enough to be able to answer questions
> >> > (coming from some other human -- most likely reviewer/maintainer)?
> >> >
> >> > That's not something that'd be reflected in DCO, but it's very important
> >> > fact for the maintainer's decision process.
> >>
> >> Perhaps this is what needs to be explicitly stated in the SubmittingPatches
> >> document.
> >>
> >> I know we can't change the DCO, but could we add something about our policy
> >> is that if you submit code, you certify that you understand said code, even
> >> if (especially) it was produced by AI?
> >
> >It is already the case that human developed code is not always
> >understood by the submitter (i.e. bugs, or see occasions of "no
> >functional changes intended" commits referenced by "Fixes:"). It is also
> >already the case that the speed at which code is applied has a component
> >of maintainer's trust in the submitter to stick around and address
> >issues or work with the community.
> >
> >AI allows production of plausible code in higher volumes, but it does
> >not fundamentally change the existing dynamic of development velocity vs
> >trust.
> 
> Right: I think that the issue Jiri brought up is a human problem, not a
> tooling problem.
> 
> We can try and tackle a symptom, but it's a losing war.
> 
> >So an expectation that is worth clarifying is that mere appearance of
> >technical correctness is not sufficient to move a proposal forward. The
> >details of what constitutes sufficient trust are subsystem, maintainer,
> >or even per-function specific. This is a nuanced expectation that human
> >submitters struggle, let alone AI.
> >
> >"Be prepared to declare a confidence interval in every detail of a patch
> >series, especially any AI generated pieces."
> 
> Something along the lines of a Social Credit system for the humans
> behind the keyboard? :)
> 
> Do we want to get there? Do we not?

Don't we have one already ? I'm pretty sure every maintainer keeps a
mental list of trust scores, and uses them when reviewing patches.
Patch submitter who doesn't perform due diligence usually lose points,
especially if the offences occur repeatedly (newcomers often get a few
free passes thanks to their inexperience and the benefit of the doubt,
at least with most maintainers). 

LLMs increase the scale of the problem, and also makes it easier to fake
due diligence. I believe it's important to make it very clear to
contributors that they will suffer consequences if they don't hold up to
the standards we expect.

-- 
Regards,

Laurent Pinchart

