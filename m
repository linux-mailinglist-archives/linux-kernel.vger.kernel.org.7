Return-Path: <linux-kernel+bounces-752940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3BEB17CC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2E61C27071
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF01F3B8A;
	Fri,  1 Aug 2025 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOZ1PnGs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C933987;
	Fri,  1 Aug 2025 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028468; cv=none; b=PI8PxhiBpJtyj3Yg0H3emAGWS1Z0F20PNIUc66XMnN7gCDef9QJoF9te01w4LvGEQ72XiuK9oE/uHNE9+C+0Nsmxezb7WOl4iU5BfPRy8qY2F8F/VIKgTBgzFAgHss7or5H72KQ6OyWjlfjL67sCVpWnFZdeBi+bUl+VYobYizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028468; c=relaxed/simple;
	bh=SKcAG9s36AttOiFoT61hu0hmfOOD1shJUfG5+sw3YVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Od31e+M2cNyzd8VsTJpvLo5UydhWBPxMiU4qh6MlNqNZnNyeUadzmiJJ79p9I/5njqOVX2+ayNi2xSZl6XAxrLPTgBgQft1WQBNgv/yJvpWAx+Gb+xLWBM2drjNeHaTF264xbaWfM7AMBujWB0uZ8x6gSTdunSkWnUnk4+HIeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOZ1PnGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55EFC4CEE7;
	Fri,  1 Aug 2025 06:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754028468;
	bh=SKcAG9s36AttOiFoT61hu0hmfOOD1shJUfG5+sw3YVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GOZ1PnGscHObXscgPGu0bdqUUJUBV7Rge0EK4TnxJDCTLK1UCnj+BBQcswHa61uLC
	 2WoMvqKUIwX32T6mx5exdPT6319MdUuB4/C5Qhsa+mVBDeHzA5Y2xH53wn3ftrE2zy
	 icy+0tXG3aLEBgZrcL423sV6YY3s1K8KL+bCdJT5C67yOcfYxBZGFQf+Ml0ajHgcwe
	 tly4ppmBphD0/SNGZka81RaTGWaNp+jIoZFEMhuaDs/50emKB6ZtR9fCjkamCAapCv
	 A0TxtIHbZy0Fxn7gISCu9cXuQ3y3V5HGvm44612a9Qbuxb4eTvoEDQVj08vRB+FN6v
	 1oolfRFOJY5MA==
Date: Fri, 1 Aug 2025 08:07:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 10/12] docs: kdoc: further rewrite_struct_members()
 cleanup
Message-ID: <20250801080744.14f83626@foz.lan>
In-Reply-To: <20250801001326.924276-11-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-11-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:24 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Get rid of some single-use variables and redundant checks, and generally
> tighten up the code; no logical change.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 89 ++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 47 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 20e0a2abe13b..2b7d7e646367 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -673,73 +673,68 @@ class KernelDoc:
>          while tuples:
>              for t in tuples:
>                  newmember = ""
> -                maintype = t[0]
> -                s_ids = t[5]
> -                content = t[3]

The reason I opted for this particular approach...
> -
> -                oldmember = "".join(t)
> -
> -                for s_id in s_ids.split(','):
> +                oldmember = "".join(t) # Reconstruct the original formatting
> +                #
> +                # Pass through each field name, normalizing the form and formatting.
> +                #
> +                for s_id in t[5].split(','):

... is that it is easier to understand and to maintain:

	for s_id in s_ids.split(','):

than when magic numbers like this are used:

	for s_id in t[5].split(','):


>                      s_id = s_id.strip()
>  
> -                    newmember += f"{maintype} {s_id}; "
> +                    newmember += f"{t[0]} {s_id}; "
> +                    #
> +                    # Remove bitfield/array/pointer info, getting the bare name.
> +                    #
>                      s_id = KernRe(r'[:[].*').sub('', s_id)
>                      s_id = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
> -
> -                    for arg in content.split(';'):
> +                    #
> +                    # Pass through the members of this inner structure/union.
> +                    #
> +                    for arg in t[3].split(';'):

Here, for example, we're far away from the tuple definition... I can't
recall anymore what "3" magic number means ;-)

>                          arg = arg.strip()
> -
> -                        if not arg:
> -                            continue
> -
> +                        #
> +                        # Look for (type)(*name)(args) - pointer to function
> +                        #
>                          r = KernRe(r'^([^(]+\(\*?\s*)([\w.]*)(\s*\).*)')
>                          if r.match(arg):
>                              # Pointer-to-function
> -                            dtype = r.group(1)
> -                            name = r.group(2)
> -                            extra = r.group(3)

Same applies here. Having a named var makes easier to understand/maintain
rest of the code. If you're willing to do something like that, better to
use named capture groups, like:

	r = KernRe(r'^(?P<dtype>[^(]+\(\*?\s*)'
		   r'(?P<name>[\w.]*)'
		   r'(?P<extra>\s*\).*)')

together with a syntax using match.group(group_name)

I'm not a particular fan of named groups, as it adds a lot more stuff
at regexes. They're already hard enough to understand without ?P<name>,
but at least match.group('dtype'), match.group('name'), match.group('extra')
inside the next calls would be easier to maintain than when using magic
numbers.

Same comments apply to other changes below.


> -
> -                            if not name:
> -                                continue
> -
>                              if not s_id:
>                                  # Anonymous struct/union
> -                                newmember += f"{dtype}{name}{extra}; "
> +                                newmember += f"{r.group(1)}{r.group(2)}{r.group(3)}; "
>                              else:
> -                                newmember += f"{dtype}{s_id}.{name}{extra}; "
> -
> +                                newmember += f"{r.group(1)}{s_id}.{r.group(2)}{r.group(3)}; "
> +                        #
> +                        # Otherwise a non-function member.
> +                        #
>                          else:
> -                            # Handle bitmaps
> +                            #
> +                            # Remove bitmap and array portions and spaces around commas
> +                            #
>                              arg = KernRe(r':\s*\d+\s*').sub('', arg)
> -
> -                            # Handle arrays
>                              arg = KernRe(r'\[.*\]').sub('', arg)
> -
> -                            # Handle multiple IDs
>                              arg = KernRe(r'\s*,\s*').sub(',', arg)
> -
> +                            #
> +                            # Look for a normal decl - "type name[,name...]"
> +                            #
>                              r = KernRe(r'(.*)\s+([\S+,]+)')
> -
>                              if r.search(arg):
> -                                dtype = r.group(1)
> -                                names = r.group(2)
> +                                for name in r.group(2).split(','):
> +                                    name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name)
> +                                    if not s_id:
> +                                        # Anonymous struct/union
> +                                        newmember += f"{r.group(1)} {name}; "
> +                                    else:
> +                                        newmember += f"{r.group(1)} {s_id}.{name}; "
>                              else:
>                                  newmember += f"{arg}; "
> -                                continue
> -
> -                            for name in names.split(','):
> -                                name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name).strip()
> -
> -                                if not name:
> -                                    continue
> -
> -                                if not s_id:
> -                                    # Anonymous struct/union
> -                                    newmember += f"{dtype} {name}; "
> -                                else:
> -                                    newmember += f"{dtype} {s_id}.{name}; "
> -
> +                #
> +                # At the end of the s_id loop, replace the original declaration with
> +                # the munged version.
> +                #
>                  members = members.replace(oldmember, newmember)
> +            #
> +            # End of the tuple loop - search again and see if there are outer members
> +            # that now turn up.
> +            #
>              tuples = struct_members.findall(members)
>          return members
>  



Thanks,
Mauro

