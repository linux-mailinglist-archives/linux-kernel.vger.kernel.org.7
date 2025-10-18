Return-Path: <linux-kernel+bounces-859378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A8BED706
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8895B4E1B11
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5708F2571D8;
	Sat, 18 Oct 2025 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFaK/fFu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23321FE46D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810386; cv=none; b=mCK2Q5LbnCRWPYyOw8a3ebGqMSHG7cKNk3j+eZxopXmsrOvntwFuwyhj7gme9giCYOjc1l6N5Rik9CfWnhJ7XYue+6ZYl0v76erClDLuyW5zY9MeXb6ESOpNcnvwL5sEMVKh01Rb1+jUfIkgEEzifwAsPfvKxw3gjsIM3vX/MDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810386; c=relaxed/simple;
	bh=BbV03NsBXX5OJ9htFnHtVePUGG3rfU9XY/re9DAiuaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js/rTvCY+b6wYGkPpqiSmN8hgxLWfdxOzTEnv7JN5hErZeS0/M0XMQtNarx+DUY1fGgPy/eGdVeq5bpHjSKEYFMNHzDfyEeKT+5jt5dneOrIOXIA43KgbFe3DSPMRyU9Qku9WIEmkq19I0oPVnjw2RFe4YkqyAb3uo+hycqUHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFaK/fFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4A7C4CEF8;
	Sat, 18 Oct 2025 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760810386;
	bh=BbV03NsBXX5OJ9htFnHtVePUGG3rfU9XY/re9DAiuaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hFaK/fFu1J6TjJFYjVfXaPI0hOPdiGti95Nbs4owUH3M4QRMw4F6+z431BPZZXI0Z
	 KYsmhheTcaM4UL/e3Nirgobp7h6OWLCAbtpU8nuqD+siA1PohVt3r2nu0iNJ05vzHJ
	 HwceSOpePInSDjNKbQa/gJ4xGzjXTV88r4LpgO2nRWgQgSIGkbRAnVHR7UP+37C2pb
	 RNF2vWXjLLWkoTKYvZRasHSH0pcnt4sWSKWz9ugqh8TfR5078VCRWezFOBtv+ERomV
	 IJDyelyvwleqtkTU2QeJNVJbTtDHnAL1nRVioT+QCU5Lodei/HV5v7oeWvQ9YdBkoA
	 waQa8GDeViieA==
Message-ID: <e0d09eb8-a53f-4dce-a858-8852cf8695d2@kernel.org>
Date: Sat, 18 Oct 2025 19:59:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm, vc_screen: move __free() handler that frees a
 page to a common header
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Jackman <jackmanb@google.com>,
 David Hildenbrand <david@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251018093002.3660549-1-rppt@kernel.org>
 <20251018093002.3660549-2-rppt@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20251018093002.3660549-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 10. 25, 11:30, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> vc_screen defines __free() handler that frees a page using free_page().
> Move that definition to include/linux/gfp.h next to free_page() and
> rename it from free_page_ptr to free_page.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   drivers/tty/vt/vc_screen.c | 6 ++----
>   include/linux/gfp.h        | 2 ++
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index c814644ef4ee..d2029f029de6 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -53,8 +53,6 @@
>   #define HEADER_SIZE	4u
>   #define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_SMALL) ? 256 : PAGE_SIZE)
>   
> -DEFINE_FREE(free_page_ptr, void *, if (_T) free_page((unsigned long)_T));
> -
>   /*
>    * Our minor space:
>    *
> @@ -371,7 +369,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   	loff_t pos;
>   	bool viewed, attr, uni_mode;
>   
> -	char *con_buf __free(free_page_ptr) = (char *)__get_free_page(GFP_KERNEL);
> +	char *con_buf __free(free_page) = (char *)__get_free_page(GFP_KERNEL);
>   	if (!con_buf)
>   		return -ENOMEM;
>   
> @@ -596,7 +594,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
>   	if (use_unicode(inode))
>   		return -EOPNOTSUPP;
>   
> -	char *con_buf __free(free_page_ptr) = (char *)__get_free_page(GFP_KERNEL);
> +	char *con_buf __free(free_page) = (char *)__get_free_page(GFP_KERNEL);
>   	if (!con_buf)
>   		return -ENOMEM;
>   
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index f46b066c7661..ee3f27046667 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -385,6 +385,8 @@ extern void free_pages(unsigned long addr, unsigned int order);
>   #define __free_page(page) __free_pages((page), 0)
>   #define free_page(addr) free_pages((addr), 0)
>   
> +DEFINE_FREE(free_page, unsigned long, if (!IS_ERR_OR_NULL(_T)) free_page(_T));

This IMO breaks the build at this point, right? Makes sense after 3/3, 
though.

-- 
js
suse labs

