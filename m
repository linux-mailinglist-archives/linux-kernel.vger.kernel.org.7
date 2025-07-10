Return-Path: <linux-kernel+bounces-724913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102EEAFF873
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BBB561B44
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78228313A;
	Thu, 10 Jul 2025 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSzRtHdU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865DE469D;
	Thu, 10 Jul 2025 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752125324; cv=none; b=bEzBv4gAw7Z9+h9kTXXrtzlp2QFcpxJcoEJ4dTEuXHZEV/ryPBpRG/lYaNR5qmhdElmN0jXflWTR279xhmix608fIV2gEerlG35x5lgoRKCUw96tKCRluunodo7jyLtHdvx2Mcc++4FxlylNx+V81xCMW8Wl2XV29k15Y/mSDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752125324; c=relaxed/simple;
	bh=wF5JeayeBkEEDdnlLPqOLW0bHgQTlWJbPloR5u0JlW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mo5UYbHx1W57CR0ZYZFytUnhk9e4+yoAGPvQQ7Ai/FHNLtBG4OsF/EMgvyrP7OCbWHvKpzAGNgpoVyjlP07dFPWO/o6FjF4RfN0t9zZwTHV5CSdNTyMFiSPiTJQqXhB3s6W8fSf2Y1BD3cb49iKo9l1Pxsl76qQzBPP4cHD3fS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSzRtHdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17D7C4CEE3;
	Thu, 10 Jul 2025 05:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752125324;
	bh=wF5JeayeBkEEDdnlLPqOLW0bHgQTlWJbPloR5u0JlW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jSzRtHdUC2ZOr+tJvnZydVGksNqOMmoEZsEwM3/xX8y5DjbU67/IN2eWl1CYZwK1r
	 2Ou+pP+/32lTX+Ef5e5k17Iak63ET1XEYEYXrRcEOvCiuClpe0WKvf1/Ho8wXCREIl
	 2/2I6lQjtIFCq5agMyAVuG7VPjTbhF6Oy1BidrZk0O155Srodto5JGhUuC+jETNe/D
	 YPzhW+Ed1rb53h8bPE9XzoeR1gbc9AM3kcP8ChzuWc+l32FFkHJSyW7DHje51gMz+y
	 E072T4YV5itjlrTG1Bbm3rlxhdixI+zcwqjuA3iiClLH9futNYCodS8vSuZuFEf/xJ
	 VwNU5WXlsxTmg==
Date: Thu, 10 Jul 2025 07:28:39 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 01/12] docs: kdoc; Add a rudimentary class to represent
 output items
Message-ID: <20250710072839.295da9f1@foz.lan>
In-Reply-To: <20250702223524.231794-2-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-2-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:13 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> This class is intended to replace the unstructured dict used to accumulate
> an entry to pass to an output module.  For now, it remains unstructured,
> but it works well enough that the output classes don't notice the
> difference.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_item.py   | 26 ++++++++++++++++++++++++++
>  scripts/lib/kdoc/kdoc_parser.py | 30 +++++++++---------------------
>  2 files changed, 35 insertions(+), 21 deletions(-)
>  create mode 100644 scripts/lib/kdoc/kdoc_item.py
> 
> diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
> new file mode 100644
> index 000000000000..add2cc772fec
> --- /dev/null
> +++ b/scripts/lib/kdoc/kdoc_item.py
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# A class that will, eventually, encapsulate all of the parsed data that we
> +# then pass into the output modules.
> +#
> +
> +class KdocItem:
> +    def __init__(self, name, type, start_line, **other_stuff):
> +        self.name = name
> +        self.type = type
> +        self.declaration_start_line = start_line
> +        #
> +        # Just save everything else into our own dict so that the output
> +        # side can grab it directly as before.  As we move things into more
> +        # structured data, this will, hopefully, fade away.
> +        #
> +        self.other_stuff = other_stuff
> +
> +    def get(self, key, default = None):
> +        ret = self.other_stuff.get(key, default)
> +        if ret == default:
> +            return self.__dict__.get(key, default)
> +        return ret
> +
> +    def __getitem__(self, key):
> +        return self.get(key)
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 831f061f61b8..a5a59b97a444 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -16,7 +16,7 @@ import re
>  from pprint import pformat
>  
>  from kdoc_re import NestedMatch, KernRe
> -
> +from kdoc_item import KdocItem
>  
>  #
>  # Regular expressions used to parse kernel-doc markups at KernelDoc class.
> @@ -271,32 +271,20 @@ class KernelDoc:
>          The actual output and output filters will be handled elsewhere
>          """
>  
> -        # The implementation here is different than the original kernel-doc:
> -        # instead of checking for output filters or actually output anything,
> -        # it just stores the declaration content at self.entries, as the
> -        # output will happen on a separate class.
> -        #
> -        # For now, we're keeping the same name of the function just to make
> -        # easier to compare the source code of both scripts
> -
> -        args["declaration_start_line"] = self.entry.declaration_start_line
> -        args["type"] = dtype
> -        args["warnings"] = self.entry.warnings
> -
> -        # TODO: use colletions.OrderedDict to remove sectionlist
> +        item = KdocItem(name, dtype, self.entry.declaration_start_line, **args)
> +        item.warnings = self.entry.warnings
>  
> -        sections = args.get('sections', {})
> -        sectionlist = args.get('sectionlist', [])
> +        sections = item.get('sections', {})
> +        sectionlist = item.get('sectionlist', [])
>  
>          # Drop empty sections
>          # TODO: improve empty sections logic to emit warnings
>          for section in ["Description", "Return"]:
> -            if section in sectionlist:
> -                if not sections[section].rstrip():
> -                    del sections[section]
> -                    sectionlist.remove(section)
> +            if section in sectionlist and not sections[section].rstrip():
> +                del sections[section]
> +                sectionlist.remove(section)
>  
> -        self.entries.append((name, args))
> +        self.entries.append((name, item))
>  
>          self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
>  



Thanks,
Mauro

