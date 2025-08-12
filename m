Return-Path: <linux-kernel+bounces-765662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F6B23C38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780147B708B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3656F2D0622;
	Tue, 12 Aug 2025 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7i4scn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B31E493C;
	Tue, 12 Aug 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755040671; cv=none; b=dZjA6q9GLiEYwaFqNk80GCZnC/WT3NvHiLa45jwXQxBk6eJ01v59H/kYvv6PUv+U3pb0iPw0j5Js728Q2hSiLAiu18oeV9oozezAx5iLwz4wQgQsHEtiBqGMEYzjZTKySDRFZvqQ7QrTb8QRgKSUfjEdyrISgjQo+WM8EUuk5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755040671; c=relaxed/simple;
	bh=mphiqOdQXDDKL7JZOE6d1Tgtt4nHTE3ai/ZtREqsIbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bS1HUOaCO75VS+8o4WkRJP5t3bNrxYmUbS3zIFSGIn5R4yDLLxZ6KZzD3xyJVzDHGD0dgtgtGY8qLOiuNcDFQOWoq4OsD7AtG9MhWnPcgFE1pPR3ghSYqslcyS0J+W0w9NLaA/KvxtOqvh/J7Wi+kuvaRNW2bhwKZGcO6Y0Z2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7i4scn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3820C4CEF0;
	Tue, 12 Aug 2025 23:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755040671;
	bh=mphiqOdQXDDKL7JZOE6d1Tgtt4nHTE3ai/ZtREqsIbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D7i4scn1FQ/wT7dOAYsdhBmhevEiPfY/I3BUlQhqFg4t9ByvbjzkFH18wgOpMzg3d
	 MFRqGjvG6An1L2ZHjkqTLZndtfnaJPtJwufhroPVkP40UNhfjrAI+ZEp4EvxXGLyEj
	 wprEyM4oRjB7FLisg/gGjU8Ct8wVHxCT9IF6Zv/NNALonRmBnG3sb38HSVqRqvFLH1
	 a/z88sPXJxOL+50l4lR02YmbbWFL4V0Uy40if9sus75cuAwxUfH7WsYwuXwo2wLkWR
	 uiMWRMDC2/eU+Xa5b+rLffxiFi/VIphl3L43UCSrLZnej1Pw24NcVXSQJXHItsIEOP
	 sZM9bHV1HlTVQ==
Date: Wed, 13 Aug 2025 01:17:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 3/7] docs: kdoc: clean up the create_parameter_list()
 "first arg" logic
Message-ID: <20250813011746.6779c0f1@foz.lan>
In-Reply-To: <20250812195748.124402-4-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
	<20250812195748.124402-4-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:57:44 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> The logic for finding the name of the first in a series of variable names
> is somewhat convoluted and, in the use of .extend(), actively buggy.
> Document what is happening and simplify the logic.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 53051ce831ba..47f7ea01ed10 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -553,18 +553,18 @@ class KernelDoc:
>                  arg = KernRe(r'\s*\[').sub('[', arg)
>                  args = KernRe(r'\s*,\s*').split(arg)
>                  args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
> -
> -                first_arg = []
> -                r = KernRe(r'^(.*\s+)(.*?\[.*\].*)$')
> -                if args[0] and r.match(args[0]):
> -                    args.pop(0)
> -                    first_arg.extend(r.group(1))
> -                    first_arg.append(r.group(2))

I double-checked the Perl code. The Python version seems to be an exact
translation of what was there:

            $arg =~ s/\s*\[/\[/g;

            my @args = split('\s*,\s*', $arg);
            if ($args[0] =~ m/\*/) {
                $args[0] =~ s/(\*+)\s*/ $1/;
            }

	    my @first_arg;
            if ($args[0] =~ /^(.*\s+)(.*?\[.*\].*)$/) {
                shift @args;
                push(@first_arg, split('\s+', $1));
                push(@first_arg, $2);
            } else {
                @first_arg = split('\s+', shift @args);
            }

Yeah, I agree that this logic is confusing. 

> +                #
> +                # args[0] has a string of "type a".  If "a" includes an [array]
> +                # declaration, we want to not be fooled by any white space inside
> +                # the brackets, so detect and handle that case specially.
> +                #
> +                r = KernRe(r'^([^[\]]*\s+)' r'((?:.*?\[.*\].*)|(?:.*?))$')

Same comment as patch 6/7... concats in the middle of the like IMO makes it
harder to read. Better to place them on separate lines:

	r = KernRe(r'^([^[\]]*\s+)'
		   r'((?:.*?\[.*\].*)|(?:.*?))$')

> +                if r.match(args[0]):
> +                    args[0] = r.group(2)
> +                    dtype = r.group(1)
>                  else:
> -                    first_arg = KernRe(r'\s+').split(args.pop(0))
> -
> -                args.insert(0, first_arg.pop())
> -                dtype = ' '.join(first_arg)
> +                    # No space in args[0]; this seems wrong but preserves previous behavior
> +                    dtype = ''
>  
>                  bitfield_re = KernRe(r'(.*?):(\w+)')
>                  for param in args:

I didn't test your new code. On a first glance, it doesn't seem identical
to the previous one, but if you tested it and the results are the same,
the new version seems nicer once you split the concat on two lines. So,
feel free to add:

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


-

Btw, IMHO, it would make sense to have unittests to check things
like that to ensure that new patches won't cause regressions for
some particular usecases.

Thanks,
Mauro

