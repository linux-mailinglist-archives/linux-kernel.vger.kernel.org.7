Return-Path: <linux-kernel+bounces-756621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3121B1B6E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364E57A8866
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88A92264A0;
	Tue,  5 Aug 2025 14:52:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C866B2475C3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405549; cv=none; b=TSe+opSCS8B6tveXAvQF/AeQ1n3DJYqtLii2EDoHZbcEid/7tv3vOrEZosP0M3eYhjaxqjVjqrPiSB5AtZS+LG81EQMhJEU/SEpoklctjCx3J91rRi9e8drbZ8Dk6CaJNOnSlspCGthicDdIQTWPj00HfB8USynxK+uf2KjvkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405549; c=relaxed/simple;
	bh=VVlMtuKfvsytkCCmPMHos8d55PzPw8+2MmKLifKRtmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbpmW6fDG6wM2YK8N3NisWS8Nof9aAwUW9dW8LUHmKXFyBkXDjIbvoc9NGJ5wgJG0QAU6ZO16WWSdo7m4vSk8EK0hVGMWB/vHE+VNLP3G01mtEcrvIqUaQCZq0xXtFWSUNzStAGx2WWnv6TZEvTqSbZc6vx4zZidWbRyIzwNzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E1012FC;
	Tue,  5 Aug 2025 07:52:19 -0700 (PDT)
Received: from [10.1.26.194] (unknown [10.1.26.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAD9C3F673;
	Tue,  5 Aug 2025 07:52:25 -0700 (PDT)
Message-ID: <b4ba5c9c-fc9c-435b-9110-1014127bef05@arm.com>
Date: Tue, 5 Aug 2025 15:52:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 0/4] arm64: support FEAT_BBM level 2 and large
 block mapping when rodata=full
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 akpm@linux-foundation.org, Miko.Lenczewski@arm.com, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <985f9d53-ea5e-4da0-9427-106a58be7f26@arm.com> <aJIXmIgCGlWlHDNK@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aJIXmIgCGlWlHDNK@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2025 15:39, Catalin Marinas wrote:
> On Tue, Aug 05, 2025 at 09:16:31AM +0100, Ryan Roberts wrote:
>> On 05/08/2025 09:13, Ryan Roberts wrote:
>>> This is a new version built on top of Yang Shi's work at [1]. Yang and I have
>>> been discussing (disagreeing?) about the best way to implement the last 2
>>> patches. So I've reworked them and am posting as RFC to illustrate how I think
>>> this feature should be implemented, but I've retained Yang as primary author
>>> since it is all based on his work. I'd appreciate feedback from Catalin and/or
>>> Will on whether this is the right approach, so that hopefully we can get this
>>> into shape for 6.18.
>>
>> I forgot to mention that it applies on Linus's current master (it depends upon
>> mm and arm64 changes that will first appear in v6.17-rc1 and are already merged
>> in master). I'm using 89748acdf226 as the base.
> 
> It's fine as an RFC but, for upstream, please rebase on top of -rc1
> rather than a random commit in the middle of the merging window. Also
> note that many maintainers ignore new series posted during the merging
> window.

Yeah understood - I'm going to be out from Saturday for 2 weeks so thought it
was better to post an RFC now hoping to get some feedback so I can repost
against -rc3 when I'm back and have a chance of getting it into v6.18.


