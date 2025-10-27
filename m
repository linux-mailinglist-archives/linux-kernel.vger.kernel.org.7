Return-Path: <linux-kernel+bounces-870874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E70C0BE13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9F818A21ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A92D7DD7;
	Mon, 27 Oct 2025 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zNqDoACA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332F2D77E3;
	Mon, 27 Oct 2025 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544557; cv=none; b=C5gk35eQ+O1WDUMckeOsSxfaegZnWw8uminmY9WCpd8dgjudAVJmDsJmONGrtv1VZcqHtFAAMwIW3TgOf0IdRSxvM/ngq0ha5xT4JR5x1u/wtPqEUqXJcFbwBeRr7X5sdSyVYkYn2K228ke0a0FA4xWHmjdt7o9rYz+tbeN8oDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544557; c=relaxed/simple;
	bh=ybYmKh8/39nPxjAAy3oM4Wv0m5D7zdqQ/h0WxF4fTI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAPJgV9ky1RFplWxIRoVVdsTkUSyJbK//4ahZ3AGYMX0D18rCgpRuMJY/g8kPh/iZMMfOrKZRthG2PWUyMLL0AKJyCzc+dHeSTc/PGmgiWPMnbKq1eHOgSKUih211XEIQuu0zrceRN06wQOZDb8QTdpj4YMPgzD+sgGLEYEvDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zNqDoACA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=2PSjt9WH+pBseVt0UIOQSGXPv18u2Yu6JU4vrx0TYeU=; b=zNqDoACAEhpf9GVKEy365h9/91
	K9bcBF3iL/OTLZjAWzZHocKS9YTocNfXJLJEAOd5vGTUc1YlnvjraZCeA7bs1kAF2X60YgDwbKYtc
	Bqf9F90iYEpLUvXaTV2uAWajYyxWOSi3imkHYd+uFQkVCf4Xa7vVjTAX590y1Nwp9yvganhAUTIAL
	SrwZpcTKy2glw1a4Hv/m5uL7ieLatNzVswCm691WIMdtQWgYRCKBpMlKNHyr2yC1SRrBl5USnWpj5
	MxBzNTNe+Rkr63YgalmMfiY3ctTTVpZqvZTWlTHa7pq1UHsutDJZ3tpEaiAswLIDbVWNcHa+TzlIm
	RSWaRwsQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDGCu-0000000D9sQ-3p3F;
	Mon, 27 Oct 2025 05:55:52 +0000
Message-ID: <766767b3-946a-4ff1-ace6-b7889ba296ae@infradead.org>
Date: Sun, 26 Oct 2025 22:55:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Makefile: Sort Documentation targets
 case-insensitively in make help
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
References: <20251015012922.19467-1-bhanuseshukumar@gmail.com>
 <47844424-302b-4a99-9cce-82924c7b7ebb@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <47844424-302b-4a99-9cce-82924c7b7ebb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/26/25 10:27 PM, Bhanu Seshu Kumar Valluri wrote:
> On 15/10/25 06:59, Bhanu Seshu Kumar Valluri wrote:
>> Avoid case-sensitive sorting when listing Documentation targets in make help.
>> Previously, targets like PCI and RCU appeared ahead of others due to uppercase
>> names.
>>
>> Normalize casing during _SPHINXDIRS generation to ensure consistent and
>> intuitive ordering.
>>
>> Fixes: 965fc39f7393 ("Documentation: sort _SPHINXDIRS for 'make help'")
>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
>> ---
>>  Notes
>>  - Patch is tested with make help command.
>>  - Verified case-insensitive sorting.
>>
>>  Documentation/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 3609cb86137b..00c81e7947a9 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -23,7 +23,7 @@ SPHINXOPTS    =
>>  SPHINXDIRS    = .
>>  DOCS_THEME    =
>>  DOCS_CSS      =
>> -_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
>> +_SPHINXDIRS   = $(shell printf "%s\n" $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)) | sort -f)
>>  SPHINX_CONF   = conf.py
>>  PAPER         =
>>  BUILDDIR      = $(obj)/output
> Hi,
> 
> I just wanted to check if you had a chance to review the patch or if any changes are needed from my side.

It's OK with me and it works.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

