Return-Path: <linux-kernel+bounces-887364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0806C37FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0564FC89B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748D2DAFB0;
	Wed,  5 Nov 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OalmWR9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB428726E;
	Wed,  5 Nov 2025 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377551; cv=none; b=NrUbxxs8VkD6PjUVDKnRlrEneL10RvFZFUeYCq21ch/oArPUWqTbJ1UBcFvAfTxresiz3cVig8UvUpJOK9sZhQGEUc19SqdQN8CAjisraizoXWic+35s3ZjDJYlsnzl8jde3XFyYb+J4fGnrSLPnBLDDE7Vi/khrTAuukKyPLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377551; c=relaxed/simple;
	bh=1/KqV2b3zTTN2lwKtCoOJBgUyT+KNbZzoIYtgpw+4qA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHG0uaXTpzlpZF88z45Y3JWf0vzryCns6Xm2kDw5YqL0ru2Wyq9VIxptlxQCupyRo6i+TXHi/ToJYBG7Iu2dlyrYJLKWgrHQ3R7ioAcQCP9T4ImI4zkcIwCKl1Xu+BHPQaxhs9F7V7Hf9y58lOzhXTV1YTlp8B7xXZ0fWO3kgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OalmWR9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57585C4CEF5;
	Wed,  5 Nov 2025 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762377551;
	bh=1/KqV2b3zTTN2lwKtCoOJBgUyT+KNbZzoIYtgpw+4qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OalmWR9GKhFxQuVFflfPRWBKKRIIruipMj2xDv0EsyfOQj3d7qgoQu8Swygr73Z53
	 TDAsw7DgrIR3CgKWCkpLdgeBYo16Q6JpIU2ilcZABnj5Rb505rj1+iGMNvYHq8Jgvz
	 btQpPeD//HTiniZzA/5k5EIiXFI9P7Tovr+FnBW25Gjk5Ow76WPAVq1RwJSCOBQfzw
	 E3M6ITiJDTvu1VRXFG9SJwMf5/+35GVw1zJo7YxumzuUKB/p9RBfoDpiSHfBaLzfQE
	 qagvVGBAKNOF8DsonK01hR20MDyMuUBFl7Ofi7ifMGcNojF6bT3jrIEVN1eW/PRIb1
	 Oz/UI7HQKh07A==
Date: Wed, 5 Nov 2025 22:19:07 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <20251105221907.0c8c388b@foz.lan>
In-Reply-To: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue,  4 Nov 2025 22:55:02 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> escreveu:

> When kernel-doc parses the sections for the documentation some errors
> may occur. In many cases the warning is simply stored to the current
> "entry" object. However, in the most of such cases this object gets
> discarded and there is no way for the output engine to even know about
> that. To avoid that, check if the "entry" is going to be discarded and
> if there warnings have been collected, issue them to the current logger
> as is and then flush the "entry". This fixes the problem that original
> Perl implementation doesn't have.
> 
> As of Linux kernel v6.18-rc4 the reproducer can be:
> 
> $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> ...
> Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> ...
> 
> while with the proposed change applied it gives one more line:
> 
> $ scripts/kernel-doc -v -none -Wall include/linux/util_macros.h
> ...
> Info: include/linux/util_macros.h:138 Scanning doc for function to_user_ptr
> Warning: include/linux/util_macros.h:144 expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> ...
> 
> And with the original Perl script:
> 
> $ scripts/kernel-doc.pl -v -none -Wall include/linux/util_macros.h
> ...
> include/linux/util_macros.h:139: info: Scanning doc for function to_user_ptr
> include/linux/util_macros.h:149: warning: expecting prototype for to_user_ptr(). Prototype was for u64_to_user_ptr() instead
> ...
> 
> Fixes: 9cbc2d3b137b ("scripts/kernel-doc.py: postpone warnings to the output plugin")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index ee1a4ea6e725..f7dbb0868367 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -451,6 +451,13 @@ class KernelDoc:
>          variables used by the state machine.
>          """
>  
> +        #
> +        # Flush the warnings out before we proceed further
> +        #
> +        if self.entry and self.entry not in self.entries:
> +            for log_msg in self.entry.warnings:
> +                self.config.log.warning(log_msg)
> +
>          self.entry = KernelEntry(self.config, self.fname, ln)
>  
>          # State flags

No objection of this one, but this breaks the behavior of the -W
flags.

See, the way kernel-doc.pl worked is that:

1. Warnings are controlled via several -W flags:

  -Wreturn, --wreturn   Warns about the lack of a return markup on functions.
  -Wshort-desc, -Wshort-description, --wshort-desc
                        Warns if initial short description is missing

                        This option is kept just for backward-compatibility, but it does nothing,
                        neither here nor at the original Perl script.
  -Wall, --wall         Enable all types of warnings
  -Werror, --werror     Treat warnings as errors.

  Those affect running kernel-doc manually.

2. Warnings are affected by the filtering commands:

  -e, -export, --export
                        
                        Only output documentation for the symbols that have been
                        exported using EXPORT_SYMBOL() and related macros in any input
                        FILE or -export-file FILE.
  -i, -internal, --internal
                        
                        Only output documentation for the symbols that have NOT been
                        exported using EXPORT_SYMBOL() and related macros in any input
                        FILE or -export-file FILE.
  -s, -function, --symbol SYMBOL
                        
                        Only output documentation for the given function or DOC: section
                        title. All other functions and DOC: sections are ignored.
                        
                        May be used multiple times.


  Those affect both running kernel-doc manually or when called via make htmldocs,
  as the kerneldoc Sphinx markup supports them.

As the filters are only applied at kdoc/kdoc_output.py, printing warnings
early at kdoc_parser means that, even ignored symbols will be warned. It might
also make the same warning to appear more than once, for C files that are listed
on multiple kerneldoc entries(*).

(*) There is a logic at kerneldoc.py Sphinx extension and inside kdoc_files
    to avoid parsing the same file twice, but I didn't test adding a hack
    similar to this one to double-check that the warning won't appear multiple
    times when export is used. Maybe it is working fine.

-

In summary, if warnings are suppressed, my suggestion would be to check at 
kdoc_output to see what is filtering them out. 

Alternatively, if the idea is to always print warnings, get rid of all
-W<option> flags, except for -Werror.

Thanks,
Mauro

