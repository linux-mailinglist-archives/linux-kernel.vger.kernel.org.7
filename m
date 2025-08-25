Return-Path: <linux-kernel+bounces-785519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD27B34BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B923A7A7CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476522FF37;
	Mon, 25 Aug 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC8gFRgr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D328726C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153821; cv=none; b=lQmDjNkegirt5wsHPDAgJZ5ip5PMcLZnmRD0GHkoZb9sdz3rGpTcAFVLpp2h2GtcmfF7piDfHl8b5SLylJ8o09LwwqwpgxetTsndlFnVV1Gxah2NRtiq0OqnzKdL3Wjyz3sYmvR+kuVRFdV/Oq9zRdBFWSUgQij927RQWHpSDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153821; c=relaxed/simple;
	bh=0kTs8u7XOu5hziZIWSqcPnlVhzZIFyIGWTdZxZ8r0ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqznjB5R1qPJ5oI7TSiSinqXE5Ynz6lY/KAF7wPWAtQRzBPfzFBJlXTSoNmMx7XdzgX4L7Uz7sJlIg7AasoodrfKb4EsqBqjBuzv4XRmh6ItrixBz/fyhfGqGlD8397oChFABeY7o3xa1br2+zKlxkIS5i1YcOfVeo0LrF+6zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC8gFRgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B62C4CEED;
	Mon, 25 Aug 2025 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756153817;
	bh=0kTs8u7XOu5hziZIWSqcPnlVhzZIFyIGWTdZxZ8r0ZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GC8gFRgrWVeIdDe4Q5ntB8ZqjhXF2RUqA5f+29BaJ4aSJosIF2u1dogbBSjQNwOGB
	 k5YPE95zF7XkIkWq117fqydHAjrqkWwoggRUmkZMJot3BYu4aU7Jg5YtL4IFdkHBQS
	 cxtPh04pDDykMhnhrfnt3OcmPXLJluGc9bzk07mttFbsoidGNNX2NvZoXahWf08r2W
	 sk1jhNTJ0vRxN8MmsHy68gNh91Dpeo16er3H4Ayl3gZB/xDbZxGCPGbHKaGnGJ3ZnA
	 vQq6akvkTCe3ZzglO58waiV5+cuGrVBfdaFVlU9ZMQaDzVCv5UhNqgixMMdb44YNp4
	 ZcSgFizD+0EPA==
Message-ID: <7b4bd666-3f74-4c99-b073-03cd2a090eab@kernel.org>
Date: Mon, 25 Aug 2025 22:30:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gpuvm: fix various typos in .c and .h gpuvm file
To: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250825-gpuvm-typo-fix-v1-1-14e9e78e28e6@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250825-gpuvm-typo-fix-v1-1-14e9e78e28e6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/25 11:22 AM, Alice Ryhl wrote:
> After working with this code for a while, I came across several typos.
> This patch fixes them.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to drm-misc-fixes, thanks!


