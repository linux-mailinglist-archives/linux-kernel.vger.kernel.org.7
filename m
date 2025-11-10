Return-Path: <linux-kernel+bounces-894061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D71BC492C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F203B189A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC133F8A0;
	Mon, 10 Nov 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFecNSsk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A8337B8A;
	Mon, 10 Nov 2025 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804856; cv=none; b=t44YPkZrU0d00pzsMscq557Dt50RMiQaXRStRSCgZaTFHXo1eK8jXxARo80TZiKAB/jquT3w+QquYxWFubrDhf9j9ovGQ7/AJZRn3es+z9+0aGLnA3gd+1FRCYQKsNLkqAbyut19rovZPSQYp8Q9kVPywGEkIZKUohj8QUxZ9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804856; c=relaxed/simple;
	bh=h3o9LAmSyvnIV3axnAq88Rd/1hcBZOHc9Sn/FM6kKjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUkhrp79e3lRCMRictC3UW6/coDuEO10HPKf4Izetf3gUVw2Tol4F4TdryvQ85I6CEnj9c0ljnEo6lfD/e6lmKwpWtK4V4cB6lZ8AcLeAcb/ex8OST48wAB+Te03Qv7PpUYEdtrz6f1i7XXLqAOVFWUp8tww+gMu83/qeuUWWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFecNSsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D34BC16AAE;
	Mon, 10 Nov 2025 20:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762804855;
	bh=h3o9LAmSyvnIV3axnAq88Rd/1hcBZOHc9Sn/FM6kKjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFecNSsktu3j835501fvdrNAHQdcXfJBeqB/8rcmLpxHpDaI9gnaWVUe1QmuoKv2W
	 TiLgRNTNBihqF8c8738rDT7E9BFfMJl1eJoU2EF3fs5rS6FVJo1vSaRHMP7EcZyjyr
	 TpDV9XYDgVKY6jv4GwkshuNcMgKPZ17S1MciZGfU=
Date: Mon, 10 Nov 2025 15:00:54 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, 
	Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110-spiffy-intelligent-cockle-efde1e@lemur>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110145405.5bc87cc5@gandalf.local.home>

On Mon, Nov 10, 2025 at 02:54:05PM -0500, Steven Rostedt wrote:
> Probably no difference. I would guess the real liability is for those that
> use AI to submit patches. With the usual disclaimers of IANAL, I'm assuming
> that when you place your "Signed-off-by", you are stating that you have the
> right to submit this code. If it comes down that you did not have the right
> to submit the code, the original submitter is liable.

And if the lawyers come back and say that the submitter is not liable, what's
to prevent someone from copypasting actual copyrighted code from a proprietary
source and adding a "Generated-by: Chat j'ai-pété" line to absolve themselves?

-K

