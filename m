Return-Path: <linux-kernel+bounces-834578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51529BA4FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089C73A9AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947A27FD46;
	Fri, 26 Sep 2025 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k7g6D9SH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA741A0728;
	Fri, 26 Sep 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758915674; cv=none; b=rBJtjGv6RfEeVF9z55XvnDJcRakJbfOO8cu2g02ok6forFfGMNrF68LHTiz4qyjuCgmphOCYpKbDcqTKZDXpRlwUiMkpPcA9bHkmbKQ72TZB7ZK/+24P4e1r2st6v0pcm4LNhb0xVBPSqs7l3mLy4M8UmmEKMOG6+MZDH7adGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758915674; c=relaxed/simple;
	bh=yNQ1BL6Uo2tEzqpW+U8KL58C/yFZB4s7Gp5MOkTJWyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhtxZQdGDNnJQ7Dqgkj0I1kzv7COnsRpS2kzNeleYR1JsxnTfyKAsAqpr/58TpZXV0Eo26J9NOmDB+xBT6MdLfgHC36xqwVEzuwZ+qm9LcPhv69hgY4JliQyrsn4nvhkdb9GB0kWo8GxAiTe0KTQpGwQsz1LL5lQsB/Dz4veeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k7g6D9SH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=e5R906mUk1iA+k7ic9DC6cc67+79yufwoiaYMprzy/U=; b=k7g6D9SHbrNP3PmwizNZBcuovX
	gVlEWCcg9RkG605Nss+UiGOyj8zcnvVWPR2FOdSyKEknKOqsn4lICj5RQ2ejEriiZ3v7JIJDpIVwm
	OT1LQ4+ab2PU7d8czC+WG8vg0R00HRa1SvbfLv5rBPJ0/VaZFA2xsEQZmCQPUfzXn3pXuEoOQGPjD
	3MkxHB4CL6FCHTi3X5YxhOllXaKqYlma70Lguo5WAzQypVClwggNYpagq1Hu08CYZd9lXrFrUFbBw
	YjH8YBJW8I9e88uTJ0YkjXw2L3a71WxauHqMdQ/lGOamcd2N11/sv3O+kTKK/IpH4trS3STaUseKC
	F8FkF7ZQ==;
Received: from [50.53.25.54] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2EJc-000000041DA-3uxH;
	Fri, 26 Sep 2025 19:41:12 +0000
Message-ID: <097971a6-9a19-4618-ac96-070fcb3ff4bd@infradead.org>
Date: Fri, 26 Sep 2025 12:41:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: Makefile: avoid a warning when using without
 texlive
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <cover.1758881658.git.mchehab+huawei@kernel.org>
 <e23e03dd41e044d55e4ae24ffd9e1b49e3f2515a.1758881658.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e23e03dd41e044d55e4ae24ffd9e1b49e3f2515a.1758881658.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/26/25 3:16 AM, Mauro Carvalho Chehab wrote:
> As reported by Randy, running make htmldocs on a machine
> without textlive now produce warnings:
> 
>      $ make O=DOCS htmldocs
>      ../Documentation/Makefile:70: warning: overriding recipe for target 'pdfdocs'
>      ../Documentation/Makefile:61: warning: ignoring old recipe for target 'pdfdocs'
> 
> That's because the code has now two definitions for pdfdocs in
> case $PDFLATEX command is not found. With the new script, such
> special case is not needed anymore, as the script checks it.
> 
> Drop the special case. Even after dropping it, on a machine
> without LaTeX, it will still produce an error as expected,
> as running:
> 
>      $ ./tools/docs/sphinx-build-wrapper pdfdocs
>      Error: pdflatex or latexmk required for PDF generation
> 
> does the check. After applying the patch we have:
> 
>      $ make SPHINXDIRS=peci htmldocs
>      Using alabaster theme
>      Using Python kernel-doc
> 
>      $ make SPHINXDIRS=peci pdfdocs
>      Error: pdflatex or latexmk required for PDF generation
>      make[2]: *** [Documentation/Makefile:64: pdfdocs] Error 1
>      make[1]: *** [/root/Makefile:1808: pdfdocs] Error 2
>      make: *** [Makefile:248: __sub-make] Error 2
> 
> Which is the expected behavior.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-doc/e7c29532-71de-496b-a89f-743cef28736e@infradead.org/

s/Link/Closes/

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>   Documentation/Makefile | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index c60db1038c9c..f764604fa1ac 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -66,20 +66,15 @@ htmldocs mandocs infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkche
>   		--builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
>   		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
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
>   # The following targets are independent of HAVE_SPHINX, and the rules should
>   # work or silently pass without Sphinx.
>   
> +htmldocs-redirects: $(srctree)/Documentation/.renames.txt
> +	@tools/docs/gen-redirects.py --output $(BUILDDIR) < $<
> +
>   refcheckdocs:
>   	$(Q)cd $(srctree);scripts/documentation-file-ref-check
>   

-- 
~Randy


