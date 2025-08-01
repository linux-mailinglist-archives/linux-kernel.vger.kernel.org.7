Return-Path: <linux-kernel+bounces-752926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5C9B17C96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919DB582C62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F431F099C;
	Fri,  1 Aug 2025 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkFSdYB0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC0D2FF;
	Fri,  1 Aug 2025 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027117; cv=none; b=NJLXz5ffLTgCQleAiiGHeWQno0I1wd/H89MXPAPRnvcxlmNu7rpo4aLoNHGXzH4WFBIpXpOU/ugWkGxLZ/ZkEroU7WXVjqS3qcLiwNVzI4GobU+FwAdCselJRWeyYfSPjfmeGd8gM5b9zrahAeI0VqNs1aHMIvGdquue/tpqB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027117; c=relaxed/simple;
	bh=rENd7JnJ1EZcdheKbpVBN8F6veTrN+SHAAfm5FsJATU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogrnilfOk2++zDPTnaAVJCzzOJRYcaePWQEKoKaeB0cBVtd3G4DPTIk+31f+Fq7ie5to35bBfltYp54ovgKssmpZeScuuSeQz5iGxTpnw2q7oWItMnsqGvlNE7hfvCoieDerl/x+6gxQDn9vqVPFw58Rmqg9zchLE0iMdn/NTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkFSdYB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0764C4CEE7;
	Fri,  1 Aug 2025 05:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754027116;
	bh=rENd7JnJ1EZcdheKbpVBN8F6veTrN+SHAAfm5FsJATU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GkFSdYB09nSIp96PxGJjuI5p9cN/kBXkf7qBGcVzdzjTW2ohbqLH+OAsZdwsMMPct
	 DJvZQyJF6EW7/kOSQB+Od1bQH3VfHmLtV3uJq1YXstdPOuK4wVZABQmEl9MaF0DovE
	 1wGI6Z8BE4M7qYkBmmKqRr2XaU5NaK2b+lG7w0OIJlq8NL94+5O0H7Y5QmY3kZoYds
	 oRxUcwctYeSAyu0o9fJybuRDxpTfA8/wWanR5U/kdF4F5fuROiMG9mLmItaKwtqTFY
	 2d8zyhebZGWcUEIbIctm7wS0BtgGDRPaS3DMcTrh1x22HtpFkPTCL9ReY9GFTqcBjm
	 FLhKyR4Jsb52w==
Date: Fri, 1 Aug 2025 07:45:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 08/12] docs: kdoc: remove an extraneous strip() call
Message-ID: <20250801074513.5b10671d@foz.lan>
In-Reply-To: <20250801001326.924276-9-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-9-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:22 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> ...the variable in question was already strip()ed at the top of the loop.

Good catch. This was probably a left-over from some code changes.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index efc5888fcc74..b751fa8edde7 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -703,7 +703,6 @@ class KernelDoc:
>                                  newmember += f"{dtype}{s_id}.{name}{extra}; "
>  
>                          else:
> -                            arg = arg.strip()
>                              # Handle bitmaps
>                              arg = KernRe(r':\s*\d+\s*').sub('', arg)
>  



Thanks,
Mauro

