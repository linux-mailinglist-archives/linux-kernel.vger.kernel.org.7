Return-Path: <linux-kernel+bounces-725016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E81AFF9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BB26404E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81CB284B2E;
	Thu, 10 Jul 2025 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2WdCwsA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE612857FF;
	Thu, 10 Jul 2025 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128761; cv=none; b=hnqPhViJneOFeaYiFLOAWDPecBnqjc7CnAamI3+AuelmbLvAHR75TpEuy35lq/jdTtvEf+uvQAMF7WwWNGdKUpUK6+lWa3SCjHjJd/XQw8qBReAfP7qaoRuxlk4ZIImfRbbpWJlPpPlKvmy8EXAenGftYGN5MgkF6LAVSaC172Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128761; c=relaxed/simple;
	bh=Z5Vp4C9qdlP1/68mqRBOkxcwj8Lw+vV1bMroVEOT2L0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwQYVUwrf0+BXJ//r20nzD6c/N7rja0XQjDdRb/FhVYSV66eYAWdu8QhTzidbtcy3IwOnLLgtqJJhQHQDzABqH7PsVWSO1IJdd81NdgG7H1XfN/eiOMA3s40CyPBeVAngoqWSN0UEc4eP+CiDAvtubHsM8NJugCdoy8uYaAGaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2WdCwsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A85C4CEE3;
	Thu, 10 Jul 2025 06:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752128760;
	bh=Z5Vp4C9qdlP1/68mqRBOkxcwj8Lw+vV1bMroVEOT2L0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m2WdCwsAtcQmKKROHTism3V4GaMP1/o6N2TK1grSJCSBXGN2mOvpSmu8GeY20BK9f
	 JBSQhI3U+pGrpCMr2l6CRSYPgNDzKvkNrhfdpOyLtG0EPwtfu8j6taXR0gsRISCULx
	 98lVn+bgwgzJf5KLYnp+XSmtYQKDII89kQpQXDkyBe4mJCkZVYervQ3ZhKYk37Bgwi
	 YLLXHjFsrZ7gdHLxDhU3B6VJyx+5AtZBHWTdOcer36d8u0yI51Co820KyRoNg6WiII
	 Bfr9IQDrrnYg31gu1oy3Zp/ZXpimoik4DyYyEPMnEQfuG1Pj8gz9C6GKu8xV9fKuvM
	 h7Q2w2xqoz9xA==
Date: Thu, 10 Jul 2025 08:25:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 09/12] docs: kdoc: straighten up dump_declaration()
Message-ID: <20250710082556.35a909b2@foz.lan>
In-Reply-To: <20250702223524.231794-10-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-10-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:21 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Get rid of the excess "return" statements in dump_declaration(), along with
> a line of never-executed dead code.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 6e35e508608b..7191fa94e17a 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -878,18 +878,13 @@ class KernelDoc:
>  
>          if self.entry.decl_type == "enum":
>              self.dump_enum(ln, prototype)
> -            return
> -
> -        if self.entry.decl_type == "typedef":
> +        elif self.entry.decl_type == "typedef":
>              self.dump_typedef(ln, prototype)
> -            return
> -
> -        if self.entry.decl_type in ["union", "struct"]:
> +        elif self.entry.decl_type in ["union", "struct"]:
>              self.dump_struct(ln, prototype)
> -            return
> -

The above LGTM.

> -        self.output_declaration(self.entry.decl_type, prototype,
> -                                entry=self.entry)
> +        else:
> +            # This would be a bug
> +            self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')

Hmm... Are you sure about that? If I'm not mistaken, this was used for
other types of arguments, like DOC: tags.

>  
>      def dump_function(self, ln, prototype):
>          """

Thanks,
Mauro

