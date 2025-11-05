Return-Path: <linux-kernel+bounces-885742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ABEC33CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0CC8348B60
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCB92571C5;
	Wed,  5 Nov 2025 02:54:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12946214228
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311288; cv=none; b=r+QnbY9Qv52Uyc4B4HmaKG6mrX7Fnsfs9b1BwS6DJUdAcn7PWXLeqkY0tS8RrUNQjuQGg1kKD91JSyyuAcA7OQbEgFw85YOCpSA+nrKpg/SDJ38w1h3bkefPvnMDmb6f0xaWJIlrBREuT3OoLkhuNSI15tWTtYSo2TNgPnd9bGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311288; c=relaxed/simple;
	bh=PGHFaWFzkVDAVsefZK4iggvfaftEOTYfzttVTN51kq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttUuzju56CO6DlEZcDKEqrgDd6zKfSkygw6li00DjfmbTl8hlpdVGcfIqir6HWOH/KmRylyF9LerRrYncwSIEbbwYm83sZ4hsMq7T+HAmcV9KBNXtgzfEe3Oy7hR5KRozoRbd4IQGswyfUvJrCfTeyGhmQQhrbz/P9f1cMRn0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 555DB1764;
	Tue,  4 Nov 2025 18:54:37 -0800 (PST)
Received: from [10.164.18.45] (unknown [10.164.18.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76CA03F66E;
	Tue,  4 Nov 2025 18:54:43 -0800 (PST)
Message-ID: <e660e033-6300-4deb-b034-4d26746d8d01@arm.com>
Date: Wed, 5 Nov 2025 08:24:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Add a fallback stub for pgd_page_paddr()
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org
References: <20251014110633.304961-1-anshuman.khandual@arm.com>
 <aQoORmgliayA0s_a@willie-the-truck>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <aQoORmgliayA0s_a@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/25 8:01 PM, Will Deacon wrote:
> On Tue, Oct 14, 2025 at 12:06:33PM +0100, Anshuman Khandual wrote:
>> Add a fallback stub for pgd_page_paddr() when (PGTBALE_LEVELS <= 4) which
> 
> typo

Sure will change - s/Add/Adds
> 
>> helps in intercepting any unintended usage and which is also in line with
>> existing stubs for similar [pud|p4d]_page_paddr() helpers.
> 
> Are you saying the kernel compiles in this case without your patch? Which
> definition of pgd_page_paddr() does it end up using?

Kernel compiles for PGTBALE_LEVELS <= 4 just fine without this patch as both
its current users p4d_offset_phys() and p4d_offset_lockless() are wrapped in
with PGTBALE_LEVELS > 4.



