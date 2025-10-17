Return-Path: <linux-kernel+bounces-857855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05441BE813D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAEC19A787C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD06221D00A;
	Fri, 17 Oct 2025 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ADsVBid6"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B123346A6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697175; cv=none; b=DzhWLKB4BA3v9e96XT6m3AowS3nIa16aKVazXYg7WNVLwkaGHsZJiOquLH2eDUY0Ovk0BcP4DJPCS4GR1Stz3OUPbR8Jz6ZwXCzcFd8E2d9D6ciTaocHLhnXEF6Kqm1ubc4ub9Xt5Z0bblIreMdy7qVUo+zSg7BgnDtqWtFJ+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697175; c=relaxed/simple;
	bh=gI+lsI99W3VGPpT5/jzydPZ0hzvGQAzZgNUidtfC/ug=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T3vUbmDfooxIsv/n6cUAoJKFjPqWctYsADAFnAnGaUNsgnLfb1tW9wdNdeX5q94f/jcz23uy8JMRDn5xWU/oxlg+wzT4rYhcKsM/aF578O1I90UoEvK8xhi6dBv0sR3+RRYhV5P3IOuD4gviLm8wX+yPdVVFpLHn1Pdpi+Lfu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ADsVBid6; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wj+WCRcYc5nfyqI/50vIC5NGiZlcs4drP/9wRD28+Yw=;
  b=ADsVBid6B80mQ9HaRrHY35ByFAMAF2ifC821wGU9nkR0o6WhQeN6BeZU
   sbrCno0MZlyz9sHTwOB2HMEPioyNQsqF6hzgYnnAAiz2NP3fOe9c01EFt
   CmQ5u+IZQcSLIn9DEp55lTB6ShuzWggC9eI8CACTGf9//B3CG638jAQ3a
   A=;
X-CSE-ConnectionGUID: feMLIk4kTgiffT72J1gSHw==
X-CSE-MsgGUID: O3Me8zbdRKeVb0rGoo63Ww==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,236,1754949600"; 
   d="scan'208";a="128488925"
Received: from bb116-15-226-202.singnet.com.sg (HELO hadrien) ([116.15.226.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 12:32:42 +0200
Date: Fri, 17 Oct 2025 18:32:35 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Coccinelle: pm_runtime: Fix typo in report
 message
In-Reply-To: <20251017103032.75686-2-thorsten.blum@linux.dev>
Message-ID: <ec9e6ef-d047-d084-1e29-514246869336@inria.fr>
References: <20251017103032.75686-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 17 Oct 2025, Thorsten Blum wrote:

> s/Unecessary/Unnecessary/
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>

> ---
>  scripts/coccinelle/api/pm_runtime.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
> index 2c931e748dda..e29ac3a87d96 100644
> --- a/scripts/coccinelle/api/pm_runtime.cocci
> +++ b/scripts/coccinelle/api/pm_runtime.cocci
> @@ -110,5 +110,5 @@ p2 << r.p2;
>  pm_runtime_api << r.pm_runtime_api;
>  @@
>
> -msg = "%s returns < 0 as error. Unecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
> +msg = "%s returns < 0 as error. Unnecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
>  coccilib.report.print_report(p1[0],msg)
> --
> 2.51.0
>
>

