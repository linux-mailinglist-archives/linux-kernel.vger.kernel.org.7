Return-Path: <linux-kernel+bounces-761171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07504B1F53C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB46254AB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5575D2BE653;
	Sat,  9 Aug 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtD+6zK8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99030274B5A;
	Sat,  9 Aug 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754754285; cv=none; b=THBaDXGAL+3+S4yfbPnmo2bZUbE8kKfg5dXG3uS8h+yzNQ45JA5TwBxybPU3jy/CGxGF9KbPCB/VQPSh6yzw21uvRXuflPkTfFKAmohlc6JM9TUhPfdC4fMnUjuCV8I3o1M18ZA9S90GllpelnMxanSueNM+IdKJEiAivekHVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754754285; c=relaxed/simple;
	bh=k3EHWo7z0Fgl/ecQ3m03h2zQ8gHkwpN9dUUclhzRHh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRQol15xA4bGftjK9Vhy4D3csyu9Jx7Ymi7w/7RUH8biVNz4tXcA5W/slTX2/8/RgbUpBhhd3KLfLQdXFN7ATBY5ydEWOP1+AI2oVCm58r0dWHRPL6rSZtzmNpoyEfLKbQ+Qpqnq+pIYQGmffh+Lp6NgH1m80s7o8SAx7JQVspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtD+6zK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185F9C4CEE7;
	Sat,  9 Aug 2025 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754754285;
	bh=k3EHWo7z0Fgl/ecQ3m03h2zQ8gHkwpN9dUUclhzRHh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JtD+6zK8UccuOL/d7BzEdMEOprAEBhBtaxnNEioaBbJeB3yqWGkmtzXO1BGMeBZfo
	 DWsI8e+FHIaLGinQEe+A2H6P7fVmxon0RJLsNrAGcE6rniCjCoWfYRSbfnkegS2s5b
	 jtwpb9dJb+XWoWAfyxFx7RDf962kMzot2N28cHG4EeqBNRTdxeJ8i2d79tYOlyNi6C
	 Ku3uHG9Ew5p9nLquTFprXiTctnL8f2eCJcvNrNotnArTOdPvWP2Th42rzesWL/wwQq
	 2YH989iijNa6NIgxukuCaW3n9Sp/LeyUByRXsB5grO4JEixVwneOZWjFDBKth5zfH6
	 76aPp/AO2Dfdg==
Date: Sat, 9 Aug 2025 17:44:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 10/12] docs: kdoc: further rewrite_struct_members()
 cleanup
Message-ID: <20250809174441.6b0baa06@foz.lan>
In-Reply-To: <20250807211639.47286-11-corbet@lwn.net>
References: <20250807211639.47286-1-corbet@lwn.net>
	<20250807211639.47286-11-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu,  7 Aug 2025 15:16:37 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Get rid of some redundant checks, and generally tighten up the code; no
> logical change.

LGTM, but see below:

> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 86 ++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 45 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index e3d0270b1a19..b3f937901037 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -673,73 +673,69 @@ class KernelDoc:
>          while tuples:
>              for t in tuples:
>                  newmember = ""
> -                maintype = t[0]
> -                s_ids = t[5]
> -                content = t[3]
> -
> -                oldmember = "".join(t)
> -
> -                for s_id in s_ids.split(','):
> +                oldmember = "".join(t) # Reconstruct the original formatting
> +                dtype, name, lbr, content, rbr, rest, semi = t

Here, I would either use non-group matches or use "_" for the vars
we're just ignoring.

IMO, the cleanest approach without using finditer would be:


	struct_members = KernRe("("			# 0: the entire pattern
				r'(struct|union)' 	# 1: declaration type
				r'([^\{\};]+)'
				r'(?:\{)'
				r'(?:[^\{\}]*)'		# 2: Contents of declaration
				r'(?:\})'
				r'([^\{\};]*)(;)')	# 3: Remaining stuff after declaration
				")")

	tuples = struct_members.findall(members)
	while tuples:
            for t in tuples:
		oldmember, maintype, content, s_ids = match.groups()

I wonder if using finditer would avoid the first while - I guess not
as the logic here picks multi-level members - but if it matches, then
It would be a nice improvement to use it.

Anyway, such cleanup can be done later. So:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> +                #
> +                # Pass through each field name, normalizing the form and formatting.
> +                #
> +                for s_id in rest.split(','):
>                      s_id = s_id.strip()
> -
> -                    newmember += f"{maintype} {s_id}; "
> +                    newmember += f"{dtype} {s_id}; "
> +                    #
> +                    # Remove bitfield/array/pointer info, getting the bare name.
> +                    #
>                      s_id = KernRe(r'[:\[].*').sub('', s_id)
>                      s_id = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
> -
> +                    #
> +                    # Pass through the members of this inner structure/union.
> +                    #
>                      for arg in content.split(';'):
>                          arg = arg.strip()
> -
> -                        if not arg:
> -                            continue
> -
> +                        #
> +                        # Look for (type)(*name)(args) - pointer to function
> +                        #
>                          r = KernRe(r'^([^\(]+\(\*?\s*)([\w.]*)(\s*\).*)')
>                          if r.match(arg):
> +                            dtype, name, extra = r.group(1), r.group(2), r.group(3)
>                              # Pointer-to-function
> -                            dtype = r.group(1)
> -                            name = r.group(2)
> -                            extra = r.group(3)
> -
> -                            if not name:
> -                                continue
> -
>                              if not s_id:
>                                  # Anonymous struct/union
>                                  newmember += f"{dtype}{name}{extra}; "
>                              else:
>                                  newmember += f"{dtype}{s_id}.{name}{extra}; "
> -
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

