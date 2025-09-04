Return-Path: <linux-kernel+bounces-800592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF91B439A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E0C3A2024
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D672FC00A;
	Thu,  4 Sep 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djUTHghf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D09EACE;
	Thu,  4 Sep 2025 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984190; cv=none; b=J1rAEP1wm1VU612YUnAvXsu6sk1U49qW+p1/s+wzUeHy2c6Er1vyPQqxc9b0+Oekk4NsDc1UQfn43bgXsiK3crVPVBldzxpJ3C/Ntbtn9ufYXXIQmTasnCaHEKJ1WY6zxLkJN5qM4OIpGluuA/MwrAeUJQDMzAr39246Vc7qgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984190; c=relaxed/simple;
	bh=Pl/Kp/dhWz0ALytYZvDvqWTH7WBjJIXrEp8tIpxw7uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2JeLPRrpPvktk8vUVTRJNGH27Jm1UP/HZj4ySQMkLs+iWBRN0NwarkzKz2fIraBEbRZd71YR/eLu19pnomyv6m4g90GdkfrITzIn7kt7U8wWgABXbTQXQdhVD97VgE2GM/wKm1I4xRJ2dAumTdpY/BnxEbu4rG9kc2uVuG36R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djUTHghf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D192C4CEF1;
	Thu,  4 Sep 2025 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756984189;
	bh=Pl/Kp/dhWz0ALytYZvDvqWTH7WBjJIXrEp8tIpxw7uM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=djUTHghf3oqzR/Ce68eVIUgFzhA6jz6CPfIf7PRxk1kk7/m0gJ81wJTg3tdpIKecb
	 DsoU9rChwTvFGNNy+RYjDm5moxcQE/ObSqheEgoie1Kn09a1oZ0hRo0XZZ5VW9SeAw
	 Zby6Bg0phR46hP+IAs46CTK4316pwDQY0sYJa0V8Nms7xvQ8qJo6mJwZjO+eEOiDjF
	 kNYVk9fqpHRDvrYLB3up34RlXxP0Vt5oLuM2FfbHlrjU794IuR+otX9Bx/64dZcLPp
	 qLtHMfP3biMqkrhLpRJaqgtq4JDWq6NC1B/ZDetC3gidTpYy4ybWMmPEJZaHNuF1c1
	 Oyjf6Y2rQNwqg==
Message-ID: <08632fbd-1984-44ff-a6e1-bd9e39bbea97@kernel.org>
Date: Thu, 4 Sep 2025 13:09:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
To: Alice Ryhl <aliceryhl@google.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, acourbot@nvidia.com,
 daniel.almeida@collabora.com, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>
References: <20250901202850.208116-1-dakr@kernel.org>
 <aLlsmNzp_KardLUt@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aLlsmNzp_KardLUt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(Cc: Jani)

On 9/4/25 12:40 PM, Alice Ryhl wrote:
> On Mon, Sep 01, 2025 at 10:26:39PM +0200, Danilo Krummrich wrote:
>> +DRM DRIVERS AND COMMON INFRASTRUCTURE [RUST]
>> +M:	Danilo Krummrich <dakr@kernel.org>
>> +M:	Alice Ryhl <aliceryhl@google.com>
>> +S:	Supported
>> +W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-rust.html
> 
> It looks like the right path is:
> https://drm.pages.freedesktop.org/maintainer-tools/repositories/drm-rust.html

Heh, seems like there's an explicit redirect for drm-misc:

https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html

I think we should get the same redirect, so the links in MAINTAINERS are
consistent with each other.

