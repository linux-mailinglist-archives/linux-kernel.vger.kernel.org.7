Return-Path: <linux-kernel+bounces-887559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD26C38847
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05F71A22709
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3A1C5D6A;
	Thu,  6 Nov 2025 00:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="knNG+TDa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5A19D89E;
	Thu,  6 Nov 2025 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390121; cv=none; b=pW1nRQ46Zpdwd8Gtrd6w3Vv55IOjIgxinlNO/H/PhsBS4janasrYeoAHFVzFDEm/2EuZ9enDGcDPb4wwpmqsjtxv3xlEktrB5WEBKIijZj0bqp6ygRuCxqSJrB+/cp/yWplApktz6kxurZ0q3TioHMQSCf9hfwBbmgk2TtgzrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390121; c=relaxed/simple;
	bh=ofMeivP53QuCVBZGpy4m9dYlilxHAAHRdQP23px9lZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mx8xnYPUGCaKvKEfT/AxEboH43Jjn/T4+ldccU1RK1siwpW1sXGMvbf4U0RmATCfccu5iIHOM4B0lz8qhZHn8AVywFicU154MzTdiHS+Es6vSZG5+CV9NkNBjswUJtxbhzGswtntvRF9rt5oEuGJ5MMCoes3wKaQh75p8vDjDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=knNG+TDa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=t3trqbZvnpKuPDnyDXnsM2TfU5BGfVVFR5dv1baRrXQ=; b=knNG+TDa+bOfc34SamcxlM0QUk
	yLZFfeGqehhoR6dzwSMyfW3NqB4QlotDHNCMvLSmweRszKu9tKgdkX2cWbAQhParzvxDvQMn0OAk5
	KSnC6zGJP8FCG7oI4TFMKR/yoTcIql8AziPTuazhx9MZyVERKeiw8gpCfN4EYMw2R0E2reUdC5rJH
	S7WMEiWCbL363yJ7mza5SUIcnR1W3hl1YKm2jGv4osgY7WAttSkv+TllTfqCjZauJ4s6H8epIxoBZ
	nctvOug71TP45mILRGQP2Qg8OGuJMFiSgmk8GB+IgrUr779OTj4zuMe8x4V2fogyiy1zOqig8Dc8x
	zZmgAqIA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGoB2-0000000Ef97-3RPR;
	Thu, 06 Nov 2025 00:48:36 +0000
Message-ID: <e0b30586-3f30-4ec4-9231-51c4e1baadd3@infradead.org>
Date: Wed, 5 Nov 2025 16:48:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <20251105221907.0c8c388b@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251105221907.0c8c388b@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 1:19 PM, Mauro Carvalho Chehab wrote:
> 
> No objection of this one, but this breaks the behavior of the -W
> flags.
> 
> See, the way kernel-doc.pl worked is that:
> 
> 1. Warnings are controlled via several -W flags:
> 
>   -Wreturn, --wreturn   Warns about the lack of a return markup on functions.
>   -Wshort-desc, -Wshort-description, --wshort-desc
>                         Warns if initial short description is missing
> 
>                         This option is kept just for backward-compatibility, but it does nothing,
>                         neither here nor at the original Perl script.

FWIW, it did output warnings once upon a time (the Perl script version).
I don't know what happened to it.

>   -Wall, --wall         Enable all types of warnings
>   -Werror, --werror     Treat warnings as errors.
> 
>   Those affect running kernel-doc manually.
-- 
~Randy


