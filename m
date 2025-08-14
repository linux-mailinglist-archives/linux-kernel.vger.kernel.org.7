Return-Path: <linux-kernel+bounces-769718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5839BB272CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A625E77FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939B2877CA;
	Thu, 14 Aug 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0R/JyhNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183E2877C5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212955; cv=none; b=kIaMUk3nYzDUZiUstCLGOAFxfdTn2E9C9QRwRVu5wrlshbvodK/QvPcAVhKkPOp55B43F//E0LGl4+onJWhrYHbJdumkenEcJ8TrMQRk9l9WFwQAueFg9iJvvO3iyKo+5/JmCB+jv41+wQdwwmCnnLl8yjx4Tlvf2a6k/wfkpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212955; c=relaxed/simple;
	bh=8+3X2KbhAIZ4Bx08PApMHwoBqmWQTqqkpPsM0eZcjoY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d4iN+o0SUESQB06+x9iCBe7j9SSReMZbaoi+FahqccInQDHCEohy1U7IVeE1IVL8iGJMOk8BP54edG/NVxgASr1zz00CrVxqgyu19u3VLMU/r0F+Px5dDFQI209br4RM656sUyOejsl3EqKpvhy9dNd3X0QuQ+U3gLEzNrEdS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0R/JyhNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EA2C4CEED;
	Thu, 14 Aug 2025 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755212955;
	bh=8+3X2KbhAIZ4Bx08PApMHwoBqmWQTqqkpPsM0eZcjoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0R/JyhNGgq/eZXZdrifW43th1gOVFSjuevoez3EcC7Ev3iF0mZiqmMuJEn/orhgdv
	 dgMvFVRZJzIVKW0m/EuWolNPBJfDx3GGkVphPCRP6l2x6VMTiCYpUAZaHh5UXdkhfu
	 vbUpWP605ZV30nzT0a1/ThIggXXfjwIrRk4X46/M=
Date: Thu, 14 Aug 2025 16:09:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: <zhongjinji@honor.com>
Cc: <linux-mm@kvack.org>, <mhocko@suse.com>, <rientjes@google.com>,
 <shakeel.butt@linux.dev>, <npache@redhat.com>,
 <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <peterz@infradead.org>, <dvhart@infradead.org>, <dave@stgolabs.net>,
 <andrealmeid@igalia.com>, <liam.howlett@oracle.com>, <liulu.liu@honor.com>,
 <feng.han@honor.com>
Subject: Re: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite orders
Message-Id: <20250814160914.7a4622ae1370092dde11c5f2@linux-foundation.org>
In-Reply-To: <20250814135555.17493-4-zhongjinji@honor.com>
References: <20250814135555.17493-1-zhongjinji@honor.com>
	<20250814135555.17493-4-zhongjinji@honor.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 21:55:55 +0800 <zhongjinji@honor.com> wrote:

> When a process is OOM killed, if the OOM reaper and the thread running
> exit_mmap() execute at the same time, both will traverse the vma's maple
> tree along the same path. They may easily unmap the same vma, causing them
> to compete for the pte spinlock. This increases unnecessary load, causing
> the execution time of the OOM reaper and the thread running exit_mmap() to
> increase.

Please tell me what I'm missing here.

OOM kills are a rare event.  And this race sounds like it will rarely
occur even if an oom-killing is happening.  And the delay will be
relatively short.

If I'm correct then we're addressing rare*rare*small, so why bother?

> When a process exits, exit_mmap() traverses the vma's maple tree from low to high
> address. To reduce the chance of unmapping the same vma simultaneously,
> the OOM reaper should traverse vma's tree from high to low address. This reduces
> lock contention when unmapping the same vma.

Sharing some before-and-after runtime measurements would be useful.  Or
at least, detailed anecdotes.


