Return-Path: <linux-kernel+bounces-765655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B00B23C02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06837B56C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D6248865;
	Tue, 12 Aug 2025 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/5hIAbO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D612F0661;
	Tue, 12 Aug 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755038880; cv=none; b=gcmyBjFhoNTBFvA49Pc4zheayhEzLooDz+mSRD++zXIMWgGQXwvhPCp7Msk8LsxffjDTkmJ8d0txa7JfN7RuBhElLi0w7PH3v0OHuYz/QO4pnp96tid5U4V2zV155597l1UI56IATpbz6yfoytGX/MW1TFnYiDiNaJlJ04lrUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755038880; c=relaxed/simple;
	bh=CPxvjrAngKzWu4ybSQtg6CUOZTomliO4Y/sBb1xAkuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alMWP/LlHAFSeQb48k+/p6fhzJ2CARWdX477B6t2OSblByqyswJOC3SuIcLuAJO7S+aSTg0ph/NYhnu5KsMkX67K9aRwBBb5QsQVPiS8iNfnuzaoXIx0QyK58TfjAdC9H/3CU2BRkXt0mN++LmuD0ktwaKhvWyMV+6Bl+SS2/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/5hIAbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56312C4CEF0;
	Tue, 12 Aug 2025 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755038880;
	bh=CPxvjrAngKzWu4ybSQtg6CUOZTomliO4Y/sBb1xAkuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/5hIAbOVNLAGO4jzOC9CKs98KAh0E1pyZQhzx1PbWSm1rXPTn4U8irDE+rxDfLVP
	 zz6tWW5KeMmpjcHs2i7+4jFGmTq0RoChiZN8z+zt/k5mK9BLp6A0et3AoD0OmQhLhe
	 6pKAEiBHN53L+F9tSnP8Z+h3ZmMGCu/5LX/OAadhM3AjzuZMwE7Q25kVP0scYXfTOA
	 fzcISDVGdLFrgav+fgXIE4MYdit0dgWoWFgt6omsfFoTxrQWg9H+nfemXGfjUlT60x
	 7xpB0d4cAAv6/w4YlgJfN4gjU1Tal+LU3vXK0FypaIPdn8PRXhAhZwykWFekD8TY4d
	 2A+Qw38OQ8l4Q==
Date: Wed, 13 Aug 2025 00:47:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 4/7] docs: kdoc: add a couple more comments in
 create_parameter_list()
Message-ID: <20250813004756.044a8695@foz.lan>
In-Reply-To: <20250812195748.124402-5-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
	<20250812195748.124402-5-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:57:45 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Make what the final code is doing a bit more clear to slow readers like me.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 47f7ea01ed10..36c4035343dc 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -568,12 +568,18 @@ class KernelDoc:
>  
>                  bitfield_re = KernRe(r'(.*?):(\w+)')
>                  for param in args:
> +                    #
> +                    # For pointers, shift the star(s) from the variable name to the
> +                    # type declaration.
> +                    #
>                      r = KernRe(r'^(\*+)\s*(.*)')
>                      if r.match(param):
>                          self.push_parameter(ln, decl_type, r.group(2),
>                                              f"{dtype} {r.group(1)}",
>                                              arg, declaration_name)
> -
> +                    #
> +                    # Perform a similar shift for bitfields.
> +                    #
>                      elif bitfield_re.search(param):
>                          if dtype != "":  # Skip unnamed bit-fields
>                              self.push_parameter(ln, decl_type, bitfield_re.group(1),



Thanks,
Mauro

