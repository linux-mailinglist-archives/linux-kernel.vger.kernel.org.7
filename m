Return-Path: <linux-kernel+bounces-876513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E74EC1BEA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537F466495E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC9D329366;
	Wed, 29 Oct 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAG9uV7r"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DB937A3B9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751596; cv=none; b=AG67nudDg3Fs6k4kUsGNN14n7pKBbWVq6MyH87sgg1meSjjVz1/BtsumAo4cJ9qKbzrOh9GXuR/kGLiaXvGinAvNtpfTX/ypALRwNRNrQ0tbRc7573UQknybkt2748qoCxG2YsPb9wyvM4ag6oJXGDkgCHr2OVVmBFvBydoerK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751596; c=relaxed/simple;
	bh=qUR+hDDWpejQz7ESuFKyw5/nsFtMbXXE4NZ+Qw9YtOo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iHhu/r2S6UlwTLT361N6vT6Unu0nQ0tonQHncfziXB8ntBEYfi9qc89Gzy4djC980jiysZydDt+CDw0WJLBPIqdHJN8L2qjd40v9buBTgTHkHeZAjT0tuc2/7kWg5CkUVi1nNVMz1bGwqhm6lOvw+ADdUpZ5HynDAC5IpsZ5NZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAG9uV7r; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761751592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1mXWPIcGefnfukfWZLsSmr02dQQl+Vz8q3ce3a+7ls=;
	b=SAG9uV7rrXDHzqz3opK37YbmQQoONwmJBzaDmeHlKXtmF4Mmm8YzzBXzAZoT0u60zdK2kG
	lDXwXjZpG9Tnrq6p5fR5ioEltOKUHF0f0dsis7ROJHrmlAmy/jPT7wyHGi4umbH9CgeRss
	sUz25zcZyGkcHG+pwyCAaCXvEjBmVHg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251029130045.70127-2-thorsten.blum@linux.dev>
Date: Wed, 29 Oct 2025 16:25:59 +0100
Cc: stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <DB14BF54-DA19-408C-8D0E-65279AF19282@linux.dev>
References: <20251029130045.70127-2-thorsten.blum@linux.dev>
To: David Laight <david.laight.linux@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Huisong Li <lihuisong@huawei.com>,
 Akira Shimahara <akira215corp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 29. Oct 2025, at 14:00, Thorsten Blum wrote:
> The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
> bytes and a NUL terminator is appended. However, the 'size' argument
> does not account for this extra byte. The original code then allocated
> 'size' bytes and used strcpy() to copy 'buf', which always writes one
> byte past the allocated buffer since strcpy() copies until the NUL
> terminator at index 'size'.
> 
> Fix this by parsing the 'buf' parameter directly using simple_strtol()
> without allocating any intermediate memory or string copying. This
> removes the overflow while simplifying the code.
> 
> Cc: stable@vger.kernel.org
> Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

I should still add overflow detection to simple_strtol() to match the
behavior of kstrtoint(), but please let me know what you think of the
current version first.

Thanks,
Thorsten


