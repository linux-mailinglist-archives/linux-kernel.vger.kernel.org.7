Return-Path: <linux-kernel+bounces-887444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138A1C38440
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDE1188A373
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E42D73A7;
	Wed,  5 Nov 2025 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMBqAPzH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57247224B05
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383074; cv=none; b=JW3b5daerxVBUryvI7N/CIi5dCVSmK6qMoBSQFzQJdJ/bi5oml/W85prH7CwhzJ3FZl3/E6PbI9xN2WUBxVwfakyORtwmlIqgKXTvtIKidW7UxLfeI3iYMf6HzLwLwTY8i27Q1M0Ibo3f4isISsIhI9Yc470o3yLSYNQyilhnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383074; c=relaxed/simple;
	bh=pVqiMffJ+/+3iCw/xeioPbEjfyBueyeofbkgdZ2WABQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Njslq9c85PwB5pEEDLTDMtco0lr+Ulp4rQ4AY9EFvT1qzw5ThKccbjWnJ4IT9r8KoikHN1ttFKW/I/LHM2sP6SmqMLgn/L//NEQHE47p/lwecBYr6OU6Gvt9S+MfJVg5ugmiKS9MrWkYDP1j43Bo1KD7zPO1APOlRvgNQdD0d7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMBqAPzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0737C4CEF5;
	Wed,  5 Nov 2025 22:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383074;
	bh=pVqiMffJ+/+3iCw/xeioPbEjfyBueyeofbkgdZ2WABQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TMBqAPzHGUcab+wR+R9Vg1polDI6xrnGmUGYgjNYqeA1W+/VoDgpDiY+mEkhK7PHq
	 pGF0csZ6Izt3JUt7Y1WTE5jfVZObf9paLmHWKV3d5Z4h8H+cj6Gkd87mXqI6yTkLU1
	 4PUvVm9Px2kcnojCv+jEuPUWMGtezcd6b2GbLByNpn8aG0eYlwoXXl8GIdwslBQAiR
	 38rHxXrJpjkVFM/A/0DtJO8okerR9hvLWQyWI5roB+ZZMoLNiKbnqOXOcBBbyTPfHo
	 6FoQJs5MkJ8AP037qB1I5ZODQulbWDI/CFJhl+bxOukaWDrjdVCBvtX/57OieMIJWj
	 LGAOnCMpKYR0g==
Message-ID: <de2900a9-79cf-49b7-8fa8-f9321f9a21e9@kernel.org>
Date: Wed, 5 Nov 2025 23:51:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drm/nouveau/uvmm: Allow larger pages
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mary Guillemard <mary@mary.zone>,
 Faith Ekstrand <faith.ekstrand@collabora.com>, Lyude Paul
 <lyude@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org
References: <20251031104924.10631-1-mohamedahmedegypt2001@gmail.com>
 <20251031104924.10631-3-mohamedahmedegypt2001@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251031104924.10631-3-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 11:49 AM, Mohamed Ahmed wrote:
> +	/* If we get here then nothing can reconcile the requirements. This should never
> +	 * happen.
> +	 */
> +	WARN_ON(1);

This is called from a userspace path, please use dev_warn_once() instead and
return an error code.


