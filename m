Return-Path: <linux-kernel+bounces-785256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89628B34837
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4560F3B208A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3B32FE575;
	Mon, 25 Aug 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKg3lQVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DCC502BE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141636; cv=none; b=kJz4N4D5zcAu227iWlta5xMTqKnUOY1IxLTqdIgNmhV+OpzKvfN44KYGhP83j6yekEkShy4YwrBFJoVOVXebI+EMIv3MTb0HPGZdh3dlosUMDowUM2tgxA+PA4SdeV/uCO8VAqEGUiSEqXDNobOmt71na4ljLbBQmsEM6jWeyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141636; c=relaxed/simple;
	bh=CtFV4txEIsb5GwPU95hW0QcOZfgmoLFWkkT+zvYFR6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOPrw7AZExqxIAhgWfECsf3CU7RwxetlWngBW6dPtBF/WUvBmd8iU/R+XJXaRVShj2UcDG2+2h7iSxesdxowlnz8Wa3GKmzRTERFMVZJdzKdomvNPhmr3qxY7lihCLGYEef2dT6+8YQJtj4LsCc1InLVzpJ2ve84XF+gWcl49HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKg3lQVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D9AC4CEED;
	Mon, 25 Aug 2025 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756141634;
	bh=CtFV4txEIsb5GwPU95hW0QcOZfgmoLFWkkT+zvYFR6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKg3lQVrmqNutEHlOY9EAlUciEVp/jmSINPjrPrXW5DNWqzG7EVGeqrzgY1HB/ahc
	 J6rW5saoTEu1XM+BJaU76SayNAJZHZDlfTEGqz/49J5eR+dqenc4vMaNyTFMfOOXoZ
	 mqP6V206NFx+4HUrBFItIb6H0wgupHeL0aSDDNTc4PiFTzZgevWxOT5pABAkC3UZnI
	 Px1FyrO0SySC/C3JKWj2+Gac1sjWuZ3Cw/rLTYqAJRXNf6VU0s+OeAHXgFVGjCtyZS
	 DcEqa9A0owAlI5evfnulkIxrse9KPsZc18X5Ml3Ne4YDji2ozdAEoYFiHAVk2jdsKM
	 Q5hVhE4VWn8TQ==
Date: Mon, 25 Aug 2025 10:07:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/misc-check: update export checks for
 EXPORT_SYMBOL_FOR_MODULES()
Message-ID: <20250825170710.GC2719297@ax162>
References: <20250825-export_modules_fix-v1-1-5c331e949538@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-export_modules_fix-v1-1-5c331e949538@suse.cz>

On Mon, Aug 25, 2025 at 05:00:37PM +0200, Vlastimil Babka wrote:
> The module export checks are looking for EXPORT_SYMBOL_GPL_FOR_MODULES()
> which was renamed to EXPORT_SYMBOL_FOR_MODULES(). Update the checks.
> 
> Fixes: 6d3c3ca4c77e ("module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_MODULES")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> I've missed these new checks when renaming the export macro due to my
> git grep being too narrow. My commit went through Christian's vfs tree
> but seems the script is part of kbuild (which is currently Odd fixes).

If this needs to reach Linus's tree to avoid warnings, it could go via
another vfs fixes pull request with our ack or we could ask him to pick
it up directly (as I am not sure we will have a fixes pull request this
cycle). If it is not urgent, I can pick it up via kbuild-next for 6.18.
I have no strong preference.

> ---
>  scripts/misc-check | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/misc-check b/scripts/misc-check
> index 84f08da17b2c0508b5c2471a6ffb2ab7e36592a4..40e5a4b01ff473a7bfd2fdc156ae06c8cf18f504 100755
> --- a/scripts/misc-check
> +++ b/scripts/misc-check
> @@ -45,7 +45,7 @@ check_tracked_ignored_files () {
>  # does not automatically fix it.
>  check_missing_include_linux_export_h () {
>  
> -	git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_GPL_FOR_MODULES)\(.*\)' \
> +	git -C "${srctree:-.}" grep --files-with-matches -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' \
>  	    -- '*.[ch]' :^tools/ :^include/linux/export.h |
>  	xargs -r git -C "${srctree:-.}" grep --files-without-match '#include[[:space:]]*<linux/export\.h>' |
>  	xargs -r printf "%s: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing\n" >&2
> @@ -58,7 +58,7 @@ check_unnecessary_include_linux_export_h () {
>  
>  	git -C "${srctree:-.}" grep --files-with-matches '#include[[:space:]]*<linux/export\.h>' \
>  	    -- '*.[c]' :^tools/ |
> -	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_GPL_FOR_MODULES)\(.*\)' |
> +	xargs -r git -C "${srctree:-.}" grep --files-without-match -E 'EXPORT_SYMBOL((_NS)?(_GPL)?|_FOR_MODULES)\(.*\)' |
>  	xargs -r printf "%s: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present\n" >&2
>  }
>  
> 
> ---
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> change-id: 20250825-export_modules_fix-07d9597f9009
> 
> Best regards,
> -- 
> Vlastimil Babka <vbabka@suse.cz>
> 

