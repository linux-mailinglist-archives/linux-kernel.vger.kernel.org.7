Return-Path: <linux-kernel+bounces-752809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D49B17B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A795680DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE517BEBF;
	Fri,  1 Aug 2025 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E0nHAjRY"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48778F4F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754015297; cv=none; b=sA2vbd57kv085r6KglN5O6I849QFCLn3/yKIJ7wJ8QSXvW4VSjB5HaVU12J1GZm+0xpb7l0VcMMrSMudvPsmvPgD/8XtwSJ2YTAjpq7oPb5Wj1EhDK/POC7lZb9n5NdswH+Xeifyx41VnyzuPXQL+KthybwQQsmupfNLT8TK3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754015297; c=relaxed/simple;
	bh=/3xjHgGqoX9LXDA7FW8p5jRMwAaUxAk/bT5pxxzHXpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ertIzREgHEfr4y9xM2AXIj8K0mp/e6dFu8hQpw4BwxvF0/7otwh3hFpJaW11MibfXoNhFTU9MU3NrXX7OKcNTaBLRtrwgfjJaThSpJHjsnJ+j+EiLV0cP7Ofl+mm7QZIhdiFk4pU5RwkBnsmzNW0qnMFcO3gz1doLP1O+UOO9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E0nHAjRY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Jul 2025 22:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754015291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qATfYxkJ2lUUcIMB1+MnAKkLf+MKdiD0hrn8yfGwNc=;
	b=E0nHAjRYNPGoQVEt0y5uHcD9xGCGZr2/IPkrjvtE64nf0KFkpEwpgGo/8+Z/z+hFfaP5If
	p+oPNa+EODCPvWmiwDLhVc/qfKeoKurJLY10AcisdTD66xaFZNv2xv6ABWkR6oA5Dzjmv1
	AnCtXcnb4Xck9v8hUoM713Pe+7481b0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-bcachefs@vger.kernel.org, Liao Yuanhong <liaoyuanhong@vivo.com>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bcachefs: Simplify kzalloc usage
Message-ID: <hu5y7xoxtx6sqk6vegszx3jgngmu2pvqbscmk6hok3du6qrkr7@26zo2k73o5b2>
References: <20250731131551.218666-1-liaoyuanhong@vivo.com>
 <32fbb160-4888-4d57-bd16-62ece192e81c@web.de>
 <ztnjjzlx3a2cvmxnc3jx2umwlh2faetdy6rzhmuc746vppmuns@lzn33bv2smpz>
 <a3860880-acfb-41cc-98dd-0d878d9b37dd@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3860880-acfb-41cc-98dd-0d878d9b37dd@web.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 31, 2025 at 10:00:31PM +0200, Markus Elfring wrote:
> >>> Use the shorter variants will improves further maintainability. 
> >>> Convenient for subsequent code updates or refactoring.
> >>
> >> Please improve such a change description.
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n45
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.16#n941
> > 
> > The commit message is reasonable, it communicates the intent.
> 
> * I would wonder about the relevance of a shorter item here.
> 
> * Would you like to avoid wording weaknesses?
> 
> 
> Another example for previous contributions:
> https://lore.kernel.org/all/?q=%22Improve%20size%20determinations%22
> 
> 
> > I haven't decided if I want to apply it; the dereference approach is
> > better in principle but it's very far off into the weeds of "things that
> > will never, ever cause an actual problem".
> 
> Have you got development views which might be in contradiction
> to the preferred Linux coding style?

Marcus, I believe you've been warned in other subsystems, by other
maintainers - you need to cut this out. I decide what's acceptable for
patches to bcachefs, not you :)

