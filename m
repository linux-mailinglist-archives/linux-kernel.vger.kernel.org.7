Return-Path: <linux-kernel+bounces-852853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75ABDA1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288AF400084
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BE2FF652;
	Tue, 14 Oct 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G7KAczSk"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB792F616D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452699; cv=none; b=BQQP0h4Tk9HSgGt2DBsNSFUs8qGVjfU94zf5+K1Z0EEKRbyUZxHlz0dTMFmDwXyFjh5QUOOveQpblfuzwJVVBrXXO9bf37FLeKIBMbl5kn9VrHIEJ3JCHElJqgiOH3r3J4qomIkcrBD/2XBfPXmlitJmHXWNKYf3xylPtx/WUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452699; c=relaxed/simple;
	bh=+Qfmzv4rdao135C/vjU0DMOsvnXXdVztZfhdDGXV1SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVr+/1wRkWLzaVJ5LJmSEKKua7zBkPV2IhZgUXzQgajVPTQnDKTP9ejLH5Wbk96xdZq+uC1WsAftEf4fkxQEuLug+xW5f8YHsF9XwPc5bt0IbqCKKFXeqBkW7cVNm/4KJtWDnw+PWn158sNkbK6RjEEEsVGS94Z42Kt54jhiAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G7KAczSk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e22cff1-fad7-45a6-bdd4-d5921d12c5e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760452693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph45ShvU5LxibAKmRwrd9NsEUxkKQysF0rWNW9JCj9E=;
	b=G7KAczSkogU8fLCXmjILNi+xkzGOvqobi5PzscfO4BTFXWU/rDzEBllPdzGmDpzXsyEFX9
	Qlky5S9AdHOpkGfRZpQtuXjHWNCe4jYCqtZFYbrzEzbwbJiD7kct25j/TjTKMsKQwZ1ALy
	rgMcbkTVubIVoWzJjOAMjHNusy6wM64=
Date: Tue, 14 Oct 2025 22:37:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <6f448506-677f-4e0c-aa9c-d5da061e57ee@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <6f448506-677f-4e0c-aa9c-d5da061e57ee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/14 22:32, David Hildenbrand wrote:
> 
>> static inline int pte_protnone(pte_t pte)
>> {
>>     return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
>>         == _PAGE_PROTNONE;
>> }
>>
>> static inline int pte_present(pte_t a)
>> {
>>     return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
>> }
>> ```
>>
>> On x86, pte_present() returns true for a protnone pte. And I'd assume
>> other archs behave similarly ...
> 
> Applies to all architecture. prot-none entries must be present, 
> otherwise we'd have a lot of other issues :)

Thanks for confirming, David! That's good to know ;p

So @Lorenzo, looks like we're good here on the protnone front. Does
that clear up your concern?


