Return-Path: <linux-kernel+bounces-752915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E8B17C55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7717B5915
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C61E3DFE;
	Fri,  1 Aug 2025 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIBgt/Jk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54480139D;
	Fri,  1 Aug 2025 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754026125; cv=none; b=pmxmlLgXW80lKxDXHfd74MQIY85iB8vyEeqN8POgZXE6oY7PtuVNC156RnhqZiQQxASmyYhUOsHFc9zPBzVy33VdjU98jNMsn4xpwzx13H/S9h0yNrO+u0sJ4TSm4NFs27RZDWvgahkSLEkb7srjiBDo0Hd5OX+Vz3BuXGKxH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754026125; c=relaxed/simple;
	bh=ZBHsAN0trNPzYZj8u/UJHqu3Nl7vtcqqbKPxj2t6sbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsLNNKw6Dub1WKM5u0twvmAbP/mccEaNLav8Lq6yfHhGaDRGhODh3O0EoR7RlT19n7DNX/zG/VKZP3cd2qKqe7fNKNrRLcrFeYm8fV+LX230mJX6jv7LJVozjqEmuyG9Ce88nWgZDdhzBzS2zqBTqgL6Gt3svXwTll8RgLYg4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIBgt/Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D3C4CEE7;
	Fri,  1 Aug 2025 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754026124;
	bh=ZBHsAN0trNPzYZj8u/UJHqu3Nl7vtcqqbKPxj2t6sbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EIBgt/Jky+7c6uMbLxNTDX4KmiVPT/F5bHHgCOxIDd7s9HZBSIZBcsGz4oAtBnm38
	 tkPuH/2hW4yjeRP+qEYfSl1onOAajOifIe7BDtIXxn2/ZGOpZ2sTaXwxaKPp6XhpU8
	 9N2J3cYcgjsBppMMXAAnsx2kT9yxbCtZ6JDcrcqwjxOva4YvJAJc3mXzNF+AXaEd3m
	 7RDv9DQwN596JNNyIlbPtmKhy9XdsV0rMRh1M3kjav5ESAp6pCRNnPWMNg82henHkO
	 krx+R3xtcKq/DW2yJzrFdNc0GX4YEwpUD6E3hweJzG8Z7k+FO+qBZc1eQCZknME3F8
	 8xRO/RlqiAF2w==
Date: Fri, 1 Aug 2025 07:28:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 04/12] docs: kdoc: move the prefix transforms out of
 dump_struct()
Message-ID: <20250801072841.0246eeac@foz.lan>
In-Reply-To: <20250801001326.924276-5-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-5-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:18 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> dump_struct is one of the longest functions in the kdoc_parser class,
> making it hard to read and reason about.  Move the definition of the prefix
> transformations out of the function, join them with the definition of
> "attribute" (which was defined at the top of the file but only used here),
> and reformat the code slightly for shorter line widths.
> 
> Just code movement in the end.

This patch itself LGTM:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

but see my notes below:

> +struct_prefixes = [
> +    # Strip attributes
> +    (struct_attribute, ' '),
> +    (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
> +    (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
> +    (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
> +    (KernRe(r'\s*__packed\s*', re.S), ' '),
> +    (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
> +    (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
> +    (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
> +    #
> +    # Unwrap struct_group macros based on this definition:
> +    # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
> +    # which has variants like: struct_group(NAME, MEMBERS...)
> +    # Only MEMBERS arguments require documentation.
> +    #
> +    # Parsing them happens on two steps:
> +    #
> +    # 1. drop struct group arguments that aren't at MEMBERS,
> +    #    storing them as STRUCT_GROUP(MEMBERS)
> +    #
> +    # 2. remove STRUCT_GROUP() ancillary macro.
> +    #
> +    # The original logic used to remove STRUCT_GROUP() using an
> +    # advanced regex:
> +    #
> +    #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
> +    #
> +    # with two patterns that are incompatible with
> +    # Python re module, as it has:
> +    #
> +    #   - a recursive pattern: (?1)
> +    #   - an atomic grouping: (?>...)
> +    #
> +    # I tried a simpler version: but it didn't work either:
> +    #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
> +    #
> +    # As it doesn't properly match the end parenthesis on some cases.
> +    #
> +    # So, a better solution was crafted: there's now a NestedMatch
> +    # class that ensures that delimiters after a search are properly
> +    # matched. So, the implementation to drop STRUCT_GROUP() will be
> +    # handled in separate.
> +    #
> +    (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
> +    (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
> +    (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
> +    (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
> +    #
> +    # Replace macros
> +    #
> +    # TODO: use NestedMatch for FOO($1, $2, ...) matches

This comment is actually related to patch 03/12: regex cleanups:

If you want to simplify a lot the regular expressions here, the best
is to take a look at the NestedMatch class and improve it. There are lots
of regular expressions here that are very complex because they try
to ensure that something like these:

	1. function(<arg1>)
	2. function(<arg1>, <arg2>,<arg3>,...)

are properly parsed[1], but if we turn it into something that handle (2) as 
well, we could use it like:

	match = NestedMatch.search("function", string)
	# or, alternatively:
	# match = NestedMatch.search("function($1, $2, $3)", string)

	if match:
		arg1 = match.group(1)
		arg2 = match.group(2)
		arg3 = match.group(3)

or even do more complex changes like:

	NestedMatch.sub("foo($1, $2)", "new_name($2)", string)

A class implementing that will help to transform all sorts of functions
and simplify the more complex regexes on kernel-doc. Doing that will
very likely simplify a lot the struct_prefixes, replacing it by something
a lot more easier to understand:

	# Nice and simpler set of replacement rules
	struct_nested_matches = [
		("__aligned", ""),
		("__counted_by", ""),
		("__counted_by_(be|le)", ""),
	...
		# Picked those from stddef.h macro replacement rules
		("struct_group(NAME, MEMBERS...)", "__struct_group(, NAME, , MEMBERS)"),
		("struct_group(TAG, NAME, ATTRS, MEMBERS...)",
		 """	__struct_group(TAG, NAME, ATTRS, MEMBERS...)
		        union {
		                struct { MEMBERS } ATTRS;
		                struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME;
		        } ATTRS"""),
	...
	]

	members = trim_private_members(members)
	for from, to in struct_nested_matches:
              members = NestedMatch.sub(from, to, members)
		
Granted, wiring this up takes some time and lots of testing - we should
likely have some unit tests to catch issues there - but IMO it is
worth the effort.

-

[1] NestedMatch() is currently limited to match function(<args>), as it was
    written to replace really complex regular expressions with 
    recursive patterns and atomic grouping, that were used only to
    capture macro calls for: 

	STRUCT_GROUP(...)

   I might have used instead "import regex", but I didn't want to add the
   extra dependency of a non-standard Python library at the Kernel build.

Thanks,
Mauro

