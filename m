Return-Path: <linux-kernel+bounces-781741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803C5B31620
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7E76217FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084F2E3B05;
	Fri, 22 Aug 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h03m3uah"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2620330;
	Fri, 22 Aug 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860983; cv=none; b=rpLZWysPtjCvDzpkxPKXMv6BaPWyaJIm4VsE3BMmInyOocMAm3fBRaPNZ6I5MGvGt8QlomwZpNpnUvfuAm8v+9KZ3cZbc+iZog6K+3/2qhhpGyYR7csVoKI2IURQpLNMQnW3wfDcvrekHwG4+3EplVCXS/bCCejknjG8+hkq1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860983; c=relaxed/simple;
	bh=/ioH/M3LDzYpNRt8BKiYOZNGO079fVuLd2eOZHrZ6fM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iu9qUVOFRLCj29mnPHskzY3tjIiAtEtsqD8Ra2uCIcI2re+mc7biNI4/w2NpZp2HT50Zg9xjBxuPByILph9UrZ5WarSXJl6JfiSn/uybcLawl+/TJbSBbxslLCmSem6i0g9YQn6lnKW/LNZrRo9nCi7G2gyVSnoFdo8VEcIfEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h03m3uah; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755860980;
	bh=/ioH/M3LDzYpNRt8BKiYOZNGO079fVuLd2eOZHrZ6fM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h03m3uah3VnzQJtdD5OKKtM9gkO3j0+7d5zNOStpGKJW6Px20P8cahvl12s1YgPew
	 2F5EfFJ0T+fmfQNmQxp/1ggZtN7pM/ctnXsfH/yD3k6YvhBdyICPQqI1Vy0Sd+9xlv
	 YT81dDGsvvNaD7PfueyqmqnkYzU+RpNQrmwmKoKIjmsXF922AlUMEc6oH7hDgOXhoH
	 qh2uW/HMdoHhSw3+p5SZpWIZeAJCo0pCEt0+/fft0xUoTq+rBaBT/4aBiDd50sxKEA
	 t3G95PRWjm12Hhy7bNbC81iRUphv41b7EmfOyBgQ5lyFaX6+YexBxml6C6UbNRMRTA
	 02F86oRzp+Xnw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2F2BC17E0DE3;
	Fri, 22 Aug 2025 13:09:39 +0200 (CEST)
Date: Fri, 22 Aug 2025 13:09:33 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Steven
 Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm_gem: add mutex to drm_gem_object.gpuva
Message-ID: <20250822130933.50bf1746@fedora>
In-Reply-To: <aKhNFn7hdsLapLWO@google.com>
References: <20250822-gpuva-mutex-in-gem-v2-0-c41a10d1d3b9@google.com>
	<20250822-gpuva-mutex-in-gem-v2-1-c41a10d1d3b9@google.com>
	<20250822115221.24fffc2c@fedora>
	<aKhNFn7hdsLapLWO@google.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 10:57:26 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Fri, Aug 22, 2025 at 11:52:21AM +0200, Boris Brezillon wrote:
> > On Fri, 22 Aug 2025 09:28:24 +0000
> > 
> > Maybe it's time we start moving some bits of the gpuva field docs next
> > to the fields they describe:
> > 
> > 	/**
> > 	 * @gpuva: Fields used by GPUVM to manage mappings pointing to this GEM object.
> > 	 */
> > 	struct {
> > 		/**
> > 		 * @gpuva.list: list of GPU VAs attached to this GEM object.
> > 		 *
> > 		 * Drivers should lock list accesses with the GEMs &dma_resv lock
> > 		 * (&drm_gem_object.resv) or &drm_gem_object.gpuva.lock if the
> > 		 * list is being updated in places where the resv lock can't be
> > 		 * acquired (fence signalling path).
> > 		 */
> > 		struct list_head list;  
> 
> This isn't a new issue, but it's somewhat confusing to call it a list of
> VAs when it's a list of vm_bos.

Yep, that's true.

> 
> > 		/**
> > 		 * @gpuva.lock: lock protecting access to &drm_gem_object.gpuva.list
> > 		 * when the resv lock can't be used.
> > 		 *
> > 		 * Should only be used when the VM is being modified in a fence
> > 		 * signalling path, otherwise you should use &drm_gem_object.resv to
> > 		 * protect accesses to &drm_gem_object.gpuva.list.
> > 		 */
> > 		struct mutex lock;
> > 
> > 		...
> > 	};
> >   
> 
> Alice


