Return-Path: <linux-kernel+bounces-799186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88129B4281E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C058D487BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3479931578B;
	Wed,  3 Sep 2025 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KBmCg5QE"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CE4C92;
	Wed,  3 Sep 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921275; cv=none; b=ayuDwZquNLSm1Z6KyAfVlO2Cx8bIb4zgAzN8p0kwpZs5s/5LQC6JdXeNYgYY4oZCHIrlGr1RvgdeCu66saUQ4Z2GcmCgUtcD8qntgdgoStyKXzyzDBvkSdn671lV/wPPHYCW+2xXj3V2jFwuCrpZfwQbxn8PSk8zewtpw0iaThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921275; c=relaxed/simple;
	bh=DwBkzoE+GXBkoTQ6jyYyprBpeOMhHPBK+76dx8fUlEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DG9eord9q12+L/RE2f2J7HSLMpGipLyW+RYII5fWa7oZww/YqW+Q2qWzWaeyMw+yefMvbm5HoazuR1CE5HG6aUWnZtqAE9mfefZ7FEWT69Nf0to2HZlWHeW4zCj+h+ZZQl4g/OcuMG/Dp1xpew+EgY8+Iaik157Iq8qA7TF7wyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KBmCg5QE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=X1eVCAkFUUWC9Rcj+8pDwlYz1m9LGmi/MZUugLKYsbM=; b=KBmCg5QE+NSTb1NZX6o53q9SKe
	z6CSKCFXKN3ffeW1JCQ9L+ou9wnVksOSytx0wnS5Ik7nv1V5Iir6BhAfQBajLGtbCCNI6DkUwsaqf
	Ff6cYdX/GsQmGt6eYl+SgG3D6pqj8pZ/b95GBHDCy1ACH0iYgNeZXVLPfBeY6FPw4wPFzTDktl1T0
	vR7UvYAxA+Jcc8cNjPt9d+4YgAT8rwe5vMZs6sq1mfQb6IgdRlCCgF23e6SHAUJXLjYfo7BB0fArm
	lEJ39H4SC1aTCzk8zD3dorofvl9g527rpWsAJgE1AfrMqNPvvs5hdKsObtipWKnHUOHuLWikX7IjX
	bT2yrREw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utrTt-00000007DH0-0CKu;
	Wed, 03 Sep 2025 17:41:13 +0000
Message-ID: <76c552d4-878f-4ec4-a22c-c5b0f7903eba@infradead.org>
Date: Wed, 3 Sep 2025 10:41:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tools/docs: sphinx-* break documentation bulds on
 openSUSE
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <cover.1756916565.git.mchehab+huawei@kernel.org>
 <29135db8c8094006f256e1fa0b64663c735737e7.1756916565.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <29135db8c8094006f256e1fa0b64663c735737e7.1756916565.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/25 9:24 AM, Mauro Carvalho Chehab wrote:
> Before this patch, building htmldocs on opensuseLEAP works
> fine:
> 
>     # make htmldocs
>     Available Python versions:
>       /usr/bin/python3.11
> 
>     Python 3.6.15 not supported. Changing to /usr/bin/python3.11
>     Python 3.6.15 not supported. Changing to /usr/bin/python3.11
>     Using alabaster theme
>     Using Python kernel-doc
> 
>     ...
> 
> As the logic detects that Python 3.6 is too old and recommends
> intalling python311-Sphinx. If installed, documentation builds
> work like a charm.
> 
> Yet, some develpers complained that running python3.11 instead
> of python3 should not happen. So, let's break the build to make
> them happier:
> 
>     $ make htmldocs
>     Python 3.6.15 not supported. Bailing out
>     You could run, instead:
>       /usr/bin/python3.11 /root/tools/docs/sphinx-build-wrapper htmldocs --sphinxdirs=. --conf=conf.py --theme= --css= --paper=

                            /root
??

> 
>     Python 3.6.15 not supported. Bailing out
>     make[2]: *** [Documentation/Makefile:75: htmldocs] Error 1
>     make[1]: *** [/root/Makefile:1806: htmldocs] Error 2
>     make: *** [Makefile:248: __sub-make] Error 2
> 
> It should be noticed that:
> 
> 1. after this change, sphinx-pre-install needs to be called
>    by hand:
> 
>     $ /usr/bin/python3.11 tools/docs/sphinx-pre-install
>     Detected OS: openSUSE Leap 15.6.
>     Sphinx version: 7.2.6
> 
>     All optional dependencies are met.
>     Needed package dependencies are met.
> 
> 2. sphinx-build-wrapper will auto-detect python3.11 and
>    suggest a way to build the docs using the parameters passed
>    via make variables. In this specific example:
> 
>    /usr/bin/python3.11 /root/tools/docs/sphinx-build-wrapper htmldocs --sphinxdirs=. --conf=conf.py --theme= --css= --paper=

ditto.

> 
> 3. As this needs to be executed outside docs Makefile, it won't run
>    the validation check scripts nor build Rust documentation if
>    enabled, as the extra scripts are part of the docs Makefile.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/docs/sphinx-build-wrapper | 3 ++-
>  tools/docs/sphinx-pre-install   | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
> index 932b1b675274..48e6e0a76aeb 100755
> --- a/tools/docs/sphinx-build-wrapper
> +++ b/tools/docs/sphinx-build-wrapper
> @@ -719,7 +719,8 @@ def main():
>  
>      args = parser.parse_args()
>  
> -    PythonVersion.check_python(MIN_PYTHON_VERSION)
> +    PythonVersion.check_python(MIN_PYTHON_VERSION, show_alternatives=True,
> +                               bail_out=True)
>  
>      builder = SphinxBuilder(venv=args.venv, verbose=args.verbose,
>                              n_jobs=args.jobs, interactive=args.interactive)
> diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
> index 663d4e2a3f57..698989584b6a 100755
> --- a/tools/docs/sphinx-pre-install
> +++ b/tools/docs/sphinx-pre-install
> @@ -1531,7 +1531,8 @@ def main():
>  
>      checker = SphinxDependencyChecker(args)
>  
> -    PythonVersion.check_python(MIN_PYTHON_VERSION)
> +    PythonVersion.check_python(MIN_PYTHON_VERSION,
> +                               bail_out=True, success_on_error=True)
>      checker.check_needs()
>  
>  # Call main if not used as module

-- 
~Randy


