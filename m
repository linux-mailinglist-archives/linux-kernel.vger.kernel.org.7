Return-Path: <linux-kernel+bounces-887693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11861C38E41
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4573B5FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD043242D6C;
	Thu,  6 Nov 2025 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="hU3tts/k"
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D11A9F84
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396836; cv=none; b=l4/dxDUll3kB2IRMrYg5jJBwQnsFS8OpgX3EpHzzllm1zPAVlXiwUNjFaY0HvVEURaUx+IZZ2O/jF1B1AmfPEKXSB+RuqzGDSxOvzBak4zC0JS8aXqbumVUMwMj5A3CLa3zfzvFHnT0twlo5i/iaSOOnvi2FP5tZtZ0xo/NwpLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396836; c=relaxed/simple;
	bh=84yVhO4YOwy7McOUfNihgVUCDl1jZUc8MXppenE6hH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnQZC9teVmI3xpQVI2rM3y0PeQsNK2laprtMMAs7WO453rsJ2MX5tJwR5pOWlxofjMH0ILOW4R5zR53/GOed/uYYk+44/p0gRqOgpdRfuSzavyw24qdGRuksFxwkWJCX10YmM9JiH/yOs4jJRNxd9GIeeYFd9ldXHmQ42urYFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=hU3tts/k; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762396829;
	bh=swnUrd0MeXSi9bZIvDS2KXEraWlxYd+GnPUoFbIY99o=;
	h=From:Subject:Date:Message-ID;
	b=hU3tts/kLh4Msx/nEIAl5q/ZiKg+7UHKS0VwK0dzumGarLbH3Fbaqf/33dtDvTq4w
	 G/cbMIzbjIW6ZNDGSJIyxG1HxJ1qol2y/AD/f46B9ofziSoYM7Vk0mJ31vY9Vvsg4k
	 NxZgcjpbH8aBb7/samXJ4kmaoz3Meq0UJau1EBHw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 690C095500000D97; Thu, 6 Nov 2025 10:35:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5734166816353
X-SMAIL-UIID: 1F066F0A0E2B4467A1ADB457BFC95624-20251106-103503-1
From: Hillf Danton <hdanton@sina.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Calvin Owens <calvin@wbinvd.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [QUESTION] Order-4 allocation failures on reads with 256bit csums
Date: Thu,  6 Nov 2025 10:34:51 +0800
Message-ID: <20251106023454.8888-1-hdanton@sina.com>
In-Reply-To: <0f137e3f-7b9b-4fbe-a8f7-2c90dad1a5fc@suse.com>
References: <20251105180054.511528-1-calvin@wbinvd.org> <cc115783-7b1c-4196-a06d-08008277141c@suse.com> <0f137e3f-7b9b-4fbe-a8f7-2c90dad1a5fc@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thursday 11/06 at 07:31 +1030, Qu Wenruo wrote:
> 在 2025/11/6 07:24, Qu Wenruo 写道:
> > 在 2025/11/6 04:30, Calvin Owens 写道:
> > > Hello all,
> > > 
> > > I'm seeing order-4 allocation failures reading from btrfs filesystems
> > > with blake2b/sha256 checksums, on a couple different machines.
> > > 
> > > I don't think I'm doing anything interesting: in both cases they were
> > > idle except for a single-threaded file reader doing buffered I/O. The
> > > first one was an x86 QEMU VM, the second was a raspberry pi 4b (below):
> 
> Another thing is, although the order 4 allocation is indeed large, it's not
> that unreasonable large.
> 
> The problem is still that we're requiring physically contiguous range which
> greatly reduce the chance to get one.
> 
> Another point contributing to this is the order 4, which is beyond the
> PAGE_ALLOC_COSTLY_ORDER (3), thus no more retry is done thus can fail here.
> 
And the flag GFP_NOFS, though correct, in this report that makes any high order insane.

> In fact for your aarch64 case, you can configure the kernel to use 64K page
> size and in that case such allocation will only be one page thus will almost
> never fail.
>
> This leads to my final question, what's the memory size of the RPI4 and your
> qemu VM?
> My guess is there is a very limited amount of memory (1GiB?), but still a
> lot of large buffered IOs.
> I guess enlarging the VM RAM size will hugely reduce the chance of memory
> allocation failure.

