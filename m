Return-Path: <linux-kernel+bounces-757157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C44B1BE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9AE625E55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD380165F16;
	Wed,  6 Aug 2025 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRSpdYWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684D2E3717
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445085; cv=none; b=AqKBAYr32YAzttcs2X/JYWA0hng0HpvPL7XBHGmmapKfJk61DbPAucARffFPw6yMVyWqNHZqvVKXvukfjJbrJApqeOdlkj0DOEdAL03FUpxjSYJtIQgOZKLmqoHnJ4iIJQq3QQgD18c/wJAN+TJ243eC3rIlU+hMCJ+s4F6hqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445085; c=relaxed/simple;
	bh=PQZc/q65JiHh2RcepehYW3OIxX4IWqymq4kCk+fM0AQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=okKPUUEisAp6uZntR3VuX0Mur5uMm5g5iMMsN4U7tAQO3dTJjD4TVprueHZUJqiwFpVwlpQk4zJP8NFIwvTblO7YUQ+SWa43Nb6Cf0IDwBFE0aHgNX1R/idN5u4K556ndrr9F5W9fC5RBUBmkalaHaPFtg8S/S0JR21xQ6bYapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRSpdYWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C37C4CEF0;
	Wed,  6 Aug 2025 01:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754445084;
	bh=PQZc/q65JiHh2RcepehYW3OIxX4IWqymq4kCk+fM0AQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QRSpdYWQYR+w2LYdyxUXBtmuhF+9HbKn3Z3mvkANZVtnTi6SlnkfF8Byb8fwAwQmi
	 X+L13NeutfFEbr+1dLnBbf3V6u6tYDEhxuRPLshqI1EctW4H8YopKIY25a1gVTU5S9
	 pUMB1NcdP8Q/xaSWlWAwsKhAJtlQHc5AziSU3B7YLcd1HEna+BV0En/NjPQCtZ4ZYD
	 VjRTkoanJPiUWPSTlMXPOpovqOOnSaAvtNaPj/QJYspUSXpf/t49tFyWtvqj9eeJ9a
	 RgB1GP9ZGnziWOBW+Oj8SN3GgIJxSCgv2gBiqwSYTdqupaZ2jOyUClR09a+RWnYgOY
	 UjfBwJeJLnv6g==
Message-ID: <9c7ef111-548c-4751-af9f-335563bda263@kernel.org>
Date: Wed, 6 Aug 2025 09:51:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Qi Han <hanqi@vivo.com>
Subject: Re: [PATCH v2] f2fs: fix to return -EOPNOTSUPP for uncached write
To: Jens Axboe <axboe@kernel.dk>, jaegeuk@kernel.org
References: <20250805061914.3067747-1-chao@kernel.org>
 <587aaee2-8d84-4eb5-9b87-22947abd0752@kernel.dk>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <587aaee2-8d84-4eb5-9b87-22947abd0752@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 23:37, Jens Axboe wrote:
> On 8/5/25 12:19 AM, Chao Yu wrote:
>> f2fs doesn't support uncached write yet, for write() w/ IOCB_DONTCACHE
>> flag, let's return -EOPNOTSUPP instead of ignoring IOCB_DONTCACHE flag
>> and write w/o uncached IO.
> 
> Didn't we agree that write support should be pursued first before
> bifurcating the read/write DONTCACHE support?

Yeah, no worries, this is just used for test purpose, will drop this once
Qi Han prepare the new patchset supporting dontcache in both read and write
path. :)

Thanks,


