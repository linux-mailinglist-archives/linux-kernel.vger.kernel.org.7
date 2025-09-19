Return-Path: <linux-kernel+bounces-824141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B78EFB8831F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFA31C86CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F072D1303;
	Fri, 19 Sep 2025 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B6nB/pXd"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C963525522B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267237; cv=none; b=Hnhv0c0gmr+bvhuHepIAOuFJaUgaZLQRxrJi9QJGNQB+3EqhbIrj5XCUnUgEFZjthgo/LXnexe1o/+jxtC/eYvsdAzmWHDJEVDa3tPmgGFp71SMyt9EXRSFe8c4oVjMzaMHYLwfThaVfbovc0BcCay1bImryvZ2z5DVsg7hItyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267237; c=relaxed/simple;
	bh=iOGGWyFDBu6SA32339IqwHVfXtx4/MbHW4eTf/SxnyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWkSkNjFS6Slo1sTys0lPXnZuSMwkXYS1UwW0VTsmEjN6QaMn8J1PfHdljKowlSf9ylUM3CIVE1eY3P2rUUkt0ASM0Sy3C5JFMXdERNvFFQxVlGPh0T/kJhPGveMCfqtxbcGpurCV2tiHGEkwoVHmA/cKT2c2B1NVzxIH2s4eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B6nB/pXd; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U91o9Zqc2PJ90qyrV5arZCIif0SuJMRWy4xQnzTZJBk=; b=B6nB/pXdvivQCTb2VWrlgDdWOr
	eK3tGN1CEn5pQOeMazMIf1lcro9ETZT43ZiswQmrCveEl4DcTg71ZX9vUUZRxoGnbqVcfejzUiQrt
	Ffb1LNnixJZOhBjw3j8K/Azf8j92g+FHUXZFfXn0qHgiVMPXW8R82qqzs3R6QNco7b7mNnqceoSKe
	49hT6gQHwleSnd0VSxnWTSXbgix3zN8zUfUtOhaBy6gE1OdT9SWX7bzOKGOL1PHXDlEu9t3Q/OixI
	B9HWz3B1NBsEqvzQRo/pqtoyTV8j1xHu3paNrMDlm0NgsWQ6lGaGX+3DQ9WICoOJPs+bGyI3/L3Ar
	PJeB1vXQ==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uzVcV-00Dzey-JN; Fri, 19 Sep 2025 09:33:27 +0200
Message-ID: <ad1359c3-86ae-4ed1-ac60-902daa2331a7@igalia.com>
Date: Fri, 19 Sep 2025 08:33:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched/tests: Remove relict of done_list
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250919064450.147176-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250919064450.147176-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/09/2025 07:44, Philipp Stanner wrote:
> A rework of the scheduler unit tests removed the done_list. That list is
> still mentioned in the mock test header.
> 
> Remove that relict.
> 
> Fixes: 4576de9b7977 ("drm/sched/tests: Implement cancel_job() callback")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/tests/sched_tests.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gpu/drm/scheduler/tests/sched_tests.h
> index 7f31d35780cc..553d45abd057 100644
> --- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
> +++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
> @@ -31,9 +31,8 @@
>    *
>    * @base: DRM scheduler base class
>    * @test: Backpointer to owning the kunit test case
> - * @lock: Lock to protect the simulated @hw_timeline, @job_list and @done_list
> + * @lock: Lock to protect the simulated @hw_timeline and @job_list
>    * @job_list: List of jobs submitted to the mock GPU
> - * @done_list: List of jobs completed by the mock GPU
>    * @hw_timeline: Simulated hardware timeline has a @context, @next_seqno and
>    *		 @cur_seqno for implementing a struct dma_fence signaling the
>    *		 simulated job completion.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


