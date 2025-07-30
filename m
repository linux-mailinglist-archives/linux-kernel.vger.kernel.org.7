Return-Path: <linux-kernel+bounces-751191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B077AB1663B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C5E3B69FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6432E11A5;
	Wed, 30 Jul 2025 18:29:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8F2E0405
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900169; cv=none; b=KGlWkZI5mA6O4HRYIYQyo9DUsaMrDkLO5Wy9Rx2m9mNdxI+vdqOw3kIpbuxJcXhTV7W25MVtaQVLnZdOm9/NA5Hseoi/OrQXkY1fHgTwfTAMvDkcCNlXJD7Bhvc041wbKHtShbXFaFs+JNLrIPhfNIO85GteMdTL4JI2GcCSL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900169; c=relaxed/simple;
	bh=CABo9Hc5J03jEKF2za1Qtce1ZRnA4efHREMNHOtujZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNYjP+h4iVenr15wL4ohlIhVFNbgCodfeL/IoK16cMU+GwdLfV5ORSAo9IDWa1awaN3EMd3KlgsrmGCz9T4mFfHBwOZokVEp3FgXkbRUHSUjynos76IGOTjKH9AjJILo93vmHMuHCcFpAQVJQAc6G4x7VS9oAhp43t5IJzfapd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ED1B1BF7;
	Wed, 30 Jul 2025 11:29:19 -0700 (PDT)
Received: from [10.57.87.181] (unknown [10.57.87.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6563F66E;
	Wed, 30 Jul 2025 11:29:24 -0700 (PDT)
Message-ID: <8f89490b-bac5-4297-a4a8-9e9c4a8f5ef5@arm.com>
Date: Wed, 30 Jul 2025 19:29:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>, Dev Jain <dev.jain@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com, mark.rutland@arm.com, urezki@gmail.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aIpPsg1Kij8Knnjl@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aIpPsg1Kij8Knnjl@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2025 18:00, Catalin Marinas wrote:
> On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:

[...]

> 
>> +	 * mmap_write_lock/unlock in T1 be called CS (the critical section).
>> +	 *
>> +	 * Claim: The CS of T1 will never operate on a freed PMD table.
>> +	 *
>> +	 * Proof:
>> +	 *
>> +	 * Case 1: The static branch is visible to T2.
>> +	 *
>> +	 * Case 1 (a): T1 acquires the lock before T2 can.
>> +	 * T2 will block until T1 drops the lock, so pmd_free() will only be
>> +	 * executed after T1 exits CS.
> 
> This assumes that there is some ordering between unlock and pmd_free()
> (e.g. some poisoning of the old page). The unlock only gives us release
> semantics, not acquire. It just happens that we have an atomic
> dec-and-test down the __free_pages() path but I'm not convinced we
> should rely on it unless free_pages() has clear semantics on ordering
> related to prior memory writes.

I can understand how pmd_free() could be re-ordered before the unlock, but
surely it can't be reorded before the lock? I need to go unlearn everything I
thought I understood about locking if that's the case...


