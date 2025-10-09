Return-Path: <linux-kernel+bounces-846205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24188BC746A
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E3BB34E2C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C0221FBF;
	Thu,  9 Oct 2025 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM9mxkoW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83248221F11
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979697; cv=none; b=eWwROqJBTG5tLnHOlPuu2F74wX0PRCnJ/XUORWI2zaNIqvcoKjnU5Bn95g+4CQ618o71sw5Uf/VJgmTfRayuVhDw2NXbJXoVq1G4WWwoiFib3tK4piGotg4ATSxoWztWWo6HhLuInyiGxBIywcXK/wvSYCz7lg24UnAVHMbHBTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979697; c=relaxed/simple;
	bh=VxdVFeEekQvwsHI+Hcvm/2sBm05P6xZAXuTaVx/1N0c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nymPFFYUpVs1EDos8i/HTvLBbVkQ6oyduCtg8SfoBg11pCU4TgvJ0OHC1VCMN5inR7dUJAwG2Fr9Ehp3ap6EUSgUi5pshJPOEplDo3waSVC2q1fInkxAdBQRzzni1Vmv2TW/mkOQNNormpq6lczdKjdC1Rd/Nl1mrLmbiisLmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM9mxkoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E37C4CEE7;
	Thu,  9 Oct 2025 03:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759979697;
	bh=VxdVFeEekQvwsHI+Hcvm/2sBm05P6xZAXuTaVx/1N0c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hM9mxkoW975flQisRAZlmkqpBgOWjTZwdSF+4zz4OIMEstzFrlaFWmXQ6uTS6uYvP
	 ZppVAAv5UATPQXu8VO8a27W3vrQtdIFk5o9JpkGD8hjX5Oqz2fqV4HD4O8J2yTnhny
	 JMVhy2YHAio7SeCWsKMUlD4InTI/cwwJOxGU03nGMjG2NVKzPPwgKkFz7Da2TT9GV6
	 7cGwYOBSAwB/DSfN3/nfZsOMKiRUHKpL+H3+r6UfuZligAs4varKMLwSQS1ygMZtb0
	 VRAvBrHKy0zo2N4P35pxp6uwvBgHzb4Q5Toz58CK8tf9LzD+G7tQyv9LD8k7hUtPPm
	 uC5nkXUrUnTnQ==
Message-ID: <5f08d6e5-f7f2-4109-89b1-03485516e54e@kernel.org>
Date: Thu, 9 Oct 2025 11:14:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: maintain one time GC mode is enabled
 during whole zoned GC cycle
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20251003224308.1948874-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251003224308.1948874-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/2025 6:43 AM, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The current version missed setting one time GC for normal zoned GC
> cycle. So, valid threshold control is not working. Need to fix it to
> prevent excessive GC for zoned devices.
> 
> Fixes: e791d00bd06c ("f2fs: add valid block ratio not to do excessive GC for one time GC")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

