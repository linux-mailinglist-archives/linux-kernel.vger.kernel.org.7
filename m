Return-Path: <linux-kernel+bounces-858761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C36FBEBCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FA13BFCB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24832FB0AD;
	Fri, 17 Oct 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jyk5UvgG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25F354ADF;
	Fri, 17 Oct 2025 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735790; cv=none; b=E3qmDyp/5hLZpT8CgBQEFgOBK69NED4bsdvQRAxLiJk1+m+e7cYwkJEOYcNTZ7Z+ht7yn3oUZIdMAV4PxxmL9Y3ajyH3TMcZRq9U3Rim2+rBHdzPHXfNhvxekgzUZz4ZdWjHgehCanJnCCsQqXuf4KKzPzkWMAjF5ZtFeR3tv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735790; c=relaxed/simple;
	bh=WmUPzgLnBG1yK+phNKyl3NvrOgOJI6MjklB6JGxT0UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUsoHlvOaOFDD89+lg6+TCQkhOMR2+AdWFvXFuWelaFbC8kd/FPlcINrstegnIuuPevJW99vugg5AiOrzXo9/LsVK1JPYLizHl8TD16DnfYbNKn2a8Q+8Ski+EmV3RMweNsZNPqPZgN84sRR1PGzKAfN62C1bk1ollVP135fKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jyk5UvgG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=z/TSXdncORw86OBVqBrpLa3jhePghRL2wLGg8BR64rs=; b=jyk5UvgGnpqpJ22faaWu8az0jN
	fzsPqmx7CHPl0TvcAqhRedctBUOfw3YQc3NQMjBE9BaFjZM3uVTJrdJbSZT80SoIU9QWLHl9S4HHs
	qTIfJDhJsFfh4rjIzugu734xFhquJyyycElpMSE9GqGWflUI985CAtJHpss9tUGpLJ8Mfb5XtXqQu
	liy9R8qa+qfanQtfEs9LAVyuh56fMUbAHKpabwfMEsJyS8IidHtIeQQdzWyUukgnPTpn6EoFnE1sd
	jnjLJALpqdsPgrJTCkb215cvYc2lrCsoPYz7bD9PkIGVn+e0AQZC/ErBGTj+AEHw6vreEszq8JL34
	me9cR/9Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9roJ-000000091zh-0vcn;
	Fri, 17 Oct 2025 21:16:27 +0000
Message-ID: <e4eaf960-b21b-475e-955c-b40f0adbfbf5@infradead.org>
Date: Fri, 17 Oct 2025 14:16:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs: checkpatch: Drop networking comment style
To: Brian Norris <briannorris@chromium.org>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joe Perches <joe@perches.com>, workflows@vger.kernel.org
References: <20251017203719.1554224-1-briannorris@chromium.org>
 <20251017203719.1554224-2-briannorris@chromium.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251017203719.1554224-2-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/25 1:37 PM, Brian Norris wrote:
> Networking no longer has their own comment style, and checkpatch no
> longer checks for this.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

and for reference:

commit 82b8000c28b5
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Aug 19 11:09:43 2024 +0200
    net: drop special comment style


Thanks.

> ---
> 
> Changes in v2:
>  * new in v2
> 
>  Documentation/dev-tools/checkpatch.rst | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index d7fe023b3080..dfaad0a279ff 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -465,13 +465,6 @@ Comments
>         * for multi line comments.
>         */
>  
> -    The networking comment style is a bit different, with the first line
> -    not empty like the former::
> -
> -      /* This is the preferred comment style
> -       * for files in net/ and drivers/net/
> -       */
> -
>      See: https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
>  
>    **C99_COMMENTS**

-- 
~Randy

