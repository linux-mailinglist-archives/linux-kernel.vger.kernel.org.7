Return-Path: <linux-kernel+bounces-655766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F7ABDD12
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5FE174E16
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024C2517A8;
	Tue, 20 May 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOGo8eDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F52459F3;
	Tue, 20 May 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750457; cv=none; b=IeO67fmqu9vk+68LafkkfN2+gsn2M1Khf9LXXgkg9ECu9cWjU7GnK6shYf0KRjnJIFBRrvgXpbFCw9RyyySz8qjRaRjFtcOrG7kVCiHVcFPJLYjAjuuA+QaKrujIaQn8k4K+FGInrGIDrHb2yX6KSg/ZmGV1Yn+lNuINgSNB3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750457; c=relaxed/simple;
	bh=er5Z9v1gTHlblQ0IFiaXz43wpcJyMEwObalM+JrBQ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th/B9CSSBtmJ1Bvos6ZcsEBLygJu7SbRtcWA9diCQgo6jss/yILEbmziXVJKwXLqnjhiQ7BEtfocKBSIwzCWGJyb+nTNXSHMrLMGiRtkHiyQ22q8+XRTP72k97SDtY1tijzU9C7I1FGxhxzyo5Q3yMUEd0qdRvDe4dThbkgxJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOGo8eDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1DDC4CEE9;
	Tue, 20 May 2025 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750457;
	bh=er5Z9v1gTHlblQ0IFiaXz43wpcJyMEwObalM+JrBQ+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOGo8eDBFYN3Jqyj3FUpoKhdtxaJ88v3hAYKddVq6a9xPj7N/EPLUwNimiW1bULhV
	 zzS3bD0NvJRjmxd3bA4KkQLRbbG8XVQkcBxnNi/xINhap4m4X1kn80eiBHapK6w6T5
	 DRBOnFHvZeRKYV9+WonGg/aJ9sJC/S0WSeEOcNdQ8pkxHXFIKsSVv77pMu2FwJFR6r
	 pzHr9qRP7l47V/cJE9R0+gfV3do/1PAEedaCAPJ8besyxGRg8akGTwH4kFQoS/OUTG
	 bZ6KUwtA4TP5QtjTpyCGBwINqRGG2PF25VBpFsYI76M8abO+KoJvIg6Ebb1LP8sxnt
	 ENFgeVV1im3yw==
Date: Tue, 20 May 2025 10:14:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Alexandre Demers <alexandre.f.demers@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
	airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
	boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.14 248/642] drm/amdgpu: add
 dce_v6_0_soft_reset() to DCE6
Message-ID: <aCyONyjgTxvphCPN@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-248-sashal@kernel.org>
 <CADnq5_MfAFmbLeg+PAtWaFvY1G29ApTmMKwFq7etT35NvQWXHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MfAFmbLeg+PAtWaFvY1G29ApTmMKwFq7etT35NvQWXHw@mail.gmail.com>

On Tue, May 06, 2025 at 11:05:15AM -0400, Alex Deucher wrote:
>On Mon, May 5, 2025 at 6:24 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Alexandre Demers <alexandre.f.demers@gmail.com>
>>
>> [ Upstream commit ab23db6d08efdda5d13d01a66c593d0e57f8917f ]
>>
>> DCE6 was missing soft reset, but it was easily identifiable under radeon.
>> This should be it, pretty much as it is done under DCE8 and DCE10.
>>
>> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This is not stable material.

Dropped, thanks!

-- 
Thanks,
Sasha

