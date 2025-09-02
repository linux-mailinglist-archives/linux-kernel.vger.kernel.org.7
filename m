Return-Path: <linux-kernel+bounces-796644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8459B40527
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289C31A81C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE2321F5A;
	Tue,  2 Sep 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+YlGHhB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77B320A08
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820480; cv=none; b=T13AfA7Ugt+XzHRpGhHYN76u/LaBtGwpWnUXQ5imYq5zWHz1ghRdZLXGkmwxY6WAVPpBgGe/as3u5NpJhqr4wiAFN+fuwLRRmJq1I0WoJ4zu3Y/AXbpG7oU1qtUU2P2Pgn/8lBhYW6tNNVIkKhKeS7l2tHe4uEbHRGUyg0pYLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820480; c=relaxed/simple;
	bh=CIaTo0E1ULIoJ6xDm4jWtClTGcvSLSjtzXFy6h3bR5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcmnMntD2J2zqG/qp9NdrfdeJ0a1CLOqD6FvmH9RlLwRaALu8WEqkLNyWavR+mknngELomphxPZqV2ROQt9jY6syFn67V7EAJMn5Z/SUyurvUfSXHSm21uLEofFfLpzeUfCmQVNmHFsGNM2tohJfVqh7JgAZpA0JL7lk+yQVBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+YlGHhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B077C4CEF7;
	Tue,  2 Sep 2025 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820480;
	bh=CIaTo0E1ULIoJ6xDm4jWtClTGcvSLSjtzXFy6h3bR5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O+YlGHhBEQjQJljvFKXyGPGLI2pM4wuej4KxPRExUz91y+G6L09AZQEB2ev1cvezu
	 4ZXho6qcsGacDL8ANA1Iid71xGYk1+cOYl+eoE7GYQXhuTzZxRH1WcTwvL1yGMP/h3
	 3ffijoPI9ZS2TSPVf1YNzxEo6FJQiUgIPQYx81/cazcRUk8/Hr2K4pG9lNjsmoF/kv
	 8HSGntq9JrMYCYBduucr3aR2/x1Tb2W50tPCAr2PDb6sav9ViguNOaahIiY4HX40UV
	 ggVUIRBjas2A845CYODuGxZvJchx9urQsjqWVUSUM8zGy0fUHBGl/SgeZ1t2dsapw6
	 9/vjIuksWqa9g==
Message-ID: <1cbcceed-6e95-4f20-8666-1c8f40154e3b@kernel.org>
Date: Tue, 2 Sep 2025 15:41:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm: define NVIDIA DRM format modifiers for GB20x
To: James Jones <jajones@nvidia.com>
Cc: Lyude Paul <lyude@redhat.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
References: <20250811220017.1337-1-jajones@nvidia.com>
 <20250811220017.1337-2-jajones@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250811220017.1337-2-jajones@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 12:00 AM, James Jones wrote:
> The layout of bits within the individual tiles
> (referred to as sectors in the
> DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro)
> changed for 8 and 16-bit surfaces starting in
> Blackwell 2 GPUs (With the exception of GB10).
> To denote the difference, extend the sector field
> in the parametric format modifier definition used
> to generate modifier values for NVIDIA hardware.
> 
> Without this change, it would be impossible to
> differentiate the two layouts based on modifiers,
> and as a result software could attempt to share
> surfaces directly between pre-GB20x and GB20x
> cards, resulting in corruption when the surface
> was accessed on one of the GPUs after being
> populated with content by the other.
> 
> Of note: This change causes the
> DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D() macro to
> evaluate its "s" parameter twice, with the side
> effects that entails. I surveyed all usage of the
> modifier in the kernel and Mesa code, and that
> does not appear to be problematic in any current
> usage, but I thought it was worth calling out.
> 
> Signed-off-by: James Jones <jajones@nvidia.com>

Having a second look on this, isn't this (and patch 3) a fix as well?

