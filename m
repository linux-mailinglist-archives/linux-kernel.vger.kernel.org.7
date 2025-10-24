Return-Path: <linux-kernel+bounces-867968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7BC0407A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FE4E31EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9921C3C18;
	Fri, 24 Oct 2025 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gTkHLOm7"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F91A9F90
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270071; cv=none; b=FgeBuUXUdOVeYeE2dfIjy8r25yPek3r6Z0GS9Bxh6/CNBYPTQ+4ZXXIgspIaAstuZLm7Gt07otp44+EnC9jBQgcOw0Yd3aTJ7SxH/MTdQYLViWQlAXkNc6a1/KkL+JsM3vkOU/Il5O+LAIxee5eMmXagntRDUhd9n1l2zSAFgv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270071; c=relaxed/simple;
	bh=gwfiB4C0GOFiV06KID7mXC+DZ8SSqRNfWj56vSLnzwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u07pD1beheDc8FQNOk50qybluYF+ALbAX6t4eaFb4ct5PMld2L24C5x4LwIuHnRdjxBFiOZj2YmSVM7CGl7IczV0KqvrJzhNwNjykphIa1tSpppKL0TBVnDwkLVo7JSXRyV7PrOOHV5guYuSBz2oeNFFh4J5/YGp2pa6blENFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gTkHLOm7; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761270062; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+V8kOqNOsh8UaPdUFo5M/73e9x7UlGg1quQtezT5Kvg=;
	b=gTkHLOm7s3LwDJg32MGYDYD5EOjA3saLvU7pVxWvs9wdqYJuJ015QLj2InDIHP5u5vA3S9lox+ZP7yKXOKMpxNUiZLK98nJf6IzY6wcVFAUSSKVSrpNty2qfdoM7mqLNN58Z5zDSO9wyQ/V8CmmgFxIiAP6jrvHtt4yCxplfdTM=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqsXDkv_1761270060 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 09:41:00 +0800
Message-ID: <b746b524-af09-4ab5-858a-0a29f72a0ea7@linux.alibaba.com>
Date: Fri, 24 Oct 2025 09:40:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
To: Dmitry Ilvokhin <d@ilvokhin.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/24 02:12, Dmitry Ilvokhin wrote:
> Allow to override defaults for shemem and tmpfs at config time. This is
> consistent with how transparent hugepages can be configured.
> 
> Same results can be achieved with the existing
> 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> in the kernel command line, but it is more convenient to define basic
> settings at config time instead of changing kernel command line later.
> 
> Defaults for shmem and tmpfs were not changed. They are remained the
> same as before: 'never' for both cases. Options 'deny' and 'force' are
> omitted intentionally since these are special values and supposed to be
> used for emergencies or testing and are not expected to be permanent
> ones.

Make sense to me.

> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

With addressing Shakeel's comments:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

