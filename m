Return-Path: <linux-kernel+bounces-728695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E0B02BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146303BAF09
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DFA289E0E;
	Sat, 12 Jul 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ikcPqpuE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C0283C93;
	Sat, 12 Jul 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752337955; cv=none; b=ta8BcWYIdgeVRpqnblf9qXhlsvTINMQMjGVabPxAiFr/WD5CrP6hD3tIqLDVrpJ3eBxnSVQEfFpv8TWno/tHOBSKkDaZt3TTPw2iD1g4DpssB8OBypuRRwl9+mAYfBBYOfo7Y8CSkA/U8tt7jYt/TB03svPPMhq7oRpvTJEiNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752337955; c=relaxed/simple;
	bh=bHZT+o+zslXuF3GIjfBilkmBnK1lcCmainWJp9sUfbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrBUxgsNfl1SkXtD456+LDL7iY3ZKLirr20ThN7iGtOAZZTJ7f9a/LcB1Ac9wsMqZ6Yykq8WTX1zQCdaf5uTROM9tUaGegrSxcgVdwf/tAZ7b2cLSP0WoEGAlAS7YALiaMFK1xAOn7o5DH0q1r88F2NlZwoYae1gSSIlO1HAszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ikcPqpuE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id B9EF01306;
	Sat, 12 Jul 2025 18:31:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1752337915;
	bh=bHZT+o+zslXuF3GIjfBilkmBnK1lcCmainWJp9sUfbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikcPqpuEkrVeOLNnbgykrCBNlo9aKgl6QtTRWfjiXXzJm6Mrr6wj8EDwiuElooZhe
	 Uu2aKRkxKBz44CGBnGCmAzSzJfkD2XqxMGEkuQIvZqnV8rdo1yb9Ga701quxDh1WOH
	 w5nA7kdCD6A1FxnyBCm88gkyxgvkDKWiSObiyqkU=
Date: Sat, 12 Jul 2025 19:31:55 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
Message-ID: <20250712163155.GA22640@pendragon.ideasonboard.com>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
 <58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>

Hi Mauro,

Thank you for the patch.

On Sat, Jul 12, 2025 at 10:32:38AM +0200, Mauro Carvalho Chehab wrote:
> Python is listed as an optional dependency, but this is not
> true, as kernel-doc is called during compilation when DRM is
> enabled. Better document that.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Isn't it only when CONFIG_DRM_HEADER_TEST is enabled ? That option
depends on EXPERT && BROKEN, so I wouldn't expect it to be widely
enabled. A quick grep shows that CONFIG_DRM_I915_WERROR does the same
(with a dependency on EXPERT but not BROKEN though).

Is there something else in DRM that invokes kernel-doc ?

> ---
>  Documentation/process/changes.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index bccfa19b45df..6a7d7c1ee274 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -61,7 +61,7 @@ Sphinx\ [#f1]_         3.4.3            sphinx-build --version
>  GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
>  mkimage (optional)     2017.01          mkimage --version
> -Python (optional)      3.9.x            python3 --version
> +Python                 3.9.x            python3 --version
>  GNU AWK (optional)     5.1.0            gawk --version
>  ====================== ===============  ========================================
>  
> @@ -154,6 +154,13 @@ Perl
>  You will need perl 5 and the following modules: ``Getopt::Long``,
>  ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
>  
> +Python
> +------
> +
> +At least Python 2.7 or 3.4 is required if CONFIG_DRM is selected to avoid
> +breaking compilation. Documentation build and kernel-doc won't produce
> +valid results if version is below 3.7.
> +
>  BC
>  --
>  

-- 
Regards,

Laurent Pinchart

