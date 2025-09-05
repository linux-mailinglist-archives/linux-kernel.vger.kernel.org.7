Return-Path: <linux-kernel+bounces-802101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD225B44DA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566083A65B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3626B2C8;
	Fri,  5 Sep 2025 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="mLgtGvr/";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="JaXDkq5Z"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406E1EE7B7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050960; cv=none; b=VUriTg88OEWyvRKiBOxsMy29QCzmaE5PFrWDdKhUZ4u5AEh1b8BFB4TA/AM1w06HFXHG35r8hv2ivXK0ND3QZYf72XeUNzxxJorer+hz4Et+2zdZpZJj+vgLZu9I8jQA0jq5H9Kp4bL/Vq4I9wUxeWu/vjIPErIKnG/oo+R2WUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050960; c=relaxed/simple;
	bh=v0RiDREeh+Y6rsAMPQjt8i6VfSWjDI9Nb0SixsHeCE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU34EsXP+h+hl1novB0Y5u9OvNYLkDx8xNxzvW1qA12I/tKwQW+sPnnQR8BRJAmMPiIljVQcwlSDhW/xd3vtAKpei2bJhrebWEMkIo6Cz7UQPEbPstlMt3l78ijQ/ln1gOKpUvBwZnqenfn2jBEdU9ZkQoVOmqlx9YhC+CN4qPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=mLgtGvr/; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=JaXDkq5Z; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757050955; x=1757655755;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=6uIYavXuvVkxql4mic1RNmmJBV9tJQbXNRB/J1rntf0=;
	b=mLgtGvr/BTlnRFn/pTvavaa4974fH12hdES+j8R3lvvB+FxDQbDhvD+4UdTaC5Qa+BeE5nQKwzufk
	 MDkikHh1KVRdK/Cn/d8FB9sjxfFmyEDr6dkVS0JK4b8fwQT09poQbbznFo48JZfM8wfnUFamJUIxS2
	 +p+1JMcx3Ib5MH2tQR3YV7fPEnRSWA3ebm6lw2tT/21xEpnRPe+5g708cZfN1LthhglEW61hLi9Yyz
	 owLpWVLHXmoYE8acBc56ASyeMnjzAEnXqOMawWvItOkIBapfHdB49tjH7cGtJmHm/T/lDBMy3fxych
	 +0xE8d4/pnySdV4t3HvgQIGGMNr2rTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757050955; x=1757655755;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=6uIYavXuvVkxql4mic1RNmmJBV9tJQbXNRB/J1rntf0=;
	b=JaXDkq5ZOIXjTTFAUqiTpU/5uDNa/k1YWbiF+9kYGW0Pm6bX2LmPpdLOXda1ahGuRVrnTZJaTQ5zS
	 xUcO1u9DQ==
X-HalOne-ID: 1f4ec321-8a1b-11f0-8613-e90f2b8e16ca
Received: from [192.168.10.245] (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 1f4ec321-8a1b-11f0-8613-e90f2b8e16ca;
	Fri, 05 Sep 2025 05:42:35 +0000 (UTC)
Message-ID: <f0869789-ee30-4eb9-840a-502d031df1f5@konsulko.se>
Date: Fri, 5 Sep 2025 07:42:34 +0200
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
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <20250904164710.210731847fe25d9419203886@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/25 01:47, Andrew Morton wrote:
> On Thu,  4 Sep 2025 11:33:24 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:
> 
>>> With zswap using zsmalloc directly, there are no more in-tree users of
>>> this code. Remove it.
>>>
>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>
>> Per the previous discussions, this gets a *NACK* from my side. There is
>> hardly anything _technical_ preventing new in-tree users of zpool API.
>> zpool API is neutral and well-defined, I don’t see *any* good reason for
>> it to be phased out.
> 
> Well, we have the zpool code and we know it works.  If a later need for
> the zpool layer is demonstrated then we can unremove the code at that
> time.

The whole patchset [1] depends on zpool, with the whole intention to use 
it on the Rust side.

[1] https://lkml.org/lkml/2025/8/23/232



