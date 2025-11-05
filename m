Return-Path: <linux-kernel+bounces-886178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC25C34EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495771898412
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335D302CAB;
	Wed,  5 Nov 2025 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i05Nw8Zx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE443302760
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335769; cv=none; b=joijUkH4vS8erfshjibr5LV2IgWmJXAXA6dVxyhoiOzeXTvQ6AFlg03phLLIImJBWZBAaAHLYvo7h71BwPN5ipzX86PYcqBgJ80OaTeeisXk2aEYN7cTf0K3sEC89quWxLSbdcnYE86tsCgvKW0cuGvbpUHvgMpeaAHNKofHwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335769; c=relaxed/simple;
	bh=gR67EH2yP9lSn4ONpm8uJrVynpMjctZL7TDFZrX7Q0c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZV4jS2w8gzmPrbNRv5FmQQQwwOAU9B6OxrvYe5cuuTo6SaZpW0l9dvTQe5w9Op6LiQ/cxb7mL5Ov0+PMMKWAbbRYT2rDkgq+0AH6a/wJGQZp6Fm7GonXsz4BzVa7bCBHdXvn0RbsYrvl9q3iWeOJQRVmBoGqeXs56D86QQR3ETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i05Nw8Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15F8C4CEF8;
	Wed,  5 Nov 2025 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762335769;
	bh=gR67EH2yP9lSn4ONpm8uJrVynpMjctZL7TDFZrX7Q0c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=i05Nw8ZxqtMlhl2W3pqtrYZXd/6jrcpaHYNgmhcV/UX4nVr2dpOiic2dBqDa9b50A
	 z09N2HXHoXkZG84XKsfGZwycAz7xzQMOucMN0dk5x/sjxuXkJMbwRi1JD7vO0AxE0t
	 pHVibjAz5qpfR2LLZQRFehpX7nDU783Y+lZ02SY413CmZFcM2XWS5r/4m9OmekJDth
	 lFZor0/CIFgI30jrG77yJL2TaoK/6YV3NcF7s38r06B+xyqWd2suzpyraLQe22/1fY
	 ESjiS9IUMJht8ZeKn8irTZ72kD+GuZoZ2pBrlTgOALQgO8C3ceaQAYUeDoWQVpzVdh
	 mnPDa8OK8RWPQ==
Message-ID: <84a7c83b-529a-4fca-a5d0-4d2015bdeeab@kernel.org>
Date: Wed, 5 Nov 2025 17:42:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs-tools: revert summary entry count from
 2048 to 512 in 16kb block support
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20251104162226.919906-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251104162226.919906-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 00:22, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The recent increase in the number of Segment Summary Area (SSA) entries
> from 512 to 2048 was an unintentional change in logic of 16kb block
> support. This commit corrects the issue.
> 
> To better utilize the space available from the erroneous 2048-entry
> calculation, we are implementing a solution to share the currently
> unused SSA space with neighboring segments. This enhances overall
> SSA utilization without impacting the established 8MB segment size.
> 
> Fixes: 50fd00b168d7 ("f2fs-tools: Support different block sizes")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

