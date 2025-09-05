Return-Path: <linux-kernel+bounces-803864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58721B4668B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2728B17F2D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539227E1C5;
	Fri,  5 Sep 2025 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="TCqeOMh+";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="dPtpTyrI"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147D191F98
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110857; cv=none; b=e67QxHJT8m17yOhsxSVu5vEXkaGif4j+2XqBntBHSnLXBSYj1q3DxIH/2M6Vxf0sqglkD6EpkwiMo0wadJFfnxO0UncCaVXDgEb/rafT3Sg6oSHusaeR08UQvLn953L0LVW/KgBPoWs7E3ZyzvPBHx90xYAZ69EG1ZQtuqdLHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110857; c=relaxed/simple;
	bh=IxLtAHdzEmLBZE2LYCCsTXG+Y30JEeRn1R1/WuErlk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5xpcQqGcrdZFVs+NIYOj6vwX6GdpKrxEPqDptU3vNePraOvCr16syKGh0QHwvCEwI3GkSFgNQl6TnuvkP1kossDxbLT0jAdDDRlDrmQtpg5qV4EUUBY/GJnSPsoxUusdEF5MuaZlCkO6MXD+RKwjYXyTZiHY7b2mxJQj+4lczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=TCqeOMh+; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=dPtpTyrI; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757110848; x=1757715648;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=odc26EmzyJ8HGpXoYPMXxK2vau/006W/+LwKY/jri00=;
	b=TCqeOMh+LiJj3QUTqFaSc9rzXgwRa+HQTJ25aT2mgd20EMKIVRaXBH0FMSMI669cEEap4CsRjCbMy
	 eWYwom2px4Ts9s+/xn/aLTmU6Idnb67yIfMwjgVsloQpv20pNINeboBaDFrMJOzYqcHwRL6SCDCILm
	 2gk86JTdrXLYQl+i4fZyfj5d6/ziZsOFPriAwZejwWjW98MS6rMT2J6IjcGdq4WqzsNPurpcr1j1BF
	 hmWWW0S1fA/4n7x3/UpslHS7konv+VM43ZeEF8ZM4o9uejj7Xkr6LhoQBApGeeR9xB2u6VHg9esu5N
	 7yMahW/zvA5UdWu4r66iSuMYXHJShuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757110848; x=1757715648;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=odc26EmzyJ8HGpXoYPMXxK2vau/006W/+LwKY/jri00=;
	b=dPtpTyrITZpEsdUxVo9uhiVbg8GNRG6UIPYCNNOMgE/ZpxiviHFRR7Yu2R67F5QhZbOAMEZkA/kOq
	 nNyT+vtCA==
X-HalOne-ID: 92c59c38-8aa6-11f0-9393-632fe8569f3f
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 92c59c38-8aa6-11f0-9393-632fe8569f3f;
	Fri, 05 Sep 2025 22:20:48 +0000 (UTC)
Message-ID: <16998440-84fb-45a4-9134-5dcff71ee68d@konsulko.se>
Date: Sat, 6 Sep 2025 00:20:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mm: remove zpool
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <20250904164710.210731847fe25d9419203886@linux-foundation.org>
 <f0869789-ee30-4eb9-840a-502d031df1f5@konsulko.se>
 <20250905113043.3fb70f94c86445617266c958@linux-foundation.org>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250905113043.3fb70f94c86445617266c958@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/25 20:30, Andrew Morton wrote:
> On Fri, 5 Sep 2025 07:42:34 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:
> 
>>
>>
>> On 9/5/25 01:47, Andrew Morton wrote:
>>> On Thu,  4 Sep 2025 11:33:24 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:
>>>
>>>>> With zswap using zsmalloc directly, there are no more in-tree users of
>>>>> this code. Remove it.
>>>>>
>>>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>
>>>> Per the previous discussions, this gets a *NACK* from my side. There is
>>>> hardly anything _technical_ preventing new in-tree users of zpool API.
>>>> zpool API is neutral and well-defined, I don’t see *any* good reason for
>>>> it to be phased out.
>>>
>>> Well, we have the zpool code and we know it works.  If a later need for
>>> the zpool layer is demonstrated then we can unremove the code at that
>>> time.
>>
>> The whole patchset [1] depends on zpool, with the whole intention to use
>> it on the Rust side.
>>
>> [1] https://lkml.org/lkml/2025/8/23/232
> 
> Well, that puts a Rust wrapper around zpool.  But what user-visible
> benefit does it (or shall it) enable?

There's at least one user ([2]) of that interface in the pipeline.

[2] https://github.com/vwool/linux-mm/blob/rbtree_experiment/mm/zblock.rs


