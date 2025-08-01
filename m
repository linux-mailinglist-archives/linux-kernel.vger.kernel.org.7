Return-Path: <linux-kernel+bounces-752916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6CB17C57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A497B06AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754151E3DFE;
	Fri,  1 Aug 2025 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CebuOb0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5E139D;
	Fri,  1 Aug 2025 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754026178; cv=none; b=AGz/Jy/mCA9FI6z7aPW+vkerSJQQJewztCAHJYzZGdIoESZx5eBo8ev5Lk6D4FVg1MAbHE8YBXKUfA9HXHeUM+V+LVrBQJIlH80ORYsCV3sw30Y6L6UkVqqz7Sh4HiEMsz6mdwjegLV5SqFZJBrN/GIA+SdQc54KEoKfYUjsktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754026178; c=relaxed/simple;
	bh=8LYkwKyjmxsIeKP0hQS4WPwPD9VbFwotzw7iSKIRj1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLV8cLdevi7DmqHpdqQe8DfE3tYhR77qyHhY1o7a0eron+mal+mKsO9jwEoXhn01GuPe4S4jO8rcysVdVnGEKGB7m8boKs8228cs1BPVCG8jOpqnXL0upE/ryTMrMYgzOnJHbMt0HqqZ462Y9LZ8F+B91yCK1GxKLmcbR1cujAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CebuOb0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA6CC4CEE7;
	Fri,  1 Aug 2025 05:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754026178;
	bh=8LYkwKyjmxsIeKP0hQS4WPwPD9VbFwotzw7iSKIRj1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CebuOb0/AZrk5+jjgrP9hSgD3wZVUVLfKqJkfZhSG8I/6SVQfCR10Fij7oMQyHCKY
	 eU2X1vx/eNc++/JaTzI70UgYqfHrhMXZni8qpAfLLfjUGvDjXb5gUSW+HoP7QajPsR
	 vfDny+bae3TKs6hPjvuxgE2mVkKx+VbOZadHVbZKQKwGGPkzxJghP58XZ2INBc6wb2
	 1JJ0EDsZx4XPLkCbbYD2med1bEi9nfyCPV7fdwVJlVEMNhonC+dCxDiSzieiKkFeSi
	 W+vUldAD6oDJ0ihM/I2+xVe+neXuNgW+Jl82sVu2ZgaQZh3Ul6LxFsB2a+FVFzL5f0
	 bZjLJQfy+gN1g==
Date: Fri, 1 Aug 2025 07:29:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 01/12] docs: kdoc: consolidate the stripping of private
 struct/union members
Message-ID: <20250801072934.47963ad7@foz.lan>
In-Reply-To: <20250801001326.924276-2-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-2-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:15 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> There were two locations duplicating the logic of stripping private members
> and associated comments; coalesce them into one, and add some comments
> describing what's going on.
> 
> Output change: we now no longer add extraneous white space around macro
> definitions.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 40 ++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index c3fe4bd5eab4..93fcd8807aa8 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -81,6 +81,21 @@ multi_space = KernRe(r'\s\s+')
>  def trim_whitespace(s):
>      return multi_space.sub(' ', s.strip())
>  
> +#
> +# Remove struct/enum members that have been marked "private".
> +#
> +def trim_private_members(text):
> +    #
> +    # First look for a "public:" block that ends a private region, then
> +    # handle the "private until the end" case.
> +    #
> +    text = KernRe(r'/\*\s*private:.*?/\*\s*public:.*?\*/', flags=re.S).sub('', text)
> +    text = KernRe(r'/\*\s*private:.*', flags=re.S).sub('', text)
> +    #
> +    # We needed the comments to do the above, but now we can take them out.
> +    #
> +    return KernRe(r'\s*/\*.*?\*/\s*', flags=re.S).sub('', text).strip()
> +
>  class state:
>      """
>      State machine enums
> @@ -568,12 +583,6 @@ class KernelDoc:
>          args_pattern = r'([^,)]+)'
>  
>          sub_prefixes = [
> -            (KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', re.S | re.I), ''),
> -            (KernRe(r'\/\*\s*private:.*', re.S | re.I), ''),
> -
> -            # Strip comments
> -            (KernRe(r'\/\*.*?\*\/', re.S), ''),
> -
>              # Strip attributes
>              (attribute, ' '),
>              (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
> @@ -648,6 +657,7 @@ class KernelDoc:
>              (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
>          ]
>  
> +        members = trim_private_members(members)
>          for search, sub in sub_prefixes:
>              members = search.sub(sub, members)
>  
> @@ -797,24 +807,18 @@ class KernelDoc:
>          """
>          Stores an enum inside self.entries array.
>          """
> -
> -        # Ignore members marked private
> -        proto = KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', flags=re.S).sub('', proto)
> -        proto = KernRe(r'\/\*\s*private:.*}', flags=re.S).sub('}', proto)
> -
> -        # Strip comments
> -        proto = KernRe(r'\/\*.*?\*\/', flags=re.S).sub('', proto)
> -
> -        # Strip #define macros inside enums
> +        #
> +        # Strip preprocessor directives.  Note that this depends on the
> +        # trailing semicolon we added in process_proto_type().
> +        #
>          proto = KernRe(r'#\s*((define|ifdef|if)\s+|endif)[^;]*;', flags=re.S).sub('', proto)
> -
>          #
>          # Parse out the name and members of the enum.  Typedef form first.
>          #
>          r = KernRe(r'typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;')
>          if r.search(proto):
>              declaration_name = r.group(2)
> -            members = r.group(1).rstrip()
> +            members = trim_private_members(r.group(1))
>          #
>          # Failing that, look for a straight enum
>          #
> @@ -822,7 +826,7 @@ class KernelDoc:
>              r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
>              if r.match(proto):
>                  declaration_name = r.group(1)
> -                members = r.group(2).rstrip()
> +                members = trim_private_members(r.group(2))
>          #
>          # OK, this isn't going to work.
>          #



Thanks,
Mauro

