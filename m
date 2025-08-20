Return-Path: <linux-kernel+bounces-776771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B2B2D151
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFAF4E480E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0C1A9FB2;
	Wed, 20 Aug 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tYqB962O"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11C194A45;
	Wed, 20 Aug 2025 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652834; cv=none; b=oRmPWgXnB0z/9obKifgXzXixp9J8Ki2oGwVHfFzEeHXbqM1EenHRKDHO1/MWN2d6y+SmiAOMd2FnFDPu8r2w8QFfoI2R6v5ZkZstrFELIwbErzfpYGOf77nJsAuHw/v0Lp3/XNAync3+f01yF5r8asJJLqLgDh26BR78W00AaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652834; c=relaxed/simple;
	bh=svWzG9sF031XyKJb72JtwTqDoEzVn7DJp417oOQkgMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHkIXPQs5SFy/IZuH+zmk6Wq6zDa+aOBL+2/ACeiUpg3vmJuioCNsZe2/IUIU4M7LBqTbBf65a5WLtMPwWfhXgdfY/q/FRRfXv6xMIwL+5n8BlaeP1n1ylExC9z+n/aUl1LZTfdiQVtc29MProoGol0Mm23yIJ29Nb1wifBokaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tYqB962O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tuR6rPmIqpc8DdqsUiEd4fLkPe8oIAaXR6ncnw2kdj4=; b=tYqB962O0mDQXwvZLSAplvyIMi
	ZNTlcMg22fy1nCKIlFOGM6hrrAyqM3Wp2/0WfSYjjmGACI8SR3dmGkkMFhbEsPqK1Zhb+PVGoPgHf
	5eUexB9ePTVZfR2MhnqxM/vkCQ2lEtJz4RawtpFMrIn1DTgUaa0lPQy6NSTtFkgnwUgy2HUKV+X3Q
	ShxAytFT3gT+eT4jCYuvrkFJE2piSjlqg3sB85B7VqjmV26U8Cxcx1H10HOV2KUJROwDkQhJ4FXIM
	7hbmhxUuPzphBghtmnvcy7MuYTQFyg/XL04YIRS5mRVcUXQC4rOVJ7hSDW6uZ4GU/M5FMnHBT5LLF
	uAIYhf4Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoXVA-0000000C4bD-1ZDo;
	Wed, 20 Aug 2025 01:20:32 +0000
Message-ID: <bc5d5208-4dd1-4eaf-9c4a-76020ec3c959@infradead.org>
Date: Tue, 19 Aug 2025 18:20:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix typo in RAID arrays documentation
To: Vivek Alurkar <primalkenja@gmail.com>, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250819225034.8739-2-primalkenja@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250819225034.8739-2-primalkenja@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/19/25 3:50 PM, Vivek Alurkar wrote:
> Changed "write-throuth" to "write-through".
> 
> Signed-off-by: Vivek Alurkar <primalkenja@gmail.com>
> ---
>  Documentation/admin-guide/md.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
> index 4ff2cc291d18..8b9866cacb87 100644
> --- a/Documentation/admin-guide/md.rst
> +++ b/Documentation/admin-guide/md.rst
> @@ -758,7 +758,7 @@ These currently include:
>  
>    journal_mode (currently raid5 only)
>        The cache mode for raid5. raid5 could include an extra disk for
> -      caching. The mode can be "write-throuth" and "write-back". The

preferably:                                        or

> +      caching. The mode can be "write-through" and "write-back". The
>        default is "write-through".
>  
>    ppl_write_hint
thanks.
-- 
~Randy


