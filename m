Return-Path: <linux-kernel+bounces-765663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10709B23C39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCC72A691F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA12D738C;
	Tue, 12 Aug 2025 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXMdypx+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C91227B8E;
	Tue, 12 Aug 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755040785; cv=none; b=gFWWOwTv+JVc4mM6oeXciz8sSr0nDs55RDpfucFVMfE+89z5zkIJjZu7YVtbPdvCivZicmRNew0Hl6B5JkLfHvnjod2LDiZTbHzPh/R4RcbVpWYS+VPdEE86a2xR3hi3mRuhXpMLwY492hNMBsr/D1I6qWZ35oOmP/nkLfN9NS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755040785; c=relaxed/simple;
	bh=h+T6mfhxxUSUkqlZPKSs8b5pzQmeaeSGZvagtUfLfoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkSAh+Y5uxaqHCC/CzDhczB1HDTvr8Tmp4EoaO89Qr2C2XmoDYKwLGVkHNyQjHxoKVUdBQvM5ys7zQkRfWLPxhz73gcEMINh0siDE6vaO+Dr3X9GV7CCoXgMMTE41Z8IsfFF7HSf9Z5EIbxQJTRf+7OBklib72NPL3B/eUFuKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXMdypx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D98C4CEF0;
	Tue, 12 Aug 2025 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755040785;
	bh=h+T6mfhxxUSUkqlZPKSs8b5pzQmeaeSGZvagtUfLfoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DXMdypx+aOAU0XPRoUIKTHzCj8x+Yj1yCZvOdybm8Rw8iSOnpE0dGJ5IIdCpkQWBj
	 sKfPea4w4Pml3B55Zm5jv5gYHsjV80e8IsfKW+CVeYR/qx4cnAcAS84pzzPx5c0Xa9
	 XIRY1B2X02GwERZBXETg14jIcPmhGdpRkyG8nj3k3jnDXeVg4IcJQC1c0JsPU8Y29+
	 rSHgfmPQx2FTOlFLod7Yd88sW+nWuCDE+TgGFjv3eM56fcvjyX8/tQdlGTPBTc+jG5
	 I/pr9AjU8k7KNF18Ja42fHAygPdx37+Lj5fZ+KovJA+HR0Xs8D3DCSOsPS3xnj88y3
	 bM7w+7SZZxSUA==
Date: Wed, 13 Aug 2025 01:19:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 7/7] docs: kdoc: remove redundant comment stripping
Message-ID: <20250813011941.4ca1ee00@foz.lan>
In-Reply-To: <20250812195748.124402-8-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
	<20250812195748.124402-8-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:57:48 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> By the time stuff gets to create_parameter_list(), comments have long since
> been stripped out, so we do not need to do it again here.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index ceb38b59fb4c..900c028687cc 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -493,9 +493,6 @@ class KernelDoc:
>              args = arg_expr.sub(r"\1#", args)
>  
>          for arg in args.split(splitter):
> -            # Strip comments
> -            arg = KernRe(r'/\*.*\*/').sub('', arg)
> -
>              # Ignore argument attributes
>              arg = KernRe(r'\sPOS0?\s').sub(' ', arg)
>  

Didn't check, but yeah, there are some places already doing
it, so:

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Thanks,
Mauro

