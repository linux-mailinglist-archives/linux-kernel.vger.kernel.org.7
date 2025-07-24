Return-Path: <linux-kernel+bounces-745104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A85B114F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC07189B5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1550724728E;
	Thu, 24 Jul 2025 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAp72SLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CF22B8C5;
	Thu, 24 Jul 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753401252; cv=none; b=qr6O6B4lSlGmvaXKJ5+C4AtSl8QKkRLAFE/Zob0VHfDOC0gfmGTUrUafP+O+QQWy50TCSU9atQRgrnZ0ImYSJoL2ujpzI2hQd4OdWY7rz+Wk1m+/CY6CkjnGYCH9RQ+8lpSUxnwS/KC+mzCKKkpB/OfdiWxkMgpO8WOVa8PiMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753401252; c=relaxed/simple;
	bh=Q9jh7CkBbhldMF1J1smRrxzkFS3p/4ns7ni/1yXL+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/8OBs8tZQCX3iZS7eDW7QYbGBMPLQPb5NkfJtqW/kqZhy8+S6tfIyxrE9VGZ0sEJWRWM/voUZ1IaTGbTOzJeQHQHLChRZDubo9XHBKkCNDIEbEj13dxflDV6z3tDg9ThJ6ZG6CpBBzYWylILh5hgziUjsOhT41tMvcSorZzTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAp72SLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1ECC4CEED;
	Thu, 24 Jul 2025 23:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753401252;
	bh=Q9jh7CkBbhldMF1J1smRrxzkFS3p/4ns7ni/1yXL+gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAp72SLDWjoJQolLVXqmG89HQuXI4rOyYoT/r7/OmhpCUYd3IVuD/mPrCpYWwKkNF
	 LEbV3b2QQhWgssePkS/zTeBB+ng03J+rOQGTOZpBxI8GxxFAR2+ChFaVstdP6Mb8Yn
	 xv4OmBCg7EyZLF2/skP2LRXrcItJ5ABYURm7kRkMVBFg6f9v8s2XSEz6Xb6qcwCOb+
	 pR+eHV8HgqkUoJucQ/7EODEKIASEaxRqB0EbcLqC9yVjGy10BoXl6/oPZQpYkHmnuz
	 7WqMpSL88i8Sk29xWaqzC3ldqwH9xYcjAjglXQOMAQhUQaVMX8VlTvSqvDhbI60wuV
	 Ncne9e7ef+GLA==
Date: Thu, 24 Jul 2025 16:54:11 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <202507241651.5E9C803C70@keescook>
References: <20250724175439.76962-1-linux@treblig.org>
 <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
 <202507241418.34AFD28C@keescook>
 <20250724194556.105803db@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724194556.105803db@gandalf.local.home>

On Thu, Jul 24, 2025 at 07:45:56PM -0400, Steven Rostedt wrote:
> My thought is to treat AI as another developer. If a developer helps you
> like the AI is helping you, would you give that developer credit for that
> work? If so, then you should also give credit to the tooling that's helping
> you.
> 
> I suggested adding a new tag to note any tool that has done non-trivial
> work to produce the patch where you give it credit if it has helped you as
> much as another developer that you would give credit to.

We've got tags to choose from already in that case:

Suggested-by: LLM

or

Co-developed-by: LLM <not@human.with.legal.standing>
Signed-off-by: LLM <not@human.with.legal.standing>

The latter seems ... not good, as it implies DCO SoB from a thing that
can't and hasn't acknowledged the DCO.

-- 
Kees Cook

