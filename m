Return-Path: <linux-kernel+bounces-861373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C05DBF290A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A5B64E1FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914FE32F76F;
	Mon, 20 Oct 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zFzUAYaV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC32609D0;
	Mon, 20 Oct 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979438; cv=none; b=qAt7rhvtgFUEOy/ZledQfq6kU0YDSN68Jbq+y35lDbAPLtAkp1XwuhsfFkbkg+G7LRWUivV+9Uo9AY/+Dkey5hjlaXaJLH8DJ9s+3Av8iC10YOgK7d/Pf9mWwa32MzXNieDWPcB+MSjo5ZH51lfvvRxKNKfQSacYvRfsGbq+M9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979438; c=relaxed/simple;
	bh=lP4t8YJJHqNeK+4r5rJ5YLhZknmCyXDPBSAoIvoLdzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CazYXuVy3PtDT9+qFP3DFMm3ZDzAc+lYFh0YigzUrm36ODSkgQSW0GAIu0bNkLJ2ifGoZPMoKrXlWUucqnrRvJWr7aliTW3f2NwuKANJHj5TDO/GKLGAYMs9v8S/n+gWSyYNbF/GVp6u9DbiItdGCL4UFz5cEDuO8LlTWPtLktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zFzUAYaV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NN8qfFOgZzkX1DrjZkg3eL33Ry1IX9buJ4v9zmNWoqQ=; b=zFzUAYaVo+zvWLqiVJCq1Sy4T9
	Py/9reyRhS9U2dBYeYa4P1J33My7ZV1xPaDY/pOhl0pzG3mfc/YcZy+9f+zOZssRPv3bJ55qAafve
	fk6xyduBJy+TqWIrUtUT7fU+ad19ENcaTkLji+ebMNjsX1dPjL34QwsbBO5Ut0mV4ubfVcOXKxiXR
	dVSy2Co/22IOeT3AlqZu6ZpMLt8l0TrsZJb7sfrcnrVLpgSijTEc9I06zGNuH0JNSbo63xVcYEwIC
	MUbZ0oTey5atD9m8y7h+qDngP5oN99OmzR0hMJLZm+P8lsQxrUXnEVTu6p7jg5qldJbHle8ZOFhfW
	Mh45Mu5Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtC7-0000000EOOZ-0Obg;
	Mon, 20 Oct 2025 16:57:15 +0000
Message-ID: <0b0d5773-e004-4e15-bf18-5cec59c02b6d@infradead.org>
Date: Mon, 20 Oct 2025 09:57:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ktap: Revert incorrect change
To: Clint George <clintbgeorge@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <ba148c36-8778-425e-8c94-35ebd708fc80@infradead.org>
 <20251020145334.65356-1-clintbgeorge@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251020145334.65356-1-clintbgeorge@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/25 7:53 AM, Clint George wrote:
> Thank you  Randy for pointing out. I am really sorry that i missed the
> incorrect change while creating the Patch. I have reverted the
> incorrect change in this version.

The above paragraph shouldn't be in the patch description.
It would be OK below the --- line.

This should be [PATCH v2] docs: ktap: fix minor typos in ktap.rst file

I'll let the maintainers decide if they want a v3 from you.

> 
> Fix couple of grammar and spelling issues such as:
> diagnosic -> diagnostic
> Cuurently accepted directives -> The currently accepted directives
> 
> This patch aims to correct these issues and enhance the existing
> documentation.
> 
> Signed-off-by: Clint George <clintbgeorge@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/dev-tools/ktap.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index a9810bed5..faaad92e6 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -13,7 +13,7 @@ which don't align with the original TAP specification. Thus, a "Kernel TAP"
>  This specification describes the generally accepted format of KTAP as it is
>  currently used in the kernel.
>  
> -KTAP test results describe a series of tests (which may be nested: i.e., test
> +KTAP test results describe a series of tests (which may be nested: i.e., tests
>  can have subtests), each of which can contain both diagnostic data -- e.g., log
>  lines -- and a final result. The test structure and results are
>  machine-readable, whereas the diagnostic data is unstructured and is there to
> @@ -94,7 +94,7 @@ keyword preceding the diagnostic data. In the event that a parser encounters
>  a directive it doesn't support, it should fall back to the "ok" / "not ok"
>  result.
>  
> -Currently accepted directives are:
> +The currently accepted directives are:
>  
>  - "SKIP", which indicates a test was skipped (note the result of the test case
>    result line can be either "ok" or "not ok" if the SKIP directive is used)
> @@ -237,7 +237,7 @@ Major differences between TAP and KTAP
>  ==================================================   =========  ===============
>  Feature                                              TAP        KTAP
>  ==================================================   =========  ===============
> -yaml and json in diagnosic message                   ok         not recommended
> +yaml and json in diagnostic message                  ok         not recommended
>  TODO directive                                       ok         not recognized
>  allows an arbitrary number of tests to be nested     no         yes
>  "Unknown lines" are in category of "Anything else"   yes        no

-- 
~Randy

