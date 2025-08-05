Return-Path: <linux-kernel+bounces-756639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FCB1B71F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF61625579
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D92797B3;
	Tue,  5 Aug 2025 15:06:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D652797AC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406391; cv=none; b=E6fPQ40pVnhSJVd053jspdEaDu8rN170zbzKCSMpy4BEOiubE+V3XEjnhKuQs1NuT0b7QH10oICMyL3VpbdEGXZjPLz2Ft4MlMEZR5QVxmiWJCtT6sad8JngaMpk7Erqwp0SxwCMLj56ctQrSJDzY/2r1SWp1Vi61qCh02y+Gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406391; c=relaxed/simple;
	bh=IRPnCmz2fWFDtS9q+ve2Qncui0/3hOtCgfw5Vn3B8b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=iSpnvtJhM7r4DOCEMTBg5DZ23w0FC5ov4oxRIa7AU4sDerwB5hW+4/s1bYKSH1CuMa//Qy/ufyLrVcU3WXR/Kz7t7GDY8Y4mcAsKRNAx7go/adEH8x8tEIxKdlE1W89uttS+TDpA3O3ZUm/xjbo2vb4Ruz02qOdRKigl/yIwNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74E5E2BCC;
	Tue,  5 Aug 2025 08:06:21 -0700 (PDT)
Received: from [10.1.29.177] (e137867.arm.com [10.1.29.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBD3F3F673;
	Tue,  5 Aug 2025 08:06:25 -0700 (PDT)
Message-ID: <b8adfbad-2a7d-47d4-a925-2f93c09cc414@arm.com>
Date: Tue, 5 Aug 2025 16:06:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 3/7] arm64: entry: Rework
 arm64_preempt_schedule_irq()
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-4-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, sstabellini@kernel.org,
 mark.rutland@arm.com, puranjay@kernel.org, broonie@kernel.org,
 mbenes@suse.cz, ryan.roberts@arm.com, akpm@linux-foundation.org,
 chenl311@chinatelecom.cn, anshuman.khandual@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, ardb@kernel.org,
 leitao@debian.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250729015456.3411143-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2025 02:54, Jinjie Ruan wrote:

> The generic entry code has the form:
>
> | raw_irqentry_exit_cond_resched()
> | {
> | 	if (!preempt_count()) {
> | 		...
> | 		if (need_resched())
> | 			preempt_schedule_irq();
> | 	}
> | }
>
> In preparation for moving arm64 over to the generic entry code, align
> the structure of the arm64 code with raw_irqentry_exit_cond_resched() from
> the generic entry code.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>


