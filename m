Return-Path: <linux-kernel+bounces-752923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E21CB17C68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DA71C26377
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3880B1EEA47;
	Fri,  1 Aug 2025 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzQOwMLb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F5AD4B;
	Fri,  1 Aug 2025 05:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754026667; cv=none; b=Knc/godASmwHD3Gmw+EveBQ0HybBdiJxIoBKTt00qf6NZ+cKUcxD5HKlaHFzTuNC2kvGoHMSs4G+gRU9TeXkhtMuo6Ikp6tGYaCkyM1xuV/49K1USt0kUtgLpDbxPA/lQQXhBWKpaE7B+vvbSCsGn5RggQaczhAGZQAXOc52/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754026667; c=relaxed/simple;
	bh=nW/zdH8XcEwK4reU7s2ZPN+4jHfYO7vQdvwINpg+QN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaPPNG+Krmr3svgdUkvqOaCcU/iKzmHLEiAt/WTeEDKpTC+IAIl10dILtrSwH/nuiWcf10Mn9vzlZshpil0ak1EaSSq6C2FVvr92sXoAb862MmJ+Fk0u4UUoDJr88SZBxYYxStWwbPop6XeqfgBF0rC6WiRk/424NjN0Dr+PfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzQOwMLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F74C4CEE7;
	Fri,  1 Aug 2025 05:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754026667;
	bh=nW/zdH8XcEwK4reU7s2ZPN+4jHfYO7vQdvwINpg+QN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qzQOwMLb+JRMzRxTv1FjJTQkXe1QBeAvViaWmv7qcZ3ibvATjdYpVs8R4S8Z0zY3u
	 Ecy3A4vCsB/DEvReZ1A4xE0xdXyCL4WF+X6Bnb4pIIsSJCPeJPz0oMpeh36uoZNU55
	 BadQH3evWzK0jVlIy2zEnBhrXh7RsWn+GSCtn3IIv0eoc1IcgQzPF2GhPMdgJo2/3z
	 dGXeJ0XSxUrT72OLaJWpcPqZtb1GYd1HL+s3c1uUQr9K5IQAgWWV9Dk1/+3KArGsCW
	 jni+qqXYaCv8yFBJivwOKICdLWTa4bEaefVunNKnzYYmWF9BeIahdv5Ec4755i8Vpw
	 fKpjCn1DqxyHQ==
Date: Fri, 1 Aug 2025 07:37:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 06/12] docs: kdoc: split struct-member rewriting out of
 dump_struct()
Message-ID: <20250801073743.06c2e823@foz.lan>
In-Reply-To: <20250801001326.924276-7-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-7-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:20 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> The massive loop that massages struct members shares no data with the rest
> of dump_struct(); split it out into its own function.  Code movement only,
> no other changes.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 65 +++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 2bb0da22048f..5c4ad8febb9f 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -647,37 +647,7 @@ class KernelDoc:
>                  return (r.group(1), r.group(3), r.group(2))
>          return None
>  
> -    def dump_struct(self, ln, proto):
> -        """
> -        Store an entry for an struct or union
> -        """
> -        #
> -        # Do the basic parse to get the pieces of the declaration.
> -        #
> -        struct_parts = self.split_struct_proto(proto)
> -        if not struct_parts:
> -            self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
> -            return
> -        decl_type, declaration_name, members = struct_parts
> -
> -        if self.entry.identifier != declaration_name:
> -            self.emit_msg(ln, f"expecting prototype for {decl_type} {self.entry.identifier}. "
> -                          f"Prototype was for {decl_type} {declaration_name} instead\n")
> -            return
> -        #
> -        # Go through the list of members applying all of our transformations.
> -        #
> -        members = trim_private_members(members)
> -        for search, sub in struct_prefixes:
> -            members = search.sub(sub, members)
> -
> -        nested = NestedMatch()
> -        for search, sub in struct_nested_prefixes:
> -            members = nested.sub(search, sub, members)
> -
> -        # Keeps the original declaration as-is
> -        declaration = members
> -
> +    def rewrite_struct_members(self, members):
>          # Split nested struct/union elements
>          #
>          # This loop was simpler at the original kernel-doc perl version, as
> @@ -768,6 +738,39 @@ class KernelDoc:
>                                      newmember += f"{dtype} {s_id}.{name}; "
>  
>                  members = members.replace(oldmember, newmember)
> +        return members
> +
> +    def dump_struct(self, ln, proto):
> +        """
> +        Store an entry for an struct or union
> +        """
> +        #
> +        # Do the basic parse to get the pieces of the declaration.
> +        #
> +        struct_parts = self.split_struct_proto(proto)
> +        if not struct_parts:
> +            self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
> +            return
> +        decl_type, declaration_name, members = struct_parts
> +
> +        if self.entry.identifier != declaration_name:
> +            self.emit_msg(ln, f"expecting prototype for {decl_type} {self.entry.identifier}. "
> +                          f"Prototype was for {decl_type} {declaration_name} instead\n")
> +            return
> +        #
> +        # Go through the list of members applying all of our transformations.
> +        #
> +        members = trim_private_members(members)
> +        for search, sub in struct_prefixes:
> +            members = search.sub(sub, members)
> +
> +        nested = NestedMatch()
> +        for search, sub in struct_nested_prefixes:
> +            members = nested.sub(search, sub, members)
> +
> +        # Keeps the original declaration as-is
> +        declaration = members
> +        members = self.rewrite_struct_members(members)
>  
>          # Ignore other nested elements, like enums
>          members = re.sub(r'(\{[^\{\}]*\})', '', members)



Thanks,
Mauro

