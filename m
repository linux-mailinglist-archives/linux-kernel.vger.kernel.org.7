Return-Path: <linux-kernel+bounces-655879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BD0ABDEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17151BA666E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9E25B676;
	Tue, 20 May 2025 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WJIBO6F4"
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26FF25A2D7
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754344; cv=none; b=WG4Kd+8kQnLjo9oGs217FFq/1jcTrG3Ne55Q4YMuvbtRL0aJZwWmXcUK4y28E67ZcYdHjZBug5HpnmJXe4iA97SkpoqeSjvrEOQhw1P1OJGyn9Ip7txR+S9R8Bt2JEvjPAVXdHlx4OzV9nawA01TitbK1qrdxUVdybUcaBh11/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754344; c=relaxed/simple;
	bh=70BAyOFeZfWM41kAHLRdIU92GSfnWFH99n9UrsgwNlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RirvANTOEiRD/lAjhiVSDxHxZkG2e2cgp93ToPS9tkrEMAdYwUqbJHZfwoHJPApi3IZvc4uNOIzjl4Q2dJk/3wwU2fwqJhXGbapZcCJSgdiyguQlHzIyZqQ020BDOXq6oSxvJGm9nB0OTyi7Wmg+8TySdngN9wLMk/flZcIGHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WJIBO6F4; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b1yrL67zmz64G;
	Tue, 20 May 2025 17:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1747754338;
	bh=fpcq+IBeWj32z7gPBx92ypw/9OpgG/CmMTsCvhDLbdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJIBO6F4WWZKdj3YhVkk5wXJ/gzj3dr968LNvBwTBESVBEio3Vd7IWUNJcUaXA92y
	 gU0iLGCGQmKXsRqqLFvvDyq4ZBD0aHlg1hrNG9jia1+sIitx77VFoic86WTH8h88Lq
	 ILu9RMl3lFFDQLLqHcYQnrxtOXXYlXYfIoDrXfJE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4b1yrJ5lpWzGb7;
	Tue, 20 May 2025 17:18:56 +0200 (CEST)
Date: Tue, 20 May 2025 17:18:56 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Mark Brown <broonie@kernel.org>, 
	WangYuli <wangyuli@uniontech.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Bill Wendling <morbo@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Tamir Duberstein <tamird@gmail.com>, 
	Diego Vieira <diego.daniel.professional@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/3] randstruct: gcc-plugin: Remove bogus void member
Message-ID: <20250520.Riene6ceesha@digikod.net>
References: <20250427013604.work.926-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250427013604.work.926-kees@kernel.org>
X-Infomaniak-Routing: alpha

On Sat, Apr 26, 2025 at 06:38:32PM -0700, Kees Cook wrote:
> Hi,
> 
> Okay, I've tracked down the problem with the randstruct GCC plugin,
> and written a KUnit test to validate behaviors. This lets us add
> it back the COMPILE_TEST builds.
> 
> No need for https://lore.kernel.org/all/20250421000854.work.572-kees@kernel.org/

Hi,

What is the status of this patch series?  Do you plan to send it for
v6.15?

> 
> -Kees
> 
> Kees Cook (3):
>   randstruct: gcc-plugin: Remove bogus void member
>   lib/tests: Add randstruct KUnit test
>   Revert "hardening: Disable GCC randstruct for COMPILE_TEST"
> 
>  MAINTAINERS                                   |   1 +
>  lib/Kconfig.debug                             |   8 +
>  lib/tests/Makefile                            |   1 +
>  lib/tests/randstruct_kunit.c                  | 283 ++++++++++++++++++
>  scripts/gcc-plugins/randomize_layout_plugin.c |  18 +-
>  security/Kconfig.hardening                    |   2 +-
>  6 files changed, 295 insertions(+), 18 deletions(-)
>  create mode 100644 lib/tests/randstruct_kunit.c
> 
> -- 
> 2.34.1
> 
> 

