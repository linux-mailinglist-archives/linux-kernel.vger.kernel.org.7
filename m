Return-Path: <linux-kernel+bounces-877200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6ECC1D6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8295918934C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E5319619;
	Wed, 29 Oct 2025 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="l4LgjgNs"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E93195FC;
	Wed, 29 Oct 2025 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773054; cv=none; b=RgMbyQKXI7+FaJENs/VohJCV2IApaKz4ZhwlXaLiW8zO59lfeq5GkjxjfyrvD7/AmP0hr07BTC76Bm3hExWU75q+FHHZvU7qbKD3mCXWlemHnTsPoDAxHFiHTsdHdFB5DgF/CQNGpUqnIQwaAPjoammeYO8M5/ZOET36jdpfIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773054; c=relaxed/simple;
	bh=AoWJkaeuPELhOLcErmA+AIqNOI83/H7VbD7V4mPgde8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MNRJRymx3zrmZO2XTiqBxaXJyNWrilCyTsz3QkKJ/p2LR0GnqWrKIWUFRDEwN4iYFYd8awaOrZyBjxaRetiDwmMzJ1Fz5kjahVTfmA5xHuz/YIXAqX+tvC9Rdv0WurfT/Iab+/kkyEJQmO9jiux91ilp3oTGMCaKGcNI9e5ea1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=l4LgjgNs; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FERmsB+tS9xO1ykNi67NXdFvsLGuPfJXUcOk6M+xjwo=;
  b=l4LgjgNse9C2yymulJpUXI76EyG66UuPXFBWOd3zZQdypaNsyrbIdf6u
   ITfTyetuwWDSwJP7lXikmkY1J+y/zibBw2JQBymcw3C+fsFvfs18EONMZ
   wgdUd8p8PpnLJUX/nZunXR1usZMA48/eIo7vN+rvpymSPO2ORnQJVtdIy
   U=;
X-CSE-ConnectionGUID: 3nQfdhFETqCNj1Uo4OorKw==
X-CSE-MsgGUID: 3JezrcibS/2QdtaevInyXQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,265,1754949600"; 
   d="scan'208";a="246753524"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 22:24:01 +0100
Date: Wed, 29 Oct 2025 22:24:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
In-Reply-To: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
Message-ID: <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-899333787-1761773041=:4032"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-899333787-1761773041=:4032
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 29 Oct 2025, Markus Elfring wrote:

> Hello,
>
> I got into the mood to try another simple source code transformation out which
> can be achieved also by the means of the semantic patch language.
>
> @replacement@
> expression object, size, source, target;
> @@
>  target =
> -         object;
>  memcpy(
> -       target
> +       object
>         , source,
>         size);
>
>
> Test result (according to the software combination “Coccinelle 1.3.0”):
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --max-width 100 --timeout 23 -j4 --chunksize 1 --no-loops -dir . …/Projekte/Coccinelle/janitor/use_memcpy_assignment.cocci > …/Projekte/Bau/Linux/scripts/Coccinelle/use_memcpy_assignment-no_loops-20251029.diff 2> …/Projekte/Bau/Linux/scripts/Coccinelle/use_memcpy_assignment-no_loops-errors-20251029.txt
> real    5m35,579s
> user    20m20,037s
> sys     0m14,467s
>
>
> It can be determined then from the generated diff file that mentioned
> implementation details can be transformed in 304 source files at the moment.
> Thus I became curious if it would be supported to adjust any places there
> according to (Linux) coding style preferences.

If you have a concern, you have to say what it is.  It doesn't seem it is
about the running time, so why do you include that information?

I should not have to repeat your experiment to figure out what you are
asking about.

julia
--8323329-899333787-1761773041=:4032--

