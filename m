Return-Path: <linux-kernel+bounces-619160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A214A9B897
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 21:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DAD4A3E14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A5292912;
	Thu, 24 Apr 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdVemTkx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC022918DA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524677; cv=none; b=vAded87CgrG4tPSmTgOpEYd3U3M9KAq1ahaBUK9csL2s9oq4M4DCf3lPR5vk9IY3RoPPzlmry6sZmHDJzyKe+FAk48n5WUVNeZpF/UQmvp28RJTp7KONv+Kno5i3wwufhqmVevrmeaEb9ntQeF2Yp2wfgdAVaQf66Mj9iWI7G/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524677; c=relaxed/simple;
	bh=56tG6cfOVThEkd1go1seyUGyB1KU/yRwCu18qPO4ofs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ+WgHeoQis3LWtgDQnRChC5TZc9UGozd3icvJiHeoQPMya2OlbQvdalekgqEcrJe4FrGFX3Ye76ZKYy9XHllqGu+XcPcmkJIerNCorXiwWHgrulrN2NmuPsXD6EhvXuMh0YikZpyV+ySbOjBEOC5z07kwmzdgtBMYfhoHQYT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdVemTkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BA0C4CEE3;
	Thu, 24 Apr 2025 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745524677;
	bh=56tG6cfOVThEkd1go1seyUGyB1KU/yRwCu18qPO4ofs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MdVemTkxV3OBU7ew3CC/ZHigqfT1yqtFnx2Av+M9LEKolhBS/XuYE+ax2PUQ+PVY8
	 PEX/tz7VvMrGIQx4pO88oPtF5tg3AWorE8LfRxqls9bpCg7TEET+1z7ddeWmZ+e8NJ
	 b80ObZNDHIkm1J2M1j99di0x58nuxkdVsIKvxz4iTAcJHHorMub9jd8u+NS0pCcnbI
	 Jalxvht9p1LSGaBXsOFeg/irLbt4HCZbVFo35QkYBzpgJsIN970saR+Jhu2J5G5JOh
	 syDbJHDcKsePdhjUFRmcnd3nqFEl1qEBJJQU5apfheYdT0Bntn2Zph5sYvAQfC/jrH
	 2Rb9olU+JUjhw==
Date: Thu, 24 Apr 2025 09:57:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Philipp Stanner <phasta@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: flush all pending jobs in destroy_workqueue()
Message-ID: <aAqXw3t9UVU8pF8_@slm.duckdns.org>
References: <20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com>

Hello, Alice.

On Wed, Apr 23, 2025 at 05:51:27PM +0000, Alice Ryhl wrote:
...
> @@ -367,6 +367,8 @@ struct workqueue_struct {
>  	struct lockdep_map	__lockdep_map;
>  	struct lockdep_map	*lockdep_map;
>  #endif
> +	raw_spinlock_t		delayed_lock;	/* protects pending_list */
> +	struct list_head	delayed_list;	/* list of pending delayed jobs */

I think we'll have to make this per-CPU or per-pwq. There can be a lot of
delayed work items being queued on, e.g., system_wq. Imagine that happening
on a multi-socket NUMA system. That cacheline is going to be bounced around
pretty hard.

Thanks.

-- 
tejun

