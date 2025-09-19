Return-Path: <linux-kernel+bounces-824163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79252B8842B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8355B64C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12787469D;
	Fri, 19 Sep 2025 07:46:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BD22BE7C0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267987; cv=none; b=O+/JpjJXvl15FsEnw5T/3RPPaQE09UaoJTwoYcdtDJy4IiE/vwQFYLzYKRaRdV65IUba61Mlxv6wI/D352sZ6nXQBjqzC5fMIRDz39q7mxflgfVAY6cS/x07G2baicQuB8ny0sqPD7BnAIb2qpJHOUpj42Lp+imwqEkRsF+DUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267987; c=relaxed/simple;
	bh=F9flJKM7IzkC8ce1hDWca3X0bVH2146bB5hDPYcqi/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZqerQUivBefwtM/QdBadpvt0J7GVtDWZrThkQl8PfMBL6AART3q8YHYG7h0Q6xFCv3J/h2iZvjnXFK/CtkxyXhWnq28AKpI/G+E/nWEKwI1VJio6UyQAss1CcIV1xmFSMVuLwhqBcmCCwS9+xSI82/dmduWPhOdid93JyNlJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 912811692;
	Fri, 19 Sep 2025 00:46:16 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAA743F66E;
	Fri, 19 Sep 2025 00:46:20 -0700 (PDT)
Message-ID: <4f5df85d-b238-4e12-8654-cab771454c49@arm.com>
Date: Fri, 19 Sep 2025 13:16:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
 quic_zhenhuah@quicinc.com, ryan.roberts@arm.com, kevin.brodsky@arm.com,
 yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com, mark.rutland@arm.com, urezki@gmail.com,
 jthoughton@google.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aMk8QhkumtEoPVTh@willie-the-truck> <aMrXBArFNLTdwWs3@willie-the-truck>
 <aM0F8U-cW6sh62H-@willie-the-truck>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aM0F8U-cW6sh62H-@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/09/25 12:57 pm, Will Deacon wrote:
> Dev,
>
> On Wed, Sep 17, 2025 at 04:43:00PM +0100, Will Deacon wrote:
>> On Tue, Sep 16, 2025 at 11:30:26AM +0100, Will Deacon wrote:
>>> I'm currently trying to put together a litmus test with James (cc'd) so
>>> maybe we can help you out with that part.
>> Here's what we came up with. There's not a good way to express the IPI
>> from kick_all_cpus_sync() but it turns out that the ISB from the TLB
>> invalidation is sufficient anyway. Does it make sense to you?
> Any comments on the litmus test and/or my question about serialisation
> of the static key? I'll be moving the arm64 tree to "fixes only" soon
> as far as 6.18 is concerned.

Sorry, I had read your replies but thought I will take time to respond since
it seemed this patch wouldn't land in 6.18, and I need to recall the discussion :)
I'll reply to the other mail.

>
> Will

