Return-Path: <linux-kernel+bounces-892713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B735C45A75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65833A7C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876E2F691A;
	Mon, 10 Nov 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ghppzoIr"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C11E47C5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767133; cv=none; b=E7SCh7CGWP0LCkFwCeZnVj7z6bGvuPhzFBqLFjEY4CR0Q41GD1xtkqkA/LJgKZPg6n/NtKF/VPfZMEo78uR6fIgeGyhEToXPeTOZ+KmAXZ7Cwtn6G5j1laH3I2IQ+l4dkHH8XIRU75nhbU+icqWk7kqb+1AsbWcgoBlAab8asBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767133; c=relaxed/simple;
	bh=lwruCbuKvcI/RXTiWfORSD6gncR7qrSJQBoWWSJVSQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg71q8VNn8/w94wN0TNg1XVuW1R+NyXMKC++EN/D2cmzRiHoAW1v8gNgrwgiCe2EMfmaNc7UPD1e4C9I4riMMFnuuWXDhx3OKPtuN/cUdJA8777le3r7NZCPyVvkQM25DRAPS/nYrwh9MP/W73A7wVdNcnx43AmDuvTDBHZ2ORA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ghppzoIr; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3f05987-74d9-4e6e-a18d-31e64c92337e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762767125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ClMFlGw+3oW+Mx09+T/4s8CBInH2qbgvOkap9Vt6M8=;
	b=ghppzoIr9fx6cD8ZMfCbFqa2KZA907YF/YA668q73DyyK8bg2shk1VN85RWbYu0Kpyi5Vb
	6sblyfDy7g/nARJGFPlCAaj3C5TbcF1ndDGoSWRerKBQGaRhUdXAlTefbbfVdYs4x7suy+
	s/7TalOfMqKoUWP1tamsbc7gZXJJSYw=
Date: Mon, 10 Nov 2025 17:31:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot ci] Re: mm/hugetlb: fix possible deadlock in
 __hugetlb_zap_begin
Content-Language: en-US
To: syzbot ci <syzbot+ci5a676d3d210999ee@syzkaller.appspotmail.com>
Cc: syzbot@lists.linux.dev, osalvador@suse.de,
 syzbot@syzkaller.appspotmail.com, linux-kernel@vger.kernel.org,
 david@redhat.com, akpm@linux-foundation.org,
 syzkaller-bugs@googlegroups.com, linux-mm@kvack.org, muchun.song@linux.dev
References: <6911ad38.a70a0220.22f260.00dc.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <6911ad38.a70a0220.22f260.00dc.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/10 17:15, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v1] mm/hugetlb: fix possible deadlock in __hugetlb_zap_begin
> https://lore.kernel.org/all/20251110051421.29436-1-lance.yang@linux.dev
> * [PATCH 1/1] mm/hugetlb: fix possible deadlock in __hugetlb_zap_begin
> 
> and found the following issues:
> * possible deadlock in move_hugetlb_page_tables
> * possible deadlock in remove_inode_hugepages
> * possible deadlock in unmap_vmas

Oops, this fix was incomplete, as other code paths with the reverse locking
order still exist, leading to the deadlocks reported by syzbot ...

Let me take a closer look ...

