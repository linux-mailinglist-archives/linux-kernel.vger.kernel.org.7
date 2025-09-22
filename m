Return-Path: <linux-kernel+bounces-827349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2189CB91833
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB36166BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E730F52C;
	Mon, 22 Sep 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0gkXo+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C530EF6F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549015; cv=none; b=IZIvomT1ErYgkBv98pGB7Q+HhL3dBwNTV7dfNBcKh8/k3CDeDd7OrqUoSbws1o5CQluvy+E9UyrK2vMve4YPkZbhK2oOd9e35iJ+YEr9J0d2ETrYtK5jZV0BahPwZUTGCj7t0OyhO3lxQtKtncroISRVsf9zlGTak0Vx9ibvovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549015; c=relaxed/simple;
	bh=KUdvoa11waaL9VuET18T94f4qWSxyLfuRY+uFrUSlbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eRopxM8lcwUlDN5VJnDkmvJVtLCrv55QX5eHQmQ4FcVJt8Lf4750c5GWrc39Vz6g9rDfZZBhLOCMrtBk/AT06FI4UsRKo32JcYc25nEXdNIPassCTyye0AswCQr5VxnKzSs6c3Fph3/3TPnjf8kwSp0NrCm5jDL/85ae29gdasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0gkXo+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F0AC4CEF0;
	Mon, 22 Sep 2025 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758549015;
	bh=KUdvoa11waaL9VuET18T94f4qWSxyLfuRY+uFrUSlbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a0gkXo+7nkOQjnfZoRnPryocuqfZjQyryU+hLaAMYZUqw6iC1azA7St+vnNuoVRTh
	 nNkh68Ro9p2RrHDyKGqPnT73vcBHi+RqgC+3AKVPNaQve8wgwDMUFVQP6i0bkwuyR7
	 N9dWi040fV2IjhU7VJw2lW7933JwoNscuXyevLoGxbgWMi5OaBVieTstCKHqaj9Cji
	 kL84/+J0ryNnwsfKSYoFZqW3DYPyLLWM2S8UY8W4aVKacDIN3c9zwcAHElgdPNmfHw
	 IDWLQQcOEjB88Apb8ReEL/jIX60v8tlUChs4T64rSXK5TqNuYDwtTgXtkZgA2arBtb
	 jYvB4xyJi6a6A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] kho: replace kho_preserve_phys() with
 kho_preserve_pages()
In-Reply-To: <20250921054458.4043761-3-rppt@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-3-rppt@kernel.org>
Date: Mon, 22 Sep 2025 15:50:12 +0200
Message-ID: <mafs0y0q6fvfv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Sep 21 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> to make it clear that KHO operates on pages rather than on a random
> physical address.
>
> The kho_preserve_pages() will be also used in upcoming support for
> vmalloc preservation.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

