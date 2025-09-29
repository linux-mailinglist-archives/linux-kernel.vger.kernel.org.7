Return-Path: <linux-kernel+bounces-836491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CCBA9DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F511920ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6241FBC91;
	Mon, 29 Sep 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z/9t8FLd"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463B302CC3;
	Mon, 29 Sep 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160954; cv=none; b=rcx5mPmI8VPPFFdQDapojwPQbez2DP7LpFv21N2uQE94zUpQ9Eym/RZBE1l0hyimy5C5FbVl5I05bAkxg4nEQfdn7TjywHiogXJIKSrf2w6DVnxGGD66fvk0DaW5JSKipCwEUBmx7Cc91OgWVSKB04TBmSLBkG+/9xtOMoEGdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160954; c=relaxed/simple;
	bh=Djz8TYajhBiMayr/M3LBbJmVAmUn4/m0WGHlcZH+J7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqWbS8YEOgEf1umTsa1/67TVBfFyN7TeaPgVYG7rjl4A0MkqKZS9Cs1QWY6ThDLm3ay7zXXAkKMDdgBs/Aii4SXnVUphgq6qJVDOJoZ60w2VtY3R93qP7IFNKG7wn/sV5+qJ9uwYE3aIxH7XDrbFApdVf3QxLRjL5I41OtVzY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z/9t8FLd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8MOO/nezL5lEYXiXWSaF0TEmtNr4EFi6jORsrGyEUZw=; b=z/9t8FLdz1oS15LFfp37+PGM4X
	XUj+X7VlHZETBpfAIlh9dKMwiJziPnOjbuR63N1DBiiGRwTOfEuM44lw9ZSm2k35zlWf62zAPmNBA
	nOfGjDfBSHcEvvFU7iGZT+nl4YhvpY/B4jNde7A2MigyDRlSPMXe/L7RVf6Pi5vdvJV6auAAqbnhf
	qxE+iC6XkN+l8IMQzFiuYwigbMvCMlKwv0Fo7UT1rM4bgwCI3+esv6Kti8hAef5mm0vLndgTjgvnH
	uBCBMRAAyc4873XU4nAya2i6A8d5XD1Se0ZwZXdUG3nCvGWoAGTeFF86pOMCYODti0PgVItNS6RW1
	Hpi8XFOw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3G7k-00000002pNC-3plx;
	Mon, 29 Sep 2025 15:49:12 +0000
Message-ID: <b47f784a-1322-4f7e-92be-c26a8d56b076@infradead.org>
Date: Mon, 29 Sep 2025 08:49:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] docs: Makefile: avoid a warning when using without
 texlive
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1759135339.git.mchehab+huawei@kernel.org>
 <cd16a7436a510116ef87cd4abbb1f3cfe358012f.1759135339.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cd16a7436a510116ef87cd4abbb1f3cfe358012f.1759135339.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/29/25 1:53 AM, Mauro Carvalho Chehab wrote:
> As reported by Randy, running make htmldocs on a machine
> without textlive now produce warnings:
> 
>     $ make O=DOCS htmldocs
>     ../Documentation/Makefile:70: warning: overriding recipe for target 'pdfdocs'
>     ../Documentation/Makefile:61: warning: ignoring old recipe for target 'pdfdocs'
> 
> That's because the code has now two definitions for pdfdocs in
> case $PDFLATEX command is not found. With the new script, such
> special case is not needed anymore, as the script checks it.
> 
> Drop the special case. Even after dropping it, on a machine
> without LaTeX, it will still produce an error as expected,
> as running:
> 
>     $ ./tools/docs/sphinx-build-wrapper pdfdocs
>     Error: pdflatex or latexmk required for PDF generation
> 
> does the check. After applying the patch we have:
> 
>     $ make SPHINXDIRS=peci htmldocs
>     Using alabaster theme
>     Using Python kernel-doc
> 
>     $ make SPHINXDIRS=peci pdfdocs
>     Error: pdflatex or latexmk required for PDF generation
>     make[2]: *** [Documentation/Makefile:64: pdfdocs] Error 1
>     make[1]: *** [/root/Makefile:1808: pdfdocs] Error 2
>     make: *** [Makefile:248: __sub-make] Error 2
> 
> Which is the expected behavior.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-doc/e7c29532-71de-496b-a89f-743cef28736e@infradead.org/

Maybe Closes: ?  Anyway:

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Makefile | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index c60db1038c9c..f764604fa1ac 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -66,20 +66,15 @@ htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkche
>  		--builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
>  		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
>  
> -# Special handling for pdfdocs
> -ifneq ($(shell which $(PDFLATEX) >/dev/null 2>&1; echo $$?),0)
> -pdfdocs:
> -	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
> -	@echo "  SKIP    Sphinx $@ target."
> -endif
>  
> -htmldocs-redirects: $(srctree)/Documentation/.renames.txt
> -	@tools/docs/gen-redirects.py --output $(BUILDDIR) < $<
> -endif # HAVE_SPHINX
> +endif
>  
>  # The following targets are independent of HAVE_SPHINX, and the rules should
>  # work or silently pass without Sphinx.
>  
> +htmldocs-redirects: $(srctree)/Documentation/.renames.txt
> +	@tools/docs/gen-redirects.py --output $(BUILDDIR) < $<
> +
>  refcheckdocs:
>  	$(Q)cd $(srctree);scripts/documentation-file-ref-check
>  
-- 
~Randy


