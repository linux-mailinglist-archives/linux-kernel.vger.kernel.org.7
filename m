Return-Path: <linux-kernel+bounces-747452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24ECB13402
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84DE1895EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1C7219A89;
	Mon, 28 Jul 2025 05:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv6Z2STG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E5290F;
	Mon, 28 Jul 2025 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753679403; cv=none; b=mRRyD2FeEUohJ6oZnZ9neYKfrUJWOdCYtx2AqYnuARlx62WdqmmX005vJVRe93GizOLD8yhfU7KBwwgVSkHCA+TIUy1sOyhZ4gHZpATq/Yg3vhCf8imKHFqnwqhfgEp7SknsBxrp7hM2i43OtuRYdYZ1+CF16sTgSTJ32Qkm+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753679403; c=relaxed/simple;
	bh=2qEe6DqAuEUqbVXL+xo0D0mEXM1k79M9L758DOFS5aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSXvXtczsMBrxTjccI0cQZGgeV59oOexdaK/O9tqBTL9To1wHbV4iRIC0Y0gKd66wuYhSBg5qzBLuRYMvJDeZZOKiduHR+kDBNSBW6Lv2Orydtptm12lGu7qYdXXh4zLp0WhBug3EhyaPS0wRrA8FKTVv7E8+l3Kz+YsHiLbn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv6Z2STG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74D2C4CEE7;
	Mon, 28 Jul 2025 05:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753679402;
	bh=2qEe6DqAuEUqbVXL+xo0D0mEXM1k79M9L758DOFS5aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nv6Z2STGtW51o60x6gB7Ql5l7l59w88DNxhywbVhtsG3/+4zdOTJV9U6l2Blgn/oS
	 o5Nxi2Yy+ucZLF20ZyYXHlZ8xbOlnrDcnaPK6SNIJPfjJGcL9KIJfkJ23loHVi5JcI
	 /0jKLMW/aHvju+djmNq29WCMTJC0BURAl/Uxi6OSwqFp3xaFokaOmmxeT7mAr3QcNc
	 8j8kTiiVKrOs38oSVF85isktsZuWqXFhukCHW+lGipvT4nkIquaaJZG5jk7iKIwIyF
	 8FcnY5cXcGK1zgcOypvpKlb6itqjJuX7MBDXwaEE3HUkyFSsL370f+08jw6D/qBJah
	 a3Cu7DjVO3HsA==
Date: Sun, 27 Jul 2025 22:10:02 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <202507272203.BECE244@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <202507271937.EC44B39@keescook>
 <aIcD9f_52tlLgE-e@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIcD9f_52tlLgE-e@lappy>

On Mon, Jul 28, 2025 at 01:00:37AM -0400, Sasha Levin wrote:
> > If an Agent needs the above list, then so does a human. Everything above
> > should already be discoverable by the Agent. If it's not, then we need a
> > better summary document _for humans_ that reads like the above.
> 
> Why would an agent read those docs unless we tell it to?

When I typed "/init" in claude, it found the references in the Makefile
and other files to stuff in Documentation/ and read it. Hence my
suggestion to add this in a place that is human (and agent)
discoverable, like Makefile, which any sane agent is going to read to
look for a "help" target, etc. Any agent that doesn't understand how to
figure out what _kind_ of codebase it's working on isn't an agent that
is going to deal well with the Linux tree.

> Similarily, why would a human read those docs unless we tell it to? :)

We do, though. But this is my point: if we _lack_ a good entry point for
humans, then we need to solve _that_ problem.

> Just like with humans, the better context and background you give them
> the better of a result you'll get out of it.

Both the top of Makefile and the bottom of "make help" refer to reading
the README file. I think *that* is where all these kinds of changes
should go, and it should be suitable for human consumption. Honestly,
README is extremely vague right now:

$ cat README
Linux kernel
============

There are several guides for kernel developers and users. These guides can
be rendered in a number of formats, like HTML and PDF. Please read
Documentation/admin-guide/README.rst first.

In order to build the documentation, use ``make htmldocs`` or
``make pdfdocs``.  The formatted documentation can also be read online at:

    https://www.kernel.org/doc/html/latest/

There are various text files in the Documentation/ subdirectory,
several of them using the reStructuredText markup notation.

Please read the Documentation/process/changes.rst file, as it contains the
requirements for building and running the kernel, and information about
the problems which may result by upgrading your kernel.




"There are several guides..." and "There are various text files in
..." is hardly the right language for a human either. And why is doc
building in the README? That's, frankly, esoteric for anyone who needs
to read the README.

Let's fix up the README into something nice for everyone, and any decent
agent should already be reading it anyway.

-Kees

-- 
Kees Cook

