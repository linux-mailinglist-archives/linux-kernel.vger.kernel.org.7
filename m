Return-Path: <linux-kernel+bounces-752942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D6B17CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEF91C2567D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431F1F3BAC;
	Fri,  1 Aug 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIYQ78y8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7B2E36EA;
	Fri,  1 Aug 2025 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028615; cv=none; b=QuM18g0ofdIcbK0Algu5KxqD0bnz0FebARA4zBF5h1douFfWqvMjhHkL82M0krsJN/tvlCkIGRZFjimX1iIA/tT4kB2FSd4t0/y0kJ4VcQjbDmpGDqYUVHL/gSbFqp7QVZjOOXqJdtsg46UPSxZf5axekpRWYbr8moK0xM4xLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028615; c=relaxed/simple;
	bh=CHhA//WK4DHzPYG5OpmIghiaCWDye+1yuEo1jGi9+dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLLWcrDjmv9MWB0vsleAvShdrSgiv73I9ar+FDaXrZwKcJYVNwO2q6B/yOzYbrv8m+nrZ1/7Q0/Z/9L48mS7yax9oQ1p+oMtfprt5FKVboYRjzQRVEDeUBvUcYHRzsmVmuB5ifhBbuJMOhn+7y83hbYuGFQtg249N9oFgpxcz2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIYQ78y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2CBC4CEE7;
	Fri,  1 Aug 2025 06:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754028615;
	bh=CHhA//WK4DHzPYG5OpmIghiaCWDye+1yuEo1jGi9+dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZIYQ78y8Hn8rWSoHDUmBF2kfQ/qzWyQ8hAvpEG131FzbC/6HGwsmw52q8PvrCPsDi
	 2HbUDv2hxE8juu/wFOZ6Or3kLS37n8bb2ntMZB2BA55fTZg/X3P62hKGYKPCH2ZrvM
	 FJP2ndAkQpfgno1BPD44rnCtvgtVRNYnuoCgmAESfKrBoY3/rvvFzITvvDJ2UaRMRI
	 osZrAckJdAfAAQWHNnA63u3iIcLTi2y/b9s4dcPk52XpuSQzwuJshB6TrxIB/A+kDK
	 QclFf3yYh/TokC8vKC4UaEUsqKecnZEfaZ8E8mboW6+nLcksA0lPv0JDE9GiTDHdAP
	 z3qRXnwfzj1aw==
Date: Fri, 1 Aug 2025 08:10:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: a few final dump_struct() touches
Message-ID: <20250801081011.41975240@foz.lan>
In-Reply-To: <20250801001326.924276-13-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-13-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:26 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Add a couple more comments so that each phase of the process is
> now clearly marked.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 131956d89f84..fa2041276f8c 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -801,14 +801,15 @@ class KernelDoc:
>          nested = NestedMatch()
>          for search, sub in struct_nested_prefixes:
>              members = nested.sub(search, sub, members)
> -
> -        # Keeps the original declaration as-is
> +        #
> +        # Deal with embedded struct and union members, and drop enums entirely.
> +        #
>          declaration = members
>          members = self.rewrite_struct_members(members)
> -
> -        # Ignore other nested elements, like enums
>          members = re.sub(r'(\{[^\{\}]*\})', '', members)
> -
> +        #
> +        # Output the result and we are done.
> +        #
>          self.create_parameter_list(ln, decl_type, members, ';',
>                                     declaration_name)
>          self.check_sections(ln, declaration_name, decl_type)



Thanks,
Mauro

