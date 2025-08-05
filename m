Return-Path: <linux-kernel+bounces-756038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCBBB1AF01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB963A8860
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26512253E0;
	Tue,  5 Aug 2025 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLxw7I69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF282248B0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377201; cv=none; b=j2MAL9B7xMVusUP/jOlMtJHNR08rdX3AnYzrDMWyQAs2JT8c5nou/neJHTD/DudOSNntUclbY92hM/odHbi9padZzrkAYZGqvW0lXbRhAS5QKKIHbJ0DQ88Tn7fPYfDJ3OcRhLX2sGIP6mbp1UuRA2MeWGiVpTZBvjIMSkXTXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377201; c=relaxed/simple;
	bh=0uYqnbPDze1SZb+yrC9TJphGZQHscAgYxRNN8YGVzU4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SF2zk8CJYl7j0NV0bzymbq3Q6+S5mmd9VWhkMAYnYiRcsCOCqSWe7uMASXfFRsmasr720GH0f/YRkhMu9ksNaj9+kRRKlbgbgjdY/kikShxuuwU5I5A1XDOmQO4nGwoHKaej4P7FMCdTW0ENAR+fpCroEmz7mXFLjYjTzT2GmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLxw7I69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AA0C4CEF4;
	Tue,  5 Aug 2025 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754377200;
	bh=0uYqnbPDze1SZb+yrC9TJphGZQHscAgYxRNN8YGVzU4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QLxw7I69GjxAu5wWXTEzk5lSJa0bN1yLsTKh0cM6AdduIqxkMm6ra/YBFrO8uV87+
	 xjWNFDX6j14YDr1oJGXrm+Ej/RdGl+OiW0LBxGjaZhQBbTJ6Erd4Zso6LPS6oxMiy1
	 TFaHBkja+Nwc+i0gOuC0QToEJhhXqzLc8BFFyq3uesuB9QY4YhJONGtIfNPywMKnkn
	 ZY+84TkFZU8qQL1gYQJYXNloLQXvR9nvPHA1aa2Lsb1fhUqwsQ6SSydzBZgvKKeT+Y
	 1dE8YffXuqwjlcRLAXryLvfctjD8q/4YbyRsh8+X4dXF58p3TtdPqEOUuONDS/qrat
	 EW23PtK2mQwzw==
Message-ID: <f2f8cbd8-af49-475b-8b9c-e00250263007@kernel.org>
Date: Tue, 5 Aug 2025 14:59:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] f2fs: add lookup_mode mount option
To: Daniel Lee <chullee@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250805065228.1473089-1-chullee@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250805065228.1473089-1-chullee@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 14:52, Daniel Lee wrote:
> For casefolded directories, f2fs may fall back to a linear search if
> a hash-based lookup fails. This can cause severe performance
> regressions.
> 
> While this behavior can be controlled by userspace tools (e.g. mkfs,
> fsck) by setting an on-disk flag, a kernel-level solution is needed
> to guarantee the lookup behavior regardless of the on-disk state.
> 
> This commit introduces the 'lookup_mode' mount option to provide this
> kernel-side control.
> 
> The option accepts three values:
> - perf: (Default) Enforces a hash-only lookup. The linear fallback
>   is always disabled.
> - compat: Enables the linear search fallback for compatibility with
>   directory entries from older kernels.
> - auto: Determines the mode based on the on-disk flag, preserving the
>   userspace-based behavior.
> 
> Signed-off-by: Daniel Lee <chullee@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

