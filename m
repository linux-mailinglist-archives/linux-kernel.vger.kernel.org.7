Return-Path: <linux-kernel+bounces-893901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEBDC489C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648291883D22
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD9532AAB2;
	Mon, 10 Nov 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9KomAO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988331BCAE;
	Mon, 10 Nov 2025 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799979; cv=none; b=dDh+B2ss5ai8I4qL5OH2YfWOPQidXMPowQgrOK4r3LLpKeCFq33VFxZpAj8y/04qOHosoTEpil+wIiOVuln/s5/A8SZtO4fP/IY63d1WktUmRlTD6NlzamVXIatiYuyTZksJYxo6fA7ItyUIMTxGjgKSbc3Pf634zsPFOqYcO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799979; c=relaxed/simple;
	bh=IvGt/WWiUvQoOBi0OItWTxUXBAZF0Qzn0yz7/eSCvjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hbn83O5updrh03U2yRK3xomPy3unJ/ZrfDL/Ze+HiWgiRum6qfhcbZRHPpy4kP2xqBl3quH4QPpQUXfd9c8lAT7FNZVOZy/KwG4WnnfL10tSOlcbhASQyU/h3uTuxMy7ilrv7Q4N1CVYXYDBdlika6LKHpERVDQBT0azV8E+2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9KomAO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732E5C116B1;
	Mon, 10 Nov 2025 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799978;
	bh=IvGt/WWiUvQoOBi0OItWTxUXBAZF0Qzn0yz7/eSCvjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9KomAO8CwRBGHlqqIJTdETtAwI10GvE66jMHKwRB/OjZbxLKLz+Zun5NhfDZiagG
	 OraXZpV32gOXO51qm5fvIEmxWB58T5wB2JejYle7ZvSTl/Mys2r/VE0NxdfBPz79rg
	 QKlF32Tk5yJJ04+nxTEWkhJoOGBQN7HZ+0zqB3+WdRdTxJAJ8TNZF58NM2oUTXUoV/
	 M/2rRB0YX36YyART5lsqxRqB/lIq7EPBB86bO6gouUuDPW+nIWye2zaYt7/l+xC94t
	 2B07uJ7dMT4prpzgvhAi/I726ZVrlcnFish+XAYf9yVblkIOOYdZHCBWd01TlirXWJ
	 M+8ih6iu/lwvA==
Date: Mon, 10 Nov 2025 20:39:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Christian Brauner <brauner@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	"ksummit@lists.linux.dev" <ksummit@lists.linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <aRIxYkjX7EzalSoI@kernel.org>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
 <20251110-weiht-etablieren-39e7b63ef76d@brauner>
 <20251110172507.GA21641@pendragon.ideasonboard.com>
 <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>

On Mon, Nov 10, 2025 at 09:44:00AM -0800, Linus Torvalds wrote:
> On Mon, 10 Nov 2025 at 09:25, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Mechanical transformations are often performed with Coccinelle. Given
> > how you mention that tool below, I wouldn't frame it as out of scope
> > here.
> 
> Honestly, I think the documented rule should not aim to treat AI as
> anything special at all, and literally just talk about tooling.
> 
> I think we should treat any AI generated patches similarly: people
> should mention the tool it was done with, and the script (ok, the
> "scripts" are called "prompts", because AI is so "special") used.
> 
> Sure, AI ends up making the result potentially much more subtle, but I
> don't think the *issue* is new, and I don't think it should need to be
> treated as such.
 
The novelty here is that AI does not only transform the code, it can
generate it from scratch en masse.

>                  Linus
> 

-- 
Sincerely yours,
Mike.

