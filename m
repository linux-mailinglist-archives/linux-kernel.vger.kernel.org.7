Return-Path: <linux-kernel+bounces-792310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19535B3C28C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67AC0189D474
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8B33EAF6;
	Fri, 29 Aug 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahto970C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D81F4192
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492639; cv=none; b=fEmdgP7Gcu3EzCB8YyEXkz7UUwhpKdD8/Da74iP3uFokRR/SGIqk6IvlnN6pBi9cddcBs4zSeAeLSZbe5ErG5e+b0exJ44uGyFpBcXLNXrHnkUGeKcidhgWRTEJAn5Fsk3Vvxufp0BdwM2aEW5rJ1Q8eRGo/bl/nJhMMe6cI+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492639; c=relaxed/simple;
	bh=W5n8+hlytq7ASISeL9ErQDXq9duSkQKAbex6L2az1Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sx43aubh/nO9DljLQmmjfXhR+Em7KWeP+9ATwSBVxElgjpPUecafUgorraLzXOE5slyk7tQZGBlDxvbAo8q6OL1z2JVWuWyPCdo21uIvnV4hgf8f8q7Cn12SN4+Meiap1+yNjx8rNx44+K955BUqIlewq4zCz0prB001c5eP9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahto970C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B7BC4CEF0;
	Fri, 29 Aug 2025 18:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756492637;
	bh=W5n8+hlytq7ASISeL9ErQDXq9duSkQKAbex6L2az1Zg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ahto970C/IhOm3AhaKx816EtPJ7M9zGDDCIDpKL6rHNFXRV1GhSqstdsV5RGVkT7k
	 xHEF1moRLHaYs1oiTevVS3/I4BtP5AdeIvPSboc0Mv8bNWEUnP6P/h6Hr8j/aAyaWa
	 md+OX6wLVBxCC9J+CC5Nztr5VRrlKESrqImMluVENAvXijHYy69L/unxe3S9+91w3L
	 O39W6lfrqgjT9zfyfmNeL0VCiT6aajE/Z2S3WE3XLVdJIhSCFhts85Zv2X1oxVy2BX
	 22WyN2BJlcXldCUF9+WPGqLJsyZ6eXIenfzRtIJecEjzuyrE12Zh7HZhOxPQ0K7hP7
	 vJkaX3o1zyfSQ==
Message-ID: <a84b3b1e-7095-4411-8ee9-53caa1b18962@kernel.org>
Date: Fri, 29 Aug 2025 20:37:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/nouveau: Remove waitque for sched teardown"
To: Philipp Stanner <phasta@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250829183044.213380-2-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829183044.213380-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/25 8:30 PM, Philipp Stanner wrote:
> This reverts:

Thanks for sending the revert!

> commit bead88002227 ("drm/nouveau: Remove waitque for sched teardown")
> commit 5f46f5c7af8c ("drm/nouveau: Add new callback for scheduler teardown")
> commit 89b2675198ab ("drm/nouveau: Make fence container helper usable driver-wide")

I think we only need to revert the first two patches, we can keep the last one.

Eventually, we'll take advantage of the scheduler callback for EXEC jobs only,
so we can keep this.

