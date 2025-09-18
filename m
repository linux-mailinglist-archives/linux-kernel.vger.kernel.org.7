Return-Path: <linux-kernel+bounces-821951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F09B82ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820464A2B18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE3241CB2;
	Thu, 18 Sep 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cReQRru3"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1D23D28B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758163543; cv=none; b=Qgm2Hsr6gPOZLW7fXGXrNpk7UyYTpEZXpOQP9VQlvUngorJDJZ5seyx8ZT+T0SwlVN3IQL4kqCAjIi0lQh/BEdqZtfCnTqP+KlDhuoNmALPTFcV6N6jDIKOpY/h4J8oAm6soFrLDNmOt52zeKMPFNnnIhqKLhTrManSrz2jV9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758163543; c=relaxed/simple;
	bh=lDi2RCGrGA0BgkYHmZk3X1XDrkChbX5rhoydsWAFh0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ9LVn68AzSmWwaYASjnAXQ+BCHsPChl80KC5iPP/tarTt2tb0HzHBhwjPe8r73AV1NWMmONIV9nYQYKFFnO72K44cTuf11GeXpmG6zaZv+vottKZSN/ChgxL4G3LEDQ46OV8zvE6v/pp8b5B/ETgDN/WZf9ZkGmhcVPYVfk9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cReQRru3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758163539; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=edngCZIauCo4tQxaAcmWsONusTDWKBny329eUJIO/dc=;
	b=cReQRru3JTV5jfiZETOjJcHf343qYMoK9vdrlKtins8s61TzFxdRHAT6VS+fVqTzILh/Dtk1n2RnaU/RMd2h80Vc+K7i04vIvJel5hA5oBtqCfnvTPj9AbXE3OaV4AxBA7Rs8yviVVPY+SuHBm+Ajzqb3pDtdWX9ay4mTgttntI=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoEIDoH_1758163537 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 10:45:37 +0800
Message-ID: <41c98144-de4c-4b46-b842-dfc03e3b0cca@linux.alibaba.com>
Date: Thu, 18 Sep 2025 10:45:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <aMQ6bW-OoMWMVEFF@casper.infradead.org>
 <11629632-c652-460e-b617-3ec0c27969f5@linux.alibaba.com>
 <aMh7SAlitp5FqR-M@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aMh7SAlitp5FqR-M@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/16 04:47, Matthew Wilcox wrote:
> On Sat, Sep 13, 2025 at 11:04:48AM +0800, Baolin Wang wrote:
>> On 2025/9/12 23:21, Matthew Wilcox wrote:
>>> On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
>>>> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
>>>>    	 * swap_backing_dev_info is bust: it doesn't reflect the
>>>>    	 * congestion state of the swapdevs.  Easy to fix, if needed.
>>>>    	 */
>>>> -	if (!is_page_cache_freeable(folio))
>>>> +	if (!is_page_cache_freeable(folio) || !mapping)
>>>>    		return PAGE_KEEP;
>>>
>>> I feel like we need to keep the comment (assuming it's still true ...
>>> which it probably is, although there's nobody who would think to update
>>> this comment if it became no longer true).  I would certainly wonder why
>>> we can have this !mapping test.
>>
>> I think the !mapping check is still needed here because the tmpfs/shmem
>> folios truncation might race with folio reclamation, see shmem_undo_range().

Sorry for noise. tmpfs/shmem folios will be clean after calling 
truncate_inode_folio().

> I agree that we still need the !mapping check.  But it needs this comment
> that you're deleting, because it's not obvious why we'd have a dirty
> folio with a NULL mapping on the LRU list.

As I discussed with Hugh in another thread[1], the issue of a folio 
being dirty but having a NULL mapping was fixed by commit a2b345642f530 
("Fix dirty page accounting leak with ext3 data=journal"). I can hardly 
believe this kind of situation can still occur nowadays. Anyway, let me 
leave a warning comment here.

[1] 
https://lore.kernel.org/all/1111883c-974f-e4da-a38f-bb3d337185ad@google.com/

>>>> -		/*
>>>> -		 * Some data journaling orphaned folios can have
>>>> -		 * folio->mapping == NULL while being dirty with clean buffers.
>>>> -		 */


