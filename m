Return-Path: <linux-kernel+bounces-884157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED62C2F7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE21F3B6984
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0262017AE11;
	Tue,  4 Nov 2025 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cx6vSjls"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D53DDD2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238821; cv=none; b=rcbAZRgCxxAdnDiz2Di8lcUw7S/oL5y6nwbbT4QenSlJXgGBL0NE8oCwDcixZW2v3TKw7n3FKHGOXbp/KZEIEzYf7daPq6dyg9JabmcWi9tCaAAXi/A2GkGRKmeNSRMaV3OHK0PPdV5Pdw/EbKXDB3Ed6J5R820zJhCyRjwEQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238821; c=relaxed/simple;
	bh=p5YlA4nWIx2zDvbAyHqnAgk5s0hh1Yuv7pMKyeUt/nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1NUd7D7VDF+JGqlLqpgsT4yMRfdOCRRixAfi7hyHaGBJ2BlK2Ea1RAFWk3/GHTRv++yHwoJf6jVnuuQvlnamWrpHm1ZjZFO7yVCRixEhNNOxPenOsJhtBtZY4KzPFqJQSpBBNI8YYZVpwh0Mci0RJjyORBkonxim8TGyWBKH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cx6vSjls; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1248c78a-c471-496b-b7ac-892ac7335a08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762238806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zypHK8xHj9d3wyeceDQrjDFX1DeChKWeDe7WPWRLSEE=;
	b=Cx6vSjls3xtNhjsQyQeVEHRebXJStsAS07c8FAEpurFDb6DP0Y4M4nHW7cpO1JVUVpbsmO
	vX3z9vLIiCv48Kbke9okwi5JO7pX9eP89jkv/Z9o7MtTRWmS2WYpqM2+ft9J4oi/24QSl1
	XdRXBJt8b63gBnhScAhxkdSNZcwilQc=
Date: Tue, 4 Nov 2025 14:46:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] dm-pcache: avoid leaking invalid metadata in
 pcache_meta_find_latest()
To: Li Chen <me@linux.beauty>, Zheng Gu <cengku@gmail.com>
Cc: dm-devel <dm-devel@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20251030123323.967081-1-me@linux.beauty>
 <20251030123323.967081-4-me@linux.beauty>
 <CADSj-VoQerDc2UUfBOknRMGetSddMEqRKaC3VDniD+xCq0pH1g@mail.gmail.com>
 <19a3f8ae9db.8a18892d3330798.1127794710232272337@linux.beauty>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
In-Reply-To: <19a3f8ae9db.8a18892d3330798.1127794710232272337@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 11/1/2025 9:10 PM, Li Chen 写道:
> Hi Zheng,
>
>   ---- On Fri, 31 Oct 2025 10:01:23 +0800  Zheng Gu <cengku@gmail.com> wrote ---
>   >> On Thu, Oct 30, 2025 at 8:36 PM Li Chen <me@linux.beauty> wrote:From: Li Chen <chenl311@chinatelecom.cn>
>   >>
>   >> Before this change pcache_meta_find_latest() was copying each
>   >> slot directly into meta_ret while scanning. If no valid slot
>   >> was found and the function returned NULL, meta_ret still held
>   >> whatever was last copied (possibly CRC-bad). Later users
>   >> (e.g. cache_segs_init) could mistakenly trust that data.
>   >
>   > This functions is * __must_check*, users must check the return value first before touching the meta_ret, so it should not be a problem here.
>
> Right now, the callers only check the return value with IS_ERR(). If the
> function returns NULL instead of an error pointer, a caller like
> cache_info_init() will assume that no valid cache_info was found because all cache_info are
> corrupted. Instead, it will try to init a new one, and then return 0 (success),
> https://github.com/torvalds/linux/blob/master/drivers/md/dm-pcache/cache.c#L61
>
> Later, cache_tail_init() will access cache->cache_info.flags. But in this
> path all cache_info may have already been corrupted, and the CRCs are mismatched
> (https://github.com/torvalds/linux/blob/ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7/drivers/md/dm-pcache/pcache_internal.h#L97),
> so flags may contain garbage.
>
> This commit fixes this issue by allocating a temp buffer with kvmalloc, so meta_ret would never
> contain corrupted values.

Hi

     Thanx for your fix. So the better change should be reseting 
cache_info in cache_info_init_default() firstly by memset() with 0.

Allocating a temp buffer in pcache_meta_find_latest() is really not a 
good idea.

Thanx

>
> Regards,
>
> Li​
>
>

