Return-Path: <linux-kernel+bounces-844069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD1BC0ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5561882E26
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE424A069;
	Tue,  7 Oct 2025 09:53:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919134BA34
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830813; cv=none; b=tkRBFp+V3owM0EoGD0bUDpA/JdBtxVi1S7V8me0dbasUnpoUoe9oLCPqb0sWgVPS9Z5H/+TDKE0Y7QG7ttoVHePU+3d/k8pG9NhOoU+c36l8EAjyW1/pWtyV1UmiCFHf/SAkSXDJc7u1FgjSMR1b1WuY0c7fFrz3Q5dR4cEDtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830813; c=relaxed/simple;
	bh=aekVDrW2ABCQsRy///0oTao9FYiAJwzSPu/SM6UiY34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqIypeIm9p+y4TVZeMqPVjLPei6KPdEO6j7zv8wToq2vsQTUkkj8GhrPw3SEUMM5lPuWxRICafPF52ukMb4PPJWnGA1mPCN1hYBxnbSdivawWsZ0jg+aK/OQ53fUbD4rYWNO2X0XZGHn1nAJvKrk6B7CptMZwbXGU0+Bi2kb5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83CD91424;
	Tue,  7 Oct 2025 02:53:21 -0700 (PDT)
Received: from [10.163.65.24] (unknown [10.163.65.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E2A03F59E;
	Tue,  7 Oct 2025 02:53:26 -0700 (PDT)
Message-ID: <c26dbbf7-8475-4424-8e73-b35a845a2949@arm.com>
Date: Tue, 7 Oct 2025 15:23:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Replace READ_ONCE() with standard page table
 accessors
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20251007063100.2396936-1-anshuman.khandual@arm.com>
 <584fea72-e564-4cf6-9435-ce4b03f2fd65@arm.com>
 <627da4d5-5c6b-4bf4-9544-9021062d378e@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <627da4d5-5c6b-4bf4-9544-9021062d378e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/10/25 1:24 pm, Anshuman Khandual wrote:
>
> On 07/10/25 12:41 PM, Dev Jain wrote:
>> On 07/10/25 12:01 pm, Anshuman Khandual wrote:
>>> Replace all READ_ONCE() with a standard page table accessors i.e pxdp_get()
>>> that defaults into READ_ONCE() in cases where platform does not override.
>> Does any platform override into something else currently? The way you write
>> the description implies that.
> That's how the callbacks have been designed to be overridden when required.

What I mean is, if currently some arch is overriding into something else,
this patch will be a functional change. So it is beneficial to say
in the description that the patch is a safeguard for when the platform
chooses to override, and no functional change is intended.

Reviewed-by: Dev Jain <dev.jain@arm.com>

>>

