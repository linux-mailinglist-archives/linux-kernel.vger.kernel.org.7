Return-Path: <linux-kernel+bounces-765654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B50DB23BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A6244E1DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A042D836A;
	Tue, 12 Aug 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7uzg9U+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3BD208CA;
	Tue, 12 Aug 2025 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755038687; cv=none; b=bF9HPNd35iaEgOSqrR0tbgmxm/2zGH/Dbl5D4zAxkO445UbUfrq0Gw4EBk9eO7RUjYHVwkVPFBZIyUCMlcOOju6nc6uGuHnRzHMJ5yGuoBm3Vy9v0PQgfCla+JdA3TBDzHfqxQsetAvMT463nJKz/6AI9poWixGu+VnPCzo/628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755038687; c=relaxed/simple;
	bh=qxkQX4tnWctFHCYqy1N30P3Q8HXxL4m7FQX1HHKLiQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bs+Dmu6qWZNa/ijPuWMIhdSQeUz5mRVAl9kr6AkzsCGV+/JYcibMmcSfN93wtRIEcMw7Q/1p9ulmlnQDlp3AIOD4yqrP3GOATnYCwq21VnDfdaxIIBkSctsbaWr9TdmZR8HSRTKSUNGUpKQD6kVTctuVVeALopcxfgqsR7QXoIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7uzg9U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84D0C4CEF0;
	Tue, 12 Aug 2025 22:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755038686;
	bh=qxkQX4tnWctFHCYqy1N30P3Q8HXxL4m7FQX1HHKLiQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7uzg9U+SDpaP8dxgA5xdHaXC+FtsOIbEagEav4MFUMu52fzBEyWz+g6WYYfGmIBq
	 yNTMltXb51n9KfGl6hE6i2IMNN0fYY+XW0MbSiLyzo2ZGyyOX/xYtZoHQ5KOkqGwU/
	 TjYDiV3+F9YyDFfy4AnacRsa83I9vqPntP6efXkL+Zr+Xi2QpYjwCrHemhrG1jIYNk
	 wSE2y+/MFwpyqB4ODlMp7m4RD+TTI8X5ziLe+auuwVWc0fYlbvotiU8xyJFGAyxqA6
	 jkTCwBBAoJrfggTBXlm6yyDP0BfO4+Rp5eurOEarPh4wDTUmW61n8qiFkztMc1KtQW
	 9bjFpXLAoB4lw==
Date: Wed, 13 Aug 2025 00:44:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 2/7] docs: kdoc: tidy up space removal in
 create_parameter_list()
Message-ID: <20250813004442.09303adf@foz.lan>
In-Reply-To: <20250812195748.124402-3-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
	<20250812195748.124402-3-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:57:43 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Remove a redundant test and add a comment describing what the space removal
> is doing.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

LGTM.
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 96e3fe4ec431..53051ce831ba 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -545,12 +545,14 @@ class KernelDoc:
>                                      arg, declaration_name)
>  
>              elif arg:
> +                #
> +                # Clean up extraneous spaces and split the string at commas; the first
> +                # element of the resulting list will also include the type information.
> +                #
>                  arg = KernRe(r'\s*:\s*').sub(":", arg)
>                  arg = KernRe(r'\s*\[').sub('[', arg)
> -
>                  args = KernRe(r'\s*,\s*').split(arg)
> -                if args[0] and '*' in args[0]:
> -                    args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
> +                args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
>  
>                  first_arg = []
>                  r = KernRe(r'^(.*\s+)(.*?\[.*\].*)$')



Thanks,
Mauro

