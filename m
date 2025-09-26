Return-Path: <linux-kernel+bounces-834479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFA8BA4C73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4399164A48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFAE2727E6;
	Fri, 26 Sep 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ai5tru/0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DB42AA6;
	Fri, 26 Sep 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908196; cv=none; b=j6S+l3rBLAWQCZTy/w2cgbVGzrkktjNEnl5poqkfxG8TBmOlHrWrVRQqQjyGL36DT0xhuoY2811Hr27p6L7U7g/QAqWE+aIaq0pWxIy/PqkhCmL0iQTWCtKhU9s9BtgmbqM4yQvZYmwDlNfliQRepMYAXOs9BdGAvnfJ+qdS61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908196; c=relaxed/simple;
	bh=ibIe6cCzV4z11ihNj6Ebgclqfn56yjxXANW665UotDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1Dp2bFo5qo75aIBvHJya7lDC1fwTNVqOgH/Am6/39uXir709WjoeQDBYL4pOC0QCiy1eimRNRaxxCOHzNjJT97+obQe6ISRHu3+obJGNCKhhHnsegWDXMcC03V+FEmTH+pmTLUGPVayJDaE3Jcp0mffVQD+4V9l+bX4NTscyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ai5tru/0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OQfOZJJeZJ43T8rPODpG16r6wiKTQshx2hI8W8/pfZM=; b=ai5tru/0HB5WJww4P/BAb89ISI
	Bifx6Iz5YNLWdnw1Mu3lDsgoTDxY6Jb4dwpI87RZuWIBT7g+mh7bN+s9lf8+119JsJjCcAXdjAM5t
	40et7tTicBeJjqpvTq5gjz0+Zcc5vWCAP1+OJU8nDWgWU4ScS85r2zbjhEs4cag3N674z3McFvNGr
	EkeEwwFOFRQXRxfIDUlTLR+JwNBH031jgY0ndb7EbO7Y4qxePOV38qJl6gWSvS/k7gJb7JUv5Bu+z
	+I2m9gXSl5fWPL7lfq3ne4ZyLS4UJJ+P43dWByc4dlGj0YyHNRSFQzWh9cwoBXoT+zmFtTIESjhHK
	IFlNSCIA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2CMv-00000003HEO-2uTj;
	Fri, 26 Sep 2025 17:36:29 +0000
Message-ID: <44f3bd7c-b32c-420e-a738-02f40853e472@infradead.org>
Date: Fri, 26 Sep 2025 10:36:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: fix spelling, typos, grammar, duplicated
 words
To: Markus Heidelberg <m.heidelberg@cab.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250926095312.206231-1-m.heidelberg@cab.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250926095312.206231-1-m.heidelberg@cab.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Markus,

On 9/26/25 2:53 AM, Markus Heidelberg wrote:
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
> ---
>  Documentation/bpf/prog_flow_dissector.rst  | 4 ++--
>  Documentation/fb/fbcon.rst                 | 2 +-
>  Documentation/filesystems/path-lookup.rst  | 2 +-
>  Documentation/hwmon/lm75.rst               | 2 +-
>  Documentation/kernel-hacking/hacking.rst   | 2 +-
>  Documentation/networking/phy.rst           | 8 ++++----
>  Documentation/process/management-style.rst | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)

These changes mostly look good. I'm curious about how you
found these. ??

thanks.
-- 
~Randy


