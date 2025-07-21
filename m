Return-Path: <linux-kernel+bounces-738990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18181B0C04D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0FF3BAF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F9B28C5D9;
	Mon, 21 Jul 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmrxHLoc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62128C03B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090139; cv=none; b=oZYYwFPCWGx/CvPICGIr72hanSwpgQ0TkNrEOL4npvkTgrHrpAIfLtkoatv/01yKEGrP3h3OIuM6zUTnyMaqqR9xSEEmLEB26pH2u7avTEnn/MPBSs2xemOtjq4j6crABbd7MATqPuUDGdC4z8v0HlK2XPQcgu63vvKqNOAI6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090139; c=relaxed/simple;
	bh=e3MjNw40SX9uSql+9WWt4ZuNq+HJ7mKB5glLjQZhIwA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fYu7NlOvNHvAtcR9XHkTOliZtWqy66NT9HAcH58KyOl5LTwKhZQYq0VUKnXHf2jSrSW2niW4V9zMC9L+mAZIlnjfPf00nwKfx0mmOSmJy7++n9/Aw/FvhrW9poxzlpcP9Lo66pEnTXzDUCoNMqVbsJZRCXnm/S28FRQ81L5xCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmrxHLoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50857C4CEF7;
	Mon, 21 Jul 2025 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753090139;
	bh=e3MjNw40SX9uSql+9WWt4ZuNq+HJ7mKB5glLjQZhIwA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DmrxHLocad1e5UmD+gC/k3Kg1u3jitMAQ4eHyWaueJxvbaoneX/MGxSs/4n19lbjh
	 o+vlJ6PZ7JsUvLnXodZtV9i/mS7OJ4AWuSbLo7jKJw4sWKjiYttb0h0d8QHB2mkGVW
	 Fy9lZ4Xvty542YzW4cfGsb2mQoZ7XnjwrCdHnLW7cLl/9CdZBd7DEDlOKZ1DDxEF+q
	 j5iDY6psq/YlPU4bQeas8aIcna7BmOCyr16xC93N+1//P99DXAVIjsVIc+k/SW8Boc
	 7RVYrCtNAigPiZdX3ose8yoj37FzSujhlSofEshnIue7QqPVKkGCe4b/GuG3hr3zaR
	 LQGnnit8zr3nw==
Message-ID: <b66bc9ae-2ed9-499c-a06f-6f9817880fa8@kernel.org>
Date: Mon, 21 Jul 2025 17:28:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] erofs: add on-disk definition for metadata
 compression
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
 <20250717070804.1446345-1-hsiangkao@linux.alibaba.com>
 <20250717070804.1446345-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250717070804.1446345-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 15:08, Gao Xiang wrote:
> Filesystem metadata has a high degree of redundancy, so it should
> compress well in the general case.
> 
> Although metadata compression can increase overall I/O latency, many
> users care more about minimized image sizes than extreme runtime
> performance.  Let's implement metadata compression in response to user
> requests [1].
> 
> Actually, it's quite simple to implement metadata compression: since
> EROFS already supports per-inode compression, we can simply treat a
> special inode (called `the metabox inode`) as a container for compressed
> inode metadata.  Since EROFS supports multiple algorithms, users can
> even specify LZ4 for metadata and LZMA for data.
> 
> To better support incremental builds, the MSB of NIDs indicates where
> the inode metadata is located: if bit 63 is set, the inode itself should
> be read from `the metabox inode`.
> 
> Optionally, shared xattrs can also be kept in `the metabox inode` if
> COMPAT_SHARED_EA_IN_METABOX is set.
> 
> [1] https://issues.redhat.com/browse/RHEL-75783
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

