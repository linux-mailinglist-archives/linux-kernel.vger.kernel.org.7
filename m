Return-Path: <linux-kernel+bounces-612072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993DFA94A29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 03:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA9216F81A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6C502B1;
	Mon, 21 Apr 2025 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZNImUV9V"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC78EDDA9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745198854; cv=none; b=G1c+ZjIusG4AW0ycm0gBETRLNu+g5m1U6iK93PGNKrUgxTixF0fcpzbKA5MkWW/5Ig+vx0gF2KupD6aTqCyu1SlH40Q0lU2EFLOsiNo57GTKfSDUzRe7nG7js0Wcl0ZS0SBc4iI667ewBdBZAmfNXhh49z2KEjoHqw7rXFu+GVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745198854; c=relaxed/simple;
	bh=J0L+9lfh3W6tuuDJehMuZDOjWAum5k+olTMZ6tMQpx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqbUN3ZdX1TQ99ghZWIvY1fIwamLKRfAb4DGNSTZx9U6PlxPaGmcrLH7+vbEx6JdNzSCaY8KyblkGNd33qIFIQxEhcQTdsaq4UZtsJmxp7civif7qsN7rGIbthZOSWDlGvOuRdgamwy/PPFvx1A37fVWY8l6wgg0c0YGEyTO1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZNImUV9V; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 20 Apr 2025 21:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745198850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2jp3/lO32nyPCKwhyTc5hlOL8Q8zjhzUd2Zj41EJN8=;
	b=ZNImUV9VCk/x5h1xm/UusL8dt0SkYYGONjZCaM/hqF4sA96Cl1kqyUp4N13pzHNN8QO1X4
	Eh1XM5NLiKHhBJ5zuUd4t5EjrgdxC9XrnZ27gno3HDHJLIngSobhp1abxH6TKQ23aX/9jc
	Uw1u4CbAqVPgaWq0sMHQda7+iXRul/0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] enumarated refcounts, for debugging refcount issues
Message-ID: <yd3f6ie56x2dbagqycwluxtz7inrmbub5fg7omp226vrdvxtb2@sjn23uj3r6t7>
References: <20250420155918.749455-1-kent.overstreet@linux.dev>
 <202504201808.3064FFB55E@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504201808.3064FFB55E@keescook>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 20, 2025 at 06:08:41PM -0700, Kees Cook wrote:
> On Sun, Apr 20, 2025 at 11:59:13AM -0400, Kent Overstreet wrote:
> > Not sure we have a list for library code, but this might be of interest
> > to anyone who's had to debug refcount issues on refs with lots of users
> > (filesystem people), and I know the hardening folks deal with refcounts
> > a lot.
> 
> Why not use refcount_t instead of atomic_t?

It's rather pointless here since percpu refcounts don't (and can't)
support saturation, and atomic_long_t should always suffice - you'd have
to be doing something particularly bizarre for it not to, since
refcounts generally count things in memory.

Out of curiousity, has overflow of an atomic_long_t refcount ever been
observed?

