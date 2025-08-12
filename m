Return-Path: <linux-kernel+bounces-765658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D0B23C11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772B63B2457
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1062D7396;
	Tue, 12 Aug 2025 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctnzpVbX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8D19D880;
	Tue, 12 Aug 2025 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039219; cv=none; b=ArvD7d3OPNAvMtS4t3ea3ICEkl+Js5b0Yz+UP2jTrQ0diFQpGouW834J74+21vDT0hbbQNW7Yfy7KtQWf7/2hn9XgGLoqmTidWaZN+eNmS+u1QcXV0ureGvCJzqdOQpsipOeCslr7xwfmkz2xAuqJB51b/Ny8SkiDRw8V2y2Rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039219; c=relaxed/simple;
	bh=c+XUIxg3sUqAKz4dc24+y98/2s7vOcaQJ8wyf8BG8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd8HtnGcrU1CjxIApdSlD+nAPaLqYQPtQMdwUiATIqT9MK/vom44ZP2iSiCaLO0KerlRFbGU2NENiadBRvdnCIgW1PIYqod++/xG9FQoOa9+GVDZFhOdGPBBRiPprQKi+A/K3CqmoXerUb2jZ8OWcEhePq+SNikUw8IsW+xvhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctnzpVbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A76C4CEF0;
	Tue, 12 Aug 2025 22:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755039219;
	bh=c+XUIxg3sUqAKz4dc24+y98/2s7vOcaQJ8wyf8BG8Cg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ctnzpVbXnJ372oGY4sC4AUjPwQsWRojQI5/Jm0Y+Et1A/TTtpI8hbusnLeppyyKTm
	 Pulrd3AKlsLLNkkOeAreGenLXXMNNd4H2fnFvzE/vPy32TUxeARfOW5s2mFQHxj4Ro
	 UM0ZPkAlnLt2iotbkS5bdGGRZ59giPY10YCzvtbTpGJQu6CzOUmbIhE7q/nZ67xksU
	 OgHgognmSoi8HWWMHwD4Ea3VewKqLxJBCxuCYxTiS6jgU7ZNI6I3Svem1eSY806BPD
	 mPFNf5venvjPKz5jZUNyiXfo/0lxsNsntSxPDp3N7joGGVAEJJKoZecv3lEVaYfnIe
	 lTNaYqUU6hV6w==
Date: Wed, 13 Aug 2025 00:53:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 5/7] docs: kdoc: tighten up the array-of-pointers case
Message-ID: <20250813005334.31db20b0@foz.lan>
In-Reply-To: <20250812195748.124402-6-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
	<20250812195748.124402-6-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:57:46 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Simplify one gnarly regex and remove another altogether; add a comment
> describing what is going on.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 36c4035343dc..d7fb79a64487 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -527,23 +527,19 @@ class KernelDoc:
>                  dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
>                  self.push_parameter(ln, decl_type, param, dtype,
>                                      arg, declaration_name)
> -
> +            #
> +            # The array-of-pointers case.  Dig the parameter name out from the middle
> +            # of the declaration.
> +            #
>              elif KernRe(r'\(.+\)\s*\[').search(arg):
> -                # Array-of-pointers
> -
> -                arg = arg.replace('#', ',')

Hmm... if I'm not mistaken, there is(was?) a previous code that replaced
commas by "#". Such statement is needed to catch some corner case.

This like here is(was?) needed to restore the original arg string.

> -                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\].]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
> +                r = KernRe(r'[^\(]+\(\s*\*\s*' r'([\w.]*?)' r'\s*(\[\s*\w+\s*\]\s*)*\)')

As mentioned on patch 6/7, IMHO doing concats like that at the same line
IMO makes it harder to understand. This works best:

                r = KernRe(r'[^\(]+\(\s*\*\s*'
			   r'([\w.]*?)'
			   r'\s*(\[\s*\w+\s*\]\s*)*\)')


>                  if r.match(arg):
>                      param = r.group(1)
>                  else:
>                      self.emit_msg(ln, f"Invalid param: {arg}")
>                      param = arg
> -
> -                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
> -
> -                self.push_parameter(ln, decl_type, param, dtype,
> -                                    arg, declaration_name)
> -
> +                dtype = arg.replace(param, '')
> +                self.push_parameter(ln, decl_type, param, dtype, arg, declaration_name)
>              elif arg:
>                  #
>                  # Clean up extraneous spaces and split the string at commas; the first



Thanks,
Mauro

