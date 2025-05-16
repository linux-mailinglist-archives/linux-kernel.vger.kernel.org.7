Return-Path: <linux-kernel+bounces-651423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508BAAB9E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10824A010CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E919938D;
	Fri, 16 May 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3FjzwdT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AD1922C4;
	Fri, 16 May 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404619; cv=none; b=fPUivkVPOAVmvy8avOFuo4htoXoy2rYnysiCCvZ5eBubto1mkH/RPFcqQBvFW2u6sIglnIu2pRYz3PvFy9rTr/DNXlGl3OHmtE2pSmpVsLBsUWIom0ttVHowBIBu/1x88A5khJo5UW9nnDwGf2AaeNT+jplRUBp3dDqlaijPEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404619; c=relaxed/simple;
	bh=ufg0qaE/qIE5yWtOVN11g0Zxbb2Wd04AflOuDLEMAq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwTSEV69Afv78Kh5e4+UM5LgINvZxZsEt/ybxwZtqJ3vDuKoxv0WQh7jPfUMfpe4sAAVhFEVf9q1QY7sUVGJv1xQH+HEFafOJrJYT0ysMKuoqf26a1eMMGjChIS0U9m1XtcLDgRG1+8JMhni/ReUfHNizMRETxFDV7yw4Ej7Ot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3FjzwdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CE9C4CEF0;
	Fri, 16 May 2025 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747404619;
	bh=ufg0qaE/qIE5yWtOVN11g0Zxbb2Wd04AflOuDLEMAq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X3FjzwdTgX/7pWNU7P01oSOCATpsEBcg4K4FqDs1ksWsig9g+eCjJWst/7xA7wynt
	 k+2HudgqC2EvKyOJ1MIneG9d7gDLEEOGHU8mE/zw+J6IvSjWbupc7ucWauvdzDPoCf
	 HUB9w+lAU4yNfp26OtJemVPTtScZuCU+IcP9T4H/vnPFpZuPWwIeEpGEaOLAIbp/vL
	 UmHZInl5av2M6EItSkTX8+0HFoqXofgP2CPHr110jT3HVdrJNBiKA2J/NmWi7lBr/0
	 Gx/dBQ5sac2QT7Q5rxuFhGwsRhHCi2upLOtRmm0KWSLf2bewwV7OSSlOtq+0SHu/mA
	 MPvQ7qdyq0/Dw==
Message-ID: <8afbeffb-93c4-4f0b-8f3f-3b7ff7bc8147@kernel.org>
Date: Fri, 16 May 2025 16:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/nouveau: Simplify nouveau_fence.c
To: Philipp Stanner <phasta@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20250424130254.42046-2-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250424130254.42046-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/25 3:02 PM, Philipp Stanner wrote:
> Just some minor attempts at improving the readability of
> nouveau_fence.c

Applied to drm-misc-next, thanks!

