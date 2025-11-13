Return-Path: <linux-kernel+bounces-898768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55768C55F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40EE84E415B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40B2320CD6;
	Thu, 13 Nov 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFSc3Vf5"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB7320A0E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016235; cv=none; b=FQC1gAngOYF9EmHQd8ruWJk9YdAnrkTiAMVIzB9GpN/AT1eQMXbkU+FxhYgggNXFKaZb/XpHxM/9uucKYje67L3cETiufMZkAIU6lVwc/Ok8bGlrvJLlU0t/RezBKaZPzdI4jx4o9qrpqUbaA6f/230KRO0kWbbFVt8A9re7umg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016235; c=relaxed/simple;
	bh=tSYubWD2DzdeMFCtkfp6zGvGN6OjzN7OK2x4amL0ixE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ps7no47Z7pekSCwfcvv+iVme4OGxyDmqNw6JWIz35gutkEsEQ8VxPupNDpsI4CsLLii2rjkSQDXKVud6qt3QpwWtDDaRwxw8dIBYk0gwYiGvP3KQTe+46+QAfabUlVADR2Bg5GRPQ95X90nB8X02/eR3nNQXNPnKl8VYGHKW2tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFSc3Vf5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <520bf329-8e3b-4b27-9bd5-82092d501174@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763016230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYYGUn2P3Y/iSITP6NTSnslXySDF9DeF8ONeprLe5FE=;
	b=bFSc3Vf5Tll60JAOuChtaglxPn2qJ35dWkXnjXPWZQ/T+mz0S1IM7ewAEpdH57pM4CqrHO
	yGvg14mWBc33eXYRy86LeNd7yrkbU1Qmt45eCdky8X8LIcJkboQLbQqRO5H5Y+UqzdTsdv
	imoxGjMk4szjXhPLL+WIKeYjxB9LD2I=
Date: Thu, 13 Nov 2025 14:43:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] dm-pcache: built-in support and metadata hardening
To: Mikulas Patocka <mpatocka@redhat.com>
References: <20251111121337.1063443-1-me@linux.beauty>
Cc: Li Chen <me@linux.beauty>, Linux Device Mapper
 <dm-devel@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Zheng Gu <cengku@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
In-Reply-To: <20251111121337.1063443-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Mikulas,

     Please consider taking these three patches.


Thanx

Dongsheng

在 11/11/2025 8:13 PM, Li Chen 写道:
> From: Li Chen <chenl311@chinatelecom.cn>
>
> This three-patch series tidies dm-pcache’s build glue and tightens the metadata scan.
>
> Patch 1 allow dm-pcache to be linked into vmlinux and avoids clashing with the sunrpc
> cache_flush() by using obj-$(CONFIG_DM_PCACHE) and renaming the helper across the tree.
>
> Patch 2 drops a redundant recomputation of the metadata slot pointer while walking headers.
>
> Patch 3 Ensure dm-pcache initializes cache_info from a zeroed state so metadata CRC
> failures can’t leak stale flags into the new-cache path.
>
> Thanks for your review.
>
> Li Chen (3):
>    dm-pcache: allow built-in build and rename flush helper
>    dm-pcache: reuse meta_addr in pcache_meta_find_latest
>    dm-pcache: zero cache_info before default init
>
>   drivers/md/dm-pcache/Makefile          | 2 +-
>   drivers/md/dm-pcache/cache.c           | 4 ++--
>   drivers/md/dm-pcache/cache.h           | 2 +-
>   drivers/md/dm-pcache/cache_req.c       | 6 +++---
>   drivers/md/dm-pcache/pcache_internal.h | 2 +-
>   5 files changed, 8 insertions(+), 8 deletions(-)
>

