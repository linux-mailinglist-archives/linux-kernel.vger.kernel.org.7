Return-Path: <linux-kernel+bounces-805623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C135BB48B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F0017B920
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09E2FB08D;
	Mon,  8 Sep 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQrPBfUD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D822422D;
	Mon,  8 Sep 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329897; cv=none; b=YfzSB/XkBrcd+cnuOJKhrwukMbpxbjjwyrp/HhsGmSTC/K7bDygA26rQ4FNmna0emX+l+dvSYrRuO2rRVFJjIjqiW080z+auGVCzcfQmrC00eSNmvH2Q9t89ESf4/NtPqIpRJ+KO1+9A9smAFY5HhOReHE7Wvw2arQhTWD+Mhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329897; c=relaxed/simple;
	bh=Gf3bKLVGBIqbxULlO+jSRJmsI6c3oODRH0Ft0N6BqUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=WFVq07G9y6fNqW9kjP8D7rAKx/UkSGh5owPVyIr3dfevvKnlUyOS4PnytcI1gNqTXErrhV/of2ba/XtC5ODfErlTbG/JEUQUDBC/l24P+1jdqX2QEpmw7l9dBaLqqt64/9Kz6ktCrtg9SgZ34BlOicggUPk/AwJXPqHWqfob5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQrPBfUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A381CC4CEF9;
	Mon,  8 Sep 2025 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757329896;
	bh=Gf3bKLVGBIqbxULlO+jSRJmsI6c3oODRH0Ft0N6BqUk=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=TQrPBfUDMaZ8w+ALMfFLKSvgLIRPLaLK+W+CWaalH/wWCWUoPzFjZ0G2iLGamw9OJ
	 sv/zKxaR4+T5jJ7SlDF0D02rm1kLWcdlVtlN+UecUnq8RnmqniP1DiQHi/epJbcvvh
	 Acy8thCDU9Y3ngaMXb2C3Zrzki91T9VsEu/fW0dCjk8ttFHBLP4wOVAOlJevIuer1a
	 wnl5aRQezmoltG6R5YsniEjt7uN38e74A18aOSfBjpfifVPK/lFqkqaEsQdNZC2Gtm
	 ua/od/aQ0Apavh28JTCwMemQtBmhlN7drI+ol2HVKQJTuDplWF3v87MuF6DkG1PehD
	 MZIT9elzG9kpQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 13:11:32 +0200
Message-Id: <DCNDGFE7RR5Q.X3PCDW0KIX89@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Matthew Brost"
 <matthew.brost@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Steven Price"
 <steven.price@arm.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Boris Brezillon" <boris.brezillon@collabora.com>
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com>
 <20250905152505.005a610d@fedora>
 <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com>
 <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org> <aL1pSFB9iBsfHFM_@google.com>
 <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org> <aL1u_YxOkuj1kIq6@google.com>
 <20250908091140.44856fde@fedora> <aL6TJYRmWIkQXujj@google.com>
 <DCNAE3CJMEJ0.JH1F0MJABXQI@kernel.org> <20250908122002.2c80dd3a@fedora>
In-Reply-To: <20250908122002.2c80dd3a@fedora>

On Mon Sep 8, 2025 at 12:20 PM CEST, Boris Brezillon wrote:
> I'm not following. Yes there's going to be a
> drm_gpuva_unlink_defer_put() that skips the
>
>         va->vm_bo =3D NULL;
>         drm_gpuvm_bo_put(vm_bo);
>
> and adds the gpuva to a list for deferred destruction. But I'm not
> seeing where the leak is. Once the gpuva has been put in this list,
> there should be no existing component referring to this object, and it's
> going to be destroyed or recycled, but not re-used as-is.

I'm saying exactly what you say: "has to be a special unlink function" ->
drm_gpuva_unlink_defer_put(). :)

>> Yeah, we really want to avoid that.
>
> I think I agree that we want to avoid it, but I'm not too sure about
> the solution that involves playing with vm_bo::kref. I'm particularly
> worried by the fact drivers can iterate the evict/extobj lists
> directly, and can thus see objects scheduled for destruction. I know
> there's a gpuvm_bo_is_dead() helper, and drivers should be aware of the
> risks, but I don't feel comfortable about this.

No, drivers can't iterate the evict/extobj lists directly; or at least this=
 is
not intended by GPUVM's API and if drivers do so, this is considered peekin=
g
into GPUVM internals, so drivers are on their own anyways.

Iterators, such as for_each_vm_bo_in_list() are not exposed to drivers.

> And since we've mentioned the possibility of having to support
> gpuva destruction deferral too, I'm wondering it wouldn't be cleaner
> to just go for this approach from the start (gpuva owns a ref to a
> vm_bo, which gets released when the gpuva object is released).

