Return-Path: <linux-kernel+bounces-764376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0023B22245
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A3E3B80A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07972E765D;
	Tue, 12 Aug 2025 08:58:53 +0000 (UTC)
Received: from hs01.dakr.org (hs01.dakr.org [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBA2E613F;
	Tue, 12 Aug 2025 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989133; cv=none; b=MbEbGrPkMvSVXxt65kcwHxboIm0stviyfQwV688Kywhjaq9y/2KZuneCLDegLaDcLW0Q8AGkftxgmx2UMDpoWQScW1NXFY0riAGLKc39jMJhOBJ8t2/R9itjGYADoSwmA0if/AbW+Yc09BnBYUzo6UX9Z8w3R7LWSZRXu9wWOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989133; c=relaxed/simple;
	bh=gkxIQPtKuyWeKqXePFPbXz4NQygXcVALFY0vrZPArEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrii02artQvsKCKZ6JZqnX8OJdowGnqFkbAKCI85odsJBOj7hGcknNpKqBOvTRfFOjotRDj7QLDAatQsIcNj+p93bcYTxTxEEjJzVtwl5RIJYOVpjV8UYQffDQDLG+NJAjfeEnQes9gNpfeFuwscnqEii/ynZ8zm8vJ8JKIb8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Message-ID: <b0a36f3d-706a-4622-89a1-f88c6255e4fb@dakr.org>
Date: Tue, 12 Aug 2025 10:58:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 14/42] drm/msm: Convert vm locking
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Connor Abbott <cwabbott0@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Danilo Krummrich <dakr@redhat.com>, Rob Clark <robdclark@chromium.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linux-media@vger.kernel.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b"
 <linaro-mm-sig@lists.linaro.org>
References: <20250629201530.25775-1-robin.clark@oss.qualcomm.com>
 <20250629201530.25775-15-robin.clark@oss.qualcomm.com>
From: Danilo Krummrich <kernel@dakr.org>
Content-Language: en-US
In-Reply-To: <20250629201530.25775-15-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/25 10:12 PM, Rob Clark wrote:
> +	/*
> +	 * We mostly want to use DRM_GPUVM_RESV_PROTECTED, except that
> +	 * makes drm_gpuvm_bo_evict() a no-op for extobjs (ie. we loose
> +	 * tracking that an extobj is evicted) :facepalm:
> +	 */

Yeah, it's a consequence of this locking scheme and I really hate it. However,
you don't entirely loose tracking:

The next time you call drm_gpuvm_prepare_objects() it will be added to the list
[1] and hence picked up by subsequent validation through drm_gpuvm_validate().

[1] https://elixir.bootlin.com/linux/v6.16/source/drivers/gpu/drm/drm_gpuvm.c#L1154

