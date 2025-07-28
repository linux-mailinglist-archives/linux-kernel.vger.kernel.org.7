Return-Path: <linux-kernel+bounces-747599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835CB135CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515F518969D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D921C179;
	Mon, 28 Jul 2025 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIkgLdtt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B21862A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753688382; cv=none; b=N5jFNlm5OLyPd4mOYIi8MTgklJyMAiekVlSfVSm+droL6+4xZOAjS010rAHi465Cf3aMWkOvLcbDq3MoBF+sps9EhpsxR5zqOyIJWs97ZZMUYWwAzHLD4DodFhaqLu06ynvpVI5Dk5P17Gee6/nMxJCREGFkvk00ZvY2dv22awI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753688382; c=relaxed/simple;
	bh=xTEiG0sZVynldS/rvbgyjN1VXfeNS4PT9v90gfxqMJQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BbqX11fg0LUL3SrW6ilEXewqh5wF2Q4zeLbEqOL1TndtJGCCIvS/1LzulR1eHvQbTgXhHeuIkfQ1e1ABAKI2xvL98wTgGFTIbY6it7lk55K1HnNJzfr6bQe6kQ/BIRxcb2+FPeOSfIW16xhG+sNRQfCfcXA+LBnE3Q3giELLicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIkgLdtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B437DC4CEE7;
	Mon, 28 Jul 2025 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753688381;
	bh=xTEiG0sZVynldS/rvbgyjN1VXfeNS4PT9v90gfxqMJQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GIkgLdttgxAO2HtwdcLhUal/VtWkP8SjHgHU7YI/2Lr8bWjiTw2mrhBj+WCAvWmJa
	 dNqY1492XTVBcyTEzIrQBqW0l2NY+ah/gWf0gsCK1rp6Be9rSpZuTgogaHWwA1wUus
	 TWyaWMG9NJbRn7qeJqAdz9tgUNEGnvZu6kpiWQWlOT5ZMgGKajSSqtC+Ms+LVYJAfs
	 cvfX5oQ1FBa/RnCPTLFkANYxXBcc7Ga/KgXQpnkue+ZSGsAhqWyK/YKKYs3DC1zJb2
	 NZjwLf/4a0UBw2WyVgklM2eYH/72wA6PqpKd057fl9rpMV2ceHqlMSE6K3Ivu2FBI3
	 2Z1fhl5iHImGg==
Message-ID: <426e38c2-17bd-4461-a4e2-79368ede6daa@kernel.org>
Date: Mon, 28 Jul 2025 15:39:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, bintian.wang@honor.com, feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: avoid redundant clean nat entry
 move in lru list
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250728050237.1563560-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250728050237.1563560-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/25 13:02, wangzijie wrote:
> __lookup_nat_cache follows LRU manner to move clean nat entry, when nat
> entries are going to be dirty, no need to move them to tail of lru list.
> Introduce a parameter 'for_dirty' to avoid it.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

