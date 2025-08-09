Return-Path: <linux-kernel+bounces-761172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42271B1F53E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028603B23CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC4274B5A;
	Sat,  9 Aug 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkn8DZbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B235898;
	Sat,  9 Aug 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754754442; cv=none; b=cyRY8yxlX/PKq00acyo8RlMTYrU0kzHMvb/+iYEyUg68ni4w2ZKYXYmjE+srOPiBqfg+e9Zx2Il7TdWM3pBGvvULopO9kXCJiK2dugg9cDZosWgwmzCDzICjzfm9hKxdzYDEG69NLjskLhOGJ5aJNwz/LZ/KknqyF1QAkCdQUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754754442; c=relaxed/simple;
	bh=YHBM3Kt/CXqGsQnTOsqsjFAcAg3r2WP0nFyyLxHyjB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSZKVq7kUvqKVTAdCY2M76QOxQ2XEaHzpjtKJYV5D6AguiZAaDS6s2TE9r9jhUtuVYv+p41dx2JxYfO3KwViSLro4z25belrVY2xP0Gu1Cm+e/aZA/c0RcfIP9f3cPp4/cmgDcXIWtY1lc8tlEEqFp5oQdbnqajORDyeL6vJQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkn8DZbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F73C4CEE7;
	Sat,  9 Aug 2025 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754754441;
	bh=YHBM3Kt/CXqGsQnTOsqsjFAcAg3r2WP0nFyyLxHyjB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tkn8DZbPayb++ejni54yisZM/o353tkciON6zDB2YD4L3ipnXMrxusoTZbRiKJYiS
	 3+und1P0FSDSGIuwnUW0nrx8hhgIcYzRXkmtnQjRY59CHK+Kq1bqg+/JzUyTs54nh+
	 J9yN9jOBPgQnzMSouvj8uEQfntMtU0RicTYz2zG0ot/g1dqutwQ3a2uYOe/3W927Vs
	 yKJIZfW5MDYwR45nN+J60m5uZX86SSi7XhwCEYHlfc4DSJE8lnW6AvHSGKpL0wS1j3
	 VmEEpHsTUdcs9wbD/f2bdU/+QJcGQgiMsWKEnwwzVhTtDv2OAR+L8G3QA12FEdjaYq
	 Y2P621aj2cuRQ==
Date: Sat, 9 Aug 2025 17:47:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 00/12] docs: kdoc: thrash up dump_struct()
Message-ID: <20250809174717.45e26abf@foz.lan>
In-Reply-To: <20250807211639.47286-1-corbet@lwn.net>
References: <20250807211639.47286-1-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu,  7 Aug 2025 15:16:27 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> In my ongoing effort to truly understand our new kernel-doc, I continue to
> make changes to improve the code, and to try to make the understanding task
> easier for the next person.  These patches focus on dump_struct() in
> particular, which starts out at nearly 300 lines long - to much to fit into
> my little brain anyway.  Hopefully the result is easier to manage.
> 
> There are no changes in the rendered docs.
> 
> Changes in v2:
> 
>  - Reduce the regex backslash removal to keep them in place for
>    {}()[] even when not required.
> 
>  - Restore some of the single-use variables set from regex matches
> 
> Mauro, I have applied your Reviewed-by to everything except patch 10,
> hopefully it is more to your liking now.

All looks good to me now. Thanks!

I sent a suggestion for a further improvement on patch 10/12 together
with my R-B.

> [Helpful hint for the future: if you are going to make a bunch of
> subtle changes to regexes used throughout a patch series, do it at
> the end...you'll go through far less rebasing pain that way when you
> have to change them... :) ]

Sorry for that! Yet, IMO, the code looks a lot nicer with the regex
changes you did over the past version.

Regards,
Mauro

