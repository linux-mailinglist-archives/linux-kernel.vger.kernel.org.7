Return-Path: <linux-kernel+bounces-789777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38AB39A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEBF3AD721
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF6D30BBB9;
	Thu, 28 Aug 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBQ20whM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43919DF58;
	Thu, 28 Aug 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377769; cv=none; b=ZCcwcvwuYhFerfzhkzor6FP1KGl2FeeZYn9FgUAz0c+WAaAK/4VWBdhcEZ7jDBn5nqmhvWixEAUAmtKDTZXzwgMT7TuxMygD3xlTOIQKkLqAgGg6d3UHAuLn3I9YauQTf2EE6DFb3cPoMbV7xZ4v2b247/m8CwJTKWRmEkQZpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377769; c=relaxed/simple;
	bh=ypxh1ppNtcbAwO5q5dht/FXyUWQup2iODRBHMyFnsuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfwLDixdWTW869/bnkwKm8VcM3jPvsxVjV/1r8joQKj0RMKmm1cpOAeICqONcK5FY/PXi8XFkxnvOIYg1HtsiC0owEcAYCzkav/tX5FLj9RViHUgh74pTey+Ygk2PRTZNrspULJeglkuXzvtWcvbBbWWtQFBIflCXiCMZ8T9z7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBQ20whM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C3AC4CEEB;
	Thu, 28 Aug 2025 10:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756377768;
	bh=ypxh1ppNtcbAwO5q5dht/FXyUWQup2iODRBHMyFnsuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pBQ20whM5pgyxCfxv7buCvl7QI+5Bl+QJZKLx5VW7m9hrqs/hGicgawAEvLDFRFXR
	 2QDYiLzeYdcgx4Hl+QWtpLaHiN0GbRxcKZW1+asbca55p+EfcJhHONly/GvpJ91x44
	 AHx2+kKUp+6R/sQOuO5evCtMlkj7RShI0TmLToz5ShRjsjCF7Dz0wa5ezmr6Kj/Qc5
	 VeFYW2NFj/5IZJJwtIeIAC0WGiANCKzT+NzrmweEHyVHbPCmZX5jvEYWOGIIMveXrl
	 GkoqVdjPPsRROrUqkivc92g5pHwTWnrrtuQ/+Q8H9XUYRqgm+al18HKfQ0e798mSWx
	 51fw3Z8fW0Ndw==
Message-ID: <3fabc3b4-a592-419e-a3f1-b13c40f3644e@kernel.org>
Date: Thu, 28 Aug 2025 12:42:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add mutex to drm_gem_object.gpuva list
To: Alice Ryhl <aliceryhl@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250827-gpuva-mutex-in-gem-v3-0-bd89f5a82c0d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 3:38 PM, Alice Ryhl wrote:
> Alice Ryhl (3):

Applied to drm-misc-next, thanks!

>        drm_gem: add mutex to drm_gem_object.gpuva
>        panthor: use drm_gem_object.gpuva.lock instead of gpuva_list_lock
>        gpuvm: remove gem.gpuva.lock_dep_map

     [ Use lockdep_is_held() instead of lock_is_held(). - Danilo ]


