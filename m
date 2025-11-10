Return-Path: <linux-kernel+bounces-894304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB1C49B85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECDD1889942
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDE2242D78;
	Mon, 10 Nov 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ATeWa4Fq"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C1231A21
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816630; cv=none; b=Q0ZHZG1jta+M962Ma3jMh92hsKPEW7M8s/zYxMqOwJ7cQwN3A553RoGAn51AzRD719mV8R5fyw3RPFsSpboYVGcdBtnZ7nE+ZEQz/J87E2vwuokCHO2ESFWzYkaGs3wfqcDcKtz+VZ9+mkSHBs0JVEDACTLS1n+/bzWumd2PHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816630; c=relaxed/simple;
	bh=bvOQVAW4xZu//+HiMJtkilK7EJbPJne5AV/st98p1Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE0f8Uaq+3wARB/pPh/S4PPQ6rpuH2T7F/wXZsVI50K90+mUGlzIJCAImkyrDzODMEz2xaF9Y6IzP1lJeVtViKbI+XQ3CRjUDlMmQxf/Sh2Trphd5bLyche2+Fj5UN8XWZwBWcxecJq9hDSwzMWmyCcCBdvw9isu9kvnPxZaOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ATeWa4Fq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AANGT4N030494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762816594; bh=pz5MQEMeQZEfyQeXRoiXDtdCcCqVSnlw8NgqWs3tuxg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ATeWa4FqGLrAKrokLxXk6CjEuAJO1/g9AYh5xC3gtbjG3UPdLLdXHJkk2TCh8WiSK
	 ovqALsp+PvnqZ4NcBjaLbyRUJx6g/7Nq0bn8WmZfkmocTaK6FDYxwcJJHLXDlCjGF4
	 inYcHNG7dDJGZ1CTkJpyzCTr9tQt5adaZfFW58kXBekAAs6H3dDOP0Q+TPvKXUlg7L
	 nopwhMBvjsOgUlCKMIafhovP2rAdHGbSSlaZFswiAJRspYXkHDCpH+0BY0vfTpAbw8
	 EHaEckVN9VlVPMWs2l68ZqF9b+1rg2QbY0HkJmMk4iNijSZJIpW4hYVycje6zy1DYm
	 GiBztfqiaSmig==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 8468A2E00D9; Mon, 10 Nov 2025 18:16:29 -0500 (EST)
Date: Mon, 10 Nov 2025 18:16:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110231629.GI2988753@mit.edu>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
 <20251110-weiht-etablieren-39e7b63ef76d@brauner>
 <20251110172507.GA21641@pendragon.ideasonboard.com>
 <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
 <aRIxYkjX7EzalSoI@kernel.org>
 <CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
 <A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
 <CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
 <20251110145405.5bc87cc5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110145405.5bc87cc5@gandalf.local.home>

On Mon, Nov 10, 2025 at 02:54:05PM -0500, Steven Rostedt wrote:
> Probably no difference. I would guess the real liability is for those that
> use AI to submit patches. With the usual disclaimers of IANAL, I'm assuming
> that when you place your "Signed-off-by", you are stating that you have the
> right to submit this code. If it comes down that you did not have the right
> to submit the code, the original submitter is liable.
> 
> I guess the question also is, is the maintainer that took that patch and
> added their SoB also liable?

ObDisclaimer: Although I have take one or two law classes at the MIT
Sloan School (e.g., "Law for the I/T Manager"), I am not a lawyer, and
more importantly, I am not *your* lawyer.  So this is not legal
advice. 

Maintainers are always assuming that code that has a Signed-Off-By is
code that the submitter has a right to submit.  This is true before
AI, and it will be true today, after the advent of AI.  If I receive a
patch from someone who works for Google, or Microoft, or Amazon, how
do I know that they haven't cut and pasted code from their compan's
internal proprieatry code base?  I don't.  I rely on the Signed-off-by
and the good faith of the code submitter, and if someone sends me code
that they aren't authorized, it is my personal belief that I wouldn't be
liable; only the submitter.

What is true for code written by human (who might or might not have
cut and pasted from their internal code search), it should just be as
true for AI-generated code.

In fact, from a strict legal liability perspective, I'd be happier not
knowing whether or not a particlar patch had some kind of LLM
involved.  What I don't know, I can't *possibly* be held liable.

						- Ted

