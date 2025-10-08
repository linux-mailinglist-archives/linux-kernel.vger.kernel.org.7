Return-Path: <linux-kernel+bounces-845114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D348BBC38C9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927A53AF418
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C185D2F1FCC;
	Wed,  8 Oct 2025 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KSE0/jp4"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDE2BEC5F;
	Wed,  8 Oct 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908070; cv=none; b=VhmyyWKn+2cSGTF52BEcSEJ3aKkXyGg77jfR0T8SODOR9plaS4cYpqSY150NxG71pz0SU75HzazYh4C5qfLVxMXQ4J+VRKiSZ6VIh3aiHrUjNMFDdejwPOwSfBn149Js43/l2XVGLq49J/sE7glubh9x19aoqzr4FZYz1fHQukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908070; c=relaxed/simple;
	bh=sP4aYy3LGYKie9Zsyw/meqElIn+Pj9aRkoYfracj2U8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIJHrKKaPK4CjVzIE+RRReqiAR2IwluuvTZ+rAbEUt/t8KmDZI6OpqUmXdHqW2Fs+O2kM1+kMFVFPvPJDTY1lOjjPQCLO56820Bbh/5V4Vc3mtmM7pmar+0gIehX/+NphnMMeSCBoSQOZWuEzCKGZXvDUgamE3mHwZXJXtdAEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KSE0/jp4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E412F40B1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1759908062; bh=oDxqo6bhrFtTz43JrqaXib9xnrYhpkhJu6sFEpYEEeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KSE0/jp4/koiMnK3t/gQJA3NlBWA1txLVHv3K47G1fxkvRKv8iAowqHzK+bApqRvZ
	 yXIkW8BHnjcePX3sK0oTQgKEJMvYLalZe52x7FBKIdnlEAFHg0Sze6nxGm+dp6HWQQ
	 EsFBhTmKvvTImGAXX+YHq32nvG9Z7n0ado+BwcK+4htOKpKJNLxPdLQ/gC1wdpw//L
	 SA7VJ9NseGCU4V1s3gLi1LHSROK5UchwJzMH2/iQ9ihKLuTSpfwHeWKWKlQw0pr0uy
	 D4hX5CovwflXxVNKk5syZsDkiKnarDPgFyMgANvLC8ioBtrGBBzpGujYZyvpRAfZWf
	 ouXQQDk/iN8pA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E412F40B1C;
	Wed,  8 Oct 2025 07:21:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/docs: sphinx-build-wrapper: -q is a boolean, not
 an integer
In-Reply-To: <cafa10cddce3e5342a66c73f3f51a17fb6c7f5d3.1759851791.git.mchehab+huawei@kernel.org>
References: <cafa10cddce3e5342a66c73f3f51a17fb6c7f5d3.1759851791.git.mchehab+huawei@kernel.org>
Date: Wed, 08 Oct 2025 01:20:58 -0600
Message-ID: <87jz15oo4l.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> As reported by Konstantin, sphinx-build -q is a boolean, not an integer.
>
> Fix the code.
>
> Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Closes: https://lore.kernel.org/all/871pnepxfy.fsf@trenco.lwn.net/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/docs/sphinx-build-wrapper | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
> index a74998e8309a..3e6d166d4102 100755
> --- a/tools/docs/sphinx-build-wrapper
> +++ b/tools/docs/sphinx-build-wrapper
> @@ -141,7 +141,7 @@ class SphinxBuilder:
>          #
>          parser = argparse.ArgumentParser()
>          parser.add_argument('-j', '--jobs', type=int)
> -        parser.add_argument('-q', '--quiet', type=int)
> +        parser.add_argument('-q', '--quiet', action='store_true')

Applied to the build-script branch, thanks.

jon

