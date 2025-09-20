Return-Path: <linux-kernel+bounces-825877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C224CB8D028
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EA67E399C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E32A268C40;
	Sat, 20 Sep 2025 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gj+llbKW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C1227E83;
	Sat, 20 Sep 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758398569; cv=none; b=RiCvoLKB57qpPRgTvIvOVDmNtwkwQsJoO8Q6hvro3O4FEtH9NO7DxQrcG7I5OF2YBU1cymIbANdXwz0CS2i7fgMVwdFcm5CaEejH9tvzLZKJzt4wqW5r4p2yMR9kH0RA6AhSpZ2DxQFYyqD5WUHNXyL4dQw2yFsbUuJdjPGh6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758398569; c=relaxed/simple;
	bh=jW4mH194D7Tt5ZsbK/oaA8j5ZR9zgdUbL8JvqbOON84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/BPLXuzb1NsjyHxiWgz5L2iN25cXbeIQf1VFb38U0JvdjQ8s83Bnrj3NoJIACIdaROGasn3RMq5dlC5QpV4Ph+sDdjbQKsGH4CDp9tWq7ioEAMa/2/1L5sR0I6MJMMtZvFBnTUzPElAcS2mt2V/KtDUJtSLUhiGLh1Eg14kH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gj+llbKW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GTNIp+ffuoJXH+xJX7j5xcYPvd2FHtccv/wqvPEo9SU=; b=Gj+llbKWRw4IWzMQwskfrAn2J9
	d9SsgM1Gf4io7lzG8f3GDMgoPCCvNwa+v9fpoN9OrObZfNVcWEOimDCqYP95H1xtHIBX04WUzdjNb
	CRVxjwtFRhjBLAkKyB0QobBouAabbeI4n0moV7PbuCw6xDuMk/za1IlzhkMtqeFiydcOA1mDjNIYk
	cr63bcGwpJ153vS6RmDm74ned1d+1kHAwdipIOtG97umloelJh5eh1HB56xrOzfJ/6cyq9bsxk2SL
	KHmijsZOT/SasKKmFX+4vbNneGvpTJOp8O0lXCtlKGq1ZemOygSIsRLoPm6lHG3gHlCTnfsAlEReq
	WkL61a3w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v03nD-00000005r5i-2TdQ;
	Sat, 20 Sep 2025 20:02:47 +0000
Message-ID: <2456eb05-5697-4397-871c-cbc95bfab048@infradead.org>
Date: Sat, 20 Sep 2025 13:02:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation/process: submitting-patches: fix typo in
 "were do"
To: Yash Suthar <yashsuthar983@gmail.com>, corbet@lwn.net
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250920190856.7394-1-yashsuthar983@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250920190856.7394-1-yashsuthar983@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/20/25 12:08 PM, Yash Suthar wrote:
> Fixes a typo in submitting-patches.rst:
> "were do" -> "where do"
> 
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> v2: Resending patch as v1 received no reply. No code changes.
> 
>  Documentation/process/submitting-patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index cede4e7b29af..fcc08eb93897 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -343,7 +343,7 @@ https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
>  As is frequently quoted on the mailing list::
>  
>    A: http://en.wikipedia.org/wiki/Top_post
> -  Q: Were do I find info about this thing called top-posting?
> +  Q: Where do I find info about this thing called top-posting?
>    A: Because it messes up the order in which people normally read text.
>    Q: Why is top-posting such a bad thing?
>    A: Top-posting.

-- 
~Randy

