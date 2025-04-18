Return-Path: <linux-kernel+bounces-611250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC45A93F55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 23:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D597B4660A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E5222FE11;
	Fri, 18 Apr 2025 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e8TIgeUj"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC432868B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010707; cv=none; b=beeL47R55YUl1Vl1NybrYb0/ikgSe7FI7QMV+b9xVOzPOZpuu7Dmf5uvlXZOd9wCC3E9XW//G3nOMDHBRJQ5Muj3cGvpl/l7UQ9i/BcuRmZCX3Q7nt2L5+fkj7DwURcqSHa/aTsainnltidk7WFIZ3RwKd5eqY0pMgZK3LCTiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010707; c=relaxed/simple;
	bh=H93/9GEFcjpvx1qy3qGsiFgA/EU8Rjuh7rXPxSjJMWQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n/kVEj8HUM024AzKAUWTx+vC0YH0BdsDA36EtJ/mklh2ndybWXNvAXjj+uTXYy9lgO2GNw1iT0KIb6MwhlVI2ix8w0eMXnNhM1WHFCq0yW8+TFzgW79G8SfmTSUhF3qEmHn8vNZ29pJLqTrXUqLl+0T/Q8SsyzynDlFnJyoRH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e8TIgeUj; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745010693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEfMZCJYJjq1p4pMLitVHU5aT6JAbeH5Z6gnYZpSYvY=;
	b=e8TIgeUjloX/9YtfWIhZ2Hat9l+yQwz4p/UeVvSMr3FDLbr2u77redq+cxErM7p6AVAjVb
	FdS2iO8MOJ4jF1UmhYn260xhbKIuRM2Fe83NQ2cVNc2KzrirICeF6wsYgIZ4hJ4yq8gts7
	iOi+B+zHAsG8sSa8Uov17vDmSwE38yw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] smp: Replace deprecated strcpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202504181322.5D3B93E93@keescook>
Date: Fri, 18 Apr 2025 23:11:20 +0200
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-hardening@vger.kernel.org,
 linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <ABD8884A-36DF-457C-83D4-49F4F63C339F@linux.dev>
References: <20250417192054.69663-2-thorsten.blum@linux.dev>
 <202504181322.5D3B93E93@keescook>
To: Kees Cook <kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 18. Apr 2025, at 22:23, Kees Cook wrote:
> On Thu, Apr 17, 2025 at 09:20:52PM +0200, Thorsten Blum wrote:
>> strcpy() is deprecated; use strscpy() instead.
> 
> Are there more strcpy() uses in arch/alpha? Maybe do all of them and
> give the Subject prefix as "alpha:". If not, the "smp:" prefix is likely
> to non-specific. Maybe "alpha: smp:".

There are a handful left, but they're not as straightforward as this
one - so I'd prefer to keep them separate.

Could the committer change the subject to "alpha: smp:" or should I
submit a v2 just for the title?

Thanks,
Thorsten


