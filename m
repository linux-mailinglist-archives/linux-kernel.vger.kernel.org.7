Return-Path: <linux-kernel+bounces-743462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0F1B0FEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925E61C28741
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083F1A316C;
	Thu, 24 Jul 2025 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwdRwmNy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372222097
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325494; cv=none; b=dXtCyo04NkMBur24xlMTDeiWtuToo8qmOF1MdsXKPSiitHk/9YCAlvz2f7o0I/DJwPqmWvLg4rZ9PgxA7QRieABDBlsXANI9+5BCpzg2VhchM2gwfjljXP9y9yPXGriJfhn8amVXeqT7h3vJzQuY+911PPebjTiIwS3OLPNcjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325494; c=relaxed/simple;
	bh=zQMwssB5DRI+JwmLY5fcSE/9Ybp+39Nh/8mCHog03zk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U1adPoyP824JXSkZ7FbnOuQzG1X6QXWWoAw54wB1z5gmjnC8oW9N+jrB/hHz3xLdMFE40KRTqpuhbFt6fOQsfueh/GofBSPzYRWKj8/Zg1ZPCPCYKZYVDdfqIN9gHHqsLesG5Iqk2dw5cTzWixQ1F5po1JxXTyixa/Ngcq0wlzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwdRwmNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D602BC4CEE7;
	Thu, 24 Jul 2025 02:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325494;
	bh=zQMwssB5DRI+JwmLY5fcSE/9Ybp+39Nh/8mCHog03zk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rwdRwmNyao1OJ/aF0Ds9ac7JQcLHW7iGMKc9sgHl8/0pE7aJGqfFKQxgHd3gwnVsI
	 Dzbvg4RR9V+3NktvYyny1yrAn3njkJpr4+mF/fjeyPCxVWUnp/5nV5uG7uIAPqjdWe
	 ih7Z4yszK+iQwjNmK+x8ewqbs58S+quegcZOXDVPNUUJk2tn6fSV5byUbVuieNYuji
	 9d0FMBc1NAMoWDX4hbU0vKUClL6BvnUQsSqcMi53qD3Lbup6WLEcAf4Pzn417B1OaN
	 6RnoF6Q7TXnv0u514ww4YRx8pT7if7xg9KJ5VDfCnt4sux3TPA0/SaNKF6JOxCDxpG
	 yHiLDQJEqct2w==
Message-ID: <561990bb-136b-49d3-b5d0-465e99a6bc90@kernel.org>
Date: Thu, 24 Jul 2025 10:51:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: merge the two conditions to avoid code duplication
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250723145837.187089-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250723145837.187089-1-masonzhang.linuxer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 22:58, mason.zhang wrote:
> No functional changes.
> 
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

