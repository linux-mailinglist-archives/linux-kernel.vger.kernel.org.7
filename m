Return-Path: <linux-kernel+bounces-785145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 672D8B3469A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C56B1B21CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CCD2F0694;
	Mon, 25 Aug 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEn2C+06"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F824677A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137711; cv=none; b=c33ieR2u/SPoJnJaLSKgfKkwWs17QQLBPvxg2r9BQh+zCAblX8CFZKM2+cWyujOAtQUKa9xPqjMx+n0HLwNKliMIDugW0T77OxEATOKb1xlxampcmHc78dz4wNj4LHpSKY3C+eGJq6Xw0qDB5C290bMGSkmh0x/j9KOQO4uMxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137711; c=relaxed/simple;
	bh=ISkwQ5NNuVryq92yIseUmZFg+3W7aO5mFGQ0UqjFjA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTKqI5W8Xf2i/XvTmpAOaNYDIXYeIfqy+9JmNcZ4Os+0cb/Q3kJ7Yskcm7VkE8n27+8K/1ldaWUXIDzVJfhI1ceyXyNGyuUbhca41GpjSkeGNWxJZLIUHqjX7BZoI51Qt7YK75iIpFQwe+CmuXtKZFsEyzlD1eIwrXpluoC5/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEn2C+06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C69C4CEED;
	Mon, 25 Aug 2025 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756137711;
	bh=ISkwQ5NNuVryq92yIseUmZFg+3W7aO5mFGQ0UqjFjA8=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vEn2C+0686rex61T+R05++0z4oinqXWmfihQA28VAIwLrOvwY0wYQf4DPaObCbnup
	 tcGzhSoMKmliGCc7CoTN/M9TlAJi2X9kPZyM/689zn04771OFLGaQkHpCG642bqXQN
	 ze7KNDsHQ3M5ibSRZAg3g92xsCfniQrdiSUfkLo97UnbekHuSk7hNH/ah2EQvr8Tw6
	 cgm7RNlr3vdwq+ZS9WUX2iYOFsHDVZi9O9iK6/CC1pgCKYZKKXq0kRoqdGI6wxJEeW
	 BiSm74nipaqFd5GJNZ5PWZKTWuNfuhFm6vKEmgTKqcfjX364DzRlHNWS3oBevnTcEt
	 u9GbrP52EWKTg==
Message-ID: <c24885ed-da71-46c2-9438-e500176a03b5@kernel.org>
Date: Mon, 25 Aug 2025 18:01:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] scripts/misc-check: update export checks for
 EXPORT_SYMBOL_FOR_MODULES()
To: Vlastimil Babka <vbabka@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
References: <20250825-export_modules_fix-v1-1-5c331e949538@suse.cz>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250825-export_modules_fix-v1-1-5c331e949538@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/08/2025 17.00, Vlastimil Babka wrote:
> The module export checks are looking for EXPORT_SYMBOL_GPL_FOR_MODULES()
> which was renamed to EXPORT_SYMBOL_FOR_MODULES(). Update the checks.
> 
> Fixes: 6d3c3ca4c77e ("module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_MODULES")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

LGTM,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> ---
> I've missed these new checks when renaming the export macro due to my
> git grep being too narrow. My commit went through Christian's vfs tree
> but seems the script is part of kbuild (which is currently Odd fixes).
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

