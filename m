Return-Path: <linux-kernel+bounces-799989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14981B43214
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25CC165B87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAD0248F5A;
	Thu,  4 Sep 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t/voUSzS"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF771A23A9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966389; cv=none; b=gjKZi8pTTiEF8XIVX2syeWGfBcb3WQfxMc6V5wPtiXVSBxfVUN05L5lhLJpcB+wS1QFfOSj4gUppKMBE5dZtUeWITZcvaSbHSsMI8lkPPz1xOmL/uL4pQAoq8jyMhPZOV+mZjnVyxaicxi2UvzS0DUewuL4+4ZR9smOLoaW+GsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966389; c=relaxed/simple;
	bh=8QwC0ZKYJXado70luU4Przoa3K2sG5UAhVy4DFqCMX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhvosRV23Q/I4wIrnDJNfOcArHT6DIbZ8K0ywLfNCi+tU7R4u9IhU1qKXLv0+7VkiVzbweaE5KzPB5lZCeXxuR7IgQOvmLoedUniVc4vqUp3R6M3l9nCBec4WQy4n0L61AfaxM7ZvA2GAL1tnzuK7vLJo9cEfg8OgH92+PLXosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t/voUSzS; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756966379; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sl+7sZlPHAR/h3IM776vMLfUaeHGIeBuokgV+a09Z8I=;
	b=t/voUSzS6y1GV4BwqlZ9czLyQTrOI6vvtZGGECwuI2md6Hcbyg77rWdA5M39IFkoouszcwvwSIUPF7dSslhtwGp/aj6j2V6FsadilFNIOzkzb5B7XZb7zvcqW2DIUSOAfrOU4DftzEac9NdquFageM2Hai7UHU9Ni/Y6vhIo3gQ=
Received: from 30.74.144.113(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnEblbM_1756966376 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 14:12:57 +0800
Message-ID: <28381bf8-f278-4b4e-b7eb-b3525e98f050@linux.alibaba.com>
Date: Thu, 4 Sep 2025 14:12:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: Drop all references of writable and SCAN_PAGE_RO
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 kas@kernel.org, willy@infradead.org, hughd@google.com
Cc: ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903054635.19949-2-dev.jain@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250903054635.19949-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/3 13:46, Dev Jain wrote:
> Now that all actionable outcomes from checking pte_write() are gone,
> drop the related references.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

