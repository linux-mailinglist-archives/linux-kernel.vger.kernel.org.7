Return-Path: <linux-kernel+bounces-807120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ABFB4A05A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5381BC7495
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED782D7DED;
	Tue,  9 Sep 2025 03:50:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D329F256C9F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389837; cv=none; b=H3JPddfqnClgiycEpsMxA51i4gTvhrTDX3xlw1EATwTcQUTsKec+3ceQBtBNYzeHo0ceqeQtjjTEPQe+DN7hPUVKg+VwSVK0Oan03U/Izx2VOxEcO97EF5Ewm0yZC0jnIEFSbejooR/eEF/xCTijG0L7BhYRlN/i76KbdNqZTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389837; c=relaxed/simple;
	bh=gez7hgmHhKk3TpTb7upQbshAJv74HU7e5+XOLHsTNwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OocKSFYygjEASYmVaT3niXzHJXkiVt9wkYg1UGSgDnBwjCXK1P6fqT120P9cTdArHCfdYEGNtVEe3Xfopm28qUvzoeyxhqUOFO7u3o+F2QanzoYTznGOF3M8Mpj3sBX37+5EHHX/JJGmJ+ShOFUAoXD5QqnClTVBYQZaUUCax6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FEFC15A1;
	Mon,  8 Sep 2025 20:50:26 -0700 (PDT)
Received: from [10.163.72.34] (unknown [10.163.72.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 728C03F63F;
	Mon,  8 Sep 2025 20:50:30 -0700 (PDT)
Message-ID: <bfe55fd9-e00f-44a8-bf4f-0b0a6cfc16bb@arm.com>
Date: Tue, 9 Sep 2025 09:20:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] arm64/sysreg: Update TCR_EL1 register
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250907123000.414181-1-anshuman.khandual@arm.com>
 <20250907123000.414181-2-anshuman.khandual@arm.com>
 <a195095c-8ebd-4d74-959b-7b407d416a1f@sirena.org.uk>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <a195095c-8ebd-4d74-959b-7b407d416a1f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/09/25 7:28 PM, Mark Brown wrote:
> On Sun, Sep 07, 2025 at 05:59:59PM +0530, Anshuman Khandual wrote:
> 
>> Update TCR_EL1 register fields as per latest ARM ARM DDI 0487 L.B and while
>> here drop an explicit sysreg definition SYS_TCR_EL1 from sysreg.h, which is
>> now redundant.
> 
> I actually checked against DDI0601 2025-06 to spare my poor machine the
> strain of loading the ARM.

Right, they are the same.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks !
> 
> I guess the cleanup of the redundant definition could've been a separate
> patch but it's not super important.

Dropping SYS_TCR_EL1 definition from header (asm/sysreg.h)
into a separate patch ?

#define SYS_TCR_EL1 	sys_reg(3, 0, 2, 0, 2)

