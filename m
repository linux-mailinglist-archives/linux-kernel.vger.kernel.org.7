Return-Path: <linux-kernel+bounces-840581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB9DBB4B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2369A2A60F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634EA271451;
	Thu,  2 Oct 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCHxKw3Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B882737E1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426763; cv=none; b=RwG7Cse2Xv/zLDovFwVZledVTjEkk/QnhWhvkIoL6/aXUhDskUTQZmxwoIZx1ir/qQlUp6ZuyeekQQZBRVcsXKujwibDdfRuUHAej6KZkTs2f7fhrPaK+6yTQvopBKN4572oJBJQoNjv0kxhTgmqUTAEJPikhhgNMO3hEuL3KUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426763; c=relaxed/simple;
	bh=CpJbQiQzc/Zz/i3BHy97csps9TKRZRRFA7h8wc9Gjbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cx2OuXFe/FXvaiQKV0bPSmpNAd7loxDS33UKwTq3yBdzqgD9jai/qWZBFHydE8JZwX4JEMCtOC0Dvo+qcZFklLq0td1sTSYJkF4312/5s6kqCyqL2q68g0DBc9qko/U3RW3sNl6Tlc8N8GO2wsHPc8/tb6es+b6JFPHMlsp/tY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCHxKw3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFBAC4CEF4;
	Thu,  2 Oct 2025 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759426763;
	bh=CpJbQiQzc/Zz/i3BHy97csps9TKRZRRFA7h8wc9Gjbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCHxKw3QHv9Ms+pj2fBRFuGDY0andUTExnAAnUFn8xjqxtx+2ZqTFaCOMfpno4uTA
	 ZCmUttYtM2OIxkJvLCbIkQKIa3DF8QZz0X+24NMCABVSFh86IhgNuoMk4umCwWvgtE
	 zYkzD110A5Gy0OGomks2/nungiYWmTKSiRbvhvAeJwSNEx9Xo6sJ1WwT3sLU/17TD9
	 n3aCqnZINIVuSUf16/+DLfWMyK9KQJFiT3XdYwRrvvyiFgRCJGWlTVR8koG+QnXIs9
	 7Ym7+aETMhBUleHyUFK6qf3omBfGQmQBJAWg4SfJzFvot+ng5e9YytXv4+Yqfta9Qi
	 1a319zyP2LT0g==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Jakub Acs <acsjakub@amazon.de>,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	peterx@redhat.com,
	axelrasmussen@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: redefine VM_* flag constants with BIT()
Date: Thu,  2 Oct 2025 10:39:20 -0700
Message-Id: <20251002173921.58664-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <fc539c61-7a28-42ee-a28a-fef987967958@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Oct 2025 09:29:37 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 01.10.25 18:51, SeongJae Park wrote:
> > On Wed, 1 Oct 2025 09:03:53 +0000 Jakub Acs <acsjakub@amazon.de> wrote:
> > 
> >> Make VM_* flag constant definitions consistent - unify all to use BIT()
> >> macro.
> >>
> >> This is a separete follow-up fix after we changed VM_MERGEABLE
> >> separately to isolate bugfix for easier backporting. As suggested by
> >> David in [1].
> >>
> >> [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
> >>
> >> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Xu Xin <xu.xin16@zte.com.cn>
> >> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Cc: Axel Rasmussen <axelrasmussen@google.com>
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>   include/linux/mm.h | 66 +++++++++++++++++++++++-----------------------
> >>   1 file changed, 33 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index c6794d0e24eb..88cab3d7eea2 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -246,56 +246,56 @@ extern unsigned int kobjsize(const void *objp);
> >>    * vm_flags in vm_area_struct, see mm_types.h.
> >>    * When changing, update also include/trace/events/mmflags.h
> >>    */
> >> -#define VM_NONE		0x00000000
> >> +#define VM_NONE		0
> > 
> > I'm wondering if it could be more consistent to use 0UL instead.
> 
> Not really required, and if we're switching to BIT already there is not 
> a lot of consistency to be had. Would be different if we were avoid 
> BIT() is in patch v2.

Agreed. :)


Thanks,
SJ

[...]

