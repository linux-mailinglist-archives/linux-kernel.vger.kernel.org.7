Return-Path: <linux-kernel+bounces-726928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C824B012F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880AA1C8308B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBAD1C84B3;
	Fri, 11 Jul 2025 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTeaLxeX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892BB469D;
	Fri, 11 Jul 2025 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212994; cv=none; b=kkbQBzrfG6ebF+9Ph7U2rcRiWnDT0tG5LIqiHn7Jc9ZquuuFqHpsZSYT5k0v6NIMS9XQdbhv4RcdkGVaES0OzRZOC+QhwcN5zZUt61pmlN20UeAH4zyN3gQE1QtrDuhv3/AODnkdW90ofQihFSnY6rxo5utCwbbYjie1kxTFCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212994; c=relaxed/simple;
	bh=N547kb+EDzrWedKEp0F4foA8weUWsuctW/SSslhI4H0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxLP9TOS2yAkcCIzYQ5Tcjm70Yez/5DK06yzrg/kLquMBDePI8/E/aIdHMde8CdTGnSkQOku+P3M14P1GKm5Q+bLIwRshVOdYdqj7Aj5toPLn6HRy79/BZAVCaSjDMrnn5xKa/DMOzfp2h9REud+/nAdltCTbp936j3ecW7KWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTeaLxeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1316FC4CEED;
	Fri, 11 Jul 2025 05:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752212994;
	bh=N547kb+EDzrWedKEp0F4foA8weUWsuctW/SSslhI4H0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTeaLxeXuAF9A79hastFo2SzBvR4ZWrW6bjDiYf65JUz8dTW2D6KZ35AEH8Sozzqz
	 sHHz2a4klDnV75wBvRZmvC5RurxKTFqfge8iVdYc4w0vTegjXUIJS3/+zBpUEm9wLU
	 kPl1EKvPYuz7OemngbV+M6v/JZyxGtV8j8Gzj8Z66vMOQgtSjL8/yZpIXw+dEHZrrQ
	 4tFIyXKTD1E2Xzzf2yRkH4gupP/N7vmaLiiuBaR/o612YBS48KlO+ESDikjdxiKe36
	 c5ejDiehZKTFOrmeKcdZT7qJd/HUOwA9pO34hb9PgsD2qjQ1dVHp/iO3uTLS0087LN
	 Ofeh0ypW0Jbjg==
Date: Fri, 11 Jul 2025 07:49:50 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 12/12] docs: kdoc: emit a warning for ancient
 versions of Python
Message-ID: <20250711074950.3e1ea8ce@foz.lan>
In-Reply-To: <20250710233142.246524-13-corbet@lwn.net>
References: <20250710233142.246524-1-corbet@lwn.net>
	<20250710233142.246524-13-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 10 Jul 2025 17:31:42 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Versions of Python prior to 3.7 do not guarantee to remember the insertion
> order of dicts; since kernel-doc depends on that guarantee, running with
> such older versions could result in output with reordered sections.
> 
> Python 3.9 is the minimum for the kernel as a whole, so this should not be
> a problem, but put in a warning just in case somebody tries to use
> something older.
> 
> Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index fdde14b045fe..23ac4ad204f4 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -12,6 +12,7 @@ Read a C language source or header FILE and extract embedded
>  documentation comments
>  """
>  
> +import sys
>  import re
>  from pprint import pformat
>  
> @@ -238,6 +239,14 @@ class KernelDoc:
>          # Place all potential outputs into an array
>          self.entries = []
>  
> +        #
> +        # We need Python 3.7 for its "dicts remember the insertion
> +        # order" guarantee
> +        #
> +        if sys.version_info.major == 3 and sys.version_info.minor < 7:
> +            self.emit_message(0,
> +                              'Python 3.7 or later is required for correct results')
> +
>      def emit_msg(self, ln, msg, warning=True):
>          """Emit a message"""
>  



Thanks,
Mauro

