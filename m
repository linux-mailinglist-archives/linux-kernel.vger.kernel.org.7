Return-Path: <linux-kernel+bounces-833376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EEBA1D06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513307AE0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C866E322536;
	Thu, 25 Sep 2025 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XSE28i//"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA4321F4A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839731; cv=none; b=r43sF9+TRazojRGjojc268tDnoqhO57UbfoSA6CBP0Ds3I2jE0/Jl4CFxYunPwM4LeLNzk4jc4akqacklE5znB4Fw4fecMCWVfDgYw6ZkmlNaxJsPOJ38WQWWhfbSCrN5WLIT84ER2dhawkroBklL2E+BE2X8ijtgU/UGK6r0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839731; c=relaxed/simple;
	bh=a1TJAUG1xtQ+zr/DGPP3xX5WgMjbIYhRm48EUqZn76Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IKvHkMWUShWP6VL3JPg6MygcmaxCbI8gyomDK9ekC7X3Kn2P/nQfuB/2kOxahT3zSea61gHtvyEDsdoxyt30KGHOlC2KQ8d7u6gEmXcAFc7l82qfhE4F/L3Th8jyFQ6YRin6Tb9UuvH1FDGwl4DmV972mVkNHp0nmiz+rIERuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XSE28i//; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758839726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvs7jUazi5d0m5GvWoBhaorJ0Iy7g9chWyT3/fMM+JQ=;
	b=XSE28i//t1y+Gs/C8T1fx7qcit7TgYW+b9QDgayEZ4ZMBB/KJsVkhE2Hw5lrwH30xG4g8G
	soAi0RomBlu28k/lyqdTAi4owPUTvckHPutycl2H8IRz2jlXL3hz2+tbDHVwToAz1//RwD
	6T+s87a0uQ3Dgd1599MJQ7a89ZiWsZM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] drm: Use strscpy() instead of strscpy_pad()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250908102217.3725-1-thorsten.blum@linux.dev>
Date: Fri, 26 Sep 2025 00:35:07 +0200
Cc: dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Message-Id: <596CAA63-C3F8-4C90-B898-259B7CF8AD6D@linux.dev>
References: <20250908102217.3725-1-thorsten.blum@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
X-Migadu-Flow: FLOW_OUT

Hi all,

> On 8. Sep 2025, Thorsten Blum wrote:
> 
> kzalloc() already zero-initializes the destination buffers, making
> strscpy() sufficient for safely copying the names. The additional
> NUL-padding performed by strscpy_pad() is unnecessary.
> 
> If the destination buffer has a fixed length, strscpy() automatically
> determines its size using sizeof() when the argument is omitted. This
> makes the explicit size arguments unnecessary.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---

I've been resending this patch since April and I'm wondering what else I
could do to get this reviewed and/or merged?

The patch still applies to both linux-next and master.

Thanks,
Thorsten


