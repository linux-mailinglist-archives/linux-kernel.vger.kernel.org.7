Return-Path: <linux-kernel+bounces-752920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFEB17C61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C8B5A5E6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B2B1EE01A;
	Fri,  1 Aug 2025 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdBX9SQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF3AD4B;
	Fri,  1 Aug 2025 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754026455; cv=none; b=uEDIRLZeulz28IAk6FFbHh996O6Q6Faeh7I2OFbzAGaEEg/BflLcBWuWUNwD5NyZiYasH+so13Y8MyMzSHhbaB68H+Pyvw7Knxun4jFXlHrn9pEdywRPH1/B0Zz/QLb0zZHz0XoPIe8hlGjibDnpFkHnpdcwW/TBv2YPN1k8dn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754026455; c=relaxed/simple;
	bh=u5FT6FvuhCwhQmyOUWQFRQhysRDka5Olb2IyHzYnlmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxv5yoRPm9PqXPWbNdL07bWcirD0EGjgmRixys++svpJJrMU7yCQYWmoNcx3+iViFSlTW5b4gL8mJgKypTj4lNYe1kAHITJYFenq49DcVCebAykI1h0lVvzTCoBBfL7ZZBIAdJXgTT9K1JPU9hJewTjQMysfcrpFPrMy3RoWs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdBX9SQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADF3C4CEEB;
	Fri,  1 Aug 2025 05:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754026455;
	bh=u5FT6FvuhCwhQmyOUWQFRQhysRDka5Olb2IyHzYnlmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JdBX9SQaLdEJEJQuJR769XUsaQZoM0tlXuHTfkxIo+7kyQ8UGoW3si8qwdzLLRdIm
	 hwJBbK4aG1uGYmRQ7Sifs14SazTTsTKpIWoTkp4Jvhc6FPNLEtLshc9YyuqjpubeOp
	 pndB6Y76G2qLD4/J/GG167t0ksQBot9qXPKzD2v7FlAvprCX6xl+rnXp2G/77S6Z67
	 W77szaOaqaWOj9IxBDQMye6krcBiQAEdOvoYynVKN3b+k7S3auzla2ngkgUCh4v33k
	 nOBgMshlDwpKFlLN7LUO0WH5LlhTIZKzxceWl6eg9+q+bbOhJ/pBqEiTR9OCkZ2Tov
	 Y31RFsScwqxxg==
Date: Fri, 1 Aug 2025 07:34:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 05/12] docs: kdoc: split top-level prototype parsing out
 of dump_struct()
Message-ID: <20250801073411.06cb530e@foz.lan>
In-Reply-To: <20250801001326.924276-6-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-6-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:19 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Move the initial split of the prototype into its own function in the
> ongoing effort to cut dump_struct() down to size.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 44 +++++++++++++++------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 5e375318df9c..2bb0da22048f 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -624,13 +624,11 @@ class KernelDoc:
>              self.emit_msg(ln,
>                            f"No description found for return value of '{declaration_name}'")
>  
> -    def dump_struct(self, ln, proto):
> -        """
> -        Store an entry for an struct or union
> -        """
> -
> +    #
> +    # Split apart a structure prototype; returns (struct|union, name, members) or None
> +    #
> +    def split_struct_proto(self, proto):
>          type_pattern = r'(struct|union)'
> -
>          qualifiers = [
>              "__attribute__",
>              "__packed",
> @@ -638,36 +636,34 @@ class KernelDoc:
>              "____cacheline_aligned_in_smp",
>              "____cacheline_aligned",
>          ]
> -
>          definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
>  
> -        # Extract struct/union definition
> -        members = None
> -        declaration_name = None
> -        decl_type = None
> -
>          r = KernRe(type_pattern + r'\s+(\w+)\s*' + definition_body)
>          if r.search(proto):
> -            decl_type = r.group(1)
> -            declaration_name = r.group(2)
> -            members = r.group(3)
> +            return (r.group(1), r.group(2), r.group(3))
>          else:
>              r = KernRe(r'typedef\s+' + type_pattern + r'\s*' + definition_body + r'\s*(\w+)\s*;')
> -
>              if r.search(proto):
> -                decl_type = r.group(1)
> -                declaration_name = r.group(3)
> -                members = r.group(2)
> +                return (r.group(1), r.group(3), r.group(2))
> +        return None
>  
> -        if not members:
> +    def dump_struct(self, ln, proto):
> +        """
> +        Store an entry for an struct or union
> +        """
> +        #
> +        # Do the basic parse to get the pieces of the declaration.
> +        #
> +        struct_parts = self.split_struct_proto(proto)
> +        if not struct_parts:
>              self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
>              return
> +        decl_type, declaration_name, members = struct_parts
>  
>          if self.entry.identifier != declaration_name:
> -            self.emit_msg(ln,
> -                          f"expecting prototype for {decl_type} {self.entry.identifier}. Prototype was for {decl_type} {declaration_name} instead\n")
> +            self.emit_msg(ln, f"expecting prototype for {decl_type} {self.entry.identifier}. "
> +                          f"Prototype was for {decl_type} {declaration_name} instead\n")
>              return
> -
>          #
>          # Go through the list of members applying all of our transformations.
>          #
> @@ -696,7 +692,7 @@ class KernelDoc:
>          # So, we need to have an extra loop on Python to override such
>          # re limitation.
>  
> -        struct_members = KernRe(type_pattern + r'([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
> +        struct_members = KernRe(r'(struct|union)([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')

I would prefer keeping type_pattern here. 

With that:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


>          while True:
>              tuples = struct_members.findall(members)
>              if not tuples:



Thanks,
Mauro

