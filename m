Return-Path: <linux-kernel+bounces-853066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E5BDA924
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFC633498E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062F30146F;
	Tue, 14 Oct 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xVqSR5mP"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC8221FCB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458195; cv=none; b=u0rJsBDsbn47aGuYX4oiZaxFzjfG+qsSAYjxo6NpVZPYDslM8GHDb47qOB9t5rmtiHtsj9FwL6wP5Cdy3EQOvseq3ipwLStGQDDpE+CLgt4jdOXL+0Dvshh4dRTP2fhxZsSbo5gRTml/79NzRzhO5+OIhhb1fjHk599nxXJ42tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458195; c=relaxed/simple;
	bh=Whutt4xQd6Pv4Eivvs00SmQKWn9c93fGKp+BqvRd0JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZgVfHok0kaY3glrj9mbWflFuS6jjQC25yiQMtKoaz5pys6TJ16jwMbc5qKqBmaJg59P0tXrzWg8DQ3mT+KfJ7FYF7pj8KkBb0zqv/qhC43LnJsjUo8x16X+xycL99M0MPcEBPatYtK+NXFC6eB4uEiNlqrfq8qq5db7UYElHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xVqSR5mP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b0e88b97-3c55-4be3-9782-4ab5e5d72ebe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760458190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O+Twt08nWN4Np4W7evQ3ot+OSGaLX8P0SMb0zqLKEwM=;
	b=xVqSR5mP5Kwg/dvugAJHEPNCg7sb/bH/6mecSofbYeyIVMvdk1hXmF83ovYbzQEl0s0o4/
	wnR6gkCzhFWaxScV9CsI+UfFEXQM3ZndKVGWOhUwaZ7/gHbPC7EkT2B+7RGNVPBkkFNWcH
	lisHrpd9o+mpdDdPxI+g0xwEbQIJYmw=
Date: Wed, 15 Oct 2025 00:09:42 +0800
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
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
 <95a223b1-8d57-40c3-8226-678b1db233aa@redhat.com>
 <57cffedc-65c0-44f1-8364-3a3ff9bdc760@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <57cffedc-65c0-44f1-8364-3a3ff9bdc760@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi David, Lorenzo,

Thanks to both of you for the deep dive on this!!!

The code we've been discussing was moved to a new helper by
another patch series[1], so let's call it a day on this
thread and leave it as-is and just review/change the logic
at its new home :)

[1] 
https://lore.kernel.org/linux-mm/20251008043748.45554-1-lance.yang@linux.dev/

Thanks a lot!
Lance

