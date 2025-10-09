Return-Path: <linux-kernel+bounces-846209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D74BC748C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95E9D4EC95B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED2423371B;
	Thu,  9 Oct 2025 03:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpSnV+LV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669A230D0F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980111; cv=none; b=ICtEb7J1NvOqnneKsL5ZOhrA2HNtqlIyZmgabW5uiQGW652GF1pBLFetbBnxhoKAiU/7L6zLtelpi6M7/ElTkMIQs/AK3wJru02x4GoApLkGI0fBYlnUJRXfx4FiL/voKSvOnG1d8JovC5YqJvusobvH/6H1GVEBYkHaWY+eBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980111; c=relaxed/simple;
	bh=PtQ41OI35O60urs8xAZ826G4NPsJvGyXxDM4/4UAcaU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UwdPlG0ijGZNrjbRdDbwUeW0CRYYvSjzRfHc2aah2spzRLUgzsvzQcUb+FG9TJ9i3PWaHW89bu3GvAk2h7HKG8sJZtDrhg6MATbxnKCmH9TeZFswnO8cWxMbc6rWh47uaC7nNd3BNZA9X+ZgX34wlsGA5mOPrvSnjKrB3fCJiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpSnV+LV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D18C4CEE7;
	Thu,  9 Oct 2025 03:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759980110;
	bh=PtQ41OI35O60urs8xAZ826G4NPsJvGyXxDM4/4UAcaU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZpSnV+LVg5G/rjlqykPkHL+ovS+hmo2gxXU/MdmSaO+DamwlU8hZOb7qJCVbskqA9
	 nmbboLA2bX9KtByKgylIf/9k5cbiv/Lf54C1Cp3zCtzklZNPuak5Hss+TcxLfkoBfc
	 nMqzsysDgSuBg4HIXK3EJb2EkTt4kDqP/Hzd7PVQZLBm1Vwnh0z3quaGuSFcKRfHWZ
	 VdNyL7j6G0by9bqF0P5wUbo2MD014XaIQVIfOMm0W7lPsU+6QasuvXNtuBBVF2YMp/
	 EqXNlc6RjQrxwL7vj4wD9pDNvh96dxna1QJTCMm5qtk6vaZR3stdW3qKuWKmFRndnN
	 ciLNt45LgNe2A==
Message-ID: <03cc9db0-9294-40d5-8638-d9f71066b5ed@kernel.org>
Date: Thu, 9 Oct 2025 11:21:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: set default valid_thresh_ratio to 80 for
 zoned devices
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20251003224917.1950708-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251003224917.1950708-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/2025 6:49 AM, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Zoned storage devices provide marginal over-capacity space, typically
> around 10%, for filesystem level storage control.
> 
> By utilizing this extra capacity, we can safely reduce the default
> 'valid_thresh_ratio' to 80. This action helps to significantly prevent
> excessive garbage collection (GC) and the resulting power consumption,
> as the filesystem becomes less aggressive about cleaning segments
> that still hold a high percentage of valid data.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

