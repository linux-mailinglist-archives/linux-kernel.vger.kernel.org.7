Return-Path: <linux-kernel+bounces-898421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05517C55421
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4D24344CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274982877C3;
	Thu, 13 Nov 2025 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WmuypgvH"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F748264638;
	Thu, 13 Nov 2025 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997496; cv=none; b=exryGQYWrixI3nzjNw8a7wkYXWIV7p/EraspfJziz7tY19kxDKs3o/qoUmpITXtNEvLRj7zoq87Qu+q3Vg0T0LUP+obZl+0jvobi+cZdkobcuf0z5AhRCyTpxrNvomCoeq1XI23Fv17Gg6CrbWlkPuiBDdthC6otW+fwKPUITao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997496; c=relaxed/simple;
	bh=ryGkllMbqj7qBHYcr1wgNdazkSY7bg8IQDrKElhDblI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oEies4RBFrnaZojGngf2BrCGVqPCqGVjUE7xRgEZRw8v9w+L98zalspRVZ8x945UCCGFC2rtD2oQqx7Inkn60cKR+F+BVQHbHy6zEN62Zb32F/sDZygdJb+PJCYCNBErL8oONr09EAhuiu/JBbwHJhafc/DPVTPxNn3hqk/mhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WmuypgvH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=Qdb6cmTzMYAcnFLIkL/oulW43LiqvNLplY/sWh1QN7U=; b=WmuypgvHbeSc/FAoPa0QU8ZzT8
	LteqXC+WAgxXI3ubjLUSxW9qKLeX66FobOyVYbhDxpmsXw5+JJeDkIlfhUrqMZl8Oz2DAx3FQhyRu
	jhubvZtBiqzORaGKh8c+7oqXuNtEIkmuEgIIW7CFiMwHMzwVYV6gwVztFLUuOJyDa4RXKTiFED4Nm
	W13kv7KmZv1rE8fyLi89/WHH9cOJwW2mWcSvkh7mVtNmKqPONK8d5Ny6Cw1bVoy489ln0s/VrK8XJ
	+VqTqcWNnFmgaOeBtZL6azQXnLZYNfqMzRFoSp9hMPkwCCQBAP/DGinP7ldPwlempV6cLodZiTgeQ
	sSmNSd/w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJMBR-00000009iwg-2b8L;
	Thu, 13 Nov 2025 01:31:33 +0000
Message-ID: <1a1b0c88-e610-4851-a01d-ff16d472cb6f@infradead.org>
Date: Wed, 12 Nov 2025 17:31:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH] scripts: docs: kdoc_files.py: don't consider symlinks as
 directories
To: mchehab+huawei@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
 linux-kernel@vger.kernel.org
References: <20251112171452.Y5jX9%mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251112171452.Y5jX9%mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[all of my copies of this email had header (at least Subject:) problems]


On 11/12/25 9:14 AM, mchehab+huawei@kernel.org wrote:
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
> 	Jonathan Corbet <corbet@lwn.net>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
> 	linux-kernel@vger.kernel.org,
> 	Randy Dunlap <rdunlap@infradead.org>
> Subject: [PATCH] scripts: docs: kdoc_files.py: don't consider symlinks as directories
> Date: Wed, 12 Nov 2025 18:14:49 +0100
> Message-ID: <73c3450f34e2a4b42ef2ef279d7487c47d22e3bd.1762967688.git.mchehab+huawei@kernel.org>
> X-Mailer: git-send-email 2.51.1
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
> 
> As reported by Randy, currently kdoc_files can go into endless
> looks when symlinks are used:
> 
> 	$ ln -s . Documentation/peci/foo
> 	$ ./scripts/kernel-doc Documentation/peci/
> 	...
> 	  File "/new_devel/docs/scripts/lib/kdoc/kdoc_files.py", line 52, in _parse_dir
> 	    if entry.is_dir():
> 	       ~~~~~~~~~~~~^^
> 	OSError: [Errno 40] Too many levels of symbolic links: 'Documentation/peci/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo'
> 
> Prevent that by not considering symlinks as directories.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-doc/80701524-09fd-4d68-8715-331f47c969f2@infradead.org/
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  scripts/lib/kdoc/kdoc_files.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
> index 061c033f32da..1fd8d17edb32 100644
> --- a/scripts/lib/kdoc/kdoc_files.py
> +++ b/scripts/lib/kdoc/kdoc_files.py
> @@ -49,7 +49,7 @@ class GlobSourceFiles:
>              for entry in obj:
>                  name = os.path.join(dirname, entry.name)
>  
> -                if entry.is_dir():
> +                if entry.is_dir(follow_symlinks=False):
>                      yield from self._parse_dir(name)
>  
>                  if not entry.is_file():

-- 
~Randy

