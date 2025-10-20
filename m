Return-Path: <linux-kernel+bounces-860588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1EBF0770
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA693A413D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA032F5A02;
	Mon, 20 Oct 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3VT5mh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADB191F91;
	Mon, 20 Oct 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955211; cv=none; b=jT/tF4Dhk3GvIn5046TXYICczxkd9YYBRGwRroeKJYjNLCq1DnRL9L3PViC8UBSCkIhmWp0Ms3+supe6NfXkfAsd6osxsyLVpWJrszqpIgBbnIDA6D9YElMAgPvTlKY6qXzPokQr9RkvJZlMrQMVmOspnN/O4GnRpkC3y4DyFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955211; c=relaxed/simple;
	bh=MfxJouz/1s/HQ9XACEExFeHjaUCFWc22PevzBiJAZKg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=U/GgppkUfSHlaE7ke90nRXEG7Uw/OCiv8/AyXtElxEgqTfpuFJ5OStvTjgUkNj9pFcbAuVT7MYBMhnkt8Q07VItCpwQsF6n6zL5EeUBYKJ0iq7T3VUHxEE9tuGVCrPWs3xoS/J3Phfkx1yNNM+Z/a5Ls+pUUVANYav086VjIYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3VT5mh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E64C113D0;
	Mon, 20 Oct 2025 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760955211;
	bh=MfxJouz/1s/HQ9XACEExFeHjaUCFWc22PevzBiJAZKg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=A3VT5mh1lThYKr2EZVY1Llk/2Tn090PKGz1/IKdZ3R9zR65yFw0aGoklyyv/AyHIA
	 iHir/QFTDnPdkSJvlneLGBUKFl+WTcZnDFFlxnw71lF6mJl8Id6qWIFzhKfDPAkSMl
	 Vo/WcCP4QMarxCJ0GQJOm2BvLD07DGiBCPYPdELwFMt2TUOT9d9vg69x7d9E/w3ZXg
	 x4Elv5zrnMvV9c3b54aC7BZ4Jml/XolDUPw2kbzdJ51YMtcGeaP1y9LFNzmy++Tbd/
	 nHByJuifTUWv7WPBuUKFa/EjEr/8l+wj8biLKLW7uyb0U3MGf7kpSF05JPZ2u/+Az8
	 6sPL8+DqrqlWw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 12:13:25 +0200
Message-Id: <DDN2ITDOVCEV.50CEULQSFLVO@kernel.org>
Subject: Re: [PATCH v5 03/14] gpu: nova-core: gsp: Create wpr metadata
Cc: "Alistair Popple" <apopple@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251013062041.1639529-1-apopple@nvidia.com>
 <20251013062041.1639529-4-apopple@nvidia.com>
 <DDJJ4ECCSE2I.1EUAJRU9JBGNI@nvidia.com>
 <zwaefk62to77b5nyakeiboyj53fge3lysc3z7arp54tyyherdo@nsqhuig7bmbc>
 <DDK4KADWJHMG.1FUPL3SDR26XF@kernel.org>
 <DDMWPMS0U5PK.3IW61GCOI3GZB@nvidia.com>
In-Reply-To: <DDMWPMS0U5PK.3IW61GCOI3GZB@nvidia.com>

On Mon Oct 20, 2025 at 7:40 AM CEST, Alexandre Courbot wrote:
> The alternative would be to have const functions like `usize_to_u64`. It
> doesn't look as smooth as the extention trait, but can be used in const
> contexts.

That's what I thought of, exactly for the reason of being usable in const
contexts (at least for a quick fix in nova-core).

Whether we want an extention trait and a separate temporary const_usize_to_=
u64()
etc. can be discussed in the context of making it common infrastructure.

