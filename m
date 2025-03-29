Return-Path: <linux-kernel+bounces-580893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165EA757BF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 20:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C709D7A531B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10E0190470;
	Sat, 29 Mar 2025 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FrJTbrqS"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A421EB3D
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743278010; cv=none; b=iycKaJIYCCqcPzQ5TZiFxg/ZKYEtvgZTkM+kWPqKTWEAM6tA3gSoNrK0nEL2WseesuSJWSU1iSpQtBRVNCxFnah2dUc7H6XJBZqaYSxC+QiRs7eLhusdQToo5hG4ahRNhzZr6xO6DlPSj8BF5hPB6WYYueCyCsdoGZUisLgAP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743278010; c=relaxed/simple;
	bh=ME1fBO5Jh7xEa67T+MF0kiPosGpY29d6ns5G/AbMfrI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=rrt7EbwQBo+82zJupPzb4jL86gISTPcKyH0VkZS1mAiLL5kgfEmoM6QHBQRY0XfZpkmmoc5kHeBAe1gyRwxD/Q682L+PvzPe/ThCoyuqhMgJAldLkfe0tVlqnEcPQbwb0Q1tzyhO2S88O2qrPuXBOOP9PJTqCxnVd0ROFzcO06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FrJTbrqS; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743278006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ME1fBO5Jh7xEa67T+MF0kiPosGpY29d6ns5G/AbMfrI=;
	b=FrJTbrqSP9wgn9WjYsD4xZr35TJFbcMCIw0hf+C5ZLFqizCcYh4WdAYysMmoHk98J9BlgW
	1ny8mVqF0OJgZx0+W6FirtSrUVwyquaoI/feHaQRZxijkeSHntDcokRVrfzRIiFRW9wKKn
	/yoj2JdXBr143TT+1OLPY4DAsbZO4d4=
Date: Sat, 29 Mar 2025 19:53:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <2759fa95d0071f3c5e33a9c6369f0d0bcecd76b7@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH 0/2] zswap: fix placement inversion in memory tiering
 systems
To: "Nhat Pham" <nphamcs@gmail.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
 sj@kernel.org, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 gourry@gourry.net, willy@infradead.org, ying.huang@linux.alibaba.com,
 jonathan.cameron@huawei.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org
In-Reply-To: <20250329110230.2459730-1-nphamcs@gmail.com>
References: <20250329110230.2459730-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

March 29, 2025 at 1:02 PM, "Nhat Pham" <nphamcs@gmail.com> wrote:

> Currently, systems with CXL-based memory tiering can encounter the
> following inversion with zswap: the coldest pages demoted to the CXL
> tier can return to the high tier when they are zswapped out,
> creating memory pressure on the high tier.
> This happens because zsmalloc, zswap's backend memory allocator, does
> not enforce any memory policy. If the task reclaiming memory follows
> the local-first policy for example, the memory requested for zswap can
> be served by the upper tier, leading to the aformentioned inversion.
> This RFC fixes this inversion by adding a new memory allocation mode
> for zswap (exposed through a zswap sysfs knob), intended for
> hosts with CXL, where the memory for the compressed object is requested
> preferentially from the same node that the original page resides on.

I didn't look too closely, but why not just prefer the same node by defau=
lt? Why is a knob needed?

Or maybe if there's a way to tell the "tier" of the node we can prefer to=
 allocate from the same "tier"?

