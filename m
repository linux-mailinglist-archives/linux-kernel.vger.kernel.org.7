Return-Path: <linux-kernel+bounces-806912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D44BB49D76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC604E43AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABB2F7ADC;
	Mon,  8 Sep 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G16NZRd0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F0F1B87F2;
	Mon,  8 Sep 2025 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373894; cv=none; b=lyW9WRf9thYh05IHzoYHI5X0NKF8F219JBg6baIOXv3Bx7XjQqwNu+fx4cTsschE+xIHUqclo7BykfchHaG9XQzD1OljVdqCCgkH/wmYS9fbxe/3TQZPSre7W6hCYzo4WHuw8TJaQUAxpQB+RwKw7CRsUzJYxDFgZCZ0heW8f4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373894; c=relaxed/simple;
	bh=kknwVALPchxX0mj+Hxc56nDgnBNJk/z7KwE2dTVLSYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUFyZ8SWEGRoXrHMVkVRtvMcQKPcnLGBMV+lXINhLQBmYXy/F0xpWHf0TRIU/g4mQ/TSISM5O+QTjaRdm9AY77gHWquN654DtFOEjbFclLv+gt524mSPL64bU4c1WBtn3dx3xrtsXQc8EEkNa1g4cQkmaJDF+wSKt7VVRWO2VHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G16NZRd0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=l95PSEtUbGHnCqBRekzfUsDtN3LLag+0o85iItgBhQ0=; b=G16NZRd0OjOFf1g2Psq/MdTzvm
	v91ln3LmWVFnFMi+uvsezVYTDJRvFDq0rm+qXbNnrKgQzKp7L2h5nEh3qcKPlhtNA8mXbED0cSylL
	nHO6Z5raIuuJ/pNFkd4+DdNWvOVEDzmHGDdu1NMU7VQb7TvC8+P9Quc05a0GI/iImkMQ7Zt8guckS
	a9ZKaJLwOBREugd6GpEAw6/q5/tUHVFZTav8pjEknyMEFOX/KEdNmghtBsf2U8oB6MOXqGUfGLB0o
	0NuBBesQaX0J3yjT/ZsJXeH/2ssPtlucmGvqvwztlZEaNQeIeo7xIlmzYnoY4WknAfy71gIqPR8Zi
	hAFVr42g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvlEC-00000002wVg-0YFq;
	Mon, 08 Sep 2025 23:24:52 +0000
Message-ID: <b85f833d-1da7-4e4e-8258-7358c9d5a0b2@infradead.org>
Date: Mon, 8 Sep 2025 16:24:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update the guidance for Link: tags
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>, linus.walleij@linaro.org
References: <87segwyc3p.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87segwyc3p.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/25 12:32 PM, Jonathan Corbet wrote:
> As stated definitively by Linus, the use of Link: tags should be limited to
> situations where there is additional useful information to be found at the
> far end of the link.  Update our documentation to reflect that policy, and
> to remove the suggestion for a Git hook to add those tags automatically.
> 
> Link: https://lore.kernel.org/all/CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com/
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/maintainer/configure-git.rst | 28 ----------------------
>  Documentation/process/5.Posting.rst        |  7 +++---
>  2 files changed, 3 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
> index 0a36831814ea..0c21f203cf7a 100644
> --- a/Documentation/maintainer/configure-git.rst
> +++ b/Documentation/maintainer/configure-git.rst
> @@ -28,31 +28,3 @@ You may also like to tell ``gpg`` which ``tty`` to use (add to your shell
>  rc file)::
>  
>  	export GPG_TTY=$(tty)
> -
> -
> -Creating commit links to lore.kernel.org
> -----------------------------------------
> -
> -The web site https://lore.kernel.org is meant as a grand archive of all mail
> -list traffic concerning or influencing the kernel development. Storing archives
> -of patches here is a recommended practice, and when a maintainer applies a
> -patch to a subsystem tree, it is a good idea to provide a Link: tag with a
> -reference back to the lore archive so that people that browse the commit
> -history can find related discussions and rationale behind a certain change.
> -The link tag will look like this::
> -
> -    Link: https://lore.kernel.org/r/<message-id>
> -
> -This can be configured to happen automatically any time you issue ``git am``
> -by adding the following hook into your git::
> -
> -	$ git config am.messageid true
> -	$ cat >.git/hooks/applypatch-msg <<'EOF'
> -	#!/bin/sh
> -	. git-sh-setup
> -	perl -pi -e 's|^Message-I[dD]:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
> -	test -x "$GIT_DIR/hooks/commit-msg" &&
> -		exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
> -	:
> -	EOF
> -	$ chmod a+x .git/hooks/applypatch-msg
> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> index 22fa925353cf..9999bcbdccc9 100644
> --- a/Documentation/process/5.Posting.rst
> +++ b/Documentation/process/5.Posting.rst
> @@ -207,10 +207,9 @@ document with a specification implemented by the patch::
>  
>  	Link: https://example.com/somewhere.html  optional-other-stuff
>  
> -Many maintainers when applying a patch also add this tag to link to the
> -latest public review posting of the patch; often this is automatically done
> -by tools like b4 or a git hook like the one described in
> -'Documentation/maintainer/configure-git.rst'.
> +As per guidance from the Chief Penguin, a Link: tag should only be added to
> +a commit if it leads to useful information that is not found in the commit
> +itself.
>  
>  If the URL points to a public bug report being fixed by the patch, use the
>  "Closes:" tag instead::

-- 
~Randy

