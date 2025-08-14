Return-Path: <linux-kernel+bounces-769156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662DBB26AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8323E682ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8ED221FDC;
	Thu, 14 Aug 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAe1z4KE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE63321423;
	Thu, 14 Aug 2025 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184700; cv=none; b=d4NqlR8xm/gAQNJlWtONHcbOYsDEzzI+tV0Xze90+Pva0xkgeVZMC6SCT6cf7TBMX3fF18Gp/njpGzzRshkrfGWQ3mUHqp191ixVF5gVyHXQ7cWQsX7ReiqY1h8Aeq1G2tyzcWPSdL9EcBlPrNgyGaQUmvGhMpKUcHvxpBVyQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184700; c=relaxed/simple;
	bh=4p74E7bNCFHspyPHVUwYdRfNg1qoS7STRMQynF0Lho0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XTl9xe97ZEgiD0Ei1CO1+nrUhOBrPat6e7jETm9OcqK0YjpjcMov2xcqnIgHiKQXsZxHy2ZFHKHw2NlAvySdp1Pk77OGiNqNaUhp4OpZUO8RO5Yp7oB1oEl2WRURN9jTPsoixLUUbSE+ft1IQZ/vCuFeOYaBCFXZOG4I18MUUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAe1z4KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD719C4CEED;
	Thu, 14 Aug 2025 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184700;
	bh=4p74E7bNCFHspyPHVUwYdRfNg1qoS7STRMQynF0Lho0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IAe1z4KEpVoRwonxyQu3SDapDiUfj+I7Y3wzNpOUQtCnn7AcFZxUHBsy6g4xDKwRD
	 DmX3DDIP+F0Y2/QVNt7aBy6vE2Wt8hWaSKi0EJawm5txPLIk/UaYaQ+DJazN1L2vf0
	 WjV5hQYyhDWB65jj26THxzCzRYpDszyzgK9I4ocTTTGW+0fZ2G7u0bCF7Q9Vx24/L4
	 fXYb7n1exYqiC8EDVcJqW25Kmy0RA5oZxdzi9ux8pp7mjyhjumr9dzYH4NXmoCgwNP
	 eJ9GJ0Ven8n7uvz0Mra8TV5YzwRaCSz5RrZL6WY4QKm5+cj0mFQgXwsirW3h2MVnCm
	 YN7wcxsljF1vg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 17:18:14 +0200
Message-Id: <DC291P4PSHFC.OEKNWCGDFOJN@kernel.org>
Subject: Re: [PATCH 1/2] drm_gem: add mutex to drm_gem_object.gpuva
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Steven Price" <steven.price@arm.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Rob Herring" <robh@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250814-gpuva-mutex-in-gem-v1-0-e202cbfe6d77@google.com>
 <20250814-gpuva-mutex-in-gem-v1-1-e202cbfe6d77@google.com>
 <DC28NIMIPF5I.2P17OZFA06GXL@kernel.org>
 <CAH5fLgiYqQA-jcz=S_u8EjHkpr65m6nU9DHRkRWs3js8v3Uadg@mail.gmail.com>
In-Reply-To: <CAH5fLgiYqQA-jcz=S_u8EjHkpr65m6nU9DHRkRWs3js8v3Uadg@mail.gmail.com>

On Thu Aug 14, 2025 at 5:01 PM CEST, Alice Ryhl wrote:
> I had wanted to move it below free(), but we can't do that since
> free() also performs the kfree() call.

Actually, I think it belongs in drm_gem_private_object_fini(), where also c=
all
dma_resv_fini() for the GEM owned dma-resv lock.

Any cleanup should be done from where a driver calls drm_gem_object_release=
().

