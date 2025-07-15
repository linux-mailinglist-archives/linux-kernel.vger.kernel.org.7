Return-Path: <linux-kernel+bounces-732334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F48B0653B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D447B56E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C595E1D79BE;
	Tue, 15 Jul 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MaCN7NZy"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DA284689
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601002; cv=none; b=mOjDq/FFTYKg/2CyaUGPZlnH+PoxqWazdZAJNW+KFxapVkyGApeDWSX7Qg8sn0LQ9g4qhdgSSyLmJf6oBeNiVKRhJBu4iVLoDhSjhaoPim8DXpMajlz22XRJAX9oyP9gi296sA/oPauzqpCTstLixeXSaMkIkVPOHNtezP0Enuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601002; c=relaxed/simple;
	bh=KGSPFtIqXmGx0OaYyj8XsqCNHf5Y2xDMcatgKgJfTnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXON0UsnWTJM9lv1+aJeqWXPHt/EL+GlQJpzFKP2Id0Ipd0QsIhbvwXHT97EG/iAODW72FP+YZuzwA7rjojZp4DjobW429cM3zfIlFuC1B5snegn+pAWtMaFfh6do9SzRqA1vRcVHQ8BBbBSZdwOy8wfN780rokko+LJI2v/lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MaCN7NZy; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7225a8ed-8502-48b5-a39f-870b444d069c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752600997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEKQAob8hvUtnRt3y2HHuyX5JTS4CeKZwqn3nHlvEt0=;
	b=MaCN7NZy1NqKSo0XHlUtlrUh8yzVjV4cIKuWSHIDuF3k8NbmpZ+zY3rn4rWDBNzFVDwXiN
	Ii1srrrpkG+FykYtBq8sN1dd8LWrkV119uLMNvtH6AK2+7tgtN5ze3ZmhodggPnd3EVDPC
	RncYZKvvzBZpyKLJgPrHD5w/4R5s3HY=
Date: Tue, 15 Jul 2025 13:36:33 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] math64: Add div64_s64_rem
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-2-sean.anderson@linux.dev>
 <aHYLYT57eF6UhLvC@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHYLYT57eF6UhLvC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 04:03, Andy Shevchenko wrote:
> On Mon, Jul 14, 2025 at 09:20:17PM -0400, Sean Anderson wrote:
>> Add a function to do signed 64-bit division with remainder. This is
>> implemented using div64_u64_rem in the same way that div_s64_rem is
>> implemented using div_u64_rem.
> 
> LGTM, but one important Q. Can we (start to) add the test cases, please?
> 

Well, this just calls div64_u64_rem. So I am inclined to make the test something
like

#define test(n, d, q, r) ({ \
	u64 _q, _r; \
	_q = div64_u64_rem(n, d, &r); \
	assert(_q == q); \
	assert(_r == r); \
})

test( 3,  2,  1,  1);
test( 3, -2, -1,  1);
test(-3,  2, -1, -1);
test(-3, -2,  1, -1);

--Sean

