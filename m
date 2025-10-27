Return-Path: <linux-kernel+bounces-871581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250D7C0DAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA623AF98A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F922AE65;
	Mon, 27 Oct 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QrJ6dEk8"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC72288D5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569150; cv=none; b=I2CMWcE/GN1FQhVk/8eW5e5xE+RZqLV8yhH5jtbgd+WGX8Edkr+IqoqG3/v2M06gbjzNA1P0YoBDcH56Etp+NiOl8zt5NN8FunS2T67yvQvO4/93yFEY0RL5O0FSWy7NV3XlAJbZOhfCiW13an1WNcX0dyhLo41iR5b5mvU1hUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569150; c=relaxed/simple;
	bh=h4B4zPEil9gsqoH2GDWgXR21CguczGzEIgJBNGdRdO4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f384uyDZiYEOyIvQGH6We6qmHu3nywlH/NvwwfspCqRNOWM3T82IVyuAVA9VP5XJyhWGYah5xb8O1mWxF3IXUHrY7GVQ4lBo09piADzivwpPLSEqaP9moROq6ofbiiVy443DS2AcP4N6+jBQbdOUbcTfjTAOihItVonqfmS51OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QrJ6dEk8; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwCsZ5Yy0z9tPJ;
	Mon, 27 Oct 2025 13:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761569138; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9/5/O/PnrRErtA64sqZiP8P5kegkr2ZMB9bruDNLPg=;
	b=QrJ6dEk8PteROh999ANb9OgInroyRXoqQ35/kM0p64fvX3PRxJB/+bRHUT6EwJ6My44QAF
	zilj5zHqNBNbZqSz1yJpYzrbINBLi1KGpL3W2OX33NGKQZ5Yc26y16j+yOr+d56uUCm4aQ
	rGiik7/IRYzXZ4YBt6YhpThcuwcJ2FN3mnQVuLGjPY8sviycuQBUgEjrkBAR/5Cel9Qtlg
	wyn9y9i9omguIlTJ+UkU14eyiF8D6+52CiXj9Kf5Z4DzAdVrDBc8EbO2/HT8Jl/y5/OjvJ
	+4CyT9Y2xH+ZifqVOF88SyweUBRslibFNFIptf6WSbL8anr8X36SuGit0tBwyA==
Message-ID: <e8d18b60162e3d83ee58dc9df642d8a46f6eda08.camel@mailbox.org>
Subject: Re: [PATCH] MAINTAINERS: Maintain spsc_queue through drm_sched
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 13:45:36 +0100
In-Reply-To: <aPtm5UD4tfVBJzSh@phenom.ffwll.local>
References: <20251024081459.164634-2-phasta@kernel.org>
	 <aPtm5UD4tfVBJzSh@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: b6e7f0e381d9064061c
X-MBO-RS-META: 7xrf55ennrui3ztncdj6hio4ouaq44a8

On Fri, 2025-10-24 at 13:45 +0200, Simona Vetter wrote:
> On Fri, Oct 24, 2025 at 10:15:00AM +0200, Philipp Stanner wrote:
> > Back in the day a specialized lockless queue was designed solely for th=
e
> > DRM GPU Scheduler: spsc_queue. This queue's only user is drm_sched, and
> > there is no dedicated maintainer entry for the queue.
> >=20
> > Add the spsc_queue header to the DRM GPU Scheduler MAINTAINERS' section=
.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

Applied to drm-misc-next

Thx.
P.

>=20
> > ---
> > =C2=A0MAINTAINERS | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5889df9de210..efafe2b3517c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8580,6 +8580,7 @@ S:	Supported
> > =C2=A0T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> > =C2=A0F:	drivers/gpu/drm/scheduler/
> > =C2=A0F:	include/drm/gpu_scheduler.h
> > +F:	include/drm/spsc_queue.h
> > =C2=A0
> > =C2=A0DRM GPUVM
> > =C2=A0M:	Danilo Krummrich <dakr@kernel.org>
> > --=20
> > 2.49.0
> >=20
>=20


