Return-Path: <linux-kernel+bounces-819304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FF4B59E58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2DA16AFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7D30170F;
	Tue, 16 Sep 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EPXsIUKU"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12C301700
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041482; cv=none; b=nm/052R0VKsm7D7XRWQpD0FUVOTJ35OcnihsVZCoDah5zzCiAbhML8cFNClASxhwJiBnUejrg6RrdmfIKehip/zbl94QZDogh/mg5SBg/qt6wgGkWeCx1O+sq/M1nPd7Xb+d6P/pVK62V4lCABNrk+K1T8qej2a8vSmoOsq+mU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041482; c=relaxed/simple;
	bh=i9q6ZiO0AAK3YCRz9OrqbYrkpx9iJIBeOI2vbqRC7Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiYdg0oGOYUNTN/3lmEp8q9Kr8bSmuJhfOiKpI2XXW8GQv981fNymDfAjQxTO/Hc53JTChmxKs9S1dBJIwMVXVxB+h4Gkn9VQbsmoJqIUAWGJF9Jmb4RvsRdWHSdrNZBMHoO6eevfqgs6AUqNWpbt2gEbPQvcknYpzYGp6/XLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EPXsIUKU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <42f1c98c-1432-47bb-9203-e878f011ff6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758041475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xzv5p6owT6EL+wfHjq1N+1BcwT2xgrM1X7zJEAxZ9aY=;
	b=EPXsIUKUEYq5lC67bIQmYD+ru51kr4NDTFa4sGNgf33AHftf+dwJYPAqrklL6IeZRr3fn+
	cglopwl1EsJLZi9Tggm8VZcl/XyfY5pkGxMBd+bpxW+BC3Zy3CSKDXgWR0fGUqSpb7iCaD
	ZrJi5AwolL0OuAY3PQPYYuhOZL3/XLU=
Date: Tue, 16 Sep 2025 12:51:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Yeoreum Yun <yeoreum.yun@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Linu Cherian <lcherian@marvell.com>,
 linux-kernel@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
 <20250916160027.GK12516@e132581.arm.com>
 <a35e2d54-f1f5-4ae4-9daa-ae1f3a8a302b@linux.dev>
 <20250916164854.GM12516@e132581.arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250916164854.GM12516@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/16/25 12:48, Leo Yan wrote:
> On Tue, Sep 16, 2025 at 12:14:40PM -0400, Sean Anderson wrote:
> 
> [...]
> 
>> > Could you check if the drafted patch below looks good to you? If so, I
>> 
>> As stated above I disagree with a half-hearted removal. If you want to do that,
>> then I will resend v2 done with an rcu list and you can make your own follow-up.
> 
> It is fine to disagree, but please don't resend v2 :)
> 
> We have plan to refactor locking in CoreSight driver, I will try my
> best to avoid adding new lock unless with a strong reason.

As said above it will be done with an rcu list, so no new lock.

Or I can do this patch but stick the notifier block in csdev as suggested by Suzuki.

--Sean


