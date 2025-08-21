Return-Path: <linux-kernel+bounces-779820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51540B2F98D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D3AAE2DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47B31CA59;
	Thu, 21 Aug 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLjdZUQr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA12E0B4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781331; cv=none; b=sVQL/FUL9COPnqsJ2P7+EZGhE1OScucDi7zAuLgvbwwpfXy+fbiDVGyB6sJkS+XhrOiDAIocVMHk1NJ56foBqX2BJN9N9VVd7n0qyhTGC+5mTxkdhjjCB3NaSHV+oASFirZWa2o0CfiWGG+UBz3lM2qIuLB6VRAJ1QagSPT9a7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781331; c=relaxed/simple;
	bh=HNHiZLThPQ887txOD81b+D+T9uJUF8eSiY2C4Hx0+CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCeopoTIlEEn9g/xoKgTDV8HpHwJ80kt6AcONSsMGoWcNeOC02NRd7dUSoN1WDgvGZ3n4h5hj7xaFUuRY2yIUTm21SyuNXK4n69MD3HbgWkLsVbLvw5ZEQas8CjnaUiARxDbm3vi4nVLkBYezs35Dza5qd9VNgzlnZ++DOH1QDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLjdZUQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EA3C4CEEB;
	Thu, 21 Aug 2025 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755781331;
	bh=HNHiZLThPQ887txOD81b+D+T9uJUF8eSiY2C4Hx0+CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLjdZUQrco0yrBsfgTjmkII/EchFrBZc3oUnkgzCbhO9PiSuT3OJHBPNnOmZU/qcm
	 W8vSazTpvJGQ56zyEZcwal9IKlGpIMiBSAUQNh1nbU/Fgt5M6/X2HfsBYi9Ybl1qc0
	 NbgexLJbd+TEdcLzM/VVHiY956Fk0Fw5O9k2IjmURetxJcXVRk0tDyZpYJOSXuVuTT
	 HhRAAHWu42OkPojnJYm+GyOszaNXb5xGvT/Wi6yQlg3rRxO0cjwc08lXmyAQjSNsD5
	 jMueGfHlncQvGJfTVm9vGi2NizVzLpE9Hyl0kFnSGhn88LekF/R6ScFKoKrN6IF1be
	 hWX9ZG06deOtQ==
Date: Thu, 21 Aug 2025 09:02:10 -0400
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, surenb@google.com, aarcange@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix kmap_local LIFO ordering for
 CONFIG_HIGHPTE
Message-ID: <aKcY0ocUDHnLJv12@laps>
References: <20250731144431.773923-1-sashal@kernel.org>
 <20250801141101.9f3555a172609cb64fde7f71@linux-foundation.org>
 <aI04CQZZzgCDO2A5@lappy>
 <20250820212423.fbac2b17eb4f6a9667a8c979@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250820212423.fbac2b17eb4f6a9667a8c979@linux-foundation.org>

On Wed, Aug 20, 2025 at 09:24:23PM -0700, Andrew Morton wrote:
>On Fri, 1 Aug 2025 17:56:25 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
>> >> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>> >> Co-developed-by: Claude claude-opus-4-20250514
>> >
>> >Well this is innovative.  I doubt if Co-developed-by: is appropriate
>> >for this (where's Claude's Signed-off-by:?)
>>
>> Claude (or any other AI) can't legally sign off on code :)
>>
>> >I'd support creating a new changelog tag for this case.
>>
>> This is in the context of a proposal on workflows@:
>> https://lore.kernel.org/workflows/20250728105634.GF787@pendragon.ideasonboard.com/T/#t
>>
>> The Co-developed-by: usage wasn't my proposal, but it looked like the
>> majority of folks were okay with it.
>>
>
>I need to do something about this and the discussion over on
>ksummit@lists.linux.dev has been as beer-addled as one would expect.
>
>Oh well.  I guess for now we can welcome Claude to the kernel
>development team.

FWIW, I've switched the new RFC to use Assisted-by: as suggested by yourself
and David. If you'd prefer, I can resend it with the Assisted-by tag instead.

-- 
Thanks,
Sasha

