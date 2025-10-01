Return-Path: <linux-kernel+bounces-838903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59129BB064D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A858219460C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957832EC0A9;
	Wed,  1 Oct 2025 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MBpLJj+C"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5C256C9E;
	Wed,  1 Oct 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323371; cv=none; b=bZ9zBvins7Ec8ptPIFRWkFB2xWhomw4usN84cdaLsl8sNXoNfUH1UiSgpGfCecFgoveiSdUgRqHRZ+0ONbI/HLyucjAjaLr4n3wsd2HZM32n978dkSvHv5gnQAeJhVtIo6vS6UjIsm+h7RSXm7cCDGMydjF8XgDgbq8fiZJ7+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323371; c=relaxed/simple;
	bh=mOReZNqWwbU4a/wTjJDB0+lkjw0UmfuQ9GPr10g0YVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWFg1YniSaV9rZrRd+HPfxgh6/ohSNT0ylCQpvAXNE1Y9d4Fk2zzYhYKqXhu4xMT2D9VvD/m8LQemBKnyKHwruQzH1seB0/tsY4mT00mOvZt5TK/ze+ssIBWwJkiN3kM5hzhJzicvTZiKObojNDz/ZUemVczhdHzCS/15wx4+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MBpLJj+C; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6C70740B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1759323361; bh=EgZoynB3HntThhqa4R0c/Bog3MxF773jArVoHdMs/BM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MBpLJj+CZHD4g9j3eG4cW1cQFCB97uzVFLfjyAg0Zuo+OMmb9pfhp97mqmsjBNb3C
	 ZSsS9GO5Rsh8eqC/s3IJKtVHNJ16O+JlBEcJ5+H6FKmUNJihlFRvTv4Bj6/hpvAv/o
	 vfpuiUs/a1YXboMr0NdWuRRY5khpO25yJWU4p5zjEHcn5U0ZQj3nyJ+HAU1gr1QUY3
	 /oUAl5K2VbaRkNO+kqitUWDuQcHWJEVQ5DT5RZq6e4VNkWWoLQgssBVXhoJ53Kn+hJ
	 Ge7jSGAhRRPeInhXuAqyQXU9YZIuofgdbUs7PkyJntDyEJNuC/7IHQ66R/GpUdKEa/
	 e+z8tO1pd8s/A==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6C70740B1B;
	Wed,  1 Oct 2025 12:56:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] docs: Makefile: use PYTHONPYCACHEPREFIX
In-Reply-To: <65f341d516c329e2b57252176b188ae68f3bb6ca.1759135339.git.mchehab+huawei@kernel.org>
References: <cover.1759135339.git.mchehab+huawei@kernel.org>
 <65f341d516c329e2b57252176b188ae68f3bb6ca.1759135339.git.mchehab+huawei@kernel.org>
Date: Wed, 01 Oct 2025 06:55:57 -0600
Message-ID: <87a52avl0i.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Previous cleanup patches ended dropping it when sphinx-build-wrapper
> were added. Also, sphinx-pre-install can also generate caches.
>
> So, re-add it for both.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index f764604fa1ac..cf26d5332fb5 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -60,8 +60,10 @@ else # HAVE_SPHINX
>  
>  # Common documentation targets
>  htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
> -	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
> -	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
> +	$(Q)PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
> +		@$(srctree)/tools/docs/sphinx-pre-install --version-check
> +	+$(Q)PYTHONPYCACHEPREFIX="$(PYTHONPYCACHEPREFIX)" \
> +		$(PYTHON3) $(BUILD_WRAPPER) $@ \

This causes an immediate build fail for me:

  /bin/sh: line 1: @./tools/docs/sphinx-pre-install: No such file or directory
  make[2]: *** [Documentation/Makefile:63: htmldocs] Error 127
  make[1]: *** [Makefile:1808: htmldocs] Error 2
  make: *** [Makefile:248: __sub-make] Error 2

jon

