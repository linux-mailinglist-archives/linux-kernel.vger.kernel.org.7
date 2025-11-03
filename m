Return-Path: <linux-kernel+bounces-882275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CB2C2A0AA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D62188FCB8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45018145355;
	Mon,  3 Nov 2025 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="seNlBSJF"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D738D;
	Mon,  3 Nov 2025 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762146555; cv=none; b=uUqIi1ycUx06LhWjHiKOn8nnk2X52YY1ocv4MB3MVb/Noam6kwSHoQ65xBb5BCaFKIMumoMhZh9SQdIV8Z/NMFXX6/yIlzcOucP6Gu/FD1+JYXCqGFTdTJ0EEspyrbH0eZ8NGE0CcG1b2ckWSIP7HHgIhkiXNNiXGL+LnJO2HUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762146555; c=relaxed/simple;
	bh=Aui+uXq7gBynAr9OBN/unPwWy+rKwHXmZxOQwQjcSzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PP6Q/bT6dHhdwXsn3Um69qzxbgf2MM73nxJSzJWp8Nx0hAxS9zJHX/cKW7EMnaEJYXXHB54UcIBxd8rqEzwfNgYI8RFVtke2aNFWsl7NkqhHnNkO/abSWxn0DnT1UOsIcir0R3K4kA/VDYalBIOvU6UiJdR951VgyZzJjn6QcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=seNlBSJF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9CiYw9yFrowi8FxrR/WFrKpp3eBVwHxAvWsrtAh9fI4=; b=seNlBSJFHEezyitQv6z+olvmyo
	EPMegIFMNPgy5I/RTxrlSXZUc2wQgDj+pF9KuS8Ksnk/aySuDF0Gkc9hJ1dYjQ409FYLrBG+C33fx
	PsNz9WrI9II6osO5ARTj0gVNlRV7A7VvNluDsr9Nh7kAfA8SGhDjXxhhamvwh/B4rKA0XlkZ5enEk
	L2qAOKsZgo8MB9qvGHa7whWxQPrCEmbmZyzW4ywqYp6U8lQ5QKy4Wam7CAppE52Pgs0ksh0rLYOBW
	ydecSD376h0T30Li9S36z5+1vymwFz6sgAwe6GDSyC8AKESpa+XpKK/qhclkHNI+7nLUXjWWZTjiv
	W9aLJLnQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFmoZ-00000009DC5-16XH;
	Mon, 03 Nov 2025 05:09:11 +0000
Message-ID: <33ce66c4-d128-41d5-9e26-aabb7e80aa67@infradead.org>
Date: Sun, 2 Nov 2025 21:09:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: pldmfw: Demote library overview section
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jonathan Corbet <corbet@lwn.net>
References: <20251103030228.23851-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251103030228.23851-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/25 7:02 PM, Bagas Sanjaya wrote:
> pldmfw library overview section is formatted as title heading (the
> second title of index.rst), making it listed in driver-api toctree.
> 
> Demote the section.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/driver-api/pldmfw/index.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/pldmfw/index.rst b/Documentation/driver-api/pldmfw/index.rst
> index fd871b83f34f3a..e59beca374c1fa 100644
> --- a/Documentation/driver-api/pldmfw/index.rst
> +++ b/Documentation/driver-api/pldmfw/index.rst
> @@ -14,7 +14,6 @@ the PLDM for Firmware Update standard
>     file-format
>     driver-ops
>  
> -==================================
>  Overview of the ``pldmfw`` library
>  ==================================
>  
> 
> base-commit: e5e7ca66a7fc6b8073c30a048e1157b88d427980

-- 
~Randy

