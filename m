Return-Path: <linux-kernel+bounces-752929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1667B17CA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1691C27976
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E591F12FB;
	Fri,  1 Aug 2025 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieAq1MX2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD41347DD;
	Fri,  1 Aug 2025 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027416; cv=none; b=Q1jrMavMlrmhRUYlIXKxI2UUBnToAvePNuYEbVHLQywEmaGUaV0s5h5B8SzcjXDRRcRTNB01LEIwwPLNrlsSbTiC6e8xq+6AFvZ00sJIFPyTLV+A8bA2fg4mJ7IJ1cSpCxBZB952kWV0mmy0SoazIKkhh2a5naQGICVNUUhDR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027416; c=relaxed/simple;
	bh=NU0fx3/xNBKwdmPMNh+Xy+m2WgMnwTddLcWr/Hqfpts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4b3KHQD/rxpTmRFhpKVfnD6LgSTaIVm213XAd8XH9WMDmJ2UfuhlRPN1cGSQZbiBRzIbGjySxVwNKwltXH6srpZPJriwF71tRqI8nokhF/TzIIrNlEWa6rl7IfSbm2rqGK3gG6P2VGqzru59hqQRaL5W+yNi6fLnyffvIQowPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieAq1MX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645F1C4CEE7;
	Fri,  1 Aug 2025 05:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754027415;
	bh=NU0fx3/xNBKwdmPMNh+Xy+m2WgMnwTddLcWr/Hqfpts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ieAq1MX2kjbK3zRLP9bG1zkEpyeuCdDZgmH80oIF2MS84Q4q2PTv321gthfuWehGB
	 ciA+8TaXCVsT0ds+aqmrHCCzlypWeCPO5mOTsHAQyUBFwFzYWoUmnNEfLg5CxK44WI
	 s3tWc6KaxJTJN+NB2shKv/mCZcGBWbhBQ1FNhd613b72XdJruDlhEAvqnEV+Lp/6zi
	 GAoFVP0ylZmnFcG+RyAwqEs04CsJdi4pNaedn5IWGVWcExyoml3vnZr893wYUiRr5S
	 rL9v9E5cCB5sxT7bA46e6OjO98yPpOxLsC32dqxUxwM2Wv7U9nMnutGuXWenJ6mxCx
	 cOKx+JLENDkAA==
Date: Fri, 1 Aug 2025 07:50:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 09/12] docs: kdoc: Some rewrite_struct_members()
 commenting
Message-ID: <20250801075011.04645db6@foz.lan>
In-Reply-To: <20250801001326.924276-10-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-10-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:23 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Add comments to rewrite_struct_members() describing what it is actually
> doing, and reformat/comment the main struct_members regex so that it is
> (more) comprehensible to humans.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index b751fa8edde7..20e0a2abe13b 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -647,22 +647,28 @@ class KernelDoc:
>                  return (r.group(1), r.group(3), r.group(2))
>          return None
>  
> +    #
> +    # Rewrite the members of a structure or union for easier formatting later on.
> +    # Among other things, this function will turn a member like:
> +    #
> +    #  struct { inner_members; } foo;
> +    #
> +    # into:
> +    #
> +    #  struct foo; inner_members;
> +    #
>      def rewrite_struct_members(self, members):
> -        # Split nested struct/union elements
> -        #
> -        # This loop was simpler at the original kernel-doc perl version, as
> -        #   while ($members =~ m/$struct_members/) { ... }
> -        # reads 'members' string on each interaction.
>          #
> -        # Python behavior is different: it parses 'members' only once,
> -        # creating a list of tuples from the first interaction.
> +        # Process struct/union members from the most deeply nested outward.  The
> +        # trick is in the ^{ below - it prevents a match of an outer struct/union
> +        # until the inner one has been munged (removing the "{" in the process).
>          #
> -        # On other words, this won't get nested structs.
> -        #
> -        # So, we need to have an extra loop on Python to override such
> -        # re limitation.
> -
> -        struct_members = KernRe(r'(struct|union)([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
> +        struct_members = KernRe(r'(struct|union)' # 0: declaration type
> +                                r'([^{};]+)' 	  # 1: possible name
> +                                r'(\{)'
> +                                r'([^{}]*)'       # 3: Contents of declaration
> +                                r'(\})'
> +                                r'([^{};]*)(;)')  # 5: Remaining stuff after declaration

I liked breaking it like these, but I do miss backslashes before some
'{' and '}' to make this actually more readable on my eyes.

Re-adding that, you can add:
	Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks,
Mauro

