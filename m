Return-Path: <linux-kernel+bounces-752924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D62B17C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C07C582C44
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3481EF09B;
	Fri,  1 Aug 2025 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJFuMhU5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BFAD4B;
	Fri,  1 Aug 2025 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754026959; cv=none; b=J0kR5TuczbXlsXa9YRr3X3j1O3pYybjw8Q37EhccUDmd5AffcRyavd9ELgHE7G5gmdw7PzaDcgz51O414Fw0y5HHMPc7sEQEsyj7lfMVN2iMy4Kf+v6XvOT502s3FoUsxjI+PeU/0lOutX9z11dt9qUW7KJf3FywlCtcfc/RrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754026959; c=relaxed/simple;
	bh=6vZPk7aK5fxpzhVEUWzyl6LmTBkKI6hZYhlqWmFU0Os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDSs8PGNZaAXUewTtsxwUqEvlRUOHO3vIbEI9Buy3Hsc4M1yyHtbluYY4Rfl6rev6ny+5VOZWrYbG78/EIG31DGhrizNSw7wkCMbR3m/LjQ080WbgK0LEdoaY4H0B8dovpY8eWRa+4DZGBBAwgClNvoc3XXj+3O8EuWFF0z7IAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJFuMhU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8E9C4CEE7;
	Fri,  1 Aug 2025 05:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754026957;
	bh=6vZPk7aK5fxpzhVEUWzyl6LmTBkKI6hZYhlqWmFU0Os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lJFuMhU5GcFiOpK7T8kG9AJgWimMG4zNnJ09fHXS/yV5ziVZaBUw8j8Vouo2XzjXN
	 aRBJVTO1yiwTpO2tKdShE0UqW3cTzzEwKbBShWvyavbTkDTF1+/h2XWX/TH2eX+Iho
	 WqG2hB2nSwh3hf4moauEnxFYQnylOXHYMfL7O1TASuPvFYN/1m0xAnVbqynY/T8BUc
	 IlpAKP6iASrA+1Qq06xuePAg8Lb6xfdGUhKslp+9lW6x0XnMUsPbKRWAg69j2H46RA
	 O5trfdWySxlYBrE6cxZIpT/mzXOnz2CT+nRw/3o8n8Mkuv2+0NBt57SNgJtlWmuoK1
	 Wx/F86LDCtp8g==
Date: Fri, 1 Aug 2025 07:42:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 07/12] docs: kdoc: rework the rewrite_struct_members()
 main loop
Message-ID: <20250801074233.23e751d4@foz.lan>
In-Reply-To: <20250801001326.924276-8-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-8-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:21 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Adopt a more Pythonic form for the main loop of this function, getting rid
> of the "while True:" construction and making the actual loop invariant
> explicit.

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 5c4ad8febb9f..efc5888fcc74 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -663,11 +663,8 @@ class KernelDoc:
>          # re limitation.
>  
>          struct_members = KernRe(r'(struct|union)([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
> -        while True:
> -            tuples = struct_members.findall(members)
> -            if not tuples:
> -                break
> -
> +        tuples = struct_members.findall(members)
> +        while tuples:
>              for t in tuples:
>                  newmember = ""
>                  maintype = t[0]
> @@ -738,6 +735,7 @@ class KernelDoc:
>                                      newmember += f"{dtype} {s_id}.{name}; "
>  
>                  members = members.replace(oldmember, newmember)
> +            tuples = struct_members.findall(members)
>          return members
>  
>      def dump_struct(self, ln, proto):



Thanks,
Mauro

