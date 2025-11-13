Return-Path: <linux-kernel+bounces-899252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF43C57302
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B6894E4B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88733C504;
	Thu, 13 Nov 2025 11:29:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8BA339B4A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033391; cv=none; b=RZ5Y28mY0+WioIdH/V+fbg1TNMUIfEy7Ker1Z5lPLr9ANQmaXc6pQlv7df+PfCovkwKgF9ef33X6QF2lO6JZP4eCVmCihFfTPiSH9lfDM2Wubr+wLJaVq4iUfz87eK+qTRYnnJKAPXvSwbwfhYdyUStEhhdPR3A0ha8h7rFJjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033391; c=relaxed/simple;
	bh=MeIVnOXMvYiIp8CDDQ0Fxa0thYR9hUqn2OAng8JtcL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0DUIa1FWb73fDthdnQf04IY2wqVQSrRD2PaOKF/R6mAfz3ssEN6Hg7ATWcm3xLDUHqFTDBtto+ysBqaYYXwsBzZR4R2ho414FiA1TZ2t3nU9NmRnRBZJyGi9fiPbVoq1480YpX/Yc3ZN/fJfgqQcaHtXZLQ7iQkmXflavGTKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3691C12FC;
	Thu, 13 Nov 2025 03:29:41 -0800 (PST)
Received: from [10.57.88.12] (unknown [10.57.88.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5B363F66E;
	Thu, 13 Nov 2025 03:29:47 -0800 (PST)
Message-ID: <3d4b96ed-60a8-446a-b34a-44c083ad25ff@arm.com>
Date: Thu, 13 Nov 2025 11:29:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: mm: show direct mapping use in /proc/meminfo
Content-Language: en-GB
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023215210.501168-1-yang@os.amperecomputing.com>
 <3af5d651-5363-47f7-b828-702d9a0c881c@arm.com>
 <a6eec165-9c48-56aa-8b05-6bf73411e4bf@gentwo.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a6eec165-9c48-56aa-8b05-6bf73411e4bf@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2025 17:11, Christoph Lameter (Ampere) wrote:
> On Wed, 12 Nov 2025, Ryan Roberts wrote:
> 
>> I have a long-term aspiration to enable "per-process page size", where each user
>> space process can use a different page size. The first step is to be able to
>> emulate a page size to the process which is larger than the kernel's. For that
>> reason, I really dislike introducing new ABI that exposes the geometry of the
>> kernel page tables to user space. I'd really like to be clear on what use case
>> benefits from this sort of information before we add it.
> 
> One is user space where you want to "emulate" other page sizes and the
> other is kernel space.
> 
> The per process page size is likely going to end up
> being a per VMA page size since these address spaces can be shared and the
> VMA is already containing information about huge pages, memory policies
> and other stuff relatd to memory layout. And yes it would be great to have
> an accounting of the page sizes used in a VMA.

See my response to Yang. I suspect my issue shouldn't really be a consideration
for this patch.

> 
> 
>> nit: arm64 tends to use the term "linear map" not "direct map". I'm not sure why
>> or what the history is. Given this is arch-specific should we be aligning on the
>> architecture's terminology here? I don't know...
> 
> Other architectures are already exposing this data via the terminology
> used here. The information is useful for seeing if there is an issue with
> small pages that could be impacting kernel performance. It is surprising
> coming from oter architectures that this information is not readily
> available.
> 


