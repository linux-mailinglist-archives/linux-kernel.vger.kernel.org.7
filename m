Return-Path: <linux-kernel+bounces-845057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E6BC3628
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 07:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 107274E42A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDDF2E9EAC;
	Wed,  8 Oct 2025 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Oi7k3OwQ"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F831FECAB;
	Wed,  8 Oct 2025 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759901645; cv=none; b=K/DlouPWmFD91pedVCIfVxns5HyNAsrlJDVb1cNGsJhl7X0XBtLL7OwqK1Ne8GLrDHpaEqNkP+ttcLINRb5RUtMTX5jeADDuwJSMO5VWcS9+nsjd2TRgX3MR9Uko7oBhD9odUuA8I/3ELoiFyXskXZU6FSe5HupP+QC9P8wPYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759901645; c=relaxed/simple;
	bh=HTVYCQyDMrBag0JqlevpI1fMUY4FDOO8k6AmG5PTpJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7Kkg22n5UPY2PpDkzE7KxzN1f+6oFqS0jZBAgBDUMhA0HMU+F7escv22Rv6SSe24usKMCrG5mJj2LzzrAfa0pgPZRng7gH2+DZRlXARBHPejsa44mKivAxIKp5yNGKxXNNVNNv4d+JtT2Jhpm6x0g064xmppqCDy9kbmpR0f+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Oi7k3OwQ; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:63d4:0:640:7fb:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 9658A81DEE;
	Wed, 08 Oct 2025 08:26:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pQeM59JLtKo0-ggYUaLP8;
	Wed, 08 Oct 2025 08:26:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759901217;
	bh=GRs7GB4aRJ8yeDgtBXvZS/vdrRPxkhyCtpTVwFyur+0=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Oi7k3OwQcSYkDUFtwNNKIHVWUixUGHLsehdVlt0Sv+AguDGOBwjWONqv9GTFs3cey
	 jcc6ecoRlyyfj91BU5FwZ6SXNH//RFKI3RFkTbR2tUrnsjkNp5qcEzrtQLfsozagOL
	 sXsudjNPnJWhcz6IEAiacq+wuGPV1VIMO0TV4Xus=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 8 Oct 2025 08:26:49 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, linux-kernel@vger.kernel.org,
 acourbot@nvidia.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 corbet@lwn.net, lyude@redhat.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: xarray: abstract `xa_alloc_cyclic`
Message-ID: <20251008082649.1f9cacd0@nimda.home>
In-Reply-To: <CANiq72m8t2j3+XoELfYFG9ivymueOGdwpZnFhRVZ8f3Xw9ygiA@mail.gmail.com>
References: <20251006163024.18473-1-work@onurozkan.dev>
	<20251006163024.18473-3-work@onurozkan.dev>
	<aOTx-Oj_VN6fVV_s@google.com>
	<20251007152724.2b33a899@nimda.home>
	<CANiq72m8t2j3+XoELfYFG9ivymueOGdwpZnFhRVZ8f3Xw9ygiA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 19:28:31 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Tue, Oct 7, 2025 at 7:19=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
> >
> > Why do we not like to use the bindings type directly?
>=20
> For public APIs, we generally try to avoid exposing C types:
>=20
>     https://docs.kernel.org/rust/general-information.html#abstractions-vs=
-bindings
>=20
> Sometimes it still makes sense, of course, e.g. a method may return
> an inner type so that it gets used by other abstractions to call into
> C. But generally we want to avoid exposing those for drivers and other
> abstractions wherever possible.
>=20
> Cheers,
> Miguel

Thank you for explaining it, I will drop the bindings type in the next
version.

Regards,
Onur

