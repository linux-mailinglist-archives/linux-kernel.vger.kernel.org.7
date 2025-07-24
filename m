Return-Path: <linux-kernel+bounces-744304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B8B10AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4160A1895F27
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2D2D46DF;
	Thu, 24 Jul 2025 12:52:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFA02D46C9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361533; cv=none; b=hrH4wqTUgmP+qW0Rf0ZKM0XHpq+ngKZQVC9iS3sMQIcLeHpqu0O6mFlAUMfmCAJwiKD7oNMXsC5tFwG0/lndmfQOTZbbJjhj6YuEexFpkHtbsbrphYUNJAf0QZ+Os3Ob57rgyN+X2PkzJu49skykzU94Y/vWAkIRyocvZZQjGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361533; c=relaxed/simple;
	bh=DJu7mcsbC7uhEJ9gZqdxamOAr/+0XgNWxo/b11zufhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SJ5bLwkBXAWkizWj84CX5XWPbk9rc8OetI/oHfXnfnqHpQstJqpTrkv5ZTYikvYIvJaKHbf+eLm/uWfqNczSzaUw4tQD9ekIGDJbQgAUX9PkEWc9XxrK8laLiRvPc0zes4dFVmpqxcuOebxltFaecoqiSW8gSUAMTocY/spk92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D193C1A00;
	Thu, 24 Jul 2025 05:52:04 -0700 (PDT)
Received: from [10.1.33.48] (e122027.cambridge.arm.com [10.1.33.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29D5C3F6A8;
	Thu, 24 Jul 2025 05:52:08 -0700 (PDT)
Message-ID: <78ec8bcc-0178-4c5d-9d03-0b534bdd2231@arm.com>
Date: Thu, 24 Jul 2025 13:52:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] panthor: print task pid and comm on gpu errors
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250718063816.1452123-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250718063816.1452123-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2025 07:38, Chia-I Wu wrote:
> This series saves task pid and comm in panthor_group and prints task pid and
> comm on gpu errors.
> 
> v3: fix new kerneldoc warnings
> v2: save the task info in panthor_group on panthor_group_create, rather than
>     in panthor_file on panthor_open, because, when the two differ, we are more
>     interested in the task that created the group.
> 
> Chia-I Wu (3):
>   panthor: set owner field for driver fops
>   panthor: save task pid and comm in panthor_group
>   panthor: dump task pid and comm on gpu errors
> 
>  drivers/gpu/drm/panthor/panthor_drv.c   | 14 ++------
>  drivers/gpu/drm/panthor/panthor_sched.c | 43 ++++++++++++++++++++++---
>  2 files changed, 41 insertions(+), 16 deletions(-)
> 

Applied to drm-misc-next.

Thanks,
Steve


