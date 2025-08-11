Return-Path: <linux-kernel+bounces-763601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA15B2174A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93483A65BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A02DCBF1;
	Mon, 11 Aug 2025 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpt3/kPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF282D9EC4;
	Mon, 11 Aug 2025 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947492; cv=none; b=i4S4MBwfd4pSUGMI+O+rpRC6CxqMipLw/REbpN+6Ic/ps+gNUqvb/jBYEWlxIPkXvWgPyQ/ksEASaVHyJIB9LfR/UP+oSi7EIYaG1AbtjdGEHP4yjIP6yIzUVObvM8woYVatvG7VoA4iSFREsfut2tn7ElcH8pwido1rIPNA+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947492; c=relaxed/simple;
	bh=FBfrc5n//xqcxAB6OfOVXo9cs54q9iIJHxD49Lk0gow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMMpO/KP7C64chtOOBh0Si5h/gW2GXO6GMMfc8B5XAaF3lDgjNnMcCCKQiViQeXX3woMmhdlQ9BlqT+B8K6M6TAKh3XT4jWMmdU0Dp3c/UN8uOfTIQ/Zt0BqLk89SslBoedHtI+65UyGfGEbhkBLf48LyF+b6YsOEq3LyrXLeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpt3/kPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2688AC4CEED;
	Mon, 11 Aug 2025 21:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754947491;
	bh=FBfrc5n//xqcxAB6OfOVXo9cs54q9iIJHxD49Lk0gow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kpt3/kPZ3wtE9utUf5yDhesS31wBtYRqoy2I2PK+8MdO5TFYKaiG5TMU1TgnqkP8a
	 pZVE5tmEX8mvj35LERznfQ3r4s76nQT08FHfnU0+GdeEM1WY3u+jyugyFyf5NyP9Cc
	 qM7p+oticH8DfYkAL4EE8R2iBdc9F+LOOXxGvr72lpa6vpPebC5q52s3GMnd62eM4S
	 4MZgbfS38q58hO0lOA3jdde1Z/glDUgtznGFYd4PAzEFNRlNzyDg/Ekis9EDbyDl8G
	 dcSrjQ4vpPgmGSQMBQhwPrDNvZYIXUUCS3cxeNDiLWX7okTXjaXYZ8qpfrY7WY4Sj1
	 gBWEZa7REnd3w==
Date: Mon, 11 Aug 2025 14:24:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Haoyang LIU <tttturtleruss@gmail.com>, Dongliang Mu <dzm91@hust.edu.cn>,
	Yanteng Si <si.yanteng@linux.dev>, Alex Shi <alexs@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	hust-os-kernel-patches@googlegroups.com,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] scripts/checktransupdate.py: add support for scanning
 directory
Message-ID: <20250811212446.GA924610@ax162>
References: <20250811170050.94997-1-tttturtleruss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811170050.94997-1-tttturtleruss@gmail.com>

Hi Haoyang,

On Tue, Aug 12, 2025 at 01:00:50AM +0800, Haoyang LIU wrote:
> Origin script can only accept a file as parameter, this commit enables
> it to scan a directory.
> 
> Usage example:
> ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools
> 
> Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
> ---
> 
> V1 -> V2: remove the fix of missing "f" in f-string and make it a new patch
> 
>  scripts/checktransupdate.py | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Thanks for the update. While this seems reasonable to me from a purely
surface level glance over the actual Python, I have added the
Documentation folks that Dongliang added from the previous thread, who
really own and maintain this file (the original patch is at [1]). Please
include them in future revisions should they be necessary. It would
probably be good for something like this to be applied?

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..b7e3a8c8832e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,6 +7302,7 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	scripts/check-variable-fonts.sh
+F:	scripts/checktransupdate.py
 F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*

[1]: https://lore.kernel.org/20250811170050.94997-1-tttturtleruss@gmail.com/

Cheers,
Nathan

