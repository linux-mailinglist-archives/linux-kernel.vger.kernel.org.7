Return-Path: <linux-kernel+bounces-885981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02944C34709
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C0F4E1919
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCBD28000F;
	Wed,  5 Nov 2025 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4UChklm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E0271443
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330848; cv=none; b=Qj1wIsRDqTfuWlnzurpVpCAjzosvS8U1/xSL3QUPYBmaQZ9OW2BATb7tHYvTe5efuDXScdUgvGJ1wZJzshsWx425o6qyabY0ao1+jqerpRoEKxMgpnhBrBAaBdhoqyQT4F1mrnUkDvwOLXbiEqNTmWmEAoYJqttUbiKTW4olVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330848; c=relaxed/simple;
	bh=SU3xXnJ3tFjhlwJLcJ9BD1p3BJovvHZH4JOUp/Jg5RI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZAGvMJZ8VqiDfhRmtX3MYwXp1rA3ZAr+VcjV7hN0U90skBZgVRWbFyWAXKI2/j55NYA6ai8/YC7acZTl573Hke5RD/gvPgYMPDJ3V8WWizJZptsqCUbnt3x5+E7TBvZ856cwVt/fCc8HoTIuOHjGItSUsFH+UNrL9h/zA3/gR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4UChklm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF717C4CEF8;
	Wed,  5 Nov 2025 08:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762330847;
	bh=SU3xXnJ3tFjhlwJLcJ9BD1p3BJovvHZH4JOUp/Jg5RI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Y4UChklmd6dvtVjMtbZ2rKoq+qKtfvtBs3wRFIfsuN3aUFx9DawDKazZvGYPgaFCh
	 OOPFEGmptS+lCJHcoCCocaS3YnjjQnRASioiGx1aAunwl3Pe2W5wBKJR430wOXgD4W
	 MRQvQStpRh2m0rcvAzmCRJJqXJKMS9G6Lu6rwVW7PuzlXJMkSSidgTZTpUUf9Ntu2I
	 zGob/mN20C2YWZH9mGOSBLiCgSs4SmWQrrK0kglOBvBEE2sxwk87Vif4YTMvEbr2aU
	 2qGJsCZU6aJn8lqcBdkXEaKdWKpYn5yYpsGvNjloy+vmzbaRuKEwcH/lY2PxoTKtnH
	 6c/khjy84Vb0g==
Message-ID: <7e0f34bc-0caf-4d56-a5ba-ef28b947cce8@kernel.org>
Date: Wed, 5 Nov 2025 16:20:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: revert summary entry count from 2048 to
 512 in 16kb block support
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20251104162402.928582-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251104162402.928582-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 00:24, Daeho Jeong wrote:
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
> Fixes: d7e9a9037de2 ("f2fs: Support Block Size == Page Size")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

