Return-Path: <linux-kernel+bounces-771364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD88B28617
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D614EB05CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6B2F9C57;
	Fri, 15 Aug 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNZOkHKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF0A317714
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755284014; cv=none; b=h6McLWd3BfERNEoS+eNpFGC2VWJb0SdAYKW7YPnqCHicCG4b9ZPXK1vhjHPCsWsMof1o+h00UIko9Ob1wBCTCxnSivYpywQcEflSrjU636rwLAL9cfBPf161i4/T5RoNLbPF+9BZDrIjM258C+UHjxhZ9+V5BqApOI17w4c2zUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755284014; c=relaxed/simple;
	bh=88A8SsAWlEkSBITeV1u5QVhR5tRMTyKUnag0c/Hm5iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8+6w9GATjz0NohFSD6uvduM9vBrjXHROw03POJY9ZaFUDz3tGpW9T8FS6FE8wGmebJv41EDhyYiBL7ESYNcLV5GvheixmL3G17Cp6SDgwIoq1CPMWImT+g+el4XCQmFwjrvfnZtwPx3OnM+dG6LqjxBXUvZaXLnfEt4PalPcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNZOkHKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E20C4CEF5;
	Fri, 15 Aug 2025 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755284013;
	bh=88A8SsAWlEkSBITeV1u5QVhR5tRMTyKUnag0c/Hm5iA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FNZOkHKY7WcR1aE2fILAlDHtK4Ln/hCOrZPlGbDn8ZPv49T7LM9zf6YHKbOr1TSYf
	 JanVedJY9glCi2I7qcKcp7HXZx+zZyDbLx0B2pujOA+dm0Wz+OAHLOTPjIPC4Y3JQL
	 X7zVF9xbwJSsQRIr87pPdS0M+keXPH0ocn0R30axL72i9C8uLMUQQvyPtVlnutMAjH
	 J4XCzaN9lPS4667TWDgaLWiEXuWKBIekYobQKX25RdsA7O3qfhEFP/3l6dULDSRWB3
	 pSu/HIjxaV+Cn5pJ3bkf/q9HqMOQ2KyW9Cgf11gf+4EXkB1OyBHOcRfAzyn+bn0pfw
	 CdC8P0OcuMZTQ==
Message-ID: <f3b13797-07a0-4b2f-897a-e4ef2a11d6cc@kernel.org>
Date: Fri, 15 Aug 2025 20:53:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Add directive to format code in comment
To: Javier Garcia <rampxxxx@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robin.clark@oss.qualcomm.com, antomani103@gmail.com,
 dmitry.baryshkov@oss.qualcomm.com, me@brighamcampbell.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <DBYS3FAEVMHC.178SXO45NIBI8@kernel.org>
 <20250810150706.305040-1-rampxxxx@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250810150706.305040-1-rampxxxx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/25 5:07 PM, Javier Garcia wrote:
> Add formating directive line in function `drm_gpuvm_sm_map_exec_lock()`
> comment to clear warning messages shown bellow that appears generating
> documentation `make htmldocs`.
> 
>    Warning: ./drivers/gpu/drm/drm_gpuvm.c:2444: Unexpected indentation.
>    Warning: ./drivers/gpu/drm/drm_gpuvm.c:2446: Block quote ends without a blank line; unexpected unindent.
>    Warning: ./drivers/gpu/drm/drm_gpuvm.c:2450: Definition list ends without a blank line; unexpected unindent.
>    Warning: ./drivers/gpu/drm/drm_gpuvm.c:2451: Definition list ends without a blank line; unexpected unindent.
>    Warning: ./drivers/gpu/drm/drm_gpuvm.c:2455: Unexpected indentation.
>    Warning: ./drivers/gpu/drm/drm_gpuvm.c:2456: Definition list ends without a blank line; unexpected unindent.
>    Warning: ./drivers/gpu/drm/drm_gpuvm.c:2457: Definition list ends without a blank line; unexpected unindent.
>    Warning: ./drivers/gpu/drm/drm_gpuvm.c:2458: Definition list ends without a blank line; unexpected unindent.
> 
> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>

Applied to drm-misc-fixes, thanks!

