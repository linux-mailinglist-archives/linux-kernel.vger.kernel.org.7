Return-Path: <linux-kernel+bounces-899796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60FC5909B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44574540067
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0104D2FD668;
	Thu, 13 Nov 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sp9ltNr+"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F428725B;
	Thu, 13 Nov 2025 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050964; cv=none; b=KPg6ytXCgAwQuZmNzqb9y4nNx25Ml2bmuiTC4E/U80U9xCfBC71fXuZz5si2wBiylVwRttoGaAQZjHBOfYA5vr40yE/mcIQp3pN8sy8czXC+/usPPN7org2ucb9fSM2YmcK6pw19ZoaFBBQknx0jIPb4Yxt8D/1Mc1Jx52jNsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050964; c=relaxed/simple;
	bh=+eDEtAfsIZWqM55NCONZFNk+30J0WdRc4YvnH5eyqm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kw5FDgfk8aFfq0thvDzaBbBL3JYFptJUY1IUez2EVFc9+7SfoUpbJk/Kz4eqGWjiaQljoizyt+A348Ujgkh61tWE58rj/QPj3CyI8D4yGGmF16F+EYc1QK1o5XuYK0eKHLMRHTvonwequHCzSMByAYv+53hD2nm3373IprHEko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sp9ltNr+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2332D40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1763050962; bh=mdF9LbRSystwYcUv1PMVYl8XBSKgx8qgBf9HV+OWE8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sp9ltNr+t2+l0bhcklwC+BveThtzAuWgKZfIbvhU290Y8ntSlfACN2SiFd+4pvrdp
	 ERQAG3xKWMyQ7FJMHvSYrephhgd0fSRM6SR6pW7BUdPABD0bR7gxkicIB8n9AAadU9
	 1ZXYd5ftoboO6w4t2LZelPhoNlFYzwA6QitPpyyFZufm7XAlRpi8jztlduzjny7cD9
	 Tf/a8V/Wa2gpuT1E46SHm0EdnnC32KencsTjSU5KohVt6N8hEM4+r+nQPXtqBDFv6S
	 tynxJHtAgojnwrx3XcVP5P+DM7+uF54+xDY6TI1RuC4VWu3Euqsy+EEPfB8d9vTU8o
	 Fhpss8r9oeKCw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2332D40AFB;
	Thu, 13 Nov 2025 16:22:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jani Nikula
 <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Makefile: update SPHINXDIRS documentation
In-Reply-To: <683469813350214da122c258063dd71803ff700b.1763031632.git.mchehab+huawei@kernel.org>
References: <683469813350214da122c258063dd71803ff700b.1763031632.git.mchehab+huawei@kernel.org>
Date: Thu, 13 Nov 2025 09:22:41 -0700
Message-ID: <874iqxucku.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Since the beginning, SPHINXDIRS was meant to be used by any
> subdirectory inside Documentation/ that contains a file named
> index.rst on it. The typical usecase for SPHINXDIRS is help
> building subsystem-specific documentation, without needing to
> wait for the entire building (with can take 3 minutes with
> Sphinx 8.x and above, and a lot more with older versions).
>
> Yet, the documentation for such feature was written back in
> 2016, where almost all index.rst files were at the first
> level (Documentation/*/index.rst).
>
> Update the documentation to reflect the way it works.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d514ab6761dc..c66df29cf0a3 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -104,7 +104,9 @@ dochelp:
>  	@echo  '  cleandocs       - clean all generated files'
>  	@echo
>  	@echo  '  make SPHINXDIRS="s1 s2" [target] Generate only docs of folder s1, s2'
> -	@echo  '  valid values for SPHINXDIRS are: $(_SPHINXDIRS)'
> +	@echo  '  top level values for SPHINXDIRS are: $(_SPHINXDIRS)'
> +	@echo  '  you may also use a subdirectory like SPHINXDIRS=userspace-api/media,'
> +	@echo  '  provided that there is an index.rst file at the subdirectory.'
>  	@echo

Applied, thanks.

jon

