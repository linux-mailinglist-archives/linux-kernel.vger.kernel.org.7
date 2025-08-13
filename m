Return-Path: <linux-kernel+bounces-767554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A340EB255D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2110D5A3C66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663E2ECE8C;
	Wed, 13 Aug 2025 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BzsGehsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6A2E54D8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121658; cv=none; b=J0UQLSjQE1djpWRnwzev4g1mmS3M2bozHHAElCyuajKK6EI3HDHmPaxUaZXQzvBPtPnUElU6oFDiHoHXV1p4hL9llaGSNsMzE8PdI3+GwCTGtcNqRsJy0me0I2r1p4/Kxweq+HTCHJGJBkAwnbtspGY6/AHPHyW8RtbBhpGPPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121658; c=relaxed/simple;
	bh=9owTMvtzsi8RT8rpO3avGMKwTlUwvjGyNVoc27VfaMs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f4RxiOHbFrPjgJEkAyEXlwM583n+lMmNZp2i6dJWSuWn2kghV8jsii5BfcEK38wz7S+QvxFADjsSk08JzFzAftC5HJWtRgXWQzOc/RxDUFvU23ndmK9j5d94aq2cTW307//V5tOsuWOVJlDPyC9Av5r7pNQZCaBupWt5GjGUrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BzsGehsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0572AC4CEEB;
	Wed, 13 Aug 2025 21:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755121658;
	bh=9owTMvtzsi8RT8rpO3avGMKwTlUwvjGyNVoc27VfaMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BzsGehsFkISgFM9oRKX+a5a0If+eYAOyaabyHYBqp6nLek4af8aNRZLJaNkaSGkQk
	 KidyC7bZOPQc2WnJWgiJcSAJSt3NzqXXp7Yfb4z/wrO232NE3sFnXcsnVcPPtIo8U3
	 X5WxE3Dgurymzqv0280RAxKZgj+fujz25nS16aOI=
Date: Wed, 13 Aug 2025 14:47:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 21cnbao@gmail.com, ngeoffray@google.com, Suren Baghdasaryan
 <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, Barry Song
 <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
Message-Id: <20250813144737.c3f388313fe13ff44856daf5@linux-foundation.org>
In-Reply-To: <20250813193024.2279805-1-lokeshgidra@google.com>
References: <20250813193024.2279805-1-lokeshgidra@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 12:30:24 -0700 Lokesh Gidra <lokeshgidra@google.com> wrote:

> MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> for moving present pages. Mitigate this cost by opportunistically
> batching present contiguous pages for TLB flushing.
> 
> Without batching, in our testing on an arm64 Android device with UFFD GC,
> which uses MOVE ioctl for compaction, we observed that out of the total
> time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> ~20% in vm_normal_folio().
> 
> With batching, the proportion of vm_normal_folio() increases to over
> 70% of move_pages_pte() without any changes to vm_normal_folio().
> Furthermore, time spent within move_pages_pte() is only ~20%, which
> includes TLB-flush overhead.
> 
> When the GC intensive benchmark, which was used to gather the above
> numbers, is run on cuttlefish (qemu android instance on x86_64), the
> completion time of the benchmark went down from ~45mins to ~20mins.
> 
> Furthermore, system_server, one of the most performance critical system
> processes on android, saw over 50% reduction in GC compaction time on an
> arm64 android device.

Were these inefficiencies a regression relative to an earlier kernel?

